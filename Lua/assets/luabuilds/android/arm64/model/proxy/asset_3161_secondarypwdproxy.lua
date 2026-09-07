local SecondaryPWDProxy = class("SecondaryPWDProxy", import(".NetProxy"))

function SecondaryPWDProxy:register()
	self.data = self.data or {}
	self.data.state = 0
	self.data.fail_count = 0
	self.data.fail_cd = nil
	self.data.notice = nil
	self.data.system_list = {}

	return
end

function SecondaryPWDProxy:SetData(arg_2_1)
	self.data = self.data or {}
	self.data.state = arg_2_1.state
	self.data.fail_count = arg_2_1.fail_count
	self.data.fail_cd = arg_2_1.fail_cd
	self.data.notice = arg_2_1.notice
	self.data.system_list = {}

	for iter_2_0 = 1, #pg.SecondaryPWDMgr.LIMITED_OPERATION do
		table.insert(self.data.system_list, arg_2_1.system_list[iter_2_0])
	end

	return
end

function SecondaryPWDProxy:OnFirstSet(arg_3_1)
	self.data = self.data or {}
	self.data.state = 1
	self.data.system_list = Clone(arg_3_1.settings)
	self.data.fail_count = 0
	self.data.fail_cd = nil
	self.data.notice = Clone(arg_3_1.tip)

	return
end

function SecondaryPWDProxy:OnSettingsChange(arg_4_1)
	self.data = self.data or {}

	local var_4_0 = self.data

	var_4_0.state = #arg_4_1.settings == 0 and 0 or 2
	var_4_0.system_list = Clone(arg_4_1.settings)
	var_4_0.fail_cd = nil
	var_4_0.fail_count = 0

	return
end

function SecondaryPWDProxy:GetPermissionState()
	if self.data.state == 0 then
		return true
	end

	local var_5_0 = self.data.fail_cd
	local var_5_1 = pg.TimeMgr.GetInstance():GetServerTime()

	if self.data.fail_cd and var_5_1 < var_5_0 then
		return false, var_5_0 - var_5_1
	end

	return true
end

return SecondaryPWDProxy
