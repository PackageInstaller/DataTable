--[[ 
-----------------------------------------------------
@filename       : EliminateAreaConfigVo
@Description    : 消消乐章节区域配置数据
@date           : 2023-12-6 00:00:00
@Author         : Zzz
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("eliminate.EliminateAreaConfigVo", Class.impl())

function ctor(self)
end

function setData(self, areaId, cusData)
	self.areaId = areaId
	self.areaName = cusData.name
	self.stageIdList = cusData.stage_list
	table.sort(self.stageIdList, function(id1, id2) return id1 < id2 end)

	self.beginTimeData = {}
    if not table.empty(cusData.begin_time) then
		self.beginTimeData.year = cusData.begin_time[1][1]
		self.beginTimeData.month = cusData.begin_time[1][2]
		self.beginTimeData.day = cusData.begin_time[1][3]
		self.beginTimeData.hour = cusData.begin_time[2][1]
		self.beginTimeData.min = cusData.begin_time[2][2]
		self.beginTimeData.sec = cusData.begin_time[2][3]
    end
end

function isOpen(self)
    local isOpen = false
    if table.empty(self.beginTimeData) then
		isOpen = true
	else
        isOpen = GameManager:getClientTime() > os.time(self.beginTimeData)
    end
    return isOpen
end


return _M