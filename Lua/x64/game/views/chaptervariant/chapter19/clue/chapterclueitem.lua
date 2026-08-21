local var_0_0 = class("ChapterClueItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.positionController_ = arg_1_0.controllerEx_:GetController("position")
	arg_1_0.geryController_ = arg_1_0.controllerEx_:GetController("get")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.clueID_ = arg_2_1

	if arg_2_1 == 0 then
		arg_2_0.nameText_.text = ""

		arg_2_0.geryController_:SetSelectedState("false")
	else
		local var_2_0 = StageArchiveCfg[arg_2_1]

		arg_2_0.nameText_.text = var_2_0.name

		arg_2_0.geryController_:SetSelectedState("true")
	end

	if arg_2_2 % 2 == 1 then
		arg_2_0.positionController_:SetSelectedState("state0")
	else
		arg_2_0.positionController_:SetSelectedState("state1")
	end
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		if arg_3_0.clueID_ == 0 then
			ShowTips("COLLECTION_CULE_AND_READ")

			return
		end

		JumpTools.OpenPageByJump("stageArchive", {
			isClue = true,
			archiveID = arg_3_0.clueID_
		})
	end)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
