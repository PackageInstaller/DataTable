
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
local checkNumber      = checkNumber
local attribute_format = attribute_format

local AttrExpandDefault = "CultivateLevelupAttrExpandDefault"
local AttrExpandGo      = "CultivateLevelupAttrExpandGo"
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaLevelupAndEvolution.prefab > name: Levelup
---@class CardProgressionLevelUpPanel
---@field Env                           	CardProgressionLevelUpPanel             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field FontStyleButton2              	Game.Native.Common.FontStyleButton      
---@field ItemButton2                   	UnityEngine.RectTransform               
---@field CommonBtnConsumePop           	UnityEngine.RectTransform
---@field FontStyleButton               	UnityEngine.RectTransform
---@field BtnChoose                     	UnityEngine.RectTransform
---@field ItemButton                    	UnityEngine.RectTransform
---@field GoodsConsumeNode4             	UnityEngine.RectTransform
---@field GoodsConsumeNode3             	UnityEngine.RectTransform
---@field GoodsConsumeNode2             	UnityEngine.RectTransform
---@field GoodsConsumeNode1             	UnityEngine.RectTransform
---@field ItemMaterial                  	UnityEngine.RectTransform
---@field TxtNumberNew                  	TMPro.TextMeshProUGUI
---@field PlusNode                      	UnityEngine.RectTransform
---@field TxtNumber                     	TMPro.TextMeshProUGUI
---@field BtnArmed                      	UnityEngine.RectTransform
---@field ItemAttribute                 	UnityEngine.Animation
---@field TextNumberSlider              	TMPro.TextMeshProUGUI
---@field SliderOrigin                  	UnityEngine.UI.Slider
---@field Slider                        	UnityEngine.UI.Slider
---@field TxtNumberLevel                	TMPro.TextMeshProUGUI
---@field RoleRareNode                  	UnityEngine.RectTransform
local CardProgressionLevelUpPanel = Class('CardProgressionLevelUpPanel')

function CardProgressionLevelUpPanel:__init()
    self._expAdd = false
end


function CardProgressionLevelUpPanel:__delete()

end


function CardProgressionLevelUpPanel:Awake()
    self._maxAdvanceLevel = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.MaxAdvanceLevel))

    self._goodsConsumeNodes = {
        self.GoodsConsumeNode1,
        self.GoodsConsumeNode2,
        self.GoodsConsumeNode3,
        self.GoodsConsumeNode4,
        
    }
end


function CardProgressionLevelUpPanel:Start()
    --SetButtonAction(self.BtnStylePreview, Bind(self, self.OnClickBtnStylePreviewAction))
    SetButtonAction(self.BtnChoose, Bind(self, self.OnClickBtnChooseAction))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBtnAction))
    SetButtonAction(self.FontStyleButton2, Bind(self, self.OnClickBtn2Action))
    
end


function CardProgressionLevelUpPanel:OnDestroy()
    
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

---InitLevelUpConsumeGoodsList
---@param entity CardProgressionEntity
function CardProgressionLevelUpPanel:InitLevelUpConsumeGoodsList(entity)
    if self._consumeGoodsList == nil then
        self._goodsId2ConsumeData = {}
        self._index2Proportion = {1}
        local consumeGoodsList = goodsConfMgr:GetExpGoodsVoList()
        local lastExp = 0
        for i, goodsVo in ipairs(consumeGoodsList) do
            local goodsId = goodsVo.id
            local ownNum = GoodsUtils.GetThingNo(goodsId)
            self._goodsId2ConsumeData[goodsId] = {
                ownNum    = ownNum,
                selectNum = 0,
                index     = i,
                goodsId   = goodsId,
            }
            
            if i > 1 then
                table.insert(self._index2Proportion, checkInt(goodsVo.effectNum / lastExp))
            end
            lastExp = goodsVo.effectNum
            
        end
        self._consumeGoodsList = consumeGoodsList
        
    else
        for i, v in pairs(self._goodsId2ConsumeData) do
            v.selectNum = 0
            v.ownNum = GoodsUtils.GetThingNo(v.goodsId)
        end
        
    end
    
    ---@type RoleAdvanceLevelLimitVo
    local roleAdvanceLevelLimitVo = cardConfMgr:GetRoleAdvanceLevelLimitVo(entity.cardDojo.advanceLevel)
    self._cardConsume = roleAdvanceLevelLimitVo.consumeAspect
