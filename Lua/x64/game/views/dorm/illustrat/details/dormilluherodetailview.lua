local var_0_0 = class("DormIlluHeroDetailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolDance/IdolDanceIllustrateHeroDetailsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.OnTop(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.OnBehind(arg_5_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_6_0)
	if arg_6_0.infoPage_ then
		arg_6_0.infoPage_:OnEnter(arg_6_0.params_.heroID, function(arg_7_0)
			arg_6_0:PlayAction(arg_7_0)
		end)
	end

	arg_6_0:ChangeHeroID(arg_6_0.params_.heroID)

	arg_6_0.heroIDList_ = arg_6_0.params_.heroIDList
	arg_6_0.doneAniList_ = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.heroIDList_) do
		if iter_6_1 == arg_6_0.heroID_ then
			arg_6_0.enterIndex_ = iter_6_0
		end
	end

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	manager.ui:SetMainCamera("hero")
end

function var_0_0.OnExit(arg_8_0)
	manager.audio:StopEffect()

	if arg_8_0.infoPage_ then
		arg_8_0.infoPage_:OnExit()
	end

	if arg_8_0.entityID_ and arg_8_0.entityID_ ~= 0 then
		DormIllu.RemoveHero(arg_8_0.entityID_)

		arg_8_0.entityID_ = 0
	end

	arg_8_0.heroID_ = 0
	arg_8_0.archiveID_ = 0
	arg_8_0.enterIndex_ = 0

	manager.ui:ResetMainCamera()
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.infoPage_ then
		arg_9_0.infoPage_:Dispose()

		arg_9_0.infoPage_ = nil
	end

	for iter_9_0 = 1, #arg_9_0.roleTabs_ do
		arg_9_0.roleTabs_[iter_9_0]:Dispose()
	end

	if arg_9_0.entityID_ and arg_9_0.entityID_ ~= 0 then
		DormIllu.RemoveHero(arg_9_0.entityID_)

		arg_9_0.entityID_ = 0
	end

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.InitUI(arg_10_0)
	arg_10_0:BindCfgUI()
	arg_10_0:BindController()
	arg_10_0:AddUIListener()

	arg_10_0.infoPage_ = DormIlluHeroDetailInfoView.New(arg_10_0.heroInfoSubView_)
	arg_10_0.heroIDList_ = {}
	arg_10_0.heroID_ = 0
	arg_10_0.archiveID_ = 0
	arg_10_0.roleIndex_ = 0
	arg_10_0.roleTabs_ = {}
	arg_10_0.roleIDList_ = {}
	arg_10_0.enterIndex_ = 0
end

function var_0_0.BindController(arg_11_0)
	arg_11_0.roleSwitchController_ = arg_11_0.mainControllerEx_:GetController("roleSwitch")
end

