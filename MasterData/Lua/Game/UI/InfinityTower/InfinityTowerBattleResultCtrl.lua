local InfinityTowerBattleResultCtrl = class("InfinityTowerBattleResultCtrl", BaseCtrl)
local AdventureModuleHelper = CS.AdventureModuleHelper
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local LocalData = require("GameCore.Data.LocalData")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local newDayTime = UTILS.GetDayRefreshTimeOffset()
InfinityTowerBattleResultCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  bgComplete = {},
  goComplete = {},
  texLvCountTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Battle_LvCount"
  },
  texLvCount = {sComponentName = "TMP_Text"},
  texTimeCountTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Battle_Time"
  },
  texTimeCount = {sComponentName = "TMP_Text"},
  btn_Complete_Quit = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quite"
  },
  txtCompleteQuit = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Quit"
  },
  btn_NextLv = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NextLv"
  },
  txtNextLv = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_NextLv"
  },
  btn_NextMsg = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NextMsg"
  },
  tex_NextMsg = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Next_LvMsg"
  },
  auto_lv = {},
  auto_lvTime = {sComponentName = "TMP_Text"},
  bgFail = {},
  goFail = {},
  btn_Fail_Quit = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quite"
  },
  txtFailQuit = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Quit"
  },
  btn_Again = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Again"
  },
  btnDamageResult = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_DamageResult"
  },
  txtAgain = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Again"
  },
  txtTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Result_Fail_Tip"
  },
  txtTipShadow = {
    sComponentName = "TMP_Text",
    sLanguageId = "Battle_Result_Fail_Tip"
  },
  texTowerNameSuccess = {sComponentName = "TMP_Text"},
  texTowerNameFail = {sComponentName = "TMP_Text"},
  goNextMsg = {},
  anit_window = {
    sNodeName = "t_window_04",
    sComponentName = "Animator"
  },
  goNextMsg_blur = {},
  t_window_04 = {},
  MaskClose = {
    sComponentName = "UIButton",
    callback = "OnClickCloseNextMsgRoot"
  },
  btnCloseBV = {
    sComponentName = "UIButton",
    callback = "OnClickCloseNextMsgRoot"
  },
  txt_goNextMsgTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Next_LvMsg"
  },
  tex_goNextMsg_lvIndex = {sComponentName = "TMP_Text"},
  tex_goNextMsg_lvName = {sComponentName = "TMP_Text"},
  tex_goNextMsg_ReLv = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Lv"
  },
  tex_goNextMsg_ReLvCount = {sComponentName = "TMP_Text"},
  img_goNextMsg_ReCon = {sComponentName = "Image"},
  tex_goNextMsg_ReCon = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Construct"
  },
  btn_goNextMsg_MonInfo = {
    sComponentName = "UIButton",
    callback = "OnClickMonsterInfo"
  },
  tex_lvmsgBot_MonInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "MonsterInfo"
  },
  tex_goNextMsg_Affix = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Affix"
  },
  goNextMsg_affixSCRoot = {sComponentName = "Transform"},
  goNextMsg_affix_Item = {},
  tex_goNextMsg_Reward = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Reward"
  },
  goNextMsg_RewardRoot = {sComponentName = "Transform"},
  goNextMsg_RewardItem = {},
  goEnemyInfo = {
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  }
}
InfinityTowerBattleResultCtrl._mapEventConfig = {
  Infinity_Tower_SettleSuccess = "SettleSuccess",
  Infinity_Tower_AgainOrNext = "InfinityTowerAgainOrNext",
  [EventId.ClosePanel] = "OnEvent_ClosePanel",
  Close_Infinity_BountyUp = "OnEvent_CloseInfinityBountyUp",
  Stop_InfinityTowerAutoNextLv = "StopAutoNextLv"
}

function InfinityTowerBattleResultCtrl:Awake()
  self.rewardItem = {}
  self._mapNode.safeAreaRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function InfinityTowerBattleResultCtrl:FadeIn()
