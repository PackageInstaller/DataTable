
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
------------ import ------------


------------ define ------------
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFashionUpgradePreview.prefab > name: Cell
---@class CardProgressionStarUpPreviewCell
---@field Env                           	CardProgressionStarUpPreviewCell        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field AttributeNode                 	UnityEngine.RectTransform               	@ 0    
---@field ImgBg                         	UnityEngine.RectTransform               	@ 1    
---@field BtnDetails                    	UnityEngine.RectTransform               	@ 2    
local CardProgressionStarUpPreviewCell = Class('CardProgressionStarUpPreviewCell')

function CardProgressionStarUpPreviewCell:__init()

end


function CardProgressionStarUpPreviewCell:__delete()

end

function CardProgressionStarUpPreviewCell:Start()
    if self.BtnDetails then
        SetButtonAction(self.BtnDetails, Bind(self, self.OnClickBtnDetailsAction))
    end
end


function CardProgressionStarUpPreviewCell:OnDestroy()
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

function CardProgressionStarUpPreviewCell:FreshUI(attribute, position, valInfos)
    self.attribute = attribute
    self.valInfos = valInfos
    if position then
        KTool.SetActive(self.ImgBg.gameObject, (position % 2) ~= 0)
    end
    ---@type CardProgressionAttributeNode
    local env = CfUtils.GetLuaScr(self.AttributeNode, CardProgressionConstants.EnvPath.CardProgressionAttributeNode)
    if not isNull(env) then
        env:FreshUI(attribute)
    end
end

function CardProgressionStarUpPreviewCell:FreshImgBg(position)
    KTool.SetActive(self.ImgBg.gameObject, true)
    self.ImgBg.alpha = (position % 2 == 0) and 0.05 or 0.1 
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

function CardProgressionStarUpPreviewCell:OnClickBtnDetailsAction()
    local attribute = self.attribute
    local valInfos = self.valInfos

    CardProgressionUtils.ShowComTipsFashionDetailsNode(self.controller.gameObject, attribute, valInfos)
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionStarUpPreviewCell
