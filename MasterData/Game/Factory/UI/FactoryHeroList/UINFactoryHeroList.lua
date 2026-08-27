local UINFactoryHeroList = class("UINFactoryHeroList", UIBaseNode)
local base = UIBaseNode
local UINHeroSortList = require("Game.Hero.NewUI.SortList.UINHeroSortList")
local UINSortButtonGroup = require("Game.Hero.NewUI.SortList.UINSortButtonGroup")
local UINSiftCondition = require("Game.Hero.NewUI.SortList.UINSiftCondition")
local UINFactoryHeroListCard = require("Game.Factory.UI.FactoryHeroList.UINFactoryHeroListCard")
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
local HeroSortEnum = require("Game.Hero.NewUI.HeroSortEnum")
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_MessageCommon = CS.MessageCommon
local ENTER_LIMIT = 3

function UINFactoryHeroList:OnInit()
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.resloader = cs_ResLoader.Create()
  self.__OnClickHeroItem = BindCallback(self, self.m_OnClickHeroItem)
  self.__OnFilterConfirmAction = BindCallback(self, self.m_OnFilterConfirmAction)
  self.__OnClickBtnSortItem = BindCallback(self, self.m_OnClickBtnSortItem)
  self.SelectedHeroIds = {}
  self.SavedSelectedHeroIds = {}
  self.CardDatas = {}
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Filter, self, self.m_OnClickBtnFilter)
  UIUtil.AddButtonListener(self.ui.btn_Comfirm, self, self.m_OnClickConfirm)
  self:SetHeroListTweens()
end

function UINFactoryHeroList:SetCallback(EnergyAddCallback, confirmCallback)
  self.EnergyAddCallback = EnergyAddCallback
  self.confirmCallback = confirmCallback
end

function UINFactoryHeroList:InitFactoryHeroList(roomIndex)
  self.roomIndex = roomIndex
  self.ui.sortConditionNode:SetActive(false)
  self.ui.btn_Comfirm.gameObject:SetActive(false)
  self:m_InitHeroList()
  self:m_InitSortButtonGroup()
  self:ShowHeroCollection()
  self.pageSequence:Restart()
  self:ReadCurEntered()
  self.SavedSelectedHeroIds = table.deepCopy(self.SelectedHeroIds)
end

function UINFactoryHeroList:ReadCurEntered()
  local AllEnteredHeroIds = self.factoryController:GetRoomHeroList()
  self.SelectedHeroIds = {}
  self.CardDatas = {}
  for roomIndex, heroList in pairs(AllEnteredHeroIds) do
    if roomIndex == self.roomIndex then
      for index, value in ipairs(heroList) do
        self.SelectedHeroIds[index] = value
        self.CardDatas[value] = {
          roomIndex = roomIndex,
          num = index,
          isInOtherFactory = false
        }
      end
    else
      for index, value in ipairs(heroList) do
        self.CardDatas[value] = {roomIndex = roomIndex, isInOtherFactory = true}
      end
    end
  end
  for heroId, cardData in pairs(self.CardDatas) do
    local cardItem = self.heroSortList:__GetHeroItemById(heroId)
    if cardItem ~= nil then
      cardItem:RefreshFactoryUI(cardData)
    end
  end
  self.heroSortList:SetCustonDataDic(self.CardDatas)
  self.heroSortList:RefreshHeroSortList()
  self:UpdateEnergyAdd(true)
end

function UINFactoryHeroList:m_InitHeroList()
  if self.heroSortList == nil then
    local HeroSortList = UINHeroSortList.New()
    HeroSortList:Init(self.ui.heroListFade.gameObject)
    HeroSortList:SetShowRedDotActive(false)
    HeroSortList:SetCustomCardClass(UINFactoryHeroListCard)
    HeroSortList:InitHeroSortList(self.resloader, nil, self.__OnClickHeroItem, true, false, false, false)
    HeroSortList:ShowHeroPower(false)
    self.heroSortList = HeroSortList
  end
end

function UINFactoryHeroList:m_OnClickHeroItem(heroData, selectItem)
  for index, heroId in ipairs(self.SelectedHeroIds) do
    if heroData.dataId == heroId then
      local oldNum = self.CardDatas[heroData.dataId].num
      table.remove(self.SelectedHeroIds, index)
      if not self.CardDatas[heroData.dataId].isInOtherFactory then
        self.CardDatas[heroData.dataId] = nil
      else
        self.CardDatas[heroData.dataId].num = nil
      end
      for index, heroId in ipairs(self.SelectedHeroIds) do
        self.CardDatas[heroId].num = index
        local cardItem = self.heroSortList:__GetHeroItemById(heroId)
        if cardItem ~= nil then
          cardItem:RefreshFactoryUI(self.CardDatas[heroId])
        end
      end
      self:ShowHeroChange(heroData, selectItem)
      return
    end
  end
  if #self.SelectedHeroIds >= ENTER_LIMIT then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(string.format(ConfigData:GetTipContent(TipContent.Factory_HeroEnterLimit), tostring(ENTER_LIMIT)))
    return
  end
  
  local function ApplySelect()
    table.insert(self.SelectedHeroIds, heroData.dataId)
    if self.CardDatas[heroData.dataId] == nil then
      self.CardDatas[heroData.dataId] = {
        roomIndex = self.roomIndex,
        num = #self.SelectedHeroIds,
        isInOtherFactory = false
      }
    else
      self.CardDatas[heroData.dataId].num = #self.SelectedHeroIds
    end
    self:ShowHeroChange(heroData, selectItem)
  end
  
  if self.CardDatas[heroData.dataId] ~= nil and self.CardDatas[heroData.dataId].isInOtherFactory then
    cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.Factory_ConfirmSwitchHero), ApplySelect, nil)
  else
    ApplySelect()
  end
