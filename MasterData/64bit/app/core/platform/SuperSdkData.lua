local SuperSdkData = class("SuperSdkData")

require("cocos.cocos2d.base64")

function SuperSdkData:ctor()
	self._osdk_ticket_str = nil
	self._osdk_ticket = nil
	self._userinfo = nil
	self._isInit = false
	self._otherData = {}
end

function SuperSdkData:init(arg_2_1)
	if not arg_2_1 or tostring(arg_2_1.status) ~= "1" then
		return
	end

	self._osdk_ticket_str = arg_2_1.osdk_ticket
	self._osdk_ticket = from_base64(self._osdk_ticket_str)
	self._osdk_ticket = json.decode(self._osdk_ticket)
	self._userinfo = arg_2_1.userinfo

	if arg_2_1.data then
		self._otherData = arg_2_1.data
	end

	self._isInit = true
end

function SuperSdkData:initWithTicket(arg_3_1)
	self._osdk_ticket_str = arg_3_1
	self._osdk_ticket = from_base64(arg_3_1)
	self._osdk_ticket = json.decode(self._osdk_ticket)
	self._isInit = true
end

function SuperSdkData:getUserId()
	if not self._isInit then
		return nil
	end

	return self._userinfo.user_id
end

function SuperSdkData:getTicket()
	if not self._isInit then
		return ""
	end

	return self._osdk_ticket_str
end

function SuperSdkData:getDecodeTicket()
	if not self._isInit then
		return ""
	end

	return self._osdk_ticket
end

function SuperSdkData:getOtherData()
	return self._otherData
end

return SuperSdkData
