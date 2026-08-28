
------------ import ------------
---@type Engine.Lib.KTool
local KTool                    = CS.Engine.Lib.KTool
---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
------------ import ------------


------------ define ------------
-- local cardConfMgr = CardConfMgr:GetInstance()
--local Label = {
--    [CardProgressionConstants.SkillGroupType.Final] = localize("[SP]"),
--    [CardProgressionConstants.SkillGroupType.Buff] = localize("[被动]"),
--}
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaBreakNode.prefab
---@class CardProgressionBreakDescNode
---@field Env                           	CardProgressionBreakDescNode            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextDesc                      	UnityEngine.UI.Text
---@field TextNumber                    	TMPro.TextMeshProUGUI
---@field TitleNode                     	UnityEngine.RectTransform               
local CardProgressionBreakDescNode = Class('CardProgressionBreakDescNode')

function CardProgressionBreakDescNode:__init()

end


function CardProgressionBreakDescNode:__delete()
    
end


function CardProgressionBreakDescNode:Awake()
end


-- function CardProgressionBreakDescNode:Start()
-- end


function CardProgressionBreakDescNode:OnDestroy()
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

---Fresh
---@param skillData table { skillId, level, skillGroupType }
---@param isExpand boolean 是否展开
function CardProgressionBreakDescNode:FreshUI(skillData, isExpand)
    self.TextDesc.text = CardProgressionSkillUtils.GetSkillDescBySkillData(skillData, true)
    
    KTool.SetActive(self.TitleNode.gameObject, isExpand)
    if isExpand then
        self.TextNumber.text = skillData[2]
    end

end

----- FreshUI
-----@param skillData table { skillId, level, skillGroupType }
-----@param cardVo CardVo
--function CardProgressionBreakDescNode:FreshUI(skillData, cardVo, awakeningLevel)
--    self:FreshSkillCardNode(skillData, cardVo)    
--    
--    self:FreshTitleNode(skillData)
--    self:FreshSkillDesc(skillData, cardVo, awakeningLevel)
--
--end
--
--function CardProgressionBreakDescNode:FreshSkillCardNode(skillData, cardVo)
--    ---@type CardProgressionSkillNode
--    local env = CfUtils.GetLuaScr(self.SkillCardNode, CardProgressionConstants.EnvPath.CardProgressionSkillNode)
--    if isNull(env) then return end
--    
--    env:FreshUI(skillData, cardVo)
--
--end
--
--function CardProgressionBreakDescNode:FreshTitleNode(skillData)
--    local skillId, skillLevel, skillGroupType = SafeUnpack(skillData)
--    ---@type SkillCardVo | TalentVo
--    local vo = CardProgressionSkillUtils.GetSkillVoBySkillGroupType(skillId, skillGroupType)
--    local name = skillGroupType == CardProgressionConstants.SkillGroupType.Buff and vo.name or vo.skillName
--    --local label = Label[skillGroupType]
--    --if label then
--    --    self.TextSkill.text = label
--    --end
--    self.TextTitle.text = name
--end
--
----- FreshSkillDesc
-----@param skillData table { skillId, level, skillGroupType }
-----@param cardVo CardVo
-----@param awakeningLevel number
--function CardProgressionBreakDescNode:FreshSkillDesc(skillData, cardVo, awakeningLevel)
--    self.TextDesc.text = CardProgressionSkillUtils.GetSkillDescBySkillData(skillData, cardVo, awakeningLevel, true)
--
--end

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


return CardProgressionBreakDescNode
