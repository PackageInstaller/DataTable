local var_0_0 = class("TetrisGameSkillItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController = arg_3_0.controller:GetController("status")
	arg_3_0.notController = arg_3_0.controller:GetController("not")
	arg_3_0.categoryController = arg_3_0.controller:GetController("category")
end

function var_0_0.RefreshUIInCheckView(arg_4_0, arg_4_1)
	arg_4_0.skillID = arg_4_1
	arg_4_0.conficID = nil

	local var_4_0 = ActivityTetrisGameSkillCfg[arg_4_0.skillID]

	arg_4_0.name.text = var_4_0.name
	arg_4_0.skillDesc.text = var_4_0.desc
	arg_4_0.skillImg.sprite = TetrisGameTools:GetSkillIcon(arg_4_1)

	arg_4_0.statusController:SetSelectedState("noBtn")
end

function var_0_0.RefreshUIInGame(arg_5_0, arg_5_1)
	arg_5_0:RefreshUIInCheckView(arg_5_1)

	if arg_5_1 == TetrisGameConst.ultimateID then
		arg_5_0.categoryController:SetSelectedState("special")
	else
		arg_5_0.categoryController:SetSelectedState("normal")
	end

	local var_5_0 = TetrisGameRunTimeManager:GetSkillCD(arg_5_0.skillID)

	if var_5_0 then
		if arg_5_0.skillID == TetrisGameConst.skillType.bubble then
			arg_5_0.remainCountTxt_.text = string.format(GetTips("TETRIS_GAME_SKILL_BUBBLE_CD_TIPS"), var_5_0)
		elseif arg_5_0.skillID == TetrisGameConst.skillType.lock then
			arg_5_0.remainCountTxt_.text = string.format(GetTips("TETRIS_GAME_SKILL_LOCK_CD_TIPS"), var_5_0)
		else
			arg_5_0.remainCountTxt_.text = string.format(GetTips("TETRIS_GAME_SKILL_ULTIMATE_CD_TIPS"), var_5_0)
		end

		arg_5_0.statusController:SetSelectedState("tips")
	else
		arg_5_0.statusController:SetSelectedState("noBtn")
	end
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.skillID = arg_6_1
	arg_6_0.conficID = nil

	if arg_6_0.skillID then
		if arg_6_1 == TetrisGameConst.ultimateID then
			arg_6_0.categoryController:SetSelectedState("special")
		else
			arg_6_0.categoryController:SetSelectedState("normal")
		end

		local var_6_0 = ActivityTetrisGameSkillCfg[arg_6_0.skillID]

		arg_6_0.name.text = var_6_0.name
		arg_6_0.skillDesc.text = var_6_0.desc
		arg_6_0.skillImg.sprite = TetrisGameTools:GetSkillIcon(arg_6_1)

		local var_6_1, var_6_2 = TetrisGameTools:CheckSkillIsUnlock(arg_6_0.skillID)

		if var_6_1 then
			if TetrisGameTools:CheckSkillInList(arg_6_0.skillID) then
				arg_6_0.statusController:SetSelectedState("cancel")
			else
				arg_6_0.statusController:SetSelectedState("normal")
			end
		else
			arg_6_0.statusController:SetSelectedState("lock")

			local var_6_3 = ActivityTetrisGameSkillCfg[arg_6_0.skillID].unlock_stage_id
			local var_6_4 = ""

			for iter_6_0, iter_6_1 in ipairs(var_6_3) do
				if TetrisGameTools:GetStageState(iter_6_1) ~= "finish" then
					if iter_6_0 == 1 then
						var_6_4 = string.format("%s%s", var_6_4, ActivityTetrisGameStageCfg[iter_6_1].desc)
					else
						var_6_4 = string.format("%s,%s", var_6_4, ActivityTetrisGameStageCfg[iter_6_1].desc)
					end
				end
			end

			arg_6_0.lockDesc.text = string.format(GetTips("TETRIS_GAME_SKILL_UNLOCK_CONDITION"), var_6_4)
		end

		local var_6_5, var_6_6 = TetrisGameTools:CheckSkillIsConflict(arg_6_1)

		if var_6_5 then
			arg_6_0.notController:SetSelectedState("on")

			arg_6_0.confictText.text = string.format(GetTips("TETRIS_GAME_SKILL_CONFLICT"), ActivityTetrisGameSkillCfg[var_6_6].name)
			arg_6_0.conficID = var_6_6
			arg_6_0.mutualImg_.sprite = TetrisGameTools:GetSkillIcon(var_6_6)
		else
			arg_6_0.notController:SetSelectedState("off")
		end
	end

	arg_6_0:RefreshRedPoint()
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.addBtn_, nil, function()
		if arg_7_0.notController:GetSelectedState() == "on" then
			local var_8_0 = ActivityTetrisGameSkillCfg[arg_7_0.skillID].name
			local var_8_1 = ActivityTetrisGameSkillCfg[arg_7_0.conficID].name

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips(GetTips("TETRIS_GAME_SKILL_CONFLICT_CONFIRM")), var_8_1),
				OkCallback = function()
					TetrisGameTools:AddOrReduceSkill(arg_7_0.skillID, arg_7_0.conficID)
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_NEW_SKILL, arg_7_0.skillID), 0)
				end
			})
		else
			TetrisGameTools:AddOrReduceSkill(arg_7_0.skillID)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_NEW_SKILL, arg_7_0.skillID), 0)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.reduceBtn_, nil, function()
		TetrisGameTools:AddOrReduceSkill(arg_7_0.skillID)
	end)
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.RefreshRedPoint(arg_12_0)
	if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_NEW_SKILL, arg_12_0.skillID)) then
		manager.redPoint:SetRedPointIndependent(arg_12_0.transform_, true, nil)
	else
		manager.redPoint:SetRedPointIndependent(arg_12_0.transform_, false, nil)
	end
end

return var_0_0
