_class("UIActivityN33BuildingInfo", UIController)
UIActivityN33BuildingInfo = UIActivityN33BuildingInfo
local ARCH_LEVEL_MIN_CONST = 1
local ARCH_LEVEL_MAX_CONST = 4
local TitleText_KEY = "str_n33_date_arch_info_key1"
local UpTipsText_KEY = "str_n33_date_arch_info_key2"
local RewardUnlockText_KEY = "str_n33_date_arch_info_key5"
local RewardItemText_KEY = "str_n33_date_arch_info_key6"
local UpLvBtnText_OverUp_KEY = "str_n33_date_arch_info_key8"
local UpLvBtnText_KEY2 = "str_n33_date_arch_info_key7"
local CurrRateText_KEY = "str_n33_date_arch_info_key9"

function UIActivityN33BuildingInfo:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIActivityN33BuildingInfo:OnShow(...)
  self:InitWidget()
  local data = table.unpack({
    ...
  })
  self.activityConst = data[1]
  self.currArchID = data[2]
  local serverData = self:GetServerData()
  self.archCfg = data[4]
  self.isAllArchFullLv = data[5]
  self.closeCallFun = data[6]
  self.currArchLv = ARCH_LEVEL_MIN_CONST
  self.showLv = ARCH_LEVEL_MIN_CONST
  self.isUpArch = false
  self.isCanUpArch = false
  self.isCanUpArch_Coin = false
  self.notCanUpArch_PreArch = false
  self:AttachEvent(GameEventType.OnN33RefArchUI, self.InitUI)
  self._currentTimeEvent = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, self.OnOneMinusUpdate, self)
  self:InitUI(serverData)
  self:PlayAnim(true)
end

