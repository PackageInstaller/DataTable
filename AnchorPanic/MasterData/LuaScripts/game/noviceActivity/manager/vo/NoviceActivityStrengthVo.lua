
module("noviceActivity.NoviceActivityStrengthVo", Class.impl())

function parseData(self, id, data)
    self.id = id
    self.reward = data.reward
end

return _M