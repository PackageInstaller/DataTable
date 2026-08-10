local var_0_0 = class("TugGameItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.statusControlller = arg_1_0.checkpointitemControllerexcollection_:GetController("status")
	arg_1_0.checkpointnumControlller = arg_1_0.checkpointitemControllerexcollection_:GetController("checkpointnum")
	arg_1_0.selectControlller = arg_1_0.checkpointitemControllerexcollection_:GetController("select")
	arg_1_0.passControlller = arg_1_0.checkpointitemControllerexcollection_:GetController("pass")
	arg_1_0.lineControlller = arg_1_0.checkpointitemControllerexcollection_:GetController("line")
	arg_1_0.linePosControlller = arg_1_0.checkpointitemControllerexcollection_:GetController("linePos")
	arg_1_0.goodControlller = arg_1_0.checkpointitemControllerexcollection_:GetController("good")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.itemBtn_, nil, function()
		arg_2_0.ctrl:SetSelect(arg_2_0.index)

		arg_2_0.ctrl.uilistSr_.enabled = false

		arg_2_0:OnClick()
	end)
end

function var_0_0.OnClick(arg_4_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_KALI_GAME_TUG, arg_4_0.stageID_), 0)
	arg_4_0:Go("SPKailiTugSectionView", {
		activityID = arg_4_0.activityID,
		stageID = arg_4_0.stageID_,
		lock = arg_4_0.lockState,
		prePass = arg_4_0.prePass
	})
end

function var_0_0.SetActivityID(arg_5_0, arg_5_1)
	arg_5_0.activityID = arg_5_1
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.data = arg_6_1
	arg_6_0.stageID_ = arg_6_0.data.id
	arg_6_0.index = arg_6_2
	arg_6_0.ctrl = arg_6_4

	local var_6_0 = ActivityKaliGameStageCfg[arg_6_0.stageID_]

	arg_6_0.lockState = arg_6_0.data and arg_6_0.data.unlockIndex >= arg_6_0.index

	if arg_6_0.data.unlockIndex >= arg_6_0.index - 1 then
		arg_6_0.lockState = true
	end

	arg_6_0.prePass = arg_6_0.lockState
	arg_6_0.isOpenTime = ActivityData:GetActivityIsOpen(var_6_0.activity_id)
	arg_6_0.lockState = arg_6_0.lockState and arg_6_0.isOpenTime

	if arg_6_2 % 2 == 0 then
		arg_6_0.lineControlller:SetSelectedState("up")
		arg_6_0.linePosControlller:SetSelectedState("down")
	else
		arg_6_0.lineControlller:SetSelectedState("down")
		arg_6_0.linePosControlller:SetSelectedState("up")
	end

	if arg_6_3 <= arg_6_2 then
		arg_6_0.lineControlller:SetSelectedState("hide")
	end

	arg_6_0.textnumText_.text = "0" .. arg_6_2

	if var_6_0 then
		arg_6_0.text_.text = var_6_0.name
	end

	arg_6_0.passControlller:SetSelectedState(arg_6_0.data.passState and "on" or "off")
	arg_6_0.statusControlller:SetSelectedState(arg_6_0.lockState and "Unlock" or "lock")
	arg_6_0.checkpointnumControlller:SetSelectedState(arg_6_0.lockState and "01" or "02")
	manager.redPoint:unbindUIandKey(arg_6_0.ndpassTrs_.transform)
	manager.redPoint:bindUIandKey(arg_6_0.ndpassTrs_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KALI_GAME_TUG, arg_6_0.stageID_))
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	arg_7_0.lockState = arg_7_0.data and arg_7_0.data.unlockIndex >= arg_7_0.index

	if arg_7_0.data.unlockIndex >= arg_7_0.index - 1 then
		arg_7_0.lockState = true
	end

	arg_7_0.lockState = arg_7_0.lockState and arg_7_0.isOpenTime

	if arg_7_1 then
		if arg_7_0.lockState then
			arg_7_0.selectControlller:SetSelectedState("onray")
			arg_7_0.statusControlller:SetSelectedState("selectunlock")
			arg_7_0.checkpointnumControlller:SetSelectedState("03")
		else
			arg_7_0.selectControlller:SetSelectedState("on")
			arg_7_0.statusControlller:SetSelectedState(arg_7_0.lockState and "Unlock" or "lock")
			arg_7_0.checkpointnumControlller:SetSelectedState(arg_7_0.lockState and "01" or "02")
		end
	else
		arg_7_0.statusControlller:SetSelectedState(arg_7_0.lockState and "Unlock" or "lock")
		arg_7_0.checkpointnumControlller:SetSelectedState(arg_7_0.lockState and "01" or "02")
		arg_7_0.selectControlller:SetSelectedState("off")
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.ndpassTrs_.transform)
end

return var_0_0