function UIActivityN33BuildingInfo:InitWidget()
  self.rootNode = self:GetGameObject("RootNode")
  self.titleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self.upTipsText = self:GetUIComponent("UILocalizationText", "UpTipsText")
  self.imgIconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self.bgImageLoader = self:GetUIComponent("RawImageLoader", "bgImage")
  self.icon_item_3000328Loader = self:GetUIComponent("RawImageLoader", "icon_item_3000328")
  self.curr_rate_icon_item_3000328Loader = self:GetUIComponent("RawImageLoader", "curr_rate_icon_item_3000328")
  self.starNode_1 = self:GetUIComponent("Image", "StarNode_1")
  self.starNode_2 = self:GetUIComponent("Image", "StarNode_2")
  self.starNode_3 = self:GetUIComponent("Image", "StarNode_3")
  self.starNode_4 = self:GetUIComponent("Image", "StarNode_4")
  self.nameText = self:GetUIComponent("UILocalizationText", "NameText")
  self.nextAddRateNode = self:GetGameObject("NextAddRateNode")
  self.nextAddRateText = self:GetUIComponent("UILocalizationText", "NextAddRateText")
  self.currRateNode = self:GetGameObject("CurrRateNode")
  self.currRateText = self:GetUIComponent("UILocalizationText", "CurrRateText")
  self.rewardNode = self:GetGameObject("RewardNode")
  self.rewardUnlockText = self:GetUIComponent("UILocalizationText", "RewardUnlockText")
  self.rewardItemText = self:GetUIComponent("UILocalizationText", "RewardItemText")
  self.upBtn = self:GetUIComponent("Image", "UpBtn")
  self.upLvBtnText = self:GetUIComponent("UILocalizationText", "UpLvBtnText")
  self.UpLvBtnCoinNumText = self:GetUIComponent("UILocalizationText", "UpLvBtnCoinNumText")
  self.unupText = self:GetUIComponent("UILocalizationText", "UnupText")
  self.lbtn = self:GetGameObject("Lbtn")
  self.rbtn = self:GetGameObject("Rbtn")
  self.upTipsNode = self:GetGameObject("UpTipsNode")
  self.showStarNumNode = self:GetGameObject("ShowStarNumNode")
  self.showStarNumNode_rectTransform = self.showStarNumNode:GetComponent("RectTransform")
  self.showStarNumText = self:GetUIComponent("UILocalizationText", "ShowStarNumText")
  self.upgradedMark = self:GetGameObject("UpgradedMark")
  self.rewardItem = self:GetGameObject("RewardItem")
  self.rewardItemParent = self:GetGameObject("RewardItemParent")
  self.rewardPet = self:GetGameObject("PetReward")
  self.rewardPetParent = self:GetGameObject("PetRewardParent")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self.preNode1 = self:GetGameObject("PreNode1")
  self.preNode2 = self:GetGameObject("PreNode2")
  self.preNode3 = self:GetGameObject("PreNode3")
  self.preMark1 = self:GetGameObject("PreMark1")
  self.preMark2 = self:GetGameObject("PreMark2")
  self.preMark3 = self:GetGameObject("PreMark3")
  self.preText1 = self:GetUIComponent("UILocalizationText", "PreText1")
  self.preText2 = self:GetUIComponent("UILocalizationText", "PreText2")
  self.preText3 = self:GetUIComponent("UILocalizationText", "PreText3")
  self.upLvBtnUnClick = self:GetGameObject("UpLvBtnUnClick")
  self.CurrRateTitle = self:GetUIComponent("UILocalizationText", "CurrRateTitle")
  self.NextRateTitle = self:GetUIComponent("UILocalizationText", "NextRateTitle")
  self.OverUpLvBtnText = self:GetUIComponent("UILocalizationText", "OverUpLvBtnText")
  self.lNode = self:GetGameObject("LNode")
  self.imgIconLoader_l = self:GetUIComponent("RawImageLoader", "Icon_l")
  self.imgIcon_l = self:GetUIComponent("RawImage", "Icon_l")
  self.fullCoinTipsText_l = self:GetUIComponent("UILocalizationText", "FullCoinTipsText_l")
  self.starNodeL_1 = self:GetUIComponent("Image", "StarNodeL_1")
  self.starNodeL_2 = self:GetUIComponent("Image", "StarNodeL_2")
  self.starNodeL_3 = self:GetUIComponent("Image", "StarNodeL_3")
  self.starNodeL_4 = self:GetUIComponent("Image", "StarNodeL_4")
  self.infoNode_l = self:GetGameObject("InfoNode_l")
  self.lvUpNodeL = self:GetGameObject("LvUpNodeL")
  self.nameText2_l = self:GetUIComponent("UILocalizationText", "NameText2_l")
  self.nameText_l = self:GetUIComponent("UILocalizationText", "NameText_l")
  self._anim = self:GetGameObject():GetComponent("Animation")
  self.starNumMax = 4
  self.atlas = self:GetAsset("UIN33Date.spriteatlas", LoadType.SpriteAtlas)
  self.starNumNodePos1 = Vector2(50, 0)
  self.starNumNodePos2 = Vector2(210, 0)
  self.rewardItemPool = {}
  self.rewardPetPool = {}
  self:AttachEvent(GameEventType.AircraftInteractiveEventRewardShowItemTips, self._ShowTips)
end

function UIActivityN33BuildingInfo:CloseBtnOnClick(go)
  if self.activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  self:PlayAnim(false, function()
    self:CloseDialog()
  end)
end

function UIActivityN33BuildingInfo:LbtnOnClick(go)
  if self.activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  self.showLv = self.showLv - 1
  self:PlayPageAnim(function()
    self:RefreshUI()
  end)
end

function UIActivityN33BuildingInfo:RbtnOnClick(go)
  if self.activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  self.showLv = self.showLv + 1
  self:PlayPageAnim(function()
    self:RefreshUI()
  end)
end

function UIActivityN33BuildingInfo:UpBtnOnClick(go)
  if self.activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  if not self.preOk then
    ToastManager.ShowToast(StringTable.Get("str_n33_date_arch_info_key16"))
    return
  end
  if not self.isCanUpArch then
    return
  end
  if not self.isCanUpArch_Coin then
    ToastManager.ShowToast(StringTable.Get("str_n33_date_arch_info_key13"))
    return
  end
  if self.notCanUpArch_PreArch then
    ToastManager.ShowToast(StringTable.Get("str_n33_date_arch_info_key14"))
    return
  end
  self.isUpArch = true
  self:StartTask(function(TT)
    self._anim:Play("uieffanim_UIActivityN33BuildingInfo_upLevel")
    YIELD(TT, 800)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN33UpgradeArch, self.currArchID)
  end, self)
