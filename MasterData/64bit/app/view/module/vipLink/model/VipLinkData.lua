local VipLinkData = class("VipLinkData")

function VipLinkData:ctor()
	self._isOpened = (g.core.common.Storage:load("vip_link_record.json", true) or {}).isOpened or false
	self._reward = {}
	self._linkCode = ""
	self._linkType = 0
	self._opIds = ""
	self._rechargeMoney = 0
	self._bindTime = 0
	self._canShow = false
end

function VipLinkData:onRecvGetInfo(arg_2_1)
	if not arg_2_1 or not arg_2_1.contact_info or not arg_2_1.view_info then
		return
	end

	self._linkCode = arg_2_1.contact_info.url
	self._linkType = arg_2_1.contact_info.url_type
	self._reward = arg_2_1.view_info.awards or {}
	self._opIds = arg_2_1.view_info.op_ids or ""
	self._rechargeMoney = arg_2_1.view_info.recharge_money or 0
	self._bindTime = arg_2_1.bind_time or 0
	self._canShow = arg_2_1.can_show or false
end

function VipLinkData:onRecvNotifyBind(arg_3_1)
	self._bindTime = arg_3_1.bind_time or 0

	if not arg_3_1 or not arg_3_1.contact_info then
		return
	end

	self._linkCode = arg_3_1.contact_info.url
	self._linkType = arg_3_1.contact_info.url_type
end

function VipLinkData:isShouldOpen()
	local var_4_0 = false
	local var_4_1 = g.core.platform.PlatformProxy:getOpId()

	for iter_4_0, iter_4_1 in pairs((self._opIds:split(","))) do
		if tostring(var_4_1) == tostring(iter_4_1) then
			var_4_0 = true
		end
	end

	local var_4_2

	if var_4_0 then
		::label_4_0::

		var_4_2 = g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.VIP_LINK)
		var_4_2 = var_4_2 and self._bindTime <= 0 and self._canShow
	end

	return var_4_2
end

function VipLinkData:getLinkCode()
	return self._linkCode
end

function VipLinkData:getLinkType()
	return self._linkType
end

function VipLinkData:isOpen()
	return self._isOpened
end

function VipLinkData:setIsOpen(arg_8_1)
	self._isOpened = arg_8_1

	local var_8_0 = g.core.common.Storage:load("vip_link_record.json", true) or {}

	var_8_0.isOpened = arg_8_1

	g.core.common.Storage:save("vip_link_record.json", var_8_0)
end

function VipLinkData:getReward()
	return self._reward
end

return VipLinkData
