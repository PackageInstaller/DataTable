local var_0_0 = class("TangramGameShowView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_Tangram/TangramInferencePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.stepController = arg_3_0.controller:GetController("page")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()

	arg_4_0.tipsList = {}
	arg_4_0.titleItemList = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.nextBtn, nil, function()
		if not arg_5_0.isWatch then
			arg_5_0.step = arg_5_0.step + 1

			arg_5_0.stepController:SetSelectedState(string.format("%s_%s", arg_5_0.chapterIndex, tostring(arg_5_0.step)))

			if arg_5_0.step > #arg_5_0.tipsList then
				JumpTools.OpenPageByJump("/tangramGameMainView", {
					chapterID = arg_5_0.chapterID
				})

				return
			end

			arg_5_0:RefreshText()
		else
			arg_5_0:Back()
		end

		arg_5_0:PlaycharacterMoveAni()
	end)
end

function var_0_0.PlaycharacterMoveAni(arg_7_0)
	arg_7_0:AddTween()
end

function var_0_0.AddTween(arg_8_0)
	arg_8_0:RemoveTween()

	local var_8_0 = arg_8_0.characterposTrs_.anchoredPosition.x
	local var_8_1 = arg_8_0.characterTrs_.anchoredPosition.x
	local var_8_2 = arg_8_0.characterTrs_.anchoredPosition.y

	arg_8_0.characterAni_:Play("character_move", -1, 0)
	manager.audio:PlayEffect("minigame_activity_3_5", "minigame_activity_3_5_key_guess_jump", "")

	if var_8_0 - var_8_1 > 0 then
		arg_8_0.characterTrs_.localScale = Vector3(-1, 1, 1)
	else
		arg_8_0.characterTrs_.localScale = Vector3(1, 1, 1)
	end

	local var_8_3 = math.abs(var_8_0 - var_8_1) / 280

	arg_8_0.moveTween = LeanTween.value(0, 1, var_8_3):setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
		local var_9_0 = Vector2(Mathf.Lerp(var_8_1, var_8_0, arg_9_0), var_8_2)

		arg_8_0.characterTrs_.anchoredPosition = var_9_0

		if arg_8_0.characterAni_:GetCurrentAnimatorStateInfo(0).normalizedTime > 1 then
			arg_8_0.characterAni_:Play("character_move", -1, 0)
			manager.audio:PlayEffect("minigame_activity_3_5", "minigame_activity_3_5_key_guess_jump", "")
		end
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_8_0:RemoveTween()
		arg_8_0.characterAni_:Play("character_stop", -1, 0)
	end)):setEase(LeanTweenType.linear)
end

function var_0_0.RemoveTween(arg_11_0)
	if arg_11_0.moveTween then
		arg_11_0.moveTween:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(arg_11_0.moveTween.id)

		arg_11_0.moveTween = nil
	end
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.step = 1
	arg_12_0.stageID = arg_12_0.params_.stageID
	arg_12_0.chapterID = ActivityTangramGameChapterCfg.get_id_list_by_inference_stage_list[arg_12_0.stageID][1]
	arg_12_0.chapterIndex = table.keyof(ActivityTangramGameChapterCfg.all, arg_12_0.chapterID)
	arg_12_0.tipsList = ActivityTangramGameStageCfg[arg_12_0.stageID].conclusion

	arg_12_0:RefreshView()
	arg_12_0:RefreshBar()
	arg_12_0:RefreshTitleText()
	arg_12_0.characterAni_:Play("character_stop", -1, 0)

	arg_12_0.characterTrs_.anchoredPosition = arg_12_0.characterposTrs_.anchoredPosition
	arg_12_0.characterTrs_.localScale = Vector3(1, 1, 1)
end

function var_0_0.RefreshTitleText(arg_13_0)
	local var_13_0 = ActivityTangramGameStageCfg[arg_13_0.stageID].conclusion_list

	for iter_13_0 = 1, #var_13_0 do
		arg_13_0:RefreshTitleItem(iter_13_0)
	end
end

function var_0_0.RefreshTitleItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0[string.format("title%s_%sTrs_", arg_14_0.chapterIndex, arg_14_1)]
	local var_14_1 = ActivityTangramGameStageCfg[arg_14_0.stageID].conclusion_list[arg_14_1]

	for iter_14_0 = 1, var_14_0.childCount do
		local var_14_2 = var_14_1[iter_14_0]

		if var_14_2 then
			local var_14_3 = table.keyof(ActivityTangramGameStageCfg[arg_14_0.stageID].answer, var_14_2)
			local var_14_4 = string.format("%s_%s_%s", arg_14_0.chapterIndex, arg_14_1, iter_14_0)
			local var_14_5 = arg_14_0.titleItemList[var_14_4]

			if not var_14_5 then
				local var_14_6 = var_14_0:GetChild(iter_14_0 - 1)

				SetActive(var_14_0:GetChild(iter_14_0 - 1).gameObject, true)

				var_14_5 = TangramGameShowTitleItem.New(var_14_6)
			end

			arg_14_0.titleItemList[var_14_4] = var_14_5

			var_14_5:RefreshUI(var_14_2, var_14_3)
		else
			SetActive(var_14_0:GetChild(iter_14_0 - 1).gameObject, false)
		end
	end
end

function var_0_0.RefreshView(arg_15_0)
	local var_15_0 = TangramGameData:GetStageInfoByStageID(arg_15_0.stageID)

	if var_15_0 then
		arg_15_0.isWatch = var_15_0:GetInferenceStageWatchPlay()

		if arg_15_0.isWatch then
			if arg_15_0.chapterIndex then
				arg_15_0.stepController:SetSelectedState(string.format("%s_%s", arg_15_0.chapterIndex, tostring(#arg_15_0.tipsList)))

				arg_15_0.result.text = arg_15_0:GetTotalText()

				LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_0.resultTrs_)
			end
		else
			arg_15_0.stepController:SetSelectedState(string.format("%s_%s", arg_15_0.chapterIndex, tostring(arg_15_0.step)))
			arg_15_0:RefreshText()
		end
	end
end

function var_0_0.RefreshText(arg_16_0)
	arg_16_0.desc.text = GetTips(arg_16_0.tipsList[arg_16_0.step])
	arg_16_0.result.text = GetTips(arg_16_0.tipsList[arg_16_0.step])
end

function var_0_0.GetTotalText(arg_17_0)
	local var_17_0 = ""

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.tipsList) do
		var_17_0 = string.format("%s\n%s", var_17_0, GetTips(iter_17_1))
	end

	return var_17_0
end

function var_0_0.OnExit(arg_18_0)
	manager.windowBar:HideBar()
	arg_18_0:RemoveAllEventListener()

	arg_18_0.step = nil
end

function var_0_0.RefreshBar(arg_19_0)
	if arg_19_0.isWatch then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			JumpTools.OpenPageByJump("/tangramGameMainView", {
				chapterID = arg_19_0.chapterID
			})
		end)
	end
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0:RemoveTween()
	var_0_0.super.Dispose(arg_21_0)

	for iter_21_0, iter_21_1 in pairs(arg_21_0.titleItemList) do
		iter_21_1:Dispose()

		iter_21_1 = nil
	end
end

return var_0_0
