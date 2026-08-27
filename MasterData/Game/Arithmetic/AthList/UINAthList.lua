local UINAthList = class("UINAthList", UIBaseNode)
local base = UIBaseNode
local UINAthListArea = require("Game.Arithmetic.AthList.Area.UINAthListArea")
local AthSortEnum = require("Game.Arithmetic.AthList.Sort.AthSortEnum")
local UINAthListSort = require("Game.Arithmetic.AthList.Sort.UINAthListSort")
local UINAthListToggle = require("Game.Arithmetic.AthList.UINAthListToggle")
local UINAthListSuit = require("Game.Arithmetic.AthList.Suit.UINAthListSuit")
local UINAthListAreaTog = require("Game.Arithmetic.AthList.Area.UINAthListAreaTog")
local UINAthUsingRate = require("Game.Arithmetic.UsingRate.UINAthUsingRate")
local AthUtil = require("Game.Arithmetic.AthUtil")
local CS_DoTween = CS.DG.Tweening.DOTween
local CS_ResLoader = CS.ResLoader
local spaceIdDic = {
  [1] = 1,
  [2] = 2,
  [4] = 3,
  [8] = 4
}

function UINAthList:ctor(isConsumeAth)
  self.isConsumeAth = isConsumeAth
  self._reverseSortOrder = not isConsumeAth
end

function UINAthList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self:_RefreshReverseSort()
  UIUtil.AddButtonListener(self.ui.btn_Sort, self, self.OnClickSort)
  UIUtil.AddButtonListener(self.ui.btn_Decompose, self, self._OnClickDecompose)
  UIUtil.AddButtonListener(self.ui.btn_Dteail, self, self._OnClickDetail)
  UIUtil.AddButtonListener(self.ui.btn_SortReverse, self, self._OnClickReverseSort)
  UIUtil.AddButtonListener(self.ui.btn_SelectAll, self, self._OnClickSelectAll)
  self.__OnClickAthItem = BindCallback(self, self.OnClickAthItem)
  self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdate)
  self.__OnAthItemDetailShow = BindCallback(self, self._OnAthItemDetailShow)
  self.athListArea = UINAthListArea.New()
  self.athListArea:Init(self.ui.areaNode)
  self.athListArea.athScrollList:SetAthScrollListEmptyFunc(BindCallback(self, self.ShowAthListEmpty))
  self.athListSortNode = UINAthListSort.New()
  self.athListSortNode:Init(self.ui.sortDropdown)
  self.athListSortNode:InitAthListSort(self, self.isConsumeAth)
  self.athListSortNode:Hide()
  self.athListSuit = UINAthListSuit.New()
  self.athListSuit:Init(self.ui.suitNode)
  self.athListSuit:Hide()
  self.togArea = UINAthListToggle.New()
  self.togArea:Init(self.ui.tog_Area)
  self.togArea:InitAthListToggle(BindCallback(self, self._OnSelectAreaTog))
  self.togSuit = UINAthListToggle.New()
  self.togSuit:Init(self.ui.tog_Suit)
  self.togSuit:InitAthListToggle(BindCallback(self, self._OnSelectSuitTog))
  self.__onAthListAreaSelect = BindCallback(self, self.__OnAreaSelect)
  self.ui.tog_AreaItem:SetActive(false)
  self.areaTogList = UIItemPool.New(UINAthListAreaTog, self.ui.tog_AreaItem)
  for i = 0, ConfigData.game_config.athSlotCount do
    local togItem = self.areaTogList:GetOne()
    togItem:InitAthListAreaTog(i, self.__onAthListAreaSelect)
  end
  local fecomposeUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_Decompose)
  self:ShowAthListDecomposeBtn(fecomposeUnlock)
  self.ui.tex_TogArea:SetIndex(0)
end

