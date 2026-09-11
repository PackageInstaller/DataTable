local StickersListView = class("StickersListView", ReduxView)

function StickersListView:UIName()
	return "Widget/System/UserInfor/paster/StickersListUI"
end

function StickersListView:UIParent()
	return manager.ui.uiMain.transform
end

function StickersListView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function StickersListView:InitUI()
	self:BindCfgUI()

	self.medalList_ = {}
	self.medalScrollHelper_ = LuaList.New(handler(self, self.MedalRenderer), self.listGo_, MedalItem)
end

function StickersListView:AddUIListeners()
	return
end

function StickersListView:OnEnter()
	for iter_6_0, iter_6_1 in ipairs((PlayerData:GetStickerList())) do
		local var_6_0 = PlayerData:GetSticker(iter_6_1)

		if ItemCfg[iter_6_1].sub_type ~= 1302 or var_6_0.unlock ~= 0 then
			table.insert(self.medalList_, var_6_0)
		end
	end

	table.sort(self.medalList_, function(arg_7_0, arg_7_1)
		if arg_7_0.unlock ~= arg_7_1.unlock then
			return arg_7_0.unlock > arg_7_1.unlock
		end

		return arg_7_0.id < arg_7_1.id
	end)
	self.medalScrollHelper_:StartScroll(#self.medalList_)
end

function StickersListView:MedalRenderer(arg_8_1, arg_8_2)
	arg_8_2:RefreshItem(self.medalList_[arg_8_1])
end

function StickersListView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function StickersListView:OnExit()
	self.medalList_ = {}

	manager.windowBar:HideBar()
end

function StickersListView:Dispose()
	self:RemoveAllListeners()
	self.medalScrollHelper_:Dispose()
	StickersListView.super.Dispose(self)
end

return StickersListView
