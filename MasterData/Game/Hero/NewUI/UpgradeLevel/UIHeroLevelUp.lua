local UIHeroLevelUp = class("UIHeroLevelUp", UIBaseWindow)
local base = UIBaseWindow
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINHeroLevelUpItem = require("Game.Hero.NewUI.UpgradeLevel.UINHeroLevelUpItem")
local UINStarUpAttrItem = require("Game.Hero.NewUI.UpgradeStar.UINStarUpAttrItem")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UIHeroTweenUtil = require("Game.CommonUI.Tween.UINTweenUtil")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_Tweening = CS.DG.Tweening

function UIHeroLevelUp:OnInit()
  self.isClosing = false
  self.growupItemNums = {}
  self.growupItemList = {}
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  self.growupItemPool = UIItemPool.New(UINHeroLevelUpItem, self.ui.upgradeItem)
  self.ui.upgradeItem:SetActive(false)
  self.attrItemPool = UIItemPool.New(UINStarUpAttrItem, self.ui.attriItem)
  self.ui.attriItem:SetActive(false)
  self.upgradeItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.upgrade_chipItemWithCount)
  self.ui.upgrade_chipItemWithCount:SetActive(false)
  self.potentialImgWidth = self.ui.img_LimitUp.sprite.textureRect.width
  UIUtil.AddButtonListener(self.ui.btn_StarUp, self, self.OnClickLevelUp)
  UIUtil.AddButtonListener(self.ui.btn_ClearSelect, self, self.OnClickClean)
  UIUtil.AddButtonListener(self.ui.btn_LeftArrow, self, self.__OnClickLeftArrow)
  UIUtil.AddButtonListener(self.ui.btn_RightArrow, self, self.__OnClickRightArrow)
  UIUtil.AddButtonListener(self.ui.btn_LimitUp, self, self.__OnClickPotentialPreview)
  self.__refreshItem = BindCallback(self, self.RefreshItem)
  self.__refresh = BindCallback(self, self.Refresh)
  self:InitAllTween()
  self.ui.obj_potentialEft:SetActive(false)
  self.oriTexTweenCol = Color.New(1, 1, 1, 0.6)
end

function UIHeroLevelUp:InitAllTween()
  self.allTweens = self.transform:GetComponentsInChildren(typeof(CS.DG.Tweening.DOTweenAnimation))
  for i = 0, self.allTweens.Length - 1 do
    local tween = self.allTweens[i]
  end
end

function UIHeroLevelUp:InitHeroLevelUp(heroData, resloader, hideCallBack, switchHeroFunc)
  UIUtil.SetTopStatus(self, self.OnClickBack, {})
  self:PlayAllDOTween()
  self.heroData = heroData
  self.resloader = resloader
  self.hideCallBack = hideCallBack
  self.switchHeroFunc = switchHeroFunc
  self.heroId = heroData.dataId
  self.level = heroData.level
  self.curExp = heroData.curExp
  self.isClosing = false
  self:RefreshHeroStaticInfo()
  self:RefreshCurrency()
  self:RefreshLevelUpItems()
  self:CalAndShowExpBar()
  self:UpdatePotential()
  self:RefreshBlutDot()
  self.ui.obj_potentialEft:SetActive(false)
end

function UIHeroLevelUp:SwitchHero(heroData, reUseBigImgResloader)
  self:PlayAllDOTween()
  self.heroData = heroData
  self.heroId = heroData.dataId
  self.level = heroData.level
  self.curExp = heroData.curExp
  self.isClosing = false
  if self.lvUpSeq ~= nil then
    self.lvUpSeq:Kill(true)
    self.lvUpSeq = nil
    self.ui.tex_LevelTween:DOKill()
  else
    self:CalAndShowExpBar()
  end
  self:OnClickClean()
  self:RefreshHeroStaticInfo(reUseBigImgResloader)
  self:RefreshCurrency()
  self:UpdatePotential()
  self:RefreshBlutDot()
end

