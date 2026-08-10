local var_0_0 = class("EnterBattleSelectOpponentPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
	arg_2_0:RegisterEvents()

	arg_2_0.opponentUIList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.opponentList_, SelectOpponentListItem)
	arg_2_0.showFlag = false
	arg_2_0.typeController_ = arg_2_0.mainControllerEx_:GetController("type")
	arg_2_0.stateController = arg_2_0.mainControllerEx_:GetController("state")
end

function var_0_0.RegisterEvents(arg_3_0)
	arg_3_0:RegistEventListener(IDOL_TRAINEE_REFRESH_OPPONENT, function()
		return
	end)
end

function var_0_0.ShowPage(arg_5_0, arg_5_1)
	if arg_5_0.showFlag == arg_5_1 then
		return
	end

	arg_5_0.showFlag = arg_5_1

	if arg_5_1 then
		arg_5_0.stateController:SetSelectedState("show")
		arg_5_0:OnEnter()
	else
		arg_5_0.stateController:SetSelectedState("close")
		arg_5_0:OnExit()
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.strangerBtn_, nil, function()
		if arg_6_0.canClick then
			arg_6_0.canClick = false

			IdolTraineeAction.RequestOpponentList(IdolTraineeConst.friendType.stranger, function()
				arg_6_0:ChangeContent(IdolTraineeConst.friendType.stranger)

				arg_6_0.canClick = true
			end)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.friendBtn_, nil, function()
		if arg_6_0.canClick then
			arg_6_0.canClick = false

			IdolTraineeAction.RequestOpponentList(IdolTraineeConst.friendType.friend, function()
				arg_6_0:ChangeContent(IdolTraineeConst.friendType.friend)

				arg_6_0.canClick = true
			end)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.refreshBtn_, nil, function()
		if arg_6_0.canClick then
			arg_6_0.canClick = false

			IdolTraineeAction.RequestOpponentList(IdolTraineeConst.friendType.stranger, function()
				arg_6_0:ChangeContent(arg_6_0.curContent_, true)

				arg_6_0.canClick = true
			end, true)
		end
	end)
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_0.infoList[arg_13_1], arg_13_0.curContent_)
end

function var_0_0.RefreshUI(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1 or arg_14_0.curContent_ or IdolTraineeConst.friendType.friend

	arg_14_0:ChangeContent(var_14_0, true)
end

function var_0_0.ChangeContent(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.curContent_ == arg_15_1 and not arg_15_2 then
		return
	end

	arg_15_0.curContent_ = arg_15_1

	if arg_15_1 == IdolTraineeConst.friendType.friend then
		arg_15_0.typeController_:SetSelectedState("friend")
	else
		arg_15_0.typeController_:SetSelectedState("stranger")
	end

	arg_15_0:RefreshPlayerInfoList()
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0.canClick = true

	if arg_16_0.canClick then
		arg_16_0.canClick = false

		IdolTraineeAction.RequestOpponentList(IdolTraineeConst.friendType.friend, function()
			local var_17_0 = IdolTraineeTools:GetOpponentList(IdolTraineeConst.friendType.friend)

			if not var_17_0 or #var_17_0 == 0 then
				arg_16_0:ChangeContent(IdolTraineeConst.friendType.stranger)
			else
				arg_16_0:ChangeContent(IdolTraineeConst.friendType.friend)
			end

			arg_16_0.canClick = true
		end)
	end
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0:RemoveAllEventListener()
end

function var_0_0.RefreshPlayerInfoList(arg_19_0)
	arg_19_0.infoList = IdolTraineeTools:GetOpponentList(arg_19_0.curContent_)

	if arg_19_0.infoList then
		arg_19_0.opponentUIList_:StartScroll(#arg_19_0.infoList)
	end
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0.infoList = nil

	arg_20_0.opponentUIList_:Dispose()

	arg_20_0.opponentUIList_ = nil

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
