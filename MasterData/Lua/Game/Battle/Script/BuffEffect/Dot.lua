--
-- Author:luqucheng
-- Date: 2019-11-13 15:51:01
--
local BuffEffect = import('Game.Battle.Core.BuffEffect')
local Dot = Class("Dot", BuffEffect)

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function Dot:__init(buff, buffEffectData, effectParams)
    BuffEffect.__init(self, buff, buffEffectData, effectParams)

    local data = self.data
    --@RefType [Game.Battle.Entity.Role#Role]
    local owner = self.buff.owner
    --@RefType [Game.Battle.Entity.Role#Role]
    local attacker = self.buff.attacker

    local dt = Constants.DotType
    local switch = {
        [dt.Poison] = function (  )
            self.value = attacker:GetAttr(Constants.AttrTypeId.Attack)
        end,
        [dt.Bleed] = function (  )
            -- print("[dot] value ", effectParams.buffOverrideValue, table.dump(effectParams))
            self.value = effectParams.buffOverrideValue
        end,
        [dt.Curse] = function (  )
            self.value = attacker:GetAttr(Constants.AttrTypeId.Attack)
        end,
        [dt.Corrosion] = function (  )
            self.value = attacker:GetAttr(Constants.AttrTypeId.Attack)
        end,
        [dt.Virus] = function (  )
            self.value = attacker:GetAttr(Constants.AttrTypeId.Attack)
        end,
        [dt.Gale] = function (  )
            self.value = attacker:GetAttr(Constants.AttrTypeId.Attack)
        end,
        [dt.Torrent] = function (  )
            self.value = attacker:GetAttr(Constants.AttrTypeId.Attack)
        end,
    }

    local func = switch[self.data.subEffectType]
    assert(func, '找不到对应的dot类型:'..self.data.subEffectType)
    func()
end

function Dot:GetValue(  )
    local dt = Constants.DotType
    local data = self.data
    local owner = self.buff.owner
    local attacker = self.buff.attacker

    local giveChange = attacker:GetGiveDotDamage(data.subEffectType)
    local takeChange = owner:GetTakeDotDamage(data.subEffectType)
    local dotDamageChange = math.max(1 + giveChange + takeChange, 0)

    --判断dot类型
    local switch = {
        [dt.Poison] = function (  )
            local dmg = self.value * data.effectNum1[1]
            return dmg
        end,
        [dt.Bleed] = function (  )
            return data.effectNum1[1] * self.value
        end,
        [dt.Curse] = function (  )
            return math.min(owner:GetAttr(Constants.AttrTypeId.Hp) * data.effectNum1[1], self.value * data.effectNum1[2])
        end,
        [dt.Corrosion] = function (  )
            return math.min(owner:GetAttr(Constants.AttrTypeId.NowHp) * data.effectNum1[1], self.value * data.effectNum1[2])
        end,
        [dt.Virus] = function (  )
            return math.min(owner:GetAttr(Constants.AttrTypeId.NowHp) * data.effectNum1[1], data.effectNum1[2])
        end,
        [dt.Gale] = function (  )
            local atk = self.value
            local param = data.effectNum1
            local nowHp = owner:GetAttr(Constants.AttrTypeId.NowHp)
            local hp = owner:GetAttr(Constants.AttrTypeId.Hp)
            return math.min(atk * param[1] * (1 + nowHp / hp * param[2] * 100), atk * param[3])
        end,
        [dt.Torrent] = function (  )
            return math.min(owner:GetAttr(Constants.AttrTypeId.Hp) * data.effectNum1[1], self.value * data.effectNum1[2])
        end,
    }
    return switch[data.subEffectType]() * dotDamageChange, data.miniEffectType
end

--- 携带者身上有某个ID的BUFF时，就操作特殊寄存器
function Dot:IsNeedOperateSpecialRegister()
    local dt = Constants.DotType
    local data = self.data
    local params = data.effectNum1

    local switch = {
        [dt.Poison] = function (  )
            return params[2]
        end,
        [dt.Bleed] = function (  )
            return params[2]
        end,
        [dt.Curse] = function (  )
            return params[3]
        end,
        [dt.Corrosion] = function (  )
            return params[3]
        end,
        [dt.Virus] = function (  )
            return params[3]
        end,
        [dt.Gale] = function (  )
            return params[4]
        end,
        [dt.Virus] = function (  )
            return params[3]
        end,
        [dt.Torrent] = function (  )
            return params[3]
        end,
    }
    local checkBuffId = switch[data.subEffectType]()
    local owner = self.buff.owner
    local has = owner.buffMgr:HasBuffByBuffTypeID(checkBuffId)
    return has
end

--- 携带者身上有某个ID的BUFF时，就操作特殊寄存器
function Dot:GetRegisterNum2()
    local dt = Constants.DotType
    local data = self.data
    local params = data.effectNum1

    local switch = {
        [dt.Poison] = function (  )
            return params[3]
        end,
        [dt.Bleed] = function (  )
            return params[3]
        end,
        [dt.Curse] = function (  )
            return params[4]
        end,
        [dt.Corrosion] = function (  )
            return params[4]
        end,
        [dt.Virus] = function (  )
            return params[4]
        end,
        [dt.Gale] = function (  )
            return params[5]
        end,
        [dt.Virus] = function (  )
            return params[4]
        end,
        [dt.Torrent] = function (  )
            return params[4]
        end,
    }
    
    return switch[data.subEffectType]()
end

return  Dot