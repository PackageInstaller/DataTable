--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{author}
    time:2019-12-19 20:09:23
]]
------------ define ------------
local ANIMA_PATH_COMMON = "JumpNumNode_putong"
local ANIMA_PATH_DOUBLE = "JumpNumNode_baoji"
local ANIMA_PATH_BUFF = "JumpNumNode_buff"
local ANIMA_PATH_CURE = "JumpNumNode_jiaxue"
local ANIMAROOTNAME = "Root"
local TYPE_DESC = {
    IsHeal = localize("治疗")
}
local NUM_COLOR_STATUS = {
    default = 1,
    heal = 2,
    sp = 3,
    up = 4,
    down = 5,
}
local DESC_COLOR_STATUS = {
    dot = 1,
    heal = 2,
    immunity = 3,
    shield = 4,
}
local DotTypeIcon = {
    [102010101] = "<sprite=4>",    -- 中毒
    [102020101] = "<sprite=6>",    -- 流血
    [102020102] = "<sprite=5>",    -- 点燃
    [102020103] = "<sprite=8>",    -- 余震
    [114500811] = "<sprite=8>",    -- 余震
    [102030101] = "<sprite=7>",    -- 诅咒
    [115400817] = "<sprite=7>",    -- 诅咒
    [102040101] = "<sprite=9>",    -- 腐蚀
    [102050101] = "<sprite=10>",   -- 病毒
    -- [102060101] = "<sprite=11>",   -- 烈风
    [116000801] = "<sprite=11>",   -- 激流
    [116000802] = "<sprite=11>",   -- 激流
}
------------ define ------------

------------ import ------------
local cs_coroutine = require("XLua.cs_coroutine")
local Animation = CS.UnityEngine.Animation
local RectTransform = CS.UnityEngine.RectTransform
local UISwitchTextMeshPro = CS.Game.Native.Common.UISwitchTextMeshPro
local UISwitchText = CS.Game.Native.Common.UISwitchText
local Text = CS.UnityEngine.UI.Text
local Animator = CS.UnityEngine.Animator
local NamedAnimancerComponent = CS.Animancer.NamedAnimancerComponent
local Animation = CS.UnityEngine.Animation
local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")
local Yielders = CS.Engine.Lib.Yielders
------------ import ------------

--- from: Assets/BundleResources/Prefabs/UIBattling/JumpNumNode.prefab
---@class JumpNumNode
---@field Env                           	JumpNumNode                             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CanvasGroup_Critical          	UnityEngine.CanvasGroup                 
---@field Text_Icon                     	TMPro.TextMeshProUGUI                   
---@field Text_Desc                     	UnityEngine.UI.Text                     
---@field Text_Num                      	TMPro.TextMeshProUGUI                   
---@field Text_CriticalNum2             	TMPro.TextMeshProUGUI                   
---@field Text_CriticalNum              	TMPro.TextMeshProUGUI                   
---@field ParticleRoot                  	UnityEngine.RectTransform               
local JumpNumNode = Class("JumpNumNode")

------------ LifeCycle ------------

function JumpNumNode:__init()
    self:CleanProperty()
end

function JumpNumNode:__delete()
    self:CleanProperty()
    self.controller = nil
    self = nil
end

function JumpNumNode:Awake()
    self.coInit = cs_coroutine.start(function()
        xTry(function()
            self:InitComponent()
        end)
    end)
end

function JumpNumNode:OnDestroy()
    if not IsNull(self.coWaitingAnima) then
        cs_coroutine.stop(self.coWaitingAnima)
    end
    if not IsNull(self.coInit) then
        cs_coroutine.stop(self.coInit)
        self.coInit = nil
    end
    self.controller = nil
    --luabehaviour 中CSharp对象
    self:Delete()
    self = nil
end

------------ LifeCycle ------------

------------ Init ------------