end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshUI
---@param entity CardProgressionEntity
function CardProgressionLevelUpPanel:FreshUI(entity, isCanAdvanceLevelUp)
    if self._entity and self._entity.playerCardId ~= entity.playerCardId then
        self._preCombatEffectiveness = nil
    end

    self._isCanAdvanceLevelUp = isCanAdvanceLevelUp
    self:InitLevelUpConsumeGoodsList(entity)
    
    ---@type CardDojo
    local cardDojo          = entity.cardDojo
    local originLevel       = checkNumber(cardDojo.cardLevel)
    local cardId            = cardDojo.cardId
    local advanceLevel      = checkNumber(cardDojo.advanceLevel)
    local maxLevel          = cardConfMgr:GetCardMaxLevel(advanceLevel)
    local isMaxFinialLevel  = advanceLevel >= self._maxAdvanceLevel and originLevel >= maxLevel
    local cardLevelLimit, limitId    = CardProgressionUtils.GetCardLevelLimit()

    ---@type CardVo
    local cardVo            = cardConfMgr:GetCardByRefId(cardId)
    self._originLevel       = originLevel
    self._maxLevel          = maxLevel
    self._maxLevelTotalExp  = cardConfMgr:GetCardExp(maxLevel, cardVo.rare, maxLevel).totalExp
    self._cardLevelLimit    = cardLevelLimit
    self._limitId           = limitId
    self._cardVo            = cardVo
    self._cardDojo          = cardDojo
    self._isMaxFinialLevel  = isMaxFinialLevel
    self._entity            = entity
    self._newEntity         = clone(entity)
    self._arrivalsMaxLvNeedExp = self:InitArrivalsMaxLvNeedExp(math.min(maxLevel, cardLevelLimit))

    ---@type RoleAdvanceVo
    local vo    = cardConfMgr:GetRoleAdvanceVo(cardId, advanceLevel)
    local attrs = vo:GetUpAttributes()
    local attrId2Res = {}
    for i, v in pairs(attrs) do
        local attrId = cardConfMgr:GetBasicAttrIdByBasicAttrAdditionId(i)
        attrId2Res[attrId] = true
    end
    self._attrId2Res = attrId2Res

    ---@type Constants.RareType
    local rare     = cardDojo:GetRare()
    self:FreshRoleRareNode(rare, cardId)

    self:FreshLevelInfo()

    --self.MaskRoot.enabled = not isMaxFinialLevel
    --self.ScrollView.enabled = isMaxFinialLevel
    self.ItemAttribute:Play(isMaxFinialLevel and AttrExpandGo or AttrExpandDefault)
    --KTool.SetActive(self.FullAttributeMask.gameObject, isMaxFinialLevel)
    KTool.SetActive(self.ItemMaterial.gameObject, not isMaxFinialLevel)
    KTool.SetActive(self.ItemButton.gameObject, not isMaxFinialLevel and not isCanAdvanceLevelUp)
    KTool.SetActive(self.ItemButton2.gameObject, not isMaxFinialLevel and isCanAdvanceLevelUp)
    if not isMaxFinialLevel then
        self:FreshChooseGroup()
    end
end


function CardProgressionLevelUpPanel:FreshRoleRareNode(rare, cardId)
    ---@type CardProgressionRoleRareNode
    local env = CfUtils.GetLuaScr(self.RoleRareNode, CardProgressionConstants.EnvPath.CardProgressionRoleRareNode)
    if isNull(env) then return end
    env:FreshUI(rare, cardId)
        
end


function CardProgressionLevelUpPanel:FreshLevelInfo()
    ---刷新等级与经验
    self:CalcLevelAndFreshInfo()
    
    local attributes, preCombatEffectiveness, combatEffectiveness = self:GetAttributesAndCombatPower(self._entity, self._newEntity, self._isMaxFinialLevel, self._cardDojo.cardId, self._attrId2Res)
    ---刷新属性
    self:FreshAttributes(attributes)
    ---刷新战斗力
    self:FreshCombatEffectiveness(preCombatEffectiveness, combatEffectiveness, self._isMaxFinialLevel)
    
end

function CardProgressionLevelUpPanel:FreshAttributes(t)
    ---@type CardProgressionAttributeGroupNode
    local env = CfUtils.GetLuaScr(self.ItemAttribute, CardProgressionConstants.EnvPath.CardProgressionAttributeGroupNode)
    if isNull(env) then return end
    env:FreshUI(t)

