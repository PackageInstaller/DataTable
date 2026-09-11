local SkinTrialAcitivteItem = class("SkinTrialAcitivteItem", ReduxView)

function SkinTrialAcitivteItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
	self.adaptImg_ = self:FindCom("AdaptImage", nil, self.transform_)

	self:SetSkinTrialID(arg_1_3)
	SetActive(self.gameObject_, true)
end

function SkinTrialAcitivteItem:Dispose()
	SkinTrialAcitivteItem.super.Dispose(self)
	manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SKIN_TRIAL, self.skinTrialID_)))
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SkinTrialAcitivteItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if not ActivityData:GetActivityData(self.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		SkinTrialData:SetSelectSkinTrialID(self.skinTrialID_)

		if self.path_ == nil then
			self.path_ = string.format("/skinTrialSelect%d", self.skinTrialID_)
		end

		self:Go(self.path_, {
			canPlayAnim = true,
			activityID = self.activityID_,
			skinTrialID = self.skinTrialID_
		})
	end)
end

function SkinTrialAcitivteItem:SetSkinTrialID(arg_5_1)
	manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SKIN_TRIAL, arg_5_1)))

	self.skinTrialID_ = arg_5_1
	self.activityID_ = ActivitySkinTrialCfg[self.skinTrialID_].activity_id
	self.startTime_ = ActivityData:GetActivityData(self.activityID_).startTime
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:RefreshUI()
end

function SkinTrialAcitivteItem:RefreshUI()
	local var_6_0 = HeroStandardSystemCfg[SkinTrialTools.GetHeroStandardID(self.skinTrialID_)].skin_id

	self.nameText_.text = GetI18NText(SkinCfg[var_6_0].name)

	local var_6_1 = getSpriteViaConfig("SkinTrialTextrues", SkinCfg[var_6_0].picture_id)

	if var_6_1 ~= nil then
		self.skinImage_.sprite = var_6_1

		self.adaptImg_:AdaptImg()
	end

	if SkinTrialData:IsCompleted(self.skinTrialID_) then
		self.stateController_:SetSelectedState("true")
	end
end

function SkinTrialAcitivteItem:RefreshTime()
	if manager.time:GetServerTime() < ActivityData:GetActivityData(self.activityID_).startTime then
		SetActive(self.gameObject_, false)

		return
	end

	if manager.time:GetServerTime() >= ActivityData:GetActivityData(self.activityID_).stopTime then
		SetActive(self.gameObject_, false)

		return
	end

	SetActive(self.gameObject_, true)
end

return SkinTrialAcitivteItem
