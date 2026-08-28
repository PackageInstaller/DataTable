
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
------------ import ------------


------------ define ------------
local cardConfMgr = CardConfMgr:GetInstance()
local checkNumber = checkNumber
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaBreakNode.prefab > name: CultivateOverseaBreakNode
---@class CardProgressionBreakNode
---@field Env                           	CardProgressionBreakNode                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextDesc2                     	UnityEngine.UI.Text                     
---@field TextTitle                     	UnityEngine.UI.Text                     
---@field ImgIcon                       	Engine.UI.ImageAlterable                
---@field SkillIcon                     	UnityEngine.RectTransform               
---@field DescNode2                     	UnityEngine.RectTransform               
---@field TextDesc1                     	UnityEngine.UI.Text                     
---@field DescNode1                     	UnityEngine.RectTransform               
---@field SkillDescScrollViewBig        	UnityEngine.RectTransform               
---@field ImgArrow                      	UnityEngine.RectTransform               
---@field TextNumberAfter               	TMPro.TextMeshProUGUI                   
---@field TextLv2                       	UnityEngine.RectTransform               
---@field TextNumberBefore              	TMPro.TextMeshProUGUI                   
---@field Level                         	UnityEngine.RectTransform               
---@field TextName                      	CustomText                     
---@field CurrentInformation            	UnityEngine.RectTransform               
---@field SkillCardNode                 	UnityEngine.RectTransform
---@field StatusMax                     	UnityEngine.RectTransform               
---@field SkillLevel                    	UnityEngine.RectTransform               
---@field Placeholder                   	UnityEngine.RectTransform               
local CardProgressionBreakNode = Class('CardProgressionBreakNode')

function CardProgressionBreakNode:__init()
    self._symbolNodes     = {}
    self._symbolGlowNodes = {}
end


function CardProgressionBreakNode:__delete()

end


function CardProgressionBreakNode:Awake()
    KTool.SetActive(self.SkillDescScrollViewBig.gameObject, true)
    KTool.SetActive(self.DescNode1.gameObject, false)
    KTool.SetActive(self.DescNode2.gameObject, false)
    KTool.SetActive(self.Level.gameObject, false)
--     --local parent     = self.BreakSymbol
--     -- self._maxBreakTimes = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.MaxBreakTimes))
--     --for i = 1, self._maxBreakTimes - 1, 1 do
--     --    local symbol = parent:Find(string.format("Symbol%s", i))
--     --    local imgSymbol     = symbol:Find(string.format("ImgSymbol%s", i)) 
--     --    local imgSymbolGlow = symbol:Find("ImgSymbolGlow") 
--     --    KTool.SetActive(symbol.gameObject, true)
--     --    KTool.SetActive(imgSymbol.gameObject, false)
--     --    KTool.SetActive(imgSymbolGlow.gameObject, false)
--     --    --local child = parent:GetChild(i - 1)
--     --    --local uiSwitch = KTool.GetComponent(child.gameObject, CardProgressionConstants.CompType.UISwitchImageType)
--     --    table.insert(self._symbolNodes, imgSymbol)
--     --    table.insert(self._symbolGlowNodes, imgSymbolGlow)
--     --    
--     --end
    
--     --self.BreakTitleNodeAni = self.BreakTitleNode.gameObject:GetComponent(typeof(CS.UnityEngine.Animator))
    
end


-- function CardProgressionBreakNode:Start()
--     -- SetButtonAction(self.BtnUpgrade, Bind(self, self.OnClickExpandBtnAction))
-- end


function CardProgressionBreakNode:OnDestroy()
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

---FreshStarUpUI
---@param cardId number 卡牌id
---@param star number 卡牌星级
---@param cardDojo CardDojo 卡牌数据
---@param isHandlePlaceholder boolean 是否处理占位符
---@param isStarUpPreview boolean 是否是升星预览
function CardProgressionBreakNode:FreshStarUpUI(cardId, star, cardDojo, isHandlePlaceholder, isStarUpPreview)
    ---@type CardStarVo
    local starVo          = cardConfMgr:GetCardStarInfo(cardId, star)
    local spLevel         = starVo.spLevel
    local spDescId        = starVo.spDescId
    local passiveLevel    = starVo.passiveLevel
    local initOpenAbility = starVo.initOpenAbility

    local isShowStarEffect = self:FreshStarEffectInfo(initOpenAbility, star)
    
    self:FreshSkillInfo(spLevel, passiveLevel, cardId, cardDojo, isHandlePlaceholder == true and isShowStarEffect, isStarUpPreview and spDescId or nil)
    KTool.SetActive(self.Placeholder.gameObject, not isShowStarEffect and isHandlePlaceholder == true)
   
end

