
---@class DOTInfo
local DOTInfo = {}
---@type Game.Battle.Record.DamageRecord DOT造成伤害的战报
DOTInfo.damageRec = nil
---@type Game.Battle.Data.BuffData 触发DOT的buff
DOTInfo.buff = nil
---@type Game.Battle.Data.BuffEffectData 触发DOT的buff效果
DOTInfo.buffEffect = nil
---@type Game.Battle.Entity.Role DOT的施加者
DOTInfo.attacker = nil
---@type Game.Battle.Entity.Role DOT的目标
DOTInfo.target = nil

---@type number DOT的大类
DOTInfo.mainType = nil

---@type number DOT的二类
DOTInfo.subType = nil

---@type number DOT的三类
DOTInfo.miniType = nil

return DOTInfo