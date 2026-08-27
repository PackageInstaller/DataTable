local UIFairyFormation = class("UIFairyFormation", UIBaseWindow)
local base = UIBaseWindow
local UINFairyFormationCardItem = require("Game.Fairy.UI.Formation.UINFairyFormationCardItem")
local UINFairyInfo = require("Game.CommonUI.Fairy.UINFairyInfo")
local FormationUtil = require("Game.Formation.FormationUtil")
local FairyHelper = require("Game.Fairy.FairyHelper")
local UINFairyTopFilterNode = require("Game.Fairy.UI.Common.UINFairyTopFilterNode")
local UINFairySiftCondition = require("Game.Fairy.UI.ListFilter.UINFairySiftCondition")
local FairyFilterEnum = require("Game.Fairy.UI.ListFilter.FairyFilterEnum")
local FairySiftAndOrederUtil = require("Game.Fairy.FairySiftAndOrederUtil")
local FmtEnum = require("Game.Formation.FmtEnum")
local eFairyEnum = require("Game.Fairy.eFairyEnum")
local JumpManager = require("Game.Jump.JumpManager")

function UIFairyFormation:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, false)
  UIUtil.AddButtonListener(self.ui.btn_Details, self, self._OnClickShowDetail)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self._OnClickClose)
  self._onFairyItemClicked = BindCallback(self, self._OnFairyItemClicked)
  self.filterTopNode = UINFairyTopFilterNode.New()
  self.filterTopNode:Init(self.ui.sortAndFilterTop)
  self.infoNode = UINFairyInfo.New()
  self.infoNode:Init(self.ui.uINFairyInfoWindow)
  self.ui.fairyList.onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  self.ui.fairyList.onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self.fairyItemDic = {}
  self.curSelectedFairyUID = nil
  self.__onFairySortTypeChangeAction = BindCallback(self, self.OnFairySortTypeChangeAction)
  self.__onBtnFairyFilterClick = BindCallback(self, self.OnBtnFairyFilterClick)
  self.__onFairyUpdate = BindCallback(self, self.__OnFairyUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateFairy, self.__onFairyUpdate)
end

function UIFairyFormation:InitSelectFairy()
  self.fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  if self.fmtCtrl == nil then
    return
  end
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  local fairyUID = formationData:GetFmtFairyUID()
  self.curSelectedFairyUID = fairyUID
  self:RefreshFairyDetailBtn()
  self.filterTopNode:InitFairyTopFilterNode(self.__onBtnFairyFilterClick, self.__onFairySortTypeChangeAction)
  self:RefreshSelectedFairyDetail()
  self:PlayFairyFormationCardItemListAnim()
end

function UIFairyFormation:RefreshAllFairyItem()
  local fairtyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
  local fairyDataDic = fairtyCtrl:GetFairyDataDic()
  self.fairyDataDic = fairyDataDic
  if table.count(self.fairyDataDic) == 0 then
    self.ui.fairyList.gameObject:SetActive(false)
    self.ui.emptyList:SetActive(true)
  else
    self.ui.fairyList.gameObject:SetActive(true)
    self.ui.emptyList:SetActive(false)
  end
  local enterFmtData = self.fmtCtrl:GetCurEnterFmtData()
  if enterFmtData:IsFmtInWarChessDeploy() then
    local AllFmtIdDic = {}
    local idOffset = FormationUtil.GetFmtIdOffsetByFmtFromModule(enterFmtData:GetFmtCtrlFromModule())
    local curFmtId = enterFmtData:GetFmtCtrlFmtId()
    local max = enterFmtData:GetFmtTeamSize()
    for i = 1, max do
      local fmtId
      if enterFmtData:IsFmtFixedCouldChangeTeam() then
        fmtId = enterFmtData:GetFmtFixedChangeTeamFmtId(i)
      end
      if fmtId == nil then
        fmtId = idOffset + i
      end
      if fmtId ~= curFmtId then
        AllFmtIdDic[i] = fmtId
      end
    end
    self.otherFmtFairyUIDDic = {}
    for index, fmtId in pairs(AllFmtIdDic) do
      local fmtData = self.fmtCtrl:GetOtherFormationData(fmtId)
      if fmtData ~= nil then
        local fairyUID = fmtData:GetFmtFairyUID(false)
        if fairyUID ~= nil then
          self.otherFmtFairyUIDDic[fairyUID] = true
        end
      end
    end
  end
  local fairyDataList = {}
  for _, fairyData in pairs(fairyDataDic) do
    if self.shiftFunc == nil or self.shiftFunc(fairyData) then
      table.insert(fairyDataList, fairyData)
    end
  end
  if self.sortFunc == nil then
    FairyHelper.FairyCommonSort(fairyDataList)
  else
    table.sort(fairyDataList, self.sortFunc)
  end
  local bannedFairyDic
  if enterFmtData:GetFmtCtrlFromModule() == FmtEnum.eFmtFromModule.CardSet then
    bannedFairyDic = enterFmtData:GetCardSetTempBannedFairyDic()
  end
  self.uid2CurItemDic = {}
  self.fairyDataList = fairyDataList
  self.bannedFairyDic = bannedFairyDic
  self.ui.fairyList.totalCount = #fairyDataList
  self.ui.fairyList:RefillCells()
