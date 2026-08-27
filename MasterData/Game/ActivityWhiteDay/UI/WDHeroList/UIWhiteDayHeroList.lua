local UIWhiteDayHeroList = class("UIWhiteDayHeroList", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local ActivityWhiteDayUtil = require("Game.ActivityWhiteDay.ActivityWhiteDayUtil")
local UINWhiteDayHeroItem = require("Game.ActivityWhiteDay.UI.WDHeroList.UINWhiteDayHeroItem")
local UINWhiteDayShiftNodeItem = require("Game.ActivityWhiteDay.UI.WDHeroList.UINWhiteDayShiftNodeItem")

function UIWhiteDayHeroList:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Screen, self, self.__OnClickShiftHero)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.OnClickRule)
  self.resloader = cs_ResLoader.Create()
  self.itemDic = {}
  self.showingHeroList = {}
  self.selectedHeroId = nil
  self.__heroAssistTypeDic = {}
  self.__shiftAssistType = nil
  self.shiftFunc = BindCallback(self, self.__DefaultShiftFunc)
  self.sortFunc = BindCallback(self, self.__DefaultSortFunc)
  self.ui.loopscroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loopscroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__onClickHeroItem = BindCallback(self, self.__OnClickHeroItem)
  self.__onClickShiftHeroItem = BindCallback(self, self.__OnClickShiftHeroItem)
  self.shiftItemPool = UIItemPool.New(UINWhiteDayShiftNodeItem, self.ui.obj_optionItem)
  self.ui.obj_optionItem:SetActive(false)
  self.ui.obj_screenNode:SetActive(false)
end

function UIWhiteDayHeroList:InitWDHeroList(AWDCtrl, AWDData, AWDLineData, isPickPhoto, confirmCallback, closeCallback)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack(true)
  self.AWDCtrl = AWDCtrl
  self.AWDLineData = AWDLineData
  self.AWDData = AWDData
  if not isPickPhoto then
    self.selectedHeroId = AWDLineData:GetWDLDAssistHeroID()
  else
    self.selectedHeroId = nil
  end
  self.ui.btn_Info.gameObject:SetActive(not isPickPhoto)
  self.isPickPhoto = isPickPhoto
  self.confirmCallback = confirmCallback
  self.closeCallback = closeCallback
  self.ui.obj_selectHeroNode:SetActive(isPickPhoto)
  self.ui.obj_shifHeroNode:SetActive(not isPickPhoto)
  if isPickPhoto then
    local exchangeId, _ = self.AWDData:GetWDExchangePhotoItemIdAndNum()
    self.ui.img_Icon.sprite = CRH:GetSpriteByItemId(exchangeId)
  end
  self:__ShiftAndSortList()
  self:__RefreshList()
  self:__GenShiftItems()
  self:__RefreshAssistHeroEffect()
  self.transform:SetAsLastSibling()
end

function UIWhiteDayHeroList:__GenShiftItems()
  self.ui.obj_screenNode:SetActive(false)
  if self.isPickPhoto then
    return
  end
  self.shiftItemPool:HideAll()
  local item = self.shiftItemPool:GetOne()
  item:InitWDShiftItem(nil, self.__onClickShiftHeroItem)
  local assistGroup = ActivityWhiteDayUtil.GetAssistTypes(self.AWDData)
  for index, cfg in ipairs(assistGroup) do
    local item = self.shiftItemPool:GetOne()
    item:InitWDShiftItem(cfg, self.__onClickShiftHeroItem)
  end
end

function UIWhiteDayHeroList:__ShiftAndSortList()
  self.showingHeroList = {}
  if self.isPickPhoto then
    self.__heroId2PhotoIdDic = {}
    local photoCfgs = self.AWDData:GetWDPhotoCfgs()
    local unlockedPhotoIdDic = self.AWDData:GetWDUnlockedPhotoDic() or table.emptytable
    for photoId, photoCfg in pairs(photoCfgs) do
      if not unlockedPhotoIdDic[photoId] then
        local heroId = photoCfg.photo_hero
        local heroCfg = ConfigData.hero_data[heroId]
        table.insert(self.showingHeroList, heroCfg)
        self.__heroId2PhotoIdDic[heroId] = photoId
      end
    end
  else
    local underAssistHeroDic = self.AWDData:GetWDUnderAssistHeroDic()
    for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
      if not underAssistHeroDic[heroId] then
        local heroCfg = heroData.heroCfg
        if self.shiftFunc ~= nil then
          if self.shiftFunc(heroCfg) then
            table.insert(self.showingHeroList, heroCfg)
            self.__heroAssistTypeDic[heroId] = ActivityWhiteDayUtil.GetAssistHeroTypeByHeroId(self.AWDData, heroCfg)
          end
        else
          table.insert(self.showingHeroList, heroCfg)
          self.__heroAssistTypeDic[heroId] = ActivityWhiteDayUtil.GetAssistHeroTypeByHeroId(self.AWDData, heroCfg)
        end
      end
    end
  end
  if self.sortFunc ~= nil then
    table.sort(self.showingHeroList, self.sortFunc)
  end
end