function JumpNumNode:CleanProperty()
    self.txtSwitchNum = nil
    self.txtSwitchDesc = nil
    self.rectTxtNum = nil
    self.rectTxtDesc = nil
    self.rectTxtCriticalNum = nil
    self.nodeAnimation = nil
    self.coWaitingAnima = nil
    self.coInit = nil
    self.animationPath = nil
    self.useStatus = nil
end

function JumpNumNode:InitComponent()
    self.nodeAnimation = self.controller.transform:Find(ANIMAROOTNAME):GetComponent(typeof(Animation))
    self.txtSwitchNum = self.Text_Num.gameObject:GetComponent(typeof(UISwitchTextMeshPro))
    self.txtSwitchDesc = self.Text_Desc.gameObject:GetComponent(typeof(UISwitchText))
    self.rectTxtNum = self.Text_Num.gameObject:GetComponent(typeof(RectTransform))
    self.rectTxtDesc = self.Text_Desc.gameObject:GetComponent(typeof(RectTransform))
    self.rectTxtCriticalNum =self.Text_CriticalNum.gameObject:GetComponent(typeof(RectTransform))
end

------------ Init ------------

------------ Useless ------------

------------ Useless ------------

------------ JumpNodeComponent ------------

function JumpNumNode:RefreshTextRoot()
    self.Text_Desc.enabled = false
    self.Text_Icon.enabled = false
    self.Text_Num.enabled = false
    self.Text_Num.transform.localScale = Vector3.one
    self.CanvasGroup_Critical.alpha = 0
    cs_coroutine.yield_return()
    self.txtSwitchNum.Status = NUM_COLOR_STATUS.default
    self.txtSwitchNum:Reset()
    self.txtSwitchDesc.Status = DESC_COLOR_STATUS.default
    self.txtSwitchDesc:Reset()
end

function JumpNumNode:SetRootPosX(posX)
    self.rectTxtNum.anchoredPosition = Vector2.New(posX or 0, 0)
    self.rectTxtDesc.anchoredPosition = Vector2.New(posX or 0 , 0)
    self.rectTxtCriticalNum.anchoredPosition = Vector2.New(posX or 0, 0)
end

------------ JumpNodeComponent ------------

------------ Animation ------------

function JumpNumNode:PlayJumpNodeAnimation(animPath, isCrit, cb)
    if not IsNull(self.nodeAnimation) and animPath then
        -- print("->TryPlay:JumpNumNode:PlayJumpNodeAnimation", checkString(animPath))
        self.nodeAnimation:Play(checkString(animPath))
        if isCrit then
            -- UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CRITICAL_HIT, self.ParticleRoot.gameObject, 0.3) -- 暴击特效
        end
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(2))
        if cb then cb() end
        cs_coroutine.yield_return()
    end
end

------------ Animation ------------

------------ ShowValueInCondition ------------

--- 治疗描述
function JumpNumNode:SetDescDamageTypeHeal()
    self.Text_Desc.enabled = true
    self.Text_Desc.text = TYPE_DESC.IsHeal
    self.txtSwitchDesc.Status = DESC_COLOR_STATUS.heal
    self.txtSwitchDesc:Reset()
end

--- 治疗数量和动画
---@param data any
function JumpNumNode:SetNumDamageTypeHeal(data)
    self.Text_Num.enabled = true
    self.Text_Num.text = string.format("+%d", checkInt(math.abs(data.damage)))
    self.txtSwitchNum.Status = NUM_COLOR_STATUS.heal
    self.txtSwitchNum:Reset()
    self.animationPath = ANIMA_PATH_CURE
end

--- 暴击数量和动画
---@param data any
function JumpNumNode:SetShowNumCritical(data)
    self.CanvasGroup_Critical.alpha = 1
    local showNum = (isSet(data, "shieldAbsorb") and data.shieldAbsorb > 0 and data.damage <= 0) and data.shieldAbsorb or data.damage
    local showValue = string.format("-%d", checkInt(math.abs(showNum)))
    self.Text_CriticalNum.text = string.format("%s",  showValue)
    self.Text_CriticalNum2.text = string.format("%s",  showValue)
    self.animationPath = ANIMA_PATH_DOUBLE
