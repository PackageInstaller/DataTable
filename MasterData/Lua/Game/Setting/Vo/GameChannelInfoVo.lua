-------------------------------------------------------------------------------
-- 基础表 - 渠道信息表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-21 21:12:42
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class GameChannelInfoVo : SettingRefBase @see AutoIds.IdSetting64
local GameChannelInfoVo = Class('GameChannelInfoVo', SettingRefBase)


function GameChannelInfoVo:__init()
    ---@type integer @ 渠道id
    self.channelId = nil

    ---@type string @ 分享的url
    self.shareUrl = nil
end


function GameChannelInfoVo:__delete()
    self.channelId = nil
    self.shareUrl  = nil
end


---@param row TableML.TableFileRow
function GameChannelInfoVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.channelId = parse_number(row, "id")
    self.shareUrl  = parse_string(row, "url")
end


return GameChannelInfoVo
