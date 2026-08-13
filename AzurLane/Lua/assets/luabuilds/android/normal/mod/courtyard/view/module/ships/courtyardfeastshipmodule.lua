class = var_0_10000

local var_0_0 = "CourtYardFeastShipModule"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardShipModule"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.feastAttachments = var_1.Find(var_1_0, "feastAttachments")

	local var_1_1 = {}
	local var_1_2 = arg_1_0._tf

	var_1_1[1] = var_2.Find(var_1_2, "feastAttachments/greet")

	local var_1_3 = arg_1_0._tf

	var_1_1[2] = var_2.Find(var_1_3, "feastAttachments/drink")

	local var_1_4 = arg_1_0._tf

	var_1_1[3] = var_2.Find(var_1_4, "feastAttachments/eat")

	local var_1_5 = arg_1_0._tf

	var_1_1[4] = var_2.Find(var_1_5, "feastAttachments/dance")

	local var_1_6 = arg_1_0._tf

	var_1_1[5] = var_2.Find(var_1_6, "feastAttachments/sleep")
	arg_1_0.bubbles = var_1_1

	local var_1_7 = {}
	local var_1_8 = arg_1_0._tf

	var_1_7[1] = var_2.Find(var_1_8, "feastAttachments/express/1")

	local var_1_9 = arg_1_0._tf

	var_1_7[2] = var_2.Find(var_1_9, "feastAttachments/express/2")

	local var_1_10 = arg_1_0._tf

	var_1_7[3] = var_2.Find(var_1_10, "feastAttachments/express/3")

	local var_1_11 = arg_1_0._tf

	var_1_7[4] = var_2.Find(var_1_11, "feastAttachments/express/4")
	arg_1_0.expressList = var_1_7

	local var_1_12 = arg_1_0._tf

	arg_1_0.chatBubble = var_1.Find(var_1_12, "feastAttachments/chat")

	local var_1_13 = arg_1_0._tf
	local var_1_14 = var_1.Find(var_1_13, "feastAttachments/chat/Text")
	local var_1_15 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_1_0.chatBubbleTxt = var_1_15(var_1_14, var_3(var_4))

	local var_1_16 = arg_1_0._tf

	arg_1_0.specialMark = var_1.Find(var_1_16, "feastAttachments/specialmark")
	setActive = var_1

	var_1(arg_1_0.chatBubble, false)

	setParent = var_1

	var_1(arg_1_0.specialMark, arg_1_0._tf)

	local var_1_17 = arg_1_0.specialMark

	var_1.SetAsFirstSibling(var_1_17)

	local var_1_18 = arg_1_0.specialMark

	Vector3 = var_1_17
	var_1_18.localScale = var_1_17(2, 2, 1)

	arg_1_0:InitMark()

	arg_1_0.timers = {}

	return
end

function var_0_1.InitMark(arg_2_0)
	setActive = var_1_10001

	local var_2_0 = arg_2_0.specialMark
	local var_2_1 = arg_2_0.data

	var_1_10001(var_2_0, var_3.IsSpecial(var_2_1))
	arg_2_0:OnFeastBubbleChange(arg_2_0.data.bubble)

	local var_2_2 = arg_2_0.bubbles[1]
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Image = var_2_1

	local var_2_4 = var_2_3(var_2_2, var_3(var_2_1))

	var_2_4.raycastTarget = true
	onButton = var_2_4

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.bubbles[1]

	local function var_2_7()
		triggerButton = var_2_10000

		var_2_10000(arg_2_0.clickTF)

		return
	end

	SFX_PANEL = var_1_10005

	var_2_4(var_2_5, var_2_6, var_2_7, var_1_10005)

	return
end

function var_0_1.AddListeners(arg_4_0)
	var_0_1.super.AddListeners(arg_4_0)

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.AddListener

	CourtYardEvent = var_1_10003

	var_4_1(var_4_0, var_1_10003.FEAST_SHIP_BUBBLE_CHANGE, arg_4_0.OnFeastBubbleChange)

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0.AddListener

	CourtYardEvent = var_3

	var_4_3(var_4_2, var_3.FEAST_SHIP_CHAT_CHANGE, arg_4_0.OnFeastChatChange)

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.AddListener

	CourtYardEvent = var_3

	var_4_5(var_4_4, var_3.FEAST_SHIP_BUBBLE_INTERACTION, arg_4_0.OnFeastShipBubbleInterAction)

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.AddListener

	CourtYardEvent = var_3

	var_4_7(var_4_6, var_3.FEAST_SHIP_SHOW_EXPRESS, arg_4_0.OnFeastShipShowExpress)

	return
