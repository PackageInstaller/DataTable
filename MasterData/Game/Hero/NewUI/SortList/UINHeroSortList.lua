local UINHeroSortList = class("UINHeroSortList", UIBaseNode)
local base = UIBaseNode
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local SpecificHeroDataRuler = require("Game.PlayerData.Hero.SpecificHeroDataRuler")
local SpecialRuleGenerator = require("Game.PlayerData.SpecialRuleGenerator")
local HeroListStateEnum = require("Game.Hero.NewUI.HeroListStateEnum")

function UINHeroSortList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.isShowSelected = true
  self.heroItemDic = {}
  self.ui.scrollRest.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.scrollRest.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__selectHeroFunc = BindCallback(self, self.__OnHeroItemClicked)
  self.__onLockedHeroItemClicked = BindCallback(self, self.__OnLockedHeroItemClicked)
  self.__onUpdateHeroEvent = BindCallback(self, self.__OnUpdateHeroEvent)
  self.__isFirstInit = true
  self.__OnSkinChange = BindCallback(self, self.OnSkinChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
  self.__OnTalentChange = BindCallback(self, self.OnTalentChange)
  MsgCenter:AddListener(eMsgEventId.HeroTalentUnlock, self.__OnSkinChange)
  MsgCenter:AddListener(eMsgEventId.HeroTalentLvUp, self.__OnSkinChange)
  MsgCenter:AddListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnSkinChange)
end

function UINHeroSortList:InitHeroSortList(resloader, customSelectHero, onItemClick, ableNoSelect, ableSelectSame, isShowSelected, autoSelect, specialRuleGenerator, showLockedHeros, alwaysShowCouldMergeHero)
  if isShowSelected == nil then
    isShowSelected = true
  end
  self.isShowSelected = isShowSelected
  if specialRuleGenerator ~= nil then
    self.specialRuleGenerator = specialRuleGenerator
    self.specificHeroDataRuler = specialRuleGenerator.specialRuler
  end
  if self.__isFirstInit then
    MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__onUpdateHeroEvent)
    self.__isFirstInit = false
  end
  if self.ui.scrollRest.horizontal then
    self.ui.scrollRest.horizontalNormalizedPosition = 1
  end
  if self.ui.scrollRest.vertical then
    self.ui.scrollRest.verticalNormalizedPosition = 1
  end
  self.resloader = resloader
  self.ableNoSelect = ableNoSelect or false
  self.ableSelectSame = ableSelectSame or true
  self.autoSelect = autoSelect == nil and true or autoSelect
  self.__customSelectHero = customSelectHero
  self.__onItemClick = onItemClick
  self:ClearSelectHero()
  if showLockedHeros then
    self.originLockedHeroDic = {}
  else
    self.originLockedHeroDic = nil
  end
  self:__LoadHeroItemList(showLockedHeros, alwaysShowCouldMergeHero)
end

function UINHeroSortList:SetOfficialSupportHeroDic(dic)
  self.officialSupportHeroDic = dic
end

function UINHeroSortList:SetHeroListAnchorPosOffset(anchorPosOffset)
  self.__anchorPosOffset = anchorPosOffset
end

function UINHeroSortList:AddModifySortAndFilterFunc(callback)
  if self.__ then
  end
end

