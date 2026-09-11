local TangramGameDecodeView = class("TangramGameDecodeView", ReduxView)

function TangramGameDecodeView:UIName()
	return "Widget/System/Summer2024/Summer2024_Tangram/TangramSortUI"
end

function TangramGameDecodeView:UIParent()
	return manager.ui.uiMain.transform
end

function TangramGameDecodeView:Init()
	self:InitUI()
	self:AddUIListener()

	self.decodeViewList = {}

	for iter_3_0 = 1, 2 do
		self.decodeViewList[iter_3_0] = TangramGameDecodeScrollView.New(self["scrollviewmap" .. iter_3_0 .. "Go_"], ActivityTangramGameChapterCfg.all[iter_3_0], self)
	end

	self.baseTileItemList = {}

	for iter_3_1 = 1, 6 do
		self.baseTileItemList[iter_3_1] = {
			pos = self["stagebase" .. iter_3_1 .. "Go_"].transform.position,
			rect = self["stagebase" .. iter_3_1 .. "Go_"]:GetComponent(typeof(RectTransform)),
			controller = self["stagebase" .. iter_3_1 .. "Controllerexcollection_"]:GetController("wrong")
		}
	end

	self.smallItemList = {}

	for iter_3_2 = 1, 6 do
		self.smallItemList[iter_3_2] = TangramGameSmallstageItem.New(self["stagesmallitem" .. iter_3_2 .. "Go_"], self)

		self.smallItemList[iter_3_2]:AddItemMoveFunc(handler(self, self.StartMoveFunc))
		self.smallItemList[iter_3_2]:AddStartDrag(handler(self, self.StartDrag))
		self.smallItemList[iter_3_2]:AddOnDrag(handler(self, self.OnDrag))
		self.smallItemList[iter_3_2]:EndDrag(handler(self, self.EndDrag))
		self.smallItemList[iter_3_2]:RayPoint(handler(self, self.RayPoint))
		self.smallItemList[iter_3_2]:AddOnClick(handler(self, self.AddOnClick))
	end
end

function TangramGameDecodeView:InitUI()
	self:BindCfgUI()

	self.chacterController = self.characterCon:GetController("face")
	self.chapterController = self.chapterCon:GetController("chapter")
	self.decodeBtnController = self.decodeController:GetController("clear")
end

function TangramGameDecodeView:SendSDK(arg_5_1)
	local var_5_0 = ""

	for iter_5_0, iter_5_1 in pairs((TangramGameData:GetDecodeList())) do
		var_5_0 = iter_5_0 == 1 and string.format("%s", iter_5_1.stageID) or string.format("%s,%s", var_5_0, iter_5_1.stageID)
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = ActivityTangramGameChapterCfg[self.chapterID].activityID,
		stage_id = self.stageID,
		result = arg_5_1 and 1 or 2,
		other_data = string.format("[%s]", var_5_0)
	})
end

function TangramGameDecodeView:AddUIListener()
	self:AddBtnListener(self.reasonBtn, nil, function()
		local var_7_0, var_7_1 = TangramGameData:GetDecodePreocess()

		if var_7_0 < var_7_1 then
			self:StartTimer("ACTIVITY_TANGRAM_GAME_CLUE_NOTALLORDER")

			return
		end

		local var_7_2, var_7_3 = TangramGameData:CheckDecodeResult(self.stageID)

		self:SendSDK(var_7_2)

		if var_7_2 then
			TangramAction:SaveStageProcess(self.stageID, var_7_3, function()
				JumpTools.OpenPageByJump("/tangramGameShowView", {
					stageID = self.stageID
				})
			end)
		else
			self.reasoningbtnAni_:Play("btn_shake")

			self.errorTime = self.errorTime or 0
			self.errorTime = self.errorTime + 1

			if self.errorTime >= ActivityTangramGameChapterCfg[self.chapterID].tips_num then
				manager.audio:PlayEffect("minigame_activity_3_5", "minigame_activity_3_5_key_wrong", "")

				self.showHint = true

				self:RefreshView()
				self:StartTimer(ActivityTangramGameChapterCfg[self.chapterID].conclusion_tips, true)
			else
				self:StartTimer("ACTIVITY_TANGRAM_GAME_CONCLUSION_ERROR_1")
			end
		end
	end)