end

function UIActivityN33BuildingInfo:InitUI(serverData)
  local currArchServerData
  for key, value in pairs(serverData) do
    if value.arch_id == self.currArchID then
      currArchServerData = value
      break
    end
  end
  self.isAllArchFullLv = self:GetIsAllArchFullLv(serverData)
  local archLv = currArchServerData.level
  self.showLv = archLv >= ARCH_LEVEL_MAX_CONST and ARCH_LEVEL_MAX_CONST or archLv + 1
  self.currArchLv = archLv
  self:RefreshUI()
  self.bgImageLoader:LoadImage("N33_jyms_mask01")
  self.icon_item_3000328Loader:LoadImage("icon_item_3000328")
  self.curr_rate_icon_item_3000328Loader:LoadImage("icon_item_3000328")
end

function UIActivityN33BuildingInfo:GetIsAllArchFullLv(archInfos)
  for key, info in pairs(archInfos) do
    if info.level < ARCH_LEVEL_MAX_CONST then
      return false
    end
  end
  return true
end

function UIActivityN33BuildingInfo:RefreshUI(serverData)
  self.titleText:SetText(StringTable.Get(TitleText_KEY))
  local isNextLv = self.showLv == self.currArchLv + 1
  if isNextLv then
    self.CurrRateTitle:SetText(StringTable.Get("str_n33_date_arch_info_key3"))
  else
    self.CurrRateTitle:SetText(StringTable.Get("str_n33_date_arch_info_key17"))
  end
  local isOver = self.showLv <= self.currArchLv
  if isOver then
    self.rewardUnlockText:SetText(StringTable.Get("str_n33_date_arch_info_key18"))
    self.rewardItemText:SetText(StringTable.Get("str_n33_date_arch_info_key19"))
  else
    self.rewardUnlockText:SetText(StringTable.Get(RewardUnlockText_KEY))
    self.rewardItemText:SetText(StringTable.Get(RewardItemText_KEY))
  end
  self.NextRateTitle:SetText(StringTable.Get("str_n33_date_arch_info_key4"))
  self.OverUpLvBtnText:SetText(StringTable.Get(UpLvBtnText_OverUp_KEY))
  self.upLvBtnText:SetText(StringTable.Get(UpLvBtnText_KEY2))
  local conf = self.archCfg[self.showLv]
  self.imgIconLoader:LoadImage(conf.Pic)
  self.nameText:SetText(StringTable.Get(conf.Name))
  for i = 1, self.starNumMax do
    self["starNode_" .. i].gameObject:SetActive(i == conf.Level)
  end
  self:RefreshUI_UpBtn_UpTips()
  self:RefreshUI_Rate()
  self:RefreshUI_LRbtn()
  self:RefreshUI_UpBtn()
  self:RefreshUI_RewardList()
  self:RefreshUI_LInfo()
  self:RefreshUI_PetRewardList()
  if self.isAllArchFullLv then
    self.nextAddRateNode:SetActive(false)
    self.currRateNode:SetActive(false)
    self.upLvBtnUnClick:SetActive(true)
  end
  self:_CheckGuide()
end

function UIActivityN33BuildingInfo:RefreshUI_Rate()
  local isNextLv = self.showLv == self.currArchLv + 1
  self.nextAddRateNode:SetActive(isNextLv)
  local showConf = self.archCfg[self.showLv]
  local currConf = self.archCfg[self.currArchLv]
  if isNextLv then
    local addRate = (showConf.Rate - currConf.Rate) * 60
    self.nextAddRateText:SetText(StringTable.Get(CurrRateText_KEY, addRate))
    local currRate = currConf.Rate * 60
    self.currRateText:SetText(StringTable.Get(CurrRateText_KEY, currRate))
  else
    self.currRateText:SetText(StringTable.Get(CurrRateText_KEY, showConf.Rate * 60))
  end
  if isNextLv then
    self.upTipsText:SetText(StringTable.Get(UpTipsText_KEY))
    self.showStarNumNode_rectTransform.anchoredPosition = self.starNumNodePos2
  else
    self.upTipsText:SetText("")
    self.showStarNumNode_rectTransform.anchoredPosition = self.starNumNodePos1
  end
  self.upTipsNode:SetActive(isNextLv)
  self.showStarNumText:SetText(showConf.Level)
  self.upgradedMark:SetActive(self.showLv <= self.currArchLv)