function UIHeroLevelUp:RefreshItem()
  self:RefreshLevelUpItems()
  self:CalAndShowExpBar()
  self:RefreshConfirmBtn()
  self:UpdatePotential()
end

function UIHeroLevelUp:Refresh()
  local heroData = PlayerDataCenter.heroDic[self.heroId]
  self.level = heroData.level
  self.curExp = heroData.curExp
  self:OnClickClean()
  self:CalAndShowExpBar()
  self:UpdatePotential()
  self:RefreshBlutDot()
end

function UIHeroLevelUp:RefreshHeroStaticInfo(reUseBigImgResloader)
  local campIcon = LanguageUtil.GetLocaleText(self.heroData:GetCampCfg().icon)
  self.resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_Camp.texture = texture
  end)
  if reUseBigImgResloader ~= nil then
    self.bigImgGameObject:SetActive(false)
    reUseBigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(self.heroData:GetResPicName()), function(prefab)
      DestroyUnityObject(self.bigImgGameObject)
      self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder)
      local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroList")
      self.ui.tween_heroHolder:DORestart()
    end)
  else
    if self.bigImgResloader ~= nil then
      self.bigImgResloader:Put2Pool()
    end
    self.bigImgResloader = cs_ResLoader.Create()
    self.bigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(self.heroData:GetResPicName()), function(prefab)
      DestroyUnityObject(self.bigImgGameObject)
      self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder)
      if self.ui == nil or self.ui.heroHolder == nil then
        return
      end
      local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroList")
      self.ui.tween_heroHolder:DORestart()
    end)
  end
end

function UIHeroLevelUp:RefreshCurrency(isFullLevel)
  local topStatusWin = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if isFullLevel then
    topStatusWin:SetResourceGroupActive(false)
    self.ui.obj_CurrencyCost:SetActive(false)
    return
  else
    topStatusWin:SetResourceGroupActive(true)
    self.ui.obj_CurrencyCost:SetActive(true)
  end
  if self.currencyId ~= nil then
    topStatusWin:SetTopStatusResIds({
      self.currencyId
    })
    self.ui.obj_CurrencyCost:SetActive(true)
    local itemCfg = ConfigData.item[self.currencyId]
    if itemCfg == nil then
      error("itemCfg read error id=" .. self.currencyId)
    else
      self.ui.img_CurrencyItem.sprite = CRH:GetSpriteByItemConfig(itemCfg)
    end
    self.ui.tex_CurrencyCost:SetIndex(0, tostring(self.needCurrencyNum))
  else
    topStatusWin:SetResourceGroupActive(false)
    self.ui.obj_CurrencyCost:SetActive(false)
  end
end

function UIHeroLevelUp:_RefreshQuickLevelUp()
  local canQuickLvUp = true
  for itemData, num in pairs(self.growupItemNums) do
    if num ~= 0 then
      canQuickLvUp = false
      break
    end
  end
  canQuickLvUp = canQuickLvUp and self.heroData:GenHeroCanQuickLevelUp()
  self._canQuickLvUp = canQuickLvUp
  self.ui.text_upgrade:SetIndex(canQuickLvUp and 2 or 0)
  if canQuickLvUp then
    self.ui.img_StarUp.color = self.ui.color_orange
    self.ui.btn_StarUp.interactable = true
  end
end

function UIHeroLevelUp:UpdateAttr(newLevel)
  self.attrItemPool:HideAll()
  local changeList = self.heroData:GetDifferAttrWhenRankUp(nil, newLevel)
  if 10 <= #changeList then
    for index, data in ipairs(changeList) do
      if 10 < index then
        break
      end
      local item = self.attrItemPool:GetOne()
      item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
    end
  elseif #changeList < 10 then
    local showedIds = {}
    local num = #changeList
    for index, data in ipairs(changeList) do
      table.insert(showedIds, data.attrId)
    end
    for _, attrId in ipairs(ConfigData.attribute.baseAttrIds) do
      if ConfigData.attribute[attrId].merge_attribute == 0 then
        if 10 <= num then
          break
        end
        if not table.contain(showedIds, attrId) then
          num = num + 1
          table.insert(changeList, {
            attrId = attrId,
            property = ConfigData.attribute[attrId].attribute_priority,
            oldAttr = self.heroData:GetAttr(attrId, nil, true),
            newAttr = nil
          })
        end
      end
    end
    table.sort(changeList, function(a, b)
      if a.property == b.property then
        return a.attrId < b.attrId
      else
        return a.property < b.property
      end
    end)
    for index, data in ipairs(changeList) do
      local item = self.attrItemPool:GetOne()
      item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
    end
  end
