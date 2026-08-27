local base = UIBaseNode
local UINSectorNode = class("UINSectorNode", base)
local UINSectorItem = require("Game.Sector.UIScene.SectorNode.UINSectorItem")
local UINSectorIcon = require("Game.Sector.UIScene.SectorNode.UINSectorIcon")
local SectorChapterData = require("Game.Sector.Data.SectorChapterData")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")
local SectorUtil = require("Game.Sector.SectorUtil")
local cs_MessageCommon = CS.MessageCommon

function UINSectorNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._chaptItemPool = UIItemPool.New(UINSectorItem, self.ui.sectorItem, false)
  self._chaptIconPool = UIItemPool.New(UINSectorIcon, self.ui.sectorIcon, false)
  self._OnClickSectorItemFunc = BindCallback(self, self._OnClickSectorItem)
  self._resLoader = CS.ResLoader.Create()
  self.__onHasUncompletedEp = BindCallback(self, self._UpdateUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  self.__onSctStageStateChange = BindCallback(self, self._OnSctStageStateChange)
  MsgCenter:AddListener(eMsgEventId.OnSectorStageStateChange, self.__onSctStageStateChange)
  self.__onSctAvgStateChange = BindCallback(self, self._OnSctAvgStateChange)
  MsgCenter:AddListener(eMsgEventId.OnMainAvgStateChange, self.__onSctAvgStateChange)
end

function UINSectorNode:InitSectorNode(stcChaptDataDic, curSctMapId)
  self._chaptItemDic = {}
  self._sctChaptItemDic = {}
  self._stcChaptDataDic = stcChaptDataDic
  for stcId, chaptData in pairs(stcChaptDataDic) do
    local unFinish = PlayerDataCenter.allActivitySectorIData:IsUnfinishSectorI(stcId)
    if not unFinish and chaptData:IsSectorChapterUnlock(true) then
      self:_CreateChaptItem(chaptData)
    end
  end
  for i = 1, curSctMapId - 1 do
    local sctChapterIdList = ConfigData.sector_sector_resident.sectorMapChapterDic[i]
    if sctChapterIdList ~= nil then
      for k, chaptId in ipairs(sctChapterIdList) do
        local chaptData = SectorChapterData.New(chaptId)
        if chaptData:IsSectorChapterUnlock() then
          self:_TryCreateChaptIcon(chaptData)
        end
      end
    end
  end
  self:_UpdateUncompletedEp()
end

function UINSectorNode:_CreateChaptItem(chaptData)
  local chaptId = chaptData:GetSctChaptId()
  local sectorId = chaptData:GetSctChaptSectorId()
  local chaptItem = self._chaptItemPool:GetOne()
  chaptItem:InitSectorItem(chaptData, self._OnClickSectorItemFunc)
  self._chaptItemDic[chaptId] = chaptItem
  self._sctChaptItemDic[sectorId] = chaptItem
  self:_TryCreateChaptIcon(chaptData)
end

function UINSectorNode:_TryCreateChaptIcon(chaptData)
  local ok, iconName, posV2 = chaptData:TryGetSctChaptIcon()
  if not ok then
    return
  end
  local iconItem = self._chaptIconPool:GetOne()
  iconItem:InitSectorIcon(iconName, self._resLoader)
  iconItem.transform.anchoredPosition = posV2
  local chaptId = chaptData:GetSctChaptId()
  local chaptItem = self._chaptItemDic[chaptId]
  if chaptItem then
    iconItem.transform:SetParent(chaptItem.transform)
  end
  iconItem.transform:SetAsFirstSibling()
end

function UINSectorNode:_OnClickSectorItem(sctChaptData, chaptItem)
  SectorUtil.OnClickSectorItem(sctChaptData)
end

function UINSectorNode:_UpdateUncompletedEp()
  for sectorId, v in pairs(self._sctChaptItemDic) do
    local hasUncomplete = SectorStageDetailHelper.IsSectorHasUnComplete(sectorId)
    v:ShowSctChaptItemInEp(hasUncomplete)
  end
end

function UINSectorNode:_OnSctStageStateChange(data)
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

function UINSectorNode:_OnSctAvgStateChange(sectorId)
  self:ShowSctChaptItemBySectorId(sectorId)
  local sctItem = self._sctChaptItemDic[sectorId]
  if sctItem ~= nil then
    sctItem:UpdSctChaptChallengeProgress()
  end
end

function UINSectorNode:ShowSctChaptItemBySectorId(sectorId)
  if self._sctChaptItemDic[sectorId] then
    self._sctChaptItemDic[sectorId]:Show()
    return
  end
  local chaptData = self._stcChaptDataDic[sectorId]
  if chaptData then
    self:_CreateChaptItem(chaptData)
  end
end

function UINSectorNode:GetSctChaptItemBySectorId(sectorId)
  return self._sctChaptItemDic[sectorId]
end

function UINSectorNode:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.OnSectorStageStateChange, self.__onSctStageStateChange)
  MsgCenter:RemoveListener(eMsgEventId.OnMainAvgStateChange, self.__onSctAvgStateChange)
  if self._resLoader then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  self._chaptItemPool:DeleteAll()
  self._chaptIconPool:DeleteAll()
  base.OnDelete(self)
end

return UINSectorNode
