--- 养成-突破界面

------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionMgr
local CardProgressionMgr        = import("Game.CardProgression.CardProgressionMgr")
---@type CardProgressionUtils
local CardProgressionUtils      = import("Game.CardProgression.CardProgressionUtils")
local DOTween                  = CS.DG.Tweening.DOTween
local cs_coroutine             = require "XLua.cs_coroutine"
------------ import ------------


------------ define ------------
local isNull      = isNull
local cardConfMgr = CardConfMgr:GetInstance()

--local ViewType    = {
--    Normal = 1,
--    Expand = 2,
--}

local ChangeAni = "CultivateOverseaBreak_change"
local BackAni   = "CultivateOverseaBreak_Back"
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaBreak.prefab
---@class CardProgressionBreak
---@field Env                           	CardProgressionBreak                    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnReturn                     	UnityEngine.RectTransform               
---@field CommonBtnConsumePop           	UnityEngine.RectTransform
---@field FontStyleButton               	UnityEngine.RectTransform
---@field CommonGoodsList               	UnityEngine.RectTransform
---@field CultivateOverseaBreakNode     	UnityEngine.RectTransform               
---@field PressBtnUpgrade               	UnityEngine.RectTransform               
---@field CultivateOverseaBreakNode2    	UnityEngine.RectTransform               
---@field CultivateOverseaBreakNode1    	UnityEngine.RectTransform               
---@field RoleRareNode                  	UnityEngine.RectTransform
---@field Normal                        	UnityEngine.RectTransform
---@field Root                          	UnityEngine.Animation                   
local CardProgressionBreak = Class('CardProgressionBreak')

function CardProgressionBreak:__init()
    self._isInitialize = false
    self._entity       = nil
    self._isExpand     = false
    --self._viewType     = ViewType.Normal
    --self._awakenSymbols = {}
end

function CardProgressionBreak:__delete()

end

function CardProgressionBreak:Awake()
end

function CardProgressionBreak:Start()
    --SetButtonAction(self.BtnPreview, Bind(self, self.OnClickBtnPreviewAction))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickFontStyleButtonAction))
    SetButtonAction(self.BtnReturn, Bind(self, self.OnClickBtnReturnAction))
    
    
    CardProgressionUtils.RegRoleSwipeRegion(self.controller)
end

function CardProgressionBreak:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

--- OnInitialize
---@param entity CardProgressionEntity
function CardProgressionBreak:OnInitialize(entity)
    if self._isInitialize then return end
    self._isInitialize = false
    self._entity       = entity
    --self._maxBreakTimes = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.MaxBreakTimes))
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
function CardProgressionBreak:FreshUI(entity, skillTyp)
    self._entity = entity
    local cardDojo = entity.cardDojo
    self._skillType = skillTyp
    if skillTyp then
        if (skillTyp == CardProgressionConstants.SkillType.Final and cardDojo.finalSkillLevel >= cardConfMgr:GetMaxFinalSkillLv()) or
                (skillTyp == CardProgressionConstants.SkillType.Buff and cardDojo.awakeningLevel >= cardConfMgr:GetMaxBuffSkillLv(cardDojo.cardId))
        then
            self._skillType = nil
            self:SwitchExpand()
            --self._isExpand = false
        end
    end
    
    self:FreshRoleRareNode(cardDojo:GetRare(), cardDojo.cardId)
    
    KTool.SetActive(self.Normal.gameObject, not self._isExpand)
    if not self._isExpand then
        self:FreshNode(self.CultivateOverseaBreakNode1, CardProgressionConstants.SkillType.Final, entity, self._isExpand)

        self:FreshNode(self.CultivateOverseaBreakNode2, CardProgressionConstants.SkillType.Buff, entity,  self._isExpand)
    else
        self:FreshNode(self.CultivateOverseaBreakNode, skillTyp, entity, self._isExpand)
        
        self:FreshConsumeGoods(cardDojo, skillTyp)
    end
    
end


function CardProgressionBreak:FreshRoleRareNode(rare, cardId)
    ---@type CardProgressionRoleRareNode
    local env = CfUtils.GetLuaScr(self.RoleRareNode, CardProgressionConstants.EnvPath.CardProgressionRoleRareNode)
    if isNull(env) then return end
    env:FreshUI(rare, cardId)

end

function CardProgressionBreak:FreshNode(node, skillType, entity, isExpand)
    ---@type CardProgressionBreakNode
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionBreakNode)
    if isNull(env) then return end
    env:FreshUI(skillType, entity, isExpand, true)
    if not isExpand then
        env:SetExpandCallback(Bind(self, self.OnClickBtnReturnAction))
        
    end
    
end

---FreshConsumeGoods
---@param cardDojo CardDojo
---@param skillType CardProgressionConstants.SkillType
function CardProgressionBreak:FreshConsumeGoods(cardDojo, skillType)
    local level = skillType == CardProgressionConstants.SkillType.Final and checkNumber(cardDojo.finalSkillLevel) or checkNumber(cardDojo.awakeningLevel)
    -- print("cardDojo.cardId, skillType, level", cardDojo.cardId, skillType, level)
    ---@type BreakCommonRewardConsumeVo
    local vo = cardConfMgr:GetBreakConsumeVo(cardDojo.cardId, skillType, level)
    if vo == nil then return end
    
    local consumes = vo.consumes
    local t, goldNum = GoodsUtils.SpiltGold(consumes)
    UICommonUtils.FillCommonGoodsList(self.CommonGoodsList, t, false, false, true, true, true)
    
    self._consumes = consumes
    self._goodsConsumes = t
    self._goldNum = goldNum
    
    KTool.SetActive(self.CommonBtnConsumePop.gameObject, goldNum > 0)
    if goldNum > 0 then
        UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, Constants.Currency.GoldId, goldNum)
    end