end

function UIHeroLevelUp:RefreshLevelUpItems()
  self.growupItemPool:HideAll()
  self.growupItemNums = {}
  local id = ConstGlobalItem.HeroExp
  if PlayerDataCenter.itemDic[id] ~= nil then
    local itemData = PlayerDataCenter.itemDic[id]
    local item = self.growupItemPool:GetOne(true)
    item.gameObject.name = tostring(id)
    item:InitExpItem(itemData, function(num)
      self.growupItemNums[itemData] = num
      if self.isInLvSeq and self.lvUpSeq ~= nil then
        self.lvUpSeq:Kill(true)
        self.lvUpSeq = nil
      else
        self:CalAndShowExpBar()
      end
    end, function(isShowTip)
      return self:CheckItemUse(isShowTip)
    end)
    table.insert(self.growupItemList, item)
  else
    local item = self.growupItemPool:GetOne(true)
    item:InitEmptyExpItem(id)
  end
end

function UIHeroLevelUp:CheckItemUse(isShowTip)
  local heroMaxLevel = self.heroData:GetHeroMaxLevel()
  if heroMaxLevel <= self.level or heroMaxLevel <= self.nextlevel then
    if isShowTip then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.hero_level_Full))
    end
    return false
  end
  heroMaxLevel = self.heroData:GetLevelLimit()
  if heroMaxLevel <= self.level or heroMaxLevel <= self.nextlevel then
    if isShowTip then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.LevelUp_Limit))
    end
    return false
  end
  return true
end

function UIHeroLevelUp:UpdateLevel(level)
  self:UpdateAttr(level)
  local isFullLevel = self.heroData:IsFullLevel()
  self.ui.tex_NextLv.gameObject:SetActive(not isFullLevel)
  self.ui.obj_MaxLevel:SetActive(isFullLevel)
  if not isFullLevel then
    if level <= 9 then
      self.ui.tex_NextLv.text = "0" .. tostring(level)
    else
      self.ui.tex_NextLv.text = tostring(level)
    end
    self.ui.tex_NextLv:StartScrambleTypeWriter()
  end
end

function UIHeroLevelUp:UpdatePotential(showLevel)
  showLevel = showLevel ~= nil and showLevel or self.heroData.potential
  if showLevel > self.heroData:GetMaxPotential() then
    showLevel = self.heroData:GetMaxPotential()
  end
  local vec = self.ui.img_LimitUp.rectTransform.sizeDelta
  vec.x = self.potentialImgWidth * showLevel
  self.ui.img_LimitUp.rectTransform.sizeDelta = vec
  local isRechLimit = self.heroData:IsReachLevelLimit()
  self.ui.cannotUpgrade:SetActive(isRechLimit)
  if isRechLimit then
    self.upgradeItemPool:HideAll()
    if self.heroData:IsFullLevel() then
      self.ui.text_cannotUpgrade:SetIndex(1)
    else
      self.ui.text_cannotUpgrade:SetIndex(0)
      local potentialCfg = ConfigData.hero_potential[self.heroData.dataId][self.heroData.potential]
      for itemId, needCount in pairs(potentialCfg.cost) do
        local item = self.upgradeItemPool:GetOne()
        local itemCfg = ConfigData.item[itemId]
        local wareHouseNum = PlayerDataCenter:GetItemCount(itemId)
        item:InitItemWithCount(itemCfg, needCount, nil, wareHouseNum)
      end
      self.ui.obj_upgradTips.transform:SetAsLastSibling()
    end
  end