end

function CardProgressionLevelUpPanel:FreshCombatEffectiveness(preCombatEffectiveness, combatEffectiveness, isMaxFinialLevel)
    self._preCombatEffectiveness = preCombatEffectiveness
    self._combatEffectiveness    = combatEffectiveness

    self.TxtNumber.text = preCombatEffectiveness
    local isShowPlus = preCombatEffectiveness ~= combatEffectiveness and not isMaxFinialLevel
    -- self.TxtNumber.Status = isShowPlus and 2 or 1
    KTool.SetActive(self.PlusNode.gameObject, isShowPlus)
    if isShowPlus then
        self.TxtNumberNew.text = combatEffectiveness
    end

end

function CardProgressionLevelUpPanel:ShowCombatEffectivenessTips()
    if self._preCombatEffectiveness ~= self._combatEffectiveness then
        CardProgressionUtils.ChangePointToast(self._combatEffectiveness - self._preCombatEffectiveness)
    end
end

function CardProgressionLevelUpPanel:CalcLevelAndFreshInfo()
    local expAddition = self:GetExpAddition()
    local limitLv     = math.min(self._cardLevelLimit, self._maxLevel)
    local progressOrigin, progress, newLevel, deltaExp, newLevelNextLvExp, feedingTotalExp = CardProgressionUtils.CalcUpgradeLevelExp(self._cardDojo, expAddition, self._cardVo.rare, limitLv)
    local overflowExp = feedingTotalExp - self._maxLevelTotalExp
    self._overflowExp = overflowExp
    self._newLevel = newLevel
    ---@type CardProgressionEntity
    local newEntity = self._newEntity
    newEntity.cardDojo.cardLevel = newLevel
    self:FreshLevel(newLevel, limitLv)
    self:FreshSlider(progressOrigin, progress, deltaExp, newLevelNextLvExp, expAddition)
    
    ---金币消耗
    self:FreshLevelUpGoldConsume(expAddition, overflowExp)
    return expAddition
end

--- FreshLevel
---@param newLevel number 卡牌展示等级
function CardProgressionLevelUpPanel:FreshLevel(newLevel, limitLv)
    local isChangeLv  = newLevel ~= self._originLevel
    if isChangeLv then
        self.TxtNumberLevel.text = string.format("<size=42><color #17FFF7>%s</color></size>/%s", newLevel, limitLv)
    else
        self.TxtNumberLevel.text = string.format("<size=42><color #ffffff>%s</color></size>/%s", newLevel, limitLv)
    end

end

--- FreshSlider
---@param progressOrigin number 原始进度
---@param progress number 最新进度
---@param deltaExp number 剩余经验
---@param newLevelNextLvExp string 最新等级下一等级经验
---@param expAddition number 经验加成
function CardProgressionLevelUpPanel:FreshSlider(progressOrigin, progress, deltaExp, newLevelNextLvExp, expAddition)
    local isChangeExp       = expAddition > 0
    local isMaxLevel        = self._originLevel >= self._maxLevel
    KTool.SetActive(self.TextNumberSlider.gameObject, not isMaxLevel)
    if not isMaxLevel then
        KTool.SetActive(self.Slider.gameObject, progress > 0)
        self.Slider.value       = progress
        self.SliderOrigin.value = progressOrigin
        if isChangeExp then
            self.TextNumberSlider.text = string.format("<color #15FFE6>%s</color >/%s", deltaExp, newLevelNextLvExp)
        else
            self.TextNumberSlider.text = string.format("%s/%s", deltaExp, newLevelNextLvExp)
        end
    else
        self.Slider.value       = 0
        self.SliderOrigin.value = 1
    end

end

function CardProgressionLevelUpPanel:FreshLevelUpGoldConsume(expAddition, overflowExp)
    if overflowExp > 0 then
        expAddition = expAddition - overflowExp
    end
    local goldConsume = checkInt(expAddition * self._cardConsume)
    KTool.SetActive(self.CommonBtnConsumePop.gameObject, goldConsume > 0)
    if goldConsume <= 0 then
        return
    end
    UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, Constants.Currency.GoldId, goldConsume)
end

