-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫积分获取规则表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-28 17:29:59
-------------------------------------------------------------------------------

local SettingRefBase  = require('Game.Setting.SettingRefBase')
---@class PatrolMazeScoreVo : SettingRefBase @ AutoIds.IdSetting384
local PatrolMazeScoreVo = Class('PatrolMazeScoreVo', SettingRefBase)


function PatrolMazeScoreVo:__init()
    ---@type integer @ 分数id
    self.scoreId = 0

    ---@type integer @ 层数
    self.floorNum = 0
    
    ---@type integer @ 基础分数
    self.scoreBase = 0

    ---@type table[] @ 积分倍率map（key：PatrolMazeUtils.QuestType，value：number）
    self.increaseMap = {}
end


function PatrolMazeScoreVo:__delete()
    self.scoreId     = nil
    self.floorNum    = nil
    self.scoreBase   = nil
    self.increaseMap = nil
end


---@param row TableML.TableFileRow
function PatrolMazeScoreVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.scoreId   = parse_number(row, 'id')
    self.scoreBase = parse_number(row, 'score')
    self.floorNum  = parse_number(row, 'levelID')

    self.increaseMap = {}
    local increaseNums  = parse_numbers(row, 'increase_num', ',')
    local increaseTypes = parse_numbers(row, 'increase_type', ',')
    for increaseIndex = 1, #increaseTypes do
        local increaseNum  = increaseNums[increaseIndex]
        local increaseType = increaseTypes[increaseIndex]
        self.increaseMap[increaseType] = increaseNum
    end
end


--- 获取分数值
---@param questType PatrolMazeUtils.QuestType
---@return integer
function PatrolMazeScoreVo:GetScoreNum(questType)
    local scoreNum = self.scoreBase
    local increase = checkNumber(self.increaseMap[questType])
    return scoreNum + math.ceil(scoreNum * increase)
end


return PatrolMazeScoreVo
