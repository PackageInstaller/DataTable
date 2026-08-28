--[[
    author:luqucheng
    time:2021-02-23 13:49:07
]]
local ChangeMaxHpRecord = Class("ChangeMaxHpRecord")

function  ChangeMaxHpRecord:__init(roleId, nowHp, nowMaxHp, originMaxHp)
    self.roleId = roleId
    self.nowHp = nowHp
    self.nowMaxHp = nowMaxHp
    self.originMaxHp = originMaxHp
end

function ChangeMaxHpRecord:ToData(  )
    return {
        r = Constants.RecordType.ChangeMaxHp,
        roleId = self.roleId,
        nowHp = self.nowHp,
        nowMaxHp = self.nowMaxHp,
        originMaxHp = self.originMaxHp,
    }
end

return  ChangeMaxHpRecord