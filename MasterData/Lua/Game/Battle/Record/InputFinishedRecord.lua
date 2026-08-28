--
-- Author:luqucheng
-- Date: 2019-11-08 09:46:40
--
local InputFinishedRecord = Class("InputFinishedRecord")

--@buff: [Game.Battle.Core.Buff#Buff]
function  InputFinishedRecord:__init(turn)
    self.turn = turn
end

function InputFinishedRecord:ToData()
    return {
        r = Constants.RecordType.InputFinished,--战报类型
        t = self.turn,--轮次数
    }
end

return  InputFinishedRecord