local enumIdx = 0
local function eID()
	enumIdx = enumIdx+1
	return enumIdx
end

local STravelDef = {}

-- 启动
STravelDef.PERF_START = eID()
-- 更新坐标
STravelDef.PERF_POS = eID()
-- 打中目标
STravelDef.PERF_HIT = eID()
-- 到达目标位置 (不一定打中目标体)
STravelDef.PERF_ARRIVE = eID()
-- 结束
STravelDef.PERF_END = eID()
-- 暂停
STravelDef.PERF_PAUSE = eID()
-- 继续
STravelDef.PERF_RESUME = eID()
-- 更新速度
STravelDef.PERF_SPEED = eID()
-- 朝向
STravelDef.PERF_LOOKAT = eID()

-- 角色的受击高度
STravelDef.ENTITY_HEIGHT = 0


-- Special cmd --其它特殊的处理事件
STravelDef.PERF_LASER_POS = eID()

return STravelDef
 
--[[ 替换语言包自动生成，请勿修改！
]]
