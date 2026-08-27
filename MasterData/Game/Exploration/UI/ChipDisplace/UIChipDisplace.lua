local UIChipDisplace = class("UIChipDisplace", UIBaseWindow)
local base = UIBaseWindow
local UINChipDisplaceItem = require("Game.Exploration.UI.ChipDisplace.UINChipDisplaceItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")
local cs_tweening = CS.DG.Tweening

function UIChipDisplace:OnInit()
  self.chipList = {}
  self.chipItemDic = {}
  self.selectIndex = 1
  self.chipDetail = UINChipDetailPanel.New()
  self.chipDetail:Init(self.ui.uINChipItemDetail)
  self.__OnClickChipItem = BindCallback(self, self.OnClickChipItem)
  self.__OnClickDetail = BindCallback(self, self.OnClickDetail)
  self.resloader = CS.ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.OnClickSkip)
  UIUtil.AddButtonListener(self.ui.btn_Displace, self, self.OnClickDisplace)
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.OnClickMap)
  self.ui.chipList.onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  self.ui.chipList.onChangeItem = BindCallback(self, self.OnChangeItem)
end

function UIChipDisplace:InitChipDisplace(remainCount, isAllDisplace, epCtr)
  self.ui.btn_Map.gameObject:SetActive(ExplorationManager:HasRoomSceneInEp())
  self.epCtr = epCtr
  self.remainCount = remainCount
  self.isAllDisplace = isAllDisplace
  self:SwitchDisplaceStateUI(isAllDisplace)
  self:RefreshChipItemsUI()
  self:RefreshChipItemDetail()
  self:RefreshBtnDisplaceState()
  self.ui.frameNode:SetActive(true)
end

function UIChipDisplace:SwitchDisplaceStateUI(isAllDisplace)
  self.ui.maxRefresh:SetActive(not isAllDisplace)
  self.ui.tips:SetActive(isAllDisplace)
  local idx = isAllDisplace and 0 or 1
  self.ui.tex_Displace:SetIndex(idx)
end

function UIChipDisplace:RefreshChipItemsUI()
  self.chipList = {}
  self.selectIndex = 1
  local chipDic = self.epCtr.dynPlayer:GetNormalChipDic()
  for k, chipData in pairs(chipDic) do
    if not chipData:IsConsumeSkillChip() then
      table.insert(self.chipList, chipData)
    end
  end
  local listCount = #self.chipList
  self.ui.btn_Displace.gameObject:SetActive(0 < listCount)
  self.ui.tran_OnSelect.gameObject:SetActive(0 < listCount)
  if 0 < listCount then
    self.chipList = ExplorationManager:SortChipDataList(self.chipList, true)
  end
  self.selectIndex = 1
  self.ui.chipList:ClearCells()
  self.ui.chipList.totalCount = #self.chipList
  self.ui.chipList:RefillCells()
  self.ui.tex_maxRefresh:SetIndex(0, tostring(self.remainCount))
end

function UIChipDisplace:RefreshChipItemDetail()
  for k, v in pairs(self.chipItemDic) do
    v:SetItemSelectState(self.isAllDisplace, v.idx == self.selectIndex)
    if v.idx == self.selectIndex then
      self:SetSelectFrame(v.transform)
    end
  end
  if self.isAllDisplace then
    self.chipDetail:OnSelectChipChanged(false)
  else
    self.chipDetail:OnSelectChipChanged(self.remainCount > 0)
  end
  self:_SetCantDisplacesActive(self.remainCount == 0)
  local selectData = self.chipList[self.selectIndex]
  if selectData ~= nil then
    self.chipDetail:Show()
    self.chipDetail:InitEpChipDetail(nil, selectData, self.epCtr.dynPlayer, self.resloader, true, eChipDetailPowerType.None, true)
  else
    self.chipDetail:Hide()
  end
end

function UIChipDisplace:_SetCantDisplacesActive(active)
  for _, v in ipairs(self.ui.cantDisplaceArr) do
    v:SetActive(active)
  end
end