function CardProgressionBreakNode:FreshSkillInfo(spLevel, passiveLevel, cardId, cardDojo, isHideDesc, spDescId)
    local currentLv, nextLv
    local isMaxLv = false
    local skillName
    local desc
    local skillId
    local skillGroupType
    ---@type CardVo
    local cardVo          = cardConfMgr:GetCardByRefId(cardId)
    if spLevel > 0 then
        nextLv = cardConfMgr:GetFinalSkillDisplayLevel(spLevel) 
        currentLv = cardDojo and cardDojo.finalSkillLevel or nextLv
        isMaxLv = currentLv >= nextLv
        skillId = cardVo.skillNode.finalSkill
        skillGroupType = CardProgressionConstants.SkillGroupType.Final
        desc, skillName = CardProgressionSkillUtils.GetSkillInfo(skillId, nextLv, CardProgressionConstants.SkillGroupType.Final, false, cardVo.rare, false, spDescId)
    elseif passiveLevel > 0 then
        nextLv    = passiveLevel
        currentLv = cardDojo and cardDojo.awakeningLevel or nextLv
        isMaxLv   = currentLv >= nextLv
        skillId   = CardProgressionSkillUtils.GetTalentId(cardId, passiveLevel)
        skillGroupType = CardProgressionConstants.SkillGroupType.Buff

        desc, skillName = CardProgressionSkillUtils.GetSkillInfo(skillId, nextLv, CardProgressionConstants.SkillGroupType.Buff, false)

    end

    local isShowSkill = skillId ~= nil
    KTool.SetActive(self.SkillLevel.gameObject, isShowSkill)
    
    if not isShowSkill then return isShowSkill end

    self:FreshSkillCardNode({skillId, nextLv, skillGroupType}, cardVo)
    self:FreshCurrentInformation(skillName, currentLv, nextLv)
    self:FreshSkillDesc(desc, isHideDesc)

    return isShowSkill
end

function CardProgressionBreakNode:FreshSkillCardNode(data, cardVo, isHideLv)
    ---@type CardProgressionSkillNode
    local env = self:GetSkillNodeEnv()
    if isNull(env) then return end
    env:FreshUI(data, cardVo, true)
    
end

function CardProgressionBreakNode:FreshCurrentInformation(skillName, currentLv, nextLv)
    self.TextName.text = skillName

    -- local isShowNext = nextLv > currentLv
    -- KTool.SetActive(self.TextLv2.gameObject, isShowNext)
    -- KTool.SetActive(self.TextNumberAfter.gameObject, isShowNext)
    -- KTool.SetActive(self.ImgArrow.gameObject, isShowNext)

    -- self.TextNumberBefore.text = currentLv

    -- if isShowNext then
    --     self.TextNumberAfter.text = nextLv

    -- end

end

function CardProgressionBreakNode:FreshSkillDesc(desc, isHideDesc)
    KTool.SetActive(self.DescNode1.gameObject, not isHideDesc)
    if isHideDesc then return end
    self.TextDesc1.text = desc

end

function CardProgressionBreakNode:FreshStarEffectInfo(talentId, star)
    local desc
    local icon
    local starEffectName
    if talentId and talentId > 0 then
        starEffectName = localize("_num_星效果", {_num_ = star})
        ---@type TalentVo
        local talentVo = cardConfMgr:GetTalentByRefId(talentId)
        icon = talentVo.iconPath
        desc = CardProgressionSkillUtils.GetSkillInfo(talentId, 1, CardProgressionConstants.SkillGroupType.Buff, false)
    end

    local isShowStarEffect = icon ~= nil
    KTool.SetActive(self.DescNode2.gameObject, isShowStarEffect)
    if not isShowStarEffect then
        return isShowStarEffect
    end

    self:FreshStarEffectUI(starEffectName, icon, desc)

    return isShowStarEffect
end

function CardProgressionBreakNode:FreshStarEffectUI(starEffectName, icon, desc)
    self.TextTitle.text = starEffectName
    self.ImgIcon:LoadSprite(icon)
    self.TextDesc2.text = desc
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

---GetSkillNodeEnv
---@return CardProgressionSkillNode
function CardProgressionBreakNode:GetSkillNodeEnv()
    if isNull(self._skillNodeEnv) then
        ---@type CardProgressionSkillNode
        local env = CfUtils.GetLuaScr(self.SkillCardNode, CardProgressionConstants.EnvPath.CardProgressionSkillNode)
        self._skillNodeEnv = env

    end

    return self._skillNodeEnv

end


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

-- function CardProgressionBreakNode:OnClickExpandBtnAction()
--     if self._callback then
--         self._callback(self._skillType)
--     end
-- end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionBreakNode
