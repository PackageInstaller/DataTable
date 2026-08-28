
--region global define
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
local CfUtils   = CfUtils

--endregion

--region import
---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
---@type CardConfMgr
local cardConfMgr               = CardConfMgr:GetInstance()
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/StarupSkillInfoNode.prefab > name: StarupSkillInfoNode
---@class CardProgressionStarUpSkillInfoNode
---@field Env                           	CardProgressionStarUpSkillInfoNode      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextDesc                      	UnityEngine.UI.Text                     
---@field TextName                      	CustomText                              
---@field SkillCardNode                 	UnityEngine.RectTransform               
---@field InitialSkill                  	UnityEngine.RectTransform               
---@field StarSkillTextDesc             	UnityEngine.UI.Text                     
---@field StarSkillTextName             	CustomText                              
---@field ImgNew                        	UnityEngine.RectTransform               
---@field ImgIcon                       	Engine.UI.ImageAlterable                
---@field AddPassiveSkill               	UnityEngine.RectTransform               
local CardProgressionStarUpSkillInfoNode = Class('CardProgressionStarUpSkillInfoNode')

function CardProgressionStarUpSkillInfoNode:__init()
    self._skillNodeEnv = nil
end


function CardProgressionStarUpSkillInfoNode:__delete()

end


-- function CardProgressionStarUpSkillInfoNode:Awake()
-- end


-- function CardProgressionStarUpSkillInfoNode:Start()
-- end


function CardProgressionStarUpSkillInfoNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function CardProgressionStarUpSkillInfoNode:FreshUI(skillData, currentStar, cardId, originStar, isFullDesc)
    ---@type CardProgressionConstants.SkillType
    local skillType = skillData.skillType

    local isStarEffectSkill = skillType == CardProgressionConstants.SkillType.Star

    CfUtils.SetActive(self.AddPassiveSkill, isStarEffectSkill)
    CfUtils.SetActive(self.InitialSkill,    not isStarEffectSkill)

    if isStarEffectSkill then
        self:FreshStarEffectSkillUI(skillData, currentStar)

    else
        self:FreshSkillUI(skillData, cardId, originStar, currentStar, isFullDesc)
        
    end

end

--region star skill UI

---FreshStarEffectSkillUI
---刷新星级效果技能
function CardProgressionStarUpSkillInfoNode:FreshStarEffectSkillUI(skillData, currentStar)
    ---@type CardStarVo
    local starVo   = skillData.starVo
    local star     = skillData.star
    local talentId = starVo.initOpenAbility
    ---@type TalentVo
    local talentVo = cardConfMgr:GetTalentByRefId(talentId)
    local icon = talentVo.iconPath
    local desc = CardProgressionSkillUtils.GetSkillInfo(talentId, 1, CardProgressionConstants.SkillGroupType.Buff, false)
    local name = localize("_num_星效果", {_num_ = star})

    self.ImgIcon:LoadSprite(icon)
    self.StarSkillTextName.text = name
    self.StarSkillTextDesc.text = desc

    CfUtils.SetActive(self.ImgNew, currentStar == star)

end
--endregion 

--region skill info

---FreshSkillUI
---刷新大招或buff
---@param skillData table
function CardProgressionStarUpSkillInfoNode:FreshSkillUI(skillData, cardId, originStar, currentStar, isFullDesc)
    ---@type CardProgressionConstants.SkillType
    local skillType = skillData.skillType
    local isFinal = skillType == CardProgressionConstants.SkillType.Final
    local isBuff  = skillType == CardProgressionConstants.SkillType.Buff

    ---@type CardStarVo
    local starVo = skillData.starVo
    ---@type CardVo
    local cardVo  = cardConfMgr:GetCardByRefId(cardId)
    local displayLv, skillId, skillGroupType
    local desc, skillName
    if isFinal then
        displayLv = skillData.displayLv
        skillId = cardVo.skillNode.finalSkill
        skillGroupType = CardProgressionConstants.SkillGroupType.Final
        --- 11.22版本改成升星解锁增量
        local spDescId = nil
        -- local spDescId = originStar < currentStar and starVo.spDescId  or nil
        desc, skillName = CardProgressionSkillUtils.GetSkillInfo(skillId, displayLv, CardProgressionConstants.SkillGroupType.Final, false, cardVo.rare, false, spDescId, isFullDesc)

    elseif isBuff then
        displayLv = starVo.passiveLevel
        skillId   = CardProgressionSkillUtils.GetTalentId(cardId, displayLv)
        skillGroupType = CardProgressionConstants.SkillGroupType.Buff

        desc, skillName = CardProgressionSkillUtils.GetSkillInfo(skillId, displayLv, CardProgressionConstants.SkillGroupType.Buff, false)

    end

    self:FreshSkillCardNode({skillId, displayLv, skillGroupType}, cardVo, starVo.star > originStar)
    self.TextName.text = skillName
    self.TextDesc.text = desc

end

function CardProgressionStarUpSkillInfoNode:FreshSkillCardNode(data, cardVo, isPreview)
    ---@type CardProgressionSkillNode
    local env = self:GetSkillNodeEnv()
    if isNull(env) then return end
    env:FreshUI(data, cardVo, true, isPreview)
    
end

--endregion 

--endregion 


--region get/set 

function CardProgressionStarUpSkillInfoNode:SetActive(active)
    CfUtils.SetActive(self.controller, active)

end

---GetSkillNodeEnv
---@return CardProgressionSkillNode
function CardProgressionStarUpSkillInfoNode:GetSkillNodeEnv()
    if isNull(self._skillNodeEnv) then
        ---@type CardProgressionSkillNode
        local env = CfUtils.GetLuaScr(self.SkillCardNode, CardProgressionConstants.EnvPath.CardProgressionSkillNode)
        self._skillNodeEnv = env

    end

    return self._skillNodeEnv

end


---endregion 


--region handler 


---endregion 


return CardProgressionStarUpSkillInfoNode
