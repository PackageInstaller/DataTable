local AuctionGameGetReliefCommand = class("AuctionGameGetReliefCommand", pm.SimpleCommand)

function AuctionGameGetReliefCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23426, {
		arg = 1
	}, 23427, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(AuctionGameBaseProxy):AddReliefCnt()
			pg.m02:sendNotification(GAME.AUCTION_GAME_GET_RELIEF_DONE, (PlayerConst.GetTranAwards({}, {
				award_list = {
					{
						type = DROP_TYPE_VITEM,
						id = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):getConfig("config_client").itemID,
						number = pg.gameset.auction_relief_payment.key_value
					}
				}
			})))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return AuctionGameGetReliefCommand