end

function UIHeroLevelUp:CalAndShowExpBar(level, curExp, addExp)
  self:RefreshConfirmBtn()
  if self.isInLvSeq then
    return
  end
  if self.level <= 9 then
    self.ui.tex_curLv.text = "0" .. tostring(self.level)
  else
    self.ui.tex_curLv.text = tostring(self.level)
  end
  self.ui.tex_curLv:StartScrambleTypeWriter()
  level = level or self.level or 1
  curExp = curExp or self.curExp or 0
  addExp = addExp or self:_CalAddExp() or 0
  local requireExp = ConfigData.hero_level[level].exp
  local heroMaxLevel = self.heroData:GetLevelLimit()
  local maxAddExp = -curExp
  for i = level, heroMaxLevel - 1 do
    maxAddExp = maxAddExp + ConfigData.hero_level[i].exp
  end
  self:SetAddExpLimt(maxAddExp, addExp)
  self.ui.tex_Exp:SetIndex(0, tostring(curExp), tostring(requireExp))
  self.ui.tex_AddExp:SetIndex(0, tostring(addExp))
  local remainEXP = curExp + addExp
  local requireExp = ConfigData.hero_level[level].exp
  if remainEXP > self.heroData.curExp then
    while remainEXP >= requireExp and not (level >= heroMaxLevel) do
      level = level + 1
      remainEXP = remainEXP - requireExp
      requireExp = ConfigData.hero_level[level].exp
    end
  end
  self.nextlevel = level
  if self.heroData:IsFullLevel() then
    self.ui.img_Exp.fillAmount = 1
    self.ui.tex_Exp:SetIndex(1)
  else
    self.ui.img_Exp.fillAmount = remainEXP / requireExp
    self.ui.tex_Exp:SetIndex(0, tostring(remainEXP), tostring(requireExp))
  end
  self:UpdateLevel(level)
end

function UIHeroLevelUp:_CalAddExp()
  local totalExp = 0
  for itemData, num in pairs(self.growupItemNums) do
    totalExp = totalExp + itemData:GetActionArg(1) * num
  end
  return totalExp
end

function UIHeroLevelUp:SetAddExpLimt(maxAddExp, addExp)
  for _, item in ipairs(self.growupItemList) do
    item:SetAddExpLimt(maxAddExp, addExp)
  end
end

function UIHeroLevelUp:RefreshConfirmBtn()
  local potentialUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
  if self.heroData:IsReachLevelLimit() and not self.heroData:IsFullLevel() then
    self.ui.btn_StarUp.gameObject:SetActive(false)
    self.ui.img_ClearSelect.gameObject:SetActive(false)
    self.ui.btn_LimitUp.gameObject:SetActive(true)
    self.ui.img_BtnLimitUp.color = potentialUnlock and self.ui.color_orange or self.ui.color_gray
    self.ui.img_BtnLimitUp.transform.localPosition = self.ui.pos_canPotential
    self.ui.img_BtnLimitUp.rectTransform.sizeDelta = self.ui.size_canPotential
    return
  end
  local isSelect = false
  if table.count(self.growupItemNums) ~= 0 then
    for itemId, num in pairs(self.growupItemNums) do
      if 0 < num then
        isSelect = true
      end
    end
  end
  self.ui.img_ClearSelect.gameObject:SetActive(isSelect)
  self.ui.btn_LimitUp.gameObject:SetActive(potentialUnlock and not isSelect)
  self.ui.img_BtnLimitUp.color = self.ui.color_gray
  self.ui.img_BtnLimitUp.transform.localPosition = self.ui.pos_notPotential
  self.ui.img_BtnLimitUp.rectTransform.sizeDelta = self.ui.size_notPotential
  self.ui.btn_StarUp.gameObject:SetActive(true)
  if isSelect then
    self.ui.img_StarUp.color = self.ui.color_orange
    self.ui.btn_StarUp.interactable = true
  else
    self.ui.img_StarUp.color = self.ui.color_gray
    self.ui.btn_StarUp.interactable = false
  end
  self:_RefreshQuickLevelUp()
