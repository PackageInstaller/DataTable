local TeachStageView = class("TeachStageView", ReduxView)
local var_0_1 = {
	{
		battleConst = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING,
		redConst = RedPointConst.TEACH_BASE
	},
	{
		battleConst = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
		redConst = RedPointConst.TEACH_CHARACTER
	}
}

function TeachStageView:UIName()
	return "Widget/System/Teachinglevel/TeachinglevelUI"
end

function TeachStageView:UIParent()
	return manager.ui.uiMain.transform
end

function TeachStageView:Init()
	self.switchBtn_ = {}
	self.contentView_ = {}

	self:InitUI()
end

function TeachStageView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("TEACH_STAGE_DESC")

	for iter_4_0 = 1, 2 do
		self:AddBtnListener(self[string.format("btnTab%s_", iter_4_0)], nil, function()
			self:SelectTab(iter_4_0)
		end)
	end

	local var_4_0 = self.params_.switchType or BattleTeachData:GetSwitchType()

	BattleTeachData:SetSwitchType(var_4_0)

	self.lastSwitchType_ = var_4_0

	local var_4_1 = 1

	for iter_4_1, iter_4_2 in ipairs(var_0_1) do
		if iter_4_2.battleConst == var_4_0 then
			var_4_1 = iter_4_1
		end

		manager.redPoint:bindUIandKey(self[string.format("buttle0%sTrs_", iter_4_1)].transform, iter_4_2.redConst)
	end

	self:SelectTab(var_4_1)
	manager.redPoint:bindUIandKey(self.buttle01Trs_, RedPointConst.TEACH_BASE_TEACHING)
end

function TeachStageView:SelectTab(arg_6_1)
	self:OnGroupSelect(arg_6_1)
	self.tabControl:SetSelectedState(string.format("state%s", arg_6_1))
end

function TeachStageView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function TeachStageView:OnUpdate()
	if self.lastSwitchType_ ~= BattleTeachData:GetSwitchType() then
		self.lastSwitchType_ = BattleTeachData:GetSwitchType()

		self:SwitchPage(self.lastSwitchType_, false)
	end

	self.contentView_[self.lastSwitchType_]:OnUpdate()
end

function TeachStageView:OnClickTeachViewBtn()
	for iter_9_0, iter_9_1 in pairs(self.contentView_) do
		iter_9_1:OnClickTeachViewBtn()
	end
end

function TeachStageView:OnExit()
	self.switchType_ = nil

	manager.windowBar:HideBar()

	for iter_10_0, iter_10_1 in pairs(self.contentView_) do
		iter_10_1:OnExit()
	end

	for iter_10_2, iter_10_3 in ipairs(var_0_1) do
		manager.redPoint:unbindUIandKey(self[string.format("buttle0%sTrs_", iter_10_2)].transform)
	end
end

function TeachStageView:Dispose()
	self:RemoveListeners()

	for iter_11_0, iter_11_1 in pairs(self.contentView_) do
		iter_11_1:Dispose()
	end

	self.contentView_ = nil
	self.basePanel_ = nil
	self.heroPanel_ = nil

	TeachStageView.super.Dispose(self)
end

function TeachStageView:InitUI()
	self:BindCfgUI()

	self.tabControl = self.tabControllerexcollection_:GetController("select")
	self.contentView_[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING] = TeachStageBaseView.New(self.basePanel_, BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING)
	self.contentView_[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING] = TeachStageHeroView.New(self.heroPanel_, BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING)
end

function TeachStageView:RemoveListeners()
	return
end

function TeachStageView:OnGroupSelect(arg_14_1)
	if var_0_1[arg_14_1].battleConst == self.switchType_ and not self.params_.heroID then
		return
	end

	self:SwitchPage(var_0_1[arg_14_1].battleConst, self.params_.isBack)
	BattleTeachData:SetSwitchType(self.switchType_)
	self:Go("teachStage", {
		switchType = self.switchType_
	})
	manager.notify:CallUpdateFunc(CLICK_TEACH_BTN)

	for iter_14_0, iter_14_1 in pairs(self.contentView_) do
		iter_14_1:OnEnter()
	end
end

function TeachStageView:GetCurView()
	if self.contentView_[self.switchType_] then
		return self.contentView_[self.switchType_]
	end
end

function TeachStageView:SwitchPage(arg_16_1, arg_16_2)
	self.switchType_ = arg_16_1

	if arg_16_1 == 12 then
		OperationRecorder.Record("teachStage", "base")
	elseif arg_16_1 == 13 then
		OperationRecorder.Record("teachStage", "role")
	end

	for iter_16_0, iter_16_1 in pairs(self.contentView_) do
		iter_16_1:SwitchPageUI(arg_16_1, self.params_.heroID, arg_16_2 ~= true)
	end

	self.params_.heroID = nil
end

return TeachStageView
