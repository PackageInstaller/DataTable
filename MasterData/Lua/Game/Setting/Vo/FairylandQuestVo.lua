---
--- 乱流幻境副本表
--- Author: dawanfan
--- Date: 2024-1-15 11:46:06
---

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class FairylandQuestVo
local FairylandQuestVo = Class("FairylandQuestVo", SettingRefBase)

---__int
function FairylandQuestVo:__init()
    self.id = nil --副本ID
    self.name = nil --副本名
    self.story = nil -- 副本描述
    self.completeMax = nil -- 副本最大上限次数
    self.consume = nil -- 进入时消耗道具
    self.number = nil --消耗道具数
    self.unlock = nil -- 解锁条件
    self.showProgressRewards = nil -- 探索进度奖励展示
    self.showChallengeNumber = nil -- 探索进度奖励数量
    self.showChallengeRewards = nil -- 挑战进度奖励展示
    self.showChallengeNumber = nil -- 挑战进度奖励数量
    self.challengeRewards = nil -- 挑战奖励
    self.challengeNumber = nil -- 挑战奖励数量
end

---FillVo
---@param row TableML.TableFileRow
function FairylandQuestVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.name = ParseUtils.ParseLocalizeText(row, "name")
    self.story = ParseUtils.ParseLocalizeText(row, "story")
    self.completeMax = parse_number(row, "completeMax")
    self.consume = parse_number(row, "consume")
    self.number = parse_number(row, "number")
    self.unlock = parse_number(row, "unlock")
    self.showProgressRewards = parse_numbers(row, "showProgressRewards")
    self.showChallengeNumber = parse_numbers(row, "showChallengeNumber")
    self.showChallengeRewards = parse_numbers(row, "showChallengeRewards")
    self.showChallengeNumber = parse_numbers(row, "showChallengeNumber")
    self.challengeRewards = parse_numbers(row, "challengeRewards")
    self.challengeNumber = parse_numbers(row, "ChallengeNumber")
end

function FairylandQuestVo:__delete()
    self.id = nil
    self.name = nil
    self.story = nil
    self.completeMax = nil
    self.consume = nil
    self.number = nil
    self.unlock = nil
    self.showProgressRewards = nil
    self.showChallengeNumber = nil
    self.showChallengeRewards = nil
    self.showChallengeNumber = nil
    self.challengeRewards = nil
    self.challengeNumber = nil
end

return FairylandQuestVo
