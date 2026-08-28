--
-- Author:luqucheng
-- Date: 2019-11-08 09:46:40
--
local RemoveBuffRecord = Class("RemoveBuffRecord")

function  RemoveBuffRecord:__init(buff)
    self.id = buff.id
    self.targetId = buff.owner.id
end

function RemoveBuffRecord:ToData()
    return {
        r = Constants.RecordType.RemoveBuff,--战报类型
        t = self.targetId,--目标id
        id = self.id,--buff唯一id
    }
end

return  RemoveBuffRecord