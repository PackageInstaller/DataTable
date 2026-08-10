local var_0_0 = class("AstrolabeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.data_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.transform_.localPosition = Vector3(0, 0, 0)
	arg_1_0.posX = arg_1_3

	arg_1_0:InitUI()
	arg_1_0:Init()

	arg_1_0.nodeState = AstrolabeConst.NODE_STATE.LOCK
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.data_ = arg_2_1
	arg_2_0.info_ = arg_2_2

	arg_2_0:Render()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "state")
	arg_3_0.activeController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "name")
	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "select")

	arg_3_0:ShowSelect(false)
	arg_3_0:AddBtnListener(arg_3_0.nodeitemBtn_, nil, "OnClick")
end

function var_0_0.Render(arg_4_0)
	arg_4_0:RefreshUI(arg_4_0.info_)
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1)
	arg_5_0.info_ = arg_5_1

	if arg_5_1 then
		if not arg_5_1.isUnlock then
			if arg_5_1.isCanLock then
				arg_5_0.nodeState = AstrolabeConst.NODE_STATE.CANLOCK

				arg_5_0.activeController_:SetSelectedState("canUnlock")
			else
				arg_5_0.activeController_:SetSelectedState("lock")

				arg_5_0.nodeState = AstrolabeConst.NODE_STATE.LOCK
			end
		elseif arg_5_1.isUnlock then
			arg_5_0.activeController_:SetSelectedState("unlock")

			arg_5_0.nodeState = AstrolabeConst.NODE_STATE.UNLOCK
		end

		if not arg_5_0.heroViewProxy_.isSelf then
			arg_5_0.activeController_:SetSelectedState("unlock")

			arg_5_0.nodeState = AstrolabeConst.NODE_STATE.UNLOCK
		end

		if arg_5_1.isEquiped then
			if arg_5_0.posX == 1 then
				arg_5_0.stateController_:SetSelectedState("red")
			elseif arg_5_0.posX == 2 then
				arg_5_0.stateController_:SetSelectedState("yellow")
			elseif arg_5_0.posX == 3 then
				arg_5_0.stateController_:SetSelectedState("bule")
			end

			arg_5_0.nodeState = AstrolabeConst.NODE_STATE.EQUIPED
		else
			arg_5_0.stateController_:SetSelectedState("gray")
		end

		arg_5_0.nameText_.text = GetI18NText(HeroAstrolabeCfg[arg_5_1.id].name)
	end
end

function var_0_0.ShowSelect(arg_6_0, arg_6_1)
	arg_6_0.selectController_:SetSelectedState(arg_6_1 and "true" or "false")
end

function var_0_0.Init(arg_7_0)
	arg_7_0:RefreshUI(arg_7_0.info_)
end

function var_0_0.SetNodeNameIsHide(arg_8_0, arg_8_1)
	if arg_8_0.nameText_ then
		SetActive(arg_8_0.nameText_.gameObject, not arg_8_1)
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()

	arg_9_0.clickFunc = nil

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.OnClick(arg_10_0)
	if arg_10_0.clickFunc then
		if not arg_10_0.heroViewProxy_.isSelf then
			return
		end

		arg_10_0.clickFunc(arg_10_0)
	end
end

function var_0_0.RegistCallBack(arg_11_0, arg_11_1)
	arg_11_0.clickFunc = arg_11_1
end

function var_0_0.GetItemInfo(arg_12_0)
	return arg_12_0.info_
end

function var_0_0.SetRedPoint(arg_13_0, arg_13_1)
	SetActive(arg_13_0.notice_imgGo_, arg_13_1)
end

function var_0_0.SetProxy(arg_14_0, arg_14_1)
	arg_14_0.heroViewProxy_ = arg_14_1
end

return var_0_0