end

function UIFairyFormation:m_OnNewItem(go)
  local item = UINFairyFormationCardItem.New()
  item:Init(go)
  self.fairyItemDic[go] = item
end

function UIFairyFormation:m_OnChangeItem(go, index)
  local item = self.fairyItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local fairyData = self.fairyDataList[index + 1]
  if fairyData == nil then
    error("Can't find fairyData by index, index = " .. tostring(index))
  end
  local resloader = self.fmtCtrl:GetFmtCtrlResloader()
  local uid = fairyData:GetFairyUID()
  local isCardSetUsed = self.bannedFairyDic ~= nil and self.bannedFairyDic[uid]
  local isWCOtherTeamUsed = self.otherFmtFairyUIDDic ~= nil and self.otherFmtFairyUIDDic[uid]
  local enterFmtData = self.fmtCtrl:GetCurEnterFmtData()
  local isDailyWasted
  local fmtDungeonDyncData = enterFmtData:GetFmtDungeonDyncData()
  if fmtDungeonDyncData ~= nil then
    isDailyWasted = fmtDungeonDyncData:GetDungeonDyncIsFairyWased(uid)
  end
  item:InitFairyCultivateCardItem(fairyData, uid, resloader, self._onFairyItemClicked)
  item:FFCI_SetIsCardSetUsed(isCardSetUsed or isWCOtherTeamUsed or isDailyWasted)
  self.uid2CurItemDic[uid] = index
  if self.curSelectedFairyUID == uid then
    item:SetInteriorSelected(true)
  else
    item:SetInteriorSelected(false)
  end
end

function UIFairyFormation:m_GetItemByUID(uid)
  local index = self.uid2CurItemDic[uid]
  local go = self.ui.fairyList:GetCellByIndex(index)
  if go ~= nil then
    return self.fairyItemDic[go]
  end
  return nil
end

function UIFairyFormation:RefreshSelectedFairyDetail()
  if self.curSelectedFairyUID == nil or self.curSelectedFairyUID == 0 then
    self.infoNode:Hide()
  else
    self.infoNode:Show()
    self.infoNode:SetCloseCardInfoSize(self.ui.btn_bg.transform)
    local fairyData = self.fairyDataDic[self.curSelectedFairyUID]
    if fairyData == nil then
      self.curSelectedFairyUID = nil
      self.infoNode:Hide()
      return
    end
    self.infoNode:InitCommonFairyInfo(fairyData)
  end
end

function UIFairyFormation:RefreshFairyDetailBtn()
  local fairtyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
  local isHaveFairy = fairtyCtrl:GetPlayerHaveFairy()
  self.ui.btn_Details.gameObject:SetActive(isHaveFairy)
end

function UIFairyFormation:OnBtnFairyFilterClick()
  if self.siftConditionNode == nil then
    local siftConditionNode = UINFairySiftCondition.New()
    siftConditionNode:Init(self.ui.firyShiftConditionNode)
    siftConditionNode:InitFairySiftCondition(FairyFilterEnum.eKindType, FairyFilterEnum.eKindMaxCount, BindCallback(self, self.OnFairyFilterConfirmAction), nil, BindCallback(self, self.CheckFairyFilterCanConfirm))
    self.siftConditionNode = siftConditionNode
  end
  self.siftConditionNode:Show()
  self.siftConditionNode:SetSortKindData(self.sortKindData)
end

function UIFairyFormation:OnFairySortTypeChangeAction(sortFunc)
  self.sortFunc = sortFunc
  self:RefreshAllFairyItem()
end

function UIFairyFormation:OnFairyFilterConfirmAction(sortKindData)
  self.sortKindData = sortKindData
  local shiftFunc = FairySiftAndOrederUtil.BuildSiftFuncWith(sortKindData)
  self.shiftFunc = shiftFunc
  self:RefreshAllFairyItem()
