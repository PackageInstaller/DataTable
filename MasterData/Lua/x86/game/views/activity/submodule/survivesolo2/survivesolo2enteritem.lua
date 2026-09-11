local SurviveSolo2EnterItem = class("SurviveSolo2EnterItem", ReduxView)

function SurviveSolo2EnterItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SurviveSolo2EnterItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SurviveSolo2EnterItem:InitUI()
	self:BindCfgUI()

	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.clearCon_ = ControllerUtil.GetController(self.transform_, "clear")
end

function SurviveSolo2EnterItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		local var_5_0 = manager.time:GetServerTime()

		if var_5_0 < self.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_)))
		elseif var_5_0 >= self.stopTime_ then
			ShowTips("TIME_OVER")
		else
			manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. self.activityID_, 0)

			local var_5_1 = {
				isSorted = true,
				isHideEffect = true,
				section = ActivitySoloSlayerCfg[self.activityID_].stage_id,
				sectionType = BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO,
				activityID = self.activityID_
			}
			local var_5_2 = {}
			local var_5_3 = {}
			local var_5_4 = {}

			if ActivitySoloSlayerCfg[self.activityID_].limit_type[1] == 1 then
				table.insert(var_5_2, ActivitySoloSlayerCfg[self.activityID_].limit_type[2])
			elseif ActivitySoloSlayerCfg[self.activityID_].limit_type[1] == 2 then
				table.insert(var_5_3, ActivitySoloSlayerCfg[self.activityID_].limit_type[2])

				var_5_1.recommend_type = ActivitySoloSlayerCfg[self.activityID_].limit_type[2]
			elseif ActivitySoloSlayerCfg[self.activityID_].limit_type[1] == 3 then
				table.insert(var_5_4, ActivitySoloSlayerCfg[self.activityID_].limit_type[2])
			end

			HeroData:SaveSortValue(false, 0, var_5_4, var_5_3, var_5_2)
			self:Go("/sectionSelectHero", var_5_1)
		end
	end)
end

function SurviveSolo2EnterItem:RefreshData(arg_6_1, arg_6_2)
	self.mainActivityID_ = arg_6_1
	self.activityID_ = arg_6_2
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime

	self:RefreshUI()
end

function SurviveSolo2EnterItem:RefreshTime(arg_7_1)
	if arg_7_1 < self.startTime_ then
		self.stateCon_:SetSelectedState("off")

		self.timeLable_.text = GetTips("SOLO_NOT_OPEN")
	elseif arg_7_1 < self.stopTime_ then
		self.stateCon_:SetSelectedState("on")

		self.timeLable_.text = manager.time:GetLostTimeStr2(self.stopTime_)
	else
		self.stateCon_:SetSelectedState("off")

		self.timeLable_.text = GetTips("TIME_OVER")
	end
end

function SurviveSolo2EnterItem:RefreshUI()
	self.levelText_.text = BattleSoloSlayerCfg[ActivitySoloSlayerCfg[self.activityID_].stage_id].name

	local var_8_0 = SurviveSoloData:GetData(self.activityID_)

	self.clearCon_:SetSelectedState(var_8_0 and var_8_0.time > 0 and "true" or "false")
	self.typeCon_:SetSelectedState(ActivitySoloSlayerCfg[self.activityID_].limit_type[2])
	SetActive(self.redGo_, manager.redPoint:getTipValue(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. self.activityID_) > 0)
end

function SurviveSolo2EnterItem:OnExit()
	self:RemoveAllEventListener()
end

function SurviveSolo2EnterItem:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return SurviveSolo2EnterItem
