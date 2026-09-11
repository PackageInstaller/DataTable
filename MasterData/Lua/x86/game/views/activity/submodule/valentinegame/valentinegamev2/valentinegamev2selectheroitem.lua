local ValentineGameV2SelectHeroItem = class("ValentineGameV2SelectHeroItem", ReduxView)

function ValentineGameV2SelectHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ValentineGameV2SelectHeroItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ValentineGameV2SelectHeroItem:InitUI()
	self:BindCfgUI()

	self.lockController_ = ControllerUtil.GetController(self.transform_, "mask")
	self.getController_ = ControllerUtil.GetController(self.transform_, "Invited")
end

function ValentineGameV2SelectHeroItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if ActivityData:GetActivityIsOpen(self.activityID_) then
			ValentineGameData:SetNotNewOpen(self.activityID_)
			JumpTools.OpenPageByJump("/valentineGameV2HeroInfoView", {
				activityID = self.activityID_
			})
		elseif manager.time:GetServerTime() < ActivityData:GetActivityData(self.activityID_).startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.activityID_).startTime))))
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
end

function ValentineGameV2SelectHeroItem:SetData(arg_6_1)
	self.activityID_ = arg_6_1
	self.cfg_ = ActivityValentineCfg[self.activityID_]
	self.nameText_.text = self.cfg_.name
	self.iconImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/Role/" .. self.cfg_.hero_id)

	self:RefreshStatus()
	manager.redPoint:bindUIandKey(self.redTrans_, RedPointConst.VALENTINE_GAME .. "_" .. self.activityID_)
	self:RegistEventListener(ACTIVITY_UPDATE, handler(self, self.OnActivityUpdate))
end

function ValentineGameV2SelectHeroItem:RefreshStatus()
	if ActivityData:GetActivityIsOpen(self.activityID_) then
		self.lockController_:SetSelectedState("false")

		if ValentineGameData:GetData(self.activityID_) and ValentineGameData:GetData(self.activityID_).isClear then
			self.getController_:SetSelectedState("yes")
		else
			self.getController_:SetSelectedState("no")
		end
	else
		self.lockController_:SetSelectedState("true")
		self.getController_:SetSelectedState("no")

		self.lockText_.text = manager.time:GetServerTime() < ActivityData:GetActivityData(self.activityID_).startTime and string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.activityID_).startTime))) or GetTips("TIME_OVER")
	end
end

function ValentineGameV2SelectHeroItem:RefreshTimeText()
	if not ActivityData:GetActivityIsOpen(self.activityID_) and manager.time:GetServerTime() < ActivityData:GetActivityData(self.activityID_).startTime then
		self.lockText_.text = string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.activityID_).startTime)))
	end
end

function ValentineGameV2SelectHeroItem:OnActivityUpdate(arg_9_1)
	if arg_9_1 == self.activityID_ then
		self:RefreshStatus()
	end
end

function ValentineGameV2SelectHeroItem:OnExit()
	manager.redPoint:unbindUIandKey(self.redTrans_, RedPointConst.VALENTINE_GAME .. "_" .. self.activityID_)
	self:RemoveAllEventListener()
end

function ValentineGameV2SelectHeroItem:Dispose()
	ValentineGameV2SelectHeroItem.super.Dispose(self)
end

return ValentineGameV2SelectHeroItem