function CardProgressionLevelUpPanel:FreshChooseGroup()
    local consumes     = self._consumeGoodsList
    local consumeCount = #consumes
    local nodes        = self._goodsConsumeNodes
    local nodeCount    = #nodes
    local goodsId2ConsumeData = self._goodsId2ConsumeData

    for i = 1, math.max(consumeCount, nodeCount) do
        ---@type GoodsVo
        local consume = consumes[i]
        local node    = nodes[i]
        if consume then
            self:FreshGoodsConsumeNode(node, goodsId2ConsumeData[consume.id])
        elseif node then
            KTool.SetActive(node, false)
        end
    end

end

local function CalcTimes(durationSeconds, intervalTime, scale)
    return checkInt(durationSeconds / intervalTime / scale)
end

--- FreshGoodsConsumeNode
---@param node UnityEngine.RectTransform
---@param goodsVo GoodsVo
---@param consumeData table{
---@    ownNum: number      道具拥有数量
---@    selectNum: number   道具选择数量
---@    index: number       _consumeGoodsList 或 _goodsConsumeNodes 所对应的下标
---@    goodsId: number     道具id
---@}
function CardProgressionLevelUpPanel:FreshGoodsConsumeNode(node, consumeData)
    ---@type CardProgressionGoodsConsumeNode
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionGoodsConsumeNode)
    if isNull(env) then
        return
    end
    env:FreshUI(consumeData)
    env:SetClickCallback(function ()
        if consumeData.ownNum <= 0 then
            GameUtils.ShowCommonGoodsTipsBoard(node, consumeData.goodsId, true)
            return
        end
        ---@type CardDojo
        local cardDojo = self._cardDojo
        local cardLevel = checkNumber(cardDojo.cardLevel)
        if cardLevel >= self._cardLevelLimit then
            self:ShowLevelLimitTips()
            return
        end
        self:FreshGoodsNumAndLevelInfo(env, 1, consumeData)
    end)
    env:SetLongPressCallback(function (pressComp, durationSeconds)
        ---@type CardDojo
        local cardDojo = self._cardDojo
        local cardLevel = checkNumber(cardDojo.cardLevel)
        if cardLevel >= self._cardLevelLimit and not self._isTriggerTips then
            self._isTriggerTips = true
            self:ShowLevelLimitTips()
            return
        end
        local intervalTime    = pressComp.intervalTime
        local times           = CalcTimes(durationSeconds, intervalTime, 30)
        self:FreshGoodsNumAndLevelInfo(env, 10 ^ times, consumeData)
    end)
    env:SetClickCallbackReduce(function ()
        self:FreshGoodsNumAndLevelInfo(env, -1, consumeData)
    end)
    env:SetLongPressCallbackReduce(function (pressComp, durationSeconds)
        local intervalTime    = pressComp.intervalTime
        local times           = CalcTimes(durationSeconds, intervalTime, 30)
        self:FreshGoodsNumAndLevelInfo(env, -(10 ^ times), consumeData)
    end)
    env:SetPointerExitCallback(function()
        self._isTriggerTips = false
    end)
end

function CardProgressionLevelUpPanel:FreshGoodsNumAndLevelInfo(env, deltaCount, consumeData)
    local isChange = self:FreshGoodsConsumeNodeSelectNum(env, deltaCount, consumeData)
    if isChange then
        self:FreshLevelInfo()
        -- self:CalcLevelAndFreshInfo()
    end
end

function CardProgressionLevelUpPanel:FreshGoodsConsumeNodeSelectNum(env, deltaCount, consumeData)
    if not (self._arrivalsMaxLvNeedExp > 0 or deltaCount < 0) then
        return
    end
    local selectNum    = consumeData.selectNum
    local ownNum       = consumeData.ownNum
    local index        = consumeData.index
    local goodsVo      = self._consumeGoodsList[index]
    local effectNum    = goodsVo.effectNum
    local arrivalsMaxLvNeedExp = self._arrivalsMaxLvNeedExp 
    local newSelectNum   = 0
    if deltaCount < 0 then
        local temp = selectNum + deltaCount
        local realDeltaCount = checkInt(deltaCount + (temp < 0 and (math.abs(temp)) or 0))
        newSelectNum    = selectNum + realDeltaCount
        self._arrivalsMaxLvNeedExp = self._arrivalsMaxLvNeedExp - realDeltaCount * effectNum
    elseif self._arrivalsMaxLvNeedExp > 0 then
        local leftNum        = ownNum - selectNum
        local realDeltaCount = math.min(leftNum, checkInt(deltaCount))
        local count          = math.ceil(self._arrivalsMaxLvNeedExp / effectNum)
        realDeltaCount       = math.min(count, realDeltaCount)
        newSelectNum         = selectNum + realDeltaCount
        self._arrivalsMaxLvNeedExp = self._arrivalsMaxLvNeedExp - realDeltaCount * effectNum
    end
    
    local isChanged    = arrivalsMaxLvNeedExp ~= self._arrivalsMaxLvNeedExp
    if isChanged then
        consumeData.selectNum = newSelectNum
        env:FreshSelectNode(consumeData)
    end
    return isChanged
