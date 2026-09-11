local DrawRightBonusItem = class("DrawRightBonusItem", ReduxView)

function DrawRightBonusItem:UIName()
	return "Widget/System/Pool/ExtractReturnBtnNew"
end

function DrawRightBonusItem:Ctor(arg_2_1)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), arg_2_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = self.controllerEx_:GetController("state")
	self.colorController_ = self.controllerEx_:GetController("color")
	self.onModifyBonusHandler_ = handler(self, self.OnModifyBonus)
end

function DrawRightBonusItem:OnEnter()
	manager.notify:RegistListener(UPDATE_ACTIVITY_POOL_BONUS, self.onModifyBonusHandler_)
end

function DrawRightBonusItem:OnExit()
	manager.notify:RemoveListener(UPDATE_ACTIVITY_POOL_BONUS, self.onModifyBonusHandler_)
end

function DrawRightBonusItem:Dispose()
	self.onModifyBonusHandler_ = nil

	DrawRightBonusItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transfrom_ = nil
end

function DrawRightBonusItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if DrawTools.GetBonusCnt(self.activityID_) > 0 then
			DrawAction.ReceivePoolBonus(self.activityID_, function()
				self:RefreshText()
			end)
		end
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		DrawAction.GetPoolData(self.selectPoolID_)
	end)
end

function DrawRightBonusItem:SetData(arg_10_1, arg_10_2)
	self.activityID_ = arg_10_1
	self.selectPoolID_ = arg_10_2

	local var_10_0 = ActivityDrawBonusCfg[arg_10_1].reward[1][1]

	ItemTools.GetItemSpriteAsync(ActivityDrawBonusCfg[arg_10_1].reward[1][1], function(arg_11_0, arg_11_1)
		if self.gameObject_ == nil then
			return
		end

		if arg_11_0 == var_10_0 then
			self.icon_.sprite = arg_11_1
		end
	end, nil, true)

	self.needNumText_.text = string.format("/%s", ActivityDrawBonusCfg[arg_10_1].need)

	self.anim_:Play("UI_ExtractReturnBtn_cx", 0, 0)
	self.anim_:Update(0)
	self:RefreshText()
end

function DrawRightBonusItem:RefreshText()
	self.curOldNumText_.text = DrawData:GetOldPoolBonus(self.activityID_)
	self.curNumText_.text = DrawData:GetPoolBonus(self.activityID_)

	self.animator_:Play("UI_num_cx", 0, 1)
	self.animator2_:Play("UI_text_cx", 0, 1)

	local var_12_0 = DrawTools.GetBonusCnt(self.activityID_)

	if var_12_0 == 0 then
		var_12_0 = ActivityDrawBonusCfg[self.activityID_].reward[1][2]

		self.controller_:SetSelectedState("normal")
		self.colorController_:SetSelectedState("normal")
	else
		self.controller_:SetSelectedState("claimable")
		self.colorController_:SetSelectedState("orange")
	end

	self.bonusText1_.text = string.format("x%s", var_12_0)
	self.bonusText2_.text = string.format("x%s", var_12_0)
	self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(self.activityID_).stopTime)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.timeTrs_)
	self:Show(true)
end

function DrawRightBonusItem:PrePlayAnimator()
	local var_13_0 = math.floor(DrawData:GetOldPoolBonus(self.activityID_) / ActivityDrawBonusCfg[self.activityID_].need)

	if math.floor(DrawData:GetPoolBonus(self.activityID_) / ActivityDrawBonusCfg[self.activityID_].need) > 0 then
		self.animator2_:Play("UI_text_cx", 0, 0)
		self.animator2_:Update(0)
		self.colorController_:SetSelectedState("orange")
	else
		self.colorController_:SetSelectedState("normal")
	end
end

function DrawRightBonusItem:PlayAnimator()
	local var_14_0 = DrawData:GetOldPoolBonus(self.activityID_)
	local var_14_1 = DrawData:GetPoolBonus(self.activityID_)
	local var_14_2 = math.floor(var_14_0 / ActivityDrawBonusCfg[self.activityID_].need)

	if var_14_0 ~= var_14_1 then
		self.curNumText_.text = var_14_1
		self.curOldNumText_.text = var_14_0

		self.animator_:Play("UI_num_cx", 0, 0)
		self.animator_:Update(0)

		if math.floor(var_14_1 / ActivityDrawBonusCfg[self.activityID_].need) > 0 then
			self.animator2_:Play("UI_text_cx", 0, 0)
			self.animator2_:Update(0)
		else
			self.animator2_:Play("UI_text_cx", 0, 1)
			self.animator2_:Update(0)
		end

		DrawData:SetOldPoolBonus(self.activityID_, var_14_1)
	else
		self.animator_:Play("UI_num_cx", 0, 1)
		self.animator2_:Play("UI_text_cx", 0, 1)
		self.animator2_:Update(0)
	end
end

function DrawRightBonusItem:OnModifyBonus()
	self:RefreshText()
end

function DrawRightBonusItem:Show(arg_16_1)
	SetActive(self.gameObject_, arg_16_1)
end

return DrawRightBonusItem
