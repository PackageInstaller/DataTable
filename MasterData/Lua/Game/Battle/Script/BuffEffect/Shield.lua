--
-- Author:luqucheng
-- Date: 2019-11-14 10:12:24
--
local BuffEffect = import('Game.Battle.Core.BuffEffect')
local Shield = Class("Shield", BuffEffect)

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function Shield:__init(buff, buffEffectData, effectParams)
    BuffEffect.__init(self, buff, buffEffectData, effectParams)
    local data = self.data
    local owner = self.buff.owner
    local attacker = self.buff.attacker

    --计算护盾初始值
    local switch = {
        [1] = function (  )
            --护盾计算公式
            return (attacker:GetAttr(Constants.AttrTypeId.Attack) + attacker:GetAttr(Constants.AttrTypeId.MAttack) ) * data.effectNum1[1]
        end,
        [2] = function (  )
            return attacker:GetAttr(Constants.AttrTypeId.Defense) * data.effectNum1[1]
        end,
        [4] = function (  )
            return owner:GetAttr(Constants.AttrTypeId.Hp) * data.effectNum1[1]
        end,
        [5] = function (  )
            local lostHp = owner:GetAttr(Constants.AttrTypeId.Hp) - owner:GetAttr(Constants.AttrTypeId.NowHp)
            local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
            return lostHp * data.effectNum1[1] + atk * data.effectNum1[2]
        end,
        [6] = function ()
            --读取之前效果里面的所有伤害求和
            local totalHpChange = 0
            local damageRecs = BattleMgr:GetNowSkillDamageRecs()
            for i,v in ipairs(damageRecs) do
                if v:IsDamage() then
                    totalHpChange = totalHpChange + v.hpChange
                end
            end
            return totalHpChange * data.effectNum1[1]
        end,
        [7] = function (  )
            local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
            local hp = attacker:GetAttr(Constants.AttrTypeId.Hp)
            return hp * data.effectNum1[1] + atk * data.effectNum1[2]
        end,
        [8] = function (  )
            return effectParams.shieldValue
        end,
        [9] = function ()
            local atk = attacker:GetAttr(Constants.AttrTypeId.Attack)
            local nowHp = attacker:GetAttr(Constants.AttrTypeId.NowHp)
            return nowHp * data.effectNum1[1] + atk * data.effectNum1[2]
        end,
        -- 按寄存器累积量*Num给目标上护盾
        [10] = function (  )
            local num = attacker.roleContextData:GetRegister1()
            return num * data.effectNum1[1]
        end,
    }

    local func = switch[data.subEffectType]
    assert(func, '找不到对应的护盾公式'..data.subEffectType)
    local takeShieldIncrease = owner:GetAttr(Constants.AttrTypeId.TakeShieldIncrease)
    local giveShieldIncrease = 0
    if attacker then
        giveShieldIncrease = attacker:GetAttr(Constants.AttrTypeId.GiveShieldIncrease)
    end
    local shieldChange = math.max(1 + giveShieldIncrease + takeShieldIncrease, 0)
    self.value = func() * shieldChange

    if BattleInfo:IsPVP() then
        local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting4100, "PVPBuffVo")
        ---@type PVPBuffVo
        local vo = setting:Get(BattleMgr.initData.pvpSettingId)
        if not isNull(vo) then
            print(string.format("PVPBuff修改前护盾:%f,修改后:%f",self.value, self.value * vo.globalShield))
            self.value = self.value * vo.globalShield
        end
    end
    
    self.valueMax = self.value
end

--返回值 伤害剩余量
function Shield:AbsorbDamage( dmg, dmgTypeVo )
    local startValue = self.value
    local ratio = checkNumber(dmgTypeVo.damageRatioParams[1])
    local isAntiShield = Core:DamageFitTag(dmgTypeVo.damageTags, Constants.DamageTag.AntiShield)
    if isAntiShield then
        dmg = dmg * ratio
    end
    --减护盾值
    if self.value >= dmg then
        self.value = self.value - dmg
        return 0, startValue - self.value
    else
        dmg = dmg - self.value
        self.value = 0
        if isAntiShield then
            dmg = dmg / ratio
        end
        return dmg, startValue - self.value
    end
end

function Shield:GetValueMax()
    return self.valueMax
end

return  Shield