local TangramGameShowView = class("TangramGameShowView", ReduxView)

function TangramGameShowView:UIName()
	return "Widget/System/Summer2024/Summer2024_Tangram/TangramInferencePopUI"
end

function TangramGameShowView:UIParent()
	return manager.ui.uiMain.transform
end

function TangramGameShowView:Init()
	self:InitUI()

	self.stepController = self.controller:GetController("page")
end

function TangramGameShowView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.tipsList = {}
	self.titleItemList = {}
end

function TangramGameShowView:AddUIListener()
	self:AddBtnListener(self.nextBtn, nil, function()
		if not self.isWatch then
			self.step = self.step + 1

			self.stepController:SetSelectedState(string.format("%s_%s", self.chapterIndex, tostring(self.step)))

			if self.step > #self.tipsList then
				JumpTools.OpenPageByJump("/tangramGameMainView", {
					chapterID = self.chapterID
				})

				return
			end

			self:RefreshText()
		else
			self:Back()
		end

		self:PlaycharacterMoveAni()
	end)
end

function TangramGameShowView:PlaycharacterMoveAni()
	self:AddTween()
end

function TangramGameShowView:AddTween()
	self:RemoveTween()

	local var_8_0 = self.characterposTrs_.anchoredPosition.x
	local var_8_1 = self.characterTrs_.anchoredPosition.x
	local var_8_2 = self.characterTrs_.anchoredPosition.y

	self.characterAni_:Play("character_move", -1, 0)
	manager.audio:PlayEffect("minigame_activity_3_5", "minigame_activity_3_5_key_guess_jump", "")

	self.characterTrs_.localScale = var_8_0 - var_8_1 > 0 and Vector3(-1, 1, 1) or Vector3(1, 1, 1)
	self.moveTween = LeanTween.value(0, 1, math.abs(var_8_0 - var_8_1) / 280):setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
		self.characterTrs_.anchoredPosition = Vector2(Mathf.Lerp(var_8_1, var_8_0, arg_9_0), var_8_2)

		if self.characterAni_:GetCurrentAnimatorStateInfo(0).normalizedTime > 1 then
			self.characterAni_:Play("character_move", -1, 0)
			manager.audio:PlayEffect("minigame_activity_3_5", "minigame_activity_3_5_key_guess_jump", "")
		end
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self:RemoveTween()
		self.characterAni_:Play("character_stop", -1, 0)
	end)):setEase(LeanTweenType.linear)
end

function TangramGameShowView:RemoveTween()
	if self.moveTween then
		self.moveTween:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(self.moveTween.id)

		self.moveTween = nil
	end
end

function TangramGameShowView:OnEnter()
	self.step = 1
	self.stageID = self.params_.stageID
	self.chapterID = ActivityTangramGameChapterCfg.get_id_list_by_inference_stage_list[self.stageID][1]
	self.chapterIndex = table.keyof(ActivityTangramGameChapterCfg.all, self.chapterID)
	self.tipsList = ActivityTangramGameStageCfg[self.stageID].conclusion

	self:RefreshView()
	self:RefreshBar()
	self:RefreshTitleText()
	self.characterAni_:Play("character_stop", -1, 0)

	self.characterTrs_.anchoredPosition = self.characterposTrs_.anchoredPosition
	self.characterTrs_.localScale = Vector3(1, 1, 1)
end

function TangramGameShowView:RefreshTitleText()
	for iter_13_0 = 1, #ActivityTangramGameStageCfg[self.stageID].conclusion_list do
		self:RefreshTitleItem(iter_13_0)
	end
end

function TangramGameShowView:RefreshTitleItem(arg_14_1)
	local var_14_0 = self[string.format("title%s_%sTrs_", self.chapterIndex, arg_14_1)]

	for iter_14_0 = 1, var_14_0.childCount do
		if ActivityTangramGameStageCfg[self.stageID].conclusion_list[arg_14_1][iter_14_0] then
			local var_14_1 = table.keyof(ActivityTangramGameStageCfg[self.stageID].answer, ActivityTangramGameStageCfg[self.stageID].conclusion_list[arg_14_1][iter_14_0])
			local var_14_2 = string.format("%s_%s_%s", self.chapterIndex, arg_14_1, iter_14_0)
			local var_14_3 = self.titleItemList[var_14_2]

			if not self.titleItemList[var_14_2] then
				local var_14_4 = var_14_0:GetChild(iter_14_0 - 1)

				SetActive(var_14_0:GetChild(iter_14_0 - 1).gameObject, true)

				var_14_3 = TangramGameShowTitleItem.New(var_14_4)
			end

			self.titleItemList[var_14_2] = var_14_3

			var_14_3:RefreshUI(ActivityTangramGameStageCfg[self.stageID].conclusion_list[arg_14_1][iter_14_0], var_14_1)
		else
			SetActive(var_14_0:GetChild(iter_14_0 - 1).gameObject, false)
		end
	end
end

function TangramGameShowView:RefreshView()
	local var_15_0 = TangramGameData:GetStageInfoByStageID(self.stageID)

	if var_15_0 then
		self.isWatch = var_15_0:GetInferenceStageWatchPlay()

		if self.isWatch then
			if self.chapterIndex then
				self.stepController:SetSelectedState(string.format("%s_%s", self.chapterIndex, tostring(#self.tipsList)))

				self.result.text = self:GetTotalText()

				LayoutRebuilder.ForceRebuildLayoutImmediate(self.resultTrs_)
			end
		else
			self.stepController:SetSelectedState(string.format("%s_%s", self.chapterIndex, tostring(self.step)))
			self:RefreshText()
		end
	end
end

function TangramGameShowView:RefreshText()
	self.desc.text = GetTips(self.tipsList[self.step])
	self.result.text = GetTips(self.tipsList[self.step])
end

function TangramGameShowView:GetTotalText()
	local var_17_0 = ""

	for iter_17_0, iter_17_1 in ipairs(self.tipsList) do
		var_17_0 = string.format("%s\n%s", var_17_0, GetTips(iter_17_1))
	end

	return var_17_0
end

function TangramGameShowView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()

	self.step = nil
end

function TangramGameShowView:RefreshBar()
	if self.isWatch then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			JumpTools.OpenPageByJump("/tangramGameMainView", {
				chapterID = self.chapterID
			})
		end)
	end
end

function TangramGameShowView:Dispose()
	self:RemoveTween()
	TangramGameShowView.super.Dispose(self)

	for iter_21_0, iter_21_1 in pairs(self.titleItemList) do
		iter_21_1:Dispose()

		iter_21_1 = nil
	end
end

return TangramGameShowView