end

function InfinityTowerBattleResultCtrl:FadeOut()
end

function InfinityTowerBattleResultCtrl:OnEnable()
end

function InfinityTowerBattleResultCtrl:OnDisable()
end

function InfinityTowerBattleResultCtrl:OnDestroy()
  for go, ctrl in ipairs(self.rewardItem) do
    self:UnbindCtrlByNode(ctrl)
  end
  self.rewardItem = {}
end

function InfinityTowerBattleResultCtrl:OnRelease()
end

function InfinityTowerBattleResultCtrl:OnBtnClick_Quite()
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  PlayerData.InfinityTower:SetAutoNextLv(false)
  self:StopAutoNextLv()
  PlayerData.InfinityTower:LevelEnd()
  
  local function levelEndCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    NovaAPI.EnterModule("MainMenuModuleScene", true)
  end
  
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
  CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
end

function InfinityTowerBattleResultCtrl:OnBtnClick_NextLv()
  self:StopAutoNextLv()
  if self.haveReward or self.isBountyUp or self.isPlot then
    return
  end
  local isCan, tmpLv = self:CheckGoNextLv(true)
  if not isCan then
    return
  end
  self:CheckRecommend(tmpLv)
end

function InfinityTowerBattleResultCtrl:CheckGoNextLv(isTips)
  local isCan, tmpLv = PlayerData.InfinityTower:AnginOrNextLv(false)
  if not self:CheckCanGo(tmpLv, isTips) then
    return false, tmpLv
  end
  local tmpCharTid = PlayerData.InfinityTower.cacheCharTid
  if not PlayerData.InfinityTower:JudgeInfinityTowerBuildCanUse(tmpCharTid, tmpLv) then
    if isTips then
      local strTips = ConfigTable.GetUIText("InfinityTower_Build_NotMeetingCond")
      EventManager.Hit(EventId.OpenMessageBox, strTips)
    end
    return false, tmpLv
  end
  local _isLockWorldClass = PlayerData.InfinityTower:CheckLockWorldClass(tmpLv)
  if _isLockWorldClass then
    if isTips then
      local strTips = ConfigTable.GetUIText("InfinityTower_Lock_WorldClass")
      EventManager.Hit(EventId.OpenMessageBox, strTips)
    end
    return false, tmpLv
  end
  return true, tmpLv
end

function InfinityTowerBattleResultCtrl:OnBtnClick_Again()
  local isCan, tmpLv = PlayerData.InfinityTower:AnginOrNextLv(true)
  if not self:CheckCanGo(tmpLv, true) then
    return
  end
  self:CheckRecommend(tmpLv)
end

function InfinityTowerBattleResultCtrl:GoAgainOrNext()
  EventManager.Hit(EventId.ClosePanel, PanelId.BattleDamage)
  PlayerData.InfinityTower:GoAnginOrNextLv()
end

function InfinityTowerBattleResultCtrl:InfinityTowerAgainOrNext()
  GamepadUIManager.DisableGamepadUI("InfinityTowerBattleResultCtrl")
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  PanelManager.InputEnable(true)
  self._mapNode.imgBlurredBg:SetActive(false)
  self._mapNode.safeAreaRoot:SetActive(false)
end

function InfinityTowerBattleResultCtrl:CheckCanGo(tmpLv, isTips)
  local lvData = ConfigTable.GetData("InfinityTowerLevel", tmpLv)
  if lvData == nil then
    return false
  end
  local diff = lvData.DifficultyId
  local diffData = ConfigTable.GetData("InfinityTowerDifficulty", diff)
  local towerId = diffData.TowerId
  local _isOpenDay = PlayerData.InfinityTower:CheckOpenDay(towerId)
  if not _isOpenDay then
    if isTips then
      local strTips = ConfigTable.GetUIText("RegionBoss_Unlock_OpenDay")
      EventManager.Hit(EventId.OpenMessageBox, strTips)
    end
    return false
  end
  return true
