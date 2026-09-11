local PaChinKoMainTriggerBox = class("PaChinKoMainTriggerBox", ReduxView)

function PaChinKoMainTriggerBox:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.triggerItem_ = {}

	for iter_1_0 = 1, 3 do
		self.triggerItem_[iter_1_0] = PaChinKoMainTriggerItem.New(self[string.format("uiTriggerGo%s_", iter_1_0)], iter_1_0)
	end

	self.spaceValue_ = self.uiLayoutGroup_.spacing
	self.widthValue = self.uiRectTf_.rect.width
	self.greyController_ = self.uiControllerEx_:GetController("grey")
	self.baffleWidth_ = self[string.format("uiBaffleGo%s_", 1)]:GetComponent(typeof(RectTransform)).sizeDelta.x
end

function PaChinKoMainTriggerBox:Dispose()
	for iter_2_0, iter_2_1 in ipairs(self.triggerItem_) do
		iter_2_1:Dispose()
	end

	self.triggerItem_ = nil

	PaChinKoMainTriggerBox.super.Dispose(self)
end

function PaChinKoMainTriggerBox:AddListeners()
	return
end

function PaChinKoMainTriggerBox:RefreshTrigger(arg_4_1)
	self.activityID_ = arg_4_1

	self:RefreshUI()
end

function PaChinKoMainTriggerBox:RefreshUI()
	local var_5_0 = {}
	local var_5_1 = PaChinKoTools.GetPrizeDistribution(self.activityID_)

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		table.insert(var_5_0, #var_5_1 - iter_5_0 + 1, iter_5_1)
	end

	local var_5_2 = 0

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		if iter_5_3 == 0 then
			var_5_2 = var_5_2 + 1
		end

		SetActive(self[string.format("uiBaffleGo%s_", iter_5_2)], iter_5_3 ~= 0)
		SetActive(self[string.format("uiTriggerGo%s_", iter_5_2)], iter_5_3 ~= 0)
	end

	if var_5_2 == #var_5_0 then
		self.greyController_:SetSelectedState("grey")

		return
	end

	self.greyController_:SetSelectedState("normal")

	for iter_5_4, iter_5_5 in ipairs(var_5_0) do
		self.triggerItem_[iter_5_4]:SetWidth(iter_5_5 * ((self.widthValue - self.spaceValue_ * ((#var_5_0 - var_5_2) * 2) - self.baffleWidth_ * (#var_5_0 - var_5_2)) / 10))
	end
end

function PaChinKoMainTriggerBox:PlayEffect(arg_6_1)
	self.triggerItem_[arg_6_1]:PlayEffect()
end

return PaChinKoMainTriggerBox
