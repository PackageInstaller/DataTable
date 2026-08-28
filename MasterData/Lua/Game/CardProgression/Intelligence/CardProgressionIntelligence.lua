--- 养成-情报界面

local import = import
------------ import ------------
---@type CardConfMgr
local cardConfMgr               = CardConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils      = import("Game.CardProgression.CardProgressionUtils")
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
---@type MaidCoffeeUtils
local MaidCoffeeUtils           = import("Game.MaidCoffee.MaidCoffeeUtils")
---@type Engine.Lib.KTool
local KTool                     = CS.Engine.Lib.KTool
---@type UnityEngine.UI.LayoutRebuilder
local LayoutRebuilder           = CS.UnityEngine.UI.LayoutRebuilder
---@type DG.Tweening.Ease
local OutSine                   = CS.DG.Tweening.Ease.OutSine
---@type FishingUtils
local FishingUtils = import('Game.UI.Fishing.FishingUtils')
------------ import ------------


------------ define ------------
local AnimationName = {
    AttrGo         = "CultivateInteligenceAttrExpandGo",
    AttrBack       = "CultivateInteligenceAttrExpandBack",
    LeftSkillGo    = "CultivateInteligenceLifeSkillNodeGo",
    LeftSkillBack  = "CultivateInteligenceLifeSkillNodeBack",
    StarEffectGo   = "CultivateInteligenceStarupEffectNodeGo",
    StarEffectBack = "CultivateInteligenceStarupEffectNodeBack",
}

local AttrExpendOffset      = 351
local LifeSkillExpendOffset = 505
local StarEffectExpendOffset = 400

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaIntelligence.prefab > name: CultivateOverseaIntelligence
---@class CardProgressionIntelligence
---@field Env                           	CardProgressionIntelligence             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgIconFishing                	Game.Native.Common.UISwitchImage        
---@field TextDescFishing               	CustomText                     
---@field TextTitleFishing              	UnityEngine.UI.Text                     
---@field SkillNode2                    	UnityEngine.RectTransform               
---@field ImgIconTakeaway               	Game.Native.Common.UISwitchImage        
---@field TextDescTakeaway              	CustomText                     
---@field TextTitleTakeaway             	UnityEngine.UI.Text                     
---@field SkillNode1                    	UnityEngine.RectTransform               
---@field BtnArrowLife                  	UnityEngine.RectTransform               
---@field BtnAreaLife                   	UnityEngine.RectTransform               
---@field LifeSkillNodeAni              	UnityEngine.Animation                   
---@field LifeSkillNode                 	UnityEngine.RectTransform                   
---@field StarUpEffect2                 	UnityEngine.RectTransform               
---@field StarUpEffect1                 	UnityEngine.RectTransform               
---@field BtnArrowStarEffect            	UnityEngine.RectTransform               
---@field BtnAreaStarEffect             	UnityEngine.RectTransform               
---@field StarUpEffectNodeAni           	UnityEngine.Animation                   
---@field StarUpEffectNode              	UnityEngine.RectTransform               
---@field SkillDescGroup                	UnityEngine.RectTransform               
---@field SkillNode                     	UnityEngine.RectTransform               
---@field SliderWhite                   	UnityEngine.UI.Slider                   
---@field TxtNumberLevel                	TMPro.TextMeshProUGUI                   
---@field TxtNumberArmed                	TMPro.TextMeshProUGUI                   
---@field BtnArmed                      	UnityEngine.RectTransform               
---@field BtnArrowAttr                  	UnityEngine.RectTransform               
---@field MaskRoot                      	UnityEngine.RectTransform               
---@field BtnAreaAttr                   	UnityEngine.RectTransform               
---@field ItemAttribute                 	UnityEngine.RectTransform               
---@field StarLevelNode                 	UnityEngine.RectTransform               
---@field RoleRareNode                  	UnityEngine.RectTransform               
---@field RightPanel                    	UnityEngine.RectTransform               
---@field Content                       	UnityEngine.RectTransform               
---@field AnimRoot                      	UnityEngine.Animation                   
local CardProgressionIntelligence = Class('CardProgressionIntelligence')

