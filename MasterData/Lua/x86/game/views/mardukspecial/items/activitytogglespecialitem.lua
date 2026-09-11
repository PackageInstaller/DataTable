local ActivityToggleSpecialItem = class("ActivityToggleSpecialItem", ReduxView)

function ActivityToggleSpecialItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityToggleSpecialItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityToggleSpecialItem:InitUI()
	self:BindCfgUI()

	self.activityOpenHandler_ = handler(self, self.ActivityOpen)
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
end

function ActivityToggleSpecialItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.subActivityId_) then
			if ActivityData:GetActivityData(self.subActivityId_).stopTime < manager.time:GetServerTime() then
				ShowTips(GetTips("TIME_OVER"))
			else
				ShowTips(string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.subActivityId_).startTime))))
			end

			return
		end

		if self.itemSelectHandler_ ~= nil then
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
			self.itemSelectHandler_(self.index_, true)
		end

		MardukSpecialAction.ClickMardukSpecial(self.subActivityId_)
		self:UpdateRedPoint()
	end)
	self:AddBtnListener(self.readyBtn_, nil, function()
		gameContext:Go("/sectionSelectHero", {
			section = BattleQuickTrainingCfg[ActivityQuickTrainingCfg[self.subActivityId_].stage_id].id,
			sectionType = BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL,
			activityID = self.subActivityId_
		})
	end)
end

function ActivityToggleSpecialItem:AddEventListeners()
	manager.notify:RegistListener(ACTIVITY_UPDATE, self.activityOpenHandler_)
end

function ActivityToggleSpecialItem:ShowSelect(arg_8_1)
	if arg_8_1 then
		self.statusController_:SetSelectedState("select")

		self.panelTrans_.sizeDelta = Vector2(self.panelTrans_.rect.width, 470)
	else
		self.statusController_:SetSelectedState("normal")

		self.panelTrans_.sizeDelta = Vector2(self.panelTrans_.rect.width, 140)
	end
end

function ActivityToggleSpecialItem:ActivityOpen(arg_9_1)
	if arg_9_1 == self.subActivityId_ then
		self:UpdateView()
	end
end

function ActivityToggleSpecialItem:SetItemSelectHandler(arg_10_1)
	self.itemSelectHandler_ = arg_10_1
end

function ActivityToggleSpecialItem:SetData(arg_11_1, arg_11_2, arg_11_3)
	self.index_ = arg_11_1
	self.activityId_ = arg_11_2
	self.subActivityId_ = arg_11_3
	self.battleCfg_ = BattleQuickTrainingCfg[ActivityQuickTrainingCfg[self.subActivityId_].stage_id]

	self:UpdateView()
end

function ActivityToggleSpecialItem:UpdateView()
	self.nameLabel1_.text = self.battleCfg_.name
	self.descLabel_.text = self.battleCfg_.tips
	self.scoreLabel1_.text = MardukSpecialData:GetPoint(self.subActivityId_)
	self.bgImage_.sprite = getSprite("Atlas/XuHeng3rdUI", ActivityQuickTrainingCfg[self.subActivityId_].bg_id)
	self.iconImage_.sprite = getSprite("Atlas/CampItemAtlas", ActivityQuickTrainingCfg[self.subActivityId_].icon_id)

	if ActivityData:GetActivityIsOpen(self.subActivityId_) then
		self.statusController_:SetSelectedState("normal")

		self.panelTrans_.sizeDelta = Vector2(self.panelTrans_.rect.width, 140)
	else
		self.statusController_:SetSelectedState("lock")

		self.panelTrans_.sizeDelta = Vector2(self.panelTrans_.rect.width, 140)

		local var_12_0 = ActivityData:GetActivityData(self.subActivityId_)

		self.timeCntText_.text = var_12_0.stopTime < manager.time:GetServerTime() and GetTips("TIME_OVER") or string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(var_12_0.startTime)))
	end

	self:UpdateRedPoint()
end

function ActivityToggleSpecialItem:UpdateTime()
	if not ActivityData:GetActivityIsOpen(self.subActivityId_) then
		local var_13_0 = ActivityData:GetActivityData(self.subActivityId_)

		self.timeCntText_.text = var_13_0.stopTime < manager.time:GetServerTime() and GetTips("TIME_OVER") or string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(var_13_0.startTime)))
	end
end

function ActivityToggleSpecialItem:UpdateRedPoint()
	SetActive(self.redGo_, manager.redPoint:getTipValue(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, self.subActivityId_)) > 0 and true or false)
end

function ActivityToggleSpecialItem:OnEnter()
	self:AddEventListeners()
end

function ActivityToggleSpecialItem:OnExit()
	self:RemoveAllEventListener()
end

function ActivityToggleSpecialItem:RemoveAllEventListener()
	manager.notify:RemoveListener(ACTIVITY_UPDATE, self.activityOpenHandler_)
	ActivityToggleSpecialItem.super.RemoveAllEventListener(self)
end

function ActivityToggleSpecialItem:OnMainHomeViewTop()
	return
end

function ActivityToggleSpecialItem:Dispose()
	self.data_ = nil
	self.activityOpenHandler_ = nil

	ActivityToggleSpecialItem.super.Dispose(self)
end

return ActivityToggleSpecialItem
