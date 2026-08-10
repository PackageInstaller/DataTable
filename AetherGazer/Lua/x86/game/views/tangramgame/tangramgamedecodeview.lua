local var_0_0 = class("TangramGameDecodeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_Tangram/TangramSortUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.decodeViewList = {}

	for iter_3_0 = 1, 2 do
		arg_3_0.decodeViewList[iter_3_0] = TangramGameDecodeScrollView.New(arg_3_0["scrollviewmap" .. iter_3_0 .. "Go_"], ActivityTangramGameChapterCfg.all[iter_3_0], arg_3_0)
	end

	arg_3_0.baseTileItemList = {}

	for iter_3_1 = 1, 6 do
		arg_3_0.baseTileItemList[iter_3_1] = {
			pos = arg_3_0["stagebase" .. iter_3_1 .. "Go_"].transform.position,
			rect = arg_3_0["stagebase" .. iter_3_1 .. "Go_"]:GetComponent(typeof(RectTransform)),
			controller = arg_3_0["stagebase" .. iter_3_1 .. "Controllerexcollection_"]:GetController("wrong")
		}
	end

	arg_3_0.smallItemList = {}

	for iter_3_2 = 1, 6 do
		arg_3_0.smallItemList[iter_3_2] = TangramGameSmallstageItem.New(arg_3_0["stagesmallitem" .. iter_3_2 .. "Go_"], arg_3_0)

		arg_3_0.smallItemList[iter_3_2]:AddItemMoveFunc(handler(arg_3_0, arg_3_0.StartMoveFunc))
		arg_3_0.smallItemList[iter_3_2]:AddStartDrag(handler(arg_3_0, arg_3_0.StartDrag))
		arg_3_0.smallItemList[iter_3_2]:AddOnDrag(handler(arg_3_0, arg_3_0.OnDrag))
		arg_3_0.smallItemList[iter_3_2]:EndDrag(handler(arg_3_0, arg_3_0.EndDrag))
		arg_3_0.smallItemList[iter_3_2]:RayPoint(handler(arg_3_0, arg_3_0.RayPoint))
		arg_3_0.smallItemList[iter_3_2]:AddOnClick(handler(arg_3_0, arg_3_0.AddOnClick))
	end
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.chacterController = arg_4_0.characterCon:GetController("face")
	arg_4_0.chapterController = arg_4_0.chapterCon:GetController("chapter")
	arg_4_0.decodeBtnController = arg_4_0.decodeController:GetController("clear")
end

function var_0_0.SendSDK(arg_5_0, arg_5_1)
	local var_5_0 = ""
	local var_5_1 = TangramGameData:GetDecodeList()

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		local var_5_2 = iter_5_1.stageID

		if iter_5_0 == 1 then
			var_5_0 = string.format("%s", var_5_2)
		else
			var_5_0 = string.format("%s,%s", var_5_0, var_5_2)
		end
	end

	local var_5_3 = string.format("[%s]", var_5_0)

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = ActivityTangramGameChapterCfg[arg_5_0.chapterID].activityID,
		stage_id = arg_5_0.stageID,
		result = arg_5_1 and 1 or 2,
		other_data = var_5_3
	})
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.reasonBtn, nil, function()
		local var_7_0, var_7_1 = TangramGameData:GetDecodePreocess()

		if var_7_0 < var_7_1 then
			arg_6_0:StartTimer("ACTIVITY_TANGRAM_GAME_CLUE_NOTALLORDER")

			return
		end

		local var_7_2, var_7_3 = TangramGameData:CheckDecodeResult(arg_6_0.stageID)

		arg_6_0:SendSDK(var_7_2)

		if var_7_2 then
			TangramAction:SaveStageProcess(arg_6_0.stageID, var_7_3, function()
				JumpTools.OpenPageByJump("/tangramGameShowView", {
					stageID = arg_6_0.stageID
				})
			end)
		else
			arg_6_0.reasoningbtnAni_:Play("btn_shake")

			arg_6_0.errorTime = arg_6_0.errorTime or 0
			arg_6_0.errorTime = arg_6_0.errorTime + 1

			if arg_6_0.errorTime >= ActivityTangramGameChapterCfg[arg_6_0.chapterID].tips_num then
				manager.audio:PlayEffect("minigame_activity_3_5", "minigame_activity_3_5_key_wrong", "")

				arg_6_0.showHint = true

				arg_6_0:RefreshView()
				arg_6_0:StartTimer(ActivityTangramGameChapterCfg[arg_6_0.chapterID].conclusion_tips, true)
			else
				arg_6_0:StartTimer("ACTIVITY_TANGRAM_GAME_CONCLUSION_ERROR_1")
			end
		end
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.chacterController:SetSelectedState("state0")

	if arg_9_0.chapterID ~= arg_9_0.params_.chapterID then
		arg_9_0.showHint = false
	end

	arg_9_0.chapterID = arg_9_0.params_.chapterID
	arg_9_0.stageID = ActivityTangramGameChapterCfg[arg_9_0.chapterID].inference_stage_list[1]
	arg_9_0.cfg = ActivityTangramGameStageCfg[arg_9_0.stageID]

	arg_9_0:RefreshBar()
	arg_9_0:RefreshView()
	arg_9_0:RegisterEvents()
	arg_9_0:RefreshFixedPos()

	if not getData("summer_tangram_decode", "first") then
		local var_9_0 = GameSetting.summer_tangram_describe3 and GameSetting.summer_tangram_describe3.value or {}

		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_9_0
		})
		saveData("summer_tangram_decode", "first", true)
	end
