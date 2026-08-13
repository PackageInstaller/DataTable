import = var_0_10000

local var_0_0 = var_0_10000("view.activity.AuctionGame.game.main.right.AuctionGameMainRightView")

class = AuctionGameMainRightView

local var_0_1 = "AuctionGameMainRightGuideView"

AuctionGameMainRightView = var_0_10003

local var_0_2 = var_0(var_0_1, var_0_10003)

function var_0_2.OnPopBidLayer(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.emit

	BaseUI = var_1_10004

	local var_1_2 = var_1_10004.ON_ADD_SUBLAYER

	Context = var_1_10005

	local var_1_3 = var_1_10005.New
	local var_1_4 = {}

	AuctionGameMainBidGuideLayer = var_1_10008
	var_1_4.viewComponent = var_1_10008
	AuctionGameMainBidMediator = var_1_10008
	var_1_4.mediator = var_1_10008

	var_1_1(var_1_0, var_1_2, var_1_3(var_1_4))

	return
end

function var_0_2.OnPopEventLayer(arg_2_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)

	if var_1.GetRound(var_2_0) > 1 then
		return
	end

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.emit

	BaseUI = var_1_10004

	local var_2_3 = var_1_10004.ON_ADD_SUBLAYER

	Context = var_1_10005

	local var_2_4 = var_1_10005.New
	local var_2_5 = {}

	AuctionGameMainEventGuideLayer = var_1_10008
	var_2_5.viewComponent = var_1_10008
	AuctionGameMainEventMediator = var_1_10008
	var_2_5.mediator = var_1_10008

	var_2_2(var_2_1, var_2_3, var_2_4(var_2_5))

	return
end

return var_0_2
