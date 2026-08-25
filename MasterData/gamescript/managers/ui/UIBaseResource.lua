local System = require("System.System")
local rawset = _ENV.rawset
local TYPEOF_UIExport = typeof(CS.FrameWork.UIExport)
local _, _
local UIBaseResource, Super = System.NewClass("UIBaseResource", System.BaseObject)

function UIBaseResource:ctor(uiNode)
  self.uiNode = uiNode
  if uiNode then
    local uiExport = uiNode and uiNode:GetComponent(TYPEOF_UIExport)
    if uiExport then
      local uiNodeList = uiExport.uiNodeList
      local uiNode, name, obj
      for i = 0, uiNodeList.Count - 1 do
        uiNode = uiNodeList[i]
        name, obj = uiNode.name, uiNode.obj
        if name and obj then
          rawset(self, uiNode.name, obj)
        end
      end
    end
  end
end

return UIBaseResource
