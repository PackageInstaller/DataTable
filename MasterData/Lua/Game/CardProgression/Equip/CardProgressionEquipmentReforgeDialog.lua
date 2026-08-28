
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type CardProgressionMgr
local CardProgressionMgr   = import("Game.CardProgression.CardProgressionMgr"):GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
---@type CardConfMgr
local cardConfMgr      = CardConfMgr:GetInstance()
---@type GoodsConfMgr
local goodsConfMgr      = GoodsConfMgr:GetInstance()
--endregion

--region define
local GoldId = Constants.Currency.GoldId
local GoodNodePrefabPath = "Game.Behaviours.GoodNodeMB"
--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaEquipmentReforgeDialog.prefab > name: CultivateOverseaEquipmentReforgeDialog
---@class CardProgressionEquipmentReforgeDialog
---@field Env                           	CardProgressionEquipmentReforgeDialog   
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnClose                      	UnityEngine.RectTransform               
---@field TextDesc                      	UnityEngine.RectTransform               
---@field ButtonGroup1                  	UnityEngine.RectTransform               
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               
---@field GoodNode                      	UnityEngine.RectTransform               
---@field TxtEquipName                  	UnityEngine.UI.Text                     
---@field ATKNumericalValue             	UnityEngine.RectTransform               
---@field SubAttrNode1                  	UnityEngine.RectTransform               
local CardProgressionEquipmentReforgeDialog = Class('CardProgressionEquipmentReforgeDialog')


function CardProgressionEquipmentReforgeDialog:__init()
    ---@type CardProgressionEquipmentReforgeAttrNode[]
    self.attrNodeEnvs = {}

    self._attrs = nil
    self._consumes = nil
    self._lockIndex = nil
end


function CardProgressionEquipmentReforgeDialog:__delete()
    self.controller = nil
end


function CardProgressionEquipmentReforgeDialog:Awake()
end


function CardProgressionEquipmentReforgeDialog:OnFocus(focus)
    self:RefreshCurrencyBar()
end


function CardProgressionEquipmentReforgeDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
    end))
    return coWait
end


function CardProgressionEquipmentReforgeDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:FreshUI()

    end))
    return coWait
end


function CardProgressionEquipmentReforgeDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function CardProgressionEquipmentReforgeDialog:OnInit()
    self:InitData()
    self:InitHandler()
end

function CardProgressionEquipmentReforgeDialog:InitData()
    local param = self.controller.Argument.parameters
    local equipComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.EquipmentComponent)
    ---@type EquipDojo
    self._equipDojo = equipComponent:GetEquipById(param.equipDojo.id)

    local reforgeConsumeId    = EquipUtils.GetLadderRiseParamValue(CardProgressionConstants.LadderRiseParams.ReforgeConsumeId)
    local reforgeConsumeNum   = EquipUtils.GetLadderRiseParamValue(CardProgressionConstants.LadderRiseParams.ReforgeConsumeNum)
    local reforgeLockGoodsId  = EquipUtils.GetLadderRiseParamValue(CardProgressionConstants.LadderRiseParams.ReforgeLockGoodsId)
    local reforgeLockGoodsNum = EquipUtils.GetLadderRiseParamValue(CardProgressionConstants.LadderRiseParams.ReforgeLockGoodsNum)

    local goodsIds = {}
    local reforgeConsumes = {}
    local reforgeLockConsumes = {}

    for index, value in ipairs(reforgeConsumeId) do
        table.insert(reforgeConsumes, {goodsId = value, num = reforgeConsumeNum[index]})
        if value ~= GoldId then
            table.insert(goodsIds, value)
        end
    end
    for index, value in ipairs(reforgeLockGoodsId) do
        table.insert(reforgeLockConsumes, {goodsId = value, num = reforgeLockGoodsNum[index]})
        if value ~= GoldId then
            table.insert(goodsIds, value)
        end
    end

    self._goodsIds = goodsIds
    self._reforgeConsumes = reforgeConsumes
    self._reforgeLockConsumes = reforgeLockConsumes

    
end

function CardProgressionEquipmentReforgeDialog:InitHandler()
    SetButtonAction(self.BtnClose, Bind(self, self.BtnCloseOnClickHandler))
    SetButtonAction(self.ButtonGroup1, Bind(self, self.BtnReforgeOnClickHandler))
    -- SetButtonAction(self.QuickFontStyleButton, Bind(self, self.BtnQuickUpgradeOnClickHandler))

    self.executeJumpEvent = Events.AddListener(Constants.EventNames.EXECUTE_JUMP, Bind(self, self.ExecuteJumpEventHandler))
end

--endregion 


--region logic 

function CardProgressionEquipmentReforgeDialog:FreshUI()
    self:RefreshEquipmentGoods()
    self:RefreshUI()
    -- self:RefreshButton()
end

function CardProgressionEquipmentReforgeDialog:RefreshUI()
    self:RefreshAttrs()
    self:RefreshConsume()
    -- self:RefreshButton()
end



---刷新货币栏
function CardProgressionEquipmentReforgeDialog:RefreshCurrencyBar()
    CfUtils.RefreshTopGoods(self._goodsIds)
end