end

function InfinityTowerBattleResultCtrl:CheckRecommend(tmpLv)
  local TipsTime = LocalData.GetPlayerLocalData("IntinityT_Tips_Time")
  local _tipDay = 0
  if TipsTime ~= nil then
    _tipDay = tonumber(TipsTime)
  end
  local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  local fixedTimeStamp = curTimeStamp - newDayTime * 3600
  local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
  local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
  local nDay = tonumber(os.date("!%d", fixedTimeStamp))
  local nowD = nYear * 366 + nMonth * 31 + nDay
  if nowD == _tipDay then
    self:GoAgainOrNext()
    EventManager.Hit("MainBattleMenuBtnPauseActive", false)
  else
    local function GetBuildCallback(mapBuildData)
      local recLv = ConfigTable.GetData("InfinityTowerLevel", tmpLv).RecommendLv
      
      local recRank = ConfigTable.GetData("InfinityTowerLevel", tmpLv).RecommendBuildRank
      local charTid = mapBuildData.tbChar[1].nTid
      local charData = PlayerData.Char:GetCharDataByTid(charTid)
      if charData ~= nil then
        if recLv <= charData.nLevel and recRank <= PlayerData.Build:CalBuildRank(mapBuildData.nScore).Id then
          self:GoAgainOrNext()
          EventManager.Hit("MainBattleMenuBtnPauseActive", false)
        else
          local isSelectAgain = false
          
          local function confirmCallback()
            if isSelectAgain then
              local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
              local _fixedTimeStamp = _curTimeStamp - newDayTime * 3600
              local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
              local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
              local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
              local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
              LocalData.SetPlayerLocalData("IntinityT_Tips_Time", tostring(_nowD))
            end
            self:GoAgainOrNext()
            EventManager.Hit("MainBattleMenuBtnPauseActive", false)
          end
          
          local function againCallback(isSelect)
            isSelectAgain = isSelect
          end
          
          local msg = {
            nType = AllEnum.MessageBox.Confirm,
            sContent = ConfigTable.GetUIText("InfinityTower_Recommend_Tips"),
            callbackConfirm = confirmCallback,
            callbackAgain = againCallback,
            bBlur = false
          }
          EventManager.Hit(EventId.OpenMessageBox, msg)
        end
      else
        self:GoAgainOrNext()
        EventManager.Hit("MainBattleMenuBtnPauseActive", false)
      end
    end
    
    local nBuildId = PlayerData.InfinityTower:GetCachedBuildId(tmpLv)
    PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId)
  end
end

