local var_0_0 = class("HeroTransitionPage", HeroPageBase)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.transitionDiscView_ = TransitionSkillSlotsModule.New(arg_3_0.transitionDiscGo_)
	arg_3_0.transitionDetailInfoView_ = HeroTransitionDetailInfoView.New(arg_3_0.detailInfoViewGo_)
	arg_3_0.transitionSimpleInfoView_ = HeroTransitionSimpleInfoView.New(arg_3_0.simpleInfoViewGo_)
	arg_3_0.infoController_ = arg_3_0.controller_:GetController("info")

	arg_3_0:InitModule()
end

function var_0_0.InitModule(arg_4_0)
	arg_4_0.transitionDiscView_:LockJumpAnim(true)
	arg_4_0.transitionDiscView_:LockSelect(false)
	arg_4_0.transitionDiscView_:SetShowLocked(false)
	arg_4_0.transitionDiscView_:RegisterSlotClickCallback(handler(arg_4_0, arg_4_0.OnSelectSlot))
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0.infoController_:SetSelectedState("simple")
		arg_5_0.transitionDiscView_:ClearSelect()
	end)
end

function var_0_0.CameraEnter(arg_7_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		7,
		0
	})
end

function var_0_0.OnEnter(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.enterIndex_ = arg_8_2.transitionIndex

	arg_8_0.infoController_:SetSelectedState("simple")

	arg_8_0.heroViewProxy_ = arg_8_1
	arg_8_0.type_ = arg_8_0.heroViewProxy_:GetViewDataType()

	arg_8_0.transitionSimpleInfoView_:OnEnter(arg_8_1)
	arg_8_0.transitionDetailInfoView_:OnEnter(arg_8_1)
	arg_8_0:RegistEventListener(HERO_TRANSITION_CHANGE, function(arg_9_0)
		if arg_9_0.heroId == arg_8_0.heroInfo_.id then
			arg_8_0:UpdateView()
		end
	end)
end

function var_0_0.OnSelectSlot(arg_10_0, arg_10_1)
	arg_10_0.selectInfo_ = arg_10_1

	arg_10_0.transitionDetailInfoView_:SetSlotInfo(arg_10_1)
	arg_10_0.infoController_:SetSelectedState("detail")
end

function var_0_0.SetHeroInfo(arg_11_0, arg_11_1)
	arg_11_0.heroInfo_ = arg_11_1
	arg_11_0.heroID_ = arg_11_1.id

	arg_11_0.transitionSimpleInfoView_:SetHeroInfo(arg_11_1)
	arg_11_0.transitionDetailInfoView_:SetHeroInfo(arg_11_1)

	arg_11_0.isAdd_ = HeroTools.GetHeroEquipTransitionAddLevel(arg_11_0.heroInfo_)

	SetActive(arg_11_0.changeBtnGo_, arg_11_0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function var_0_0.UpdateView(arg_12_0)
	arg_12_0.transitionSimpleInfoView_:UpdateView()
	arg_12_0.transitionDetailInfoView_:UpdateView()
	arg_12_0.transitionDiscView_:RenderView({
		needRefresh = true,
		heroID = arg_12_0.heroID_,
		proxy = arg_12_0.heroViewProxy_
	})
	arg_12_0.transitionDiscView_:RenderLock()

	if arg_12_0.enterIndex_ then
		local var_12_0 = arg_12_0.transitionDiscView_:GetAllSlotMessage()[arg_12_0.enterIndex_]

		arg_12_0:OnSelectSlot(var_12_0)
		arg_12_0.transitionDiscView_:SelectSlot(arg_12_0.enterIndex_)
	end
end

function var_0_0.Show(arg_13_0)
	var_0_0.super.Show(arg_13_0)
	arg_13_0:UpdateView()
end

function var_0_0.OnTop(arg_14_0)
	return
end

function var_0_0.Hide(arg_15_0)
	var_0_0.super.Hide(arg_15_0)

	arg_15_0.enterIndex_ = nil

	arg_15_0.infoController_:SetSelectedState("simple")
	arg_15_0.transitionDiscView_:ClearSelect()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.transitionDiscView_:Dispose()
	arg_17_0.transitionDetailInfoView_:Dispose()
	arg_17_0.transitionSimpleInfoView_:Dispose()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
