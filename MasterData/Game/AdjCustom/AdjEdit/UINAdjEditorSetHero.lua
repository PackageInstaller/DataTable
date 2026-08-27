local UINAdjEditorSetHero = class("UINAdjEditorSetHero", UIBaseNode)
local base = UIBaseNode
local UINAdjEditorSetHeroIcon = require("Game.AdjCustom.AdjEdit.UINAdjEditorSetHeroIcon")
local UINSortButtonGroup = require("Game.Hero.NewUI.SortList.UINSortButtonGroup")
local HeroSortEnum = require("Game.Hero.NewUI.HeroSortEnum")
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
local UINAdjCareerFilterItem = require("Game.AdjCustom.AdjEdit.UINAdjCareerFilterItem")
local CS_UnityEngine_GameObject = CS.UnityEngine.GameObject
local CS_ResLoader = CS.ResLoader
local CS_MessageCommon = CS.MessageCommon

function UINAdjEditorSetHero:OnInit()
  self._isInInit = true
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.__OnClickCancle)
  UIUtil.AddButtonListener(self.ui.btn_Filter, self, self.__OnClickFilter)
  UIUtil.AddButtonListener(self.ui.btn_close_filter, self, self.__OnClickCloseFilter)
  self.ui.img_HeadItemSel.gameObject:SetActive(false)
  self._sortFunc = nil
  self._sortBtnGroup = UINSortButtonGroup.New()
  self._sortBtnGroup:Init(self.ui.sortButtonGroup)
  self._sortBtnGroup:InitSortButtonGroup(HeroSortEnum.SortMannerDefine, BindCallback(self, self.__OnClickSort), HeroSortEnum.eSortResource.adjSelect, {
    [1] = HeroSortEnum.eSortMannerType.Rank,
    [2] = HeroSortEnum.eSortMannerType.GetOrder
  })
  self.__OnClickHeadItemCallback = BindCallback(self, self.__OnClickHeadItem)
  self.ui.heroHeadList.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.heroHeadList.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.heroHeadList.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self._heroList = {}
  self._heroHeadDic = {}
  self._heroGoDic = {}
  self.__SetFilterCallback = BindCallback(self, self.__SetFilter)
  self._careerFilterPool = UIItemPool.New(UINAdjCareerFilterItem, self.ui.sortKindItem)
  self.ui.sortKindItem.gameObject:SetActive(false)
  local careerCount = HeroFilterEnum.eKindMaxCount[HeroFilterEnum.eKindType.Career]
  for i = 1, careerCount do
    local item = self._careerFilterPool:GetOne()
    item:InitAdjCareerFilterItem(i, self.__SetFilterCallback)
  end
  self.ui.sortConditionNode:SetActive(false)
  self._defaultConfirmColor = self.ui.img_confirm.color
end

function UINAdjEditorSetHero:InitUINAdjEditorSetHero(editMain)
  self._editMain = editMain
  self._isInInit = nil
end

function UINAdjEditorSetHero:UpdateUINAdjEditorSetHero()
  local modifyIndex = self._editMain:GetAdjModifyIndex()
  self.ui.sortConditionNode:SetActive(false)
  self._filterCareer = nil
  for _, item in ipairs(self._careerFilterPool) do
    item:SetSelectState(false)
  end
  self:__CreateSortList()
  self:__RefreshConfirmState()
  self.ui.btn_Cancel.gameObject:SetActive(self._editMain:IsAdjCacheInModify())
  for i, v in ipairs(self._careerFilterPool.listItem) do
    v:ResetAdjCareerFilterItem()
  end
end

function UINAdjEditorSetHero:__CreateSortList()
  table.removeall(self._heroList)
  for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
    if self:__FilterHeroList(heroData) then
      table.insert(self._heroList, heroData)
    end
  end
  if self._sortFunc ~= nil then
    table.sort(self._heroList, self._sortFunc)
  else
    table.sort(self._heroList, function(a, b)
      return a.dataId < b.dataId
    end)
  end
  local total = #self._heroList
  if 0 < total then
    local selectIndexDic = self._editMain:GetAdjEditAdjIndexDic()
    local curModifyIndex = self._editMain:GetAdjModifyIndex()
    if selectIndexDic[curModifyIndex] == nil then
      local heroId = self._heroList[1].dataId
      self._editMain:SetAdjEditHero(heroId, true)
    end
  end
  self.ui.img_HeadItemSel:SetActive(false)
  self.ui.heroHeadList.totalCount = total
  self.ui.heroHeadList:RefillCells()
end

function UINAdjEditorSetHero:__OnInstantiateItem(go)
  local heroHead = UINAdjEditorSetHeroIcon.New()
  heroHead:Init(go)
  self._heroGoDic[go] = heroHead
end

