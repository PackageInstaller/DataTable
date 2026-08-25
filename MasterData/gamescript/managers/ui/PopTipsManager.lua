local UnityEngine = CS.UnityEngine
local NOT_SHOW_REWARD_ITEMS = DT.GetOriginalConstant("ItemGainSilence")
local BP_EXP_ITEM_TID = DT.GetConstant("BPExpItemTid")
local PopTipsManager, Super = System.NewClass("PopTipsManager", Manager, IUpdater)

function PopTipsManager:ctor()
  Super.ctor(self)
  self.tipsInfoTable = {}
  self.gainTipsItemList = {}
  self.sidePos = {
    [1] = false,
    [2] = false,
    [3] = false
  }
  self.lastSidePos = 0
  self.weaponLock = {}
  self:InitTutorialTipsCache()
  self.cachedRewardList = {}
  self._cachedRewardTitle = nil
  self._cachedRewardSubTitle = nil
end

function PopTipsManager:Awake(binder)
  Super.Awake(self)
  self.tipRoot = UnityEngine.GameObject.Find("UIRoot/SafeArea/TipPopRoot")
  self.binder = binder
  self:Init()
  self.binder:BindTimer(5, -1, System.fn(self, self._CheckCachedRewardTimeout))
  self.binder:BindRawTable(function()
    do return end
    return UIPopTipsDataUtils.GetTipsShowQueue, nil
  end, function(_, nowVal, oldVal)
    if nowVal and not oldVal then
      self:PlayTipsAnim()
    end
  end, false)
  self.binder:BindEvent(EventMgr.Instance.AddItemEvent, System.fn(self, self.OnAddItem))
  self.binder:BindEvent(EventMgr.Instance.SummonGainItem, System.fn(self, self.OnGetAwakerItem))
  self.binder:BindEvent(EventMgr.Instance.CheckShowRewardEvent, System.fn(self, self._OnSummonRewardPanelClosed))
  self.binder:BindEvent(EventMgr.Instance.CommonTips, System.fn(self, self.OnCommonTips))
  self.binder:BindEvent(EventMgr.Instance.TempAddGainItemEvent, System.fn(self, self.ShowNewAwakerWeaponReward))
  self.binder:BindEvent(EventMgr.Instance.ShowMarquee, System.fn(self, self._ShowMarquee))
end

local function GetPlatformStr(data)
  if data and data.content and data.content.showStr then
    return data.content.showStr
  end
  if data and data.test and data.test.TEST then
    return data.test.TEST
  end
  return nil
end

function PopTipsManager:_ShowMarquee(msgs)
  Logger.Info("跑马灯信息", table.tostring(msgs))
  local data = msgs[1] and msgs[1].content.data or nil
  local timeliness = msgs[1] and msgs[1].content.timeliness or nil
  local endTs = timeliness and timeliness.end_ts or nil
  local showStr = GetPlatformStr(data)
  if showStr then
    UIManager.Instance:Reopen(Urls.MarqueePanel, showStr)
    self.timer = self.binder:BindTimer(DT.GetConstant("RotationTimeInterval"), -1, function()
      if not endTs or TimeUtils.GetServerTime() > endTs then
        self.binder:StopTimer(self.timer)
        self.timer = nil
      else
        UIManager.Instance:Reopen(Urls.MarqueePanel, showStr)
      end
    end)
  else
    if self.timer then
      self.binder:StopTimer(self.timer)
      self.timer = nil
    end
    UIManager.Instance:CloseByUrl(Urls.MarqueePanel)
  end
end

local function _GetSidePos(lastSidePos)
  local sidePos = lastSidePos + 1
  if 4 == sidePos then
    sidePos = 1
  end
  return sidePos
end

function PopTipsManager:Init()
  self.tipsInfoTable = {
    [UIPopTipsDataUtils.SideMsgType.Default] = {
      resource = "UI.UIPackages.Function_ReliqueCount_TipsResource",
      compUrl = "UI.Public.PopTips.GainTipsItem"
    },
    [UIPopTipsDataUtils.SideMsgType.GainTips] = {
      resource = "UI.UIPackages.Popup_Public_Tip_3Resource",
      compUrl = "UI.Public.PopTips.CommonSideTipsItem"
    }
  }
end