end

function CardProgressionBreak:ShowAwakeningLevelUp(skinId, awakeLevel, cardDojo, skillType)
    CardProgressionUtils.BlockerAndStartCo("ShowAwakeningLevelUp", function()
        awakeLevel            = checkNumber(awakeLevel)
        local isMaxAwakeLevel = awakeLevel == self._maxBreakTimes
        local effectPath      = isMaxAwakeLevel and CardProgressionConstants.PrefabPath.CatAwakeHigh or CardProgressionConstants.PrefabPath.CatAwakeLow

        ---@type CardProgressionControllerRole
        local controllerEnv = CardProgressionUtils.GetRoleControllerEnv()
        controllerEnv:LoadCat(skinId,  {CardProgressionConstants.CameraState.CultivateCatAwakenSuccess, awakeLevel, effectPath})

        while not controllerEnv:IsLoadCatComplete() do
            cs_coroutine.yield_return()
        end

        while DOTween.TotalPlayingTweens() > 0 do
            cs_coroutine.yield_return()
        end

        CardProgressionUtils.OpenDialog(Constants.UITypeIds.CardProgressionBreakSuccess, {dojo = cardDojo, skillType = skillType})

        -- local particleSystems = controllerEnv:GetCardAwakenEffect(effectPath)
        -- if not isNull(particleSystems) then
        --     for i = 0, particleSystems.Length - 1 do
        --         ---@type UnityEngine.ParticleSystem
        --         local ps = particleSystems[i]
        --         if not isNull(ps) then
        --             while ps.isPlaying do
        --                 cs_coroutine.yield_return()
        --             end
        --             ps.emission.enabled = false
        --         end
        --     end
        -- end

    end)


end


--- OnEnter
--- 进入时调用
function CardProgressionBreak:OnEnter()
    
    
end

--- OnLeave
--- 离开时时调用
function CardProgressionBreak:OnLeave()
    
    
end

--- OnReload
--- 重载时调用
---@param entity CardProgressionEntity
function CardProgressionBreak:OnReload(entity, localData, interface)
    self._entity = entity

    if interface == Interfaces.OverseaCardAwakeningSkillLevelUp then
        ---@type CardDojo
        local cardDojo = entity.cardDojo
        local skillType = self._skillType
        
        local pre = FormulaUtils.CalcCardCombatEffectiveness(self._entity, {awakeningLevel = checkNumber(cardDojo.awakeningLevel) - 1})
        local cur = FormulaUtils.CalcCardCombatEffectiveness(self._entity)
        if pre ~= cur then
            CardProgressionUtils.ChangePointToast(cur - pre)
        end

        self:ShowAwakeningLevelUp(cardDojo.cardSkin, cardDojo.awakeningLevel, cardDojo, skillType)
        
    elseif interface == Interfaces.OverseaCardFinalSkillLevelUp then
        ---@type CardDojo
        local cardDojo = entity.cardDojo
        local skillType = self._skillType

        local pre = FormulaUtils.CalcCardCombatEffectiveness(self._entity, {finalSkillLevel = checkNumber(cardDojo.finalSkillLevel) - 1})
        local cur = FormulaUtils.CalcCardCombatEffectiveness(self._entity)
        if pre ~= cur then
            CardProgressionUtils.ChangePointToast(cur - pre)
        end
        
        Events.Broadcast(CardProgressionConstants.EventNames.SetCultivateMainShowState, false)
        CardProgressionUtils.OpenDialog(Constants.UITypeIds.CardProgressionBreakSuccess, {dojo = cardDojo, skillType = skillType})
        
    end

    self:FreshUI(entity, self._skillType)
end

function CardProgressionBreak:SwitchExpand()
    self._isExpand = not self._isExpand
    local animName = self._isExpand and ChangeAni or BackAni
    self.Root:Play(animName)
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

--function CardProgressionBreak:OnClickBtnPreviewAction()
--    CardProgressionUtils.OpenDialog(Constants.UITypeIds.CardProgressionBreakPreview, {cardId = self._entity.cardDojo.cardId})
--
--end

function CardProgressionBreak:OnClickBtnReturnAction(skillType)
    self:SwitchExpand()
    self:FreshUI(self._entity, skillType)
end
--
function CardProgressionBreak:OnClickFontStyleButtonAction()
    
    
    local goldNum  = self._goldNum
    local goldConsume
    if goldNum > 0 then
        goldConsume = {goodsId = Constants.Currency.GoldId, num = goldNum}
        if not GoodsUtils.CheckConsumeDataCondition({goldConsume}) then
            return
        end
    end

    local realConsumes, errorTip = GoodsUtils.CheckGoodConsume(self._goodsConsumes)
    if errorTip then
        GameUtils.Toast(errorTip)
        return
    end

    if goldConsume then
        goldConsume.num = goldConsume.num * -1
        table.insert(realConsumes, goldConsume)
    end

    local skillType = self._skillType
    if skillType == nil then
        return
    end

    ---@type CardProgressionMgr
    local instance = CardProgressionMgr:GetInstance()

    ---@type CardProgressionEntity
    local entity   = self._entity
    local cardDojo = entity.cardDojo

    local requestFunc = skillType == CardProgressionConstants.SkillType.Final and instance.RequestOverseaCardFinalSkillLevelUp or instance.RequestOverseaCardAwakeningSkillLevelUp
    requestFunc(instance, {playerCardId = cardDojo.id}, realConsumes, cardDojo)
   
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionBreak
