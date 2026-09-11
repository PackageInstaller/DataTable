local DifficultSelectItem = class("DifficultSelectItem", ReduxView)
local var_0_1 = {
	[ActivityConst.SUMMER_LIMITED_CALCULATION] = 4,
	[ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION] = 4,
	[ActivityConst.ACTIVITY_2_10_LIMITED_CALCULATION] = 4
}

function DifficultSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function DifficultSelectItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function DifficultSelectItem:InitUI()
	self:BindCfgUI()

	self.selectCon_ = ControllerUtil.GetController(self.transform_, "select")
	self.difficultyCon_ = ControllerUtil.GetController(self.transform_, "difficulty")
	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
end

function DifficultSelectItem:AddUIListeners()
	self:AddBtnListener(self.Btn_, nil, function()
		if self.clickFun_ then
			self.clickFun_(self.id_)
		end
	end)
end

function DifficultSelectItem:OnEnter()
	return
end

function DifficultSelectItem:RefreshUI(arg_7_1, arg_7_2)
	self.activityID_ = arg_7_1
	self.id_ = arg_7_2
	self.cfg_ = ActivityLimitCalculationCfg[self.id_]
	self.difficulty_ = self.cfg_.difficulty

	self.difficultyCon_:SetSelectedState(self.difficulty_)

	self.odds_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_RANK"), self.cfg_.reward_point / 100)
	self.enemyBuff_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_ENEMY_LEVEL"), self.cfg_.enemy_level)
	self.debuff_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_PLAYER_LEVEL"), self.cfg_.player_level)

	if (var_0_1[arg_7_1] or nil) and self.difficulty_ > var_0_1[arg_7_1] and not LimitedCalculationData:IsClearActivity(self.activityID_, LimitedCalculationData:GetDifficultyList(arg_7_1)[var_0_1[arg_7_1]]) then
		self.lockController_:SetSelectedState("off")
	else
		self.lockController_:SetSelectedState("on")
	end
end

function DifficultSelectItem:SetSelected(arg_8_1)
	if self.id_ == arg_8_1 then
		self.selectCon_:SetSelectedState("selected")
	else
		self.selectCon_:SetSelectedState("unselect")
	end
end

function DifficultSelectItem:RegisterClickListener(arg_9_1)
	self.clickFun_ = arg_9_1
end

function DifficultSelectItem:OnExit()
	self.clickFun_ = nil
end

function DifficultSelectItem:Dispose()
	self:RemoveAllListeners()
	DifficultSelectItem.super.Dispose(self)
end

return DifficultSelectItem