function UINAthList:InitAthListNode(heroData, resLoader, withMat, clickItemFunc, areaId, quality, changeAreaFunc, ignoreInstalled, withSuitNode)
  self.heroData = heroData
  self.clickItemFunc = clickItemFunc
  self.resLoader = resLoader
  self.changeAreaFunc = changeAreaFunc
  if withSuitNode then
    self.togSuit:Show()
  else
    self.togSuit:Hide()
  end
  self:SetAthListArea(areaId)
  if self.suitNodeIsShow then
    self:_ShowListSuit()
    return
  end
  self.ui.img_Select:SetIndex(PlayerDataCenter.allAthData:IsAthItemAttrShow() and 1 or 0)
  self.withMat = withMat
  AthSortEnum.SetAthSortKindParam(self._sortKindValue, self._reverseSortOrder, self.heroData.dataId)
  self.athListArea.athScrollList:SetAthScrollListSortFunc(self._sortFunc)
  self.athListArea:InitAthListArea(heroData, areaId, quality, self.__OnClickAthItem, self.__itemStartDragFunc, resLoader, withMat, changeAreaFunc, ignoreInstalled)
  self:_ShowAreaTog(areaId)
end

function UINAthList:SetAthListArea(areaId)
  self.areaId = areaId
  local showUsingRate = self._showUsingRate and areaId ~= nil
  if self.athUsingRateNode then
    if showUsingRate then
      self.athUsingRateNode:Show()
    else
      self.athUsingRateNode:Hide()
    end
  else
    self.ui.athUsingRate:SetActive(showUsingRate)
  end
end

function UINAthList:_ShowAreaTog(areaId)
  local selecteTogItem = self.areaTogList.listItem[(areaId or 0) + 1]
  self.ui.areaTogGroup:SetAllTogglesOff()
  selecteTogItem:SetAthListAreaTogIsOn()
end

function UINAthList:ShowAthListUsingRate()
  self._showUsingRate = true
  if self.athUsingRateNode == nil then
    local athUsingRate = UINAthUsingRate.New()
    athUsingRate:Init(self.ui.athUsingRate)
    athUsingRate:InitAthUsingRate(BindCallback(self, self._ShowUsingRateWin))
    self.athUsingRateNode = athUsingRate
  end
  self.athUsingRateNode:Show()
end

function UINAthList:_ShowUsingRateWin()
  self.athUsingRateNode:ShowAthUsingRateDetail(self.heroData, self.areaId)
end

function UINAthList:ShowAthListDecomposeBtn(show)
  self.ui.btn_Decompose.gameObject:SetActive(show)
end

function UINAthList:EnableAthListDecomposeMode()
  self.ui.areaTogGroup.gameObject:SetActive(false)
  self.athListArea:SetAthListAreaScrollTop(-20)
  self.ui.tex_TogArea:SetIndex(1)
  self:ShowAthListDecomposeBtn(false)
end

function UINAthList:SetAthItemStartDragFunc(itemStartDragFunc)
  self.__itemStartDragFunc = itemStartDragFunc
end

function UINAthList:OnAthDataUpdate()
  if not self.active then
    return
  end
  if self.athListArea.active then
    self.athListArea.athScrollList:RefreshAthScrollListData()
    self:RefillCurAthSortList(true)
  end
  if self.athListSuit.active then
    self.athListSuit:RefreshAthListSuit()
  end
end

function UINAthList:RefillCurAthSortList(useLastPos)
  AthSortEnum.SetAthSortKindParam(self._sortKindValue, self._reverseSortOrder, self.heroData.dataId)
  self.athListArea.athScrollList:RefillAthScrollList(nil, self._sortFunc, useLastPos)
end

function UINAthList:OnClickAthItem(athItem)
  if self.clickItemFunc ~= nil then
    self.clickItemFunc(athItem)
  end
end

function UINAthList:GetAthItemGo(space)
  local index = spaceIdDic[space]
  if index == nil then
    error("Can't get athItemGo, space = " .. tostring(space))
    return
  end
  return self.athListArea.athScrollList.ui.athSpaceItemList[index]
end

