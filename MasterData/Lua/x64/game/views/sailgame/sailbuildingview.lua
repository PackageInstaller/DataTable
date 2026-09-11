local SailBuildingView = class("SailBuildingView", ReduxView)

function SailBuildingView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyageBuildingUnlockUI"
end

function SailBuildingView:UIParent()
	return manager.ui.uiPop.transform
end

function SailBuildingView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SailBuildingView:InitUI()
	self:BindCfgUI()

	self.costController_ = ControllerUtil.GetController(self.transform_, "cost")
	self.unlockController_ = ControllerUtil.GetController(self.transform_, "unlock")
end

function SailBuildingView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buildBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not self.isEnough_ then
			ShowTips("ACTIVITY_SKADI_SEA_MATERIAL_NUM_NOT_ENOUGH")

			return
		end

		SailGameAction.UnlockBuilding(self.activityID_, self.id_)
	end)
end

function SailBuildingView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.id_ = self.params_.ID
	self.buildingCfg_ = SailGameBuildingCfg[self.id_]
	self.unlock_ = SailGameData:GetUnLockBuilding(self.activityID_)[self.id_]

	self.unlockController_:SetSelectedState(self.unlock_ and "true" or "false")
	self:RefreshUI()
end

function SailBuildingView:RefreshUI()
	self:RefreshTitle()
	self:RefreshReward()
	self:RefreshCost()
end

function SailBuildingView:RefreshTitle()
	local var_10_0 = SailGameBuildingCfg[self.id_]

	if self.unlock_ then
		self.titleText_.text = var_10_0.name
		self.descText_.text = var_10_0.desc
	else
		self.titleText_.text = GetTips("ACTIVITY_SKADI_SEA_BUILDING_NOT_FOUND_NAME")
		self.descText_.text = GetTips("ACTIVITY_SKADI_SEA_BUILDING_NOT_FOUND_DESCRIBE")

		local var_10_1 = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/" .. var_10_0.picture_unlock)

		if var_10_1 then
			self.lockIcon_.sprite = var_10_1
		end
	end

	local var_10_2 = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/" .. var_10_0.picture_pop)

	if var_10_2 then
		self.normalIcon_.sprite = var_10_2
	end
end

function SailBuildingView:RefreshReward()
	self.rewardNumText_.text = string.format("+%d/%s", self.buildingCfg_.token_get[1][2] * (60 / GameSetting.activity_skadi_sea_building_calculate_time.value[1]), GetTips("HOUR"))
	self.rewardIcon_.sprite = ItemTools.getItemSprite(self.buildingCfg_.token_get[1][1])
end

function SailBuildingView:RefreshCost()
	local var_12_0

	if self.unlock_ then
		do return end

		var_12_0 = self.buildingCfg_.cost[1][1]
	end

	local var_12_1 = self.buildingCfg_.cost[1][2]

	self.isEnough_ = false

	if var_12_1 <= ItemTools.getItemNum(var_12_0) then
		self.isEnough_ = true

		self.costController_:SetSelectedState("true")
	else
		self.costController_:SetSelectedState("false")
	end

	self.costNumText_.text = var_12_1
	self.costIcon_.sprite = ItemTools.getItemSprite(var_12_0)
end

function SailBuildingView:OnBuildingUnlock()
	ShowTips(string.format(GetTips("ACTIVITY_SKADI_SEA_BUILD_SUCCESS"), self.buildingCfg_.name))
	self:Back()
end

return SailBuildingView
