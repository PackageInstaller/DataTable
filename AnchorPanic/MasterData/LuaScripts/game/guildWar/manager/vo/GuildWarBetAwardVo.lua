module('guildWar.GuildWarBetAwardVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id
    self.successAward = cusData.bet_success
    self.failAward = cusData.bet_fail
    self.joinAward = cusData.join_fail
end



return _M