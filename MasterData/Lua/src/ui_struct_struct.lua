local this = class("struct")

function this.getQueue(...)
  return require("ui.struct.queue").new(...)
end

function this.getStack(...)
  return require("ui.struct.stack").new(...)
end

function this.getDictionary(...)
  return require("ui.struct.dictionary").new(...)
end

function this.getDoubleLink(...)
  return require("ui.struct.doubleLink").new(...)
end

function this.getLruCache(...)
  return require("ui.struct.lruCache").new(...)
end

function this.getTree(...)
  return require("ui.struct.tree.tree").new(...)
end

function this.getTreeNode(...)
  return require("ui.struct.tree.treeNode").new(...)
end

function this:getBounds(...)
  return require("ui.struct.bounds").new(...)
end

function this:getPolyhedron(...)
  return require("ui.struct.polyhedron").new(...)
end

function this:getOcTree(...)
  return require("ui.struct.ocTree.ocTree").new(...)
end

function this:getOcTreeNode(...)
  return require("ui.struct.ocTree.ocTreeNode").new(...)
end

return this