end

function CardProgressionLevelUpPanel:FreshGoodsConsumeNodeSelectNumByNode(node, consumeData)
    ---@type CardProgressionGoodsConsumeNode
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionGoodsConsumeNode)
    if isNull(env) then
        return
    end
    env:FreshSelectNode(consumeData)
end

function CardProgressionLevelUpPanel:ShowLevelLimitTips()
    local playerLvLimit, levelLimit = CardProgressionUtils.GetCardLevelLimitData(self._limitId + 1)
    if playerLvLimit ~= nil and levelLimit ~= nil then
        GameUtils.Toast(localize('已经达到上限，调查官达到_num1_级可提升至_num2_级', {_num1_ = playerLvLimit, _num2_ = levelLimit}))
    end
end


---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionLevelUpPanel:GetAttributesAndCombatPower(preEntity, entity, isMaxFinialLevel, cardId, attrId2Res)
    local t, preCombatEffectiveness, combatEffectiveness = {}, 0, nil
    if isMaxFinialLevel then
        ---@type CardVo
        --local cardVo = cardConfMgr:GetCardByRefId(cardId)
        ---@type CatTypeVo
        --local cardTypeVo = cardConfMgr:GetCatTypeVoById(cardVo.catType)
        --table.insert(t, {order = -3, icon = CardProgressionConstants.AssetPath.Attribute, name = localize("属性"), cardAttrId = cardVo.attributeType, viewType = CardProgressionConstants.AttrNodeType.CardAttr})
        --table.insert(t, {order = -2, icon = CardProgressionConstants.AssetPath.Race,      name = localize("阵营"), raceId = cardVo.race,              viewType = CardProgressionConstants.AttrNodeType.Race})
        --table.insert(t, {order = -1, icon = CardProgressionConstants.AssetPath.CatType,   name = localize("血统"), desc = cardTypeVo and cardTypeVo.name or "", viewType = CardProgressionConstants.AttrNodeType.CatType})

        preCombatEffectiveness = FormulaUtils.CalcCardCombatEffectiveness(preEntity, nil, function (vo, num, index)
            local order = vo.order
            if vo.order > 0 then
                local text = attribute_format(vo.isConversion, num)
                table.insert(t, {
                    order = order,
                    icon = vo.icon,
                    name = vo.name,
                    attrNum = text,
                    viewType = CardProgressionConstants.AttrNodeType.Single,
                })
            end
        end)
    else
        preCombatEffectiveness, combatEffectiveness = FormulaUtils.CalcCardCombatEffectivenessAndCompareAttr(preEntity, entity, function (vo, preBaseV, baseV, i)
            local order = vo.order
            if order > 0 and attrId2Res[vo.id] then
                local preText = attribute_format(vo.isConversion, preBaseV)
                local text    = attribute_format(vo.isConversion, baseV)
                table.insert(t, {
                    order = order,
                    icon = vo.icon,
                    name = vo.name,
                    attrNum = preText,
                    plusAttrNum = baseV ~= preBaseV and text or nil,
                    viewType = CardProgressionConstants.AttrNodeType.Double,
                })
            end
        end)
    end

    table.sort(t, function(a, b) return a.order < b.order end)
    return t, preCombatEffectiveness, combatEffectiveness
end

function CardProgressionLevelUpPanel:GetExpAddition()
    local expAddition         = 0
    local goodsId2ConsumeData = self._goodsId2ConsumeData
    local consumeGoodsList    = self._consumeGoodsList
    for goodsId, consumeNodeData in pairs(goodsId2ConsumeData) do
        local index     = consumeNodeData.index
        local selectNum = consumeNodeData.selectNum
        local goodsVo   = consumeGoodsList[index]
        expAddition     = expAddition + checkNumber(goodsVo.effectNum) * selectNum
    end
    return expAddition
end

