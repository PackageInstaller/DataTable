local UIHeroPotential = class("UIHeroPotential", UIBaseWindow)
local base = UIBaseWindow
local UINHeroPotentialCostItem = require("Game.Hero.NewUI.UpgradePotential.UINHeroPotentialCostItem")
local UINStarUpAttrItem = require("Game.Hero.NewUI.UpgradeStar.UINStarUpAttrItem")
local CS_MessageCommon = CS.MessageCommon

function UIHeroPotential:OnInit()
  self.ui.itemWithCount:SetActive(false)
  self.itemPool = UIItemPool.New(UINHeroPotentialCostItem, self.ui.itemWithCount)
  self.ui.attriItem:SetActive(false)
  self.attriPool = UIItemPool.New(UINStarUpAttrItem, self.ui.attriItem)
  self.potentialImgWidth = self.ui.img_cur_Activate.sprite.textureRect.width
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.OnClickCancle)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Last, self, self.OnClickLast)
  UIUtil.AddButtonListener(self.ui.btn_Next, self, self.OnClickNext)
  UIUtil.AddButtonListener(self.ui.background, self, self.OnClickCancle)
  self.__onRefreshItem = BindCallback(self, self.__RefreshItem)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onRefreshItem)
  UIUtil.Push2BackStack(self, self._OnReturn)
end

function UIHeroPotential:InitPotential(heroData, successCallback)
  self.heroData = heroData
  self.successCallback = successCallback
  self.selectPotential = self.heroData.potential
  if self.heroData:IsFullPotential() then
    self.selectPotential = self.heroData.potential - 1
  end
  self.potentialCfgDic = ConfigData.hero_potential[self.heroData.dataId]
  self:RefreshPotentialView()
  GuideManager:TryTriggerGuide(eGuideCondition.InHeroPotential)
end

function UIHeroPotential:RefreshPotentialView()
  local curPotentialCfg = self.potentialCfgDic[self.selectPotential]
  local nextPotemtialCfg = self.potentialCfgDic[self.selectPotential + 1]
  local maxPontential = self.heroData:GetMaxPotential()
  local totalLength = 0
  local vec = self.ui.img_cur_Activate.rectTransform.sizeDelta
  vec.x = self.potentialImgWidth * curPotentialCfg.potential_level
  totalLength = totalLength + vec.x
  self.ui.img_cur_Activate.rectTransform.sizeDelta = vec
  vec = self.ui.img_cur_Empty.rectTransform.sizeDelta
  vec.x = self.potentialImgWidth * (maxPontential - curPotentialCfg.potential_level)
  totalLength = totalLength + vec.x
  self.ui.img_cur_Empty.rectTransform.sizeDelta = vec
  vec = self.ui.rect_currLimit.sizeDelta
  vec.x = totalLength
  self.ui.rect_currLimit.sizeDelta = vec
  totalLength = 0
  vec = self.ui.img_next_Activate.rectTransform.sizeDelta
  vec.x = self.potentialImgWidth * nextPotemtialCfg.potential_level
  totalLength = totalLength + vec.x
  self.ui.img_next_Activate.rectTransform.sizeDelta = vec
  vec = self.ui.img_next_Empty.rectTransform.sizeDelta
  vec.x = self.potentialImgWidth * (maxPontential - nextPotemtialCfg.potential_level)
  totalLength = totalLength + vec.x
  self.ui.img_next_Empty.rectTransform.sizeDelta = vec
  vec = self.ui.rect_nextLimit.sizeDelta
  vec.x = totalLength
  self.ui.rect_nextLimit.sizeDelta = vec
  self.ui.tex_CurrLimit.text = tostring(curPotentialCfg.level_max)
  self.ui.tex_NextLimit.text = tostring(nextPotemtialCfg.level_max)
  local tipsColor = curPotentialCfg.level_max >= 60 and self.ui.color_tips_60 or self.ui.color_tips_normal
  self.ui.tex_Tips.text.color = tipsColor
  self.ui.img_TipsIcon.color = tipsColor
  self.attriPool:HideAll()
  local attriDataDic = self.heroData:GetDifferAttrWhenRankUp(nil, nil, nil, nil, nextPotemtialCfg.potential_level, curPotentialCfg.potential_level)
  for key, value in ipairs(attriDataDic) do
    local item = self.attriPool:GetOne()
    item:InitAttrItem(value.oldAttr, value.newAttr, value.attrId)
  end
  self:__RefreshCost(curPotentialCfg)
  if self.selectPotential ~= self.heroData.potential then
    self.ui.empty:SetActive(true)
    self.ui.canUP:SetActive(false)
  else
    self.ui.empty:SetActive(false)
    self.ui.canUP:SetActive(true)
    local isCanPotential = self.heroData:AblePotential()
    self.ui.img_Confirm.color = isCanPotential and self.ui.color_btn_canUp or self.ui.color_btn_dontUp
    self.ui.text_Confirm.color = isCanPotential and self.ui.color_text_canUp or self.ui.color_text_dontUp
    local tipIndex = 0
    if self.heroData:IsReachLevelLimit() then
      tipIndex = 0
      if self.selectPotential == 5 then
        tipIndex = 2
      end
    else
      tipIndex = 1
    end
    self.ui.tex_Tips:SetIndex(tipIndex)
  end
  self.ui.btn_Last.gameObject:SetActive(0 < curPotentialCfg.potential_level)
  self.ui.btn_Next.gameObject:SetActive(maxPontential > nextPotemtialCfg.potential_level)
