local base = UIBaseNode
local UINSESectorListNode = class("UINSESectorListNode", UIBaseNode)
local UINSESectorListNodeItem = require("Game.Sector.UISector.UISectorEntrance.Pages.Sector.UINSESectorListNodeItem")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local SectorUtil = require("Game.Sector.SectorUtil")

function UINSESectorListNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Expand, self, self.OnClickBtnExpand)
  self._OnClickSectorItemFunc = BindCallback(self, self._OnClickSectorItem)
  self.itemPool = UIItemPool.New(UINSESectorListNodeItem, self.ui.obj_sectorItem, false)
  self.sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  self.mainSectorCtrl = self.sectorCtrl:GetMainSectorCtrl()
  self.__onHasUncompletedEp = BindCallback(self, self._UpdateUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  self.__onSctStageStateChange = BindCallback(self, self._OnSctStageStateChange)
  MsgCenter:AddListener(eMsgEventId.OnSectorStageStateChange, self.__onSctStageStateChange)
  self.__onSctAvgStateChange = BindCallback(self, self._OnSctAvgStateChange)
  MsgCenter:AddListener(eMsgEventId.OnMainAvgStateChange, self.__onSctAvgStateChange)
end

function UINSESectorListNode:InitSESectorListNode()
  self.stcChaptDataDic = self.mainSectorCtrl:GetSctChapterDataDic()
  self._sctChaptItemDic = {}
  self.ui.btn_Expand.enabled = true
  self.ui.tex_title:SetIndex(1)
  self.ui.img_arrow.transform.rotation = Vector3.New(0, 0, 180)
  CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.btn_Expand.transform)
end

function UINSESectorListNode:CloseSectorBtnExpand()
  if self.isOpen then
    self:OnClickBtnExpand()
  end
  self.ui.btn_Expand.enabled = false
end

function UINSESectorListNode:RefreshSectorList()
  self.itemPool:HideAll()
  local stcIdList = {}
  for stcId, chaptData in pairs(self.stcChaptDataDic) do
    table.insert(stcIdList, stcId)
  end
  table.sort(stcIdList, function(idA, idB)
    return idA < idB
  end)
  for index, stcId in ipairs(stcIdList) do
    local chaptData = self.stcChaptDataDic[stcId]
    local unFinish = PlayerDataCenter.allActivitySectorIData:IsUnfinishSectorI(stcId)
    if not unFinish and chaptData:IsSectorChapterUnlock(true) then
      self:_CreateChaptItem(chaptData)
    end
  end
  self:_UpdateUncompletedEp()
end

function UINSESectorListNode:OnClickBtnExpand()
  self.isOpen = not self.isOpen
  self.ui.obj_bottom.gameObject:SetActive(self.isOpen)
  self.ui.tex_title:SetIndex(self.isOpen and 0 or 1)
  self.ui.img_arrow.transform.rotation = Vector3.Temp(0, 0, self.isOpen and 0 or 180)
  CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.btn_Expand.transform)
  if self.isOpen then
    self:RefreshSectorList()
  end
end

function UINSESectorListNode:_OnClickSectorItem(sctChaptData)
  SectorUtil.OnClickSectorItem(sctChaptData, true, self.mainSectorCtrl)
end

function UINSESectorListNode:_UpdateUncompletedEp()
  for sectorId, v in pairs(self._sctChaptItemDic) do
    local hasUncomplete = SectorStageDetailHelper.IsSectorHasUnComplete(sectorId)
    v:ShowSctChaptItemInEp(hasUncomplete)
  end
end

function UINSESectorListNode:_OnSctStageStateChange(data)
  local sectorIdDic = {}
  for stageId, v in pairs(data) do
    if PlayerDataCenter.sectorStage:IsStageComplete(stageId) then
      local stageCfg = ConfigData.sector_stage[stageId]
      if stageCfg == nil then
        error("Can't get sector_stage cfg, stageId = " .. tostring(stageId))
        return
      end
      sectorIdDic[stageCfg.sector] = true
    end
  end
  for sectorId, v in pairs(sectorIdDic) do
    self:ShowSctChaptItemBySectorId(sectorId)
    local sctItem = self._sctChaptItemDic[sectorId]
    if sctItem ~= nil then
      sctItem:UpdSctChaptChallengeProgress()
    end
  end
end

function UINSESectorListNode:_OnSctAvgStateChange(sectorId)
  self:ShowSctChaptItemBySectorId(sectorId)
  local sctItem = self._sctChaptItemDic[sectorId]
  if sctItem ~= nil then
    sctItem:UpdSctChaptChallengeProgress()
  end
end

function UINSESectorListNode:ShowSctChaptItemBySectorId(sectorId)
  if self._sctChaptItemDic[sectorId] then
    self._sctChaptItemDic[sectorId]:Show()
    return
  end
  local chaptData = self.stcChaptDataDic[sectorId]
  if chaptData then
    self:_CreateChaptItem(chaptData)
  end
end

function UINSESectorListNode:_CreateChaptItem(chaptData)
  local sectorId = chaptData:GetSctChaptSectorId()
  local item = self.itemPool:GetOne()
  item:InitSectorListNodeItem(chaptData, self._OnClickSectorItemFunc)
  self._sctChaptItemDic[sectorId] = item
end

function UINSESectorListNode:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.OnSectorStageStateChange, self.__onSctStageStateChange)
  MsgCenter:RemoveListener(eMsgEventId.OnMainAvgStateChange, self.__onSctAvgStateChange)
  self.itemPool:DeleteAll()
  base.OnDelete(self)
end

return UINSESectorListNode