end

function var_0_0.RefreshFixedPos(arg_10_0)
	arg_10_0.fiexdPosList = {}

	local var_10_0 = arg_10_0.cfg.fixed_pos

	for iter_10_0, iter_10_1 in pairs(var_10_0 or {}) do
		if iter_10_1 ~= 0 and TangramGameData:CheckStageIsClear(iter_10_1) then
			arg_10_0.fiexdPosList[iter_10_0] = iter_10_1

			if arg_10_0.showHint then
				TangramGameData:AddStageChangeIndex(iter_10_0)
			end

			TangramGameData:AddStageIDInList(iter_10_1, iter_10_0, true)
		end
	end
end

function var_0_0.RegisterEvents(arg_11_0)
	arg_11_0:RegistEventListener(TANGRAM_GAME_DECODE_REFRESH, function()
		arg_11_0:RefreshView()
	end)
	arg_11_0:RegistEventListener(TANGRAM_GAME_DECODE_NOTFOUND, function()
		arg_11_0:StartTimer("ACTIVITY_TANGRAM_GAME_CLUE_NOTFOUND")
	end)
end

function var_0_0.RefreshView(arg_14_0)
	local var_14_0 = table.keyof(ActivityTangramGameChapterCfg.all, arg_14_0.chapterID)

	if var_14_0 ~= arg_14_0.index then
		TangramGameData:ResetDecodeList()
	end

	arg_14_0.index = var_14_0

	arg_14_0.chapterController:SetSelectedState(tostring(arg_14_0.index))
	arg_14_0:RefreshTipsState()
	arg_14_0:RefreshSmallItemState()
	arg_14_0:RefreshProcessState()
	arg_14_0:RefreshTileState()
end

function var_0_0.RefreshTileState(arg_15_0)
	if arg_15_0.showHint then
		local var_15_0 = TangramGameData:GetErrorIndexList(arg_15_0.stageID)

		for iter_15_0, iter_15_1 in ipairs(arg_15_0.baseTileItemList) do
			local var_15_1 = true

			for iter_15_2, iter_15_3 in ipairs(var_15_0) do
				if iter_15_0 == iter_15_3 then
					var_15_1 = false

					break
				end
			end

			if not var_15_1 then
				arg_15_0.baseTileItemList[iter_15_0].controller:SetSelectedState("state1")
			else
				arg_15_0.baseTileItemList[iter_15_0].controller:SetSelectedState("state0")
			end
		end
	else
		for iter_15_4, iter_15_5 in ipairs(arg_15_0.baseTileItemList) do
			arg_15_0.baseTileItemList[iter_15_4].controller:SetSelectedState("state0")
		end
	end
end

function var_0_0.RefreshProcessState(arg_16_0)
	local var_16_0, var_16_1, var_16_2 = TangramGameData:GetChapterFinProcess(arg_16_0.chapterID)

	arg_16_0.curNum.text = var_16_1
	arg_16_0.totalNum.text = "/" .. var_16_2
	arg_16_0.sliderImg_.fillAmount = var_16_1 / var_16_2

	if var_16_0 then
		arg_16_0.decodeBtnController:SetSelectedState("state1")
	else
		arg_16_0.decodeBtnController:SetSelectedState("state0")
	end
end

