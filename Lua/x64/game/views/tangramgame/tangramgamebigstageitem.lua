local var_0_0 = class("TangramGameBigStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.stageID = arg_1_2
	arg_1_0.decodeID = arg_1_3
	arg_1_0.mainPage = arg_1_4

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.lockController = arg_2_0.controllerCom:GetController("status")
	arg_2_0.wrongController = arg_2_0.controllerCom:GetController("wrong")
	arg_2_0.unlockController = arg_2_0.controller:GetController("default0")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.stageBtn_, nil, function()
		if arg_3_0.lockController:GetSelectedState() == "lock" then
			manager.notify:Invoke(TANGRAM_GAME_DECODE_NOTFOUND)

			return
		end

		if arg_3_0.mainPage.fiexdPosList[arg_3_0.index] then
			return
		end

		if arg_3_0.mainPage.showHint then
			TangramGameData:AddStageChangeIndex(arg_3_0.index)
		end

		TangramGameData:AddStageIDInList(arg_3_0.stageID, arg_3_0.index, true)
	end)
end

function var_0_0.RefreshView(arg_5_0, arg_5_1)
	if TangramGameData:CheckStageIsClear(arg_5_0.stageID) then
		arg_5_0.lockController:SetSelectedState("complete")
		arg_5_0.unlockController:SetSelectedState("state0")
	else
		arg_5_0.lockController:SetSelectedState("lock")
		arg_5_0.unlockController:SetSelectedState("state1")
	end

	arg_5_0.index = TangramGameData:GetStageIDinListIndex(arg_5_0.stageID)

	if arg_5_0.index then
		arg_5_0.chooseText.text = arg_5_0.index
	else
		arg_5_0.chooseText.text = ""
	end

	arg_5_0.desc.text = ActivityTangramGameStageCfg[arg_5_0.stageID].conclusion_desc
	arg_5_0.stageName.text = ActivityTangramGameStageCfg[arg_5_0.stageID].name

	if arg_5_1 then
		if TangramGameData:CheckStagePosIsTrue(arg_5_0.index, arg_5_0.decodeID) then
			arg_5_0.wrongController:SetSelectedState("state0")
		else
			arg_5_0.wrongController:SetSelectedState("state1")
		end
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
