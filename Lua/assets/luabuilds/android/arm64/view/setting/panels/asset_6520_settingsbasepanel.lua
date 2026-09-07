local SettingsBasePanel = class("SettingsBasePanel")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function SettingsBasePanel:Ctor(arg_1_1)
	self.parentTF = arg_1_1

	pg.DelegateInfo.New(self)

	self.state = var_0_1

	return
end

function SettingsBasePanel:Init(arg_2_1)
	if self.state == var_0_1 then
		self:Load(arg_2_1)
	else
		arg_2_1()
	end

	return
end

function SettingsBasePanel:IsLoaded()
	return self.state == var_0_3
end

function SettingsBasePanel:Load(arg_4_1)
	self.state = var_0_2

	PoolMgr.GetInstance():GetUI(self:GetUIName(), true, function(arg_5_0)
		if self.exited then
			PoolMgr.GetInstance():ReturnUI(self:GetUIName(), arg_5_0)

			return
		end

		self.state = var_0_3
		self._go = arg_5_0
		self._tf = arg_5_0.transform

		setParent(self._tf, self.parentTF)
		self:InitTitle()
		self:OnInit()
		self:OnUpdate()
		setActive(self._tf, true)
		arg_4_1()

		return
	end)

	return
end

function SettingsBasePanel:InitTitle()
	setText(self._tf:Find("title"), self:GetTitle())
	setText(self._tf:Find("title/title_text"), self:GetTitleEn())

	return
end

function SettingsBasePanel:Dispose()
	self.exited = true

	pg.DelegateInfo.Dispose(self)

	if self.state >= var_0_3 then
		PoolMgr.GetInstance():ReturnUI(self:GetUIName(), self._go)
	end

	return
end

function SettingsBasePanel:GetUIName()
	assert(false, "overwrite me !!!")

	return
end

function SettingsBasePanel:GetTitle()
	assert(false, "overwrite me !!!")

	return
end

function SettingsBasePanel:GetTitleEn()
	assert(false, "overwrite me !!!")

	return
end

function SettingsBasePanel:OnInit()
	return
end

function SettingsBasePanel:OnUpdate()
	return
end

return SettingsBasePanel