function CardProgressionIntelligence:__init()
    self._isInitialize = false
    ---@type CardProgressionEntity
    self._entity = nil
    --self._symbolNodes = {}
    self._skillNodes = {}
    self._starSkillEffectEnvs = {}

    self._isExpendAttr = false
    self._isExpendLifeSkill = false
    self._isExpendStarEffect = false
end

function CardProgressionIntelligence:__delete()
    self:StopExpendAnim()

end

function CardProgressionIntelligence:Awake()
    self.locationTrans = self.RightPanel:Find("Location").transform


    local zero = Vector2.zero
    self.Content.offsetMin = zero
    self.Content.offsetMax = zero
end

function CardProgressionIntelligence:Start()
    local Bind = Bind
    local SetButtonAction = SetButtonAction
    SetButtonAction(self.BtnArmed,     Bind(self, self.OnBtnArmedAction))
    SetButtonAction(self.BtnAreaAttr,  Bind(self, self.OnBtnAreaAttrAction))
    SetButtonAction(self.BtnArrowAttr, Bind(self, self.OnBtnArrowAttrAction))
    -- SetButtonAction(self.BtnArrowLife, Bind(self, self.OnBtnArrowLifeAction))
    SetButtonAction(self.BtnAreaLife,  Bind(self, self.OnBtnBtnAreaLifeAction))
    -- SetButtonAction(self.BtnArrowStarEffect, Bind(self, self.OnBtnArrowStarEffectAction))
    SetButtonAction(self.BtnAreaStarEffect,  Bind(self, self.OnBtnAreaStarEffectAction))

    CardProgressionUtils.RegRoleSwipeRegion(self.controller)
end

function CardProgressionIntelligence:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

--- OnInitialize
---@param entity CardProgressionEntity
function CardProgressionIntelligence:OnInitialize(entity, isPreview)
    if self._isInitialize then return end
    self._isInitialize = false

    local starEffect2LifeSkillOffsetY = self.LifeSkillNode.anchoredPosition.y - self.StarUpEffectNode.anchoredPosition.y
    self._starEffect2LifeSkillOffsetY = starEffect2LifeSkillOffsetY
    -- print("starEffect2LifeSkillOffsetY", self.LifeSkillNode.anchoredPosition.y, self.StarUpEffectNode.anchoredPosition.y)

    self._maxAdvanceLevel = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.MaxAdvanceLevel))
    
    self._entity = entity

    self._isPreview = isPreview

    self:FreshUI(entity)
end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshUI
---@param entity CardProgressionEntity
---@param isReload boolean | nil
function CardProgressionIntelligence:FreshUI(entity, isReload)
    ---@type CardDojo
    local cardDojo = entity.cardDojo
    local cardId   = cardDojo.cardId
    ---@type CardVo
    local cardVo = cardConfMgr:GetCardByRefId(cardId)
    local star = checkNumber(cardDojo.star)
    local isChangeCardId = self._cardId ~= cardId
    self._cardId, self._star = cardId, star

    if isChangeCardId then
        self._cardStarVos = {}
        cardConfMgr:WalkAllStarEffect(cardId, function (vo, index)
            table.insert(self._cardStarVos, vo)
        end)

        self:ResetExpendAni()
    end

    self:FreshStarNodes(star)
    ---刷新稀有度信息
    self:FreshRoleRareNode(cardDojo:GetRare(), cardId)

    local attributes, combatEffectiveness = self:GetAttributesAndCombatPower(entity, cardDojo.cardId, isReload)
    ---刷新属性
    self:FreshAttributes(attributes)
    ---刷新战斗力
    self:FreshCombatEffectiveness(combatEffectiveness)
    ---刷新等级信息
    self:FreshLevelInfo(cardDojo, cardVo.rare)
    ---刷新技能信息
    self:FreshSkillInfo(cardDojo, cardVo)
    ---刷新升星效果
    ---@type UnityEngine.RectTransform
    local StarUpEffectNode = self.StarUpEffectNode
    local isShowStarEffect = self._cardStarVos ~= nil and next(self._cardStarVos) ~= nil
    KTool.SetActive(StarUpEffectNode.gameObject, isShowStarEffect)
    if self._isExpendStarEffect then
        self:FreshStarEffect(self._cardId, self._star)
    end

    self:FreshLifeSkill(cardId)
    