function PopTipsManager:PlayTipsAnim()
  if self.tipsTimer then
    return
  end
  
  local function playAnim()
    if not UIPopTipsDataUtils.GetEnabledShowTips() then
      return
    end
    local listSize = #UIPopTipsDataUtils.GetTipsShowQueue()
    if listSize <= 0 then
      TimerManager.Instance:StopTimer(self.tipsTimer)
      self.tipsTimer = nil
      self.lastSidePos = 0
      return
    end
    local tipsData = UIPopTipsDataUtils.PopTipsShowQueue()
    local count = 0
    while tipsData.hasPop do
      if count > 50 then
        local list = UIPopTipsDataUtils.GetTipsShowQueue()
        Logger.Warn("pop tips error: all tip has pop but still in queue. \n", table.tostring(list))
        break
      end
      count = count + 1
      UIPopTipsDataUtils.RemoveAtOnePop()
      tipsData = UIPopTipsDataUtils.PopTipsShowQueue()
    end
    local tipConfig = DT.TipsType[tipsData.tipTid]
    if not tipConfig then
      Logger.Error("找不到提示id: ", tipsData.tipTid)
      return
    end
    if UIPopTipsDataUtils.NeedWait(tipConfig.Type) then
      return
    end
    if tipConfig.Type == CommonDefine.TipsType.SideMsg then
      local tipsItemInfo = self.tipsInfoTable[UIPopTipsDataUtils.SideMsgType.Default]
      if tipsData.subType then
        tipsItemInfo = self.tipsInfoTable[tipsData.subType]
      end
      local sidePos = _GetSidePos(self.lastSidePos)
      local item = self.binder:BindNewComponent(self.tipRoot, require(tipsItemInfo.compUrl), require(tipsItemInfo.resource), tipsData.data, sidePos)
      self.lastSidePos = sidePos
      if item then
        item:SetPlayCallback(function()
          if item and item.binder then
            item.binder:teardown()
          end
        end)
        item:PlayAnim()
        UIPopTipsDataUtils.SetTipHasPop(tipsData, true)
      end
    else
      local title = tipsData.data.title
      local desc = tipsData.data.desc
      Alert.Show(tipsData.tipTid, tipsData.cancelFunc, tipsData.confirmFunc, title, desc)
      UIPopTipsDataUtils.SetTipHasPop(tipsData, true)
    end
  end
  
  playAnim()
  if #UIPopTipsDataUtils.GetTipsShowQueue() > 0 then
    self.tipsTimer = TimerManager.Instance:CreateTimer(1, -1, function()
      if not UIPopTipsDataUtils.GetEnabledShowTips() then
        return
      end
      UIPopTipsDataUtils.RemoveAtOnePop()
      playAnim()
    end, nil)
  end
end

function PopTipsManager:OnAddItem(itemData, oldNum, reason)
  if "CopiesSettlement" == reason or "GM" ~= reason then
    return
  end
  if SceneMgr.Instance:IsInCopies() then
    return
  end
  local config = ItemDataUtils.GetItemConfig(itemData.tid)
  local desc = config and LT.Text(config.Name) or ""
  desc = string.format("%s + <%s:%d>", desc, "Color6", itemData.num - oldNum)
  UIPopTipsDataUtils.AddToTipsShowQueue(30002, {
    icon = config.Icon,
    desc = desc
  }, nil, nil, UIPopTipsDataUtils.SideMsgType.GainTips)
end

function PopTipsManager:OnCommonTips(tipTid, cancelFunc, confirmFunc, title, desc)
  if not tipTid then
    return
  end
  UIPopTipsDataUtils.AddToTipsShowQueue(tipTid, {title = title, desc = desc}, cancelFunc, confirmFunc)
end