---刷新装备道具
function CardProgressionEquipmentReforgeDialog:RefreshEquipmentGoods()
    local equipDojo = self:GetEquipDojo()
    local equipVo = cardConfMgr:GetEquipVoById(equipDojo.equipmentId)
    local partVo = CfUtils.GetCfVo(AutoIds.IdSetting3051, "EquipmentPartVo", equipVo.part)
    local goodsVo = goodsConfMgr:GetGoodsVoById(equipDojo.equipmentId)
    ---@type GoodNodeMB
    local mbEnv = CfUtils.GetLuaScr(self.GoodNode, GoodNodePrefabPath)
    if mbEnv then
        mbEnv:Reload({dojo = equipDojo, goodsId = equipDojo.equipmentId, isShowNo = false})
    end

    self.TxtEquipName.text = goodsVo.name

end

function CardProgressionEquipmentReforgeDialog:RefreshAttrs()
    local equipDojo = self:GetEquipDojo()
    local attrs = equipDojo:GetLadderRiseAttrs()
    self._attrs = attrs
    for index, value in ipairs(attrs) do
        ---@type CardProgressionEquipmentReforgeAttrNode
        local env = self:GetSubAttrEnv(index)
        CfUtils.SetActive(env.controller.gameObject, true)
        if isNotNull(env) then
            local isFirst = env:Init(Bind(self, self.OnClickLockAttrBtnAction),Bind(self, self.CheckIsCanLock))
            env:RefreshUI(attrs[index], index, isFirst, equipDojo)

            if self.isRequestComplete then
                env:PlayRestAni(self._lockIndex)
            end
        end
        
    end

 
end

function CardProgressionEquipmentReforgeDialog:RefreshConsume()
    self._consumes = self:GetConsumes()
    UICommonUtils.FillCommonBtnConsumePopByConsumes(self.CommonBtnConsumePop, self._consumes)
end

-- function CardProgressionEquipmentReforgeDialog:RefreshButton()
    
-- end

--endregion 


--region get/set 

---获取EquipDojo
function CardProgressionEquipmentReforgeDialog:GetEquipDojo()
    return self._equipDojo
end


function CardProgressionEquipmentReforgeDialog:GetSubAttrEnv(i)
    local env = self.attrNodeEnvs[i]
    if env == nil then
        local node
        if i == 1 then
            node = self.SubAttrNode1
        else
            node = self.ATKNumericalValue.gameObject:AddChild(self.SubAttrNode1.gameObject)
        end
        env = CfUtils.GetLuaScr(node, "Game.CardProgression.Equip.CardProgressionEquipmentReforgeAttrNode")
        self.attrNodeEnvs[i] = env
    end
    return env
end

function CardProgressionEquipmentReforgeDialog:GetConsumes()
    local reforgeConsumes     = self._reforgeConsumes
    local reforgeLockConsumes = self._reforgeLockConsumes
    local t = {}
    table.insertto(t, reforgeConsumes)
    if self._lockIndex then
        for key, value in pairs(reforgeLockConsumes) do
            table.insert(t, value) 
        end
    end
    return t
end

---endregion 


--region handler 

function CardProgressionEquipmentReforgeDialog:BtnCloseOnClickHandler()
    Events.Broadcast(Constants.EventNames.CardProgressEquipSelectClear)
    self:CloseDialog()
end

function CardProgressionEquipmentReforgeDialog:BtnReforgeOnClickHandler()

    local equipDojo = self:GetEquipDojo()
    local isShowSecond = false
    local attrs = self._attrs
    for index, value in ipairs(attrs) do
        if index ~= self._lockIndex then
            isShowSecond = value.attrProgress >= 0.8
            if isShowSecond then
                break
            end
        end
    end

    if isShowSecond then
        GameUtils.SecondConfirm(localize("当前重铸属性已达稀有品质，是否确认继续洗练？"), function ()
            self:CheckAndRequest()    
        end)
    else
        self:CheckAndRequest()
    end

end

function CardProgressionEquipmentReforgeDialog:CheckAndRequest()
    local consumes = self:GetConsumes()
    local equipDojo = self:GetEquipDojo()
    if not GoodsUtils.CheckConsumeDataCondition(consumes, 10) then
        return
    end

    self._befEquipDojo = clone(equipDojo)
    CardProgressionMgr:RequestOverseaEquipmentRedReset({playerEquipmentId = equipDojo.id, lockPositions= self._lockIndex}, function ()
        self.isRequestComplete = true
        self:RefreshUI()
        self.isRequestComplete = false
    end)
end

function CardProgressionEquipmentReforgeDialog:ExecuteJumpEventHandler()
    self:CloseDialog()
end

---@param attr LadderRiseAttr
---@param index number
---@param isLock boolean
function CardProgressionEquipmentReforgeDialog:OnClickLockAttrBtnAction(attr, index, isLock)
    self._lockIndex = isLock and index or nil
    self:RefreshConsume()
end

function CardProgressionEquipmentReforgeDialog:CheckIsCanLock(index)
    if self._lockIndex ~= nil and self._lockIndex ~= index then
        return false
    end
    ---锁1 如果2未解锁这时候
    if (index == 1 and not self._attrs[2].isUnlock) or not self._attrs[index].isUnlock then
        local limitTimes = EquipUtils.GetLadderRiseParamValue(CardProgressionConstants.LadderRiseParams.UnlockSecondAttrReforgeTimes)
        local dojo = self:GetEquipDojo()
        local redResetTimes = checkNumber(dojo.redResetTimes)
        GameUtils.Toast(localize("再重铸_num_次开启属性锁定功能", {_num_ = limitTimes - redResetTimes}))
        return false
    end
    return true
end

---关闭界面
function CardProgressionEquipmentReforgeDialog:CloseDialog()
    UIModule.CloseDialog(self.controller)
end

---endregion 


return CardProgressionEquipmentReforgeDialog
