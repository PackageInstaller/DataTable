local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

-- 微缩世界自由探索排行榜奖励表

---@class MiniWorldFreeExploreRankRewaordVo
local MiniWorldFreeExploreRankRewaordVo = Class("MiniWorldFreeExploreRankRewaordVo", SettingRefBase)


function MiniWorldFreeExploreRankRewaordVo:__init()
    self.id = nil
    self.activityId = nil -- 活动id
    self.upperLimit = nil -- 排名上限
    self.lowerLimit = nil -- 排名下限
    self.name = nil -- 档位文本显示
    self.type = nil -- 排名类型（1名次，2百分比）
    self.reward = nil -- 奖励道具
    self.rewardNum = nil --奖励数量
    self.mailID = nil -- 邮件ID
    self.status = nil               --状态
end

---FillVo
---@param row TableML.TableFileRow
function MiniWorldFreeExploreRankRewaordVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.activityId = parse_number(row, "activityId")
    self.upperLimit = parse_number(row, "upperLimit")
    self.lowerLimit = parse_number(row, "lowerLimit")
    self.name = ParseUtils.ParseLocalizeText(row, "name")   
    self.type = parse_number(row, "type")
    self.reward = string.split(parse_string(row,"reward"),';') -- {}
    self.rewardNum = string.split(parse_string(row,"rewardNum"),';') -- {}
    self.mailID = parse_number(row, "mailID")
    self.status = parse_number(row, "status")
end

function MiniWorldFreeExploreRankRewaordVo:__delete()
    self.id = nil
    self.activityId = nil -- 活动id
    self.upperLimit = nil -- 排名上限
    self.lowerLimit = nil -- 排名下限
    self.name = nil -- 档位文本显示
    self.type = nil -- 排名类型（1名次，2百分比）
    self.reward = nil -- 奖励道具
    self.rewardNum = nil --奖励数量
    self.mailID = nil -- 邮件ID
    self.status = nil               --状态
end

return MiniWorldFreeExploreRankRewaordVo