function CardProgressionLevelUpPanel:InitArrivalsMaxLvNeedExp(maxLevel)
    local cardExp          = checkNumber(self._cardDojo.cardExp)
    local maxLevelTotalExp = cardConfMgr:GetCardExp(maxLevel, self._cardVo.rare, maxLevel).totalExp
    local arrivalsMaxLvNeedExp = maxLevelTotalExp - cardExp
    return arrivalsMaxLvNeedExp
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

--function CardProgressionLevelUpPanel:OnClickBtnStylePreviewAction()
--    local skinId = self._cardVo.urSkin
--    if skinId == 0 then
--        printError("角色卡牌表 卡牌%s 未配置 urSkin", self._cardVo.roleId)
--        return
--    end
--    CardProgressionUtils.OpenDialog(Constants.UITypeIds.CommonStylePreView, {skinId = skinId}, {
--        UIArgs(Constants.UITypeIds.CultivateMain)
--    })
--    
--end

function CardProgressionLevelUpPanel:OnClickBtnChooseAction()
    if checkInt(self._cardDojo.cardLevel) >= self._cardLevelLimit then
        self:ShowLevelLimitTips()
        return
    end
    local targetExp            = self:InitArrivalsMaxLvNeedExp(math.min(self._maxLevel, self._cardLevelLimit))
    local consumeGoodsList     = self._consumeGoodsList
    --- 1. 检查下剩余道具是否能满足 arrivalsMaxLvNeedExp
    local leftTotalExp = 0
    for i, goodsVo in ipairs(consumeGoodsList) do
        local effectNum          = goodsVo.effectNum
        local consumeNodeData    = self._goodsId2ConsumeData[goodsVo.id]
        local canUseGoodTotalExp = consumeNodeData.ownNum * effectNum
        leftTotalExp = leftTotalExp + canUseGoodTotalExp
    end
        
    --- 检查剩余经验是否满足 剩余的到达最大等级所需经验
    if leftTotalExp <= targetExp then
        for index, goodsVo in ipairs(consumeGoodsList) do
            local consumeNodeData     = self._goodsId2ConsumeData[goodsVo.id]
            consumeNodeData.selectNum = consumeNodeData.ownNum
            targetExp = targetExp - consumeNodeData.ownNum * goodsVo.effectNum
            self:FreshGoodsConsumeNodeSelectNumByNode(self._goodsConsumeNodes[index], consumeNodeData)
        end
    else
        local goodsIndex2Count = self:CalcOneKeyChooseGoodsByDescending(targetExp)
        for index, goodsVo in ipairs(consumeGoodsList) do
            local selectNum = goodsIndex2Count[index] or 0
            local consumeNodeData     = self._goodsId2ConsumeData[goodsVo.id]
            consumeNodeData.selectNum = selectNum
            targetExp = targetExp - selectNum * goodsVo.effectNum
            self:FreshGoodsConsumeNodeSelectNumByNode(self._goodsConsumeNodes[index], consumeNodeData)
        end
    end
    self._arrivalsMaxLvNeedExp = targetExp
    self:FreshLevelInfo()
    
end

