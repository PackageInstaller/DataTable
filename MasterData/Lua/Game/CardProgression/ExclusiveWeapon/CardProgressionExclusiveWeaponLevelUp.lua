
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type CardConfMgr
local cardConfMgr      = CardConfMgr:GetInstance()
local UICommonUtils    = UICommonUtils
---@type CardProgressionMgr
local CardProgressionMgr = import('Game.CardProgression.CardProgressionMgr')
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaSpecialWeaponLevelUp.prefab > name: CultivateOverseaSpecialWeaponLevelUp
---@class CardProgressionExclusiveWeaponLevelUp
---@field Env                           	CardProgressionExclusiveWeaponLevelUp   
---@field controller                    	Engine.UI.UILuaDialog                   
---@field TipsIllustrate                	UnityEngine.RectTransform               
---@field TipsClickClose                	UnityEngine.RectTransform               
---@field BtnIllustrate                 	UnityEngine.RectTransform               
---@field SuccessRateTxtNumber          	TMPro.TextMeshProUGUI                   
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               
---@field FontStyleButton               	Game.Native.Common.FontStyleButton      
---@field CommonGoodsListLight          	UnityEngine.RectTransform               
---@field UpLevelTxtDesc                	CustomText                     
---@field ATKNumericalValue1            	UnityEngine.RectTransform               
---@field Attribute                     	UnityEngine.RectTransform               
---@field TxtAfter                      	TMPro.TextMeshProUGUI                   
---@field TxtBefore                     	TMPro.TextMeshProUGUI                   
---@field Root                          	UnityEngine.Animation                   
---@field BtnClose                      	UnityEngine.RectTransform               
local CardProgressionExclusiveWeaponLevelUp = Class('CardProgressionExclusiveWeaponLevelUp')


function CardProgressionExclusiveWeaponLevelUp:__init()
    self._isShowTips = false

end


function CardProgressionExclusiveWeaponLevelUp:__delete()
    self.controller = nil
end


-- function CardProgressionExclusiveWeaponLevelUp:Awake()
-- end


-- function CardProgressionExclusiveWeaponLevelUp:OnFocus(focus)

-- end


function CardProgressionExclusiveWeaponLevelUp:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:FreshUI()
    end))
    return coWait
end


-- function CardProgressionExclusiveWeaponLevelUp:OnShow()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
--     end))
--     return coWait
-- end


function CardProgressionExclusiveWeaponLevelUp:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
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

function CardProgressionExclusiveWeaponLevelUp:OnInit()
    self:InitData()

    self:InitAction()

end

function CardProgressionExclusiveWeaponLevelUp:InitData()
    local parameters    = self.controller.Argument.parameters
    local playerCardId  = parameters.playerCardId
    ---@type CardComponent
    local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    ---@type CardDojo 
    local cardDojo      = cardComponent:GetCardById(playerCardId)
    self._cardDojo      = cardDojo
    self._cardId        = cardDojo.cardId
    self._maxLv         = cardConfMgr:GetMaxCardExclusiveWeaponLv(cardDojo.cardId)
    ---@type CardProgressionEntity
    self._entity        = CardProgressionUtils.GenerateEntity(cardDojo, false)

    self:InitLevelData(checkNumber(cardDojo.weaponUnlocked))
    
end

function CardProgressionExclusiveWeaponLevelUp:InitLevelData(weaponLv)
    self._weaponLv = weaponLv
    --- 大于最大等级会自动关闭该界面 不用做检查
    self._nextLv   = weaponLv + 1

    ---@type RoleCardExclusiveWeaponVo
    self._vo = cardConfMgr:GetRoleCardExclusiveWeaponVo(self._cardId, self._nextLv)

    local consumes = self._vo:GetConsumes()
    self._goodsConsumes, self._goldNum = GoodsUtils.SpiltGold(consumes)
    self._consumes = consumes

    self._baseRate  = cardConfMgr:GetRoleCardExclusiveWeaponBaseRate(self._nextLv)
    self._extraRate = cardConfMgr:GetRoleCardExclusiveWeaponExtraRate(self._nextLv)
    self._times     = checkNumber(self._cardDojo.weaponFailTimes)

end

function CardProgressionExclusiveWeaponLevelUp:InitAction()
    local Bind            = Bind
    local SetButtonAction = SetButtonAction
    SetButtonAction(self.BtnClose,        Bind(self, self.OnClickBtnCloseAction))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickLevelUpAction))
    SetButtonAction(self.TipsClickClose,  Bind(self, self.OnClickTipsClickCloseAction))
    SetButtonAction(self.BtnIllustrate,   Bind(self, self.OnClickBtnIllustrateAction))

    self._eventRequestSuccessAction = Events.AddListener(CardProgressionConstants.EventNames.RequestSuccess, Bind(self, self.OnEventRequestSuccessAction))