function var_0_0.RefreshTipsState(arg_17_0)
	arg_17_0.decodeViewList[arg_17_0.index]:RefreshView(arg_17_0.showHint)

	arg_17_0.chapterDesc.text = ActivityTangramGameChapterCfg[arg_17_0.chapterID].chapter_question
end

function var_0_0.RefreshSmallItemState(arg_18_0)
	if arg_18_0.smallItemList then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0.smallItemList) do
			iter_18_1:RefreshUI(arg_18_0.cfg.ori_pos[iter_18_0])
		end
	end
end

function var_0_0.RefreshCurState(arg_19_0)
	arg_19_0.stageInfo = TangramGameData:GetStageInfoByStageID(arg_19_0.stageID)

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.decodeItemList) do
		for iter_19_2, iter_19_3 in ipairs(arg_19_0.stageInfo.finishChipList) do
			if iter_19_1.tipsID == iter_19_3 then
				iter_19_1:SetChooseIndex(iter_19_2)
			end
		end
	end
end

function var_0_0.StartDrag(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0.edit and not arg_20_0.fiexdPosList[arg_20_1.index] then
		arg_20_1.move = true
		arg_20_0.dragStageID = arg_20_1.stageID
		arg_20_0.canUsePoseIndex = arg_20_1.index
		arg_20_0.edit = true

		arg_20_0:UpdateDragPos(arg_20_1)

		local var_20_0 = arg_20_0:GetCurPosInTile(arg_20_1, arg_20_2)

		if var_20_0 then
			local var_20_1

			for iter_20_0, iter_20_1 in pairs(arg_20_0.smallItemList) do
				if iter_20_1.index == var_20_0 then
					var_20_1 = iter_20_1

					break
				end
			end

			if var_20_1 then
				arg_20_0:RayPoint(var_20_1, true)
			end
		end
	end
end

function var_0_0.UpdateDragPos(arg_21_0, arg_21_1)
	local var_21_0 = Vector2.New(Input.mousePosition.x, Input.mousePosition.y)
	local var_21_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_21_2 = {}
	local var_21_3, var_21_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_21_0.itemParent.transform, var_21_0, var_21_1, var_21_2)

	arg_21_1.transform_.localPosition = var_21_4
end

function var_0_0.OnDrag(arg_22_0, arg_22_1)
	if arg_22_0.edit and arg_22_0.dragStageID then
		arg_22_1.transform_:SetAsFirstSibling()
		arg_22_0:UpdateDragPos(arg_22_1)
	end
end

function var_0_0.EndDrag(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.edit and arg_23_0.dragStageID then
		arg_23_0.edit = false

		local var_23_0 = arg_23_0:GetCurPosInTile(arg_23_1, arg_23_2)
		local var_23_1 = true

		for iter_23_0, iter_23_1 in pairs(arg_23_0.smallItemList) do
			if iter_23_1.index == var_23_0 then
				var_23_1 = false

				break
			end
		end

		if arg_23_0.fiexdPosList[var_23_0] then
			var_23_1 = false
		end

		if var_23_0 and var_23_1 then
			arg_23_0.canUsePoseIndex = var_23_0
		end

		if arg_23_0.canUsePoseIndex then
			arg_23_0.tweenValue_ = LeanTween.value(0, 1, 0.3):setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
				local var_24_0 = Vector3(Mathf.Lerp(arg_23_1.transform_.position.x, arg_23_0.baseTileItemList[arg_23_0.canUsePoseIndex].pos.x, arg_24_0), Mathf.Lerp(arg_23_1.transform_.position.y, arg_23_0.baseTileItemList[arg_23_0.canUsePoseIndex].pos.y, arg_24_0), Mathf.Lerp(arg_23_1.transform_.position.z, arg_23_0.baseTileItemList[arg_23_0.canUsePoseIndex].pos.z, arg_24_0))

				arg_23_1.transform_.position = var_24_0
			end)):setOnComplete(LuaHelper.VoidAction(function()
				if arg_23_0.showHint then
					TangramGameData:AddStageChangeIndex(arg_23_1.index, arg_23_0.canUsePoseIndex)
				end

				TangramGameData:AddStageIDInList(arg_23_1.stageID, arg_23_0.canUsePoseIndex, true, true)

				arg_23_1.move = false
				arg_23_1.index = arg_23_0.canUsePoseIndex
				arg_23_0.dragStageID = nil
				arg_23_0.edit = false
				arg_23_0.canUsePoseIndex = nil
			end)):setEase(LeanTweenType.easeOutQuad)
		else
			TangramGameData:AddStageIDInList(arg_23_1.stageID, arg_23_1.index, true)
		end

		return
	end
