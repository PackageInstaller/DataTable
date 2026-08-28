
------------ import ------------

------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFeelingRewardTips.prefab
---@class CardProgressionFavorRewardTipsDescNode
---@field Env                           	CardProgressionFavorRewardTipsDescNode
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TextDesc                      	UnityEngine.UI.Text
---@field ImgGoodsIcon                  	Engine.UI.ImageAlterable
local CardProgressionFavorRewardTipsDescNode = Class('CardProgressionFavorRewardTipsDescNode')

function CardProgressionFavorRewardTipsDescNode:__init()

end


function CardProgressionFavorRewardTipsDescNode:__delete()

end


function CardProgressionFavorRewardTipsDescNode:Awake()
end


function CardProgressionFavorRewardTipsDescNode:Start()
end


function CardProgressionFavorRewardTipsDescNode:OnDestroy()
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

function CardProgressionFavorRewardTipsDescNode:FreshUI(data)
    local icon = data.icon
    local text = data.text

    self.ImgGoodsIcon:LoadSprite(icon)
    self.TextDesc.text = text
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


return CardProgressionFavorRewardTipsDescNode
