--
-- Author:luqucheng
-- Date: 2019-11-07 17:36:20
--
local AddBuffRecord = Class("AddBuffRecord")

--@buff: [Game.Battle.Core.Buff#Buff]
function AddBuffRecord:__init(buff)
    self.id = buff.id
    self.buffId = buff.buffID
    self.attackerId = buff.attacker and buff.attacker.id
    self.targetId = buff.owner.id
    self.layNum = buff.layNum
    self.lv = buff.data.lv
    self.star = buff.data.star
    self.remainRound = buff.remainRound
    self.showId = buff.data.showId
    self.sourceType = buff.sourceType
    -- print('record add', table.toString(self:ToData()))
end

function AddBuffRecord:ToData()
    return {
        r = Constants.RecordType.AddBuff,
        a = self.attackerId,
        t = self.targetId,--目标id
        b = self.buffId,--buffid
        l = self.layNum,--层数
        id= self.id,--buff唯一Id
        lv = self.lv,
        s = self.star,
        si = self.showId,
        rr = self.remainRound,
        st = self.sourceType,
    }
end


return  AddBuffRecord