local var_0_0 = class("IndiaNianStageDescItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "state")
	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "selected")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if not IndiaNianData:GetStageHasClearedByID(arg_2_0.cfg_.id) then
			ShowTips("ACTIVITY_INDIA_NIAN_DESC_LOCK")
		end

		IndiaNianData:SetSelectedDescIndex(arg_2_0.index_)

		if arg_2_0.callBack then
			arg_2_0.callBack(arg_2_0.index_)
		end
	end)
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.nameText_.text = arg_4_0.cfg_.name
	arg_4_0.iconImg_.sprite = getSprite("Atlas/IndiaUI_2_8", arg_4_0.cfg_.icon)

	arg_4_0:RefreshState()
end

function var_0_0.RefreshState(arg_5_0)
	local var_5_0 = getData("ActivityIndiaNian" .. IndiaNianData:GetActivityID() .. PlayerData:GetPlayerInfo().userID, "unlockNewStage" .. arg_5_0.cfg_.id) == 1
	local var_5_1 = arg_5_0.cfg_.round > IndiaNianData:GetRound()
	local var_5_2 = IndiaNianData:GetStageHasClearedByID(arg_5_0.cfg_.id)
	local var_5_3 = arg_5_0.index_ == IndiaNianData:GetSelectedDescIndex()

	if var_5_1 then
		arg_5_0.controller_:SetSelectedState("lock")
	elseif var_5_2 then
		arg_5_0.controller_:SetSelectedState("open")
	end

	arg_5_0.selectController_:SetSelectedState(tostring(var_5_3))

	if var_5_2 then
		SetActive(arg_5_0.effectGo_, not var_5_0)
	end
end

function var_0_0.SetCallBack(arg_6_0, arg_6_1)
	arg_6_0.callBack = arg_6_1
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.index_ = arg_7_1
	arg_7_0.cfg_ = arg_7_2

	arg_7_0:RefreshUI()
end

function var_0_0.OnExit(arg_8_0)
	if IndiaNianData:GetStageHasClearedByID(arg_8_0.cfg_.id) then
		saveData("ActivityIndiaNian" .. IndiaNianData:GetActivityID() .. PlayerData:GetPlayerInfo().userID, "unlockNewStage" .. arg_8_0.cfg_.id, 1)
	end
end

return var_0_0
