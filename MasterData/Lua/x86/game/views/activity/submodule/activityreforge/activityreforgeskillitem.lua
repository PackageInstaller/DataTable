local ActivityReforgeSkillItem = class("ActivityReforgeSkillItem", ReduxView)

function ActivityReforgeSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityReforgeSkillItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeSkillItem:InitUI()
	self:BindCfgUI()

	self.skillUseStateController_ = self.controllerEx_:GetController("skillUseState")
	self.selectController_ = self.controllerEx_:GetController("select")
	self.skillStatusController_ = self.controllerEx_:GetController("skillStatus")
end

function ActivityReforgeSkillItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.redPoint:setTip(RedPointConst.ACTIVITY_REFORGE_SKILL .. self.skillID_, 0)

		if self.clickHandle_ then
			self.clickHandle_(self.skillID_)
		end
	end)
end

function ActivityReforgeSkillItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	self.viewType_ = arg_6_1
	self.skillID_ = arg_6_2

	local var_6_0 = ActivityReforgeSkillCfg[self.skillID_]

	self.clickHandle_ = arg_6_3
	self.activityID_ = arg_6_4
	self.levelID_ = arg_6_5
	self.curSkillID_ = arg_6_6

	if self.skillID_ == self.curSkillID_ then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end

	self.iconImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", var_6_0.icon)
	self.skillNameText_.text = var_6_0.name

	if self.viewType_ == 1 then
		if ActivityReforgeData:GetSkillIsLock(self.activityID_, self.skillID_) then
			self.skillUseStateController_:SetSelectedState("illustratedLock")
		elseif var_6_0.count == -1 then
			self.skillUseStateController_:SetSelectedState("freeNormal")
		else
			self.skillUseStateController_:SetSelectedState("normal")
			self.skillStatusController_:SetSelectedState("useNum" .. var_6_0.count)

			for iter_6_0 = 1, 3 do
				SetActive(self["useNumGo" .. iter_6_0 .. "_"], true)
			end
		end
	else
		self.skillStatus_, self.skillCanUseNum_ = ActivityReforgeData:GetSkillStatus(self.activityID_, self.levelID_, self.skillID_)

		self.skillUseStateController_:SetSelectedState(self.skillStatus_)

		if self.skillStatus_ == "using" or self.skillStatus_ == "normal" or self.skillStatus_ == "lock" or self.skillStatus_ == "haveNot" or self.skillStatus_ == "ban" then
			self.skillStatusController_:SetSelectedState("useNum" .. var_6_0.count)

			if self.skillStatus_ == "using" or self.skillStatus_ == "normal" then
				for iter_6_1 = 1, 3 do
					if iter_6_1 <= self.skillCanUseNum_ then
						SetActive(self["useNumGo" .. iter_6_1 .. "_"], true)
					else
						SetActive(self["useNumGo" .. iter_6_1 .. "_"], false)
					end
				end
			else
				for iter_6_2 = 1, 3 do
					SetActive(self["useNumGo" .. iter_6_2 .. "_"], false)
				end
			end
		end
	end

	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.ACTIVITY_REFORGE_SKILL .. self.skillID_)
end

function ActivityReforgeSkillItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.ACTIVITY_REFORGE_SKILL .. self.skillID_)
end

function ActivityReforgeSkillItem:SetIsActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function ActivityReforgeSkillItem:Dispose()
	self.clickHandle_ = nil

	Object.Destroy(self.gameObject_)
	ActivityReforgeSkillItem.super.Dispose(self)
end

return ActivityReforgeSkillItem
