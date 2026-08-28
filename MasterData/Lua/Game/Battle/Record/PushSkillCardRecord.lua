--
-- Author:luqucheng
-- Date: 2019-11-27 18:12:49
--
local PushSkillCardRecord = Class("PushSkillCardRecord")

function  PushSkillCardRecord:__init(pushRow1, pushRow2, cardMgr)
    self.pushRow1 = self:ToRowData(pushRow1)
    self.pushRow2 = self:ToRowData(pushRow2)
    self.recordType = Constants.RecordType.PushCard
    self.camp = cardMgr.camp
    self.playerId = cardMgr.playerId
end

function PushSkillCardRecord:ToData(  )
    return {
        r = Constants.RecordType.PushCard,
        r1 = self.pushRow1,--{角色id,技能id,技能星级}的数据,代表第一行加入的技能牌数据
        r2 = self.pushRow2,--{角色id,技能id,技能星级}的数据,代表第二行加入的技能牌数据
        c = self.camp,
        pId = self.playerId,
    }
end

function PushSkillCardRecord:ToRowData( row )
    local data = {}
    for i,v in ipairs(row) do
        table.insert(data, v:ToData())
    end
    return data
end

return  PushSkillCardRecord