local _ShowTipsFromGainItemType = {
  XGC = {
    title = "ItemGain_String_WorkTitle_CHN"
  },
  RW = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  ChapterAward = {},
  MCP = {},
  GmCommand = {title = ""},
  GM = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  Shop = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  Recharge = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  Techonlogy = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  Mail = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  Questionnaire = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  Recasting = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  PlatformMail = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  GainStageAchievementRw = {
    title = "ItemGain_String_WorkTitle_CHN"
  },
  PlotWorldRet = {
    title = "ItemGain_String_WorkTitle_CHN"
  },
  Home = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  SpecialSkill = {},
  UseItem = {
    title = "ItemGain_String_SpecialItemUse"
  },
  UseChooseItem = {
    title = "ItemGain_String_SpecialItemUse"
  },
  Item = {
    title = "ItemGain_String_SpecialItemUse"
  },
  BattlePass = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  Activity = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  Decompose = {
    title = "ItemGain_String_MainTitle"
  },
  Exchange = {
    title = "ItemGain_String_MainTitle"
  },
  Share = {
    title = "ItemGain_String_ShareTitle"
  },
  AwakerGainLikeReward = {
    title = "ItemGain_AwakerGainLikeReward_CHN"
  },
  MoonCard = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  AssistReward = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  Backtrack = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  AwakerChipChest = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  Common = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  DailyChallengeCut = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  ExpBonus = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  AvgCommunicate = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  Turntable = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  Task = nil,
  AutoDecompose = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  WeaponAutoRefine = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  Lottery = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  GuideNote = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  GuideNoteExtra = {
    title = "ItemGain_String_MainTitle_CHN"
  },
  BattlePassDoubleEx = {
    title = "ItemGain_String_MainTitle_CHN"
  }
}

local function _GetTitles(tp)
  if _ShowTipsFromGainItemType[tp] then
    local title = _ShowTipsFromGainItemType[tp].title or ""
    local subTitle = _ShowTipsFromGainItemType[tp].subTitle or ""
    return title, subTitle
  end
  return "", ""
end

local WeaponAwakerDefaultKey = "FallBack"
local _AwakerGainAnimReasons = {
  [CommonDefine.ItemReason.AwakerInit] = true,
  [CommonDefine.ItemReason.UseChooseItem] = true,
  [CommonDefine.ItemReason.UseItem] = true,
  ChestItem = true
}

local function _IsAwakerGainAnimReason(reason)
  return reason and _AwakerGainAnimReasons[reason]
end

local function _IsAwakerGainItem(tid)
  return ItemDataUtils.GetItemType(tid) == CommonDefine.ItemType.AwakerItem
end

local _ShowWeaponSource = {
  Summon = {showRewardPanel = false},
  Weapon = {showRewardPanel = false},
  FallBack = {showRewardPanel = true, skipBeginAnim = true}
}
local _ShowAwakerSource = {
  Task = {showRewardPanel = true, skipBeginAnim = true},
  Shop = {showRewardPanel = true, skipBeginAnim = true},
  PlotWorldRet = {showRewardPanel = true, skipBeginAnim = true},
  Activity = {showRewardPanel = true, skipBeginAnim = true},
  ChestItem = {showRewardPanel = true, skipBeginAnim = true},
  GM = {showRewardPanel = true, skipBeginAnim = true},
  AwakerInit = {showRewardPanel = true, skipBeginAnim = true},
  UseChooseItem = {showRewardPanel = true, skipBeginAnim = true},
  UseItem = {showRewardPanel = true, skipBeginAnim = true},
  FallBack = {showRewardPanel = false}
}

function PopTipsManager:GetShowAwakerWeaponSource(reason, tid)
  local source
  if not reason or not tid then
    return nil
  end
  local itemType = ItemDataUtils.GetItemType(tid)
  if itemType == CommonDefine.ItemType.Weapon then
    source = _ShowWeaponSource[reason] or _ShowWeaponSource[WeaponAwakerDefaultKey]
  else
    source = _ShowAwakerSource[reason] or _ShowAwakerSource[WeaponAwakerDefaultKey]
  end
  source = source or {showRewardPanel = true, skipBeginAnim = true}
  return source
end

function PopTipsManager:UpdateWeaponLock(tid, value)
  if not tid then
    return
  end
  if DT.Item[tid] == nil then
    return
  end
  local itemType = ItemDataUtils.GetItemType(tid)
  if itemType == CommonDefine.ItemType.Weapon then
    self.weaponLock[tid] = value
  end
end

