class = var_0_10000

local var_0_0 = "AuctionGameMainNoticeBoardItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiEventBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		BaseUI = var_2_10002

		local var_3_2 = var_2_10002.ON_ADD_SUBLAYER

		Context = var_2_10003

		local var_3_3 = var_2_10003.New
		local var_3_4 = {}

		AuctionGameMainEventMsgLayer = var_2_10005
		var_3_4.viewComponent = var_2_10005
		AuctionGameMainEventMsgMediator = var_2_10005
		var_3_4.mediator = var_2_10005
		var_3_4.data = {
			eventID = arg_2_0.data.eventID
		}

		var_3_1(var_3_0, var_3_2, var_3_3(var_3_4))

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	return
end

function var_0_1.didEnter(arg_4_0, arg_4_1)
	arg_4_0.data = arg_4_1

	if arg_4_1 == nil then
		return
	end

	setText = var_1_10002

	local var_4_0 = arg_4_0.uiBidText

	StringHelper = var_1_10004

	local var_4_1 = var_1_10004.ForamtNumber
	local var_4_2

	if not arg_4_1.bidValue then
		var_4_2 = 0
	end

	var_1_10002(var_4_0, var_4_1(var_4_2))

	if arg_4_1.eventID ~= nil then
		pg = var_4_0

		local var_4_3 = var_4_0.auction_event[var_2]

		LoadSpriteAsync = var_4

		var_4(var_4_3.icon, function(arg_5_0)
			IsNil = var_2_10001

			if not var_2_10001(arg_4_0.uiEventImage) then
				arg_4_0.uiEventImage.sprite = arg_5_0
			end

			return
		end)
	end

	return
end

function var_0_1.willExit(arg_6_0)
	arg_6_0:detach()

	Object = var_1

	var_1.Destroy(arg_6_0._go)

	return
end

return var_0_1
