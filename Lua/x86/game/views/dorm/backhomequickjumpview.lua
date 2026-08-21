local var_0_0 = class("BackHomeQuickJumpView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.canteenBtnController = ControllerUtil.GetController(arg_3_0.canteenBtn.transform, "position")
	arg_3_0.publicDormBtnController = ControllerUtil.GetController(arg_3_0.publicDormBtn.transform, "position")
	arg_3_0.chooseDormBtnBtnController = ControllerUtil.GetController(arg_3_0.chooseDormBtn.transform, "position")
	arg_3_0.danceBtnBtnController = ControllerUtil.GetController(arg_3_0.danceRoomBtn.transform, "position")
end

function var_0_0.OnEnter(arg_4_0)
	manager.redPoint:bindUIandKey(arg_4_0.showBtn.transform, RedPointConst.BACKHOME)
	manager.redPoint:bindUIandKey(arg_4_0.canteenBtn.transform, RedPointConst.CANTEEN)
	manager.redPoint:bindUIandKey(arg_4_0.chooseDormBtn.transform, RedPointConst.DORM_PLACEMENT)
end

function var_0_0.OnExit(arg_5_0)
	manager.redPoint:unbindUIandKey(arg_5_0.showBtn.transform, RedPointConst.BACKHOME)
	manager.redPoint:unbindUIandKey(arg_5_0.canteenBtn.transform, RedPointConst.CANTEEN)
	manager.redPoint:unbindUIandKey(arg_5_0.chooseDormBtn.transform, RedPointConst.DORM_PLACEMENT)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgMask_, nil, function()
		arg_6_0:ShowView(false)
	end)
	arg_6_0:AddBtnListener(arg_6_0.showBtn, nil, function()
		arg_6_0:ShowView(true)
	end)
	arg_6_0:AddBtnListener(arg_6_0.visitBtn, nil, function()
		JumpTools.OpenPageByJump("/dormVisitView", {
			enterType = "quick"
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.canteenBtn, nil, function()
		if DormData:GetCurrectSceneID() == DormConst.CANTEEN_ID then
			arg_6_0:ShowView(false)

			return
		end

		BackHomeTools:GotoBackHomeRoom(DormConst.CANTEEN_ID)
	end)
	arg_6_0:AddBtnListener(arg_6_0.publicDormBtn, nil, function()
		local var_11_0 = DormData:GetCurrectSceneID()

		if var_11_0 == DormConst.PUBLIC_DORM_ID then
			arg_6_0:ShowView(false)

			return
		end

		if nullable(BackHomeCfg, var_11_0, "type") == DormConst.BACKHOME_TYPE.PrivateDorm then
			JumpTools.OpenPageByJump("/dormHeroDeployView")
		end

		BackHomeTools:GotoBackHomeRoom(DormConst.PUBLIC_DORM_ID)
	end)
	arg_6_0:AddBtnListener(arg_6_0.chooseDormBtn, nil, function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
	arg_6_0:AddBtnListener(arg_6_0.danceRoomBtn, nil, function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
			arg_6_0:ShowView(false)

			return
		end

		BackHomeTools:GotoBackHomeRoom(nil, true)
	end)
end

function var_0_0.ShowView(arg_14_0, arg_14_1)
	if arg_14_0.show == arg_14_1 then
		return
	end

	arg_14_0.show = arg_14_1

	if arg_14_0.show then
		arg_14_0.stateController:SetSelectedState("true")
		arg_14_0:RefreshView()

		if arg_14_0.clickFunc then
			arg_14_0.clickFunc()
		end
	else
		arg_14_0.stateController:SetSelectedState("false")

		arg_14_0.show = false

		if arg_14_0.closeFunc then
			arg_14_0.closeFunc()
		end
	end
end

function var_0_0.RefreshView(arg_15_0)
	if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
		arg_15_0.canteenBtnController:SetSelectedState("off")
		arg_15_0.publicDormBtnController:SetSelectedState("off")
		arg_15_0.chooseDormBtnBtnController:SetSelectedState("off")
		arg_15_0.danceBtnBtnController:SetSelectedState("on")
	else
		local var_15_0 = DormData:GetCurrectSceneID()

		if var_15_0 == DormConst.CANTEEN_ID then
			arg_15_0.canteenBtnController:SetSelectedState("on")
			arg_15_0.publicDormBtnController:SetSelectedState("off")
			arg_15_0.chooseDormBtnBtnController:SetSelectedState("off")
			arg_15_0.danceBtnBtnController:SetSelectedState("off")
		elseif var_15_0 == DormConst.PUBLIC_DORM_ID then
			arg_15_0.canteenBtnController:SetSelectedState("off")
			arg_15_0.publicDormBtnController:SetSelectedState("on")
			arg_15_0.chooseDormBtnBtnController:SetSelectedState("off")
			arg_15_0.danceBtnBtnController:SetSelectedState("off")
		elseif BackHomeCfg[var_15_0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			arg_15_0.canteenBtnController:SetSelectedState("off")
			arg_15_0.publicDormBtnController:SetSelectedState("off")
			arg_15_0.chooseDormBtnBtnController:SetSelectedState("on")
			arg_15_0.danceBtnBtnController:SetSelectedState("off")
		end
	end
end

function var_0_0.AddClickCallBack(arg_16_0, arg_16_1)
	if arg_16_1 then
		arg_16_0.clickFunc = arg_16_1
	end
end

function var_0_0.CloseCallBack(arg_17_0, arg_17_1)
	if arg_17_1 then
		arg_17_0.closeFunc = arg_17_1
	end
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