function CardProgressionLevelUpPanel:CalcOneKeyChooseGoodsByDescending(targetExp)
    local arrivalsMaxLvNeedExp = targetExp
    local consumeGoodsList     = self._consumeGoodsList
    local goodsId2ConsumeData  = self._goodsId2ConsumeData
    local goodsListCount       = #consumeGoodsList
    
    ---1. 从大向小填充道具 
    local leftExp = arrivalsMaxLvNeedExp
    local goodsIndex2Count = { 0, 0, 0, 0 }
    
    for index = goodsListCount, 1, -1 do
        ---@type GoodsVo
        local goodsVo         = consumeGoodsList[index]
        local effectNum       = goodsVo.effectNum
        local consumeNodeData = goodsId2ConsumeData[goodsVo.id]
        local leftNum         = consumeNodeData.ownNum

        local count = math.min(math.floor(leftExp / effectNum), leftNum)
        leftExp = leftExp - count * effectNum
        goodsIndex2Count[index] = count
    end

    if leftExp == 0 then
        return goodsIndex2Count
    end

    ---2. 寻找满足继续填充条件的下标 
    local index = 0
    for i, goodsVo in ipairs(consumeGoodsList) do
        local consumeNodeData = goodsId2ConsumeData[goodsVo.id]
        local leftNum         = consumeNodeData.ownNum
        if goodsVo.effectNum >= leftExp and leftNum - goodsIndex2Count[i] > 0 then 
            index = i
            break 
        end
    end
    
    --print("goodsIndex2Count-", table.toString(goodsIndex2Count))
    if index <= 0 then
        return goodsIndex2Count
    end
    
    --- 3.补齐
    local overflowExp = consumeGoodsList[index].effectNum - leftExp
    goodsIndex2Count[index] = goodsIndex2Count[index] + 1

    for i = index - 1, 1, -1 do
        local effectNum = consumeGoodsList[i].effectNum
        if overflowExp - effectNum > 0 and goodsIndex2Count[i] > 0 then
            local count = math.floor(overflowExp / effectNum)
            count = math.min(count, goodsIndex2Count[i])
            goodsIndex2Count[i] = goodsIndex2Count[i] - count
            overflowExp = overflowExp - effectNum * count
        end
    end

    --- 4.合并
    -- print(table.toString(self._index2Proportion))
    for i = 2, goodsListCount, 1 do
        local goodsVo = consumeGoodsList[i]
        local consumeNodeData = goodsId2ConsumeData[goodsVo.id]
        local leftNum         = consumeNodeData.ownNum
        if goodsIndex2Count[i - 1] >= self._index2Proportion[i] and leftNum - goodsIndex2Count[i] > 0 then
            --- 因为在步骤3 补齐 只会加一个道具 所以 不会出现过量溢出
            goodsIndex2Count[i - 1] = goodsIndex2Count[i - 1] - self._index2Proportion[i]
            goodsIndex2Count[i] = goodsIndex2Count[i] + 1 
        end
    end
    
    return goodsIndex2Count
end

function CardProgressionLevelUpPanel:CalcOneKeyChooseGoods(targetExp)
    local arrivalsMaxLvNeedExp = targetExp
    local consumeGoodsList     = self._consumeGoodsList
    local goodsId2ConsumeData  = self._goodsId2ConsumeData
    
    local function GetOwnNumByIndex(index)
        ---@type GoodsVo
        local goodsVo            = consumeGoodsList[index]
        local consumeNodeData    = goodsId2ConsumeData[goodsVo.id]
        return consumeNodeData.ownNum
    end
    
    local function GetEffectNumByIndex(index)
        ---@type GoodsVo
        local goodsVo = consumeGoodsList[index]
        return goodsVo.effectNum
    end

    --- 1. 收集选择结果
    local function CollectionSelectRes()
        local path    = {}
        local resList = {}
        ---@param goodsVo GoodsVo
        for index, goodsVo in ipairs(consumeGoodsList) do
            local effectNum = goodsVo.effectNum
            --- 由于 现在 从低品质到高品质的 道具是成倍的 所有 直接 减去 effectNum 就行 如果不成被就要改成1
            for goal = arrivalsMaxLvNeedExp, effectNum, -effectNum do
                local count              = 1
                local consumeNodeData    = goodsId2ConsumeData[goodsVo.id]
                local leftNum            = consumeNodeData.ownNum
                while count <= leftNum and goal >= count * effectNum do
                    local num = count * effectNum
                    local old = resList[goal] or 0
                    local new = (resList[goal - num] or 0) + num
                    local res = math.max(old, new)
                    resList[goal] = res
                    if new > old then
                        path[index] = path[index] or {}
                        path[index][goal] = path[index][goal] or {}
                        path[index][goal][count] = true
                    end
    
                    count = count + 1
                end
            end
    
        end
        return path, resList
    end
    local path, resList = CollectionSelectRes()

    --- 2. 收集道具选择数量
    local function CollectionGoodsIndex2Count()
        local goodsIndex2Count = {}
        local i, j = #consumeGoodsList, arrivalsMaxLvNeedExp
        while i > 0 and j > 0 do
            local effectNUm = GetEffectNumByIndex(i)
            local ownNum = GetOwnNumByIndex(i)
            for count = ownNum, 0, -1 do
                if path[i] and path[i][j] and path[i][j][count] then
                    j = j - effectNUm
                    goodsIndex2Count[i] = (goodsIndex2Count[i] or 0) + 1
                end
            end
            i = i - 1
        end
        return goodsIndex2Count
    end
    local goodsIndex2Count = CollectionGoodsIndex2Count()

    local needExp = arrivalsMaxLvNeedExp - (resList[arrivalsMaxLvNeedExp] or 0)
    ---3. 获取需要继续填充的道具下标
    local function GetNeedIndex()
        local needIdx
        for goodsIndex, goodsVo in ipairs(consumeGoodsList) do
            local effectNum = goodsVo.effectNum
            local ownNum = GetOwnNumByIndex(goodsIndex)
            local count = goodsIndex2Count[goodsIndex] or 0
            if ownNum - count > 0 and effectNum >= needExp then
                needIdx = goodsIndex
                break
            end
        end
        
        return needIdx
    end
    local needIdx = GetNeedIndex()
    --print("goodsIndex2Count1", needIdx, table.toString(goodsIndex2Count))

    if needIdx == nil then
        return goodsIndex2Count
    end

    --- 4. 修正 goodsIndex2Count
    local effectNUm = GetEffectNumByIndex(needIdx)
    local overflowExp = effectNUm - needExp
    for i = needIdx, 1, -1 do
        goodsIndex2Count[i] = goodsIndex2Count[i] or 0
        
        if i == needIdx then
            goodsIndex2Count[i] = goodsIndex2Count[i] + 1
        elseif overflowExp - GetEffectNumByIndex(i) > 0 and goodsIndex2Count[i] > 0 then
            local effectNum = GetEffectNumByIndex(i)
            local count = math.floor(overflowExp / effectNum)
            count = math.min(count, goodsIndex2Count[i])
            goodsIndex2Count[i] = goodsIndex2Count[i] - count
            overflowExp = overflowExp - effectNum * count
        end
        
    end
    
    --print("goodsIndex2Count2", table.toString(goodsIndex2Count))
    return goodsIndex2Count
