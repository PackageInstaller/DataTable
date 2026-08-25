local UIEffectMgr, Super = System.NewClass("UIEffectMgr", ResCache)

function UIEffectMgr:ctor()
  local UIEffectCaches = {}
  
  local function CreateFunc()
    local resObject = UIEffectCaches[1]
    if resObject then
      table.remove(UIEffectCaches, 1)
      return resObject
    end
    do return end
    return UIEffect, UIEffectCaches, 1
  end
  
  local function ReleaseFunc(resObject)
    table.insert(UIEffectCaches, resObject)
  end
  
  Super.ctor(self, CreateFunc, ReleaseFunc)
end

function UIEffectMgr:PlayEffect(effPath, uiNode, offsetX, offsetY, loop)
  local resObj = self:NewObject(effPath)
  resObj:SetParent(uiNode.transform)
  resObj.uiNode = uiNode
  resObj.offsetX = offsetX or 0
  resObj.offsetY = offsetY or 0
  resObj.isLooping = loop
  return resObj
end

function UIEffectMgr:StopEffect(resObj)
  self:RecycleObject(resObj)
end

UIEffectMgr.Instance = UIEffectMgr()
return UIEffectMgr
