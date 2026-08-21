_class("Digraph", Object)
Digraph = Digraph

function Digraph:Constructor()
  self.vertexCount = 0
  self.edgeCount = 0
  self.indegree = {}
  self.adj = {}
  self.marked = {}
end

function Digraph:AddEdge(v, w)
  if not self.adj[v] then
    self.adj[v] = {}
  end
  table.insert(self.adj[v], w)
  if not self.indegree[w] then
    self.indegree[w] = {}
  end
  table.insert(self.indegree[w], v)
  self.edgeCount = self.edgeCount + 1
end

function Digraph:Adj(v)
  return self.adj[v]
end

function Digraph:Indegree(v)
  return self.indegree[v]
end

function Digraph:IndegreeCount(v)
  local indegree = self:Indegree(v)
  return indegree and table.count(indegree) or 0
end

function Digraph:DFTAll(callback)
  self.marked = {}
  for v, vadj in pairs(self.adj) do
    self:InternalDFS(v, callback)
  end
end

function Digraph:DFT(v, callback)
  self.marked = {}
  self:InternalDFS(v, callback)
end

function Digraph:InternalDFS(v, callback)
  if not self.marked[v] then
    self.marked[v] = true
    if callback then
      callback(v)
    end
  end
  local adj = self:Adj(v)
  if adj then
    for _, w in pairs(adj) do
      if not self.marked[w] then
        self:InternalDFS(w)
      end
    end
  end
end
