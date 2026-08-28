--
-- Author:luqucheng
-- Date: 2019-11-08 09:46:40
--
local ChangeBuffRecord = Class("ChangeBuffRecord")

--@buff: [Game.Battle.Core.Buff#Buff]
function  ChangeBuffRecord:__init(buff)
    self.id = buff.id
    self.targetId = buff.owner.id
    self.lay = buff.layNum
    self.remainRound = buff.remainRound
end

function ChangeBuffRecord:ToData()
    return {
        r = Constants.RecordType.ChangeBuff,--战报类型
        t = self.targetId,--目标id
        id = self.id,--buff唯一id
        l = self.lay,
        rr = self.remainRound
    }
end

return  ChangeBuffRecord