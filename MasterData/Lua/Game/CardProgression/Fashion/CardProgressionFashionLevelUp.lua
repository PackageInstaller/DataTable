
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardConfMgr
local cardConfMgr              = CardConfMgr:GetInstance()
---@type CardProgressionMgr
local CardProgressionMgr = import('Game.CardProgression.CardProgressionMgr')
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
--endregion

--region define
local SimpleAttributeNodePath = "Game.Behaviours.SimpleAttributeNode"
--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFashionLevelUp.prefab > name: CultivateOverseaFashionLevelUp
---@class CardProgressionFashionLevelUp
---@field Env                           	CardProgressionFashionLevelUp           
---@field controller                    	Engine.UI.UILuaDialog                   
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               	@ 0    
---@field FontStyleButton               	Game.Native.Common.FontStyleButton      	@ 1    
---@field FontStyleButton2              	UnityEngine.RectTransform               	@ 2    
---@field CommonGoodsListLight          	UnityEngine.RectTransform               	@ 3    
---@field ATKNumericalValue3            	UnityEngine.RectTransform               	@ 4    
---@field ATKNumericalValue2            	UnityEngine.RectTransform               	@ 5    
---@field ATKNumericalValue1            	UnityEngine.RectTransform               	@ 6    
---@field Attribute                     	UnityEngine.RectTransform               	@ 7    
---@field TxtAfter                      	TMPro.TextMeshProUGUI                   	@ 8    
---@field TxtBefore                     	TMPro.TextMeshProUGUI                   	@ 9    
---@field CurrentFashionDisplay         	UnityEngine.RectTransform               	@ 10   
---@field Root                          	UnityEngine.Animation                   	@ 11   
---@field BtnClose                      	UnityEngine.RectTransform               	@ 12   
---@field ClickClose                    	UnityEngine.RectTransform               	@ 13   
---@field Fuzzy                         	UGUI.Effects.UIEffectCapturedImage      	@ 14   
local CardProgressionFashionLevelUp = Class('CardProgressionFashionLevelUp')


function CardProgressionFashionLevelUp:__init()
end


function CardProgressionFashionLevelUp:__delete()
    self.controller = nil
end


-- function CardProgressionFashionLevelUp:Awake()
--     -- if isNull(self.Fuzzy) then
--     --     local UIEffectCapturedImage = CS.UGUI.Effects.UIEffectCapturedImage      
--     --     local effectBg = self.controller.transform:Find("Fuzzy").gameObject:GetComponent(typeof(UIEffectCapturedImage))
--     --     self.Fuzzy = effectBg
--     -- end
-- end


function CardProgressionFashionLevelUp:OnFocus(focus)

end


function CardProgressionFashionLevelUp:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:FreshUI()
    end))
    return coWait
end


function CardProgressionFashionLevelUp:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self._isJumpBack then
            self._captureCo = CoStart(function() 
                CoYield(0.1)
                self.Fuzzy:Capture()
            end)
        else
            self.Fuzzy:Capture()
        end
    end))
    return coWait
end


function CardProgressionFashionLevelUp:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local parameters = self.controller.Argument.parameters
        parameters.isJumpBack = not self._isClickClose
        if self._captureCo then
            CoStop(self._captureCo)
            self._captureCo = nil
        end
        if self._eventRequestSuccessAction then
            Events.RemoveListener(CardProgressionConstants.EventNames.RequestSuccess, self._eventRequestSuccessAction)
            self._eventRequestSuccessAction = nil
        end
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function CardProgressionFashionLevelUp:OnInit()
    self:InitData()
    self:InitUI()
    self:InitAction()
end

function CardProgressionFashionLevelUp:InitUI()
    self._attributeNodes = {self.ATKNumericalValue1, self.ATKNumericalValue2, self.ATKNumericalValue3}

    
end

function CardProgressionFashionLevelUp:InitData()
    local parameters = self.controller.Argument.parameters
    local isJumpBack = parameters.isJumpBack
    local skinInfo   = parameters.skinInfo
    ---@type CardSkinVo
    local skinVo     = skinInfo.skinVo
    ---@type CardSkinComponent
    local cardSkinComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)
    local level      = cardSkinComponent:GetSkinLevelById(skinVo.skinId, skinVo.skinMaxLevel)
    self._maxLv      = skinVo.skinMaxLevel
    self._skinVo     = skinVo

    local playerCardId = parameters.playerCardId
    ---@type CardComponent
    local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    ---@type CardDojo
    local cardDojo      = cardComponent:GetCardById(playerCardId)
    ---@type CardProgressionEntity
    self._entity = CardProgressionUtils.GenerateEntity(cardDojo, false)
    self._combatEffectiveness = FormulaUtils.CalcCardCombatEffectiveness(self._entity)

    local limit = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.FashionQuickUpgradeLimit))
    self._limit = limit

    self._skinInfo   = skinInfo
    self._isJumpBack = isJumpBack
    self:InitLevel(level)
    
