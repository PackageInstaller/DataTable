local BattleHelper =BaseClass("BattleHelper", Singleton)
local M = BattleHelper

local files = require("Battle.SkillEffectConfig")
local _allConfigs = {}

for k,fileName in pairs(files) do
    _allConfigs[k] = require("Battle.SkillEffect." .. fileName)
    --print('require skillEffect id is %d and name is %s',k,fileName)
end

function M:ExecuteSkillEffect(effectType,casterRoleIndex, targetRoleIndex, skillId, effectIndex, attackValue, targetPos)
    _allConfigs[effectType]:ExecuteSkillEffect(casterRoleIndex, targetRoleIndex, skillId, effectIndex, attackValue, targetPos)
end

return M