end

--endregion 


--region logic 

function CardProgressionExclusiveWeaponLevelUp:FreshUI()
    self:FreshLevel()
    self:FreshLevelDesc()
    self:FreshConsume()
    self:FreshRate()
end

function CardProgressionExclusiveWeaponLevelUp:FreshLevel()
    self.TxtBefore.text = self._weaponLv
    self.TxtAfter.text  = self._nextLv

end

function CardProgressionExclusiveWeaponLevelUp:FreshLevelDesc()
    self.UpLevelTxtDesc.text = self._vo.upgrade

end

function CardProgressionExclusiveWeaponLevelUp:FreshConsume()
    UICommonUtils.FillCommonGoodsListLight(self.CommonGoodsListLight, self._goodsConsumes, false, false, true, true, true) 

    local goldNum           = self._goldNum
    local isShowGoldConsume = goldNum > 0
    CfUtils.SetActive(self.CommonBtnConsumePop.gameObject, isShowGoldConsume)
    if isShowGoldConsume then
        UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, Constants.Currency.GoldId, goldNum)

    end

    local consumeData, errorTip =  GoodsUtils.CheckGoodConsume(self._consumes)
    self._consumeData, self._errorTip = consumeData, errorTip
    self.FontStyleButton:ResetFontStyle(errorTip == nil  and "B1" or "B17")
end

function CardProgressionExclusiveWeaponLevelUp:FreshRate()
    local baseRate  = self._baseRate
    local extraRate = self._extraRate * self._times
    local totalRate = baseRate + extraRate
    self.SuccessRateTxtNumber.text = string.format("<size=36><color=#434343>%d%%</size></color>(%d%%+<color=#01ccc3>%d%%</color>)", totalRate, baseRate, extraRate)

end

function CardProgressionExclusiveWeaponLevelUp:FreshTipsShowState()
    CfUtils.SetActive(self.TipsIllustrate, self._isShowTips)
    CfUtils.SetActive(self.TipsClickClose, self._isShowTips)
end

--endregion 


--region get/set 


---endregion 


--region handler 

function CardProgressionExclusiveWeaponLevelUp:OnClickBtnCloseAction()
    CfUtils.DialogBack()

end

function CardProgressionExclusiveWeaponLevelUp:OnClickTipsClickCloseAction()
    if not self._isShowTips then return end
    self._isShowTips = false
    self:FreshTipsShowState()
end

function CardProgressionExclusiveWeaponLevelUp:OnClickBtnIllustrateAction()
    self._isShowTips = true
    self:FreshTipsShowState()
end

function CardProgressionExclusiveWeaponLevelUp:OnClickLevelUpAction()
    
    local consumeData, errorTip = self._consumeData, self._errorTip
    if errorTip then
        GameUtils.Toast(errorTip)
        return
    end

    if self._combatEffectiveness == nil then
        self._combatEffectiveness = FormulaUtils.CalcCardCombatEffectiveness(self._entity)
    end
    ---@type CardProgressionMgr
    local cardProgressionMgr = CardProgressionMgr:GetInstance()
    cardProgressionMgr:RequestOverseaCardWeaponLevelUp({playerCardId = self._cardDojo.id}, consumeData)

end

function CardProgressionExclusiveWeaponLevelUp:OnEventRequestSuccessAction(interface, localData)
    if interface == Interfaces.OverseaCardWeaponLevelUp then
        local isSuccess = localData.isSuccess
        GameUtils.Toast(isSuccess and localize("升级成功") or localize("升级失败"))

        local combatEffectiveness = FormulaUtils.CalcCardCombatEffectiveness(self._entity)
        if self._combatEffectiveness ~= combatEffectiveness then
            CardProgressionUtils.ChangePointToast(combatEffectiveness - self._combatEffectiveness, 0.5)
            self._combatEffectiveness = combatEffectiveness
        end

        ---@type CardDojo
        local dojo  = localData.dojo
        local newLv = checkNumber(dojo.weaponUnlocked)
        
        if newLv >= self._maxLv then
            -- CfUtils.DialogBack()
            -- CfUtils.SetActive(self.controller)
            self.controller.CacheCanvas.enabled = false
            CardProgressionUtils.PlayWeaponOpenTimeline(localData)

            return
        end

        self:InitLevelData(newLv)
        self:FreshUI()
        CfUtils.StartCoroutineWithBlocker(function()
            self.Root:Play(isSuccess and "CultivateOverseaSpecialWeaponLevelUpGo" or "CultivateOverseaSpecialWeaponLevelUpLose")
            CoYield(0.2)
            
        end)
        

    end
end

---endregion 


return CardProgressionExclusiveWeaponLevelUp
