local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local isWait = false
local Order = {}

function Order:OnStart(ca)
  local function cb()
    local nodePath = ca.nodeName
    
    if ca.nodeType == "Bubble" then
      local cityMapDataModel = require("UICityMap/UICityMapDataModel")
      for i, info in ipairs(cityMapDataModel.curShowBubbleList) do
        if info.id == ca.mId then
          nodePath = string.format(ca.nodeName, i)
          break
        end
      end
    end
    local tranUI = GuideManager:GetPanelUI(ca.uiPath, nodePath)
    if tranUI ~= nil then
      UIGuidanceController.ActiveUIGuide()
      local pos = tranUI.position
      pos = UIGuidanceController.GetLocalPos(pos)
      UIGuidanceController.SetFocus(pos.x, pos.y, ca.w, ca.h, 0, 0)
      UIGuidanceController.PosOffset(ca.offsetX, ca.offsetY)
      UIGuidanceController.ShowFinger(ca.isShowFinger)
      UIGuidanceController.SetBgAlpha(ca.alpha)
    end
  end
  
  if ca.delay then
    isWait = true
    CoroutineManager:Reg("OrderUIFocus", LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      isWait = false
      cb()
      CoroutineManager:UnReg("OrderUIFocus")
    end))
  else
    isWait = false
    cb()
  end
end

function Order:IsFinish()
  if isWait then
    return false
  end
  return true
end

return Order
