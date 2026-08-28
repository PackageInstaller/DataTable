local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

-- 限时招募活动排期表

---@class TimeLimitedRecruitActivityScheduleVO
local TimeLimitedRecruitActivityScheduleVO = Class("TimeLimitedRecruitActivityScheduleVO", SettingRefBase)

function TimeLimitedRecruitActivityScheduleVO:__init()
    self.id = nil               -- 编号
    self.changeId = nil               -- 换皮id
    self.name = nil               -- 活动名-备注
    self.sceneId = nil               -- 入口图
    self.recruitPropId = nil               -- 招募消耗道具
    self.recruitPropNum = nil               -- 招募消耗道具数量
    self.mallBgImage = nil               -- 商店背景图
    self.cardId = nil               -- 卡牌id
    self.ruleID = nil               -- 活动规则
    self.desc = nil               -- 概率规则
    self.status = nil               --状态
end

---FillVo
---@param row TableML.TableFileRow
function TimeLimitedRecruitActivityScheduleVO:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")   
    self.changeId = parse_number(row, "changeId")  
    self.name = ParseUtils.ParseLocalizeText(row, "name")
    self.sceneId = ParseUtils.ParsePathName(row, "sceneId")
    self.recruitPropId = parse_number(row, "recruitPropId") 
    self.recruitPropNum = parse_number(row, "recruitPropNum") 
    self.mallBgImage = ParseUtils.ParsePathName(row, "mallBgImage")
    self.cardId = parse_number(row, "cardId")  
    self.ruleID = parse_number(row, "ruleID")  
    self.desc = ParseUtils.ParseLocalizeText(row, "desc")
    self.status = parse_number(row, "status")
end

function TimeLimitedRecruitActivityScheduleVO:__delete()
    self.id = nil               -- 编号
    self.changeId = nil               -- 换皮id
    self.name = nil               -- 活动名-备注
    self.sceneId = nil               -- 入口图
    self.recruitPropId = nil               -- 招募消耗道具
    self.recruitPropNum = nil               -- 招募消耗道具数量
    self.mallBgImage = nil               -- 商店背景图
    self.cardId = nil               -- 卡牌id
    self.ruleID = nil               -- 活动规则
    self.desc = nil               -- 概率规则
    self.status = nil               --状态
end

return TimeLimitedRecruitActivityScheduleVO
