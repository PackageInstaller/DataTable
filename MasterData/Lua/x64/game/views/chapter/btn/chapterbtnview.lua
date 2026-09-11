local ChapterBtnView = class("ChapterBtnView", ReduxView)

function ChapterBtnView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.toggle_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.switchController_ = ControllerUtil.GetController(self.transform_, "tab")
end

local var_0_1 = {
	[BattleConst.TOGGLE.MAIN] = ViewConst.SYSTEM_ID.BATTLE,
	[BattleConst.TOGGLE.EQUIP] = ViewConst.SYSTEM_ID.BATTLE_EQUIP,
	[BattleConst.TOGGLE.CHALLENGE] = ViewConst.SYSTEM_ID.BATTLE_ASTROLABE,
	[BattleConst.TOGGLE.RESIDENT_ACT] = ViewConst.SYSTEM_ID.RESIDENT_ACT,
	[BattleConst.TOGGLE.RESOURCE] = ViewConst.SYSTEM_ID.BATTLE_DAILY
}

function ChapterBtnView:OnEnter()
	self.isLock_ = false
	self.isLock_ = self.toggle_ == BattleConst.TOGGLE.RESIDENT_ACT and (JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.RESIDENT_ACT) or #ChapterResidentTools.GetResidentChapterOpenList() <= 0) or JumpTools.IsSystemLocked(var_0_1[self.toggle_])

	self:RefreshRedPoint()
	self:RefreshLock()
end

function ChapterBtnView:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_)
end

function ChapterBtnView:Dispose()
	ChapterBtnView.super.Dispose(self)
end

function ChapterBtnView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.active_ then
			return
		end

		local var_6_0 = self.toggle_
		local var_6_1 = ViewConst.SYSTEM_ID.BATTLE

		if self.toggle_ == BattleConst.TOGGLE.MAIN then
			var_6_1 = ViewConst.SYSTEM_ID.BATTLE
		elseif var_6_0 == BattleConst.TOGGLE.RESOURCE then
			var_6_1 = ViewConst.SYSTEM_ID.BATTLE_DAILY
		elseif var_6_0 == BattleConst.TOGGLE.CHALLENGE then
			var_6_1 = ViewConst.SYSTEM_ID.BATTLE_ASTROLABE
		elseif var_6_0 == BattleConst.TOGGLE.EQUIP then
			var_6_1 = ViewConst.SYSTEM_ID.BATTLE_EQUIP
		elseif var_6_0 == BattleConst.TOGGLE.RESIDENT_ACT then
			var_6_1 = ViewConst.SYSTEM_ID.RESIDENT_ACT

			if #ChapterResidentTools.GetResidentChapterOpenList() <= 0 then
				return
			end
		end

		JumpTools.GoToSystem("/chapterMap", {
			chapterToggle = self.toggle_
		}, var_6_1)
		OperationRecorder.Record(self.class.__cname, tostring(self.toggle_))
	end)
end

function ChapterBtnView:SelectChapterToggle(arg_7_1)
	self.active_ = arg_7_1

	if arg_7_1 then
		self.switchController_:SetSelectedState("select")
	else
		self:RefreshLock()
	end
end

function ChapterBtnView:RefreshRedPoint()
	if ActivityData:GetActivityIsOpen(CoreVerificationChallengeTools.GetActivityId()) then
		local var_8_0 = CoreVerificationChallengeTools.GetModeIndex()

		if var_8_0 == 1 then
			CoreVerificationChallengeAction.UpdateRewardRedPoints()
		elseif var_8_0 == 2 then
			CoreVerificationChallengeMode2Action.UpdateRewardRedPoints()
		end
	end

	local var_8_1 = self.toggle_

	if self.toggle_ == BattleConst.TOGGLE.MAIN then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.COMBAT_MAIN)
	elseif var_8_1 == BattleConst.TOGGLE.CHALLENGE then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.COMBAT_CHALLENGE)
	elseif var_8_1 == BattleConst.TOGGLE.EQUIP then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.COMBAT_EQUIP)
	elseif var_8_1 == BattleConst.TOGGLE.RESOURCE then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.RESOURSE_STAGE)
	elseif var_8_1 == BattleConst.TOGGLE.RESIDENT_ACT then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.RESIDENT_ACT)
	end
end

function ChapterBtnView:RefreshLock()
	if self.isLock_ then
		self.switchController_:SetSelectedState("lock")
	else
		self.switchController_:SetSelectedState("notSelect")
	end
end

return ChapterBtnView
