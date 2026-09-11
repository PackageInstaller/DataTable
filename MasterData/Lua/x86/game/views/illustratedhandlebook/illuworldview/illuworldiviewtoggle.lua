local IlluWorldIViewToggle = class("IlluWorldIViewToggle", ReduxView)

function IlluWorldIViewToggle:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function IlluWorldIViewToggle:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluWorldIViewToggle:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
end

function IlluWorldIViewToggle:RefreshUI(arg_4_1, arg_4_2)
	self.index_ = arg_4_1
	self.info_ = arg_4_2
	self.nameText_.text = GetI18NText(arg_4_2.name)

	self:ShowSelect(arg_4_2.select)
end

function IlluWorldIViewToggle:ShowSelect(arg_5_1)
	self.info_.select = arg_5_1

	if arg_5_1 then
		self.controller_:SetSelectedState("sel")
	else
		self.controller_:SetSelectedState("notSel")
	end
end

function IlluWorldIViewToggle:AddUIListener()
	self:AddBtnListener(self.toggleitemBtn_, nil, function()
		if self.func_ then
			self.func_(self.index_)
		end
	end)
end

function IlluWorldIViewToggle:RegisterBtnListener(arg_8_1)
	self.func_ = arg_8_1
end

function IlluWorldIViewToggle:Dispose()
	IlluWorldIViewToggle.super.Dispose(self)
end

return IlluWorldIViewToggle