end

function UIActivityN33BuildingInfo:RefreshUI_LRbtn()
  local isShowL = self.showLv > ARCH_LEVEL_MIN_CONST
  local isShowR = self.showLv < ARCH_LEVEL_MAX_CONST
  self.lbtn:SetActive(isShowL)
  self.rbtn:SetActive(isShowR)
end

function UIActivityN33BuildingInfo:RefreshUI_UpBtn()
  local isNextLv = self.showLv == self.currArchLv + 1
  local isOver = self.showLv <= self.currArchLv
  local isNotUp = self.showLv > self.currArchLv + 1
  local showConf = self.archCfg[self.showLv - 1]
  local currConf = self.archCfg[self.currArchLv]
  self.preOk = true
  self.isCanUpArch = false
  self.isCanUpArch_Coin = false
  self.unupText.gameObject:SetActive(false)
  self.OverUpLvBtnText.gameObject:SetActive(isOver)
  self.icon_item_3000328Loader.gameObject:SetActive(not isOver)
  self.UpLvBtnCoinNumText.gameObject:SetActive(not isOver)
  self.upLvBtnText.gameObject:SetActive(not isOver)
  if isNotUp then
    self.preOk = false
    local needCoin = showConf.UpgradeCost
    self.UpLvBtnCoinNumText:SetText(needCoin)
    self.upBtn.raycastTarget = true
    self.upLvBtnUnClick:SetActive(true)
  elseif isOver then
    self.upBtn.raycastTarget = false
    self.upLvBtnUnClick:SetActive(false)
  elseif isNextLv then
    local needCoin = showConf.UpgradeCost
    local itemModule = GameGlobal.GetModule(ItemModule)
    local coinCount = itemModule:GetItemCount(RoleAssetID.RoleAssetSimulationOperationCoin)
    self.isCanUpArch = true
    self.isCanUpArch_Coin = needCoin <= coinCount
    self.UpLvBtnCoinNumText:SetText(needCoin)
    self.upBtn.raycastTarget = true
    self.upLvBtnUnClick:SetActive(false)
  end
end

function UIActivityN33BuildingInfo:RefreshUI_UpBtn_UpTips()
  self.notCanUpArch_PreArch = false
  for i = 1, 3 do
    self["preNode" .. i]:SetActive(false)
  end
  if self.showLv == ARCH_LEVEL_MIN_CONST then
    self.preNode1:SetActive(true)
    self.preMark1:SetActive(true)
    self.preText1:SetText(StringTable.Get("str_n33_date_arch_info_key20"))
    return
  end
  local currConf = self.archCfg[self.showLv - 1]
  local index = 1
  for key, cond in pairs(currConf.PreCondition) do
    self["preNode" .. index]:SetActive(true)
    local tagArchID = cond[1]
    local tagArchLv = cond[2]
    local isOk = self:CheckArchPreCond(tagArchID, tagArchLv)
    local preConf = Cfg.cfg_component_simulation_operation({ArchitectureId = tagArchID, Level = tagArchLv})
    local str = StringTable.Get("str_n33_date_arch_info_key10", StringTable.Get(preConf[1].MapName), tagArchLv)
    self["preText" .. index]:SetText(str)
    if not isOk then
      self.notCanUpArch_PreArch = true
    end
    self["preMark" .. index]:SetActive(isOk)
    index = index + 1
  end
end

function UIActivityN33BuildingInfo:CheckArchPreCond(tagArchID, tagArchLv)
  self.serverData = self:GetServerData()
  for key, value in pairs(self.serverData) do
    if tagArchID == value.arch_id then
      return tagArchLv <= value.level
    end
  end
  return false
end