function InfinityTowerBattleResultCtrl:SettleSuccess(isSuccess, time, tabItem, Change, tmpPlotId, tbCharDamage)
  self._mapNode.imgBlurredBg:SetActive(true)
  EventManager.Hit(EventId.BattleDashboardVisible, false)
  PanelManager.InputDisable()
  GamepadUIManager.EnableGamepadUI("InfinityTowerBattleResultCtrl", self.tbGamepadUINode, nil, true)
  local lvId = PlayerData.InfinityTower:GetCurrentLv()
  local lvData = ConfigTable.GetData("InfinityTowerLevel", lvId)
  local diff = lvData.DifficultyId
  local diffData = ConfigTable.GetData("InfinityTowerDifficulty", diff)
  local towerId = diffData.TowerId
  local towerData = ConfigTable.GetData("InfinityTower", towerId)
  self.LvSuccess = isSuccess
  self.tbCharDamage = tbCharDamage
  for i = 1, 2 do
    self._mapNode.btnDamageResult[i].gameObject:SetActive(self.tbCharDamage ~= nil and #self.tbCharDamage > 0)
  end
  if isSuccess then
    self.isAuto = false
    if PlayerData.InfinityTower:GetAutoNextLv() then
      self.isAuto = true
    end
    if self.isAuto then
      local isCanAuto, tmpNextLv = self:CheckGoNextLv(false)
      if not isCanAuto then
        self.isAuto = false
      end
    end
    WwiseAudioMgr:PostEvent("ui_loading_combatSFX_mute", nil, false)
    WwiseAudioMgr:PlaySound("ui_infinity_victory")
    self.tmpPlotId = tmpPlotId
    self.haveReward = false
    self.isBountyUp = false
    self.isPlot = tmpPlotId ~= 0 and not self.isAuto
    if 0 < #tabItem then
      self.haveReward = true
    end
    if PlayerData.InfinityTower.LastBountyLevel < PlayerData.InfinityTower.BountyLevel then
      self.isBountyUp = true
    end
    NovaAPI.SetTMPText(self._mapNode.texTowerNameSuccess, towerData.Name)
    self._mapNode.bgComplete:SetActive(true)
    self._mapNode.goComplete:SetActive(true)
    self._mapNode.goFail:SetActive(false)
    self._mapNode.bgFail:SetActive(false)
    local _diffSort = diffData.Sort
    local _data = PlayerData.InfinityTower:GetTowerDiffData(towerId, _diffSort)
    local _dataLv = _data.level
    local firstFloor = _data.firstFloor
    local endFloor = _data.endFloor
    local indexlvCount = 0
    for i = firstFloor, endFloor do
      local tmpData = _dataLv[i]
      indexlvCount = indexlvCount + 1
      if tmpData.Id == lvId then
        break
      end
    end
    local strIndex = indexlvCount
    if indexlvCount < 10 then
      strIndex = "0" .. indexlvCount
    end
    NovaAPI.SetTMPText(self._mapNode.texLvCount, string.format(ConfigTable.GetUIText("Infinity_Diff_Lv"), _diffSort, strIndex))
    NovaAPI.SetTMPText(self._mapNode.texTimeCount, time .. ConfigTable.GetUIText("Talent_Sec"))
    local isCan, tmpLv = PlayerData.InfinityTower:AnginOrNextLv(false)
    if isCan then
      self._mapNode.btn_NextLv.gameObject:SetActive(true)
      self._mapNode.btn_NextMsg.gameObject:SetActive(true)
    else
      self._mapNode.btn_NextLv.gameObject:SetActive(false)
      self._mapNode.btn_NextMsg.gameObject:SetActive(false)
    end
    if not self.isAuto then
      self._mapNode.auto_lv:SetActive(false)
      self:AddTimer(1, 1, function()
        PlayerData.SideBanner:TryOpenSideBanner()
        if self.haveReward then
          UTILS.OpenReceiveByDisplayItem(tabItem, Change)
        elseif self.isBountyUp then
          EventManager.Hit("Show_Infinity_BountyUp")
        elseif self.isPlot then
          PlayerData.InfinityTower:PlayPlot(self.tmpPlotId)
        end
      end, true, true, true)
    else
      self:AutoNextLv(tabItem, Change)
    end
    EventManager.Hit(EventId.TemporaryBlockInput, 2)
  else
    NovaAPI.SetTMPText(self._mapNode.texTowerNameFail, towerData.Name)
    self._mapNode.bgComplete:SetActive(false)
    self._mapNode.goComplete:SetActive(false)
    self._mapNode.bgFail:SetActive(true)
    self._mapNode.goFail:SetActive(true)
  end
  self._mapNode.safeAreaRoot:SetActive(true)
  self:PlayAni(isSuccess)
end

function InfinityTowerBattleResultCtrl:PlayAni(isSuccess)
  if isSuccess then
    self._mapNode.animRoot:Play("InfinityTowerBattleResult_Complete")
  else
    self._mapNode.animRoot:Play("InfinityTowerBattleResult_Fail")
  end
end

function InfinityTowerBattleResultCtrl:OnBtnClick_NextMsg()
  self:StopAutoNextLv()
  self._mapNode.goNextMsg:SetActive(true)
  self._mapNode.goNextMsg_blur:SetActive(true)
  self:ShowNextLvInfo(PlayerData.InfinityTower.NextLevelId)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.t_window_04:SetActive(true)
    self._mapNode.anit_window:Play("t_window_04_t_in")
  end
  
  cs_coroutine.start(wait)
end

function InfinityTowerBattleResultCtrl:OnBtnClick_DamageResult()
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleDamage, self.tbCharDamage)
end

