import = var_0_10000

local var_0_0 = var_0_10000("view.activity.AuctionGame.game.event.AuctionGameMainEventLayer")

class = AuctionGameMainEventLayer

local var_0_1 = "AuctionGameMainEventGuideLayer"

AuctionGameMainEventLayer = var_0_10003

local var_0_2 = var_0(var_0_1, var_0_10003)

function var_0_2.init(arg_1_0)
	var_0_2.super.init(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.uiBgBtn

	local function var_1_2()
		getProxy = var_2_10000
		AuctionGameProxy = var_2_10002

		local var_2_0 = var_2_10000(var_2_10002)

		if var_0.GetPersonalEventSelectedID(var_2_0) ~= 0 then
			local var_2_1 = arg_1_0

			var_0.closeView(var_2_1)
		end

		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_1_0, var_1_1, var_1_2, var_1_10006)

	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.uiOkBtn

	local function var_1_5()
		getProxy = var_2_10000
		AuctionGameProxy = var_2_10002

		local var_3_0 = var_2_10000(var_2_10002)

		if var_0.GetPersonalEventSelectedID(var_3_0) ~= 0 then
			return
		end

		if arg_1_0.selectedID == 0 then
			return
		end

		AuctionGameTools = var_1

		var_1.GuideSelectedEvent(arg_1_0.selectedID)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_1_3, var_1_4, var_1_5, var_1_10006)

	return
end

return var_0_2
