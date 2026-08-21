_class("graph_vertex", Object)
graph_vertex = graph_vertex

function graph_vertex:Constructor(data)
  self.data = data
  self.firstEdge = nil
  self.isVisited = false
end

_class("graph_node", Object)
graph_node = graph_node

function graph_node:Constructor(vertex)
  self.adjvex = vertex
  self.next = nil
end

_class("graph", Object)
graph = graph

function graph:Constructor()
  self.items = {}
end

function graph:GetItems()
  return self.items
end

function graph:AddVertex(data)
  if self:Contain(data) then
    Log.error("添加了重复的顶点")
    return
  end
  local newVertex = graph_vertex:New(data)
  table.insert(self.items, newVertex)
end

function graph:Clear()
  table.clear(self.items)
end

function graph:AddEdge(from, to)
  local fromVertex = self:Find(from)
  if not fromVertex then
    Log.error("头顶点不存在！")
    return
  end
  local toVertex = self:Find(to)
  if not toVertex then
    Log.error("尾顶点不存在！")
    return
  end
  self:_AddDirectedEdge(fromVertex, toVertex)
  self:_AddDirectedEdge(toVertex, fromVertex)
end

function graph:AddDirectedEdge(from, to)
  local fromVertex = self:Find(from)
  if not fromVertex then
    return nil
  end
  local toVertex = self:Find(to)
  if not toVertex then
    return nil
  end
  self:_AddDirectedEdge(fromVertex, toVertex)
end

function graph:_AddDirectedEdge(fromVertex, toVertex)
  if fromVertex.firstEdge == nil then
    fromVertex.firstEdge = graph_node:New(toVertex)
  else
    local temp
    local node = fromVertex.firstEdge
    while node ~= nil and node.adjvex.data ~= toVertex.data do
      temp = node
      node = node.next
    end
    local newNode = graph_node:New(toVertex)
    temp.next = newNode
  end
end

function graph:Find(data)
  for index, vertex in ipairs(self.items) do
    if vertex.data == data then
      return vertex
    end
  end
  return nil
end

function graph:Contain(data)
  for index, vertex in ipairs(self.items) do
    if vertex.data == data then
      return true
    end
  end
  return false
end

function graph:GetGraphInfo(isDirectedGraph)
  local sb = ""
  for index, v in ipairs(self.items) do
    sb = sb .. tostring(v.data) .. ":"
    if v.firstEdge ~= nil then
      local temp = v.firstEdge
      while temp ~= nil do
        if isDirectedGraph then
          sb = sb .. tostring(v.data) .. "→" .. tostring(temp.adjvex.data) .. " "
        else
          sb = sb .. tostring(temp.adjvex.data)
        end
        temp = temp.next
      end
    end
    sb = sb .. "\r\n"
  end
  return sb
end

function graph:InitVisited()
  for index, v in ipairs(self.items) do
    v.isVisited = false
  end
end

function graph:BFSTraverse(index)
  self:InitVisited()
  return self:BFS(self.items[index])
end

function graph:BFS(v)
  local tbl = {}
  v.isVisited = true
  local verQueue = AircraftQueue:New()
  verQueue:Enqueue(v)
  table.insert(tbl, v.data)
  while verQueue:Count() > 0 do
    local w = verQueue:Dequeue()
    local node = w.firstEdge
    while node ~= nil do
      if node.adjvex.isVisited == false then
        node.adjvex.isVisited = true
        table.insert(tbl, node.adjvex.data)
        verQueue:Enqueue(node.adjvex)
      end
      node = node.next
    end
  end
  local str = ""
  for index, value in ipairs(tbl) do
  end
  return tbl
end

function graph.graphTraverseTest()
  local adjList = graph:New()
  adjList:Clear()
  adjList:AddVertex("A")
  adjList:AddVertex("B")
  adjList:AddVertex("C")
  adjList:AddDirectedEdge("A", "C")
  adjList:AddDirectedEdge("C", "A")
  adjList:AddDirectedEdge("B", "A")
  adjList:AddDirectedEdge("A", "B")
  Log.error("广度优先遍历：")
  local queue = adjList:BFSTraverse(1)
end
