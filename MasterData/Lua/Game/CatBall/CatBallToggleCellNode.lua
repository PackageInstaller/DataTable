
--region global define

--endregion

--region import
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballCultivateDialog.prefab
---@class CatBallToggleCellNode
---@field Env                           	CatBallToggleCellNode                   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field redPoint                      	UnityEngine.RectTransform               
---@field Text                          	Game.Native.Common.UISwitchText         
---@field ImgBg                         	Game.Native.Common.UISwitchImage        
local CatBallToggleCellNode = Class('CatBallToggleCellNode')

function CatBallToggleCellNode:__init()

end


function CatBallToggleCellNode:__delete()

end


-- function CatBallToggleCellNode:Awake()
-- end


function CatBallToggleCellNode:Start()
    SetButtonAction(self.controller.gameObject, Bind(self, self.OnClickCellAction))
end


function CatBallToggleCellNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function CatBallToggleCellNode:FreshUI(toggleData, position)
    if self._position == position then
        return
    end
    self._position = position
    self.Text.text = toggleData.text

end

function CatBallToggleCellNode:FreshSelectState(isSelect)
    local status      = isSelect and 2 or 1
    self.ImgBg.Status = status
    self.Text.Status  = status

end

function CatBallToggleCellNode:FreshRedPointShowState(isShow)
    KTool.SetActive(self.redPoint.gameObject, isShow)
end

--endregion 


--region get/set 

function CatBallToggleCellNode:SetCallback(callback)
    self._callback = callback
end

---endregion 


--region handler 

function CatBallToggleCellNode:OnClickCellAction()
    if self._callback then
        local isSelect = self._callback(self._position)
        if isSelect then
            self:FreshSelectState(isSelect)
        end
    end
end

---endregion 


return CatBallToggleCellNode
