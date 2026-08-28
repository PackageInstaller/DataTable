
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool

------------ import ------------


------------ define ------------
local AnimName = {
    Default     = "CultivateOverseaStarNode_Default",
    Upgradeable = "CultivateOverseaStarNode_Upgradeable", --- 可升星
    UpStar      = "CultivateOverseaStarNode_UpStar"       --- 升星
}
local Scale1 = Vector3.New(0.8, 0.8, 0.8)
local Scale2 = Vector3.one
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaStarNode.prefab
---@class CardProgressionStarNode
---@field Env                           	CardProgressionStarNode
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgLock                       	UnityEngine.RectTransform
---@field Scale                         	UnityEngine.Animation
---@field ImgStar2                      	UnityEngine.UI.Image
---@field ImgStar                       	UnityEngine.UI.Image
---@field ImgSelectLight                	UnityEngine.RectTransform
local CardProgressionStarNode = Class('CardProgressionStarNode')

function CardProgressionStarNode:__init()

end


function CardProgressionStarNode:__delete()

end


function CardProgressionStarNode:Awake()
end


function CardProgressionStarNode:Start()
end


function CardProgressionStarNode:OnDestroy()
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
---@param status number 1:Lock 2:Lock Icon 3:Unlock 4:Select  5:升星效果 
function CardProgressionStarNode:FreshUI(status, cb, star)
    --KTool.SetActive(self.ImgStar.gameObject, status <= 2)
    
    KTool.SetActive(self.ImgStar2.gameObject, status > 2 and status ~= 4)
    
    KTool.SetActive(self.ImgLock, status == 2)
        
    local name = AnimName.Default
    if status == 5 then
        name = AnimName.UpStar
    elseif status == 4 then
        name = AnimName.Upgradeable
    end
    self.Scale:Play(name)

    self.ImgSelectLight.localScale = status == 4 and Scale1 or Scale2 
    
    if cb then
        SetButtonAction(self.controller.gameObject, function ()
            if cb then
                cb(star)
            end
        end)
    end
end

function CardProgressionStarNode:FreshSelectStatus(isSelect)
    self.ImgSelectLight.localScale = isSelect and Scale2 or Scale1
    KTool.SetActive(self.ImgSelectLight, isSelect)
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionStarNode
