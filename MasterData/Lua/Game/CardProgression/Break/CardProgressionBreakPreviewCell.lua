
------------ import ------------
---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaBreakPreview.prefab
---@class CardProgressionBreakPreviewCell
---@field Env                           	CardProgressionBreakPreviewCell                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field CultivateOverseaBreakNode     	UnityEngine.RectTransform               
local CardProgressionBreakPreviewCell = Class('CardProgressionBreakPreviewCell')

function CardProgressionBreakPreviewCell:__init()

end


function CardProgressionBreakPreviewCell:__delete()

end


function CardProgressionBreakPreviewCell:Awake()
end


function CardProgressionBreakPreviewCell:Start()
end


function CardProgressionBreakPreviewCell:OnDestroy()
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

function CardProgressionBreakPreviewCell:FreshUI(cardId, awakeningLevel)
    ---@type CardProgressionBreakNode
    local env = CfUtils.GetLuaScr(self.CultivateOverseaBreakNode, CardProgressionConstants.EnvPath.CardProgressionBreakNode)
    if not isNull(env) then
        env:FreshUI(cardId, awakeningLevel)
    end
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


return CardProgressionBreakPreviewCell