end

--- 伤害数量和动画
---@param data any
function JumpNumNode:SetShowDamage(data)
    self.Text_Num.enabled = true
    --self:GetShowDescDamageHit(data)
    self.Text_Num.text = self:GetShowValueDamage(data)
    self.txtSwitchNum.Status = checkNumber(data.element) == 0 and 1 or (checkNumber(data.element) > 0 and 4 or 5)
    self.animationPath = ANIMA_PATH_COMMON
end

--- 伤害描述
---@param data any
function JumpNumNode:SetDamageDesc(data)
    if isSet(data, "isDot") and data.isDot then
        self.Text_Desc.enabled = true
        self.Text_Desc.text = self:GetDotDes(data.dotType)
        self.txtSwitchDesc.Status = DESC_COLOR_STATUS.dot
        self.Text_Icon.enabled = true
        self.Text_Icon.text = DotTypeIcon[data.dotType]
        return
    end
    -- if isSet(data, "isHit") and (not data.isHit) then return TYPE_DESC.IsHit end     -- 海外不要格挡了
end

--- 根据有无护盾获取伤害数量
---@param data any
function JumpNumNode:GetShowValueDamage(data)
    local damage = checkInt(math.abs(data.damage + data.shieldAbsorb))
    return string.format("-%d%s", damage, self:GetElementIcon(data)) 
    -- if (isSet(data, "shieldAbsorb") and data.shieldAbsorb > 0 and data.damage <= 0) then
    --     -- 护盾伤害
    --     return self:GetShowIconShieldChange(data)
    -- else
    --     -- 无护盾伤害
    --     return self:GetDamageNumValue(data)
    -- end
end

--- 护盾伤害
---@param data any
function JumpNumNode:GetShowIconShieldChange(data)
    local showValue = checkString(math.floor(math.abs(data.shieldAbsorb)))
    local function _GetShieldIcon() return "<sprite=3>" end
    return string.format("-%s%s%s", showValue, self:GetElementIcon(data), _GetShieldIcon())
end

--- 无护盾伤害
---@param data any
function JumpNumNode:GetDamageNumValue(data)
    return string.format("-%d%s", checkInt(math.abs(data.damage)), self:GetElementIcon(data)) 
end

--- 属性克制图标
---@param data any
function JumpNumNode:GetElementIcon(data)
    if not isSet(data, "element") then return "" end
    if checkNumber(data.element) == 0 then return "" end
    return checkNumber(data.element) > 0 and "<sprite=1>" or "<sprite=0>"
end

---GetDotDes
---获取 Dot 描述
---@param dotType number dot 类型
---@return string 显示的 string
function JumpNumNode:GetDotDes(dotType)    
    local buffId = dotType  -- 这里其实是用buffId做dotType的
    --- showId 判断
    local buffData = Core:GetBuffData(buffId, 1,1)
    local showIds = buffData.showIds
    if isNull(showIds) or #showIds <= 0 then return end -- 数组数据判断
    local showId = showIds[1] -- 子楠兄 Said ~~
    if Tools.isNullKey(showId) then return end
    ---- Buff 飘字
    local buffEffectId = buffData.effects[1]
    local buffDes, buffValue = BattleViewMgr:GetBuffInfo(buffEffectId, showId, buffData.star, buffData.lv)
    return buffDes
end

--- 判断是否是dot
---@param buffId any
function JumpNumNode:IsDotBuff(buffId)
    if not isNull(buffId) then
        local buffData = Core:GetBuffData(buffId, 1, 1)
        return buffData.mainEffectType == Constants.BuffType.Dot
    else
        return false
    end
end
------------ ShowValueInCondition ------------

