
local BattleMgr = {}


--- 延迟添加buff
---@param info DelayBuffEffectInfo
function BattleMgr:DelayHandleBuff(info)
    local subType = info.subType
    local miniType = info.miniType

    local switch = {
        [6] = function ()
            local target = info.addBuffTarget
            local attacker = info.addBuffAttacker
            local dotDamageNum = info.dotDamageNum
            local shieldId = info.addBuffId
            local ratio = info.ratio
            local attrId = info.attrId
            local attrPercent = info.attrPercent

            if not attacker:IsDead() and not target:IsDead() then
                local attrValue = target:GetAttr(attrId)
                local valueMax = attrValue * attrPercent
                local shieldValue = math.min(valueMax, dotDamageNum * ratio)
                target.buffMgr:AddBuff(attacker, Core:GetBuffData(shieldId, 1, 1), 1, {shieldValue = shieldValue})
                target.buffMgr:AfterChangeBuff()
            end
        end,
    }

    local func = switch[subType]
    assert(func, '找不到延迟添加buff的方式:'..subType)
    func()
end

return BattleMgr