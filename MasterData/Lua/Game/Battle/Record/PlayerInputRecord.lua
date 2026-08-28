--
-- Author:luqucheng
-- Date: 2019-11-08 16:01:58
--
local PlayerInputRecord = Class("PlayerInputRecord")

function  PlayerInputRecord:__init(camp, inputData)
    self.inputData = DeepCopy(inputData)
    self.camp = camp
end

function PlayerInputRecord:ToData(  )
    return {
        r = Constants.RecordType.PlayerInput,--战报类型
        inputData = self.inputData,
        c = self.camp,
    }
end

return  PlayerInputRecord