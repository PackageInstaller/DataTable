
module("WelfareOptFestivalVo",Class.impl())

function parseData(self,id,cusData)
    self.id = id 

    self.mReward = cusData.reward

    self.language = cusData.language
end

return _M