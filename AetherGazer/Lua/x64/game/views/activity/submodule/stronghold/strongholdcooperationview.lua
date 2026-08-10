local var_0_0 = import("game.views.cooperation.CooperationView")
local var_0_1 = class("StrongholdCooperationView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdCooperationUI"
end

function var_0_1.InitUI(arg_2_0)
	var_0_1.super.InitUI(arg_2_0)

	for iter_2_0 = 1, 3 do
		arg_2_0["skillTypeController_" .. iter_2_0] = ControllerUtil.GetController(arg_2_0["m_skillTrs" .. iter_2_0], "click")
		arg_2_0["skillLockController_" .. iter_2_0] = ControllerUtil.GetController(arg_2_0["m_skillTrs" .. iter_2_0], "lock")
	end

	arg_2_0.selfSkillTypeController = ControllerUtil.GetController(arg_2_0.m_skillContent, "select")
end

function var_0_1.AddUIListener(arg_3_0)
	var_0_1.super.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(nil, arg_3_0.m_skillBtn1, function()
		StrongholdAction.QueryChooseRoomSkillType(arg_3_0.roomData.room_id, 1)
	end)
	arg_3_0:AddBtnListener(nil, arg_3_0.m_skillBtn2, function()
		StrongholdAction.QueryChooseRoomSkillType(arg_3_0.roomData.room_id, 2)
	end)
	arg_3_0:AddBtnListener(nil, arg_3_0.m_skillBtn3, function()
		StrongholdAction.QueryChooseRoomSkillType(arg_3_0.roomData.room_id, 3)
	end)
	arg_3_0:AddBtnListener(nil, arg_3_0.m_skillInfoBtn, function()
		JumpTools.OpenPageByJump("strongholdSkillInfo")
	end)
end

function var_0_1.RefreshUI(arg_8_0)
	arg_8_0.skillTypes = StrongholdData:GetRoomSkillTypes(arg_8_0.roomData.room_id)

	for iter_8_0 = 1, 3 do
		local var_8_0 = arg_8_0.skillTypes[iter_8_0] or 0

		arg_8_0["skillTypeController_" .. iter_8_0]:SetSelectedIndex(var_8_0)

		local var_8_1, var_8_2, var_8_3, var_8_4 = StrongholdData:GetStrongholdLevel(iter_8_0)

		if var_8_2 < StrongholdData:GetSkillLimitLv() then
			arg_8_0["skillLockController_" .. iter_8_0]:SetSelectedIndex(1)
		else
			arg_8_0["skillLockController_" .. iter_8_0]:SetSelectedIndex(0)
		end

		arg_8_0["m_skillIcon" .. iter_8_0].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdSkill/" .. iter_8_0)
	end

	local var_8_5 = StrongholdData:GetSelfRoomSkillType(arg_8_0.roomData.room_id)

	arg_8_0.selfSkillTypeController:SetSelectedIndex(var_8_5)
end

function var_0_1.GetRoomName(arg_9_0)
	local var_9_0 = arg_9_0.roomData.dest

	return ActivityStrongholdCfg[var_9_0] and ActivityStrongholdCfg[var_9_0].room_name or ""
end

function var_0_1.ShowComboIncreaseGo(arg_10_0)
	return true
end

return var_0_1