end

function UINFactoryHeroList:ShowHeroChange(heroData, selectItem)
  selectItem:RefreshFactoryUI(self.CardDatas[heroData.dataId])
  local isChanged = false
  if #self.SavedSelectedHeroIds ~= #self.SelectedHeroIds then
    isChanged = true
  else
    for index, heroId in ipairs(self.SavedSelectedHeroIds) do
      if heroId ~= self.SelectedHeroIds[index] then
        isChanged = true
        break
      end
    end
  end
  self.ui.btn_Comfirm.gameObject:SetActive(isChanged)
  self:UpdateEnergyAdd()
end

function UINFactoryHeroList:UpdateEnergyAdd(isInit)
  if self.EnergyAddCallback ~= nil then
    self.EnergyAddCallback(self.SelectedHeroIds, isInit)
  end
end

function UINFactoryHeroList:m_OnClickConfirm()
  self.factoryController:SetRoomHeroList(self.roomIndex, self.SelectedHeroIds, self.confirmCallback)
end

function UINFactoryHeroList:m_InitSortButtonGroup()
  if self.sortButtonGroup == nil then
    local sortButtonGroup = UINSortButtonGroup.New()
    sortButtonGroup:Init(self.ui.buttonGroup)
    sortButtonGroup:InitSortButtonGroup(HeroSortEnum.SortMannerDefine, self.__OnClickBtnSortItem, HeroSortEnum.eSortResource.factory)
    self.sortButtonGroup = sortButtonGroup
  end
end

function UINFactoryHeroList:m_OnClickBtnSortItem(sortFunc)
  if self.heroSortList == nil then
    self:m_InitHeroList()
  end
  self.heroSortList:RefreshHeroSortList(nil, sortFunc)
end

function UINFactoryHeroList:m_OnClickBtnFilter()
  if self.siftCondition == nil then
    local SiftConditionPage = UINSiftCondition.New()
    SiftConditionPage:Init(self.ui.sortConditionNode)
    SiftConditionPage:InitSiftCondition(HeroFilterEnum.eKindType, HeroFilterEnum.eKindMaxCount, self.__OnFilterConfirmAction)
    self.siftCondition = SiftConditionPage
  end
  self.siftCondition:Show()
end

function UINFactoryHeroList:m_OnFilterConfirmAction(sortKindData)
  self.sortKindData = sortKindData
  if self.heroSortList == nil then
    self:m_InitHeroList()
  end
  self.heroSortList:RefreshHeroSortList(BindCallback(self, self.__SiftFunction), nil)
end

function UINFactoryHeroList:__SiftFunction(heroData)
  local rareConfig = self.sortKindData[HeroFilterEnum.eKindType.Rank]
  local Star = math.floor(heroData.rank / 2)
  if Star == 0 then
    Star = 1
  end
  local rankOk = rareConfig.nocondition or rareConfig.selectIndexs[Star]
  local campConfig = self.sortKindData[HeroFilterEnum.eKindType.Camp]
  local campOk = campConfig.nocondition or campConfig.selectIndexs[heroData.camp]
  local careerConfig = self.sortKindData[HeroFilterEnum.eKindType.Career]
  local careerOk = careerConfig.nocondition or careerConfig.selectIndexs[heroData.career]
  if rankOk and campOk and careerOk then
    return true
  else
    return false
  end
end

function UINFactoryHeroList:ShowHeroCollection()
  local totalCount = ConfigData.hero_data.totalHeroCount
  local collectRate = 0
  collectRate = math.ceil(PlayerDataCenter.heroCount / totalCount * 100)
  self.ui.tex_Trim.gameObject:SetActive(0 < collectRate / 100)
  self.ui.tex_Collect:SetIndex(0, tostring(collectRate))
end

function UINFactoryHeroList:SetHeroListTweens()
  self.ui.decorFade.alpha = 0
  self.ui.heroListFade.alpha = 0
  self.pageSequence = cs_DoTween.Sequence()
  self.pageSequence:Append(self.ui.decorFade:DOFade(1, 0.1):SetLoops(3))
  self.pageSequence:Append(self.ui.heroListFade:DOFade(1, 0.15))
  self.pageSequence:SetDelay(0.1)
  self.pageSequence:SetAutoKill(false)
end

function UINFactoryHeroList:DeleteHeroListTweens()
  if self.pageSequence ~= nil then
    self.pageSequence:Kill()
    self.pageSequence = nil
  end
end

function UINFactoryHeroList:OnHide()
  MsgCenter:Broadcast(eMsgEventId.UIHeroListClosed)
  UIManager:PlayDoFade(self.ui.canvasGroup, 1, 0, 0.25, BindCallback(self, base.Delete))
  UIManager:PlayFov(90, 30, 0.25)
  base.OnHide(self)
end

function UINFactoryHeroList:OnDelete()
  self:DeleteHeroListTweens()
  if self.sortButtonGroup ~= nil then
    self.sortButtonGroup:Delete()
  end
  if self.siftCondition ~= nil then
    self.siftCondition:Delete()
  end
  if self.heroSortList ~= nil then
    self.heroSortList:Delete()
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UINFactoryHeroList
