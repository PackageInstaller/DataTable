

--[[ 
-----------------------------------------------------
@filename       : NoviceActivityRaffleVo
@Description    : 转盘奖励
@Author         : sxt
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("noviceActivity.NoviceActivityRaffleVo",Class.impl())

function parseRaffleData(self, id, cusData)
    self.mId = id
    --任务类型
    self.cost = cusData.cost
   
    self.mStrollDic = {}

    self:parseStrollData(cusData.stroll_reward)
end

function parseStrollData(self,datas)
    for id, data in pairs(datas) do
        self.mStrollDic[data.pos] = data
    end
end

function getStrollDataBypos(self,pos)
    return self.mStrollDic[pos]
end

return _M