end

function var_0_0.GetCurPosInTile(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_26_1 = arg_26_2.position

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.baseTileItemList) do
		if UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(iter_26_1.rect, var_26_1, var_26_0) then
			return iter_26_0
		end
	end
end

function var_0_0.RayPoint(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1.beginMove and not arg_27_2 then
		return
	end

	if arg_27_0.edit and arg_27_0.dragStageID and arg_27_0.canUsePoseIndex and arg_27_0.dragStageID ~= arg_27_1.stageID and not arg_27_1.move and not arg_27_0.fiexdPosList[arg_27_1.index] then
		local var_27_0 = arg_27_0.canUsePoseIndex

		arg_27_0.canUsePoseIndex = arg_27_1.index

		if arg_27_0.showHint then
			TangramGameData:AddStageChangeIndex(arg_27_1.index, arg_27_0.canUsePoseIndex)
		end

		arg_27_1.beginMove = true
		arg_27_1.index = var_27_0

		TangramGameData:AddStageIDInList(arg_27_1.stageID, var_27_0)

		arg_27_0.tweenValue_ = LeanTween.value(0, 1, 0.3):setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
			local var_28_0 = Vector3(Mathf.Lerp(arg_27_1.transform_.position.x, arg_27_0.baseTileItemList[var_27_0].pos.x, arg_28_0), Mathf.Lerp(arg_27_1.transform_.position.y, arg_27_0.baseTileItemList[var_27_0].pos.y, arg_28_0), Mathf.Lerp(arg_27_1.transform_.position.z, arg_27_0.baseTileItemList[var_27_0].pos.z, arg_28_0))

			arg_27_1.transform_.position = var_28_0
		end)):setOnComplete(LuaHelper.VoidAction(function()
			arg_27_1.move = false
			arg_27_1.beginMove = false
		end)):setEase(LeanTweenType.easeOutQuad)
	end
end

function var_0_0.AddOnClick(arg_30_0, arg_30_1)
	if not arg_30_1.move and not arg_30_0.fiexdPosList[arg_30_1.index] then
		if arg_30_0.showHint then
			TangramGameData:AddStageChangeIndex(arg_30_1.index)
		end

		TangramGameData:AddStageIDInList(arg_30_1.stageID, arg_30_1.index, true)
	end
end

function var_0_0.StartMoveFunc(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	arg_31_2.transform_.position = arg_31_0.baseTileItemList[arg_31_1].pos
end

function var_0_0.OnExit(arg_32_0)
	manager.windowBar:HideBar()
	arg_32_0:RemoveAllEventListener()
	arg_32_0:StopTimer()

	for iter_32_0, iter_32_1 in pairs(arg_32_0.fiexdPosList) do
		TangramGameData:AddStageIDInList(iter_32_1, iter_32_0)
	end
end

function var_0_0.OnTop(arg_33_0)
	arg_33_0:RefreshBar()
end

function var_0_0.RefreshBar(arg_34_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/tangramGameMainView")
	end)
	manager.windowBar:RegistHomeCallBack(function()
		JumpTools.OpenPageByJump("/tangramGameMainView")
	end)

	local var_34_0 = GameSetting.summer_tangram_describe3 and GameSetting.summer_tangram_describe3.value or {}

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_34_0
		})
	end)
end

function var_0_0.StartTimer(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0:StopTimer()

	if arg_38_2 then
		arg_38_0.chacterController:SetSelectedState("state1")
	else
		arg_38_0.chacterController:SetSelectedState("justText")
	end

	arg_38_0.hintText.text = GetTips(arg_38_1)
	arg_38_0.timer = Timer.New(function()
		arg_38_0.chacterController:SetSelectedState("state0")
		arg_38_0:StopTimer()
	end, 2, 1)

	arg_38_0.timer:Start()
end

function var_0_0.StopTimer(arg_40_0)
	if arg_40_0.timer then
		arg_40_0.timer:Stop()

		arg_40_0.timer = nil
	end
end

function var_0_0.Dispose(arg_41_0)
	arg_41_0:StopTimer()

	if arg_41_0.decodeViewList then
		for iter_41_0, iter_41_1 in pairs(arg_41_0.decodeViewList) do
			iter_41_1:Dispose()
		end
	end

	if arg_41_0.smallItemList then
		for iter_41_2, iter_41_3 in pairs(arg_41_0.smallItemList) do
			iter_41_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_41_0)
end

return var_0_0
