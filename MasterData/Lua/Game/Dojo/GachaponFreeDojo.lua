-------------------------------------------------------------------------------
-- 抽卡免费数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-04 16:54:13
-------------------------------------------------------------------------------

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class GachaponFreeDojo : BaseDojo
---@field New fun():GachaponFreeDojo
local GachaponFreeDojo = Class('GachaponFreeDojo', BaseDojo)


function GachaponFreeDojo:__init()
    ---@type integer @ 免费组别id
    self.freeGroupId = 0

    ---@type integer @ 免费单抽 恢复次数
    self.oneResetTimes = 0

    ---@type integer @ 免费单抽 当前次数
    self.oneLeftTimes = 0

    ---@type integer @ 免费单抽 恢复秒数
    self.oneResetSeconds = 0

    ---@type integer @ 免费单抽 CD秒数
    self.oneLeftSeconds = 0

    ---@type integer @ 免费单抽 恢复时间戳
    self.oneTimestamp = 0
end


function GachaponFreeDojo:__delete()
    self.freeGroupId     = nil
    self.oneResetTimes   = nil
    self.oneLeftTimes    = nil
    self.oneResetSeconds = nil
    self.oneLeftSeconds  = nil
    self.oneTimestamp    = nil
end


---@param jsonData table
---@return GachaponFreeDojo
function GachaponFreeDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)

    self.freeGroupId     = checkInt(jsonData.freeGroupId)
    self.oneResetTimes   = checkInt(jsonData.oneResetTimes)
    self.oneLeftTimes    = checkInt(jsonData.oneLeftTimes)
    self.oneResetSeconds = checkInt(jsonData.oneResetSeconds)

    self:SetOneLeftSeconds(jsonData.oneLeftSeconds)
    return self
end


--- 设置恢复时间
---@param oneLeftSeconds integer
function GachaponFreeDojo:SetOneLeftSeconds(oneLeftSeconds)
    self.oneLeftSeconds = checkInt(oneLeftSeconds)
    if self.oneLeftSeconds > 0 then
        self.oneTimestamp = GameUtils.GetServerTime() + self.oneLeftSeconds
    end
end


-- 刷新恢复时间
function GachaponFreeDojo:UpdateOneLeftSeconds()
    if self.oneTimestamp == 0 then
        return
    end
    self.oneLeftSeconds = math.max(self.oneTimestamp - GameUtils.GetServerTime(), 0)

    -- 恢复次数
    if self.oneLeftSeconds == 0 then
        self.oneLeftTimes = self.oneResetTimes
        self.oneTimestamp = 0
    end
end


return GachaponFreeDojo
