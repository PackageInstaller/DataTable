-------------------------------------------------------------------------------
-- 天梯竞技 - 活动表结构
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-08-08 16:16:28
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class LadderActivityVo : SettingRefBase
local LadderActivityVo = Class('LadderActivityVo', SettingRefBase)


function LadderActivityVo:__init()
    self.id         = nil  -- id
    self.name       = nil  -- 副本名
    self.sceneId    = nil  -- 背景
    self.entreImg   = nil  -- 入口图
    self.descr      = nil  -- 描述
    self.unlockId   = nil  -- 解锁id
    self.unlockNum  = nil  -- 解锁数量
    self.unlockType = nil  -- 解锁类型
end


function LadderActivityVo:__delete()
end


---@param row TableML.TableFileRow
function LadderActivityVo:FillVo(row)
    SettingRefBase.FillVo(self, row)
    
    self.id         = parse_number(row, 'id')
    self.name       = nil
    self.sceneId    = parse_number(row, 'sceneId')
    self.entreImg   = nil
    self.descr      = nil
    self.unlockId   = parse_number(row, 'unlockId')
    self.unlockNum  = parse_number(row, 'unlockNum')
    self.unlockType = parse_number(row, 'unlockType')
end


return LadderActivityVo
