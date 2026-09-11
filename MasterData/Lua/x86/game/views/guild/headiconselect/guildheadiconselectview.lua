local GuildHeadIconSelect = class("GuildHeadIconSelect", ReduxView)

function GuildHeadIconSelect:UIName()
	return "Widget/System/Club/ClubSelect"
end

function GuildHeadIconSelect:UIParent()
	return manager.ui.uiPop.transform
end

function GuildHeadIconSelect:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.controller = ControllerUtil.GetController(self.transform_, "club")
end

function GuildHeadIconSelect:OnEnter()
	self.selectID_ = self.params_.selectID

	self.controller:SetSelectedState(tostring(self.selectID_))
end

function GuildHeadIconSelect:OnExit()
	return
end

function GuildHeadIconSelect:Dispose()
	GuildHeadIconSelect.super.Dispose(self)
end

function GuildHeadIconSelect:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonCancel_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonOk_, nil, function()
		manager.notify:Invoke(GUILD_SWITCH_HEAD_ICON, self.selectID_)
		self:Back()
	end)

	for iter_7_0 = 1, 5 do
		self:AddBtnListener(self["icon0" .. iter_7_0 .. "Btn_"], nil, function()
			self.controller:SetSelectedState(tostring(iter_7_0))
			self:SelectHeadIcon(iter_7_0)
		end)
	end
end

function GuildHeadIconSelect:SelectHeadIcon(arg_12_1)
	self.selectID_ = arg_12_1
end

return GuildHeadIconSelect