end

function UIHeroLevelUp:OnClickLevelUp()
  if self.heroData:IsReachLevelLimit() then
    if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
      UIManager:ShowWindowAsync(UIWindowTypeID.HeroPotential, function(window)
        window:InitPotential(self.heroData)
      end)
    else
      local msg = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
      cs_MessageCommon.ShowMessageTips(msg)
    end
    return
  end
  self.isInLvSeq = true
  if self._lvUpCompleteFunc == nil then
    self._lvUpCompleteFunc = BindCallback(self, self._LvUpComplete)
  end
  if self._canQuickLvUp then
    self.networkCtrl:CS_HERO_Upgrade(self.heroId, self.heroData.level + 1, self._lvUpCompleteFunc)
    return
  end
  local itemTab = {}
  for itemData, num in pairs(self.growupItemNums) do
    itemTab[itemData.dataId] = num
  end
  if table.count(itemTab) == 0 then
    return
  end
  if self.networkCtrl ~= nil then
    local canLevelUp = self.heroData:GenHeroCanQuickLevelUp()
    if canLevelUp then
      self.networkCtrl:CS_HERO_Upgrade(self.heroId, self.heroData.level + 1, self._lvUpCompleteFunc)
    end
  end
end

function UIHeroLevelUp:_LvUpComplete(objList)
  self:_KillLvUpSeq(false)
  if objList.Count ~= 1 then
    error("objList.Count error" .. tostring(objList.count))
    return
  end
  local resDic = objList[0]
  local diffData = resDic[self.heroId]
  if diffData == nil then
    return
  end
  local oldLv = diffData.oldLevel
  local curLv = self.heroData.level
  local HeroExpDiffData = {
    oldLevel = oldLv,
    oldRate = diffData.oldExp / ConfigData.hero_level[oldLv].exp,
    level = curLv,
    rate = self.heroData.curExp / ConfigData.hero_level[curLv].exp
  }
  if self._onExpSeqStart == nil then
    self._onExpSeqStart = BindCallback(self, self._OnExpSeqStart)
  end
  if self._onExpSeqAppendCallback == nil then
    self._onExpSeqAppendCallback = BindCallback(self, self._OnExpSeqAppendCallback)
  end
  if self._onExpSeqComplete == nil then
    self._onExpSeqComplete = BindCallback(self, self._OnExpSeqComplete)
  end
  self.lvUpSeq = UIHeroTweenUtil.CreateExpBarSequence(self.ui.img_Exp, HeroExpDiffData, self._onExpSeqStart, self._onExpSeqComplete, self._onExpSeqAppendCallback)
end

function UIHeroLevelUp:_OnExpSeqStart()
  self.ui.tex_Exp.gameObject:SetActive(false)
  self.ui.tex_LevelTween.gameObject:SetActive(true)
  self.ui.tex_LevelTween.text = ""
end

function UIHeroLevelUp:_OnExpSeqAppendCallback(tempLevel, duration)
  self.ui.tex_LevelTween:DOKill(true)
  self.ui.img_Exp.fillAmount = 0
  self.ui.tex_LevelTween.color = self.oriTexTweenCol
  self.ui.tex_LevelTween.transform.localScale = Vector3.one
  local empty = ""
  if tempLevel <= 9 then
    empty = "0"
  end
  local strLv = tostring(empty) .. tostring(tempLevel)
  self.ui.tex_LevelTween.text = strLv
  self.ui.tex_NextLv.text = strLv
  self.ui.tex_LevelTween:DOFade(0, duration):From():SetLoops(2, cs_Tweening.LoopType.Yoyo)
  self.ui.tex_LevelTween.transform:DOScale(Vector3.New(1.25, 1.25, 1), duration)
end

function UIHeroLevelUp:_OnExpSeqComplete()
  self.ui.tex_Exp.gameObject:SetActive(true)
  self.ui.tex_LevelTween.gameObject:SetActive(false)
  self.isInLvSeq = false
  self:CalAndShowExpBar()
