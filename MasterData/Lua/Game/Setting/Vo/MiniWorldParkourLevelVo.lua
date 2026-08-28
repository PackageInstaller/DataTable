local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

-- 微缩世界主线跑酷关卡表

---@class MiniWorldParkourLevelVo
local MiniWorldParkourLevelVo = Class("MiniWorldParkourLevelVo", SettingRefBase)

function MiniWorldParkourLevelVo:__init()
    self.id = nil               -- 关卡id
    self.activityId = nil            -- 活动id
    self.trapId = nil               -- 陷阱id（显示顺序从左至右）
    self.gainId = nil               -- 增益id（显示顺序从左至右）
    self.picture = nil               -- 关卡图片
    self.prefabId = nil               -- 对应地图资源
    self.name = nil               -- 名称
    self.desc = nil               -- 描述
    self.type = nil               -- 剧情类型（ 2剧情+战斗 1纯剧情  0仅战斗）
    self.unlockLevel = nil               -- 解锁条件值（填充为0，固定为前置关卡解锁）
    self.date = nil               -- 开放时间（按照活动开启当天计算，单位为秒，0为默认解锁）
    self.status = nil               --状态
end

---FillVo
---@param row TableML.TableFileRow
function MiniWorldParkourLevelVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.activityId = parse_number(row, "activityId")
    self.trapId = parse_string(row, "trapId")
    self.gainId = parse_string(row, "gainId")
    self.picture = ParseUtils.ParsePathName(row, "picture")
    self.prefabId = parse_string(row, "prefabId")
    self.name = ParseUtils.ParseLocalizeText(row, "name")   
    self.desc = ParseUtils.ParseLocalizeText(row, "desc")
    self.type = parse_number(row, "type")
    self.unlockLevel = parse_string(row, "unlockLevel")
    self.date = parse_number(row, "date")
    self.status = parse_number(row, "status")
end

function MiniWorldParkourLevelVo:__delete()
    self.id = nil               -- 关卡id
    self.activityId = nil            -- 活动id
    self.trapId = nil               -- 陷阱id（显示顺序从左至右）
    self.gainId = nil               -- 增益id（显示顺序从左至右）
    self.picture = nil               -- 关卡图片
    self.prefabId = nil               -- 对应地图资源
    self.name = nil               -- 名称
    self.desc = nil               -- 描述
    self.type = nil               -- 剧情类型（ 2剧情+战斗 1纯剧情  0仅战斗）
    self.unlockLevel = nil               -- 解锁条件值（填充为0，固定为前置关卡解锁）
    self.date = nil               -- 开放时间（按照活动开启当天计算，单位为秒，0为默认解锁）
    self.status = nil               --状态
end

return MiniWorldParkourLevelVo
