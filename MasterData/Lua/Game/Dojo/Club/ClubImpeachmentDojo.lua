-------------------------------------------------------------------------------
-- 社团 - 社团弹劾数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-14 19:47:57
-------------------------------------------------------------------------------

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class ClubImpeachmentDojo : BaseDojo
---@field New fun():ClubImpeachmentDojo
local ClubImpeachmentDojo = Class('ClubImpeachmentDojo', BaseDojo)


function ClubImpeachmentDojo:__init()
    ---@type ClubUtils.ImpeachmentState @ 弹劾状态（0：未弹劾，1：已弹劾，2：拒绝弹劾）
    self.impeachmentState = 0

    ---@type integer @ 已经弹劾的人数
    self.joinPassTimes = 0

    ---@type integer @ 需要参与的人数
    self.joinTotalTimes = 0

    ---@type boolean @ 是否是新一轮弹劾
    self.isNewImpeachment = false

    ---@type integer @ 新管理员id
    self.newClubManagerId = 0
end


function ClubImpeachmentDojo:__delete()
    self.impeachmentState = nil
    self.joinPassTimes    = nil
    self.joinTotalTimes   = nil
    self.isNewImpeachment = nil
    self.newClubManagerId = nil
end


---@param jsonData table
---@return ClubImpeachmentDojo
function ClubImpeachmentDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)

    self.impeachmentState = checkInt(jsonData.isUnionImpeachment)
    self.joinPassTimes    = checkInt(jsonData.impeachmentTimes)
    self.joinTotalTimes   = checkInt(jsonData.impeachmentTotalTimes)
    self.isNewImpeachment = checkInt(jsonData.isNewImpeachment) == 1
    self.newClubManagerId = checkInt(jsonData.unionPresidentPlayerId)

    return self
end


--- 是否 弹劾成功
---@return boolean
function ClubImpeachmentDojo:IsImpeachSuccess()
    return self.isNewImpeachment == false and self.newClubManagerId > 0
end


return ClubImpeachmentDojo
