module('guild.GuildSweepDifficultyStepVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id

    self.remainingHp = cusData.remaining_hp
    self.award = cusData.reward
end

return _M