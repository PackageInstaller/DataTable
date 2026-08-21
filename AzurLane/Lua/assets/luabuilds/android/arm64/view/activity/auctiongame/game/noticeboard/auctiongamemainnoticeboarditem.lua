local var_0_0 = class("AuctionGameMainNoticeBoardItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiEventBtn, function()
		arg_2_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainEventMsgLayer,
			mediator = AuctionGameMainEventMsgMediator,
			data = {
				eventID = arg_2_0.data.eventID
			}
		}))

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_4_0, arg_4_1)
	arg_4_0.data = arg_4_1

	if arg_4_1 == nil then
		return
	end

	var_4_0(arg_4_0.uiBidText, StringHelper.ForamtNumber(var_4_1))

	if arg_4_1.eventID ~= nil then
		LoadSpriteAsync(pg.auction_event[arg_4_1.eventID].icon, function(arg_5_0)
			if not IsNil(arg_4_0.uiEventImage) then
				arg_4_0.uiEventImage.sprite = arg_5_0
			end

			return
		end)
	end

	return
end

function var_0_0.willExit(arg_6_0)
	arg_6_0:detach()
	Object.Destroy(arg_6_0._go)

	return
end

return var_0_0
