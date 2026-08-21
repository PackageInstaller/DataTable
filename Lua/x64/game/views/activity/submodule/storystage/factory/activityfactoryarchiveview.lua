local var_0_0 = class("ActivityFactoryArchiveView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		if arg_2_0.isLock_ then
			local var_3_0 = BattleActivityStoryStageCfg[arg_2_0.stageID_]

			ShowTips(string.format(GetTips("ACTIVITY_RACE_UNLOCK"), GetI18NText(var_3_0.name)))

			return
		end

		JumpTools.OpenPageByJump("stageArchive", {
			archiveID = arg_2_0.archiveID_
		})
		saveData("StageArchive", "archiveID" .. arg_2_0.archiveID_, true)
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.stageID_ = arg_4_1
	arg_4_0.archiveID_ = arg_4_2
	arg_4_0.isLock_ = arg_4_3

	local var_4_0 = StageArchiveCfg[arg_4_2]

	arg_4_0.nameText_.text = GetI18NText(var_4_0.name)
	arg_4_0.transform_.localPosition = Vector3(var_4_0.position[1], var_4_0.position[2], 0)

	if arg_4_3 then
		arg_4_0.lockController_:SetSelectedState("lock")
	elseif getData("StageArchive", "archiveID" .. arg_4_2) == true then
		arg_4_0.lockController_:SetSelectedState("read")
	else
		arg_4_0.lockController_:SetSelectedState("unlock")
	end

	arg_4_0:Show(true)
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:Show(false)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

return var_0_0