function UIActivityN33BuildingInfo:RefreshUI_RewardList()
  self.rewardNode:SetActive(self.showLv ~= ARCH_LEVEL_MIN_CONST)
  local isReceived = self.showLv <= self.currArchLv
  local rewardConf = {}
  if self.showLv > ARCH_LEVEL_MIN_CONST then
    rewardConf = self.archCfg[self.showLv - 1].Rewards
  end
  local rewardCount = table.count(rewardConf)
  local poolCount = table.count(self.rewardItemPool)
  if rewardCount > poolCount then
    for i = 1, rewardCount - poolCount do
      local item = UnityEngine.GameObject.Instantiate(self.rewardItem, self.rewardItemParent.transform)
      self.rewardItemPool[poolCount + i] = item
    end
  end
  for key, item in pairs(self.rewardItemPool) do
    item:SetActive(false)
  end
  if rewardCount <= 0 then
    return
  end
  for i = 1, rewardCount do
    local item = self.rewardItemPool[i]
    item:SetActive(true)
    local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local itemWidget = rowPool:SpawnObject("UIActivityN33RewardItem")
    itemWidget:SetRewardData_Item(rewardConf[i], isReceived, self.activityConst)
  end
end

function UIActivityN33BuildingInfo:RefreshUI_PetRewardList()
  local rewardConf = {}
  if self.showLv > ARCH_LEVEL_MIN_CONST then
    rewardConf = self.archCfg[self.showLv].StoryList
  end
  local rewardCount = table.count(rewardConf)
  local poolCount = table.count(self.rewardPetPool)
  if rewardCount > poolCount then
    for i = 1, rewardCount - poolCount do
      local item = UnityEngine.GameObject.Instantiate(self.rewardPet, self.rewardPetParent.transform)
      self.rewardPetPool[poolCount + i] = item
    end
  end
  for key, item in pairs(self.rewardPetPool) do
    item:SetActive(false)
  end
  if rewardCount <= 0 then
    return
  end
  for i = 1, rewardCount do
    local item = self.rewardPetPool[i]
    item:SetActive(true)
    local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local itemWidget = rowPool:SpawnObject("UIActivityN33RewardItem")
    itemWidget:SetRewardData_PetStory(rewardConf[i], self.showLv <= self.currArchLv, self.activityConst)
  end
end

function UIActivityN33BuildingInfo:RefreshUI_LInfo()
  local conf = self.archCfg[self.currArchLv]
  self.imgIconLoader_l:LoadImage(conf.Pic)
  local mat = self.imgIcon_l.material
  local mainTex = mat:GetTexture("_MainTex")
  local effIcon = self:GetUIComponent("MeshRenderer", "EffIcon1")
  local effIconMat = effIcon.sharedMaterial
  if effIconMat then
    effIconMat:SetTexture("_MainTex", mainTex)
  end
  self.nameText_l:SetText(StringTable.Get(conf.Name))
  self.nameText2_l:SetText(StringTable.Get(conf.Name))
  for i = 1, self.starNumMax do
    self["starNodeL_" .. i].gameObject:SetActive(i <= conf.Level)
  end
  self:_RefreshUpState(conf.Level)
  self:RefreshFullCoinTips(conf.LimitNum, conf.Rate)
end

function UIActivityN33BuildingInfo:_RefreshUpState(archLv)
  self.lvUpNodeL:SetActive(false)
  self.nameText_l.gameObject:SetActive(true)
  local isCanUp = archLv < ARCH_LEVEL_MAX_CONST
  if not isCanUp then
    return
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local coinCount = itemModule:GetItemCount(RoleAssetID.RoleAssetSimulationOperationCoin)
  local conf = self.archCfg[archLv]
  isCanUp = coinCount >= conf.UpgradeCost
  if not isCanUp then
    return
  end
  for key, value in pairs(conf.PreCondition) do
    local isPreOk = self:CheckUpPreCond(value)
    if not isPreOk then
      return
    end
  end
  self.nameText_l.gameObject:SetActive(false)
  self.lvUpNodeL:SetActive(true)
end

function UIActivityN33BuildingInfo:CheckUpPreCond(condition)
  local archID = condition[1]
  local archLv = condition[2]
  self.serverData = self:GetServerData()
  for key, value in pairs(self.serverData) do
    if value.arch_id == archID then
      return archLv <= value.level
    end
  end
  return false
end