end

function TangramGameDecodeView:OnEnter()
	self.chacterController:SetSelectedState("state0")

	if self.chapterID ~= self.params_.chapterID then
		self.showHint = false
	end

	self.chapterID = self.params_.chapterID
	self.stageID = ActivityTangramGameChapterCfg[self.chapterID].inference_stage_list[1]
	self.cfg = ActivityTangramGameStageCfg[self.stageID]

	self:RefreshBar()
	self:RefreshView()
	self:RegisterEvents()
	self:RefreshFixedPos()

	if not getData("summer_tangram_decode", "first") then
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = (GameSetting.summer_tangram_describe3 or nil) and (GameSetting.summer_tangram_describe3.value or {})
		})
		saveData("summer_tangram_decode", "first", true)
	end
end

function TangramGameDecodeView:RefreshFixedPos()
	self.fiexdPosList = {}

	for iter_10_0, iter_10_1 in pairs(self.cfg.fixed_pos or {}) do
		if iter_10_1 ~= 0 and TangramGameData:CheckStageIsClear(iter_10_1) then
			self.fiexdPosList[iter_10_0] = iter_10_1

			if self.showHint then
				TangramGameData:AddStageChangeIndex(iter_10_0)
			end

			TangramGameData:AddStageIDInList(iter_10_1, iter_10_0, true)
		end
	end
end

function TangramGameDecodeView:RegisterEvents()
	self:RegistEventListener(TANGRAM_GAME_DECODE_REFRESH, function()
		self:RefreshView()
	end)
	self:RegistEventListener(TANGRAM_GAME_DECODE_NOTFOUND, function()
		self:StartTimer("ACTIVITY_TANGRAM_GAME_CLUE_NOTFOUND")
	end)
end

function TangramGameDecodeView:RefreshView()
	local var_14_0 = table.keyof(ActivityTangramGameChapterCfg.all, self.chapterID)

	if var_14_0 ~= self.index then
		TangramGameData:ResetDecodeList()
	end

	self.index = var_14_0

	self.chapterController:SetSelectedState(tostring(self.index))
	self:RefreshTipsState()
	self:RefreshSmallItemState()
	self:RefreshProcessState()
	self:RefreshTileState()
end

function TangramGameDecodeView:RefreshTileState()
	if self.showHint then
		local var_15_0 = TangramGameData:GetErrorIndexList(self.stageID)

		for iter_15_0, iter_15_1 in ipairs(self.baseTileItemList) do
			local var_15_1 = true

			for iter_15_2, iter_15_3 in ipairs(var_15_0) do
				if iter_15_0 == iter_15_3 then
					var_15_1 = false

					break
				end
			end

			if not var_15_1 then
				self.baseTileItemList[iter_15_0].controller:SetSelectedState("state1")
			else
				self.baseTileItemList[iter_15_0].controller:SetSelectedState("state0")
			end
		end
	else
		for iter_15_4, iter_15_5 in ipairs(self.baseTileItemList) do
			self.baseTileItemList[iter_15_4].controller:SetSelectedState("state0")
		end
	end
end

function TangramGameDecodeView:RefreshProcessState()
	local var_16_0, var_16_1, var_16_2 = TangramGameData:GetChapterFinProcess(self.chapterID)

	self.curNum.text = var_16_1
	self.totalNum.text = "/" .. var_16_2
	self.sliderImg_.fillAmount = var_16_1 / var_16_2

	if var_16_0 then
		self.decodeBtnController:SetSelectedState("state1")
	else
		self.decodeBtnController:SetSelectedState("state0")
	end
end

function TangramGameDecodeView:RefreshTipsState()
	self.decodeViewList[self.index]:RefreshView(self.showHint)

	self.chapterDesc.text = ActivityTangramGameChapterCfg[self.chapterID].chapter_question
