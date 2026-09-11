local GuildFoundedToggleView = class("GuildFoundedToggleView", ReduxView)

function GuildFoundedToggleView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.foundedType_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()
end

function GuildFoundedToggleView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self:Go("guildFounded", {
			guildFoundedType = self.foundedType_
		})
	end)
end

function GuildFoundedToggleView:RefreshSelectType(arg_4_1)
	local var_4_0 = self.foundedType_ == arg_4_1

	SetActive(self.selectMission_, self.foundedType_ == arg_4_1)
	SetActive(self.unselectMission_, not var_4_0)
end

function GuildFoundedToggleView:Dispose()
	GuildFoundedToggleView.super.Dispose(self)
end

return GuildFoundedToggleView
