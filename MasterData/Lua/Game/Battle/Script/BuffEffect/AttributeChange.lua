--[[
    author:luqucheng
    time:2020-11-03 11:24:36
]]
local BuffEffect = import('Game.Battle.Core.BuffEffect')
local AttributeChange = Class("AttributeChange", BuffEffect)

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function AttributeChange:__init(buff, buffEffectData, effectParams)
    BuffEffect.__init(self, buff, buffEffectData, effectParams)
    self:Refresh()
end

function AttributeChange:Refresh()
    local oldValue = self.value
    local data = self.data
    --@RefType [Game.Battle.Entity.Role#Role]
    local owner = self.buff.owner
    --@RefType [Game.Battle.Entity.Role#Role]
    local attacker = self.buff.attacker

    local switch = {
        [1] = function (  )
            self.value = data.effectNum1[1]
        end,
        [2] = function (  )
            --根据施法者的atk的百分比，提供给其他角色属性
            local attack = attacker:GetBaseAttr(Constants.AttrTypeId.Attack)
            self.value = attack * data.effectNum1[1]
        end,
        [3] = function (  )
            ---YAJIE 新改过公式
            --消耗【释放者当前生命值*NUM1】的生命，并获得攻击力提升，提升量=【燃烧生命值数量*NUM2】
            local nowHp = attacker:GetAttr(Constants.AttrTypeId.NowHp)
            self.value = nowHp * data.effectNum1[2] * checkNumber(data.effectNum1[1])
        end,
        [4] = function (  )
            --根据释法者的当前hp，获得属性
            local nowHp = attacker:GetAttr(Constants.AttrTypeId.NowHp)
            self.value = nowHp * data.effectNum1[1]
        end,
        [5] = function (  )
            --根据释法者的最大hp，获得属性
            local hp = attacker:GetAttr(Constants.AttrTypeId.Hp)
            self.value = hp * data.effectNum1[1]
        end,
        [6] = function (  )
            --根据释法者的def，获得属性
            local def = attacker:GetBaseAttr(Constants.AttrTypeId.Defense)
            self.value = def * data.effectNum1[1]
        end,
        [7] = function (  )
            --根据释法者的def，获得属性
            local sp = owner:GetUltraPoint()
            self.value = sp * data.effectNum1[1]
        end,
        [8] = function ()
            --根据施法者的基础属性乘系数，作为属性值，上限为目标的某属性乘系数
            local baseValue = (attacker:GetBaseAttr(data.effectNum1[4]) or 0) * data.effectNum1[1]
            local maxValue = owner:GetBaseAttr(data.effectNum1[3]) * data.effectNum1[2]
            local sign = math.sign(baseValue)
            self.value = math.min( math.abs(baseValue),  math.abs(maxValue) ) * sign
        end,
        [9] = function ()
            --根据目标的基础属性乘系数，作为属性值，上限为施法者的某属性乘系数
            local baseValue = (owner:GetBaseAttr(data.effectNum1[4]) or 0) * data.effectNum1[1]
            local maxValue = attacker:GetBaseAttr(data.effectNum1[3]) * data.effectNum1[2]
            local sign = math.sign(baseValue)
            self.value = math.min( math.abs(baseValue),  math.abs(maxValue) ) * sign
        end,
        [10] = function ()
            --施法者每损失1%生命值，对目标施加Num1的X属性变更
            if not attacker or attacker:IsDead() then
                self.value = 0
                return
            end
            local loseHpPer = 1 - attacker:GetNowHPPercent()
            self.value = loseHpPer * 100 * data.effectNum1[1]
        end,
        [11] = function ()
            if owner:GetNowHPPercent() > data.effectNum1[1] then
                self.value = data.effectNum1[2]
                return
            end
            self.value = 0
        end,
        [12] = function ()
            if owner:GetNowHPPercent() < data.effectNum1[1] then
                self.value = data.effectNum1[2]
                return
            end
            self.value = 0
        end,
        [13] = function ()
            if owner:GetUltraPoint() > data.effectNum1[1] then
                self.value = data.effectNum1[2]
                return
            end
            self.value = 0
        end,
        [14] = function ()
            if owner:GetUltraPoint() < data.effectNum1[1] then
                self.value = data.effectNum1[2]
                return
            end
            self.value = 0
        end,
        [15] = function ()
            --施法者每损失1%生命值，对目标施加Num1的X属性变更，至多增加Num2
            if not attacker or attacker:IsDead() then
                self.value = 0
                return
            end
            local loseHpPer = 1 - attacker:GetNowHPPercent()
            self.value = math.min(loseHpPer * 100 * data.effectNum1[1], data.effectNum1[2])
        end,
        [16] = function()
            -- 携带者身上存在id=NUM1的BUFF时，携带者的X属性变更NUM2
            local targetBuffId = checkNumber(data.effectNum1[1])
            self.value = 0
            owner.buffMgr:WalkAllBuff(function(buff)
                if buff.buffID == targetBuffId then
                    self.value = checkNumber(data.effectNum1[2])
                    return true
                end
            end)
        end,
        [17] = function()
            -- 携带者身上每携带num1个 增减益类型 = num2的BUFF时，自身的X属性变更num3
            local num1 = checkNumber(data.effectNum1[1])
            local num2 = checkNumber(data.effectNum1[2])
            local num3 = checkNumber(data.effectNum1[3])
            if num1 <= 0 then
                self.value = 0
                return
            end
            local count = 0
            owner.buffMgr:WalkAllBuff(function ( v )
                if v.data.buffType == num2 then
                    count = count + 1
                end
            end)
            local times = num_floor(count / num1)
            self.value = times * num3
        end,
        [18] = function()
            -- 携带大类=num1，二类=num2，三类=num3的BUFF时，X属性变更 = num4
            local num1 = checkNumber(data.effectNum1[1])
            local num2 = checkNumber(data.effectNum1[2])
            local num3 = checkNumber(data.effectNum1[3])
            local num4 = checkNumber(data.effectNum1[4])
            local hasBuff = owner.buffMgr:HasBuffByType(num1, num2, num3)
            if hasBuff then
                self.value = num4
            else
                self.value = 0
            end
        end,
        [19] = function()
            -- X属性变更Num1*施法者的武装星级
            local num1 = checkNumber(data.effectNum1[1])
            if owner.isPlayer then
                local star = owner.rawData.star
                self.value = num1 * star
            else
                self.value = 0
            end
        end,
        [20] = function ()
            -- 根据施法者的num4（属性id）*num1（取实时属性）点X属性，提供给目标角色，不超过目标角色num3属性（战前）*num2
            local baseValue = (attacker:GetAttr(data.effectNum1[4]) or 0) * data.effectNum1[1]
            local maxValue = owner:GetBaseAttr(data.effectNum1[3]) * data.effectNum1[2]
            local sign = math.sign(baseValue)
            self.value = math.min( math.abs(baseValue),  math.abs(maxValue) ) * sign
        end,
        [21] = function()
            -- 根据目标身上id为num2的buff层数，改变目标的X属性，每有一层指定buff，属性变更num1
            local num1 = checkNumber(data.effectNum1[1])
            local num2 = checkNumber(data.effectNum1[2])
            local totalLayNum = 0
            owner.buffMgr:WalkAllBuff(function(buff)
                if buff.buffID == num2 then
                    totalLayNum = totalLayNum + math.max( 1, buff.layNum )
                end
            end)
            self.value = num1 * totalLayNum
        end,
        [22] = function()
            -- 携带者每损失1%生命值，获得Num1的X属性变更，至多增加到Num2
            local num1 = checkNumber(data.effectNum1[1])
            local num2 = checkNumber(data.effectNum1[2])
            if not owner or owner:IsDead() then
                self.value = 0
                return
            end
            local loseHpPer = 1 - owner:GetNowHPPercent()
            self.value = math.min(loseHpPer * 100 * num1, num2)
        end,
        [23] = function()
            -- 携带者身上每携带num1个 增减益类型 = num2的BUFF时，自身的X属性变更num3，最多计算num4层
            local num1 = checkNumber(data.effectNum1[1])
            local num2 = checkNumber(data.effectNum1[2])
            local num3 = checkNumber(data.effectNum1[3])
            local num4 = checkNumber(data.effectNum1[4])
            if num1 <= 0 then
                self.value = 0
                return
            end
            local totalLayNum = 0
            owner.buffMgr:WalkAllBuff(function ( v )
                if v.data.buffType == num2 then
                    totalLayNum = totalLayNum + math.max( 1, v.layNum )
                end
            end)
            local times = num_floor(totalLayNum / num1)
            times = math.min(times, num4)
            self.value = times * num3
        end,
        [24] = function ()
            -- 根据施法者的num3（属性id）*num1（取实时属性）点X属性，提供给目标角色，不超过num2
            local baseValue = (attacker:GetAttr(data.effectNum1[3]) or 0) * data.effectNum1[1]
            local maxValue = data.effectNum1[2]
            local sign = math.sign(baseValue)
            self.value = math.min( math.abs(baseValue),  math.abs(maxValue) ) * sign
        end,
        [25] = function()
            -- 根据目标身上id为num2的buff层数，改变目标的X属性，每有num3层指定buff，属性变更num1
            local num1 = checkNumber(data.effectNum1[1])
            local num2 = checkNumber(data.effectNum1[2])
            local num3 = checkNumber(data.effectNum1[3])
            local totalLayNum = 0
            owner.buffMgr:WalkAllBuff(function(buff)
                if buff.buffID == num2 then
                    totalLayNum = totalLayNum + math.max( 1, buff.layNum )
                end
            end)
            local times = num_floor(totalLayNum / num3)
            self.value = num1 * times
        end,
        [26] = function()
            -- 根据目标身上id为num2的buff层数，改变目标的X属性，每有num3层指定buff，属性变更num1，最多计入num4层
            local num1 = checkNumber(data.effectNum1[1])
            local num2 = checkNumber(data.effectNum1[2])
            local num3 = checkNumber(data.effectNum1[3])
            local num4 = checkNumber(data.effectNum1[4])
            local totalLayNum = 0
            owner.buffMgr:WalkAllBuff(function(buff)
                if buff.buffID == num2 then
                    totalLayNum = totalLayNum + math.max( 1, buff.layNum )
                end
            end)
            totalLayNum = math.min(totalLayNum, num4)
            local times = num_floor(totalLayNum / num3)
            self.value = num1 * times
        end,
        [27] = function()
            -- 根据buff拥有者方场上人数，改变目标的X属性，每有1个人。属性变更num1
            local num1 = checkNumber(data.effectNum1[1])
            local camp = owner.camp
            local roles = BattleMgr:GetAliveRoles(camp)
            local roleNum = #roles
            self.value = num1 * roleNum
        end,
        [28] = function()
            -- 施法者buffid=Num2大于Num3层时，目标角色X属性提升Num1
            local num1 = checkNumber(data.effectNum1[1])
            local num2 = checkNumber(data.effectNum1[2])
            local num3 = checkNumber(data.effectNum1[3])
            local totalLayNum = 0
            attacker.buffMgr:WalkAllBuff(function(buff)
                if buff.buffID == num2 then
                    totalLayNum = totalLayNum + math.max( 1, buff.layNum )
                end
            end)
            if totalLayNum > num3 then
                self.value = num1
            else
                self.value = 0
            end
        end,
        [29] = function()
            -- 攻击力提升量=Num*牌库中大于Num2星的技能牌数量，不超过Num3
            local num1 = checkNumber(data.effectNum1[1])
            local num2 = checkNumber(data.effectNum1[2])
            local num3 = checkNumber(data.effectNum1[3])

            local cardMgr = attacker:GetCardMgr()
            local cards = cardMgr:FindCardsByFunc(function (card, pos)
                return card.star > num2
            end)

            local cardNum = #cards
            
            self.value = math.min(num1 * cardNum, num3)
        end,
        [30] = function()
            -- 携带者每损失 1% 生命值，额外获得「NUM1× 已损失生命值百分比」的 X 属性加成，加成效果最高不超过NUM2%
            local num1 = checkNumber(data.effectNum1[1])
            local num2 = checkNumber(data.effectNum1[2])
            if not owner or owner:IsDead() then
                self.value = 0
                return
            end
            local loseHpPer = 1 - owner:GetNowHPPercent()
            loseHpPer = math.range(loseHpPer, 0, 1)
            local perAdd = math.range(num1 * loseHpPer, 0, num2)
            local baseAttrValue = owner:GetBaseAttr(data.subEffectType)
            self.value = perAdd * baseAttrValue
        end,
    }

    local func = switch[data.miniEffectType]
    assert(func, '找不到对应的类型:'..data.miniEffectType)
    func()

    return oldValue ~= self.value
end

return AttributeChange