end

function CardProgressionIntelligence:FreshStarNodes(star)
    ---@type CardProgressionStarGroupNode
    local env = CfUtils.GetLuaScr(self.StarLevelNode, CardProgressionConstants.EnvPath.CardProgressionStarGroupNode)
    if isNull(env) then return end
    env:FreshUI(star)
end

function CardProgressionIntelligence:FreshRoleRareNode(rare, cardId)
    ---@type CardProgressionRoleRareNode
    local env = CfUtils.GetLuaScr(self.RoleRareNode, CardProgressionConstants.EnvPath.CardProgressionRoleRareNode)
    if isNull(env) then return end
    env:FreshUI(rare, cardId)

    if self._isPreview then
        env:FreshCV()
    end
        
end

function CardProgressionIntelligence:FreshAttributes(t)
    ---@type CardProgressionAttributeGroupNode
    local env = CfUtils.GetLuaScr(self.MaskRoot, CardProgressionConstants.EnvPath.CardProgressionAttributeGroupNode)
    if isNull(env) then return end
    env:SetTargetNode(self.locationTrans)
    env:FreshUI(t)

end

function CardProgressionIntelligence:FreshCombatEffectiveness(text)
    self.TxtNumberArmed.text = text

end

--- FreshCardInfo
---@param cardDojo CardDojo
---@param initRare number 初始稀有度
function CardProgressionIntelligence:FreshLevelInfo(cardDojo, initRare)
    local advanceLevel = cardDojo.advanceLevel
    local maxLevel     = cardConfMgr:GetCardMaxLevel(advanceLevel)
    local cardLevel    = cardDojo.cardLevel
    self.TxtNumberLevel.text = string.format("<size=42><color #ffffff>%s</color></size>/%s", cardLevel, maxLevel)

    local progressOrigin   = CardProgressionUtils.CalcUpgradeLevelExp(cardDojo, 0, initRare, maxLevel)
    self.SliderWhite.value = progressOrigin

end

--- FreshSkillInfo
---@param cardDojo CardDojo
function CardProgressionIntelligence:FreshSkillInfo(cardDojo, cardVo)
    self:FreshSkillNodes(cardDojo, cardVo)

end

--- FreshSkillNodes
---@param cardDojo CardDojo
---@param cardVo CardVo
function CardProgressionIntelligence:FreshSkillNodes(cardDojo, cardVo)
    local finalSkillLevel, awakeningLevel = checkNumber(cardDojo.finalSkillLevel), checkNumber(cardDojo.awakeningLevel)
    local skills = CardProgressionSkillUtils.InitSkills(cardVo, awakeningLevel, finalSkillLevel)
    for i, skillInfo in ipairs(skills) do
        local node = self._skillNodes[i]
        if isNull(node) then
            node = self.SkillNode:GetChild(i - 1)
            node = node:Find("SkillCardNode")
            self._skillNodes[i] = node
        end
        self:FreshSkillNode(node, skillInfo, cardVo)
        
    end
end

--- FreshSkillNode
---@param node UnityEngine.RectTransform
---@param skillInfo table
---@param cardVo CardVo
function CardProgressionIntelligence:FreshSkillNode(node, skillInfo, cardVo)
    ---@type CardProgressionSkillNode
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionSkillNode)
    if isNull(env) then return end
    env:FreshUI(skillInfo, cardVo)
    -- env:SetTargetNode(self.RightPanel)
    env:SetTargetNode(self.locationTrans)

end