end

function CardProgressionLevelUpPanel:OnClickBtnAction()
    local goodsId2count
    local consumes
    for goodsId, v in pairs(self._goodsId2ConsumeData) do
        local selectNum = v.selectNum
        if selectNum > 0 then
            goodsId2count = goodsId2count or {}
            goodsId2count[tostring(goodsId)] = selectNum
            consumes = consumes or {}
            table.insert(consumes, { goodsId = goodsId, num = -selectNum })
        end
    end
    ----- 升级材料为0 选择升级材料 弹消耗不足界面
    --if count == #self._consumeGoodsList then
    --    GoodsUtils.ShowCommonLackMaterialDialog({
    --        {goodsId = self._consumeGoodsList[1].refId, num = 0}
    --    })
    --    return
    --end

    ---检查是否到达最大等级
    ---@type CardDojo
    local cardDojo = self._cardDojo
    local cardLevel = checkNumber(cardDojo.cardLevel)
    if cardLevel >= self._cardLevelLimit then
        self:ShowLevelLimitTips()
        return
    end

    if cardLevel >= self._maxLevel then
        GameUtils.Toast(localize('已达到等级上限'))
        return
    end

    --- 1. 检查是否选择过道具
    local expAddition = self:GetExpAddition()
    if expAddition <= 0 then
        GameUtils.Toast(localize('当前未选择材料'))
        return
    end

    if self._overflowExp > 0 then
        expAddition = expAddition - self._overflowExp
    end
    ---2.检查金币是否满足
    local goldConsumeNum = expAddition * self._cardConsume
    local goldConsume = {goodsId = Constants.Currency.GoldId, num = goldConsumeNum}
    if not GoodsUtils.CheckConsumeDataCondition({goldConsume}) then
        return
    end

    
    
    goldConsume.num = -1 * goldConsume.num
    table.insert(consumes, goldConsume)

    if self._overflowExp > 0 then
        GameUtils.SecondConfirm(localize("溢出_num_点经验值，是否确认升级？", {_num_ = self._overflowExp}), function()
            CardProgressionMgr:RequestOverseaCardLevelUp({playerCardId = cardDojo.id, goods = table.serialize(goodsId2count)}, consumes, cardDojo)
        end)
    else
        CardProgressionMgr:RequestOverseaCardLevelUp({playerCardId = cardDojo.id, goods = table.serialize(goodsId2count)}, consumes, cardDojo)
        
    end
    
    
    
end

function CardProgressionLevelUpPanel:OnClickBtn2Action()
    Events.Broadcast(CardProgressionConstants.EventNames.ToggleTab, CardProgressionConstants.MainViewType.AdvanceLevel)
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionLevelUpPanel
