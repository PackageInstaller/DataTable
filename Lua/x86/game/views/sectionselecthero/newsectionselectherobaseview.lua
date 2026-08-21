local var_0_0 = class("NewSectionSelectHeroBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return SectionSelectHeroTools.GetSelectHeroViewUIPath(arg_1_0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitSubViewCfg()
	arg_4_0:InitCallback()
end

function var_0_0.InitSubViewCfg(arg_5_0)
	arg_5_0.subViewDic_ = {
		selectHeroView = {
			go = arg_5_0.selectHeroGo_,
			getClassFunc = handler(arg_5_0, arg_5_0.GetSelectHeroViewClass)
		},
		additionalView = {
			go = arg_5_0.additionalGo_,
			getClassFunc = handler(arg_5_0, arg_5_0.GetAdditionalViewClass)
		}
	}
end

function var_0_0.InitCallback(arg_6_0)
	arg_6_0.clickHeroHandler_ = handler(arg_6_0, arg_6_0.OnSectionClickHero)
	arg_6_0.clickStartBattleHandler_ = handler(arg_6_0, arg_6_0.OnSectionClickStartBattle)
	arg_6_0.clickRandomAttributeTipsHandler_ = handler(arg_6_0, arg_6_0.OnClickRandomAttributeTips)
end

function var_0_0.ReserveCameraEnter(arg_7_0)
	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.reserve, true)
	manager.reserveCamera:SwitchCamera(ReserveCameraConst.CAMERA_TYPE.common, ReserveCameraConst.VIRTUAL_CAMERA.sectionSelectHero)
end

function var_0_0.AddListener(arg_8_0)
	return
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
end

function var_0_0.OnBehind(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListener()
	arg_11_0:ProcessParams()
	arg_11_0:ProcessSubView()
	arg_11_0:SubViewOnEnter()
	arg_11_0:Refresh()
end

function var_0_0.OnEnterOver(arg_12_0)
	arg_12_0:RegistEventListener(ON_ASYNC_SCENE_LOADED, function(arg_13_0)
		if arg_13_0 == "X104" and arg_12_0.gameObject_.activeInHierarchy then
			arg_12_0:OnAsyncSceneLoaded()
		end
	end)
end

function var_0_0.OnAsyncSceneLoaded(arg_14_0)
	arg_14_0.subViewDic_.selectHeroView.instance:RebindController()
	arg_14_0.subViewDic_.selectHeroView.instance:UpdatePosition()
	arg_14_0.subViewDic_.selectHeroView.instance:RefreshHeroInfoItem()
end

function var_0_0.AddEventListener(arg_15_0)
	arg_15_0:RegistEventListener(SECTION_CLICK_HERO, arg_15_0.clickHeroHandler_)
	arg_15_0:RegistEventListener(SECTION_CLICK_START_BATTLE, arg_15_0.clickStartBattleHandler_)
	arg_15_0:RegistEventListener(SECTION_CLICK_RANDOM_ATTRIBUTE_TIPS, arg_15_0.clickRandomAttributeTipsHandler_)
end

function var_0_0.ProcessParams(arg_16_0)
	arg_16_0:ProcessBaseParams()
	arg_16_0:ProcessReserveParams()
	arg_16_0:ProcessProxyParams()
	arg_16_0:ProcessCustomParams()
end

function var_0_0.ProcessBaseParams(arg_17_0)
	arg_17_0.multiple_ = arg_17_0.params_.multiple or 1
	arg_17_0.stageID_ = arg_17_0.params_.section
	arg_17_0.stageType_ = arg_17_0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	arg_17_0.activityID_ = arg_17_0.params_.activityID
end

function var_0_0.ProcessReserveParams(arg_18_0)
	if not arg_18_0.params_.reserveParams then
		arg_18_0.params_.reserveParams = ReserveTools.GetReserveParams(arg_18_0.stageType_, arg_18_0.stageID_, arg_18_0.activityID_)
	elseif not arg_18_0.params_.reserveParams.customData.activityID then
		arg_18_0.params_.reserveParams.customData.activityID = arg_18_0.activityID_
	end

	arg_18_0.reserveParams_ = arg_18_0.params_.reserveParams
end

function var_0_0.ProcessProxyParams(arg_19_0)
	if not arg_19_0.params_.sectionProxy then
		local var_19_0 = arg_19_0.params_.heroDataType or HeroConst.HERO_DATA_TYPE.DEFAULT

		arg_19_0.params_.sectionProxy = SectionSelectHeroTools.GetProxy(arg_19_0.params_, arg_19_0.reserveParams_, var_19_0)
	end

	arg_19_0.sectionProxy_ = arg_19_0.params_.sectionProxy
	arg_19_0.sectionProxy_.isEnter = not arg_19_0.params_.isBack
end

function var_0_0.ProcessCustomParams(arg_20_0)
	return
end

function var_0_0.ProcessSubView(arg_21_0)
	arg_21_0:InitSubView()
	arg_21_0:TryReloadSubView()
	arg_21_0:ProcessSubViewParams()
end

function var_0_0.ProcessSubViewParams(arg_22_0)
	arg_22_0:SubViewCallFunc("SetProxy", arg_22_0.sectionProxy_)
end

function var_0_0.UpdateBar(arg_23_0)
	arg_23_0.sectionProxy_:UpdateBar()
end

function var_0_0.SubViewOnEnter(arg_24_0)
	arg_24_0:SubViewCallFunc("OnEnter")
end

function var_0_0.OnExit(arg_25_0)
	arg_25_0:RemoveAllEventListener()
	arg_25_0:SubViewOnExit()

	arg_25_0.params_.isSorted = false

	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.reserve, false)
end

function var_0_0.SubViewOnExit(arg_26_0)
	arg_26_0:SubViewCallFunc("OnExit")
end

function var_0_0.Dispose(arg_27_0)
	arg_27_0:SubViewCallFunc("Dispose")

	for iter_27_0, iter_27_1 in pairs(arg_27_0.subViewDic_) do
		iter_27_1.go = nil
		iter_27_1.instance = nil
	end

	var_0_0.super.Dispose(arg_27_0)
end

function var_0_0.Refresh(arg_28_0)
	arg_28_0:RefreshSubView()
	arg_28_0:RefreshSortType()
	arg_28_0:DisplayFilterLockHero()
	arg_28_0:RefreshCustomUI()
end

function var_0_0.RefreshSubView(arg_29_0)
	arg_29_0:SubViewCallFunc("Refresh")
end

function var_0_0.RefreshSortType(arg_30_0)
	if not arg_30_0.params_.isSorted then
		HeroData:ResetSortValue()
	end
end

function var_0_0.DisplayFilterLockHero(arg_31_0)
	if not arg_31_0.params_.isBack then
		if not arg_31_0.sectionProxy_.needDisplayFilterLocalHero or #arg_31_0.reserveParams_.filterLockHeroList == 0 or manager.time:IsToday(SectionSelectHeroTools.GetSkipDisplayFilterLockHeroTime()) then
			return
		end

		JumpTools.OpenPageByJump("filterLockHero", {
			heroIDList = arg_31_0.reserveParams_.filterLockHeroList,
			type = SectionSelectHeroConst.DISPLAY_FILTER_LOCK_HERO_TYPE.NORMAL
		})
	end
end

function var_0_0.RefreshCustomUI(arg_32_0)
	return
end

function var_0_0.OnSectionClickHero(arg_33_0, arg_33_1)
	arg_33_0.sectionProxy_:GotoHeroInfoUI(arg_33_1)
end

function var_0_0.OnSectionClickStartBattle(arg_34_0)
	local var_34_0, var_34_1 = arg_34_0:CheckCanStartBattle()

	if var_34_0 then
		arg_34_0:StartBattle()
	elseif var_34_1 then
		ShowTips(var_34_1)
	end
end

function var_0_0.CheckCanStartBattle(arg_35_0)
	return arg_35_0.subViewDic_.selectHeroView.instance:CheckCanStartBattle()
end

function var_0_0.StartBattle(arg_36_0)
	arg_36_0.sectionProxy_:StartBattle()
end

function var_0_0.OnClickRandomAttributeTips(arg_37_0, arg_37_1)
	arg_37_1:SetParent(arg_37_0.pageContainerTrans_)
end

function var_0_0.GetAdditionalViewClass(arg_38_0)
	return arg_38_0.sectionProxy_:GetAdditionalViewClass()
end

function var_0_0.GetSelectHeroViewClass(arg_39_0)
	return arg_39_0.sectionProxy_:GetSelectHeroViewClass()
end

function var_0_0.InitSubView(arg_40_0)
	if not arg_40_0.createdSubview_ then
		arg_40_0.createdSubview_ = true

		for iter_40_0, iter_40_1 in pairs(arg_40_0.subViewDic_) do
			local var_40_0 = iter_40_1.go

			iter_40_1.instance = iter_40_1.getClassFunc().New(var_40_0)

			if iter_40_1.initFunc then
				iter_40_1.initFunc()
			end
		end
	end
end

function var_0_0.TryReloadSubView(arg_41_0)
	for iter_41_0, iter_41_1 in pairs(arg_41_0.subViewDic_) do
		if SectionSelectHeroTools.IsDiffViewClass(iter_41_1.instance, iter_41_1.getClassFunc()) then
			iter_41_1.instance = SectionSelectHeroTools.ReloadView(iter_41_1.instance, iter_41_1.getClassFunc())

			if iter_41_1.initFunc then
				iter_41_1.initFunc()
			end
		end
	end
end

function var_0_0.SubViewCallFunc(arg_42_0, arg_42_1, ...)
	for iter_42_0, iter_42_1 in pairs(arg_42_0.subViewDic_) do
		local var_42_0 = iter_42_1.instance

		if var_42_0 and var_42_0[arg_42_1] then
			var_42_0[arg_42_1](var_42_0, ...)
		end
	end
end

return var_0_0