function UIActivityN33BuildingInfo:RefreshFullCoinTips(CoinMax, rate)
  if self.isAllArchFullLv then
    self.fullCoinTipsText_l.gameObject:SetActive(false)
    return
  end
  self.serverData = self:GetServerData()
  local currArchServerData
  for key, value in pairs(self.serverData) do
    if value.arch_id == self.currArchID then
      currArchServerData = value
      break
    end
  end
  local currCoinNum = currArchServerData.coin_num + currArchServerData.default_coin
  if CoinMax <= currCoinNum then
    self.fullCoinTipsText_l:SetText(StringTable.Get("str_n33_date_arch_info_key12"))
    return
  end
  local t = (CoinMax - currCoinNum) / rate
  self.fullCoinTipsText_l:SetText(self:GetFormatTimerStr(t))
end

function UIActivityN33BuildingInfo:GetFormatTimerStr(time, id)
  local default_id = {
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107"
  }
  id = id or default_id
  local timeStr = StringTable.Get(id.over)
  if time < 0 then
    return timeStr
  end
  local day, hour, min, second = UIActivityHelper.Time2Str(time)
  if 0 < day then
    timeStr = self:NumColor(day) .. StringTable.Get(id.day) .. self:NumColor(hour) .. StringTable.Get(id.hour)
  elseif 0 < hour then
    timeStr = self:NumColor(hour) .. StringTable.Get(id.hour) .. self:NumColor(min) .. StringTable.Get(id.min)
  elseif 0 < min then
    timeStr = self:NumColor(min) .. StringTable.Get(id.min)
  else
    timeStr = string.format("<color=#FFC233>%s</color>", StringTable.Get(id.zero))
  end
  return StringTable.Get("str_n33_date_arch_info_key11", timeStr)
end

function UIActivityN33BuildingInfo:NumColor(num)
  local numStr = "<color=#FFC233>%d</color>"
  return string.format(numStr, num)
end

function UIActivityN33BuildingInfo:_ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIActivityN33BuildingInfo:OnOneMinusUpdate()
  if self.archCfg and self.currArchLv then
    local conf = self.archCfg[self.currArchLv]
    self:RefreshFullCoinTips(conf.LimitNum, conf.Rate)
  end
end

function UIActivityN33BuildingInfo:PlayAnim(isIn, callback)
  local key = "uieffanim_UIActivityN33BuildingInfo_in"
  if isIn then
    self:StartTask(function(TT)
      self:Lock(key)
      self._anim:Play("uieffanim_UIActivityN33BuildingInfo_in")
      YIELD(TT, 500)
      self:UnLock(key)
      if callback then
        callback()
      end
    end, self)
  else
    self:StartTask(function(TT)
      self._anim:Play("uieffanim_UIActivityN33BuildingInfo_out")
      YIELD(TT, 400)
      self:UnLock(key)
      if callback then
        callback()
      end
    end, self)
  end
end

function UIActivityN33BuildingInfo:PlayPageAnim(callback)
  self._anim:Stop()
  local key = "uieffanim_UIActivityN33BuildingInfo_page"
  self:StartTask(function(TT)
    self:Lock(key)
    self._anim:Play("uieffanim_UIActivityN33BuildingInfo_page")
    YIELD(TT, 200)
    self:UnLock(key)
    if callback then
      callback()
    end
  end, self)
  self._anim:Play("uieffanim_UIActivityN33BuildingInfo_page")
end

function UIActivityN33BuildingInfo:GetServerData()
  return self.activityConst:GetArchInfos()
end

function UIActivityN33BuildingInfo:OnHide()
  if self._currentTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._currentTimeEvent)
    self._currentTimeEvent = nil
  end
  if self.closeCallFun then
    self.closeCallFun()
  end
  if self.isUpArch then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN33ForceRefMapArch)
  end
  self:DetachEvent(GameEventType.AircraftInteractiveEventRewardShowItemTips, self._ShowTips)
  self:DetachEvent(GameEventType.OnN33RefArchUI, self.InitUI)
end

function UIActivityN33BuildingInfo:_CheckGuide()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if not guideModule:IsGuideDone(123003) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN33BuildingInfo1)
  elseif not guideModule:IsGuideDone(123005) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN33BuildingInfo2)
  end
end