function PopTipsManager:ShowCommonReward(allDatas)
  if not allDatas then
    return
  end
  allDatas = table.deepclone(allDatas)
  local allReasonMap = {}
  for _, data in pairs(allDatas) do
    if data.reason then
      allReasonMap[data.reason] = true
    end
  end
  local list = {}
  local isPrintedReason = false
  for _, data in pairs(allDatas) do
    if "table" ~= type(data) then
    else
      if not data.uid and data.targetUid then
        data.uid = data.targetUid
      end
      if data.reason == cd.ItemReason.StageMoppingUp then
        return
      end
      if not self:_CheckShowReward(data.tid, data.reason) then
      elseif self:_DisAllowShowItem(data, allDatas, allReasonMap) then
      elseif data.transData then
      else
        if data.targetUid then
          self:_AddRewardToList(list, data)
        elseif data.changedNum > 0 and data.reason and _ShowTipsFromGainItemType[data.reason] and (data.reason ~= CommonDefine.ItemReason.Lottery or ItemDataUtils.GetItemType(data.tid) == CommonDefine.ItemType.Weapon) then
          self:_AddRewardToList(list, data)
        end
        if data.reason and not _ShowTipsFromGainItemType[data.reason] and not _IsAwakerGainAnimReason(data.reason) and not isPrintedReason then
          isPrintedReason = true
          Logger.Warn("通用的奖励弹窗需要在_ShowTipsFromGainItemType中添加标题, 当前reason:" .. data.reason)
        end
      end
    end
  end
  if #list > 0 then
    local reason = list[1].reason
    local title, subTitle = _GetTitles(reason)
    if title and "" ~= title then
      title = LT.Text(title)
    end
    if subTitle and "" ~= subTitle then
      subTitle = LT.Text(subTitle)
    end
    if SummonDataUtils.IsSummonGainShowPanelAtTop() then
      self:AppendCachedRewardList(list)
      self._cachedRewardTitle = title
      self._cachedRewardSubTitle = subTitle
    else
      ItemDataUtils.ShowRewardPanel(title, subTitle, list)
    end
  end
end

function PopTipsManager:_CheckShowReward(tid, reason)
  if table.contains(NOT_SHOW_REWARD_ITEMS, tid) then
    return false
  end
  if tid == BP_EXP_ITEM_TID and "BattlePass" == reason then
    return false
  end
  local itemCfg = DT.Item[tid]
  if reason == cd.ItemReason.Activity and table.contains({
    CommonDefine.CurrencyType.SummerChapter1Ticket
  }, tid) then
    return false
  end
  if itemCfg and itemCfg.Type == CommonDefine.ItemType.AwakerItem and itemCfg.SubType == CommonDefine.ItemSubType.Awaker and reason == cd.ItemReason.Activity then
    return false
  end
  if tid and _IsAwakerGainItem(tid) and _IsAwakerGainAnimReason(reason) then
    return false
  end
  return true
end

function PopTipsManager:_DisAllowShowItem(data, allDatas, allReasonMap)
  local isDisAllow = false
  if data.reason == cd.ItemReason.Summon then
    isDisAllow = true
    local itemCfg = DT.Item[data.tid]
    local itemType = itemCfg and itemCfg.Type
    if table.contains({
      cd.ItemType.TopBarItem,
      cd.ItemType.Material
    }, itemType) then
      isDisAllow = false
    end
  end
  return isDisAllow
end

function PopTipsManager:_AddRewardToList(list, data)
  if not list or not data then
    return
  end
  if not data.extraOrigin or table.next(data.extraOrigin) == nil then
    table.insert(list, data)
  else
    local tmp = {data}
    for awaker, num in pairs(data.extraOrigin) do
      if awaker and num then
        data.changedNum = data.changedNum - num
        if data.changedNum < 0 then
          Logger.Error("[道具同步] 请检查下发数据正确性, 扣去额外奖励后, 改变数量为负:", table.tostring(data))
        end
        local extraData = {
          uid = data.uid,
          tid = data.tid,
          changedNum = num,
          awardType = data.awardType,
          extraOrigin = awaker
        }
        table.insert(tmp, extraData)
      end
    end
    data.extraOrigin = nil
    table.append(list, tmp)
  end
end

function PopTipsManager:TakeOutKeeperSkill(datas)
  local keeperSkills = {}
  for id, obj in pairs(table.clone(datas or {})) do
    if KeeperSkillUtils.IsKeeperSkillItem(obj.tid) then
      table.insert(keeperSkills, obj.tid)
      datas[id] = nil
    end
  end
  if #keeperSkills > 0 then
    EventMgr.Instance.OnNewKeepSkillItem:Dispatch(keeperSkills)
  end
end

function PopTipsManager:TakeOutSkinItem(datas)
  for i = #datas, 1, -1 do
    local reward = datas[i]
    local itemCfg = ItemDataUtils.GetItemConfig(reward.tid)
    if itemCfg.Type == cd.ItemType.SkinItem then
      table.remove(datas, i)
      return {reward}
    end
  end
end