function CardProgressionIntelligence:FreshStarEffect(cardId, star, isForce)
    local forTimes = math.max(#self._cardStarVos, #self._starSkillEffectEnvs)
    -- print("forTimes", forTimes, table.toString(self._cardStarVos))
    for index = 1, forTimes do
        local vo = self._cardStarVos[index]
        local isShow = vo ~= nil
        ---@type CardProgressionIntelligenceStarUpEffectNode
        local env = self:GetStarSkillEffectEnv(index)
        if isNotNull(env) then
            env:SetActive(isShow)
            if isShow then
                env:FreshUI(cardId, star, vo)
            end
        end

    end
   
    
end

---FreshLifeSkill
---刷新生活技能
function CardProgressionIntelligence:FreshLifeSkill(cardId, isForce)
    local isShowTakeaway = false
    ---@type MaidCoffeeCardInfoVo
    local vo = MaidCoffeeUtils.GetCardManagerInfoVo(cardId)
    if vo then
        self.ImgIconTakeaway.Status = vo.job
        ---存在经营技能
        ---@type MaidCoffeeSkillVo
        local skillVo = MaidCoffeeUtils.GetMaidCoffeeSkillInfoVo(vo.additionId)
        if skillVo then
            isShowTakeaway = true
            local desc = MaidCoffeeUtils.FillCoffeeSkillDescription(skillVo.decr, vo.additionNum,nil,vo.percentage)
            self.TextDescTakeaway.text = desc
            self.TextTitleTakeaway.text = skillVo.name
        else
            self.TextDescTakeaway.text = localize("暂无经营技能")
            self.TextTitleTakeaway.text = localize("外卖员")
        end
    else
        self.TextDescTakeaway.text = localize("暂无经营技能")
        self.TextTitleTakeaway.text = localize("外卖员")
    end

    local isShowFish = false
    ---@type FishingCardBonusVo
    local bonusVo = FishingUtils.GetFishingCardBonusVo(cardId)
    if bonusVo then
        ---@type FishingBonusEffectVo
        local effectVo = FishingUtils.GetFishingBonusEffectVo(bonusVo.additionType1)
        if effectVo then
            self.ImgIconFishing.Status = effectVo.additionPic
            local t = FishingUtils.GetFishCardBuffData(cardId, Constants.ChooseCardStatus.FishAccompany)
            local descList = {}
            for i, data in ipairs(t) do
                local additionDesc = FishingUtils.GetAdditionDesc(data.buffData)
                 table.insert(descList, additionDesc) 
            end
            self.TextDescFishing.text = table.concat(descList, "\n")
            isShowFish = true
        else
            self.TextDescFishing.text = localize("暂无垂钓技能")    
        end
    else
        self.TextDescFishing.text = localize("暂无垂钓技能")
    end
    
    self._isShowFish = isShowFish
    self._isShowTakeaway = isShowTakeaway
    self:FreshLifeSkillShowState(isShowFish, isShowTakeaway, isForce)

    
end

function CardProgressionIntelligence:FreshLifeSkillShowState(isShowFish, isShowTakeaway, isForce)
    local isShow = isShowFish or isShowTakeaway
    
    KTool.SetActive(self.SkillNode1.gameObject, isShowTakeaway and isForce == true)
    KTool.SetActive(self.SkillNode2.gameObject, isShowFish and isForce == true)
    KTool.SetActive(self.LifeSkillNode.gameObject, isShow)
end


function CardProgressionIntelligence:ResetExpendAni()
    if self._isExpendLifeSkill then
       self:OnBtnBtnAreaLifeAction() 
    end
    if self._isExpendStarEffect then
        self:OnBtnAreaStarEffectAction()
     end

end

function CardProgressionIntelligence:CloseStarUpEffects()
    ---@param env CardProgressionIntelligenceStarUpEffectNode
    for index, env in ipairs(self._starSkillEffectEnvs) do
        if isNotNull(env) then
            env:SetActive(false)
        end
    end
end

function CardProgressionIntelligence:CloseLifeSkillNodes()
    KTool.SetActive(self.SkillNode1.gameObject, false)
    KTool.SetActive(self.SkillNode2.gameObject, false)
end

--- OnEnter
--- 进入时调用
function CardProgressionIntelligence:OnEnter()
    
    
end

--- OnEnter
--- 离开时时调用
function CardProgressionIntelligence:OnLeave()
    
    
end

--- OnReload
--- 重载页面
function CardProgressionIntelligence:OnReload(entity)
    --------------------------
    --- 数据更新
    self._entity = entity

    --------------------------
    --- UI更新
    self:FreshUI(entity, true)
    
end



---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

---@param entity CardProgressionEntity
---@param cardId integer
---@param isReload boolean | nil
function CardProgressionIntelligence:GetAttributesAndCombatPower(entity, cardId, isReload)
    local t, combatEffectiveness
    if self._attributes == nil or isReload then
        ---@type CardVo
        local cardVo = cardConfMgr:GetCardByRefId(cardId)
        ---@type CatTypeVo
        local cardTypeVo = cardConfMgr:GetCatTypeVoById(cardVo.catType)
        t = {
            {order = -3, icon = CardProgressionConstants.AssetPath.Attribute, name = localize("属性"), cardAttrId = cardVo.attributeType,           viewType = CardProgressionConstants.AttrNodeType.CardAttr},
            {order = -2, icon = CardProgressionConstants.AssetPath.Race,      name = localize("阵营"), raceId = cardVo.race,                        viewType = CardProgressionConstants.AttrNodeType.Race},
            {order = -1, icon = CardProgressionConstants.AssetPath.CatType,   name = localize("血统"), desc = cardTypeVo and cardTypeVo.name or "", viewType = CardProgressionConstants.AttrNodeType.CatType},
        }
        local attribute_format = attribute_format
        ---@param vo AttrDefinesVo
        ---@param num number
        combatEffectiveness = FormulaUtils.CalcCardCombatEffectiveness(entity, nil, function (vo, num, index)
            local order = vo.order
            if vo.order > 0 then
                local text = attribute_format(vo.isConversion, num)
                table.insert(t, {
                    order = order,
                    vo    = vo,
                    icon = vo.icon,
                    name = vo.name,
                    attrNum = text,
                    viewType = CardProgressionConstants.AttrNodeType.Single,
                })
            end
        end)
        table.sort(t, function(a, b) return a.order < b.order end)
        self._attributes = t
        self._combatEffectiveness = combatEffectiveness
    else
        t = self._attributes
        combatEffectiveness = self._combatEffectiveness
    end
    return t, combatEffectiveness
end

---GetStarSkillEffectEnv
---@return CardProgressionIntelligenceStarUpEffectNode
function CardProgressionIntelligence:GetStarSkillEffectEnv(index)
    local env = self._starSkillEffectEnvs[index]
    if isNull(env) then
        local child = self.StarUpEffect1.gameObject
        local node = index == 1 and child or self.Layout.gameObject:AddChild(child)
        node.name = string.format("StarUpEffect%d", index)
        -- KTool.SetActive(node, true)
        ---@type CardProgressionIntelligenceStarUpEffectNode
        env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionIntelligenceStarUpEffectNode)
        self._starSkillEffectEnvs[index] = env
    end
    return env
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionIntelligence:OnBtnAreaAttrAction()
    self:PlayExpendAttrAnim()
