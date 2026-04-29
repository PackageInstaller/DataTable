_class("UIUndirectedGraphData", Object)
UIUndirectedGraphData = UIUndirectedGraphData

function UIUndirectedGraphData:Constructor(node_cfg, line_cfg, node_Pos, line_StartNodeId, line_EndNodeId)
  self._nodes = node_cfg
  self._lines = line_cfg
  self._node_Pos = node_Pos or "Pos"
  self._line_StartNodeId = line_StartNodeId or "StartNodeID"
  self._line_EndNodeId = line_EndNodeId or "EndNodeID"
  self._nodeIdList = self:_GetSortedIDList(self._nodes)
  self._lineIdList = self:_GetSortedIDList(self._lines)
  self._adjacencyList = self:_GetAdjacencyList()
end

function UIUndirectedGraphData:GetNodeIdList()
  return self._nodeIdList
end

function UIUndirectedGraphData:GetNode(id)
  return self._nodes[id]
end

function UIUndirectedGraphData:GetNodePos(id, isV3)
  local pos = self._nodes[id][self._node_Pos]
  return isV3 and Vector3(pos[1], pos[2]) or Vector2(pos[1], pos[2])
end

function UIUndirectedGraphData:GetLineIdList()
  return self._lineIdList
end

function UIUndirectedGraphData:GetLine(id)
  return self._lines[id]
end

function UIUndirectedGraphData:GetLinePos(id)
  local a = self._lines[id][self._line_StartNodeId]
  local b = self._lines[id][self._line_EndNodeId]
  return self:GetNodePos(a), self:GetNodePos(b)
end

function UIUndirectedGraphData:GetAdjacentNodes(id)
  return self._adjacencyList[id] or {}
end

function UIUndirectedGraphData:GetAPathToTarget(start_id, target_ids, limit_step)
  limit_step = limit_step or 100
  if table.count(target_ids) == 0 then
    return {}
  end
  local targets = table.reverse(target_ids)
  local queue = {start_id}
  local path = {
    [start_id] = {start_id}
  }
  while table.count(queue) ~= 0 do
    local cur = queue[1]
    table.remove(queue, 1)
    local step = #path[cur] - 1
    if step == limit_step then
      break
    end
    local next = self:GetAdjacentNodes(cur)
    for _, v in ipairs(next) do
      if not path[v] then
        path[v] = table.collect(path[cur])
        table.insert(path[v], v)
        table.insert(queue, v)
      end
      if targets[v] then
        return path[v]
      end
    end
  end
  return {}
end

function UIUndirectedGraphData:GetAllPathsInLimitStep(start_id, limit_step)
  limit_step = limit_step or 1
  local queue = {start_id}
  local path = {
    [start_id] = {start_id}
  }
  while table.count(queue) ~= 0 do
    local cur = queue[1]
    table.remove(queue, 1)
    local step = #path[cur] - 1
    if step == limit_step then
      break
    end
    local next = self:GetAdjacentNodes(cur)
    for _, v in ipairs(next) do
      if not path[v] then
        path[v] = table.collect(path[cur])
        table.insert(path[v], v)
        table.insert(queue, v)
      end
    end
  end
  path[start_id] = nil
  return path
end

function UIUndirectedGraphData:_GetSortedIDList(tb_in)
  local tb = {}
  for k, v in pairs(tb_in) do
    table.insert(tb, k)
  end
  table.sort(tb)
  return tb
end

function UIUndirectedGraphData:_GetAdjacencyList()
  local tb = {}
  for k, v in pairs(self._lines) do
    local a = v[self._line_StartNodeId]
    local b = v[self._line_EndNodeId]
    if tb[a] == nil then
      tb[a] = {}
    end
    table.insert(tb[a], b)
    if tb[b] == nil then
      tb[b] = {}
    end
    table.insert(tb[b], a)
  end
  return tb
end
