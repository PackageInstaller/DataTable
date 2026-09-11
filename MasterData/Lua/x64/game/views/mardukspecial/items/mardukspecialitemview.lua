local MardukSpecialItemView = class("MardukSpecialItemView", ReduxView)

function MardukSpecialItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MardukSpecialItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MardukSpecialItemView:InitUI()
	self:BindCfgUI()

	self.detailController_ = ControllerUtil.GetController(self.gameObject_.transform, "detail")
	self.raceController_ = ControllerUtil.GetController(self.gameObject_.transform, "race")
	self.viewController_ = ControllerUtil.GetController(self.gameObject_.transform, "view")
	self.detailraceController_ = ControllerUtil.GetController(self.detailtrans_, "color")
end

function MardukSpecialItemView:AddUIListener()
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
	self:AddBtnListener(self.closeBtn_, nil, function()
		if self.itemSelectHandler_ ~= nil then
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
			self.itemSelectHandler_(self.index_, false)
		end
	end)
	self:AddBtnListener(self.readyBtn_, nil, function()
		gameContext:Go("/sectionSelectHero", {
			section = BattleQuickTrainingCfg[ActivityQuickTrainingCfg[self.subActivityId_].stage_id].id,
			sectionType = BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL,
			activityID = self.subActivityId_
		})
	end)
end

function MardukSpecialItemView:AddEventListeners()
	return
end

function MardukSpecialItemView:ShowSelect(arg_9_1)
	if arg_9_1 then
		self.detailController_:SetSelectedState("true")
	else
		self.detailController_:SetSelectedState("false")
	end
end

function MardukSpecialItemView:SetItemSelectHandler(arg_10_1)
	self.itemSelectHandler_ = arg_10_1
end

function MardukSpecialItemView:SetData(arg_11_1, arg_11_2, arg_11_3)
	self.index_ = arg_11_1
	self.activityId_ = arg_11_2
	self.subActivityId_ = arg_11_3
	self.battleCfg_ = BattleQuickTrainingCfg[ActivityQuickTrainingCfg[self.subActivityId_].stage_id]

	self:UpdateView()
end

function MardukSpecialItemView:UpdateView()
	self.nameLabel1_.text = GetI18NText(self.battleCfg_.name)
	self.nameLabel2_.text = GetI18NText(self.battleCfg_.name)
	self.descLabel_.text = GetI18NText(self.battleCfg_.tips)
	self.scoreLabel1_.text = MardukSpecialData:GetPoint(self.subActivityId_)
	self.scoreLabel2_.text = MardukSpecialData:GetPoint(self.subActivityId_)

	if ActivityData:GetActivityIsOpen(self.subActivityId_) then
		self.viewController_:SetSelectedState("open")
		self.raceController_:SetSelectedIndex(self.index_ - 1)
		self.detailraceController_:SetSelectedIndex(self.index_ - 1)
	else
		self.viewController_:SetSelectedState("close")
		self.raceController_:SetSelectedIndex(self.index_ - 1)
		self.detailraceController_:SetSelectedIndex(self.index_ - 1)

		local var_12_0 = ActivityData:GetActivityData(self.subActivityId_)

		self.timeCntText_.text = var_12_0.stopTime < manager.time:GetServerTime() and GetTips("TIME_OVER") or string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(var_12_0.startTime)))
	end

	self:UpdateRedPoint()
end

function MardukSpecialItemView:UpdateTime()
	if not ActivityData:GetActivityIsOpen(self.subActivityId_) then
		local var_13_0 = ActivityData:GetActivityData(self.subActivityId_)

		self.timeCntText_.text = var_13_0.stopTime < manager.time:GetServerTime() and GetTips("TIME_OVER") or string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(var_13_0.startTime)))
	end
end

function MardukSpecialItemView:UpdateRedPoint()
	SetActive(self.redGo_, manager.redPoint:getTipValue(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, self.subActivityId_)) > 0 and true or false)
end

function MardukSpecialItemView:OnEnter()
	self:AddEventListeners()
end

function MardukSpecialItemView:OnExit()
	self:RemoveAllEventListener()
end

function MardukSpecialItemView:OnMainHomeViewTop()
	return
end

function MardukSpecialItemView:Dispose()
	self.data_ = nil

	MardukSpecialItemView.super.Dispose(self)
end

return MardukSpecialItemView
