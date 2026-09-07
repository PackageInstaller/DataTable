local MainBasePanel = class("MainBasePanel", import(".MainBaseView"))

function MainBasePanel:Ctor(arg_1_1, arg_1_2, arg_1_3)
	MainBasePanel.super.Ctor(self, arg_1_1, arg_1_2)

	self.contextData = arg_1_3
	self.btns = self:GetBtns()

	self:Register()

	return
end

function MainBasePanel:Init()
	for iter_2_0, iter_2_1 in ipairs(self.btns) do
		onButton(self, iter_2_1:GetTarget(), function()
			iter_2_1:OnClick()

			return
		end, SFX_PANEL)
		iter_2_1:Flush(true)
	end

	return
end

function MainBasePanel:Register()
	self:bind(PlayerProxy.UPDATED, function(arg_5_0)
		self:Refresh()

		return
	end)

	return
end

function MainBasePanel:Refresh()
	for iter_6_0, iter_6_1 in ipairs(self.btns) do
		iter_6_1:Flush(false)
	end

	return
end

function MainBasePanel:Dispose()
	MainBasePanel.super.Dispose(self)

	for iter_7_0, iter_7_1 in ipairs(self.btns) do
		iter_7_1:Dispose()
	end

	self.btns = {}

	self:OnDispose()

	return
end

function MainBasePanel:GetBtns()
	return {}
end

function MainBasePanel:OnDispose()
	return
end

return MainBasePanel