end

function TangramGameDecodeView:RefreshSmallItemState()
	if self.smallItemList then
		for iter_18_0, iter_18_1 in ipairs(self.smallItemList) do
			iter_18_1:RefreshUI(self.cfg.ori_pos[iter_18_0])
		end
	end
end

function TangramGameDecodeView:RefreshCurState()
	self.stageInfo = TangramGameData:GetStageInfoByStageID(self.stageID)

	for iter_19_0, iter_19_1 in ipairs(self.decodeItemList) do
		for iter_19_2, iter_19_3 in ipairs(self.stageInfo.finishChipList) do
			if iter_19_1.tipsID == iter_19_3 then
				iter_19_1:SetChooseIndex(iter_19_2)
			end
		end
	end
end

function TangramGameDecodeView:StartDrag(arg_20_1, arg_20_2)
	if not self.edit and not self.fiexdPosList[arg_20_1.index] then
		arg_20_1.move = true
		self.dragStageID = arg_20_1.stageID
		self.canUsePoseIndex = arg_20_1.index
		self.edit = true

		self:UpdateDragPos(arg_20_1)

		local var_20_0 = self:GetCurPosInTile(arg_20_1, arg_20_2)

		if var_20_0 then
			local var_20_1

			for iter_20_0, iter_20_1 in pairs(self.smallItemList) do
				if iter_20_1.index == var_20_0 then
					var_20_1 = iter_20_1

					break
				end
			end

			if var_20_1 then
				self:RayPoint(var_20_1, true)
			end
		end
	end
end

function TangramGameDecodeView:UpdateDragPos(arg_21_1)
	local var_21_0, var_21_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.itemParent.transform, Vector2.New(Input.mousePosition.x, Input.mousePosition.y), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, {})

	arg_21_1.transform_.localPosition = var_21_1
end

function TangramGameDecodeView:OnDrag(arg_22_1)
	if self.edit and self.dragStageID then
		arg_22_1.transform_:SetAsFirstSibling()
		self:UpdateDragPos(arg_22_1)
	end
end

function TangramGameDecodeView:EndDrag(arg_23_1, arg_23_2)
	if self.edit and self.dragStageID then
		self.edit = false

		local var_23_0 = self:GetCurPosInTile(arg_23_1, arg_23_2)
		local var_23_1 = true

		for iter_23_0, iter_23_1 in pairs(self.smallItemList) do
			if iter_23_1.index == var_23_0 then
				var_23_1 = false

				break
			end
		end

		if var_23_0 and (self.fiexdPosList[var_23_0] or nil) and false then
			self.canUsePoseIndex = var_23_0
		end

		if self.canUsePoseIndex then
			self.tweenValue_ = LeanTween.value(0, 1, 0.3):setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
				arg_23_1.transform_.position = Vector3(Mathf.Lerp(arg_23_1.transform_.position.x, self.baseTileItemList[self.canUsePoseIndex].pos.x, arg_24_0), Mathf.Lerp(arg_23_1.transform_.position.y, self.baseTileItemList[self.canUsePoseIndex].pos.y, arg_24_0), Mathf.Lerp(arg_23_1.transform_.position.z, self.baseTileItemList[self.canUsePoseIndex].pos.z, arg_24_0))
			end)):setOnComplete(LuaHelper.VoidAction(function()
				if self.showHint then
					TangramGameData:AddStageChangeIndex(arg_23_1.index, self.canUsePoseIndex)
				end

				TangramGameData:AddStageIDInList(arg_23_1.stageID, self.canUsePoseIndex, true, true)

				arg_23_1.move = false
				arg_23_1.index = self.canUsePoseIndex
				self.dragStageID = nil
				self.edit = false
				self.canUsePoseIndex = nil
			end)):setEase(LeanTweenType.easeOutQuad)
		else
			TangramGameData:AddStageIDInList(arg_23_1.stageID, arg_23_1.index, true)
		end

		return
	end