end

function CardProgressionIntelligence:OnBtnArrowAttrAction()
    self:PlayExpendAttrAnim()
end

function CardProgressionIntelligence:PlayExpendAttrAnim()
    self._isExpendAttr = not self._isExpendAttr 
    self.AnimRoot:Play(self._isExpendAttr and AnimationName.AttrGo or AnimationName.AttrBack)
    KTool.SetActive(self.BtnAreaAttr.gameObject, self._isExpendAttr)

    ---@type UnityEngine.Vector2
    local offsetMin = self.Content.offsetMin
    offsetMin.y  = offsetMin.y + (self._isExpendAttr and -1 or 1) * AttrExpendOffset
    self.Content.offsetMin = offsetMin
end

function CardProgressionIntelligence:OnBtnAreaStarEffectAction()
    if self._isExpendStarEffect then
        self:CloseStarUpEffects()
    else
        self:FreshStarEffect(self._cardId, self._star)
    end
    
    self:PlayExpendStarEffectAnim()
end


function CardProgressionIntelligence:PlayExpendStarEffectAnim()
    local isExpendStarEffect = not self._isExpendStarEffect
    self._isExpendStarEffect = isExpendStarEffect
    self.StarUpEffectNodeAni:Play(isExpendStarEffect and AnimationName.StarEffectGo or AnimationName.StarEffectBack)
    self:PlayExpendAnimByTrans(self.StarUpEffectNode, isExpendStarEffect)
    
end