function UINAdjEditorSetHero:__OnChangeItem(go, index)
  local selectIndexDic = self._editMain:GetAdjEditAdjIndexDic()
  local curModifyIndex = self._editMain:GetAdjModifyIndex()
  local heroHead = self._heroGoDic[go]
  local oriHeroId = heroHead:GetAdjHeroIconId()
  if self._heroHeadDic[oriHeroId] == heroHead then
    self._heroHeadDic[oriHeroId] = nil
    if self.ui.img_HeadItemSel.transform.parent == heroHead.transform then
      self.ui.img_HeadItemSel:SetActive(false)
    end
  end
  local heroData = self._heroList[index + 1]
  heroHead:InitAdjSetHeroIcon(heroData.dataId, self.__OnClickHeadItemCallback)
  self._heroHeadDic[heroData.dataId] = heroHead
  if selectIndexDic[curModifyIndex] == heroData.dataId then
    heroHead:SetAdjHeroIconUsedState(false)
    self.ui.img_HeadItemSel.transform:SetParent(heroHead.transform)
    self.ui.img_HeadItemSel.transform.localPosition = Vector3.zero
    self.ui.img_HeadItemSel.transform.localScale = Vector3.one
    self.ui.img_HeadItemSel:SetActive(true)
  else
    heroHead:SetAdjHeroIconUsedState(self._editMain:IsAdjHeroIdInPreset(heroData.dataId))
  end
end

function UINAdjEditorSetHero:__OnReturnItem(go)
  local heroHead = self._heroGoDic[go]
  local oriHeroId = heroHead:GetAdjHeroIconId()
  if self._heroHeadDic[oriHeroId] == heroHead then
    self._heroHeadDic[oriHeroId] = nil
  end
  if self.ui.img_HeadItemSel.transform.parent == go.transform then
    self.ui.img_HeadItemSel:SetActive(false)
  end
end

function UINAdjEditorSetHero:__OnClickSort(sortFunc)
  self._sortFunc = sortFunc
  if self._isInInit then
    return
  end
  self:__CreateSortList()
end

function UINAdjEditorSetHero:__OnClickHeadItem(heroId)
  local selectIndexDic = self._editMain:GetAdjEditAdjIndexDic()
  local curModify = self._editMain:GetAdjModifyIndex()
  local selectHead = self._heroHeadDic[heroId]
  if selectHead == nil then
    return
  end
  local heroHeadTr = selectHead.transform
  if selectIndexDic[curModify] == heroId then
    self._editMain:SetAdjEditHero(heroId, false)
    self.ui.img_HeadItemSel:SetActive(false)
  elseif not self._editMain:IsAdjHeroIdInPreset(heroId) then
    self._editMain:SetAdjEditHero(heroId, true)
    self.ui.img_HeadItemSel.transform:SetParent(heroHeadTr)
    self.ui.img_HeadItemSel.transform.localPosition = Vector3.zero
    self.ui.img_HeadItemSel.transform.localScale = Vector3.one
    self.ui.img_HeadItemSel:SetActive(true)
  end
  self:__RefreshConfirmState()
end

function UINAdjEditorSetHero:__OnClickFilter()
  self.ui.sortConditionNode:SetActive(true)
end

function UINAdjEditorSetHero:__OnClickCloseFilter()
  self.ui.sortConditionNode:SetActive(false)
end

function UINAdjEditorSetHero:__OnClickConfirm()
  local heroIndexDic = self._editMain:GetAdjEditAdjIndexDic()
  local curModifyIndex = self._editMain:GetAdjModifyIndex()
  if curModifyIndex == 1 and heroIndexDic[curModifyIndex] == nil then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(403))
    return
  end
  if curModifyIndex ~= 1 and heroIndexDic[curModifyIndex] == nil and not self._editMain:IsAdjCacheInModify() then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(403))
    return
  end
  if heroIndexDic[curModifyIndex] == nil then
    self._editMain:AdjEditJumpSubNode(self._editMain.subType.Operation)
  else
    self._editMain:AdjEditJumpSubNode(self._editMain.subType.SetSkin)
  end
end

function UINAdjEditorSetHero:__RefreshConfirmState()
  local heroIndexDic = self._editMain:GetAdjEditAdjIndexDic()
  local curModifyIndex = self._editMain:GetAdjModifyIndex()
  local canContinue = heroIndexDic[curModifyIndex] ~= nil
  canContinue = canContinue or self._editMain:IsAdjCacheInModify() and curModifyIndex ~= 1
  self.ui.img_confirm.color = canContinue and self._defaultConfirmColor or Color.gray
end

function UINAdjEditorSetHero:__OnClickCancle()
  self._editMain:ResetAdjCache()
  self._editMain:AdjEditJumpSubNode(self._editMain.subType.Operation)
end

function UINAdjEditorSetHero:__FilterHeroList(heroData)
  if self._filterCareer == nil or table.count(self._filterCareer) == 0 then
    return true
  end
  return self._filterCareer[heroData.career]
end

function UINAdjEditorSetHero:__SetFilter(index, select)
  if select then
    if self._filterCareer == nil then
      self._filterCareer = {}
    end
    self._filterCareer[index] = true
  elseif self._filterCareer ~= nil then
    self._filterCareer[index] = nil
  end
  self:__CreateSortList()
end

function UINAdjEditorSetHero:OnDelete()
  base.OnDelete(self)
end

return UINAdjEditorSetHero