function UINAthList:_OnClickDecompose()
  UIManager:ShowWindowAsync(UIWindowTypeID.AthDecompose, function(window)
    if window == nil or IsNull(self.gameObject) then
      return
    end
    self:Hide()
    window:InitAthDecompose(self.heroData, self.resLoader, function()
      if IsNull(self.gameObject) then
        return
      end
      self:Show()
      self:OnAthDataUpdate()
      self.ui.img_Select:SetIndex(PlayerDataCenter.allAthData:IsAthItemAttrShow() and 1 or 0)
    end)
  end)
end

function UINAthList:OnClickSort()
  AudioManager:PlayAudioById(1069)
  self.athListSortNode:ShowAthListSort()
end

function UINAthList:DragInAthSortList(worldPos)
  local anchordPos = UIManager:World2UIPosition(worldPos, self.transform, nil, UIManager.UICamera)
  if anchordPos.x <= self.transform.rect.xMax then
    return true
  end
  return false
end

function UINAthList:OnShow()
  self:SetAthSortListTween()
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnAthItemDetailShow, self.__OnAthItemDetailShow)
end

function UINAthList:OnHide()
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnAthItemDetailShow, self.__OnAthItemDetailShow)
  UIManager:HideWindow(UIWindowTypeID.RichIntro)
end

function UINAthList:SetAthSortListTween()
  local moveX = 100
  local pageLocalPos = self.transform.localPosition
  pageLocalPos = Vector3.New(pageLocalPos.x - moveX, pageLocalPos.y, pageLocalPos.z)
  self.transform.localPosition = pageLocalPos
  self.ui.fade.alpha = 0.4
  if self.sequence == nil then
    local sequence = CS_DoTween.Sequence()
    sequence:Append(self.transform:DOLocalMoveX(moveX, 0.3):SetRelative(true))
    sequence:Join(self.ui.fade:DOFade(1, 0.3))
    sequence:SetAutoKill(false)
    self.sequence = sequence
  else
    self.sequence:Restart()
  end
end

function UINAthList:GetAthItemFromList(uid)
  return self.athListArea.athScrollList:GetAthItemFromListAll(uid)
end

function UINAthList:ChangeAthListSort(kindType, kindValue, name, isInit)
  self.ui.tex_Sort.text = name
  self._sortKindValue = kindValue
  self._sortFunc = AthSortEnum.GetSortFunc(kindType, self.isConsumeAth)
  if not isInit then
    self:RefillCurAthSortList()
  end
end

function UINAthList:_ShowSortBtn(isOn)
  self.ui.btn_Sort.gameObject:SetActive(isOn)
  self.ui.btn_SortReverse.gameObject:SetActive(isOn)
end

function UINAthList:_OnSelectAreaTog(isOn)
  if self._areaTogIsShow == isOn then
    return
  end
  self._areaTogIsShow = isOn
  self:_ShowSortBtn(isOn)
  if isOn then
    if self.showSuitAth then
      self:_Return2SuitNode(true, true)
    end
    self.athListArea:Show()
    self:_ShowAreaTog(self.areaId)
  else
    self.athListArea:Hide()
  end
end

function UINAthList:_OnSelectSuitTog(isOn)
  if self.suitNodeIsShow == isOn then
    return
  end
  self.suitNodeIsShow = isOn
  if isOn then
    if self.showSuitAth then
      self:_Return2SuitNode(true)
      return
    end
    self:_ShowListSuit()
  else
    self.athListSuit:Hide()
  end
end

function UINAthList:_ShowListSuit()
  if self.showSuitAth then
    self:_Return2SuitNode(true)
  end
  self.athListSuit:Show()
  self.athListSuit:InitAthListSuit(self, self.heroData, self.resLoader)
  self:_ShowAreaTog(self.areaId)
end

function UINAthList:ShowAthListSuitAth(suitId)
  UIUtil.SetTopStatus(self, self._Return2SuitNode, nil, AthUtil.ShowATHInfoFunc)
  self.athListSuit:Hide()
  self.athListArea:Show()
  self:_ShowSortBtn(true)
  self:ShowAthListAreaTogs(false)
  self.athListArea:ShowAthListAreaSuitPartTog(true, suitId)
  self.showSuitAth = true