function UIChipDisplace:UpdateDiff()
  self.remainCount = self.remainCount - 1
  self.ui.tex_maxRefresh:SetIndex(0, tostring(self.remainCount))
  if self.isAllDisplace then
    self:RefreshChipItemsUI()
    self:RefreshChipItemDetail()
    self:RefreshBtnDisplaceState()
    local localItemList = {}
    for i, v1 in ipairs(self.chipList) do
      for k, v2 in pairs(self.chipItemDic) do
        if v2.chipData == v1 then
          table.insert(localItemList, v2)
        end
      end
    end
    self:PlayAllDisplaceTween(localItemList)
    return
  end
  local remData = self.chipList[self.selectIndex]
  local addData
  local allData = self.epCtr.dynPlayer:GetNormalChipDic()
  for k, v1 in pairs(allData) do
    if not v1:IsConsumeSkillChip() then
      for i, v2 in ipairs(self.chipList) do
        if v1.chipCfg.id == v2.chipCfg.id then
          goto lbl_76
        end
      end
      addData = v1
      break
    end
    ::lbl_76::
  end
  if addData ~= nil then
    self.chipList[self.selectIndex] = addData
    for k, v in pairs(self.chipItemDic) do
      if v.chipData == remData then
        v:InitItem(self.selectIndex, addData, self.__OnClickChipItem)
        self:RefreshChipItemDetail()
        self:PlayAllDisplaceTween({v})
        break
      end
    end
  end
  self:RefreshBtnDisplaceState()
end

function UIChipDisplace:RefreshBtnDisplaceState()
  local inRoom = self.ui.frameNode.activeInHierarchy
  self.ui.tex_MapBtnName:SetIndex(inRoom and 0 or 1)
end

function UIChipDisplace:OnClickMap()
  self.ui.frameNode:SetActive(not self.ui.frameNode.activeInHierarchy)
  self:RefreshBtnDisplaceState()
end

function UIChipDisplace:OnClickSkip()
  self.epCtr:SendExitChipReplace()
end

function UIChipDisplace:OnClickDisplace()
  if self.isAllDisplace then
    self:OnClickAllDisplace()
  else
    self:OnClickDetail()
  end
end

function UIChipDisplace:OnClickAllDisplace()
  if self.remainCount > 0 then
    local showingWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    showingWindow:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(TipContent.ChipReplaceAll), function()
      self.epCtr:SendChipReplace(0)
    end, nil)
  else
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.ChipReplaceNotCount))
  end
end

function UIChipDisplace:OnClickDetail()
  local selectData = self.chipList[self.selectIndex]
  if selectData == nil then
    return
  end
  if self.remainCount > 0 then
    self.epCtr:SendChipReplace(selectData.chipCfg.id)
  else
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.ChipReplaceNotCount))
  end
end

function UIChipDisplace:OnInstantiateItem(go)
  local item = UINChipDisplaceItem.New()
  item:Init(go)
  self.chipItemDic[go] = item
end

function UIChipDisplace:OnChangeItem(go, index)
  local item = self.chipItemDic[go]
  if item == nil then
    error("UIChipDisplace Can`t Find Item")
    return
  end
  local data = self.chipList[index + 1]
  if data == nil then
    error("UIChipDisplace Can`t Find Data")
    return
  end
  item:InitItem(index + 1, data, self.__OnClickChipItem)
end

function UIChipDisplace:OnClickChipItem(idx)
  if self.selectIndex ~= idx then
    self.selectIndex = idx
    self:RefreshChipItemDetail()
  end
end

function UIChipDisplace:SetSelectFrame(transform)
  self.ui.tran_OnSelect:SetParent(transform)
  self.ui.tran_OnSelect.localPosition = Vector3.zero
end

function UIChipDisplace:PlayAllDisplaceTween(itemList)
  local duration = 0.15
  if self.pageSequence ~= nil then
    self.pageSequence:Kill(true)
  end
  self.pageSequence = cs_tweening.DOTween.Sequence()
  for index, childData in ipairs(itemList) do
    local num = 0
    if index < 5 then
      num = num + 1
    else
      num = 1
    end
    local over = num % 5
    self.pageSequence:Join(childData.ui.tran:DOLocalMoveY(20, duration):SetLoops(2, cs_tweening.LoopType.Yoyo):SetRelative(true):SetDelay(index * 0.01))
    self.pageSequence:Join(childData.ui.canvasGroup:DOFade(0.4, duration):SetLoops(2, cs_tweening.LoopType.Yoyo):SetDelay(over * 0.01))
  end
  self.pageSequence:SetEase(cs_tweening.Ease.Linear)
end

function UIChipDisplace:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.pageSequence ~= nil then
    self.pageSequence:Kill(true)
  end
  if self.chipItemDic ~= nil then
    for k, v in pairs(self.chipItemDic) do
      v:Delete()
    end
    self.chipItemDic = nil
  end
  self.chipDetail:OnDelete()
  base.OnDelete(self)
end

return UIChipDisplace