function InfinityTowerBattleResultCtrl:ShowNextLvInfo(levelId)
  self.ChooseLevelId = levelId
  local lvData = ConfigTable.GetData("InfinityTowerLevel", levelId)
  local diffData = ConfigTable.GetData("InfinityTowerDifficulty", lvData.DifficultyId)
  local towerId = diffData.TowerId
  local diffSort = diffData.Sort
  local data = PlayerData.InfinityTower:GetTowerDiffData(towerId, diffSort)
  local dataLv = data.level
  local firstFloor = data.firstFloor
  local endFloor = data.endFloor
  local indexlvCount = 0
  for i = firstFloor, endFloor do
    local tmpData = dataLv[i]
    indexlvCount = indexlvCount + 1
    if tmpData.Id == levelId then
      break
    end
  end
  local strIndex = indexlvCount
  if indexlvCount < 10 then
    strIndex = "0" .. indexlvCount
  end
  NovaAPI.SetTMPText(self._mapNode.tex_goNextMsg_lvIndex, orderedFormat(ConfigTable.GetUIText("InfinityTower_Lv_IndexSpace"), strIndex))
  NovaAPI.SetTMPText(self._mapNode.tex_goNextMsg_lvName, lvData.Name)
  NovaAPI.SetTMPText(self._mapNode.tex_goNextMsg_ReLvCount, lvData.RecommendLv)
  local sScore = "Icon/BuildRank/BuildRank_" .. lvData.RecommendBuildRank
  self:SetPngSprite(self._mapNode.img_goNextMsg_ReCon, sScore)
  local childRewardCount = self._mapNode.goNextMsg_RewardRoot.childCount
  for i = 1, childRewardCount do
    self._mapNode.goNextMsg_RewardRoot:GetChild(i - 1).gameObject:SetActive(false)
  end
  local tbItem = {}
  local _base = decodeJson(lvData.BaseAwardPreview)
  for k, v in ipairs(_base) do
    table.insert(tbItem, {
      id = v[1],
      count = UTILS.ParseRewardItemCount(v)
    })
  end
  local index = 1
  for i, v in pairs(tbItem) do
    local objItem
    if index > self._mapNode.goNextMsg_RewardRoot.childCount then
      objItem = instantiate(self._mapNode.goNextMsg_RewardItem, self._mapNode.goNextMsg_RewardRoot)
    else
      objItem = self._mapNode.goNextMsg_RewardRoot:GetChild(index - 1).gameObject
    end
    local btn = objItem:GetComponent("UIButton")
    btn.onClick:RemoveAllListeners()
    
    local function clickCb()
      self:ShowItemTips(v.id, btn.gameObject)
    end
    
    btn.onClick:AddListener(clickCb)
    objItem:SetActive(true)
    local isGet = false
    local _objR = objItem.transform:Find("AniRoot/_RewardItem").gameObject
    self.rewardItem[_objR] = self:BindCtrlByNode(_objR, "Game.UI.TemplateEx.TemplateItemCtrl")
    self.rewardItem[_objR]:SetItem(v.id, nil, v.count, nil, isGet, nil, nil, true)
    index = index + 1
  end
  local childAffixCount = self._mapNode.goNextMsg_affixSCRoot.childCount
  for i = 1, childAffixCount do
    self._mapNode.goNextMsg_affixSCRoot:GetChild(i - 1).gameObject:SetActive(false)
  end
  local flData = ConfigTable.GetData("InfinityTowerFloor", lvData.FloorId)
  local tabAffixId = flData.AffixId
  local indexAffix = 1
  if lvData.EntryCond ~= 0 then
    local obj
    if indexAffix + 1 > self._mapNode.goNextMsg_affixSCRoot.childCount then
      obj = instantiate(self._mapNode.goNextMsg_affix_Item, self._mapNode.goNextMsg_affixSCRoot)
    else
      obj = self._mapNode.goNextMsg_affixSCRoot:GetChild(indexAffix).gameObject
    end
    self:ShowAffixItemMsg(obj, 0, false, lvData.EntryCond, lvData.EntryCondParam)
    indexAffix = indexAffix + 1
  end
  for i = 1, #tabAffixId do
    local obj
    if indexAffix + 1 > self._mapNode.goNextMsg_affixSCRoot.childCount then
      obj = instantiate(self._mapNode.goNextMsg_affix_Item, self._mapNode.goNextMsg_affixSCRoot)
    else
      obj = self._mapNode.goNextMsg_affixSCRoot:GetChild(indexAffix).gameObject
    end
    local affixId = 0
    if tabAffixId[i] ~= nil then
      affixId = tabAffixId[i]
    end
    self:ShowAffixItemMsg(obj, affixId, true, nil, nil)
    indexAffix = indexAffix + 1
  end
