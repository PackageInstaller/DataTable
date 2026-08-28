-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫战斗关卡表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-26 20:13:30
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatrolMazeBattleLevelVo : SettingRefBase @ AutoIds.IdSetting358
local PatrolMazeBattleLevelVo = Class('PatrolMazeBattleLevelVo', SettingRefBase)


function PatrolMazeBattleLevelVo:__init()
    ---@type integer @ 夜巡迷宫 关卡事件id
    self.mazeEventId = 0
    
    ---@type integer @ 战斗类型（1普通,2精英,3boss,4关底BOSS）
    self.battleType = 0

    ---@type integer @ 战斗场景id
    self.battleSceneId = 0

    ---@type integer @ 关卡阵容id
    self.commonQuestId = 0

    ---@type integer @ 关卡生成所属层数（0不限制）
    self.areaFloorNum = 0

    ---@type integer @ 回合限制（超出后直接失败）
    self.battleRoundLimit = 0

    ---@type integer @ 夜巡迷宫 关卡奖励id
    self.mazeRewardId = 0
end


function PatrolMazeBattleLevelVo:__delete()
    self.mazeEventId      = nil
    self.battleType       = nil
    self.battleSceneId    = nil
    self.commonQuestId    = nil
    self.battleRoundLimit = nil
    self.areaFloorNum     = nil
    self.mazeRewardId     = nil
end


---@param row TableML.TableFileRow
function PatrolMazeBattleLevelVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.mazeEventId      = parse_number(row, 'id')
    self.battleType       = parse_number(row, 'type')
    self.battleSceneId    = parse_number(row, 'SceneId')
    self.commonQuestId    = parse_number(row, 'monster_id')
    self.areaFloorNum     = parse_number(row, 'levelId')
    self.battleRoundLimit = parse_number(row, 'rounds')
    self.mazeRewardId     = parse_number(row, 'RewardId')
end


return PatrolMazeBattleLevelVo
