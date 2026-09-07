local Dorm3dInsPhone = class("Dorm3dInsPhone", import("model.vo.BaseVO"))

function Dorm3dInsPhone:Ctor(arg_1_1)
	self.id = arg_1_1
	self.configId = arg_1_1
	self.isLock = true

	return
end

function Dorm3dInsPhone:ExtendsData(arg_2_1)
	self.time = arg_2_1.time
	self.isRead = arg_2_1.read_flag == 1
	self.isLock = false

	return
end

function Dorm3dInsPhone:Unlock(arg_3_1)
	self.time = arg_3_1
	self.isRead = false
	self.isLock = false

	return
end

function Dorm3dInsPhone:MarkRead()
	self.isRead = true

	return
end

function Dorm3dInsPhone:bindConfigTable()
	return pg.dorm3d_ins_telephone_group
end

function Dorm3dInsPhone:ShouldTip()
	return not self.isLock and not self.isRead
end

function Dorm3dInsPhone:IsLock()
	return self.isLock
end

function Dorm3dInsPhone:GetName()
	return self:getConfig("name")
end

function Dorm3dInsPhone:GetDesc()
	return self:getConfig("unlock_desc")
end

function Dorm3dInsPhone:GetContent()
	return self:getConfig("content")
end

function Dorm3dInsPhone:GetVideoData()
	return {
		roomId = self:GetContent()[1],
		groupIds = {
			self:getConfig("ship_group")
		},
		specialId = self:GetContent()[2]
	}
end

function Dorm3dInsPhone:GetType()
	return self:getConfig("type")
end

function Dorm3dInsPhone:GetDay()
	local var_13_0 = math.floor((pg.TimeMgr.GetInstance():GetServerTime() - self.time) / 0)

	return var_13_0 == 0 and i18n("dorm3d_privatechat_visit_time_now") or i18n("dorm3d_privatechat_visit_time", var_13_0)
end

return Dorm3dInsPhone