end

function InfinityTowerBattleResultCtrl:ShowItemTips(nTid, rtBtn)
  UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
end

function InfinityTowerBattleResultCtrl:ShowAffixItemMsg(obj, affixId, isAffix, entryCond, entryCondParam)
  obj:SetActive(true)
  local goNextMsg_affix_Item_1 = obj.transform:Find("goNextMsg_affix_Item_1").gameObject
  local goNextMsg_affix_Item_2 = obj.transform:Find("goNextMsg_affix_Item_2").gameObject
  local goNextMsg_affix_Item_3 = obj.transform:Find("goNextMsg_affix_Item_3").gameObject
  goNextMsg_affix_Item_1:SetActive(isAffix)
  goNextMsg_affix_Item_2:SetActive(not isAffix)
  goNextMsg_affix_Item_3:SetActive(false)
  if isAffix then
    local tex_1 = goNextMsg_affix_Item_1.transform:Find("texgoNextMsg_affix_Item_1"):GetComponent("TMP_Text")
    local dataAffix = ConfigTable.GetData("InfinityTowerAffix", affixId)
    local sDesc = orderedFormat(ConfigTable.GetUIText("InfinityTowerAffix_Desc"), dataAffix.Name, dataAffix.Desc)
    NovaAPI.SetTMPText(tex_1, UTILS.ParseParamDesc(sDesc, dataAffix))
  else
    local tex_2Title = goNextMsg_affix_Item_2.transform:Find("texgoNextMsg_affix_Item_2/Image/texgoNextMsg_affix_Item_2Title"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(tex_2Title, ConfigTable.GetUIText("InfinityTower_Limit_March"))
    local tex_2 = goNextMsg_affix_Item_2.transform:Find("texgoNextMsg_affix_Item_2"):GetComponent("TMP_Text")
    local strElement = ConfigTable.GetUIText("ELEMENT_" .. entryCondParam[1])
    if entryCond == GameEnum.InfinityTowerCond.MasterCharactersWithSpecificElementType then
      NovaAPI.SetTMPText(tex_2, orderedFormat(ConfigTable.GetUIText("InfinityTower_Cond_SpecificElementType"), strElement))
    elseif entryCond == GameEnum.InfinityTowerCond.ElementTypeWithSpecificQuantityNoLessThanQuantity then
      NovaAPI.SetTMPText(tex_2, orderedFormat(ConfigTable.GetUIText("InfinityTower_Cond_SpecificQuantityNoLessThanQuantity"), strElement, entryCondParam[2]))
    elseif entryCond == GameEnum.InfinityTowerCond.ElementTypeWithSpecificQuantityNoMoreThanQuantity then
      NovaAPI.SetTMPText(tex_2, orderedFormat(ConfigTable.GetUIText("InfinityTower_Cond_SpecificQuantityNoMoreThanQuantity"), strElement, entryCondParam[2]))
    end
  end
end

function InfinityTowerBattleResultCtrl:OnClickMonsterInfo()
  EventManager.Hit("OpenInfinityTowerMonsterInfo", self.ChooseLevelId)
end

function InfinityTowerBattleResultCtrl:OnClickCloseNextMsgRoot()
  self._mapNode.goNextMsg_blur:SetActive(false)
  self._mapNode.anit_window:Play("t_window_04_t_out")
  self:AddTimer(1, 0.3, function()
    self._mapNode.t_window_04:SetActive(false)
    self._mapNode.goNextMsg:SetActive(false)
  end, true, true, true)
end

function InfinityTowerBattleResultCtrl:OnEvent_ClosePanel(nPanelId)
  if type(nPanelId) == "number" and nPanelId == PanelId.ReceivePropsTips then
    if self.haveReward then
      self.haveReward = false
      if self.isBountyUp then
        EventManager.Hit("Show_Infinity_BountyUp")
      elseif self.isPlot then
        if self.isAuto and self.LvSuccess then
          self.isPlot = false
          return
        end
        PlayerData.InfinityTower:PlayPlot(self.tmpPlotId)
      end
    elseif self.isPlot then
      self.isPlot = false
    end
  end
end

function InfinityTowerBattleResultCtrl:OnEvent_CloseInfinityBountyUp()
  self:StopAutoNextLv()
  self.isBountyUp = false
  if self.isPlot then
    PlayerData.InfinityTower:PlayPlot(self.tmpPlotId)
  end
end

function InfinityTowerBattleResultCtrl:AutoNextLv(tabItem, Change)
  local function callback()
    self:StopAutoNextLv()
  end
  
  self:AddTimer(1, 0.1, function()
    self._mapNode.auto_lv:SetActive(true)
  end, true, true, true)
  self:SetAutoLvTime(5)
  local nCount = 0
  self.AutoNextLvCor = self:AddTimer(5, 1, function()
    nCount = nCount + 1
    self:SetAutoLvTime(5 - nCount)
    if nCount == 1 then
      UTILS.OpenReceiveByDisplayItem(tabItem, Change, callback)
    elseif nCount == 2 then
      EventManager.Hit(EventId.ClosePanel, PanelId.ReceivePropsTips)
      if self.isBountyUp then
        EventManager.Hit("Show_Infinity_BountyUp")
      end
    elseif nCount == 3 then
      if self.isBountyUp then
        EventManager.Hit("Close_BountyUp_Auto")
        self.isBountyUp = false
        if self.isPlot then
          self.isPlot = false
        end
      end
    elseif nCount == 5 then
      local isCan, tmpLv = self:CheckGoNextLv(true)
      if not isCan then
        return
      end
      self._mapNode.auto_lv:SetActive(false)
      self:GoAgainOrNext()
      EventManager.Hit("MainBattleMenuBtnPauseActive", false)
    end
  end, true, true, true)
end

function InfinityTowerBattleResultCtrl:StopAutoNextLv()
  if nil ~= self.AutoNextLvCor and self.isAuto and self.LvSuccess then
    self.isAuto = false
    PlayerData.InfinityTower:SetAutoNextLv(false)
    self.AutoNextLvCor:Cancel(false)
    self.haveReward = false
    self.isBountyUp = false
    self.isPlot = false
  end
  EventManager.Hit("ChangeAutoBattleStateClose")
  self.AutoNextLvCor = nil
  self._mapNode.auto_lv:SetActive(false)
end

function InfinityTowerBattleResultCtrl:SetAutoLvTime(tSec)
  NovaAPI.SetTMPText(self._mapNode.auto_lvTime, orderedFormat(ConfigTable.GetUIText("InfinityTower_AutoLevel_Time"), tSec))
end

return InfinityTowerBattleResultCtrl