end

function UIHeroPotential:OnClickCancle()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHeroPotential:OnClickConfirm()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
    local msg = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
    CS_MessageCommon.ShowMessageTipsWithErrorSound(msg)
    return
  end
  if self.heroData:IsFullPotential() then
    return
  end
  if not self.heroData:IsReachLevelLimit() then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.PotentialForbidTip))
    return
  end
  if not self.heroData:AblePotential() then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.hero_CantUpgrade))
    return
  end
  local localSelf = self
  local heroNetCtr = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  heroNetCtr:CS_HERO_PotentialUpgrade(self.heroData.dataId, function(lastData)
    self.isDelayApplyCloseEvent = true
    UIUtil.OnClickBackByUiTab(self)
    localSelf:OnPotentialSuccess(lastData)
  end)
end

function UIHeroPotential:OnClickLast()
  if self.selectPotential > 0 then
    self.selectPotential = self.selectPotential - 1
    self:RefreshPotentialView()
  end
end

function UIHeroPotential:OnClickNext()
  if self.selectPotential < self.heroData:GetMaxPotential() - 1 then
    self.selectPotential = self.selectPotential + 1
    self:RefreshPotentialView()
    AudioManager:PlayAudioById(1110)
  end
end

function UIHeroPotential:OnPotentialSuccess(lastData)
  if self.successCallback ~= nil then
    self.successCallback()
  end
  local lastHeroData = PlayerDataCenter.heroDic[lastData[0].heroId]
  local uiLevelUp = UIManager:GetWindow(UIWindowTypeID.HeroLevelUp)
  if uiLevelUp ~= nil then
    uiLevelUp:UpdatePotential(lastHeroData.potential - 1)
  end
  self.__onPotentialSuccessOpen = BindCallback(self, self.__PotentialSuccessOpen, lastData[0], lastHeroData)
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroPotentialSuccess, function(win)
    if win ~= nil then
      self.__onPotentialSuccessOpen(win)
    end
  end)
end

function UIHeroPotential:__PotentialSuccessOpen(lastData, heroData, win)
  local potentialCfgDic = ConfigData.hero_potential[heroData.dataId]
  local curLimit
  local curCfg = potentialCfgDic[heroData.potential - 1]
  if curCfg ~= nil then
    curLimit = curCfg.level_max
  end
  local nextLimit
  local nextCfg = potentialCfgDic[heroData.potential]
  if nextCfg ~= nil then
    nextLimit = nextCfg.level_max
  end
  local localSelf = self
  win:OnInitHeroLimitUpSuccess(curLimit, nextLimit, heroData.dataId)
  win:SetBtnCloseAction(self.closeEvent)
end

function UIHeroPotential:__RefreshItem()
  self:RefreshPotentialView()
end

function UIHeroPotential:__RefreshCost(curPotentialCfg)
  local curCfg
  if curPotentialCfg == nil then
    curCfg = self.potentialCfgDic[self.selectPotential]
  else
    curCfg = curPotentialCfg
  end
  self.itemPool:HideAll()
  local costDic = curCfg.cost
  local sortTab = {}
  for k, v in pairs(costDic) do
    local sortData = {
      id = k,
      cfg = ConfigData.item[k],
      needCount = v
    }
    table.insert(sortTab, sortData)
  end
  table.sort(sortTab, function(a, b)
    if a.cfg.quality < b.cfg.quality then
      return false
    end
    if a.id < b.id then
      return false
    end
    return true
  end)
  for _, value in ipairs(sortTab) do
    local item = self.itemPool:GetOne()
    item:InitCostInfo(value.cfg, value.needCount)
  end
end

function UIHeroPotential:SetHeroPotentialCloseEvent(Action)
  self.closeEvent = Action
end

function UIHeroPotential:_OnReturn()
  if self.closeEvent ~= nil and not self.isDelayApplyCloseEvent then
    self.closeEvent()
  end
  AudioManager:PlayAudioById(1089)
  self:Delete()
end

function UIHeroPotential:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onRefreshItem)
  base.OnDelete(self)
end

return UIHeroPotential