end

function UIFairyFormation:CheckFairyFilterCanConfirm(sortKindData)
  local shiftFunc = FairySiftAndOrederUtil.BuildSiftFuncWith(sortKindData)
  for key, fairyData in pairs(self.fairyDataDic) do
    if shiftFunc(fairyData) then
      return true
    end
  end
  return false
end

function UIFairyFormation:_OnFairyItemClicked(uid, isForce)
  if uid == self.curSelectedFairyUID and not isForce then
    local item = self:m_GetItemByUID(uid)
    if item ~= nil then
      item:SetInteriorSelected(false)
    end
    self.curSelectedFairyUID = nil
    self:RefreshSelectedFairyDetail()
    return
  end
  if self.curSelectedFairyUID ~= nil and self.curSelectedFairyUID ~= 0 then
    local oldSelectItem = self:m_GetItemByUID(self.curSelectedFairyUID)
    if oldSelectItem ~= nil then
      oldSelectItem:SetInteriorSelected(false)
    end
  end
  local item = self:m_GetItemByUID(uid)
  if item ~= nil then
    item:SetInteriorSelected(true)
  end
  self.curSelectedFairyUID = uid
  self:RefreshSelectedFairyDetail()
end

function UIFairyFormation:_OnClickShowDetail()
  local fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
  if fairyCtrl ~= nil then
    fairyCtrl:EnterFairyCultivate(function()
      self.fmtCtrl.fmtSceneCtrl:SetFormationCameraActive(false)
    end, function()
      if JumpManager.isJumping then
        return
      end
      self.fmtCtrl.fmtSceneCtrl:SetFormationCameraActive(true)
      if fairyCtrl:GetFairyDataByUID(self.curSelectedFairyUID) == nil then
        self.curSelectedFairyUID = nil
        local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
        formationData:SetFmtFairyUID(nil)
        MsgCenter:Broadcast(eMsgEventId.OnFmtFairyChange)
      end
      self:RefreshAllFairyItem()
      self:RefreshFairyDetailBtn()
    end, self.curSelectedFairyUID, eFairyEnum.ShowFaiyType.CultivateShow)
  end
end

function UIFairyFormation:_OnClickConfirm()
  if self.curSelectedFairyUID ~= nil then
    local isWCOtherTeamUsed = self.otherFmtFairyUIDDic ~= nil and self.otherFmtFairyUIDDic[self.curSelectedFairyUID]
    if isWCOtherTeamUsed then
      return
    end
    local enterFmtData = self.fmtCtrl:GetCurEnterFmtData()
    local isDailyWasted
    local fmtDungeonDyncData = enterFmtData:GetFmtDungeonDyncData()
    if fmtDungeonDyncData ~= nil then
      isDailyWasted = fmtDungeonDyncData:GetDungeonDyncIsFairyWased(self.curSelectedFairyUID)
    end
    if isDailyWasted then
      return
    end
  end
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  formationData:SetFmtFairyUID(self.curSelectedFairyUID)
  self:_OnClickClose()
end

function UIFairyFormation:_OnClickClose()
  MsgCenter:Broadcast(eMsgEventId.OnFmtFairyChange)
  UIUtil.OnClickBackByUiTab(self)
end

function UIFairyFormation:PlayFairyFormationCardItemListAnim()
  for i, item in pairs(self.fairyItemDic) do
    if not IsNull(item) then
      local index = self.uid2CurItemDic[item.fairyCardItem:GetFairyCultivateCardIndex()]
      item.fairyCardItem:PlayFairyCultivateCardAnim(index * 0.04 + 0.25)
    end
  end
end

function UIFairyFormation:__OnFairyUpdate()
  if self.fairyDataDic[self.curSelectedFairyUID] == nil then
    self.curSelectedFairyUID = nil
    local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
    formationData:SetFmtFairyUID(self.curSelectedFairyUID)
  end
  self:RefreshAllFairyItem()
  self:RefreshSelectedFairyDetail()
  MsgCenter:Broadcast(eMsgEventId.OnFmtFairyChange)
end

function UIFairyFormation:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateFairy, self.__onFairyUpdate)
  if self.filterTopNode ~= nil then
    self.filterTopNode:Delete()
  end
  self.filterTopNode = nil
  if self.infoNode ~= nil then
    self.infoNode:Delete()
    self.infoNode = nil
  end
  if self.itemPool ~= nil then
    self.itemPool:DeleteAll()
    self.itemPool = nil
  end
  base.OnDelete(self)
end

return UIFairyFormation