--- DamageRecord跳字
---@param data any
---@param pos any
function JumpNumNode:ShowValue(data, pos)
    self.useStatus = true
    self.controller.transform.anchoredPosition = pos
    self.controller.transform.localScale = Vector3.one
    self.coWaitingAnima = cs_coroutine.start(function()
        xTry(function()
            self:RefreshTextRoot()
            if data.damageType == Constants.DamageType.Heal then -- 治疗
                self:SetDescDamageTypeHeal()
                self:SetNumDamageTypeHeal(data)
            else
                if data.isCrit then
                    self:SetShowNumCritical(data)
                else
                    self:SetShowDamage(data)
                    self:SetDamageDesc(data)
                end
            end
            --self:SetRootPosX(posX)
            local _animaEndCB = function()
                self.useStatus = false
                UIBattlingCtrlMgr:GetInstance():RecycleJumpNode(self)
                --UIBattlingTools.RecyclePoolObj(self.controller.gameObject, true)
            end
            cs_coroutine.yield_return(self:PlayJumpNodeAnimation(self.animationPath, data.isCrit, _animaEndCB))
        end)
    end)
end

---ShowBuffDes
---展示 Buff 描述(buff跳字)
---@param des string
---@param value number
function JumpNumNode:ShowBuffDes(des, value, buffUDType, buffId)
    self.useStatus = true
    self.controller.transform.localScale = Vector3.one
    self.controller.transform.anchoredPosition = Vector3.zero
    self:RefreshTextRoot()
    self.CanvasGroup_Critical.alpha = 0
    self.Text_Desc.enabled = true
    self.Text_Num.enabled = true
    self.Text_Num.text = ""
    --self.Text_Num.text = value and tostring(value) or "" --todo不显示具体数值
    self.Text_Desc.text = des and tostring(des) or ""
    local isDot = self:IsDotBuff(buffId)
    if isDot then
        self.Text_Icon.enabled = true
        self.Text_Icon.text = DotTypeIcon[buffId]
    end

    -- 需要知道buff是增益还是减益，来决定描述文字的颜色
    self.txtSwitchDesc.Status = buffUDType == 0 and DESC_COLOR_STATUS.default or (buffUDType == 1 and DESC_COLOR_STATUS.immunity or DESC_COLOR_STATUS.dot)

    if not IsNull(self.nodeAnimation) then
        self.nodeAnimation:Play(ANIMA_PATH_BUFF)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1.2))
        self.useStatus = false
        UIBattlingCtrlMgr:GetInstance():RecycleJumpNode(self)
        --UIBattlingTools.RecyclePoolObj(self.controller.gameObject, true)
    end
end

--- 技能效果改变SP跳字
---@param num any
function JumpNumNode:ShowSPChangeDes(num, pos)
    if checkInt(num) == 0 then
        UIBattlingCtrlMgr:GetInstance():RecycleJumpNode(self)
        return
    end
    self.useStatus = true
    self.controller.transform.localScale = Vector3.one
    self.controller.transform.anchoredPosition = pos or Vector3.zero
    self:RefreshTextRoot()
    self.CanvasGroup_Critical.alpha = 0
    self.Text_Desc.enabled = true
    self.Text_Desc.text = "SP"
    self.txtSwitchDesc.Status = DESC_COLOR_STATUS.shield
    self.Text_Num.enabled = true
    self.Text_Num.text = string.format("%s%s%s", num >= 0 and "+" or "-", tostring(math.abs(checkInt(num))), "<sprite=2>")
    self.txtSwitchNum.Status = NUM_COLOR_STATUS.sp

    if not IsNull(self.nodeAnimation) then
        self.nodeAnimation:Play(ANIMA_PATH_BUFF)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(2))
        self.useStatus = false
        UIBattlingCtrlMgr:GetInstance():RecycleJumpNode(self)
        --UIBattlingTools.RecyclePoolObj(self.controller.gameObject, true)
    end
end

return JumpNumNode
