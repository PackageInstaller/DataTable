local UIOasisEditor = class("UIOasisEditor", UIBaseWindow)
local base = UIBaseWindow
local BuildingTypeData = require("Game.Oasis.Data.BuildingTypeData")
local UIOasisBuildItem = require("Game.Oasis.UI.Editor.UIOasisBuildItem")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local UINBuildLogicLvPreview = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvPreview")
local cs_ResLoader = CS.ResLoader
local sortStateDic = {
  [4] = 1,
  [1] = 2,
  [3] = 3,
  [2] = 4,
  max = 5
}

function UIOasisEditor:OnInit()
  self.ui.buildingItem:SetActive(false)
  self.buildItemPool = UIItemPool.New(UIOasisBuildItem, self.ui.buildingItem)
  self.resLoader = cs_ResLoader.Create()
  self.newBuildingFunc = BindCallback(self, self._OnClickNewBuilding)
  self.previewBuildFunc = BindCallback(self, self._OnClickPreview)
  self.buildEditPreviewNode = UINBuildLogicLvPreview.New()
  self.buildEditPreviewNode:Init(self.ui.logicPreviewNode)
  self.buildEditPreviewNode:Hide()
end

function UIOasisEditor:InitOasisEditor(oasisCtrl)
  UIUtil.SetTopStatus(self, self.__ExitEditor)
  self.oasisCtrl = oasisCtrl
  self:RefreshOasisEditSideBar()
  self.ui.adapter:SetActive(true)
  self:ShowOasisEditorSideTween(true)
end

function UIOasisEditor:RefreshOasisEditSideBar()
  local buildTypeDataList = BuildingTypeData.CreateAllBuildTypeData()
  self.buildTypeDataList = buildTypeDataList
  table.sort(buildTypeDataList, self.__SortBuildTypeDataFunc)
  self.buildItemPool:HideAll()
  for k, buildTypeData in ipairs(buildTypeDataList) do
    local buildItem = self.buildItemPool:GetOne()
    buildItem:InitOasisBuildItem(buildTypeData, self.resLoader, self.newBuildingFunc, self.previewBuildFunc)
    buildItem.gameObject.name = tostring(k)
  end
end

function UIOasisEditor.__SortBuildTypeDataFunc(a, b)
  local buildTypeA = a:GetBuildTypeState()
  local buildTypeB = b:GetBuildTypeState()
  local sortIdA = sortStateDic[buildTypeA] or sortStateDic.max
  local sortIdB = sortStateDic[buildTypeB] or sortStateDic.max
  local buildDataA = a:GetNextUnlockBuildData()
  local buildDataB = b:GetNextUnlockBuildData()
  if sortIdA == sortIdB then
    if buildTypeA == 1 or buildTypeB == 3 then
      local stateIdA, mainBuildLvA = UIOasisEditor.__GetStageIdAndBuildingLevel(buildDataA)
      local stateIdB, mainBuildLvB = UIOasisEditor.__GetStageIdAndBuildingLevel(buildDataB)
      if stateIdA == stateIdB then
        if mainBuildLvA == mainBuildLvB then
          return buildDataA.id < buildDataB.id
        else
          return mainBuildLvA < mainBuildLvB
        end
      else
        return stateIdA < stateIdB
      end
    else
      return buildDataA.id < buildDataB.id
    end
  else
    return sortIdA < sortIdB
  end
end

function UIOasisEditor.__GetStageIdAndBuildingLevel(buildingData)
  local lv1Cfg = buildingData.levelConfig[1]
  local completeStateId = 999999
  local mainBuildingLv = 999999
  for k, conditionId in ipairs(lv1Cfg.pre_condition) do
    if conditionId == CheckerTypeId.CompleteStage then
      completeStateId = lv1Cfg.pre_para1[k]
    elseif conditionId == CheckerTypeId.BuildingLevel and lv1Cfg.pre_para1[k] == eBuildingId.OasisMainBuilding then
      mainBuildingLv = lv1Cfg.pre_para2[k]
    end
  end
  return completeStateId, mainBuildingLv
end

function UIOasisEditor:ShowOasisEditorSideTween(show)
  if self.sideIsShow == show then
    return
  end
  self.sideIsShow = show
  self.ui.root_CanvasGroup.blocksRaycasts = show
  if show then
    self.ui.scrollRect.verticalNormalizedPosition = 1
    self.ui.sideTween:DORestart()
    AudioManager:PlayAudioById(1077)
  else
    self.ui.sideTween:DOPlayBackwards()
    AudioManager:PlayAudioById(1078)
  end
end

function UIOasisEditor:_OnClickNewBuilding(buildItem)
  self.oasisCtrl:NewBuilding(buildItem.buildingData)
  self:ShowOasisEditorSideTween(false)
end

function UIOasisEditor:_OnClickPreview(buildingData)
  self.buildEditPreviewNode:Show()
  self.buildEditPreviewNode:InitBuildLogicLvPreview(buildingData)
end

function UIOasisEditor:__ExitEditor()
  self.oasisCtrl:ExitEditMode()
  self.ui.adapter:SetActive(false)
  self:ShowOasisEditorSideTween(false)
end

function UIOasisEditor:OnDelete()
  self.buildItemPool:DeleteAll()
  self.buildEditPreviewNode:Delete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  base.OnDelete(self)
end

return UIOasisEditor
