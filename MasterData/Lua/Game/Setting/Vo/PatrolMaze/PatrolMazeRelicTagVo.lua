-------------------------------------------------------------------------------
-- 夜巡迷宫 - 圣物标签表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-04-30 15:37:33
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatrolMazeRelicTagVo : SettingRefBase @ AutoIds.IdSetting385
local PatrolMazeRelicTagVo = Class('PatrolMazeRelicTagVo', SettingRefBase)


function PatrolMazeRelicTagVo:__init()
    ---@type integer @ 标签id
    self.tagId = 0

    ---@type string @ 标签文本
    self.tagTxt = ''
end


function PatrolMazeRelicTagVo:__delete()
    self.tagId  = nil
    self.tagTxt = nil
end


---@param row TableML.TableFileRow
function PatrolMazeRelicTagVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.tagId  = parse_number(row, 'Id')
    self.tagTxt = parse_localizeText(row, 'lable')
end


return PatrolMazeRelicTagVo