function PopTipsManager:ShowKeeperSkillReward(keeperSkills)
  if not table.next(keeperSkills or {}) then
    return
  end
  local keeperSkillController = KeeperSkillController.Instance
  keeperSkillController:OpenKeeperSkillObtainView(table.remove(keeperSkills, 1), function()
    self:ShowKeeperSkillReward(keeperSkills)
  end)
end

function PopTipsManager:ShowNewAwakerWeaponReward(datas)
  if not datas then
    return
  end
  if self:IsTutorialLockActive() then
    return
  end
  local gainShowList = SummonDataUtils.GetSummonGainShowList()
  local summonData = gainShowList[1]
  if summonData and summonData.haveShow and summonData.reason == CommonDefine.ItemReason.Summon then
    Logger.Warn("已经播放过抽卡动画了")
    return
  end
  if summonData and summonData.reason ~= CommonDefine.ItemReason.Summon then
    SummonDataUtils.SetSummonGainShowList({})
  end
  local list = {}
  local showRewardPanel = false
  local skipBeginAnim = false
  local animData = {summonNum = 0}
  local sourceData
  for _, data in pairs(datas) do
    local isValidData, summonItemData = self:_HandleAwakerWeaponRewardData(data)
    if not isValidData then
    else
      SummonDataUtils.ShowGainItems(summonItemData)
      if nil == sourceData then
        sourceData = self:GetShowAwakerWeaponSource(data.reason, data.tid)
        showRewardPanel = sourceData and sourceData.showRewardPanel
        skipBeginAnim = sourceData and sourceData.skipBeginAnim
      end
      if showRewardPanel and not self.weaponLock[data.tid] then
        table.insert(list, data)
      end
    end
  end
  local awakerGainNum = list and #list or 0
  if showRewardPanel and awakerGainNum > 0 then
    animData.summonNum = list and #list or 0
    animData.skipBeginAnim = skipBeginAnim
    animData.summonQuality = SummonDataUtils.GetHighestQuality(list)
    UIManager.Instance:Reopen(Urls.SummonNewItemPanel, nil, nil, nil, animData)
  end
end

function PopTipsManager:ShowChooseReward(itemData)
  local itemTid = itemData.tid
  local autoRefineLevel = itemData.level or itemData.targetLevel or 0
  local autoRefineInfo = autoRefineLevel > 0 and {targetLevel = autoRefineLevel} or {}
  local summonResult = {
    highestQuality = DT.Item[itemTid].Quality,
    itemList = {
      {
        tid = itemTid,
        count = 1,
        transItems = itemData.transData,
        autoRefineInfo = autoRefineInfo
      }
    }
  }
  
  local function Unlock()
    self.binder:BindTimer(1, 0, nil, function()
      self:UpdateWeaponLock(itemTid, false)
    end)
  end
  
  if 1 == DataCenter.itemData.IsRewardRandom then
    DataCenter.itemData.IsRewardRandom = nil
    UIManager.Instance:Reopen(Urls.SummonResultPanel, summonResult, nil, true, Unlock)
  else
    UIAsyncLoadMgr.Instance:PrecreatePanel(Urls.SummonNewItemPanel)
    UIManager.Instance:Reopen(Urls.SummonSkinResultNextPanel, itemTid, function()
      UIManager.Instance:Reopen(Urls.SummonResultPanel, summonResult, nil, true, Unlock, true)
    end)
  end
end

function PopTipsManager:ShowSkinReward(datas)
  if not datas then
    return
  end
  local isHaveSkin = false
  local showSkinTidList = {}
  for index, data in pairs(table.clone(datas)) do
    local itemCfg = ItemDataUtils.GetItemConfig(data.tid) or {}
    if itemCfg.Type == CommonDefine.ItemType.SkinItem and (data.changedNum or 0) > 0 then
      isHaveSkin = true
      datas[index] = nil
      local summonSkinData = {
        reason = data.reason,
        skinTid = data.tid,
        transData = data.transData
      }
      SummonDataUtils.ShowGainItems(summonSkinData)
      table.insert(showSkinTidList, data.tid)
    end
  end
  if isHaveSkin then
    local animData = {skipBeginAnim = false}
    UIAsyncLoadMgr.Instance:PrecreatePanel(Urls.SummonNewItemPanel)
    UIManager.Instance:Reopen(Urls.SummonSkinResultNextPanel, showSkinTidList[1], function()
      UIManager.Instance:Reopen(Urls.SummonNewItemPanel, nil, nil, nil, animData, function()
      end)
    end)
  end
  return isHaveSkin
