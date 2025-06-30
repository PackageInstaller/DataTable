module('guild.GuildSweepDifficultyVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id

    --self.mapId = cusData.map_id

    --开启需要资金
    self.needFund = cusData.need_fund
    --奖励预览
    self.showReward = cusData.show_reward
    --怪物等级
    self.monsterLevel = cusData.monster_level

    self.mStepList = {}
    self:parseStepList(cusData.step_reward)
end

function parseStepList(self,dic)
    for id,data  in ipairs(dic) do
        local vo = LuaPoolMgr:poolGet(guild.GuildSweepDifficultyStepVo)
        vo:parseData(id, data)
        table.insert(self.mStepList,vo)
    end
end

return _M