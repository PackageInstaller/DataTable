
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaStarup.prefab > name: StarupEffect1
---@class CardProgressionStarUpSkillDescNode
---@field Env                           	CardProgressionStarUpSkillDescNode      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextDesc                      	CustomText        
---@field TxtName                        	UnityEngine.UI.Text                      
---@field ImgIcon                       	Engine.UI.ImageAlterable                
local CardProgressionStarUpSkillDescNode = Class('CardProgressionStarUpSkillDescNode')

function CardProgressionStarUpSkillDescNode:__init()

end


function CardProgressionStarUpSkillDescNode:__delete()

end


function CardProgressionStarUpSkillDescNode:Awake()
end


function CardProgressionStarUpSkillDescNode:Start()
end


function CardProgressionStarUpSkillDescNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param vo CardFinalAndBuffSkillVo
function CardProgressionStarUpSkillDescNode:FreshUI(vo)
    local desc
    --- 角色天赋表id
    local talentId   = vo.initOpenAbility
    if talentId == 0 then return end
    local desc, name, talentVo = CardProgressionSkillUtils.GetCardTalentDescById(talentId)
    self.TextDesc.text = desc

    if self.TxtName then
        self.TxtName.text = name
    end

    local iconPath = talentVo.iconPath
    if self.ImgIcon then
        self.ImgIcon:LoadSprite(iconPath)
    end
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return CardProgressionStarUpSkillDescNode