end

function UIHeroLevelUp:_KillLvUpSeq(needComplete)
  if self.lvUpSeq ~= nil then
    self.lvUpSeq:Kill(needComplete)
    self.lvUpSeq = nil
  end
  self.ui.tex_LevelTween:DOKill()
end

function UIHeroLevelUp:OnClickClean(isForbidUpdateData)
  for _, item in ipairs(self.growupItemList) do
    item:CleanAll(isForbidUpdateData)
  end
  for itemData, _ in pairs(self.growupItemNums) do
    self.growupItemNums[itemData] = 0
  end
end

function UIHeroLevelUp:OnClickBack()
  if not self.isClosing then
    self.isClosing = true
  else
    return
  end
  if self.hideCallBack ~= nil then
    self.hideCallBack()
  end
  if self.closeEvent ~= nil then
    self.closeEvent()
    self.closeEvent = nil
  end
  local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if win ~= nil and not win.active then
    win.active = true
    win.gameObject:SetActive(true)
  end
  self:PlayAllDOTweenBackwards()
  self:Delete()
end

function UIHeroLevelUp:__OnClickLeftArrow()
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(-1)
    self:SwitchHero(newHeroData, reUseBigImgResloader)
  end
end

function UIHeroLevelUp:__OnClickRightArrow()
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(1)
    self:SwitchHero(newHeroData, reUseBigImgResloader)
  end
end

function UIHeroLevelUp:__OnClickPotentialPreview()
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroPotential, function(window)
      window:InitPotential(self.heroData)
    end)
  else
    local msg = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
    cs_MessageCommon.ShowMessageTips(msg)
  end
end

function UIHeroLevelUp:PlayAllDOTween()
  for i = 0, self.allTweens.Length - 1 do
    local tween = self.allTweens[i]
    tween:DORestart(false)
  end
end

function UIHeroLevelUp:PlayAllDOTweenBackwards()
  for i = 0, self.allTweens.Length - 1 do
    local tween = self.allTweens[i]
    tween:DOPlayBackwards()
  end
end

function UIHeroLevelUp:BackwardsAllDOTween(callback)
  local longestDuration = 0
  for i = 0, self.allTweens.Length - 1 do
    local tween = self.allTweens[i]
    if longestDuration < tween.duration then
      longestDuration = tween.duration + tween.delay
    end
    tween:DOPlayBackwards()
  end
  if callback ~= nil then
    TimerManager:StartTimer(longestDuration, callback, nil, true)
  end
end

function UIHeroLevelUp:RefreshBlutDot()
  self.ui.blueDot_pontential:SetActive(FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) and self.heroData:AblePotential())
end

function UIHeroLevelUp:OnShow()
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__refreshItem)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__refresh)
  base.OnShow(self)
end

function UIHeroLevelUp:PotentialAniPlay()
  if self.potentialTimerId ~= nil then
    TimerManager:StopTimer(self.potentialTimerId)
    self.potentialTimerId = nil
  end
  self:UpdatePotential(self.heroData.potential - 1)
  local vec = self.ui.obj_potentialEft.transform.localPosition
  vec.x = (self.heroData.potential - 1) * self.potentialImgWidth
  self.ui.obj_potentialEft.transform.localPosition = vec
  self.ui.obj_potentialEft:SetActive(false)
  self.ui.obj_potentialEft:SetActive(true)
  self.potentialTimerId = TimerManager:StartTimer(1, function()
    self.potentialTimerId = nil
    self:UpdatePotential()
  end, self, true, false, true)
end

function UIHeroLevelUp:OnHide()
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__refresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__refreshItem)
  base.OnHide(self)
end

function UIHeroLevelUp:OnDelete()
  self.growupItemPool:DeleteAll()
  if self.potentialTimerId ~= nil then
    TimerManager:StopTimer(self.potentialTimerId)
    self.potentialTimerId = nil
  end
  self:_KillLvUpSeq(false)
end

return UIHeroLevelUp