end

function var_0_1.RemoveListeners(arg_5_0)
	var_0_1.super.RemoveListeners(arg_5_0)

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.RemoveListener

	CourtYardEvent = var_1_10003

	var_5_1(var_5_0, var_1_10003.FEAST_SHIP_BUBBLE_CHANGE, arg_5_0.OnFeastBubbleChange)

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.RemoveListener

	CourtYardEvent = var_3

	var_5_3(var_5_2, var_3.FEAST_SHIP_CHAT_CHANGE, arg_5_0.OnFeastChatChange)

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.RemoveListener

	CourtYardEvent = var_3

	var_5_5(var_5_4, var_3.FEAST_SHIP_BUBBLE_INTERACTION, arg_5_0.OnFeastShipBubbleInterAction)

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.RemoveListener

	CourtYardEvent = var_3

	var_5_7(var_5_6, var_3.FEAST_SHIP_SHOW_EXPRESS, arg_5_0.OnFeastShipShowExpress)

	return
end

function var_0_1.OnFeastShipShowExpress(arg_6_0, arg_6_1)
	if arg_6_0.expressList[arg_6_1] then
		arg_6_0:ClearChatAnimation()
		arg_6_0:PlayExpressAnim(var_2)
	end

	return
end

function var_0_1.PlayExpressAnim(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	defaultValue = var_1_10004
	arg_7_3 = var_1_10004(arg_7_3, 0)
	defaultValue = var_4

	local var_7_0 = arg_7_2

	Vector3 = var_6
	arg_7_2 = var_4(var_7_0, var_6(1, 1, 1))
	LeanTween = var_4

	local var_7_1 = var_4.scale

	go = var_7_0

	local var_7_2 = var_7_1(var_7_0(arg_7_1), arg_7_2, 0.5)
	local var_7_3 = var_4.setEase

	LeanTweenType = var_6

	local var_7_4 = var_7_3(var_7_2, var_6.easeOutBack)
	local var_7_5 = var_4.setDelay(var_7_4, arg_7_3)
	local var_7_6 = var_4.setOnComplete

	System = var_6

	var_7_6(var_7_5, var_6.Action(function()
		local var_8_0 = arg_7_0
		local var_8_1 = var_0.PlayExpressAnim
		local var_8_2 = arg_7_1

		Vector3 = var_2_10003

		var_8_1(var_8_0, var_8_2, var_2_10003(0, 0, 0), 2)

		return
	end))

	return
end

function var_0_1.ClearChatAnimation(arg_9_0)
	var_0_1.super.ClearChatAnimation(arg_9_0)

	ipairs = var_1

	local var_9_0

	if not arg_9_0.expressList then
		var_9_0 = {}
	end

	for iter_9_0, iter_9_1 in var_1(var_9_0) do
		LeanTween = var_1_10006

		if var_1_10006.isTweening(iter_9_1.gameObject) then
			LeanTween = var_1_10006

			var_1_10006.cancel(iter_9_1.gameObject)
		end

		Vector3 = var_1_10006
		iter_9_1.localScale = var_1_10006.zero
	end

	return
end

function var_0_1.OnFeastBubbleChange(arg_10_0, arg_10_1)
	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.bubbles) do
		setActive = var_1_10007

		var_1_10007(iter_10_1, iter_10_0 == arg_10_1)
	end

	return
end

