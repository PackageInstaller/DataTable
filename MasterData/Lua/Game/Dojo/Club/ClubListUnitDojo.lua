-------------------------------------------------------------------------------
-- 社团 - 社团列表单元数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-26 20:13:07
-------------------------------------------------------------------------------

local BaseDojo = import('Game.Dojo.BaseDojo')

---@class ClubListUnitDojo : BaseDojo
---@field New fun():ClubListUnitDojo
local ClubListUnitDojo = Class('ClubListUnitDojo', BaseDojo)


function ClubListUnitDojo:__init()
    ---@type integer @ 社团id
    self.clubId = 0

    ---@type string @ 社团名字
    self.name = 0

    ---@type integer @ 社团等级
    self.level = 0

    ---@type integer @ 社团头像
    self.avatar = 0

    ---@type integer @ 社团人数
    self.members = 0

    ---@type integer @ 社团总战力
    self.powers = 0

    ---@type string @ 会长名称
    self.chairmanName = 0

    ---@type boolean @ 是否已经申请
    self.isApplied = false

    ---@type ClubUtils.ApplyType @ 申请类型
    self.applyType = ClubUtils.ApplyType.FREE

    ---@type integer @ 申请等级
    self.applyLevel = 0

    ---@type string @ 公告
    self.notice = ''

    ---@type integer @ 贡献点
    self.contributionPoint = 0
end


function ClubListUnitDojo:__delete()
    self.clubId            = nil
    self.name              = nil
    self.level             = nil
    self.avatar            = nil
    self.members           = nil
    self.powers            = nil
    self.chairmanName      = nil
    self.isApplied         = nil
    self.applyType         = nil
    self.applyLevel        = nil
    self.notice            = nil
    self.contributionPoint = nil
end


function ClubListUnitDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)

    self.members = checkInt(jsonData.memberNumber)

    self.powers = checkInt(jsonData.clubCombat)

    self.isApplied = checkInt(jsonData.hasApplied) == 1  -- 是否已经申请，0否，1是

    -- 审批条件
    local applyData = checkTable(jsonData.applyPermission)
    self.applyType  = checkInt(applyData.type)
    self.applyLevel = checkInt(applyData.levelLimit)

    self.contributionPoint = checkInt(jsonData.contributionPoint)
end


return ClubListUnitDojo
