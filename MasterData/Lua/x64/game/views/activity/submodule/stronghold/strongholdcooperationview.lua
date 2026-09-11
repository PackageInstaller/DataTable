local StrongholdCooperationView = class("StrongholdCooperationView", (import("game.views.cooperation.CooperationView")))

function StrongholdCooperationView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdCooperationUI"
end

function StrongholdCooperationView:InitUI()
	StrongholdCooperationView.super.InitUI(self)

	for iter_2_0 = 1, 3 do
		self["skillTypeController_" .. iter_2_0] = ControllerUtil.GetController(self["m_skillTrs" .. iter_2_0], "click")
		self["skillLockController_" .. iter_2_0] = ControllerUtil.GetController(self["m_skillTrs" .. iter_2_0], "lock")
	end

	self.selfSkillTypeController = ControllerUtil.GetController(self.m_skillContent, "select")
end

function StrongholdCooperationView:AddUIListener()
	StrongholdCooperationView.super.AddUIListener(self)
	self:AddBtnListener(nil, self.m_skillBtn1, function()
		StrongholdAction.QueryChooseRoomSkillType(self.roomData.room_id, 1)
	end)
	self:AddBtnListener(nil, self.m_skillBtn2, function()
		StrongholdAction.QueryChooseRoomSkillType(self.roomData.room_id, 2)
	end)
	self:AddBtnListener(nil, self.m_skillBtn3, function()
		StrongholdAction.QueryChooseRoomSkillType(self.roomData.room_id, 3)
	end)
	self:AddBtnListener(nil, self.m_skillInfoBtn, function()
		JumpTools.OpenPageByJump("strongholdSkillInfo")
	end)
end

function StrongholdCooperationView:RefreshUI()
	self.skillTypes = StrongholdData:GetRoomSkillTypes(self.roomData.room_id)

	for iter_8_0 = 1, 3 do
		self["skillTypeController_" .. iter_8_0]:SetSelectedIndex(self.skillTypes[iter_8_0] or 0)

		local var_8_1, var_8_2, var_8_3, var_8_4 = StrongholdData:GetStrongholdLevel(iter_8_0)

		if var_8_2 < StrongholdData:GetSkillLimitLv() then
			self["skillLockController_" .. iter_8_0]:SetSelectedIndex(1)
		else
			self["skillLockController_" .. iter_8_0]:SetSelectedIndex(0)
		end

		self["m_skillIcon" .. iter_8_0].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdSkill/" .. iter_8_0)
	end

	self.selfSkillTypeController:SetSelectedIndex((StrongholdData:GetSelfRoomSkillType(self.roomData.room_id)))
end

function StrongholdCooperationView:GetRoomName()
	return (ActivityStrongholdCfg[self.roomData.dest] or nil) and (ActivityStrongholdCfg[self.roomData.dest].room_name or "")
end

function StrongholdCooperationView:ShowComboIncreaseGo()
	return true
end

return StrongholdCooperationView
