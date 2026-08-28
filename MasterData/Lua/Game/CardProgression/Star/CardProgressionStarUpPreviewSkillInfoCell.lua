
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
local LayoutRebuilder  = CS.UnityEngine.UI.LayoutRebuilder
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaStarupPreview.prefab > name: Cell
---@class CardProgressionStarUpPreviewSkillInfoCell
---@field Env                           	CardProgressionStarUpPreviewSkillInfoCell
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field StarUpSkillInfoNode2          	UnityEngine.RectTransform               
---@field Cell                          	UnityEngine.RectTransform               
---@field StarUpSkillInfoNode1          	UnityEngine.RectTransform               
local CardProgressionStarUpPreviewSkillInfoCell = Class('CardProgressionStarUpPreviewSkillInfoCell')

function CardProgressionStarUpPreviewSkillInfoCell:__init()
    


end


function CardProgressionStarUpPreviewSkillInfoCell:__delete()

end


function CardProgressionStarUpPreviewSkillInfoCell:Awake()
    self._skillInfoNodes = {self.StarUpSkillInfoNode1, self.StarUpSkillInfoNode2}
end




function CardProgressionStarUpPreviewSkillInfoCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function CardProgressionStarUpPreviewSkillInfoCell:FreshUI(data, cardId, originStar, maxStar, isFullDesc)
    for index, node in ipairs(self._skillInfoNodes) do
        local skillInfo = data[index]
        ---@type CardProgressionStarUpSkillInfoNode
        local env = self:GetSkillNodeEnv(node)
        if isNotNull(env) then
            local isShow = skillInfo ~= nil
            env:SetActive(isShow)
            if isShow then
                env:FreshUI(skillInfo, maxStar, cardId, originStar, isFullDesc)
            end
        end
    end

    LayoutRebuilder.ForceRebuildLayoutImmediate(self.Cell)


end

--endregion 


--region get/set 

function CardProgressionStarUpPreviewSkillInfoCell:GetSkillNodeEnv(node)
    ---@type CardProgressionStarUpSkillInfoNode
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionStarUpSkillInfoNode)
    return env
end

---endregion 


--region handler 


---endregion 


return CardProgressionStarUpPreviewSkillInfoCell