function UINHeroSortList:RefreshHeroSortList(funcSift, funcSort, flag, isRefreshCells)
  if funcSift ~= nil then
    self.funcSift = funcSift
  end
  if funcSort ~= nil then
    self.funcSort = funcSort
  end
  if flag ~= nil then
    self.__flag = flag
    self.isShowFavor = HeroListStateEnum.isHaveFlag(flag, HeroListStateEnum.eHeroListFlag.showFavor)
    self.isEditorFavor = HeroListStateEnum.isHaveFlag(flag, HeroListStateEnum.eHeroListFlag.editorFavor)
    self.isShowLockedHero = HeroListStateEnum.isHaveFlag(flag, HeroListStateEnum.eHeroListFlag.showLocked) and not self.isShowFavor and not self.isEditorFavor
  end
  self.curHeroList = {}
  self.curLockedHeroList = {}
  local curSelectHero
  for _, heroData in pairs(self.originHeroDic) do
    if self.funcSift == nil or self.funcSift(heroData) then
      table.insert(self.curHeroList, heroData)
      if heroData == self.selectHero then
        curSelectHero = heroData
      end
    end
  end
  if self.isShowLockedHero and self.originLockedHeroDic ~= nil then
    for _, heroData in pairs(self.originLockedHeroDic) do
      if (self.funcSift == nil or self.funcSift(heroData)) and not heroData:GetIsNotShowInfo() then
        table.insert(self.curLockedHeroList, heroData)
      end
    end
  end
  if self.funcSort ~= nil then
    table.sort(self.curHeroList, self.funcSort)
    if self.isShowLockedHero then
      table.sort(self.curLockedHeroList, self.funcSort)
    end
  end
  if self.__customSelectHero ~= nil then
    self.__customSelectHero(curSelectHero)
  end
  for index, heroData in ipairs(self.curLockedHeroList) do
    table.insert(self.curHeroList, heroData)
  end
  if isRefreshCells and self.ui.scrollRest.totalCount == #self.curHeroList then
    self.ui.scrollRest:RefreshCells()
  else
    self.ui.scrollRest.totalCount = #self.curHeroList
    self.ui.scrollRest:RefillCells(0, self.__anchorPosOffset or 0)
  end
  if self.autoSelect then
    if self.ableNoSelect then
      if self.selectHero ~= curSelectHero then
        self:__RefreshSelectHero(curSelectHero)
        return
      end
      if #self.curHeroList == 0 or curSelectHero == nil then
        self:__RefreshSelectHero(nil)
      end
    else
      if self.selectHero ~= curSelectHero and curSelectHero ~= nil then
        self:__RefreshSelectHero(curSelectHero)
        return
      end
      if #self.curHeroList > 0 and curSelectHero == nil then
        self:__RefreshSelectHero(self.curHeroList[1])
      end
    end
  end
  return self.curHeroList
end

function UINHeroSortList:SetInFormationHero(inFormationDic)
  if self.inFormationDic ~= nil then
    for heroId, v in pairs(self.inFormationDic) do
      local heroItem = self:__GetHeroItemById(heroId)
      if heroItem ~= nil then
        heroItem:SetSelectActive(false)
      end
    end
  end
  self.inFormationDic = inFormationDic
  if inFormationDic == nil then
    return
  end
  for heroId, isBench in pairs(inFormationDic) do
    local heroItem = self:__GetHeroItemById(heroId)
    if heroItem ~= nil then
      heroItem:SetSelectActive(true, isBench)
    end
  end
end

function UINHeroSortList:SetAllFavorHero()
  for index, heroData in ipairs(self.curHeroList) do
    local index = index - 1
    local heroItem = self:__GetHeroItemByIndex(index)
    if heroItem ~= nil then
      local isFavor = self.isEditorFavor and PlayerDataCenter.favorHeroData:IsFavorHero(heroData.dataId)
      heroItem:SetSelectActive(isFavor, nil, isFavor)
    end
  end
end

function UINHeroSortList:ClearSelectHero()
  if self.selectHero ~= nil then
    local lastHeroItem = self:__GetHeroItemByData(self.selectHero)
    if lastHeroItem ~= nil and self.isShowSelected then
      lastHeroItem:SetSelectActive(false)
    end
  end
  self.selectHero = nil
end

function UINHeroSortList:SetShowRedDotActive(active)
  self.showRedDot = active
end

function UINHeroSortList:__LoadHeroItemList(showLockedHeros, alwaysShowCouldMergeHero)
  self.originHeroDic = {}
  self.selectHero = nil
  local showHeroDic = {}
  if self.specificHeroDataRuler ~= nil then
    if self.specificHeroDataRuler.heroIds ~= nil and #self.specificHeroDataRuler.heroIds > 0 then
      for i, v in ipairs(self.specificHeroDataRuler.heroIds) do
        local heroData = self.specialRuleGenerator:GetSpecificHeroData(v, self.specificHeroDataRuler)
        showHeroDic[v] = heroData
      end
    else
      for k, v in pairs(PlayerDataCenter.heroDic) do
        local heroData = self.specialRuleGenerator:GetSpecificHeroData(k, self.specificHeroDataRuler)
        showHeroDic[k] = heroData
      end
    end
  elseif self.officialSupportHeroDic ~= nil then
    showHeroDic = self.officialSupportHeroDic
  else
    for k, v in pairs(PlayerDataCenter.heroDic) do
      showHeroDic[k] = v
    end
  end
  if alwaysShowCouldMergeHero then
    for heroId, hero_dataCfg in pairs(ConfigData.hero_data) do
      if not hero_dataCfg.is_locked and showHeroDic[heroId] == nil then
        local specificHeroDataRuler = SpecificHeroDataRuler.New(1, hero_dataCfg.rank, 0)
        local heroData = SpecialRuleGenerator.CreateSpecificHeroData(heroId, specificHeroDataRuler)
        if heroData:GetIsCouldMerge() then
          heroData.isLockedHero = true
          showHeroDic[heroId] = heroData
        end
      end
    end
  end
  if showLockedHeros then
    for heroId, hero_dataCfg in pairs(ConfigData.hero_data) do
      if not hero_dataCfg.is_locked and showHeroDic[heroId] == nil then
        local specificHeroDataRuler = SpecificHeroDataRuler.New(1, hero_dataCfg.rank, 0)
        local heroData = SpecialRuleGenerator.CreateSpecificHeroData(heroId, specificHeroDataRuler)
        heroData.isLockedHero = true
        self.originLockedHeroDic[heroId] = heroData
      end
    end
  end
  self.originHeroDic = showHeroDic