function CardProgressionIntelligence:OnBtnBtnAreaLifeAction()
    if self._isExpendLifeSkill then
        self:CloseLifeSkillNodes()
        
    else
        -- self:FreshLifeSkill(self._cardId, true)
        self:FreshLifeSkillShowState(self._isShowFish, self._isShowTakeaway, true)
        
    end
    self:PlayExpendLifeSkillAnim()

end


function CardProgressionIntelligence:PlayExpendLifeSkillAnim()
    self._isExpendLifeSkill = not self._isExpendLifeSkill 
    self.LifeSkillNodeAni:Play(self._isExpendLifeSkill and AnimationName.LeftSkillGo or AnimationName.LeftSkillBack)

    self:PlayExpendAnimByTrans(self.LifeSkillNode, self._isExpendLifeSkill)

end

function CardProgressionIntelligence:StopExpendAnim()
    if isNotNull(self._sequence) then
        self._sequence:Kill(true)
        self._sequence = nil
    end
end
function CardProgressionIntelligence:PlayExpendAnimByTrans(trans, isExpend)
    self:StopExpendAnim()
    local oldHeight = trans.sizeDelta.y
    -- print("oldHeight", oldHeight)
    LayoutRebuilder.ForceRebuildLayoutImmediate(self.SkillDescGroup)
    local newHeight = trans.sizeDelta.y
    -- print("newHeight", newHeight)
    local offset = math.max(newHeight, oldHeight)

    ---@type UnityEngine.Vector2
    local offsetMax = self.Content.offsetMax
    ---@type UnityEngine.Vector2
    local offsetMin = self.Content.offsetMin
    
    local height = math.abs(offsetMax.y) + math.abs(offsetMin.y)
    height = height + (isExpend and 1 or -1) * offset
    offsetMax.y =  height
    offsetMin.y  = 0
    
    local time     = 0.45
    local ease     = OutSine
    local DOTween  = CS.DG.Tweening.DOTween
    local sequence = DOTween.Sequence()
    sequence:Append(self.Content:DoOffSetMax(offsetMax, time, ease))
    sequence:Insert(0, self.Content:DoOffSetMin(offsetMin, time, ease))
    sequence:OnKill(function ()
        self.Content.offsetMax = offsetMax
        self.Content.offsetMin = offsetMin
        self._sequence = nil
    end)
    self._sequence = sequence

end

-- function CardProgressionIntelligence:FixLifeSkillNodePosition()
--     ---@type UnityEngine.RectTransform
--     local LifeSkillNode = self.LifeSkillNode
--     ---@type UnityEngine.RectTransform
--     local StarUpEffectNode = self.StarUpEffectNode
--     if self._isExpendStarEffect then
--         LifeSkillNode.anchoredPosition = Vector2.New(LifeSkillNode.anchoredPosition.x, StarUpEffectNode.anchoredPosition.y - StarEffectExpendOffset + self._starEffect2LifeSkillOffsetY)
--     else
--         LifeSkillNode.anchoredPosition = Vector2.New(LifeSkillNode.anchoredPosition.x, StarUpEffectNode.anchoredPosition.y + self._starEffect2LifeSkillOffsetY)
--     end

-- end


function CardProgressionIntelligence:OnBtnArmedAction()
    CardProgressionUtils.ShowCombatEffectivenessTips(self.RightPanel, self._entity)

end


-- function CardProgressionIntelligence:OnClickBtnArchivesAction()
--     local cardDojo = self._entity.cardDojo
--     CardProgressionUtils.OpenDialog(
--         Constants.UITypeIds.CardProgressionIntroduction, 
--         {cardId = cardDojo.cardId, favorLevel = cardDojo.favorabilityLevel}, 
--         {
--             UIArgs(Constants.UITypeIds.CultivateMain)
--         }
--     )
-- end

-- function CardProgressionIntelligence:OnClickBtnFeelingAction()
--     CardProgressionUtils.OpenDialog(
--         Constants.UITypeIds.cARDPRO, 
--         {playerCardId = self._entity.cardDojo.id},
--         {
--             UIArgs(Constants.UITypeIds.CultivateMain)
--         }
--     )
-- end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionIntelligence
