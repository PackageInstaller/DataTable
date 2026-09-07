local GuildEventBasePage = class("GuildEventBasePage", import("....base.BaseSubView"))

function GuildEventBasePage:Show(arg_1_1, arg_1_2, arg_1_3)
	self:UpdateData(arg_1_1, arg_1_2, arg_1_3)
	GuildEventBasePage.super.Show(self)
	assert(self._tf)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:OnShow()

	self.inAnim = true

	self:EnterAnim(function()
		self.inAnim = false

		return
	end)

	return
end

function GuildEventBasePage:SetHideCallBack(arg_3_1)
	self.exitCallback = arg_3_1

	return
end

function GuildEventBasePage:UpdateData(arg_4_1, arg_4_2, arg_4_3)
	self.guild = arg_4_1
	self.player = arg_4_2
	self.extraData = arg_4_3

	return
end

function GuildEventBasePage:Hide(arg_5_1)
	local function var_5_0()
		self.inAnim = false

		GuildEventBasePage.super.Hide(self)
		assert(self._tf)
		assert(self._parentTf)
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

		if not arg_5_1 and self.exitCallback then
			self.exitCallback()
		end

		return
	end

	if not arg_5_1 then
		self.inAnim = true

		self:ExistAnim(var_5_0)
	else
		var_5_0()
	end

	return
end

function GuildEventBasePage:OnDestroy()
	self:Hide(true)

	return
end

function GuildEventBasePage:emit(...)
	if self.inAnim then
		return
	end

	GuildEventBasePage.super.emit(self, ...)

	return
end

function GuildEventBasePage:EnterAnim(arg_9_1)
	arg_9_1()

	return
end

function GuildEventBasePage:ExistAnim(arg_10_1)
	arg_10_1()

	return
end

function GuildEventBasePage:OnShow()
	return
end

return GuildEventBasePage