function var_0_1.OnFeastChatChange(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 ~= ""

	setActive = var_1_10003

	var_1_10003(arg_11_0.chatBubble, var_11_0)

	arg_11_0.chatBubbleTxt.text = arg_11_1

	arg_11_0:RemoveDisappearTimer()

	if var_11_0 then
		arg_11_0:DisappearTimer()
	end

	return
end

local var_0_2 = {
	"AiXin",
	"XinXin",
	"XinXin",
	"YinFu",
	"Zzz"
}

function var_0_1.OnFeastShipBubbleInterAction(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:GetView().poolMgr
	local var_12_1

	if not var_0_2[arg_12_1] then
		var_12_1 = var_0_2[1]
	end

	local var_12_2 = var_12_0["Get" .. var_12_1 .. "Pool"](var_12_0)
	local var_12_3 = var_4.Dequeue(var_12_2).transform

	var_6.SetParent(var_12_3, arg_12_0._tf, false)

	tf = var_6

	local var_12_4 = var_6(var_5)

	Vector3 = var_7
	var_12_4.localPosition = var_7(0, 100, -100)
	tf = var_12_4

	local var_12_5 = var_12_4(var_5)

	Vector3 = var_7
	var_12_5.localScale = var_7(3, 3, 3)

	local var_12_6 = #arg_12_0.timers + 1
	local var_12_7
	local var_12_8 = arg_12_0.cg

	var_12_8.blocksRaycasts = false
	Timer = var_12_8

	local var_12_9 = var_12_8.New(function()
		local var_13_0 = var_12_7

		var_0.Stop(var_13_0)

		table = var_0

		var_0.remove(arg_12_0.timers, var_12_6)

		local var_13_1 = arg_12_0

		var_0.Emit(var_13_1, "ShipBubbleInterActionFinish", arg_12_0.data.id)

		arg_12_0.cg.blocksRaycasts = true

		return
	end, 0.01, 1)

	var_12_7.Start(var_12_9)

	table = var_8

	var_8.insert(arg_12_0.timers, var_12_7)

	return
end

function var_0_1.DisappearTimer(arg_14_0)
	Timer = var_1_10001

	local var_14_0 = var_1_10001.New

	local function var_14_1()
		setActive = var_2_10000

		var_2_10000(arg_14_0.chatBubble, false)

		return
	end

	CourtYardConst = var_1_10003
	arg_14_0.disappearTimer = var_14_0(var_14_1, var_1_10003.FEAST_CHAT_TIME, 1)

	local var_14_2 = arg_14_0.disappearTimer

	var_1.Start(var_14_2)

	return
end

function var_0_1.RemoveDisappearTimer(arg_16_0)
	if arg_16_0.disappearTimer then
		local var_16_0 = arg_16_0.disappearTimer

		var_1.Stop(var_16_0)

		arg_16_0.disappearTimer = nil
	end

	return
end

function var_0_1.OnStateChange(arg_17_0, arg_17_1, arg_17_2)
	var_0_1.super.OnStateChange(arg_17_0, arg_17_1, arg_17_2)

	local var_17_0 = false
	local var_17_1 = arg_17_0.data

	if var_4.IsSpecial(var_17_1) then
		CourtYardShip = var_4

		if arg_17_1 ~= var_4.STATE_IDLE then
			CourtYardShip = var_4

			if arg_17_1 ~= var_4.STATE_MOVE then
				CourtYardShip = var_4

				if arg_17_1 ~= var_4.STATE_MOVING_ZERO then
					CourtYardShip = var_4

					if arg_17_1 ~= var_4.STATE_MOVING_HALF then
						CourtYardShip = var_4

						if arg_17_1 ~= var_4.STATE_MOVING_ONE then
							CourtYardShip = var_4

							if arg_17_1 ~= var_4.STATE_TOUCH then
								CourtYardShip = var_4

								if arg_17_1 == var_4.STATE_GETAWARD then
									var_17_0 = true
								end

								setActive = var_4

								var_4(arg_17_0.specialMark, var_17_0)

								CourtYardShip = var_4

								local var_17_2 = arg_17_1 == var_4.STATE_INTERACT
								local var_17_3 = arg_17_0.feastAttachments

								if var_17_2 then
									Vector3 = var_17_4

									local var_17_4

									if not var_17_4(0, -85, 0) then
										Vector3 = var_17_4
										var_17_4 = var_17_4.zero
									end

									var_17_3.localPosition = var_17_4

									return
								end
							end
						end
					end
				end
			end
		end
	end
end

function var_0_1.OnDestroy(arg_18_0)
	local var_18_0 = arg_18_0.cg

	var_18_0.blocksRaycasts = true
	ipairs = var_18_0

	local var_18_1

	if not arg_18_0.timers then
		var_18_1 = {}
	end

	for iter_18_0, iter_18_1 in var_18_0(var_18_1) do
		iter_18_1:Stop()
	end

	arg_18_0.timers = nil

	arg_18_0:RemoveDisappearTimer()

	if arg_18_0.feastAttachments then
		setParent = var_1

		var_1(arg_18_0.specialMark, arg_18_0.feastAttachments)

		local var_18_2 = arg_18_0.specialMark

		Vector3 = var_2
		var_18_2.localScale = var_2.one
		Object = var_18_2

		var_18_2.Destroy(arg_18_0.feastAttachments.gameObject)

		arg_18_0.feastAttachments = nil
	end

	var_0_1.super.OnDestroy(arg_18_0)

	return
end

return var_0_1
