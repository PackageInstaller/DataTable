TugGameItem = import("game.views.SPKali.TugGame.TugGameItem")

local var_0_0 = class("SpKaliStageItem", TugGameItem)

function var_0_0.SetData(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.data = arg_1_1
	arg_1_0.stageID_ = arg_1_0.data.id
	arg_1_0.index = arg_1_2
	arg_1_0.ctrl = arg_1_4

	local var_1_0 = BattleCoreKaliCfg[arg_1_0.stageID_]

	arg_1_0.lockState = arg_1_0.data and arg_1_0.data.unlockIndex >= arg_1_0.index

	if arg_1_0.data.unlockIndex >= arg_1_0.index - 1 then
		arg_1_0.lockState = true
	end

	arg_1_0.prePass = arg_1_0.lockState

	local var_1_1 = ActivityKaliStageCfg.all

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2 = ActivityKaliStageCfg[iter_1_1]

		if var_1_2.stage_id == arg_1_0.stageID_ then
			arg_1_0.otherCfg = var_1_2
		end
	end

	arg_1_0.isOpenTime = ActivityData:GetActivityIsOpen(arg_1_0.otherCfg.activity_id)
	arg_1_0.lockState = arg_1_0.lockState and arg_1_0.isOpenTime

	if arg_1_2 % 2 == 0 then
		arg_1_0.lineControlller:SetSelectedState("up")
		arg_1_0.linePosControlller:SetSelectedState("down")
	else
		arg_1_0.lineControlller:SetSelectedState("down")
		arg_1_0.linePosControlller:SetSelectedState("up")
	end

	if arg_1_3 <= arg_1_2 then
		arg_1_0.lineControlller:SetSelectedState("hide")
	end

	arg_1_0.textnumText_.text = "0" .. arg_1_2

	if var_1_0 then
		arg_1_0.text_.text = var_1_0.name
	end

	arg_1_0.passControlller:SetSelectedState(arg_1_0.data.passState and "on" or "off")
	arg_1_0.statusControlller:SetSelectedState(arg_1_0.lockState and "Unlock" or "lock")
	arg_1_0.checkpointnumControlller:SetSelectedState(arg_1_0.lockState and "01" or "02")
	arg_1_0.statusControlller:SetSelectedState(arg_1_0.lockState and "Unlock" or "lock")
	manager.redPoint:unbindUIandKey(arg_1_0.ndpassTrs_.transform)
	manager.redPoint:bindUIandKey(arg_1_0.ndpassTrs_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KALI_GAME_CHANLLENGE, arg_1_0.stageID_))
end

function var_0_0.OnClick(arg_2_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_KALI_GAME_CHANLLENGE, arg_2_0.stageID_), 0)

	local var_2_0 = ActivityKaliStageCfg.all
	local var_2_1 = ActivityConst.ACTIVITY_3_6_KALI_FIGHT

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_2 = ActivityKaliStageCfg[iter_2_1]

		if var_2_2.stage_id == arg_2_0.stageID_ then
			var_2_1 = var_2_2.activity_id
		end
	end

	arg_2_0:Go("SPKailiChallengeSectionView", {
		stageID = arg_2_0.stageID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_SPKALI_CHALLENGE,
		activityID = var_2_1,
		lock = arg_2_0.lockState,
		prePass = arg_2_0.prePass
	})
end

function var_0_0.SetRcommond(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.otherCfg and arg_3_0.otherCfg.recommend or {}

	arg_3_0.goodControlller:SetSelectedState(table.indexof(var_3_0, arg_3_1) and arg_3_0.lockState and "state1" or "state0")
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	manager.redPoint:unbindUIandKey(arg_4_0.ndpassTrs_.transform)
end

return var_0_0