function UIWhiteDayHeroList:__DefaultSortFunc(heroCfgA, heroCfgB)
  return heroCfgA.id < heroCfgB.id
end

function UIWhiteDayHeroList:__DefaultShiftFunc(heroCfg)
  if self.__shiftAssistType == nil then
    return true
  end
  local heroAssistType = self.__heroAssistTypeDic[heroCfg.id]
  return heroAssistType == self.__shiftAssistType
end

function UIWhiteDayHeroList:__RefreshList()
  self.ui.loopscroll.totalCount = #self.showingHeroList
  self.ui.loopscroll:RefillCells()
end

function UIWhiteDayHeroList:__OnNewItem(go)
  local heroCardItem = UINWhiteDayHeroItem.New()
  heroCardItem:Init(go)
  self.itemDic[go] = heroCardItem
end

function UIWhiteDayHeroList:__OnChangeItem(go, index)
  local heroCardItem = self.itemDic[go]
  if heroCardItem == nil then
    error("Can't find heroCardItem by gameObject")
    return
  end
  local heroCfg = self.showingHeroList[index + 1]
  if heroCfg == nil then
    error("Can't find heroCfg by index, index = " .. tonumber(index))
    return
  end
  local isSelected = self.selectedHeroId == heroCfg.id
  if self.isPickPhoto then
    heroCardItem:InitWDHeroItem(heroCfg, true, nil, self.__onClickHeroItem, self.resloader)
    heroCardItem:SetWDHeroItemSelected(isSelected)
  else
    local heroAssistType = self.__heroAssistTypeDic[heroCfg.id]
    heroCardItem:InitWDHeroItem(heroCfg, false, heroAssistType, self.__onClickHeroItem, self.resloader)
    heroCardItem:SetWDHeroItemSelected(isSelected)
  end
end

function UIWhiteDayHeroList:__GetItemByIndex(index)
  local go = self.ui.loopscroll:GetCellByIndex(index - 1)
  if go ~= nil then
    return self.itemDic[go]
  end
  return nil
end

function UIWhiteDayHeroList:__OnClickHeroItem(heroItem)
  if self.selectedHeroId ~= nil then
    if self.selectedHeroId == heroItem.heroCfg.id then
      heroItem:SetWDHeroItemSelected(false)
      self.selectedHeroId = nil
      self:__RefreshAssistHeroEffect()
      AudioManager:PlayAudioById(1200)
      return
    end
    local lastIndex
    for index, heroCfg in ipairs(self.showingHeroList) do
      if heroCfg.id == self.selectedHeroId then
        lastIndex = index
        break
      end
    end
    if lastIndex ~= nil then
      local lastSelectItem = self:__GetItemByIndex(lastIndex)
      if lastSelectItem ~= nil then
        lastSelectItem:SetWDHeroItemSelected(false)
      end
    end
  end
  heroItem:SetWDHeroItemSelected(true)
  self.selectedHeroId = heroItem.heroCfg.id
  self:__RefreshAssistHeroEffect()
  AudioManager:PlayAudioById(1201)
end

function UIWhiteDayHeroList:__RefreshAssistHeroEffect()
  if self.isPickPhoto then
    return
  end
  self.ui.obj_effectNode:SetActive(self.selectedHeroId ~= nil)
  if self.selectedHeroId == nil then
    return
  end
  local heroCfg = ConfigData.hero_data[self.selectedHeroId]
  local assistTypeId, assistCfg = ActivityWhiteDayUtil.GetAssistHeroTypeByHeroId(self.AWDData, heroCfg)
  self.ui.img_HeroEffectIcon:SetIndex(assistTypeId - 1)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(assistCfg.effect_text)
end

function UIWhiteDayHeroList:__OnClickShiftHero()
  self.ui.obj_screenNode:SetActive(not self.ui.obj_screenNode.activeSelf)
end

function UIWhiteDayHeroList:__OnClickShiftHeroItem(shiftAssistType)
  self.ui.obj_screenNode:SetActive(false)
  if shiftAssistType == self.__shiftAssistType then
    return
  end
  self.__shiftAssistType = shiftAssistType
  self:__ShiftAndSortList()
  self:__RefreshList()
end

function UIWhiteDayHeroList:__OnClickConfirm()
  if self.confirmCallback ~= nil then
    if self.isPickPhoto then
      local photoId = self.__heroId2PhotoIdDic[self.selectedHeroId]
      if photoId == nil then
        return
      end
      self.confirmCallback(photoId)
    else
      if self.selectedHeroId == nil then
        cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7215))
        return
      end
      self.confirmCallback(self.selectedHeroId)
    end
  end
  self:OnClickClose()
end

function UIWhiteDayHeroList:OnClickRule()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    local wdCfg = self.AWDData:GetWDCfg()
    window:InitCommonInfoByRule(wdCfg.assist_rule, true)
  end)
end

function UIWhiteDayHeroList:_BackAction()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self.__shiftAssistType = nil
  self:Hide()
end

function UIWhiteDayHeroList:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIWhiteDayHeroList:OnDelete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  self.shiftItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIWhiteDayHeroList
