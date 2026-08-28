
------------ import ------------
---@type Engine.Lib.KTool
local KTool                    = CS.Engine.Lib.KTool
---@type CardConfMgr
local cardConfMgr              = CardConfMgr:GetInstance()
---@type GoodsConfMgr
local goodsConfMgr             = GoodsConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionMgr
local CardProgressionMgr       = import("Game.CardProgression.CardProgressionMgr")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
------------ import ------------


------------ define ------------
local attribute_format = attribute_format
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaEvolutionDialog.prefab > name: Evolution
---@class CardProgressionAdvanceLevelUpPanel
---@field Env                           	CardProgressionAdvanceLevelUpPanel      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ArmForceNode                  	UnityEngine.RectTransform               
---@field LevelLimitNode                	UnityEngine.RectTransform
---@field CommonBtnConsumePop           	UnityEngine.RectTransform
---@field TxtPrompt                     	UnityEngine.UI.Text
---@field Text                          	Game.Native.Common.UISwitchText
---@field FontStyleButton               	Game.Native.Common.FontStyleButton
---@field CommonGoodsList               	UnityEngine.RectTransform
---@field ItemAttribute                 	UnityEngine.RectTransform
---@field Add                           	UnityEngine.RectTransform               
---@field ImgRareIcon2                  	Game.Native.Common.UISwitchImage
---@field Brush                         	Game.Native.Common.UISwitchImage
---@field ImgRareIcon                   	Game.Native.Common.UISwitchImage
---@field TextName2                     	UnityEngine.UI.Text
---@field TextName1                     	UnityEngine.UI.Text
local CardProgressionAdvanceLevelUpPanel = Class('CardProgressionAdvanceLevelUpPanel')

function CardProgressionAdvanceLevelUpPanel:__init()

end


function CardProgressionAdvanceLevelUpPanel:__delete()

end


function CardProgressionAdvanceLevelUpPanel:Awake()
    self._maxAdvanceLevel = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.MaxAdvanceLevel))
end


function CardProgressionAdvanceLevelUpPanel:Start()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBtnAction))

    self._eventCompositeFresh = Events.AddListener(Constants.EventNames.UIEventCompositeFreshGridView, Bind(self, self.OnEventCompositeFresh))
end


function CardProgressionAdvanceLevelUpPanel:OnDestroy()
    if self._eventCompositeFresh then
        Events.RemoveListener(Constants.EventNames.UIEventCompositeFreshGridView, self._eventCompositeFresh)
        self._eventCompositeFresh = nil
    end
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

--- FreshUI
---@param entity CardProgressionEntity
function CardProgressionAdvanceLevelUpPanel:FreshUI(entity, isCanAdvanceLevelUp)
    self._isCanAdvanceLevelUp = isCanAdvanceLevelUp
    ---@type CardDojo
    local cardDojo          = entity.cardDojo
    
    local cardId            = cardDojo.cardId
    local advanceLevel      = checkNumber(cardDojo.advanceLevel)

    local nextLv            = math.min(self._maxAdvanceLevel, advanceLevel + 1)
    ---@type RoleAdvanceLevelLimitVo
    local advanceLevelLimitVo     = cardConfMgr:GetRoleAdvanceLevelLimitVo(advanceLevel)
    ---@type RoleAdvanceLevelLimitVo
    local nextAdvanceLevelLimitVo = cardConfMgr:GetRoleAdvanceLevelLimitVo(nextLv)
    ---@type CardVo
    local cardVo = cardConfMgr:GetCardByRefId(cardId)

    self._nextLv = nextLv
    self._nextLvAdvType = nextAdvanceLevelLimitVo.type
    self._entity = entity
    self._newEntity = clone(entity)
    self._newEntity.cardDojo.advanceLevel = nextLv

    ---@type RoleAdvanceVo
    local vo    = cardConfMgr:GetRoleAdvanceVo(cardId, nextLv)
    local attrs = vo:GetBreakAttributes()
    local attrId2Res = {}
    for i, v in pairs(attrs) do
        local attrId = cardConfMgr:GetBasicAttrIdByBasicAttrAdditionId(i)
        attrId2Res[attrId] = true
    end
    self._attrId2Res = attrId2Res

    --Events.Broadcast(CardProgressionConstants.EventNames.SetStylePreviewShowState, false)
    
    self:FreshRoleRareNode(cardVo, cardConfMgr:GetCardRare(advanceLevel, cardVo.rare), cardConfMgr:GetCardRare(nextLv, cardVo.rare))

    self:FreshAttributes(advanceLevelLimitVo.maxLevel, nextAdvanceLevelLimitVo.maxLevel)

    self:FreshAdvanceLevelUpConsume(cardDojo.cardId, nextLv)

    self:FreshItemButton(nextAdvanceLevelLimitVo.type, isCanAdvanceLevelUp)

    self:FreshBtnStylePreviewShowState()
    
end

