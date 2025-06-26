module("notice.NoticeVo", Class.impl())

function ctor(self)
	self:__init()
end

function __init(self)
	-- 协议相关字段
	--聊天频道（0-不显示 1-系统频道）
	self.channel = nil
	--系统消息
	self.msg = nil
	--显示位置(1.聊天框， 2-屏幕顶部， 3.全部显示)
	self.location = nil
	--是否跨服(0本服 1跨服 2全服)
	self.isCross = nil
	--最小等级
	self.minLv = nil
	--最大等级
	self.maxLv = nil
	--聊天相关参数列表
	self.paramList = nil
	--公告所属玩家id，没有发0
	self.targetId = nil
	--公告结束时间戳
	self.endTime = nil
	
	-- 自定义相关字段
	--第一优先级类型
	self.priority_1 = nil
	--第二优先级类型
	self.priority_2 = nil
end

function setData(self, socketData)
	self.channel = socketData.channel
	self.location = socketData.location
	self.isCross = socketData.is_cross
	self.minLv = socketData.min_Lv
	self.maxLv = socketData.max_Lv
	self.paramList = {}
	local len = #socketData.params
    for i = 1, len do
		local paramVo = notice.NoticeParamVo.new()
		paramVo:setMsgData(socketData.params[i])
		table.insert(self.paramList, paramVo)
	end
	self.targetId = socketData.target_id
	self.endTime = socketData.end_time
	
	self.priority_1 = 0
	self.priority_2 = 0
	
	self.msg = notice.LinkHelp:getPraseContent(socketData.msg, self.paramList)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
