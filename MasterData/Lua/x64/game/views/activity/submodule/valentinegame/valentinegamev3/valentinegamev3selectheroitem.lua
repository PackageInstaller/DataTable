local ValentineGameV3SelectHeroItem = class("ValentineGameV3SelectHeroItem", ReduxView)

function ValentineGameV3SelectHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ValentineGameV3SelectHeroItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ValentineGameV3SelectHeroItem:InitUI()
	self:BindCfgUI()

	self.lockController_ = self.controllerEx_:GetController("lock")
	self.canReceiveController_ = self.controllerEx_:GetController("CanReceive")
	self.completionController_ = self.controllerEx_:GetController("Completion")
end

function ValentineGameV3SelectHeroItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if ActivityData:GetActivityIsOpen(self.subActivityID_) then
			local var_5_0 = getModule("ActivityValentineV3StageData")

			if var_5_0 == nil then
				var_5_0 = {}
			end

			table.insert(var_5_0, self.subActivityID_)
			saveModule("ActivityValentineV3StageData", var_5_0)
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_OPEN .. "_" .. self.subActivityID_, 0)
			JumpTools.OpenPageByJump("/valentineGameV3SelectStageView", {
				mainActivityID = self.mainActivityID_,
				subActivityID = self.subActivityID_
			})
		elseif manager.time:GetServerTime() < ActivityData:GetActivityData(self.subActivityID_).startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.subActivityID_).startTime))))
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
end

function ValentineGameV3SelectHeroItem:SetData(arg_6_1, arg_6_2)
	self.mainActivityID_ = arg_6_1
	self.subActivityID_ = arg_6_2
	self.cfg_ = ActivityValentineV3StageCfg[self.subActivityID_]
	self.nameText_.text = HeroCfg[self.cfg_.hero_id] and HeroCfg[self.cfg_.hero_id].suffix or GetTips("ERROR_NO_TEMPLATE")
	self.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.cfg_.hero_id)
	self.heroImage_.transform.localPosition = Vector3(self.cfg_.offset[1], self.cfg_.offset[2], 0)
	self.heroBgImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.cfg_.hero_id)
	self.heroBgImage_.transform.localPosition = Vector3(self.cfg_.offset[1], self.cfg_.offset[2], 0)

	self:RefreshStatus()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.VALENTINE_GAME .. "_" .. self.subActivityID_)
	self:RegistEventListener(ACTIVITY_UPDATE, handler(self, self.OnActivityUpdate))
end

function ValentineGameV3SelectHeroItem:RefreshStatus()
	if ActivityData:GetActivityIsOpen(self.subActivityID_) then
		self.lockController_:SetSelectedState("false")

		local var_7_0 = 0
		local var_7_1 = PlayerData:GetStoryList()
		local var_7_2 = false

		for iter_7_0 = 1, 3 do
			if var_7_1[self.cfg_["stage_storyid_and_dorpid_" .. iter_7_0][1]] == true then
				var_7_0 = var_7_0 + 1

				if not ValentineGameData:GetStoryIDIsGetReward(self.cfg_["stage_storyid_and_dorpid_" .. iter_7_0][1]) then
					var_7_2 = true
				end
			end
		end

		self.completionController_:SetSelectedState(var_7_0)

		if var_7_2 then
			self.canReceiveController_:SetSelectedState("true")
		else
			self.canReceiveController_:SetSelectedState("false")
		end
	else
		self.lockController_:SetSelectedState("true")

		self.lockText_.text = manager.time:GetServerTime() < ActivityData:GetActivityData(self.subActivityID_).startTime and string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.subActivityID_).startTime))) or GetTips("TIME_OVER")

		self.canReceiveController_:SetSelectedState("false")
	end
end

function ValentineGameV3SelectHeroItem:RefreshTimeText()
	if not ActivityData:GetActivityIsOpen(self.subActivityID_) and manager.time:GetServerTime() < ActivityData:GetActivityData(self.subActivityID_).startTime then
		self.lockText_.text = string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.subActivityID_).startTime)))
	end
end

function ValentineGameV3SelectHeroItem:OnActivityUpdate(arg_9_1)
	if arg_9_1 == self.subActivityID_ then
		self:RefreshStatus()
	end
end

function ValentineGameV3SelectHeroItem:OnExit()
	manager.redPoint:unbindUIandKey(self.redTrans_, RedPointConst.VALENTINE_GAME .. "_" .. self.subActivityID_)
	self:RemoveAllEventListener()
end

function ValentineGameV3SelectHeroItem:Dispose()
	ValentineGameV3SelectHeroItem.super.Dispose(self)
end

return ValentineGameV3SelectHeroItem
