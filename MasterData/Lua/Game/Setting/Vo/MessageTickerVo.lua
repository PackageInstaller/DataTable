---
--- 跑马灯表
--- Author: dawanfan
--- Date: 2024-3-11 16:51:53
---

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class MessageTickerVo
local MessageTickerVo = Class("MessageTickerVo", SettingRefBase)

---__int
function MessageTickerVo:__init()
    self.id = nil              -- 消息Id
    self.msg = nil             -- 消息内容
    self.round = nil           -- 播放轮数
    self.roundGap = nil        -- 每轮间隔
    self.priority = nil        -- 优先级
    self.messageShowType = nil -- 显示类型
end

---FillVo
---@param row TableML.TableFileRow
function MessageTickerVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.msg = ParseUtils.ParseLocalizeText(row, "name")
    self.round = parse_number(row, "round")
    self.roundGap = parse_number(row, "roundGap")
    self.priority = parse_number(row, "priority")
    self.messageShowType = parse_number(row, "messageShowType")
end

function MessageTickerVo:__delete()
    self.id = nil              -- 消息Id
    self.msg = nil             -- 消息内容
    self.round = nil           -- 播放轮数
    self.roundGap = nil        -- 每轮间隔
    self.priority = nil        -- 优先级
    self.messageShowType = nil -- 显示类型

end

return MessageTickerVo
