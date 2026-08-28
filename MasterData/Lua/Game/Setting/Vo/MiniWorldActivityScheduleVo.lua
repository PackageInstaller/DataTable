local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

-- 微缩世界活动排期表

---@class MiniWorldActivityScheduleVo
local MiniWorldActivityScheduleVo = Class("MiniWorldActivityScheduleVo", SettingRefBase)

function MiniWorldActivityScheduleVo:__init()
    self.id = nil               -- 编号
    self.changeId = nil               -- 换皮资源
    self.entranceImage = nil          -- 入口图片
    self.sceneId = nil               -- 背景图
    self.bgm = nil                  -- 界面背景乐
    self.openSound = nil               -- 开屏音效
    self.storyId = nil               -- 活动起始剧情id
    self.energyId = nil               -- 对应活动体力
    self.cornId = nil               -- 对应活动货币
    self.unlockType = nil               -- 开启条件（对应解锁条件表里的数值）
    self.unlockId = nil               -- 开启条件ID
    self.unlockNum = nil               -- 开启条件数值
    self.ruleID = nil               -- 功能规则id
    self.status = nil               --状态

end

---FillVo
---@param row TableML.TableFileRow
function MiniWorldActivityScheduleVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")    
    self.changeId = parse_number(row, "changeId") 
    self.entranceImage = ParseUtils.ParsePathName(row, "entranceImage")
    self.sceneId = ParseUtils.ParsePathName(row, "sceneId")
    self.bgm = parse_string(row, "bgm") 
    self.openSound = parse_string(row, "openSound") 
    self.storyId = parse_number(row, "storyId") 
    self.energyId = parse_number(row, "energyId") 
    self.cornId = parse_number(row, "cornId") 
    self.unlockType = parse_string(row, "unlockType") 
    self.unlockId = parse_number(row, "unlockId") 
    self.unlockNum = parse_string(row, "unlockNum") 
    self.ruleID = parse_number(row, "ruleID") 
    self.status = parse_number(row, "status")
end

function MiniWorldActivityScheduleVo:__delete()
    self.id = nil               -- 编号
    self.changeId = nil               -- 换皮资源
    self.entranceImage = nil          -- 入口图片
    self.sceneId = nil               -- 背景图
    self.bgm = nil                  -- 界面背景乐
    self.openSound = nil               -- 开屏音效
    self.storyId = nil               -- 活动起始剧情id
    self.energyId = nil               -- 对应活动体力
    self.cornId = nil               -- 对应活动货币
    self.unlockType = nil               -- 开启条件（对应解锁条件表里的数值）
    self.unlockId = nil               -- 开启条件ID
    self.unlockNum = nil               -- 开启条件数值
    self.ruleID = nil               -- 功能规则id
    self.status = nil               --状态
end

return MiniWorldActivityScheduleVo
