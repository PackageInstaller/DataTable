local TransitionSkillView = class("TransitionSkillView", ReduxView)

function TransitionSkillView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.transition,
		0
	})
end

function TransitionSkillView:UIName()
	return "Widget/System/Hero_jumps/SubJumps/HeroJumpsSwitchUI"
end

function TransitionSkillView:UIParent()
	return manager.ui.uiMain.transform
end

function TransitionSkillView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TransitionSkillView:BuildContext()
	self.contex = {
		heroID = 0,
		curTabIdx = 1
	}
	self.controller = {
		comps = self.elementController_,
		lock = {
			Stage1 = "state1",
			Stage2 = "state2",
			Stage4 = "state4",
			name = "lock",
			Stage6 = "state6",
			Stage3 = "state3",
			Stage5 = "state5",
			Stage0 = "state0",
			comps = self.elementController_:GetController("lock")
		},
		activate = {
			Stage1 = "state1",
			Stage2 = "state2",
			Stage4 = "state4",
			name = "activate",
			Stage6 = "state6",
			Stage3 = "state3",
			Stage5 = "state5",
			Stage0 = "state0",
			comps = self.elementController_:GetController("activate")
		}
	}
	self.view = {
		slotsModule = TransitionSkillSlotsModule.New(self.jumpviwerObj_, true),
		chipContainer = TransitionSkillListModule.New(self.chipModuleObj_),
		infoModule = TransitionSkillInfoModule.New(self.skillInfoObj_)
	}
end

function TransitionSkillView:InitModule()
	self.view.chipContainer:RegisterTabListener(handler(self, self.OnTabSwitch))
	self.view.chipContainer:RegisterItemClickListener(handler(self, self.OnItemClick))
	self.view.chipContainer:RegisterRefreshJumpElement(handler(self, self.OnJumpElementChange))
	self.view.chipContainer:RegisterRefreshJumpSlotView(handler(self, self.OnJumpSlotRefresh))
	self.view.slotsModule:LockJumpAnim(false)
	self.view.slotsModule:LockSelect(true)
	self.view.slotsModule:SetShowLocked(false)
	self.view.infoModule:RegisterEquipBtnClickEmitter(handler(self, self.OnEquipBtnClick))
	self.view.infoModule:RegisterExchangeBtnClickEmitter(handler(self, self.OnExchangeBtnClick))
	self.view.infoModule:RegisterLevelUpBtnClickEmitter(handler(self, self.OnLevelUpBtnClick))

	self.resetTxt_.text = GetTips("ACTIVITY_SNOWBALL_ICE_RESET")
	self.exchangeTxt_.text = GetTips("EXCHANGE_TRANSITION_CHIP")
end

function TransitionSkillView:InitUI()
	self:BindCfgUI()
	self:BuildContext()
	self:InitModule()
end

function TransitionSkillView:AddUIListeners()
	self:AddBtnListener(self.resetBtn_, nil, function()
		self:OnResetBtnClick()
	end)
	self:AddBtnListener(self.exchangeBtn_, nil, function()
		self:OnAddElementBtnClick()
	end)
end

function TransitionSkillView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		7,
		1,
		true
	})
end

function TransitionSkillView:OnEnter()
	self.contex.heroID = self.params_.heroID
	self.contex.curTabIdx = self.params_.index
	self.contex.type = self.params_.type

	self.view.slotsModule:RenderView({
		needRefresh = true,
		heroID = self.params_.heroID,
		type = self.contex.type,
		index = self.params_.index
	})
	self.view.chipContainer:RenderView({
		index = self.params_.index,
		heroID = self.params_.heroID
	})
end

function TransitionSkillView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EXCLUSIVE_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		self:SaveData(function()
			self:Back()
		end)
	end)
	manager.windowBar:RegistHomeCallBack(function()
		self:SaveData(function()
			self:Go("/home", nil, nil, true)
		end)
	end)
end

function TransitionSkillView:OnExit()
	manager.windowBar:HideBar()
	self.view.chipContainer:OnExit()
	self:RemoveAllEventListener()
end

function TransitionSkillView:Dispose()
	self:RemoveAllListeners()
	self.view.chipContainer:Dispose()
	self.view.infoModule:Dispose()
	self.view.slotsModule:Dispose()
	TransitionSkillView.super.Dispose(self)
end

function TransitionSkillView:OnTabSwitch(arg_20_1)
	self.view.slotsModule:JumpToSlot(arg_20_1)

	self.contex.curTabIdx = arg_20_1
end

function TransitionSkillView:OnItemClick(arg_21_1)
	self.view.infoModule:RenderView({
		skillID = arg_21_1.skillID,
		level = arg_21_1.level,
		heroID = self.contex.heroID,
		equipped = arg_21_1.equipped,
		pos = self.contex.curTabIdx
	})
end

function TransitionSkillView:OnJumpElementChange(arg_22_1)
	self.controller.activate.comps:SetSelectedState("state" .. arg_22_1.totalElement - arg_22_1.leftElement)
	self.controller.lock.comps:SetSelectedState("state" .. arg_22_1.totalElement)

	self.elementCountTxt_.text = table.concat({
		arg_22_1.leftElement,
		"/",
		arg_22_1.totalElement
	})

	SetActive(self.exchangeBtn_.gameObject, self.view.chipContainer:GetCurGiftPoint() < 6)
end

function TransitionSkillView:OnJumpSlotRefresh(arg_23_1)
	self.view.slotsModule:RefreshSlot(arg_23_1)
end

function TransitionSkillView:OnResetBtnClick()
	self.view.chipContainer:ResetUseList()
	self.view.slotsModule:ClearSlot(self.contex.curTabIdx)
end

function TransitionSkillView:OnAddElementBtnClick()
	if self.view.chipContainer:GetCurGiftPoint() < 6 then
		self:SaveData(function()
			JumpTools.OpenPageByJump("transitionGiftPt", {
				isEnter = true,
				giftPt = self.view.chipContainer:GetCurGiftPoint(),
				heroID = self.contex.heroID,
				index = self.contex.curTabIdx
			})
		end)
	end
end

function TransitionSkillView:OnEquipBtnClick()
	self.view.chipContainer:OnSkillEquip()
end

function TransitionSkillView:OnExchangeBtnClick()
	self.view.chipContainer:OnSkillExchange()
end

function TransitionSkillView:OnLevelUpBtnClick()
	self.view.chipContainer:OnSkillLevelUp()
end

function TransitionSkillView:SaveData(arg_30_1)
	self.view.chipContainer:SaveData(arg_30_1)
end

return TransitionSkillView
