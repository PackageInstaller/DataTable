--
-- Author:luqucheng
-- Date: 2019-11-13 15:51:01
--
local BuffEffect = import('Game.Battle.Core.BuffEffect')
local Hot = Class("Hot", BuffEffect)

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function Hot:__init(buff, buffEffectData, effectParams)
    BuffEffect.__init(self, buff, buffEffectData, effectParams)

    -- self.value = attacker:GetAttr(Constants.AttrTypeId.Attack) + attacker:GetAttr(Constants.AttrTypeId.MAttack) 
    local data = self.data
    local owner = self.buff.owner
    local attacker = self.buff.attacker

    local dt = Constants.HotType
    local switch = {
        [dt.Hot1] = function (  )
            self.value = attacker:GetAttr(Constants.AttrTypeId.Attack)
        end,
        [dt.Hot2] = function (  )
            self.value = attacker:GetAttr(Constants.AttrTypeId.Attack)
            self.value2 = attacker:GetAttr(Constants.AttrTypeId.Hp)
        end,
        [dt.Hot3] = function (  )
            self.value = attacker:GetAttr(Constants.AttrTypeId.MAttack)
        end,
        [dt.Hot4] = function (  )
            self.value = attacker:GetAttr(Constants.AttrTypeId.Attack)
        end,
    }

    local func = switch[self.data.subEffectType]
    assert(func, '找不到对应的hot类型:'..self.data.subEffectType)
    func()
end

function Hot:GetValue(  )
    local dt = Constants.HotType
    local data = self.data
    local owner = self.buff.owner
    local attacker = self.buff.attacker

    --判断dot类型
    local switch = {
        [dt.Hot1] = function (  )
            return self.value * data.effectNum1[1], Constants.DamageType.Heal
        end,
        [dt.Hot2] = function (  )
            return self.value * data.effectNum1[1] + self.value2 * data.effectNum1[2] , Constants.DamageType.Heal
        end,
        [dt.Hot3] = function (  )
            return self.value * data.effectNum1[1] + owner:GetAttr(Constants.AttrTypeId.Hp) * data.effectNum1[2], Constants.DamageType.Heal
        end,
        [dt.Hot4] = function (  )
            return self.value * data.effectNum1[1] 
            + (owner:GetAttr(Constants.AttrTypeId.Hp) - owner:GetAttr(Constants.AttrTypeId.NowHp)) * data.effectNum1[2], 
            Constants.DamageType.Heal
        end

    }
    return switch[data.subEffectType]()
end

--- 携带者身上有某个ID的BUFF时，就操作特殊寄存器
function Hot:IsNeedOperateSpecialRegister()
    local dt = Constants.HotType
    local data = self.data
    local params = data.effectNum1

    local switch = {
        [dt.Hot1] = function (  )
            return params[2]
        end,
        [dt.Hot2] = function (  )
            return params[3]
        end,
        [dt.Hot3] = function (  )
            return params[3]
        end,
        [dt.Hot4] = function (  )
            return params[3]
        end,
    }
    local checkBuffId = switch[data.subEffectType]()
    local owner = self.buff.owner
    local has = owner.buffMgr:HasBuffByBuffTypeID(checkBuffId)
    return has
end

--- 携带者身上有某个ID的BUFF时，就操作特殊寄存器
function Hot:GetRegisterNum2()
    local dt = Constants.HotType
    local data = self.data
    local params = data.effectNum1

    local switch = {
        [dt.Hot1] = function (  )
            return params[3]
        end,
        [dt.Hot2] = function (  )
            return params[4]
        end,
        [dt.Hot3] = function (  )
            return params[4]
        end,
        [dt.Hot4] = function (  )
            return params[4]
        end,
    }
    
    return switch[data.subEffectType]()
end

return  Hot