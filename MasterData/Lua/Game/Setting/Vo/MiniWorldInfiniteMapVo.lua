local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

-- 微缩世界自由探索地图表

---@class MiniWorldInfiniteMapVo
local MiniWorldInfiniteMapVo = Class("MiniWorldInfiniteMapVo", SettingRefBase)

function MiniWorldInfiniteMapVo:__init()
    self.id = nil               -- 编号
    self.activityId = nil   -- 活动id
    self.prefabId = nil -- 对应地图资源
    self.groupId = nil  -- 组别id
    self.status = nil               --状态

end

---FillVo
---@param row TableML.TableFileRow
function MiniWorldInfiniteMapVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")    
    self.activityId = parse_number(row, "activityId")
    self.prefabId = parse_string(row, "prefabId")
    self.groupId = parse_number(row, "groupId")
    self.status = parse_number(row, "status")
end

function MiniWorldInfiniteMapVo:__delete()
    self.id = nil               -- 编号
    self.activityId = nil   -- 活动id
    self.prefabId = nil -- 对应地图资源
    self.groupId = nil  -- 组别id
    self.status = nil               --状态
end

return MiniWorldInfiniteMapVo
