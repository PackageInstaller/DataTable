local TetrisGameChooseStageItem = class("TetrisGameChooseStageItem", ReduxView)

function TetrisGameChooseStageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.rectTransform = arg_1_1:GetComponent("RectTransform")

	self:Init()
end

function TetrisGameChooseStageItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function TetrisGameChooseStageItem:InitUI()
	self:BindCfgUI()

	self.statusController = self.controller:GetController("state")
	self.selController = self.controller:GetController("sel")
	self.chapterController = self.controller:GetController("chapter")
	self.skillShowController = self.controller:GetController("skill")
	self.animator = self.gameObject_:GetComponent("Animator")
	self.skillItemList = {}

	for iter_3_0 = 1, 2 do
		self.skillItemList[iter_3_0] = TetrisGameSkillIconItem.New(self["skillObj" .. iter_3_0])

		self.skillItemList[iter_3_0]:RegisterClickFunc(handler(self, self.ClickSkillItem))
	end
end

function TetrisGameChooseStageItem:ClickSkillItem(arg_4_1)
	JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
		stageID = self.stageID,
		skillID = arg_4_1
	})
end

function TetrisGameChooseStageItem:RefreshUI(arg_5_1, arg_5_2, arg_5_3)
	self.stageID = arg_5_1

	if self.stageID then
		self.stageName.text = ActivityTetrisGameStageCfg[arg_5_1].desc
	end

	if self.stageID == arg_5_2 then
		self.selController:SetSelectedState("on")
	else
		self.selController:SetSelectedState("off")
	end

	local var_5_0, var_5_1 = TetrisGameTools:GetStageState(self.stageID)

	if var_5_0 == "lock" then
		self.statusController:SetSelectedState("lock")
	elseif var_5_0 == "finish" then
		self.statusController:SetSelectedState("finish")
	else
		self.statusController:SetSelectedState("normal")
	end

	self.chapterController:SetSelectedState(tostring(arg_5_3))
	self:UpdataRedPoint()

	for iter_5_0 = 1, 2 do
		if ActivityTetrisGameStageCfg[arg_5_1].skill_list[iter_5_0] then
			SetActive(self.skillItemList[iter_5_0].gameObject_, true)
			self.skillItemList[iter_5_0]:RefreshUI(ActivityTetrisGameStageCfg[arg_5_1].skill_list[iter_5_0])
		else
			SetActive(self.skillItemList[iter_5_0].gameObject_, false)
		end
	end

	if #ActivityTetrisGameStageCfg[arg_5_1].skill_list == 0 then
		self.skillShowController:SetSelectedState("hide")
	else
		self.skillShowController:SetSelectedState("show")
	end
end

function TetrisGameChooseStageItem:AddUIListener()
	self:AddBtnListener(self.clickBtn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.stageID)
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_STAGE, self.stageID), 0)
	end)
end

function TetrisGameChooseStageItem:PlayAni(arg_8_1)
	if self.animator then
		if arg_8_1 then
			self.animator:Play("UI_ItemA01_cx", -1, 0)
		else
			self.animator:Play("UI_ItemA01_suoxiao", -1, 0)
		end
	end
end

function TetrisGameChooseStageItem:RegisterClick(arg_9_1)
	if arg_9_1 then
		self.clickFunc = arg_9_1
	end
end

function TetrisGameChooseStageItem:Dispose()
	TetrisGameChooseStageItem.super.Dispose(self)

	for iter_10_0, iter_10_1 in pairs(self.skillItemList) do
		iter_10_1:Dispose()
	end

	Object.Destroy(self.gameObject_)
end

function TetrisGameChooseStageItem:UpdataRedPoint()
	if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_STAGE, self.stageID)) then
		manager.redPoint:SetRedPointIndependent(self.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end
end

return TetrisGameChooseStageItem
