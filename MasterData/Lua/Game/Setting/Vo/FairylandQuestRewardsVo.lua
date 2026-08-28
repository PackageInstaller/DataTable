---
--- 乱流幻境副本奖励表
--- Author: dawanfan
--- Date: 2024-1-15 19:19:34
---

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class FairylandQuestRewardsVo
local FairylandQuestRewardsVo = Class("FairylandQuestRewardsVo", SettingRefBase)

---__int
function FairylandQuestRewardsVo:__init()
    self.id = nil --副本ID
    self.copyId = nil -- 副本Id
    self.progress = nil -- 进度
    self.progressReward = nil -- 进度奖励
    self.rewardNumber = nil -- 奖励数量
end

---FillVo
---@param row TableML.TableFileRow
function FairylandQuestRewardsVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.copyId = parse_number(row, "copyId")
    self.progress = parse_number(row, "progress")
    self.progressReward = parse_numbers(row, "progressReward")
    self.rewardNumber = parse_numbers(row, "rewardNumber")
end

function FairylandQuestRewardsVo:__delete()
    self.id = nil
    self.copyId = nil
    self.progress = nil
    self.progressReward = nil
    self.rewardNumber = nil
end

return FairylandQuestRewardsVo
