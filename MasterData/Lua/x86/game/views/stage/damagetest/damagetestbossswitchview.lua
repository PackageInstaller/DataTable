local BossSwitchView = class("BossSwitchView", ReduxView)

function BossSwitchView:UIName()
	return "UI/DamageTest/BossSwitchUI"
end

function BossSwitchView:UIParent()
	return manager.ui.uiMain.transform
end

function BossSwitchView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.listGo_, BossSwitchItem)
end

function BossSwitchView:AddListeners()
	return
end

function BossSwitchView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshData({
		id = self.bossList_[arg_5_1],
		index = arg_5_1
	})
	arg_5_2:RegistCallBack(function(arg_6_0)
		JumpTools.GoToSystem("/damageTestBossInfo", {
			damageTestId = arg_6_0.id
		})
	end)
end

function BossSwitchView:RefreshUI()
	if self.battleType_ == 0 then
		self.nameText_.text = "DEAD MAN"
	elseif self.battleType_ == 1 then
		self.nameText_.text = "COMBAT"
	elseif self.battleType_ == 3 then
		self.nameText_.text = "MOVE MAN"
	end

	self.scrollHelper_:StartScroll(#self.bossList_)
end

function BossSwitchView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.battleType_ = self.params_.battleType
	self.bossList_ = DamageTestCfg.get_id_list_by_battle_type[self.battleType_]

	self:RefreshUI()
end

function BossSwitchView:OnExit()
	manager.windowBar:HideBar()
end

function BossSwitchView:Dispose()
	self.scrollHelper_:Dispose()
	BossSwitchView.super.Dispose(self)
end

return BossSwitchView