end

function UINHeroSortList:__OnHeroItemClicked(heroData)
  self:__RefreshSelectHero(heroData)
end

function UINHeroSortList:__OnLockedHeroItemClicked(heroData)
  local function closeFunc()
    UIManager:ShowWindowOnly(UIWindowTypeID.HeroList, true)
  end
  
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroInfomation, function(window)
    if window ~= nil then
      window:InitHeroInformation(heroData, closeFunc)
    end
    local parWin = UIManager:GetWindow(UIWindowTypeID.HeroList)
    if parWin ~= nil then
      parWin:Hide()
    end
  end)
end

function UINHeroSortList:__RefreshSelectHero(heroData)
  if heroData == nil then
    return
  end
  if heroData == self.selectHero and self.ableNoSelect and not self.ableSelectSame then
    local lastHeroItem = self:__GetHeroItemByData(self.selectHero)
    if lastHeroItem ~= nil and self.isShowSelected then
      lastHeroItem:SetSelectActive(false)
    end
    self.selectHero = nil
    return
  end
  if self.selectHero ~= nil then
    local lastHeroItem = self:__GetHeroItemByData(self.selectHero)
    if lastHeroItem ~= nil and self.isShowSelected then
      lastHeroItem:SetSelectActive(false)
    end
    self.selectHero = nil
  end
  self.selectHero = heroData
  local selectItem = self:__GetHeroItemByData(self.selectHero)
  if selectItem ~= nil and self.isShowSelected then
    selectItem:SetSelectActive(true)
  end
  if self.__onItemClick ~= nil then
    self.__onItemClick(heroData, selectItem)
  end
end

function UINHeroSortList:__OnUpdateHeroEvent(heroList)
  local have2RefrshWholeList = false
  
  local function addNewHero(self, heroId)
    local heroData
    if self.specificHeroDataRuler ~= nil then
      heroData = self.specialRuleGenerator:GetSpecificHeroData(heroId, self.specificHeroDataRuler)
    else
      heroData = PlayerDataCenter.heroDic[heroId]
    end
    if heroData ~= nil then
      self.originHeroDic[heroId] = heroData
      have2RefrshWholeList = true
    end
  end
  
  local function updateItem(self, heroId)
    local heroItem = self:__GetHeroItemById(heroId)
    if heroItem ~= nil then
      if heroItem.SetIsBanNotSelfHero ~= nil then
        heroItem:SetIsBanNotSelfHero(self.isBanNotSelfHero)
      end
      if heroItem.heroData.isLockedHero then
        if heroItem.SetIsForceSupport ~= nil then
          heroItem:SetIsForceSupport(self.isForceSupport)
        end
        heroItem:InitHeroCardItem(PlayerDataCenter.heroDic[heroId], self.resloader, self.__selectHeroFunc, self.customDataDic)
        self.originHeroDic[heroId] = PlayerDataCenter.heroDic[heroId]
        have2RefrshWholeList = true
        return
      end
      heroItem:RefreshHeroCardItem()
      heroItem:SetEfficiencyActive(self.__showHeroPower or false)
    end
  end
  
  for heroId, v in pairs(heroList) do
    if self.originLockedHeroDic ~= nil and self.originLockedHeroDic[heroId] ~= nil then
      addNewHero(self, heroId)
      self.originLockedHeroDic[heroId] = nil
    elseif self.originHeroDic[heroId] ~= nil then
      updateItem(self, heroId)
    else
      addNewHero(self, heroId)
    end
  end
  if have2RefrshWholeList then
    self:RefreshHeroSortList()
  end
end

function UINHeroSortList:SetCustomCardClass(class)
  self.customCardClass = class
end

function UINHeroSortList:SetCustonDataDic(customDataDic)
  self.customDataDic = customDataDic
end

function UINHeroSortList:__OnInstantiateItem(go)
  local heroItem
  if self.customCardClass ~= nil then
    heroItem = self.customCardClass.New()
  else
    heroItem = UINHeroCardItem.New()
  end
  heroItem:Init(go)
  self.heroItemDic[go] = heroItem