--- FreshRoleRareNode
---@param cardVo CardVo
function CardProgressionAdvanceLevelUpPanel:FreshRoleRareNode(cardVo, rare, nextRare)
    self.TextName1.text = cardVo.name
    self.TextName2.text = cardVo.descr

    KTool.SetActive(self.Add.gameObject, rare ~= nextRare)
    -- self.ImgRareIcon2New.Status = nextRare
    -- self.BrushNew.Status = nextRare
    -- self.ImgRareIconNew.Status = nextRare
    self.ImgRareIcon2.Status = rare
    self.Brush.Status = rare
    self.ImgRareIcon.Status = rare

end

function CardProgressionAdvanceLevelUpPanel:FreshAttributes(maxLevel, nextMaxLevel)
    local t, levelLimitData, combatEffectivenessConf = self:GetAttributes(maxLevel, nextMaxLevel)
    self:FreshLevelLimit(levelLimitData)
    self:FreshCombatEffectiveness(combatEffectivenessConf)
    
    ---@type CardProgressionAttributeGroupNode
    local env = CfUtils.GetLuaScr(self.ItemAttribute, CardProgressionConstants.EnvPath.CardProgressionAttributeGroupNode)
    if isNull(env) then return end
    env:FreshUI(t)
end

function CardProgressionAdvanceLevelUpPanel:FreshLevelLimit(levelLimitData)
    ---@type CardProgressionAttributeNode
    local env = self:GetLevelLimitEnv()
    if isNotNull(env) then
        env:FreshUI(levelLimitData)
    end
end

function CardProgressionAdvanceLevelUpPanel:FreshCombatEffectiveness(data)
    ---@type CardProgressionAttributeNode
    local env = self:GetCombatEffectivenessEnv()
    if isNotNull(env) then
        env:FreshUI(data)
    end
end


--- FreshAdvanceLevelUpConsume
---@param cardId number
---@param nextLv number
function CardProgressionAdvanceLevelUpPanel:FreshAdvanceLevelUpConsume(cardId, nextLv)
    ---@type RoleAdvanceVo
    local vo         = cardConfMgr:GetRoleAdvanceVo(cardId, nextLv)
    local consumes   = vo.consumes
    local GoldId     = Constants.Currency.GoldId
    local t, goldNum = GoodsUtils.SpiltGold(consumes)
    
    UICommonUtils.FillCommonGoodsList(self.CommonGoodsList, t, nil, nil, nil, true, true)

    KTool.SetActive(self.CommonBtnConsumePop.gameObject, goldNum > 0)
    if goldNum > 0 then
        UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, GoldId, goldNum)
        
    end
end

--- FreshItemButton
---@param advanceType CardProgressionConstants.AdvanceType 类型（1=进阶，2=超进阶）
function CardProgressionAdvanceLevelUpPanel:FreshItemButton(advanceType, isCanAdvanceLevelUp)
    self.FontStyleButton:ResetFontStyle(isCanAdvanceLevelUp and "B1" or "B17")
    self.Text.Status = advanceType

end

-- function CardProgressionAdvanceLevelUpPanel:ShowCombatEffectivenessTips(oldCardSkin, oldAdvanceLevel)
--     -- local ce = FormulaUtils.CalcCardCombatEffectiveness(self._entity, {cardSkin = oldCardSkin, advanceLevel = oldAdvanceLevel})
--     -- if ce ~= self._curCE then
--     --     CardProgressionUtils.ChangePointToast(self._curCE - ce)
--     -- end
-- end

function CardProgressionAdvanceLevelUpPanel:FreshBtnStylePreviewShowState()
    ---@type CardDojo
    local cardDojo     = self._entity.cardDojo
    local rare         = cardDojo:GetRare()
    local advanceLevel = checkNumber(cardDojo.advanceLevel)
    local isMonster = CardUtils.IsMonsterCard(cardDojo.cardId)
    local isShow = not isMonster and advanceLevel < self._maxAdvanceLevel and rare < Constants.RareType.UR and not CardUtils.IsMonsterCard(cardDojo.cardId)
    Events.Broadcast(CardProgressionConstants.EventNames.SetStylePreviewShowState, isShow)
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionAdvanceLevelUpPanel:GetAttributes(maxLevel, nextMaxLevel)
    local attrId2Res = self._attrId2Res
    local t = {}
    local levelLimitData = 
    {
        icon = CardProgressionConstants.AssetPath.LevelLimit, 
        name = localize("等级上限"), 
        attrNum = maxLevel,
        plusAttrNum = nextMaxLevel,
        viewType = CardProgressionConstants.AttrNodeType.Double,
    }

    local preTotalCombatEff, totalCombatEff = FormulaUtils.CalcCardCombatEffectivenessAndCompareAttr(self._entity, self._newEntity, function (vo, preBaseV, baseV, i)
        local order = vo.order
        if order > 0 and attrId2Res[vo.id] then
            local preText = attribute_format(vo.isConversion, preBaseV)
            local text    = attribute_format(vo.isConversion, baseV)
            table.insert(t, {
                icon = vo.icon,
                name = vo.name,
                attrNum = preText,
                plusAttrNum = baseV ~= preBaseV and text or nil,
                viewType = CardProgressionConstants.AttrNodeType.Double,
            })
        end
    end)

    local combatEffectivenessConf = {
        name        = localize("战斗力"),
        attrNum     = preTotalCombatEff,
        plusAttrNum = preTotalCombatEff ~= totalCombatEff and totalCombatEff or nil,
        viewType    = CardProgressionConstants.AttrNodeType.Double,
    }

    self._curCE, self._nextCE = preTotalCombatEff, totalCombatEff

    return t, levelLimitData, combatEffectivenessConf
