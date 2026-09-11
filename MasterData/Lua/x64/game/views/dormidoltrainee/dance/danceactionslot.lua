local DanceActionSlot = class("DanceActionSlot", DanceActionItem)

function DanceActionSlot:InitUI()
	DanceActionSlot.super.InitUI(self)

	self.emptyController = self.controllers_:GetController("empty")
	self.acceptControlelr = self.controllers_:GetController("accept")
end

function DanceActionSlot:Dispose()
	if self.marker then
		self.marker:Dispose()
		GameObject.Destroy(self.marker.gameObject_)

		self.marker = nil
	end

	DanceActionSlot.super.Dispose(self)
end

local var_0_1 = class("DanceActionSlot.SlotMarker", BaseView)

function var_0_1:Ctor(arg_3_1)
	self.gameObject_ = arg_3_1
	self.transform_ = arg_3_1.transform

	self:BindCfgUI(arg_3_1)

	self.selectController = self.controllers_:GetController("select")
	self.stateController = self.controllers_:GetController("state")

	self:AddBtnListener(self.btn, nil, function()
		manager.notify:CallFirstUpdateFunc("OnDanceActionSlotMarkerClicked", self)
	end)
end

function var_0_1:LinkToSlot(arg_5_1)
	self.slot = arg_5_1
end

function DanceActionSlot:GenLinkedMarker(arg_6_1, arg_6_2)
	self.marker = var_0_1.New((GameObject.Instantiate(arg_6_1, arg_6_2)))

	self.marker:LinkToSlot(self)
end

function DanceActionSlot:IsEmptySlot()
	return nullable(IdolDanceDIYActionCfg, self.actionID) == nil
end

local function var_0_2(arg_8_0, arg_8_1)
	return function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1 and "true" or "false"

		arg_9_0[arg_8_0]:SetSelectedState(arg_9_1 and "true" or "false")

		if arg_9_0.marker then
			if arg_8_1 then
				arg_8_1(arg_9_0, arg_8_0, arg_9_1)
			else
				arg_9_0.marker[arg_8_0]:SetSelectedState(var_9_0)
			end
		end
	end
end

local function var_0_3(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.marker.stateController
	local var_10_1 = arg_10_0.marker.stateController:GetSelectedState()

	if arg_10_1 == "playStateController" then
		var_10_1 = arg_10_2 == "play" and "play" or nullable(IdolDanceDIYActionCfg, arg_10_0.actionID) and "normal" or "empty"
	elseif arg_10_1 == "emptyController" and var_10_1 ~= "play" then
		var_10_1 = arg_10_2 and "empty" or "normal"
	end

	var_10_0:SetSelectedState(var_10_1)
end

DanceActionSlot.SetEmpty = var_0_2("emptyController", var_0_3)
DanceActionSlot.SetSelected = var_0_2("selectController")

function DanceActionSlot:SetPlayState(arg_11_1)
	self.playStateController:SetSelectedState(arg_11_1)

	if self.marker then
		var_0_3(self, "playStateController", arg_11_1)
	end
end

local var_0_4 = {
	[1] = 16,
	[2] = 32
}

local function var_0_5(arg_12_0, arg_12_1)
	return GetTipsF("IDOL_DANCE_ACTION_BEAT", arg_12_0)
end

function DanceActionSlot:SetData(arg_13_1, arg_13_2)
	self.actionID = arg_13_1

	local var_13_0 = nullable(IdolDanceDIYActionCfg, arg_13_1)

	if arg_13_2 then
		self.beat2_.text = var_0_5(var_0_4[arg_13_2], var_0_4[arg_13_2])
	end

	if var_13_0 then
		self.name_.text = var_13_0.name
		self.beat_.text = var_0_5(var_13_0.beat, var_0_4[arg_13_2])
		self.style_.text = GetTips(IdolTraineeConst.style[var_13_0.type])
		self.color_.color = IdolTraineeConst.styleColor[var_13_0.type]

		self:SetEmpty(false)
	else
		self:SetEmpty(true)
	end
end

function DanceActionSlot:SetTime(arg_14_1, arg_14_2)
	self.ntStart = arg_14_1 or self.ntStart
	self.ntEnd = arg_14_2 or self.ntEnd
end

function DanceActionSlot:SetFilter(arg_15_1)
	self.filter = arg_15_1
end

local function var_0_6(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_1 = Mathf.Lerp(0, arg_16_1.rect.width, arg_16_2)

	arg_16_0.pivot = Vector2(0, 0.5)
	arg_16_0.anchorMin = Vector2(0, 0.5)
	arg_16_0.anchorMax = Vector2(0, 0.5)
	arg_16_0.anchoredPosition = Vector2(var_16_1, 0)
	arg_16_0.sizeDelta = Vector2(Mathf.Lerp(0, arg_16_1.rect.width, arg_16_3) - var_16_1, arg_16_0.sizeDelta.y)
end

function DanceActionSlot:UpdatePosByTimeInfo(arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1 or self.ntStart
	local var_17_1 = arg_17_2 or self.ntEnd

	self.left, self.right = arg_17_1 or self.ntStart, arg_17_2 or self.ntEnd

	var_0_6(self.transform_, self.transform_.parent, var_17_0, var_17_1)

	if self.marker then
		var_0_6(self.marker.transform_, self.marker.transform_.parent, var_17_0, var_17_1)
	end
end

function DanceActionSlot:OnPreviewUpdate(arg_18_1)
	DanceActionSlot.super.OnPreviewUpdate(self, arg_18_1)

	if self.progressUpdateFunc then
		self.progressUpdateFunc(arg_18_1)
	end
end

function DanceActionSlot:SetOnProgressUpdate(arg_19_1)
	self.progressUpdateFunc = arg_19_1
end

function DanceActionSlot:WillAcceptDrop(arg_20_1)
	if isa(arg_20_1, DanceActionItem) then
		if self.filter then
			return self.filter(arg_20_1.actionID)
		else
			return true
		end
	end
end

function DanceActionSlot:OnDropAccepted(arg_21_1)
	self:Swap(arg_21_1)
end

function DanceActionSlot:SetDisplayAcccept(arg_22_1)
	self.acceptControlelr:SetSelectedState(arg_22_1 and "true" or "false")
end

function DanceActionSlot:OnPointerDown()
	return
end

function DanceActionSlot:OnPointerClick(arg_24_1)
	manager.notify:CallFirstUpdateFunc("OnDanceActionSlotPointerClick", self)
end

function DanceActionSlot:GetDropAreaRect()
	return self.transform_
end

function DanceActionSlot:Dragable()
	return not self:IsEmptySlot() and not self.readOnly
end

function DanceActionSlot:FilterByBeat()
	return function(arg_28_0)
		return nullable(IdolDanceDIYActionCfg, arg_28_0, "beat") == self
	end
end

DanceActionSlot.Accept8BeatActionFilter = DanceActionSlot.FilterByBeat(8)
DanceActionSlot.Accept16BeatActionFilter = DanceActionSlot.FilterByBeat(16)
DanceActionSlot.Accept32BeatActionFilter = DanceActionSlot.FilterByBeat(32)

return DanceActionSlot
