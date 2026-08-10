local var_0_0 = class("TangramGameChapterStageView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterID = arg_1_2

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stageItemList = {}
	arg_2_0.stageList = ActivityTangramGameChapterCfg[arg_2_0.chapterID].puzzle_stage_list

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.stageList) do
		arg_2_0.stageItemList[iter_2_1] = {
			btn = arg_2_0["stage" .. iter_2_0 .. "Btn_"],
			controller = arg_2_0["stage" .. iter_2_0 .. "Controllerexcollection_"]:GetController("state"),
			animator = arg_2_0["mask" .. iter_2_0 .. "Go_"].gameObject:GetComponent("Animator"),
			lineAnimator = arg_2_0["line" .. iter_2_0 + 1 .. "Ani_"]
		}
	end

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.stageItemList) do
		arg_3_0:AddBtnListener(iter_3_1.btn, nil, function()
			if TangramGameData:GetStageInfoByStageID(iter_3_0).isFin then
				JumpTools.OpenPageByJump("tangramGameCluePopView", {
					playAni = false,
					stageID = iter_3_0
				})

				return
			end

			TangramGameTools:EnterStage(iter_3_0)
		end)
	end
end

function var_0_0.OnTop(arg_5_0)
	arg_5_0:RefreshStageInfoList()
end

function var_0_0.RefreshStageInfoList(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.stageItemList) do
		local var_6_0, var_6_1 = TangramGameTools:CheckStageIsOpen(iter_6_0)

		if not var_6_0 then
			iter_6_1.controller:SetSelectedState("lock")
		elseif TangramGameData:GetStageInfoByStageID(iter_6_0).isFin then
			iter_6_1.controller:SetSelectedState("clear")
		else
			iter_6_1.controller:SetSelectedState("unlock")
		end
	end
end

function var_0_0.PlayNewChipAni(arg_7_0, arg_7_1)
	if arg_7_0.tangrammap1Ani_ then
		arg_7_0.tangrammap1Ani_:Play("TangramMap1", 0, 1)
	end

	if arg_7_0.tangrammap2Ani_ then
		arg_7_0.tangrammap2Ani_:Play("TangramMap2", 0, 1)
	end

	arg_7_0.stageItemList[arg_7_1].controller:SetSelectedState("unlock")

	if arg_7_0.stageItemList[arg_7_1].animator then
		AnimatorTools.PlayAnimationWithCallback(arg_7_0.stageItemList[arg_7_1].animator, "icon_diss", function()
			arg_7_0.stageItemList[arg_7_1].controller:SetSelectedState("clear")
		end)
	end

	if arg_7_0.stageItemList[arg_7_1].lineAnimator then
		arg_7_0.stageItemList[arg_7_1].lineAnimator:Play("stage_line", 0, 0)
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
