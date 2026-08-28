-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫剧情事件表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-26 20:13:30
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatrolMazeStoryLevelVo : SettingRefBase @ AutoIds.IdSetting356
local PatrolMazeStoryLevelVo = Class('PatrolMazeStoryLevelVo', SettingRefBase)


function PatrolMazeStoryLevelVo:__init()
    ---@type integer @ 夜巡迷宫 剧情事件id
    self.mazeEventId = 0

    ---@type integer @ 区域id
    self.mapAreaId = 0
    
    ---@type integer @ 剧情描述
    self.mazeStoryDescr = 0

    ---@type integer @ 夜巡迷宫 剧情表id
    self.mazePlotId = 0
end


function PatrolMazeStoryLevelVo:__delete()
    self.mazeEventId    = nil
    self.mapAreaId      = nil
    self.mazeStoryDescr = nil
    self.mazePlotId     = nil
end


---@param row TableML.TableFileRow
function PatrolMazeStoryLevelVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.mazeEventId    = parse_number(row, 'incidentId')
    self.mapAreaId      = parse_number(row, 'region')
    self.mazeStoryDescr = parse_localizeText(row, 'desc1', true)
    self.mazePlotId     = parse_number(row, 'desc2')
end


return PatrolMazeStoryLevelVo
