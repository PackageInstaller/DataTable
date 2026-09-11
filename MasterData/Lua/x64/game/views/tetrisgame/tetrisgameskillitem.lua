local TetrisGameSkillItem = class("TetrisGameSkillItem", ReduxView)

function TetrisGameSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function TetrisGameSkillItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function TetrisGameSkillItem:InitUI()
	self:BindCfgUI()

	self.statusController = self.controller:GetController("status")
	self.notController = self.controller:GetController("not")
	self.categoryController = self.controller:GetController("category")
end

function TetrisGameSkillItem:RefreshUIInCheckView(arg_4_1)
	self.skillID = arg_4_1
	self.conficID = nil
	self.name.text = ActivityTetrisGameSkillCfg[self.skillID].name
	self.skillDesc.text = ActivityTetrisGameSkillCfg[self.skillID].desc
	self.skillImg.sprite = TetrisGameTools:GetSkillIcon(arg_4_1)

	self.statusController:SetSelectedState("noBtn")
end

function TetrisGameSkillItem:RefreshUIInGame(arg_5_1)
	self:RefreshUIInCheckView(arg_5_1)

	if arg_5_1 == TetrisGameConst.ultimateID then
		self.categoryController:SetSelectedState("special")
	else
		self.categoryController:SetSelectedState("normal")
	end

	local var_5_0 = TetrisGameRunTimeManager:GetSkillCD(self.skillID)

	if var_5_0 then
		self.remainCountTxt_.text = self.skillID == TetrisGameConst.skillType.bubble and string.format(GetTips("TETRIS_GAME_SKILL_BUBBLE_CD_TIPS"), var_5_0) or self.skillID == TetrisGameConst.skillType.lock and string.format(GetTips("TETRIS_GAME_SKILL_LOCK_CD_TIPS"), var_5_0) or string.format(GetTips("TETRIS_GAME_SKILL_ULTIMATE_CD_TIPS"), var_5_0)

		self.statusController:SetSelectedState("tips")
	else
		self.statusController:SetSelectedState("noBtn")
	end
end

function TetrisGameSkillItem:RefreshUI(arg_6_1)
	self.skillID = arg_6_1
	self.conficID = nil

	if self.skillID then
		if arg_6_1 == TetrisGameConst.ultimateID then
			self.categoryController:SetSelectedState("special")
		else
			self.categoryController:SetSelectedState("normal")
		end

		self.name.text = ActivityTetrisGameSkillCfg[self.skillID].name
		self.skillDesc.text = ActivityTetrisGameSkillCfg[self.skillID].desc
		self.skillImg.sprite = TetrisGameTools:GetSkillIcon(arg_6_1)

		local var_6_0, var_6_1 = TetrisGameTools:CheckSkillIsUnlock(self.skillID)

		if var_6_0 then
			if TetrisGameTools:CheckSkillInList(self.skillID) then
				self.statusController:SetSelectedState("cancel")
			else
				self.statusController:SetSelectedState("normal")
			end
		else
			self.statusController:SetSelectedState("lock")

			local var_6_2 = ""

			for iter_6_0, iter_6_1 in ipairs(ActivityTetrisGameSkillCfg[self.skillID].unlock_stage_id) do
				if TetrisGameTools:GetStageState(iter_6_1) ~= "finish" then
					var_6_2 = iter_6_0 == 1 and string.format("%s%s", var_6_2, ActivityTetrisGameStageCfg[iter_6_1].desc) or string.format("%s,%s", var_6_2, ActivityTetrisGameStageCfg[iter_6_1].desc)
				end
			end

			self.lockDesc.text = string.format(GetTips("TETRIS_GAME_SKILL_UNLOCK_CONDITION"), var_6_2)
		end

		local var_6_3, var_6_4 = TetrisGameTools:CheckSkillIsConflict(arg_6_1)

		if var_6_3 then
			self.notController:SetSelectedState("on")

			self.confictText.text = string.format(GetTips("TETRIS_GAME_SKILL_CONFLICT"), ActivityTetrisGameSkillCfg[var_6_4].name)
			self.conficID = var_6_4
			self.mutualImg_.sprite = TetrisGameTools:GetSkillIcon(var_6_4)
		else
			self.notController:SetSelectedState("off")
		end
	end

	self:RefreshRedPoint()
end

function TetrisGameSkillItem:AddUIListener()
	self:AddBtnListener(self.addBtn_, nil, function()
		if self.notController:GetSelectedState() == "on" then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips(GetTips("TETRIS_GAME_SKILL_CONFLICT_CONFIRM")), ActivityTetrisGameSkillCfg[self.conficID].name),
				OkCallback = function()
					TetrisGameTools:AddOrReduceSkill(self.skillID, self.conficID)
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_NEW_SKILL, self.skillID), 0)
				end
			})
		else
			TetrisGameTools:AddOrReduceSkill(self.skillID)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_NEW_SKILL, self.skillID), 0)
		end
	end)
	self:AddBtnListener(self.reduceBtn_, nil, function()
		TetrisGameTools:AddOrReduceSkill(self.skillID)
	end)
end

function TetrisGameSkillItem:Dispose()
	TetrisGameSkillItem.super.Dispose(self)
end

function TetrisGameSkillItem:RefreshRedPoint()
	if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_NEW_SKILL, self.skillID)) then
		manager.redPoint:SetRedPointIndependent(self.transform_, true, nil)
	else
		manager.redPoint:SetRedPointIndependent(self.transform_, false, nil)
	end
end

return TetrisGameSkillItem