end

function CardProgressionFashionLevelUp:InitLevel(level)
    self._currentLv = level
    self._nextLv    = level + 1
    self._isMaxLv   = self._currentLv >= self._maxLv
end

function CardProgressionFashionLevelUp:InitAction()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickLevelUpBtnAction))
    SetButtonAction(self.FontStyleButton2, Bind(self, self.OnClickQuickLevelUpBtnAction))
    SetButtonAction(self.BtnClose, Bind(self, self.OnClickBtnCloseAction))
    SetButtonAction(self.ClickClose, Bind(self, self.OnClickBtnCloseAction))

    self._eventRequestSuccessAction = Events.AddListener(CardProgressionConstants.EventNames.RequestSuccess, Bind(self, self.OnEventRequestSuccessAction))
end

--endregion 


--region logic 

function CardProgressionFashionLevelUp:FreshUI(isReload)
    if isReload then
        self:FreshFashionDisplayLevel()
    else
        self:FreshFashionDisplay()
    end

    ---@type CardSkinComponent
    local cardSkinComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)
    CfUtils.SetActive(self.FontStyleButton2, cardSkinComponent:GetSkinLevelUpTimes() >= self._limit)

    self:FreshLevel()
    self:FreshAttributes()
    self:FreshConsume()
    self:FreshBottom()
end

function CardProgressionFashionLevelUp:FreshFashionDisplay()
    ---@type CardProgressionFashionCell
    local env = self:GetFashionCellEnv()
    if isNull(env) then return end
    env:FreshUI(self._skinInfo, 1)

end

function CardProgressionFashionLevelUp:FreshFashionDisplayLevel()
    ---@type CardProgressionFashionCell
    local env = self:GetFashionCellEnv()
    if isNull(env) then return end
    env:FreshLevel(self._skinVo, true)

end

function CardProgressionFashionLevelUp:FreshLevel()
    self.TxtBefore.text = self._currentLv
    self.TxtAfter.text = self._nextLv
end

function CardProgressionFashionLevelUp:FreshAttributes()
    if self._isMaxLv then
        return
    end
    local attributes     = self:GetAttributes()
    local parent         = self.parent
    local attributeNodes = self._attributeNodes
    local count          = #attributes
    local forTimes = math.max(count, #self._attributeNodes)
    for i = 1, forTimes do
        ---@type UnityEngine.RectTransform
        local node = attributeNodes[i]
        if isNull(node) then
            ---@type UnityEngine.RectTransform
            local child = attributeNodes[1]
            local go = parent.gameObject:AddChild(child.gameObject)
            node = go.transform:rectTransform()
            node.anchoredPosition = Vector2.New(child.anchoredPosition.x, child.anchoredPosition.y + (i - 1) * (- child.sizeDelta.y - 1))
            attributeNodes[i] = node
        end

        local data = attributes[i]
        local isShow = data ~= nil
        KTool.SetActive(node.gameObject, isShow)
        if isShow then
            self:FreshAttributeNode(node, data)
        end
    end
end

function CardProgressionFashionLevelUp:FreshAttributeNode(node, data)
    ---@type SimpleAttributeNode
    local env = CfUtils.GetLuaScr(node, SimpleAttributeNodePath)
    if isNull(env) then return end
    env:FreshUI(data)

end

function CardProgressionFashionLevelUp:FreshConsume()
    if self._isMaxLv then
        return
    end
    local skinId         = self._skinVo.skinId
    ---@type SkinAttributeVo
    local nextSkinAttrVo = cardConfMgr:GetSkinAttributeVo(skinId, self._nextLv)
    local consumes       = nextSkinAttrVo:GetConsumes()
    self._consumes       = consumes

    local goodsConsumes, goldNum = GoodsUtils.SpiltGold(consumes)
    UICommonUtils.FillCommonGoodsListLight(self.CommonGoodsListLight, goodsConsumes, false, false, true, true, true)    

    local isShowGoldConsume = goldNum > 0
    KTool.SetActive(self.CommonBtnConsumePop.gameObject, isShowGoldConsume)
    if isShowGoldConsume then
        UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, Constants.Currency.GoldId, goldNum)
    end

end

function CardProgressionFashionLevelUp:FreshBottom()
    local consumes     = self._consumes
    local isCanLevelUp = GoodsUtils.CheckGoodConsumeCondition(consumes)
    self.FontStyleButton:ResetFontStyle(isCanLevelUp and "B1" or "B17")

end


--endregion 


--region get/set 