end

---@return CardProgressionAttributeNode
function CardProgressionAdvanceLevelUpPanel:GetLevelLimitEnv()
    if isNull(self._levelLimitEnv) then
        self._levelLimitEnv = self:GetAttributeNodeEnv(self.LevelLimitNode)
    end
    return self._levelLimitEnv
end

function CardProgressionAdvanceLevelUpPanel:GetCombatEffectivenessEnv()
    if isNull(self._combatEffectivenessEnv) then
        self._combatEffectivenessEnv = self:GetAttributeNodeEnv(self.ArmForceNode)
    end
    return self._combatEffectivenessEnv
end

---@return CardProgressionAttributeNode
function CardProgressionAdvanceLevelUpPanel:GetAttributeNodeEnv(go)
    ---@type CardProgressionAttributeNode
    local env = CfUtils.GetLuaScr(go, CardProgressionConstants.EnvPath.CardProgressionAttributeNode)
    return env
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionAdvanceLevelUpPanel:OnClickBtnAction()
    
    if false then
        ---@type CardDojo
        local cardDojo = self._entity.cardDojo

        local oldDojo = clone(cardDojo)
        local dojo = (cardDojo)
        -- dojo.advanceLevel = self._maxAdvanceLevel
        -- dojo.advanceLevel = checkInt(oldDojo.advanceLevel) + 1
        dojo.advanceLevel = 5
        -- print("OnClickBtnAction", dojo.advanceLevel, dojo:GetRare())
        local isUnlockSkin = dojo:GetRare() == Constants.RareType.UR
        if isUnlockSkin then
            ---@type CardVo
            local vo = cardConfMgr:GetCardByRefId(cardDojo.cardId)
            GoodsUtils.DrawRewards({ { goodsId = vo.urSkin } })
            dojo.cardSkin = checkNumber(vo.urSkin)
            -- print("advanceLevel", oldDojo.cardSkin, dojo.cardSkin)
        end

        local data = {oldDojo = oldDojo, dojo = dojo, isAdvanceLevelUp = true, isUnlockSkin = isUnlockSkin, oldCardSkin = oldDojo.cardSkin}
        Events.Broadcast(CardProgressionConstants.EventNames.RequestSuccess, Interfaces.OverseaCardAdvanceLevelUp, data)

        -- local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
        -- ActionUtils.ShowMaintQestTaskNode({
        --    questId = 106070,
        --    type = Constants.TaskType.MainTask
        -- })
        return
    end

    ---@type CardDojo
    local cardDojo = self._entity.cardDojo
    local advanceLevel = checkNumber(cardDojo.advanceLevel)
    ---@type RoleAdvanceLevelLimitVo
    local advanceLevelLimitVo = cardConfMgr:GetRoleAdvanceLevelLimitVo(advanceLevel)
    if not self._isCanAdvanceLevelUp then
        GameUtils.Toast(localize("战斗员等级达到_num_级", {_num_ = advanceLevelLimitVo.maxLevel}))
        return
    end
    
    ---@type RoleAdvanceVo
    local vo = cardConfMgr:GetRoleAdvanceVo(cardDojo.cardId, self._nextLv)
    local consumes = vo.consumes
    local t, goldNum = GoodsUtils.SpiltGold(consumes)
    if goldNum > 0 then
        local goldConsume = {goodsId = Constants.Currency.GoldId, num = goldNum}
        if not GoodsUtils.CheckConsumeDataCondition({goldConsume}) then
            return
        end
    end
    
    local rewards, errorTip = GoodsUtils.CheckGoodConsume(consumes)
    if errorTip then
         GameUtils.Toast(errorTip)
         return
    end

     CardProgressionMgr:RequestOverseaCardAdvanceLevelUp({playerCardId = cardDojo.id, type = self._nextLvAdvType}, rewards, cardDojo, self._curCE, self._nextCE)
    
end

function CardProgressionAdvanceLevelUpPanel:OnEventCompositeFresh()
    self:FreshAdvanceLevelUpConsume(self._entity.cardDojo.cardId, self._nextLv)
end


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionAdvanceLevelUpPanel
