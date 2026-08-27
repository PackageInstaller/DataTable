local UISteinsGateChapterMapHelper = {}
local GRID_SIZE = {
  leftPad = 155,
  rightPad = 155,
  Spacing = 210,
  NodeSize = 120
}

function UISteinsGateChapterMapHelper.GetCurMaxLineSize(sgStoryData)
  local spEndId = ConfigData.activity_23steinsgate_map.spEndId
  local sgNodeData = sgStoryData:Act23SG_GetNodeData(spEndId)
  if sgNodeData ~= nil and sgNodeData:Act23GSSN_GetIsChoulShow() then
    local posCfg = ConfigData.activity_23steinsgate_map.storyId2PosDic[spEndId]
    local gridIndex = posCfg.grid
    return GRID_SIZE.leftPad + gridIndex * GRID_SIZE.NodeSize + (gridIndex - 1) * GRID_SIZE.Spacing + GRID_SIZE.rightPad
  end
  local lineList = sgStoryData:Act23Gs_GetLineData()
  local maxSize = 0
  for lineIndex, lineData in pairs(lineList) do
    if lineData:Act23GSLN_GetIsLineCouldShow() then
      local lineNodes = ConfigData.activity_23steinsgate_map.lineNodeListDic[lineIndex]
      local gridIndex = 0
      for i = #lineNodes, 1, -1 do
        local nodeId = lineNodes[i]
        local sgNodeData = sgStoryData:Act23SG_GetNodeData(nodeId)
        if sgNodeData:Act23GSSN_GetIsChoulShow() then
          local posCfg = ConfigData.activity_23steinsgate_map.storyId2PosDic[nodeId]
          gridIndex = posCfg.grid
          break
        end
      end
      local size = GRID_SIZE.leftPad + gridIndex * GRID_SIZE.NodeSize + (gridIndex - 1) * GRID_SIZE.Spacing + GRID_SIZE.rightPad
      if maxSize < size then
        maxSize = size
      end
    end
  end
  return maxSize
end

function UISteinsGateChapterMapHelper.GetContentLeftNeedShirnkSize(sgStoryData)
  local gridIndex = 1000
  for _, nodeData in pairs(sgStoryData:Act23SG_GetAllNodeData()) do
    if nodeData:Act23GSSN_GetIsChoulShow() then
      local nodeGI = nodeData:Act23GSSN_GetGridIndex()
      if gridIndex > nodeGI then
        gridIndex = nodeGI
      end
    end
  end
  local size = gridIndex * GRID_SIZE.NodeSize + (gridIndex - 1) * GRID_SIZE.Spacing
  return size
end

function UISteinsGateChapterMapHelper.GetNodePos(nodeData)
  local gridIndex = nodeData:Act23GSSN_GetGridIndex()
  return GRID_SIZE.leftPad + gridIndex * GRID_SIZE.NodeSize + (gridIndex - 1) * GRID_SIZE.Spacing
end

return UISteinsGateChapterMapHelper
