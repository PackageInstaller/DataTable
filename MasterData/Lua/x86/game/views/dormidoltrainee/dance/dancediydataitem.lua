local DanceDIYDataItem = class("DanceDIYDataItem", ReduxView)

function DanceDIYDataItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DanceDIYDataItem:InitUI()
	self:BindCfgUI()

	self.selectController = self.controllers_:GetController("select")
	self.emptyController = self.controllers_:GetController("empty")
	self.categoryController = self.controllers_:GetController("category")

	self:AddUIListeners()
end

function DanceDIYDataItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self:OnClick()
	end)
end

function DanceDIYDataItem:SetOnClick(arg_5_1)
	self.onClick = arg_5_1
end

function DanceDIYDataItem:SetData(arg_6_1, arg_6_2)
	self.showShareStatistics = arg_6_2
	self.loadData = arg_6_1

	self:Refresh()
end

function DanceDIYDataItem:SetSelected(arg_7_1)
	if self.selectController then
		self.selectController:SetSelectedState(arg_7_1 and "true" or "false")
	end
end

local var_0_1 = "--"

function DanceDIYDataItem:Refresh()
	local var_8_0 = IdolTraineeTools.GetDIYDataFromLoadInfo(self.loadData)

	if var_8_0 then
		if self.emptyController then
			self.emptyController:SetSelectedState("false")
		end

		self.sceneIcon_.sprite = getSpriteViaConfig("IdolStageIcon", IdolStageSceneCfg[var_8_0.scene].stage_picture)
		self.musicName_.text = nullable(IdolStageMusicCfg, var_8_0.music, "music_name")
		self.duration_.text = manager.time:DescCDTime4((IdolTraineeTools.GetMusicDuration(var_8_0.music)))
		self.actionCnt_.text = self.loadData.actionCount or IdolTraineeTools.CalculateActionCount(var_8_0.actionList)

		if self.categoryController then
			self.categoryController:SetSelectedState(self.showShareStatistics and "shared" or "own")
		end

		self.collectedCnt_.text = var_8_0.collcted or var_0_1
		self.viewedCnt_.text = var_8_0.viewCount or var_0_1
		self.likedCnt_.text = var_8_0.liked or var_0_1
	elseif self.emptyController then
		self.emptyController:SetSelectedState("true")
	end
end

function DanceDIYDataItem:SetDisplayName(arg_9_1)
	self.seqName_.text = arg_9_1
end

function DanceDIYDataItem:SetShowStatistics(arg_10_1)
	self.showShareStatistics = arg_10_1

	if self.categoryController then
		self.categoryController:SetSelectedState(self.showShareStatistics and "shared" or "own")
	end
end

function DanceDIYDataItem:OnClick()
	if self.onClick then
		self.onClick(self.loadData)
	end
end

return DanceDIYDataItem
