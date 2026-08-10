local var_0_0 = class("DanceActionSlot", DanceActionItem)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)

	arg_1_0.emptyController = arg_1_0.controllers_:GetController("empty")
	arg_1_0.acceptControlelr = arg_1_0.controllers_:GetController("accept")
end

function var_0_0.Dispose(arg_2_0)
	if arg_2_0.marker then
		arg_2_0.marker:Dispose()
		GameObject.Destroy(arg_2_0.marker.gameObject_)

		arg_2_0.marker = nil
	end

	var_0_0.super.Dispose(arg_2_0)
end

local var_0_1 = class("DanceActionSlot.SlotMarker", BaseView)

function var_0_1.Ctor(arg_3_0, arg_3_1)
	arg_3_0.gameObject_ = arg_3_1
	arg_3_0.transform_ = arg_3_1.transform

	arg_3_0:BindCfgUI(arg_3_1)

	arg_3_0.selectController = arg_3_0.controllers_:GetController("select")
	arg_3_0.stateController = arg_3_0.controllers_:GetController("state")

	arg_3_0:AddBtnListener(arg_3_0.btn, nil, function()
		manager.notify:CallFirstUpdateFunc("OnDanceActionSlotMarkerClicked", arg_3_0)
	end)
end

function var_0_1.LinkToSlot(arg_5_0, arg_5_1)
	arg_5_0.slot = arg_5_1
end

function var_0_0.GenLinkedMarker(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = GameObject.Instantiate(arg_6_1, arg_6_2)

	arg_6_0.marker = var_0_1.New(var_6_0)

	arg_6_0.marker:LinkToSlot(arg_6_0)
end

function var_0_0.IsEmptySlot(arg_7_0)
	return nullable(IdolDanceDIYActionCfg, arg_7_0.actionID) == nil
end

local function var_0_2(arg_8_0, arg_8_1)
	return function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1 and "true" or "false"

		arg_9_0[arg_8_0]:SetSelectedState(var_9_0)

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
	local var_10_1 = var_10_0:GetSelectedState()

	if arg_10_1 == "playStateController" then
		if arg_10_2 == "play" then
			var_10_1 = "play"
		else
			var_10_1 = nullable(IdolDanceDIYActionCfg, arg_10_0.actionID) and "normal" or "empty"
		end
	elseif arg_10_1 == "emptyController" and var_10_1 ~= "play" then
		var_10_1 = arg_10_2 and "empty" or "normal"
	end

	var_10_0:SetSelectedState(var_10_1)
end

var_0_0.SetEmpty = var_0_2("emptyController", var_0_3)
var_0_0.SetSelected = var_0_2("selectController")

function var_0_0.SetPlayState(arg_11_0, arg_11_1)
	arg_11_0.playStateController:SetSelectedState(arg_11_1)

	if arg_11_0.marker then
		var_0_3(arg_11_0, "playStateController", arg_11_1)
	end
end

local var_0_4 = {
	[1] = 16,
	[2] = 32
}

local function var_0_5(arg_12_0, arg_12_1)
	return GetTipsF("IDOL_DANCE_ACTION_BEAT", arg_12_0)
end

function var_0_0.SetData(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.actionID = arg_13_1

	local var_13_0 = nullable(IdolDanceDIYActionCfg, arg_13_1)
	local var_13_1
	local var_13_2 = var_0_4[arg_13_2]

	if arg_13_2 then
		local var_13_3 = var_0_5(var_13_2, var_13_2)

		arg_13_0.beat2_.text = var_13_3
	end

	if var_13_0 then
		arg_13_0.name_.text = var_13_0.name
		arg_13_0.beat_.text = var_0_5(var_13_0.beat, var_13_2)

		local var_13_4 = var_13_0.type

		arg_13_0.style_.text = GetTips(IdolTraineeConst.style[var_13_4])
		arg_13_0.color_.color = IdolTraineeConst.styleColor[var_13_4]

		arg_13_0:SetEmpty(false)
	else
		arg_13_0:SetEmpty(true)
	end
end

function var_0_0.SetTime(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.ntStart = arg_14_1 or arg_14_0.ntStart
	arg_14_0.ntEnd = arg_14_2 or arg_14_0.ntEnd
end

function var_0_0.SetFilter(arg_15_0, arg_15_1)
	arg_15_0.filter = arg_15_1
end

local function var_0_6(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_1.rect.width
	local var_16_1 = arg_16_1.rect.height
	local var_16_2 = Mathf.Lerp(0, var_16_0, arg_16_2)
	local var_16_3 = Mathf.Lerp(0, var_16_0, arg_16_3)

	arg_16_0.pivot = Vector2(0, 0.5)
	arg_16_0.anchorMin = Vector2(0, 0.5)
	arg_16_0.anchorMax = Vector2(0, 0.5)
	arg_16_0.anchoredPosition = Vector2(var_16_2, 0)
	arg_16_0.sizeDelta = Vector2(var_16_3 - var_16_2, arg_16_0.sizeDelta.y)
end

function var_0_0.UpdatePosByTimeInfo(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.transform_.parent
	local var_17_1 = arg_17_1 or arg_17_0.ntStart
	local var_17_2 = arg_17_2 or arg_17_0.ntEnd

	arg_17_0.left, arg_17_0.right = var_17_1, var_17_2

	var_0_6(arg_17_0.transform_, var_17_0, var_17_1, var_17_2)

	if arg_17_0.marker then
		var_0_6(arg_17_0.marker.transform_, arg_17_0.marker.transform_.parent, var_17_1, var_17_2)
	end
end

function var_0_0.OnPreviewUpdate(arg_18_0, arg_18_1)
	var_0_0.super.OnPreviewUpdate(arg_18_0, arg_18_1)

	if arg_18_0.progressUpdateFunc then
		arg_18_0.progressUpdateFunc(arg_18_1)
	end
end

function var_0_0.SetOnProgressUpdate(arg_19_0, arg_19_1)
	arg_19_0.progressUpdateFunc = arg_19_1
end

function var_0_0.WillAcceptDrop(arg_20_0, arg_20_1)
	if isa(arg_20_1, DanceActionItem) then
		if arg_20_0.filter then
			return arg_20_0.filter(arg_20_1.actionID)
		else
			return true
		end
	end
end

function var_0_0.OnDropAccepted(arg_21_0, arg_21_1)
	arg_21_0:Swap(arg_21_1)
end

function var_0_0.SetDisplayAcccept(arg_22_0, arg_22_1)
	arg_22_0.acceptControlelr:SetSelectedState(arg_22_1 and "true" or "false")
end

function var_0_0.OnPointerDown(arg_23_0)
	return
end

function var_0_0.OnPointerClick(arg_24_0, arg_24_1)
	manager.notify:CallFirstUpdateFunc("OnDanceActionSlotPointerClick", arg_24_0)
end

function var_0_0.GetDropAreaRect(arg_25_0)
	return arg_25_0.transform_
end

function var_0_0.Dragable(arg_26_0)
	return not arg_26_0:IsEmptySlot() and not arg_26_0.readOnly
end

function var_0_0.FilterByBeat(arg_27_0)
	return function(arg_28_0)
		return nullable(IdolDanceDIYActionCfg, arg_28_0, "beat") == arg_27_0
	end
end

var_0_0.Accept8BeatActionFilter = var_0_0.FilterByBeat(8)
var_0_0.Accept16BeatActionFilter = var_0_0.FilterByBeat(16)
var_0_0.Accept32BeatActionFilter = var_0_0.FilterByBeat(32)

return var_0_0
