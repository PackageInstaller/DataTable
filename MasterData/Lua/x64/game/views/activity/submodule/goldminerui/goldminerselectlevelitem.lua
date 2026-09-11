local GoldMinerSelectLevelItem = class("GoldMinerSelectLevelItem", ReduxView)

function GoldMinerSelectLevelItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2
	self.selectHandler_ = arg_1_3

	self:Init()
end

function GoldMinerSelectLevelItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function GoldMinerSelectLevelItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.controllerEx_:GetController("select")
	self.stateController_ = self.controllerEx_:GetController("state")
	self.starController1_ = self.starControllerEx1_:GetController("state")
	self.starController2_ = self.starControllerEx2_:GetController("state")
	self.starController3_ = self.starControllerEx3_:GetController("state")
	self.isUnlock_ = false
end

function GoldMinerSelectLevelItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("goldMinerStageSectionView", {
			activityID = self.activityID_,
			isActivityOpen = self.isActivityOpen_,
			isUnLock = self.isUnlock_
		})

		if self.selectHandler_ then
			self.selectHandler_(self.index_, self.activityID_)
		end
	end)
end

function GoldMinerSelectLevelItem:OnEnter(arg_6_1)
	self.activityID_ = arg_6_1
	self.cfg_ = ActivityGodEaterGoldminerStageCfg[self.activityID_]
	self.nameText_.text = self.cfg_.name

	self:RefreshStatus()
	self:RegistEventListener(ACTIVITY_UPDATE, handler(self, self.OnActivityUpdate))
end

function GoldMinerSelectLevelItem:OnActivityUpdate(arg_7_1)
	self.isActivityOpen_ = ActivityData:GetActivityIsOpen(self.activityID_)

	if arg_7_1 == self.activityID_ then
		self:RefreshStatus()
	end
end

function GoldMinerSelectLevelItem:RefreshStatus()
	self.isActivityOpen_ = ActivityData:GetActivityIsOpen(self.activityID_)

	if self.isActivityOpen_ then
		local var_8_0 = table.indexof(ActivityGodEaterGoldminerStageCfg.all, self.activityID_)

		if var_8_0 == 1 then
			self.isUnlock_ = true

			local var_8_1 = GodEaterData:GetStageStar(self.activityID_)

			if var_8_1 > 0 then
				self.stateController_:SetSelectedState("complet")

				for iter_8_0 = 1, 3 do
					if iter_8_0 <= var_8_1 then
						self["starController" .. iter_8_0 .. "_"]:SetSelectedState("light")
					else
						self["starController" .. iter_8_0 .. "_"]:SetSelectedState("dark")
					end
				end
			else
				self.stateController_:SetSelectedState("normal")
			end
		elseif GodEaterData:GetStageStar(ActivityGodEaterGoldminerStageCfg.all[var_8_0 - 1]) > 0 then
			self.isUnlock_ = true

			local var_8_2 = GodEaterData:GetStageStar(self.activityID_)

			if var_8_2 > 0 then
				self.stateController_:SetSelectedState("complet")

				for iter_8_1 = 1, 3 do
					if iter_8_1 <= var_8_2 then
						self["starController" .. iter_8_1 .. "_"]:SetSelectedState("light")
					else
						self["starController" .. iter_8_1 .. "_"]:SetSelectedState("dark")
					end
				end
			else
				self.stateController_:SetSelectedState("normal")
			end
		else
			self.stateController_:SetSelectedState("lock")
		end
	else
		self.stateController_:SetSelectedState("lock")
	end
end

function GoldMinerSelectLevelItem:RefreshSelect(arg_9_1)
	if self.isActivityOpen_ and self.isUnlock_ and arg_9_1 == self.activityID_ then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end
end

function GoldMinerSelectLevelItem:OnExit()
	self:RemoveAllEventListener()
end

function GoldMinerSelectLevelItem:Dispose()
	GoldMinerSelectLevelItem.super.Dispose(self)
end

return GoldMinerSelectLevelItem