function var_0_0.AddUIListener(arg_12_0)
	arg_12_0:AddBtnListener(arg_12_0.leftBtn_, nil, function()
		local var_13_0 = 0

		if arg_12_0.enterIndex_ == 1 then
			var_13_0 = arg_12_0.heroIDList_[#arg_12_0.heroIDList_]
			arg_12_0.enterIndex_ = #arg_12_0.heroIDList_
		else
			var_13_0 = arg_12_0.heroIDList_[arg_12_0.enterIndex_ - 1]
			arg_12_0.enterIndex_ = arg_12_0.enterIndex_ - 1
		end

		arg_12_0:ChangeHeroID(var_13_0)
	end)
	arg_12_0:AddBtnListener(arg_12_0.rightBtn_, nil, function()
		local var_14_0 = 0

		if arg_12_0.enterIndex_ == #arg_12_0.heroIDList_ then
			var_14_0 = arg_12_0.heroIDList_[1]
			arg_12_0.enterIndex_ = 1
		else
			var_14_0 = arg_12_0.heroIDList_[arg_12_0.enterIndex_ + 1]
			arg_12_0.enterIndex_ = arg_12_0.enterIndex_ + 1
		end

		arg_12_0:ChangeHeroID(var_14_0)
	end)
	arg_12_0:AddDragListener(arg_12_0.backGo_, function()
		local var_15_0 = Dorm.DormEntityManager.GetTransform(arg_12_0.entityID_)

		if var_15_0 then
			arg_12_0.startRot_ = var_15_0.localEulerAngles
		else
			arg_12_0.startRot_ = Vector3.zero
		end

		arg_12_0.lastRotateY_ = nil
		arg_12_0.lastDeltaX_ = 0
	end, function(arg_16_0, arg_16_1)
		local var_16_0 = Dorm.DormEntityManager.GetTransform(arg_12_0.entityID_)

		if var_16_0 then
			local var_16_1 = arg_12_0.lastRotateY_ or var_16_0.localEulerAngles.y
			local var_16_2 = var_16_1 + (arg_16_0 - (arg_12_0.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_16_1
			local var_16_3 = var_16_2

			if var_16_2 < -HeroConst.MAX_RORATE_ANGLE then
				var_16_3 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_16_2 > HeroConst.MAX_RORATE_ANGLE then
				var_16_3 = HeroConst.MAX_RORATE_ANGLE
			end

			arg_12_0.lastRotateY_ = var_16_1 + var_16_3
			arg_12_0.lastDeltaX_ = arg_16_0
			var_16_0.localRotation = Quaternion.RotateTowards(var_16_0.localRotation, Quaternion.Euler(arg_12_0.startRot_.x, var_16_1 + var_16_3, arg_12_0.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function var_0_0.PlayAction(arg_17_0, arg_17_1)
	manager.audio:StopEffect()

	if arg_17_0.entityID_ then
		Dorm.DormEntityManager.StopAllCmd(arg_17_0.entityID_)

		if arg_17_1 and arg_17_1 ~= -1 then
			Dorm.DormEntityManager.SendInteractToEntityCMD(arg_17_0.entityID_, arg_17_0.entityID_, arg_17_1, false)
		end
	end
end

function var_0_0.ChangeHeroID(arg_18_0, arg_18_1)
	if arg_18_0.heroID_ == arg_18_1 then
		return
	end

	manager.audio:StopEffect()

	arg_18_0.doneAniList_ = {}
	arg_18_0.heroID_ = arg_18_1
	arg_18_0.archiveID_ = DormData:GetHeroArchiveID(arg_18_1)

	arg_18_0:UpdateView()
end

function var_0_0.UpdateView(arg_19_0)
	arg_19_0:UpdateRoleSwitchView()

	if arg_19_0.entityID_ and arg_19_0.entityID_ ~= 0 then
		DormIllu.RemoveHero(arg_19_0.entityID_)

		arg_19_0.entityID_ = 0
	end

	arg_19_0.entityID_ = DormIllu.GetHero(arg_19_0.heroID_)

	Dorm.DormEntityManager.PutEntityAt(arg_19_0.entityID_, Vector3.New(500.37, 1.29, 3.36))
	arg_19_0.infoPage_:UpdateView(arg_19_0.heroID_, arg_19_0.entityID_)
end

function var_0_0.UpdateRoleSwitchView(arg_20_0)
	arg_20_0.roleIDList_ = {}

	for iter_20_0, iter_20_1 in ipairs(HeroRecordCfg[arg_20_0.archiveID_].hero_id) do
		if HeroCfg[iter_20_1].private ~= 1 and not HeroTools.GetIsHide(iter_20_1) then
			table.insert(arg_20_0.roleIDList_, iter_20_1)
		end
	end

	for iter_20_2 = 1, #arg_20_0.roleTabs_ do
		arg_20_0.roleTabs_[iter_20_2]:Hide()
		arg_20_0.roleTabs_[iter_20_2]:SetSelectState(false)
	end

	for iter_20_3 = 1, #arg_20_0.roleIDList_ do
		if not arg_20_0.roleTabs_[iter_20_3] then
			local var_20_0 = Object.Instantiate(arg_20_0.heroItemGo_, arg_20_0.heroTabTrs_)

			arg_20_0.roleTabs_[iter_20_3] = DormRoleTabItem.New(var_20_0, function()
				arg_20_0:OnClickRoleTab(iter_20_3)
			end)
		end

		arg_20_0.roleTabs_[iter_20_3]:Show(arg_20_0.roleIDList_[iter_20_3])

		if arg_20_0.roleIDList_[iter_20_3] == arg_20_0.heroID_ then
			arg_20_0.roleTabs_[iter_20_3]:SetSelectState(true)

			arg_20_0.roleIndex_ = iter_20_3
		end
	end
end

function var_0_0.OnClickRoleTab(arg_22_0, arg_22_1)
	if arg_22_1 == arg_22_0.roleIndex_ then
		return
	end

	if arg_22_0.roleTabs_[arg_22_0.roleIndex_] then
		arg_22_0.roleTabs_[arg_22_0.roleIndex_]:SetSelectState(false)
	end

	arg_22_0.roleTabs_[arg_22_1]:SetSelectState(true)

	arg_22_0.roleIndex_ = arg_22_1

	arg_22_0:ChangeHeroID(arg_22_0.roleIDList_[arg_22_1])
	arg_22_0:UpdateView()
end

return var_0_0
