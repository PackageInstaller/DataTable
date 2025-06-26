module("notice.NoticeManager", Class.impl(Manager))

--构造函数
function ctor(self)
	super.ctor(self)
	self:__init()
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)
     self:__init()
end

function __init(self)
	self.noticeList = {}
end

--  解析公告
function parseNoticeMsg(self, msg)
	local vo = notice.NoticeVo.new()
	vo:setData(msg)
	if(vo.location == 2 or vo.location == 3) then
		table.insert(self.noticeList, vo)
	end
	if(vo.channel == 1 and (vo.location == 1 or vo.location == 3)) then
		chat.ChatManager:addChatByNotice(vo.channel, vo.msg)
	end
	self:__sortNoticeList()
end

-- 从大到小
function __sortNoticeList(self)
	table.sort(self.noticeList, function(vo1, vo2)
		if(vo1.priority_1 > vo2.priority_1) then return true end
		if(vo1.priority_1 < vo2.priority_1) then return false end
		if(vo1.priority_2 > vo2.priority_2) then return true end
		if(vo1.priority_2 < vo2.priority_2) then return false end
		-- if(vo1.priority_1 ~= vo2.priority_1) then return vo1.priority_1 > vo2.priority_1 end
		-- if(vo1.priority_2 ~= vo2.priority_2) then return vo1.priority_2 > vo2.priority_2 end
		return false
	end)
end

function getFirstNotice(self)
	if(#self.noticeList > 0) then
		local vo = self.noticeList[1]
		table.remove(self.noticeList, 1)
		return vo
	end
	return null
end

--析构函数
function dtor(self)
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