end

function UINAthList:_Return2SuitNode(popFunc, withoutSuit)
  if popFunc then
    UIUtil.PopFromBackStackByUiTab(self)
  end
  if not withoutSuit then
    self.athListSuit:Show()
    self.athListSuit:RefreshAthListSuit()
    self:_ShowSortBtn(false)
  end
  self.athListArea:Hide()
  self.athListArea.athScrollList:SetAthScrollListSuitId(nil)
  AthSortEnum.SetAthSortKindParam(self._sortKindValue, self._reverseSortOrder, self.heroData.dataId)
  self.athListArea.athScrollList:SetAthScrollListSortFunc(self._sortFunc)
  self:ShowAthListAreaTogs(true)
  self.athListArea:ShowAthListAreaSuitPartTog(false)
  self.showSuitAth = false
end

function UINAthList:__OnAreaSelect(areaId)
  if areaId == 0 then
    areaId = nil
  end
  self:ChangeAthListArea(areaId)
  if self.changeAreaFunc ~= nil then
    self.changeAreaFunc(areaId)
  end
end

function UINAthList:ShowAthListAreaTogs(show)
  self.ui.cg_areaTogGroup.alpha = show and 1 or 0
  self.ui.cg_areaTogGroup.interactable = show
end

function UINAthList:ChangeAthListArea(areaId)
  if self.suitNodeIsShow then
    self.athListSuit:SetAthListSuitArea(areaId)
  else
    self.athListArea.athScrollList:SetAthScrollListArea(areaId)
    self.athListArea.athScrollList:RefreshAthScrollListData()
    self.athListArea.athScrollList:RefillAthScrollList()
  end
end

function UINAthList:SelectAthListSuit(athSuitId)
  if self.showSuitAth then
    UIUtil.OnClickBackByUiTab(self)
  end
  self.togSuit:SetAthListTogSelect(true)
  self.athListSuit:SetAthListSuitSelectedSuitId(athSuitId)
  self.athListSuit:RefreshAthListSuit(true, athSuitId)
end

function UINAthList:_OnClickDetail(isOn)
  PlayerDataCenter.allAthData:SetAthItemAttrShow(not PlayerDataCenter.allAthData:IsAthItemAttrShow())
end

function UINAthList:_OnClickReverseSort()
  self._reverseSortOrder = not self._reverseSortOrder
  self:_RefreshReverseSort()
  self:RefillCurAthSortList()
end

function UINAthList:_RefreshReverseSort()
  self.ui.img_Ascend:SetActive(not self._reverseSortOrder)
  self.ui.img_Descend:SetActive(self._reverseSortOrder)
end

function UINAthList:_OnAthItemDetailShow()
  if not self.active then
    return
  end
  local show = PlayerDataCenter.allAthData:IsAthItemAttrShow()
  self.ui.img_Select:SetIndex(show and 1 or 0)
  if self.athListArea.active then
    self:RefillCurAthSortList(true)
  end
end

function UINAthList:SetAthListSelectAllFunc(selectAllFunc)
  self.selectAllFunc = selectAllFunc
  self.ui.btn_SelectAll.gameObject:SetActive(true)
end

function UINAthList:_OnClickSelectAll()
  if self.selectAllFunc ~= nil then
    self.selectAllFunc()
  end
end

function UINAthList:ShowAthListEmpty(isShow)
  self.ui.emptyNode:SetActive(isShow)
end

function UINAthList:OnDelete()
  self.athListArea:Delete()
  self.athListSortNode:Delete()
  self.athListSuit:Delete()
  if self.athUsingRateNode then
    self.athUsingRateNode:Delete()
  end
  self.togArea:Delete()
  self.togSuit:Delete()
  if self.sequence ~= nil then
    self.sequence:Kill()
    self.sequence = nil
  end
  base.OnDelete(self)
end

return UINAthList
