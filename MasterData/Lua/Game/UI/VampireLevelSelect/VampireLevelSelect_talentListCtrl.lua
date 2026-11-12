local VampireLevelSelect_talentListCtrl = class("VampireLevelSelect_talentListCtrl", BaseCtrl)
VampireLevelSelect_talentListCtrl._mapNodeConfig = {
  Content = {sComponentName = "Transform"},
  goTop = {},
  go1to3 = {},
  go3to3 = {},
  go3to1 = {},
  go1to1 = {},
  go1to2 = {},
  go2to2 = {},
  go2to1 = {}
}
VampireLevelSelect_talentListCtrl._mapEventConfig = {}
VampireLevelSelect_talentListCtrl._mapRedDotConfig = {}

function VampireLevelSelect_talentListCtrl:Awake()
  self.mapGoDic = {
    [0] = {
      [1] = self._mapNode.goTop
    },
    [1] = {
      [1] = self._mapNode.go1to1,
      [2] = self._mapNode.go1to2,
      [3] = self._mapNode.go1to3
    },
    [2] = {
      [1] = self._mapNode.go2to1,
      [2] = self._mapNode.go2to2
    },
    [3] = {
      [1] = self._mapNode.go3to1,
      [3] = self._mapNode.go3to3
    }
  }
  self.mapHeightDic = {
    [0] = {
      [1] = 195.05
    },
    [1] = {
      [1] = 276.14,
      [2] = 284.1,
      [3] = 284.1
    },
    [2] = {
      [1] = 308.6,
      [2] = 211.89
    },
    [3] = {
      [1] = 308.6,
      [3] = 211.89
    }
  }
  self._mapFloorCtrl = {}
  self.tbFloor = {}
  
  local function ForEachTalentFloor(mapData)
    table.insert(self.tbFloor, mapData)
  end
  
  ForEachTableLine(DataTable.VampireTalentFloor, ForEachTalentFloor)
  
  function SortFloor(mapDataA, mapDataB)
    return mapDataA.Id > mapDataB.Id
  end
  
  self.topId = self.tbFloor[1].TalentId[1]
end

function VampireLevelSelect_talentListCtrl:FadeIn()
end

function VampireLevelSelect_talentListCtrl:FadeOut()
end

function VampireLevelSelect_talentListCtrl:OnEnable()
  self.lsv = self.gameObject:GetComponent("ScrollRect")
end

function VampireLevelSelect_talentListCtrl:OnDisable()
  self:ClearAllFloor()
end

function VampireLevelSelect_talentListCtrl:OnDestroy()
end

function VampireLevelSelect_talentListCtrl:OnRelease()
end

function VampireLevelSelect_talentListCtrl:InitList()
  self:ClearAllFloor()
  local nCurId = 0
  local totalHeight = 0
  local targetHeight = 0
  for nFloor, mapFloorData in ipairs(self.tbFloor) do
    local nPrevCount = 0
    local tbPrevId = {}
    if self.tbFloor[nFloor - 1] ~= nil then
      nPrevCount = self.tbFloor[nFloor - 1].Num
      tbPrevId = self.tbFloor[nFloor - 1].TalentId
    end
    local nCurCount = mapFloorData.Num
    if self.mapGoDic[nPrevCount] == nil or self.mapGoDic[nPrevCount][nCurCount] == nil then
      printError("层数错误 无对应预制体：" .. nFloor)
      return
    end
    local go = instantiate(self.mapGoDic[nPrevCount][nCurCount], self._mapNode.Content)
    totalHeight = totalHeight + self.mapHeightDic[nPrevCount][nCurCount]
    local mapCtrl = self:BindCtrlByNode(go, "Game.UI.VampireLevelSelect.VampireLevelSelect_talentList_listFloorCtrl")
    table.insert(self._mapFloorCtrl, mapCtrl)
    local floorMin = mapCtrl:Refresh(mapFloorData.TalentId, tbPrevId, self.topId)
    if 0 < floorMin and (nCurId == 0 or nCurId > floorMin) then
      nCurId = floorMin
      targetHeight = totalHeight
    end
  end
  local nViewPortHeight = Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT - 210
  if nViewPortHeight > totalHeight - targetHeight then
    self._mapNode.Content.anchoredPosition = Vector2(0, totalHeight - nViewPortHeight)
  elseif targetHeight < nViewPortHeight / 2 then
    self._mapNode.Content.anchoredPosition = Vector2(0, 0)
  else
    self._mapNode.Content.anchoredPosition = Vector2(0, targetHeight - nViewPortHeight * 0.5)
  end
  EventManager.Hit("VampireTalent_ClickNode", nCurId == 0 and self.topId or nCurId)
end

function VampireLevelSelect_talentListCtrl:RefreshList(nAminId)
  for nFloor, mapFloorData in ipairs(self.tbFloor) do
    local tbPrevId = {}
    if self.tbFloor[nFloor - 1] ~= nil then
      tbPrevId = self.tbFloor[nFloor - 1].TalentId
    end
    local mapCtrl = self._mapFloorCtrl[nFloor]
    if mapCtrl ~= nil then
      mapCtrl:Refresh(mapFloorData.TalentId, tbPrevId, nAminId == 0 and self.topId or nAminId, nAminId)
    end
  end
  if nAminId == 0 then
    NovaAPI.SetVerticalNormalizedPosition(self.lsv, 1)
  end
end

function VampireLevelSelect_talentListCtrl:ClearAllFloor()
  for index, mapCtrl in ipairs(self._mapFloorCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapFloorCtrl = {}
  delChildren(self._mapNode.Content)
end

return VampireLevelSelect_talentListCtrl