---GetFashionCellEnv
---@return CardProgressionFashionCell
function CardProgressionFashionLevelUp:GetFashionCellEnv()
    if isNull(self._fashionCellEnv) then
        self._fashionCellEnv = CfUtils.GetLuaScr(self.CurrentFashionDisplay, CardProgressionConstants.EnvPath.CardProgressionFashionCell)
    end
    return self._fashionCellEnv
end

function CardProgressionFashionLevelUp:GetAttributes()
    local skinId = self._skinVo.skinId
    ---@type SkinAttributeVo
    local currentSkinAttrVo = cardConfMgr:GetSkinAttributeVo(skinId, self._currentLv)
    ---@type SkinAttributeVo
    local nextSkinAttrVo = cardConfMgr:GetSkinAttributeVo(skinId, self._nextLv)
    ---这里返回的是总属性 比较差值直接用next的就行
    local currentAttrAddId2V = currentSkinAttrVo:GetAttributes()
    local nextAttrAddId2V    = nextSkinAttrVo:GetAttributes()
    
    local attributes = {}
    for attrAddId, value in pairs(nextAttrAddId2V) do
        local curV = currentAttrAddId2V[attrAddId]
        if curV ~= value then
            ---@type AttrDefinesVo
            local vo = cardConfMgr:GetBasicAttrByBasicAttrAdditionId(attrAddId)
            table.insert(attributes, {
                addAttrId = attrAddId,
                addAttrNum = curV,
                plusAttrNum = value,
                order = vo.order,
            })
        end
    end
    table.sort(attributes, function(a, b) return a.order < b.order end)

    return attributes
end

---endregion 


--region handler 

function CardProgressionFashionLevelUp:OnClickLevelUpBtnAction()
    -- if true then
    --     ---@type CardSkinComponent
    --     local cardSkinComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)
    --     cardSkinComponent:SetSkinLevelById(self._skinVo.skinId, self._nextLv)
    --     Events.Broadcast(CardProgressionConstants.EventNames.RequestSuccess, Interfaces.OverseaCardSkinLevelUp, {level = self._nextLv})
    --     return
    -- end

    local rewards, errorTip =  GoodsUtils.CheckGoodConsume(self._consumes)
    if errorTip then
        GameUtils.Toast(errorTip)
        return
    end

    ---@type CardProgressionMgr
    local cardProgressionMgr = CardProgressionMgr:GetInstance()
    cardProgressionMgr:RequestOverseaCardSkinLevelUp({skinId = self._skinVo.skinId}, 1)

end

function CardProgressionFashionLevelUp:OnClickQuickLevelUpBtnAction()
    local goodsId2ConsumeNum, targetLv = CardProgressionUtils.CalcFashionQuickUpLvConsume(self._skinVo.skinId, self._nextLv, self._maxLv)
    if targetLv == 0 or targetLv == self._currentLv then
        GameUtils.Toast(localize("道具不足"))
        return
    end

    local consume = {}
    for goodsId, num in pairs(goodsId2ConsumeNum) do
        table.insert(consume, {goodsId = goodsId, num = checkInt(num)})
    end

    local tips = localize("是否消耗以下材料，快速升到_num_级？", {_num_ = targetLv})
    GameUtils.SecondConfirm(tips, function()
        ---@type CardProgressionMgr
        local cardProgressionMgr = CardProgressionMgr:GetInstance()
        cardProgressionMgr:RequestOverseaCardSkinLevelUp({skinId = self._skinVo.skinId, targetLevel = targetLv}, targetLv - self._currentLv)
    end, nil, nil, 4, consume, true) 
end

function CardProgressionFashionLevelUp:OnClickBtnCloseAction()
    self._isClickClose = true
    CfUtils.DialogBack()

end

function CardProgressionFashionLevelUp:OnEventRequestSuccessAction(interface, localData)
    if interface == Interfaces.OverseaCardSkinLevelUp then
        -- GameUtils.Toast(localize("升级成功！"))
        local combatEffectiveness = FormulaUtils.CalcCardCombatEffectiveness(self._entity)
        if self._combatEffectiveness ~= combatEffectiveness then
            CardProgressionUtils.ChangePointToast(combatEffectiveness - self._combatEffectiveness, 0.5)
            self._combatEffectiveness = combatEffectiveness
        end
        
        
        local newLv = localData.level
        if newLv >= self._maxLv then
            CfUtils.DialogBack()
            return
        end
        self:InitLevel(newLv)
        self:FreshUI(true)
        CfUtils.StartCoroutineWithBlocker(function()
            self.Root:Play("CultivateOverseaFashionLevelUp_LevelupDescGo")
            CoYield(0.2)
            
        end)
        
    end
end

---endregion 


return CardProgressionFashionLevelUp