end

function UINHeroSortList:__OnChangeItem(go, index)
  local heroItem = self.heroItemDic[go]
  if heroItem == nil then
    error("UINHeroSortList error:Can't find heroItem")
  end
  local heroData = self.curHeroList[index + 1]
  if heroData == nil then
    error("UINHeroSortList error:Can't find heroData")
  end
  if heroItem.SetIsBanNotSelfHero ~= nil then
    heroItem:SetIsBanNotSelfHero(self.isBanNotSelfHero)
  end
  if heroData.isLockedHero then
    if heroItem.SetIsForceSupport ~= nil then
      heroItem:SetIsForceSupport(self.isForceSupport)
    end
    heroItem:InitHeroCardItem(heroData, self.resloader, self.__onLockedHeroItemClicked, self.customDataDic)
    heroItem:SetEfficiencyActive(false)
    heroItem:SetRedDotActive(false)
  else
    if heroItem.SetIsForceSupport ~= nil then
      heroItem:SetIsForceSupport(self.isForceSupport)
    end
    heroItem:InitHeroCardItem(heroData, self.resloader, self.__selectHeroFunc, self.customDataDic)
    heroItem:SetEfficiencyActive(self.__showHeroPower or false)
    heroItem:SetSelectActive(false)
    if self.isShowSelected then
      heroItem:SetSelectActive(self.selectHero == heroData, nil)
    end
    if self.inFormationDic ~= nil then
      local inFormation = self.inFormationDic[heroData.dataId] ~= nil
      local isBench = self.inFormationDic[heroData.dataId]
      heroItem:SetSelectActive(inFormation, isBench)
    end
    if self.isEditorFavor then
      local isFavor = PlayerDataCenter.favorHeroData:IsFavorHero(heroData.dataId)
      heroItem:SetSelectActive(isFavor, nil, isFavor)
    end
    if self.showRedDot then
      local ok, heroNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, heroData.dataId)
      heroItem:SetRedDotActive(ok and heroNode:GetRedDotCount() > 0)
      local blueOk, heroSkinNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, heroData.dataId, RedDotStaticTypeId.HeroSkin)
      heroItem:SetBlueDotActive(blueOk and heroNode:GetRedDotCount() == 0 and 0 < heroSkinNode:GetBlueDotCount())
    end
  end
  if self.__changeItemCallback ~= nil then
    self.__changeItemCallback(index, heroItem)
  end
end

function UINHeroSortList:SetChangeItemCallback(callback)
  self.__changeItemCallback = callback
end

function UINHeroSortList:__GetHeroItemByData(heroData)
  for k, v in ipairs(self.curHeroList) do
    if v == heroData then
      local index = k - 1
      return self:__GetHeroItemByIndex(index)
    end
  end
  return nil
end

function UINHeroSortList:__GetHeroItemById(heroId)
  for k, v in ipairs(self.curHeroList) do
    if v.dataId == heroId then
      local index = k - 1
      return self:__GetHeroItemByIndex(index)
    end
  end
  return nil
end

function UINHeroSortList:__GetHeroItemByIndex(index)
  local go = self.ui.scrollRest:GetCellByIndex(index)
  if go ~= nil then
    return self.heroItemDic[go]
  end
  return nil
end

function UINHeroSortList:ShowHeroPower(showPower)
  self.__showHeroPower = showPower or false
end

function UINHeroSortList:OnSkinChange(heroId, skinId)
  for k, v in pairs(self.heroItemDic) do
    if v.heroData.dataId == heroId then
      v:UpdateSkin()
      break
    end
  end
end

function UINHeroSortList:OnTalentChange(heroId)
  if heroId ~= nil then
    for k, v in pairs(self.heroItemDic) do
      v:RefreshTalentState()
    end
  else
    for k, v in pairs(self.heroItemDic) do
      if v.heroData.dataId == heroId then
        v:RefreshTalentState()
        break
      end
    end
  end
end

function UINHeroSortList:SetIsForceSupport(bool)
  self.isForceSupport = bool
end

function UINHeroSortList:SetIsBanNotSelfHero(bool)
  self.isBanNotSelfHero = bool
end

function UINHeroSortList:OnDelete()
  self.officialSupportHeroDic = nil
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__onUpdateHeroEvent)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
  MsgCenter:RemoveListener(eMsgEventId.HeroTalentUnlock, self.__OnSkinChange)
  MsgCenter:RemoveListener(eMsgEventId.HeroTalentLvUp, self.__OnSkinChange)
  MsgCenter:RemoveListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnSkinChange)
  base.OnDelete(self)
end

return UINHeroSortList