end

function TangramGameDecodeView:GetCurPosInTile(arg_26_1, arg_26_2)
	local var_26_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	for iter_26_0, iter_26_1 in ipairs(self.baseTileItemList) do
		if UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(iter_26_1.rect, arg_26_2.position, var_26_0) then
			return iter_26_0
		end
	end
end

function TangramGameDecodeView:RayPoint(arg_27_1, arg_27_2)
	if arg_27_1.beginMove and not arg_27_2 then
		return
	end

	if self.edit and self.dragStageID and self.canUsePoseIndex and self.dragStageID ~= arg_27_1.stageID and not arg_27_1.move and not self.fiexdPosList[arg_27_1.index] then
		local var_27_0 = self.canUsePoseIndex

		self.canUsePoseIndex = arg_27_1.index

		if self.showHint then
			TangramGameData:AddStageChangeIndex(arg_27_1.index, self.canUsePoseIndex)
		end

		arg_27_1.beginMove = true
		arg_27_1.index = self.canUsePoseIndex

		TangramGameData:AddStageIDInList(arg_27_1.stageID, self.canUsePoseIndex)

		self.tweenValue_ = LeanTween.value(0, 1, 0.3):setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
			arg_27_1.transform_.position = Vector3(Mathf.Lerp(arg_27_1.transform_.position.x, self.baseTileItemList[var_27_0].pos.x, arg_28_0), Mathf.Lerp(arg_27_1.transform_.position.y, self.baseTileItemList[var_27_0].pos.y, arg_28_0), Mathf.Lerp(arg_27_1.transform_.position.z, self.baseTileItemList[var_27_0].pos.z, arg_28_0))
		end)):setOnComplete(LuaHelper.VoidAction(function()
			arg_27_1.move = false
			arg_27_1.beginMove = false
		end)):setEase(LeanTweenType.easeOutQuad)
	end
end

function TangramGameDecodeView:AddOnClick(arg_30_1)
	if not arg_30_1.move and not self.fiexdPosList[arg_30_1.index] then
		if self.showHint then
			TangramGameData:AddStageChangeIndex(arg_30_1.index)
		end

		TangramGameData:AddStageIDInList(arg_30_1.stageID, arg_30_1.index, true)
	end
end

function TangramGameDecodeView:StartMoveFunc(arg_31_1, arg_31_2, arg_31_3)
	arg_31_2.transform_.position = self.baseTileItemList[arg_31_1].pos
end

function TangramGameDecodeView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:StopTimer()

	for iter_32_0, iter_32_1 in pairs(self.fiexdPosList) do
		TangramGameData:AddStageIDInList(iter_32_1, iter_32_0)
	end
end

function TangramGameDecodeView:OnTop()
	self:RefreshBar()
end

function TangramGameDecodeView:RefreshBar()
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

	if GameSetting.summer_tangram_describe3 then
		local var_34_0 = GameSetting.summer_tangram_describe3.value or {}
	end

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_34_0
		})
	end)
end

function TangramGameDecodeView:StartTimer(arg_38_1, arg_38_2)
	self:StopTimer()

	if arg_38_2 then
		self.chacterController:SetSelectedState("state1")
	else
		self.chacterController:SetSelectedState("justText")
	end

	self.hintText.text = GetTips(arg_38_1)
	self.timer = Timer.New(function()
		self.chacterController:SetSelectedState("state0")
		self:StopTimer()
	end, 2, 1)

	self.timer:Start()
end

function TangramGameDecodeView:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function TangramGameDecodeView:Dispose()
	self:StopTimer()

	if self.decodeViewList then
		for iter_41_0, iter_41_1 in pairs(self.decodeViewList) do
			iter_41_1:Dispose()
		end
	end

	if self.smallItemList then
		for iter_41_2, iter_41_3 in pairs(self.smallItemList) do
			iter_41_3:Dispose()
		end
	end

	TangramGameDecodeView.super.Dispose(self)
end

return TangramGameDecodeView
