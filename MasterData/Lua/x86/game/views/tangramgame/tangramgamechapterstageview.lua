local TangramGameChapterStageView = class("TangramGameChapterStageView", ReduxView)

function TangramGameChapterStageView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterID = arg_1_2

	self:InitUI()
end

function TangramGameChapterStageView:InitUI()
	self:BindCfgUI()

	self.stageItemList = {}
	self.stageList = ActivityTangramGameChapterCfg[self.chapterID].puzzle_stage_list

	for iter_2_0, iter_2_1 in ipairs(self.stageList) do
		self.stageItemList[iter_2_1] = {
			btn = self["stage" .. iter_2_0 .. "Btn_"],
			controller = self["stage" .. iter_2_0 .. "Controllerexcollection_"]:GetController("state"),
			animator = self["mask" .. iter_2_0 .. "Go_"].gameObject:GetComponent("Animator"),
			lineAnimator = self["line" .. iter_2_0 + 1 .. "Ani_"]
		}
	end

	self:AddUIListener()
end

function TangramGameChapterStageView:AddUIListener()
	for iter_3_0, iter_3_1 in pairs(self.stageItemList) do
		self:AddBtnListener(iter_3_1.btn, nil, function()
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

function TangramGameChapterStageView:OnTop()
	self:RefreshStageInfoList()
end

function TangramGameChapterStageView:RefreshStageInfoList()
	for iter_6_0, iter_6_1 in pairs(self.stageItemList) do
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

function TangramGameChapterStageView:PlayNewChipAni(arg_7_1)
	if self.tangrammap1Ani_ then
		self.tangrammap1Ani_:Play("TangramMap1", 0, 1)
	end

	if self.tangrammap2Ani_ then
		self.tangrammap2Ani_:Play("TangramMap2", 0, 1)
	end

	self.stageItemList[arg_7_1].controller:SetSelectedState("unlock")

	if self.stageItemList[arg_7_1].animator then
		AnimatorTools.PlayAnimationWithCallback(self.stageItemList[arg_7_1].animator, "icon_diss", function()
			self.stageItemList[arg_7_1].controller:SetSelectedState("clear")
		end)
	end

	if self.stageItemList[arg_7_1].lineAnimator then
		self.stageItemList[arg_7_1].lineAnimator:Play("stage_line", 0, 0)
	end
end

function TangramGameChapterStageView:Dispose()
	TangramGameChapterStageView.super.Dispose(self)
end

return TangramGameChapterStageView
