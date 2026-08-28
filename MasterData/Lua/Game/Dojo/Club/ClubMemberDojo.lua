-------------------------------------------------------------------------------
-- 社团 - 社团成员数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-26 20:13:07
-------------------------------------------------------------------------------

local BaseDojo = import('Game.Dojo.BaseDojo')

---@class ClubMemberDojo : BaseDojo
---@field New fun():ClubMemberDojo
local ClubMemberDojo = Class('ClubMemberDojo', BaseDojo)


function ClubMemberDojo:__init()
    ---@type integer @ 玩家id
    self.playerId = 0
    
    ---@type string @ 玩家名字
    self.playerName = 0
    
    ---@type integer @ 玩家等级
    self.playerLevel = 0
    
    ---@type integer @ 玩家头像
    self.playerAvatar = 0
    
    ---@type integer @ 玩家头像框
    self.playerAvatarFrame = 0
    
    ---@type integer @ 总战斗力
    self.combat = 0

    ---@type ClubUtils.JobType @ 职位
    self.job = ClubUtils.JobType.MEMBER

    ---@type integer @ 本周贡献值
    self.weekPoint = 0

    ---@type integer @ 历史贡献值
    self.playerPoint = 0

    ---@type boolean @ 是否在线（1在线 0不在）
    self.isOnline = false

    ---@type integer @ 退出时间(秒)
    self.lastExitTime = 0

    ---@type integer @ 餐厅看板形象id
    self.clubSignboarId = 0
end


function ClubMemberDojo:__delete()
    self.playerId          = nil
    self.playerName        = nil
    self.playerLevel       = nil
    self.playerAvatar      = nil
    self.playerAvatarFrame = nil
    self.combat            = nil
    self.job               = nil
    self.weekPoint         = nil
    self.playerPoint       = nil
    self.isOnline          = nil
    self.lastExitTime      = nil
    self.clubSignboarId    = nil
end


function ClubMemberDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)

    -- 是否在线
    self.isOnline = checkInt(jsonData.isOnline) == 1

    self.clubSignboarId = checkInt(jsonData.clubSignboardCardSkinId)
end


function ClubMemberDojo:AddPoint(point)
    local addPoint   = checkInt(point)
    self.weekPoint   = self.weekPoint + addPoint
    self.playerPoint = self.playerPoint + addPoint
end


return ClubMemberDojo
