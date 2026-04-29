require("algorithm")
require("array_list")
require("sorted_array")
require("sorted_dictionary")
_staticClass("CustomNodeStatic")

function CustomNodeStatic.TraverseCollectInterface(interfaceList, funcName, node)
  if node == nil then
    return
  end
  if node.CollectInterface then
    node:CollectInterface(interfaceList, funcName)
  end
  if node.CollectInterfaceInChildren then
    node:CollectInterfaceInChildren(interfaceList, funcName)
  end
end

_staticClass("CustomNodeConfigStatic")
CustomNodeConfigStatic.NodeConfigChecker = SortedDictionary:New()

function CustomNodeConfigStatic.AddChecker(nodeType, cfgCheckFunc)
  CustomNodeConfigStatic.NodeConfigChecker:Insert(nodeType, cfgCheckFunc)
end

CLHelper = {}

function CLHelper.Assert(condition, logMsg)
  if condition then
    return true
  end
  if logMsg then
    Log.fatal(logMsg)
  end
  assert(condition)
  return false
end