end

function PopTipsManager:_HandleAwakerWeaponRewardData(data)
  if type(data) ~= "table" then
    return false
  end
  local reason = data.reason
  if not ((not data.changedNum or not (data.changedNum <= 0)) and reason) or not self:GetShowAwakerWeaponSource(reason, data.tid) then
    return false
  end
  local ItemType = CommonDefine.ItemType
  local itemType = ItemDataUtils.GetItemType(data.tid)
  if itemType ~= ItemType.AwakerItem and itemType ~= ItemType.Weapon then
    return false
  end
  local summonItemData = {}
  if itemType == ItemType.AwakerItem then
    summonItemData.awakerItemTid = data.tid
  elseif itemType == ItemType.Weapon then
    summonItemData.weaponTid = data.tid
  end
  summonItemData.reason = data.reason
  summonItemData.transData = data.transData
  return true, summonItemData
end

function PopTipsManager:OnGetAwakerItem(data)
  if data.transData then
    local transItems = {}
    transItems.tid = data.transData.tid
    transItems.num = data.transData.num
    data.transItems = transItems
  end
  SummonDataUtils.ShowGainItems(data)
end

function PopTipsManager:OnDestroy()
  Super.OnDestroy(self)
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
end

local TutorialLockTimeoutSec = 15

function PopTipsManager:InitTutorialTipsCache()
  self.tutorialPopCache = {}
  self.tutorialLock = false
  self._tutorialLockTime = 0
  self._tutorialLockTimeoutWarned = false
end

function PopTipsManager:InsertTutorialPopCache(tidGroup)
  for _, tid in pairs(tidGroup) do
    table.insert(self.tutorialPopCache, tid)
  end
  if not self.tutorialLock then
    self:PopTutorialPopCache()
  end
end

function PopTipsManager:PopTutorialPopCache()
  if 0 == #self.tutorialPopCache then
    return
  end
  TutorialDataUtils.OpenTutorialPopTip(self.tutorialPopCache)
  self.tutorialPopCache = {}
end

function PopTipsManager:SetTutorialLock(val)
  if nil == val then
    return
  end
  self.tutorialLock = val
  if val then
    self._tutorialLockTime = os.time()
    self._tutorialLockTimeoutWarned = false
  end
  if false == val then
    self:PopTutorialPopCache()
  end
end

function PopTipsManager:IsTutorialLockActive()
  if not self.tutorialLock then
    return false
  end
  if os.time() - (self._tutorialLockTime or 0) > TutorialLockTimeoutSec then
    if not self._tutorialLockTimeoutWarned then
      self._tutorialLockTimeoutWarned = true
      Logger.Warn("PopTipsManager tutorialLock timeout, treat as unlocked to avoid reward popups stuck forever")
    end
    return false
  end
  return true
end

function PopTipsManager:AppendCachedRewardList(list)
  if not list or type(list) ~= "table" then
    return
  end
  table.append(self.cachedRewardList, list)
  self._cachedRewardTime = os.time()
end

function PopTipsManager:ClearCachedRewardList()
  self.cachedRewardList = {}
end

function PopTipsManager:_OnSummonRewardPanelClosed()
  if #self.cachedRewardList <= 0 then
    return
  end
  if SummonDataUtils.IsSummonGainShowPanelAtTop() then
    return
  end
  ItemDataUtils.ShowRewardPanel(self._cachedRewardTitle, self._cachedRewardSubTitle, self.cachedRewardList)
  self:ClearCachedRewardList()
  self._cachedRewardTime = nil
end

local CachedRewardTimeoutSec = 15

function PopTipsManager:_CheckCachedRewardTimeout()
  if #self.cachedRewardList <= 0 then
    return
  end
  if not self._cachedRewardTime then
    return
  end
  if os.time() - self._cachedRewardTime < CachedRewardTimeoutSec then
    return
  end
  if SummonDataUtils.IsSummonGainShowPanelAtTop() then
    self._cachedRewardTime = os.time()
    return
  end
  Logger.Warn("PopTipsManager:_CheckCachedRewardTimeout, force flushing cached rewards, count:", #self.cachedRewardList)
  ItemDataUtils.ShowRewardPanel(self._cachedRewardTitle, self._cachedRewardSubTitle, self.cachedRewardList)
  self:ClearCachedRewardList()
  self._cachedRewardTime = nil
end

return PopTipsManager
