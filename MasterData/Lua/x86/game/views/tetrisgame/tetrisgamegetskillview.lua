local TetrisGameGetSkillView = class("TetrisGameGetSkillView", ReduxView)

function TetrisGameGetSkillView:UIName()
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameexplainPopUI"
end

function TetrisGameGetSkillView:UIParent()
	return manager.ui.uiPop.transform
end

function TetrisGameGetSkillView:Init()
	self:InitUI()
	self:AddUIListener()
end

function TetrisGameGetSkillView:InitUI()
	self:BindCfgUI()

	self.stateController = self.controller:GetController("state")
	self.grayController = self.panelController:GetController("btn_gray")
end

function TetrisGameGetSkillView:OnEnter()
	self.activityID = TetrisGameData:GetCurActivityID()

	self:EnterSelect()
end

function TetrisGameGetSkillView:EnterSelect()
	self.stageID = self.params_.stageID
	self.skillList = {}
	self.skillList = self.stageID and self.stageID > 0 and (ActivityTetrisGameStageCfg[self.stageID].type == TetrisGameConst.stageType.endLess and TetrisGameData:GetEndlessSkillList() or ActivityTetrisGameStageCfg[self.stageID].skill_list) or self.params_.skillList

	if #self.skillList <= 1 then
		self.stateController:SetSelectedState("single")
	else
		self.stateController:SetSelectedState("full")
	end

	self.index = 1

	for iter_6_0, iter_6_1 in ipairs(self.skillList or {}) do
		if self.params_.skillID == iter_6_1 then
			self.index = iter_6_0
		end
	end

	self:RefreshView()
end

function TetrisGameGetSkillView:OnTop()
	return
end

function TetrisGameGetSkillView:AddUIListener()
	self:AddBtnListener(self.maskBtn, nil, function()
		self:Back()

		if self.params_.closeCallBack then
			self.params_.closeCallBack()

			self.params_.closeCallBack = nil
		end
	end)
	self:AddBtnListener(self.btnleftBtn_, nil, function()
		if self.index > 1 then
			self.index = self.index - 1

			self:RefreshView()
		end
	end)
	self:AddBtnListener(self.btnrightBtn_, nil, function()
		if self.index < #self.skillList then
			self.index = self.index + 1

			self:RefreshView()
		end
	end)
end

function TetrisGameGetSkillView:OnExit()
	self:RemoveAllEventListener()
end

function TetrisGameGetSkillView:Dispose()
	TetrisGameGetSkillView.super.Dispose(self)
end

function TetrisGameGetSkillView:RefreshView()
	self.index = self.index or 1
	self.skillID = self.skillList[self.index]

	if ActivityTetrisGameSkillCfg[self.skillID] then
		self.skillName.text = ActivityTetrisGameSkillCfg[self.skillID].name
		self.skillDesc.text = ActivityTetrisGameSkillCfg[self.skillID].desc
		self.skillImage.sprite = TetrisGameTools:GetSkillIcon(self.skillID)
	end

	if self.index == 1 then
		self.grayController:SetSelectedState("left_gray")
	elseif self.index == #self.skillList then
		self.grayController:SetSelectedState("right_gray")
	else
		self.grayController:SetSelectedState("normal")
	end
end

return TetrisGameGetSkillView
