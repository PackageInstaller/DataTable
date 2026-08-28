
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------

local AnimationName = {
    Select        = "CultivateOverseaFashionIcon_Select", --- 选择动画
    Cancel        = "CultivateOverseaFashionIcon_Cancel", --- 取消选择动画
    SelectDefault = "CultivateOverseaFashionIcon_SelectDefault", --- 选择默认状态
    CancelDefault = "CultivateOverseaFashionIcon_CancelDefault", --- 取消选择的默认状态
}

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFashion.prefab
---@class CardProgressionFashionLabelNode
---@field Env                           	CardProgressionFashionLabelNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field AnimRoot                      	UnityEngine.Animation                   
---@field Unlock                        	UnityEngine.RectTransform               
---@field Lock                          	UnityEngine.RectTransform               
local CardProgressionFashionLabelNode = Class('CardProgressionFashionLabelNode')

function CardProgressionFashionLabelNode:__init()

end


function CardProgressionFashionLabelNode:__delete()

end


function CardProgressionFashionLabelNode:Awake()
end


function CardProgressionFashionLabelNode:Start()
    self._started = true
    if self._animationCb then
        self._animationCb()
    end
    SetButtonAction(self.controller.gameObject, Bind(self, self.OnClickLabelAction))
end


function CardProgressionFashionLabelNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------


---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshUI
---@param isUnlock boolean
function CardProgressionFashionLabelNode:FreshUI(isUnlock, isInitialize)
    KTool.SetActive(self.Unlock.gameObject, isUnlock)
    KTool.SetActive(self.Lock.gameObject,   not isUnlock)
    
end

function CardProgressionFashionLabelNode:FreshSelectState(isSelect, isInitialize)
    local animationCb = function()
        local name
        if isInitialize then
            name = isSelect and AnimationName.SelectDefault or AnimationName.CancelDefault
        else
            name = isSelect and AnimationName.Select or AnimationName.Cancel
        end
    
        if name ~= self._animationName or isInitialize then
            self._animationName = name
            self.AnimRoot:Play(name)
        end
    end
    if self._started then
        animationCb()
    else
        self._animationCb = animationCb
    end
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionFashionLabelNode:SetCallback(callback)
    self._callback = callback
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionFashionLabelNode:OnClickLabelAction()
    if self._callback then
        self._callback()
    end

end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionFashionLabelNode
