--
-- Author:luqucheng
-- Date: 2019-12-10 17:45:53
--
local SyncSkillCardRecord = Class("SyncSkillCardRecord")
--@campRoles: [Game.Battle.Entity.Role#Role<>]
--@row1: [Game.Battle.SkillCard.SkillCard#SkillCard<>]
--@row2: [Game.Battle.SkillCard.SkillCard#SkillCard<>]
function  SyncSkillCardRecord:__init(cardMgr )
    self.row1 = self:ToRowData(cardMgr.row1)
    self.row2 = self:ToRowData(cardMgr.row2)
    if cardMgr.catSkillCard then
        self.catCard = cardMgr.catSkillCard:ToData()
    end
    self.points = {}
  
    self.recordType = Constants.RecordType.SyncCard
    self.camp = cardMgr.camp
    self.playerId = cardMgr.playerId
    self.abandon = {}

    local rs = cardMgr:GetRoles()
    for i,role in ipairs(rs) do
        local roleAbandon = {}
        for skillIndex,v in pairs(role.skillCardInfos) do
            if not role:CanSkill() or not role:CanSkillCardBeUsed(skillIndex) then
                table.insert(roleAbandon, skillIndex)
            end
        end
        self.abandon[tostring(role.id)] = roleAbandon
    end
    for i,v in ipairs(rs) do
        table.insert(self.points, {v.id, v.ultraPoint})
    end

    --判断哪些是不能用的卡牌
    -- for i,v in ipairs(row1) do
    --     local role = Core:FindRole(v.roleId)
    --     if not role:CanSkill() or not role:CanSkillCardBeUsed(v.skillIndex) then
    --         table.insert(self.abandon, {i, 1})
    --     end
    -- end
    -- for i,v in ipairs(row2) do
    --     local role = Core:FindRole(v.roleId)
    --     if not role:CanSkill() or not role:CanSkillCardBeUsed(v.skillIndex) then
    --         table.insert(self.abandon, {i, 2})
    --     end
    -- end
end

function SyncSkillCardRecord:ToData(  )
    return {
        r = Constants.RecordType.SyncCard,
        r1 = table.link({}, self.row1) ,--{角色id,技能id,技能星级}的数据,代表第一行加入的技能牌数据
        r2 = table.link({}, self.row2),--{角色id,技能id,技能星级}的数据,代表第二行加入的技能牌数据
        cc = self.catCard,
        p = table.link({}, self.points),--数组{roleId, 大招点数}
        c = self.camp,
        a = self.abandon,
        pId = self.playerId,
    }
end

function SyncSkillCardRecord:ToRowData( row )
    local data = {}
    for i,v in ipairs(row) do
        table.insert(data, v:ToData())
    end
    return data
end

return  SyncSkillCardRecord