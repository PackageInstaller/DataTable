--[[ 
-----------------------------------------------------
@filename       : EliminateTaskConfigVo
@Description    : 消消乐任务配置数据
@date           : 2023-12-6 00:00:00
@Author         : Zzz
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("eliminate.EliminateTaskConfigVo", Class.impl())

function ctor(self)
end

function setData(self, taskId, cusData)
	self.taskId = taskId
	self.taskName = cusData.name
	self.taskDes = cusData.des

	self.maxCount = cusData.times
	self.awardList = cusData.reward
end

return _M