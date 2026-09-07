local AuctionGameActivity = class("AuctionGameActivity", import("model.vo.Activity"))

function AuctionGameActivity:readyToAchieve()
	if self:isEnd() then
		return false
	end

	return self:GetPreorderTip() or self:GetOpenPreorderTip() or self:GetTaskTip() or self:GetAllLocationTip() or self:GetReliefTip()
end

function AuctionGameActivity:GetPreorderTip()
	local var_2_0 = getProxy(AuctionGameBaseProxy)
	local var_2_1 = var_2_0:GetPreorderTimestamp()

	if var_2_0:GetPreorderState() == 1 then
		return false
	end

	if pg.TimeMgr.GetInstance():IsSameDay(pg.TimeMgr.GetInstance():GetServerTime(), self.stopTime) then
		return false
	end

	local var_2_2 = getProxy(PlayerProxy)

	return PlayerPrefs.GetString(string.format("AUCTION_GAME_PREORDER_%s_%s", var_2_2:getRawData().id, self.id)) ~= pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d")
end

function AuctionGameActivity:SetPreorderTip()
	if getProxy(AuctionGameBaseProxy):GetPreorderState() == 1 then
		return
	end

	PlayerPrefs.SetString(string.format("AUCTION_GAME_PREORDER_%s_%s", getProxy(PlayerProxy):getRawData().id, self.id), (pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d")))

	return
end

function AuctionGameActivity:GetOpenPreorderTip()
	local var_4_0 = getProxy(AuctionGameBaseProxy)

	if var_4_0:GetPreorderState() == 1 and var_4_0:GetPreorderTimestamp() <= pg.TimeMgr.GetInstance():GetServerTime() then
		return true
	end

	return false
end

function AuctionGameActivity:GetTaskTip()
	local var_5_0 = getProxy(ActivityProxy):getActivityById(self:getConfig("config_client").taskActID)

	return var_5_0 and var_5_0:readyToAchieve()
end

function AuctionGameActivity:GetAllLocationTip()
	for iter_6_0, iter_6_1 in ipairs(pg.auction_session.all) do
		if pg.auction_session[iter_6_1].game_type ~= 0 and self:GetLocationTip(iter_6_1) then
			return true
		end
	end

	return false
end

function AuctionGameActivity:GetLocationTip(arg_7_1)
	return PlayerPrefs.GetInt(string.format("AUCTION_GAME_LOCATION_%s_%s_%s", getProxy(PlayerProxy):getRawData().id, self.id, arg_7_1), 0) == 0 and AuctionGameTools.GetCurrencyCnt() >= pg.auction_session[arg_7_1].threshold
end

function AuctionGameActivity:SetLocationTip(arg_8_1)
	PlayerPrefs.SetInt(string.format("AUCTION_GAME_LOCATION_%s_%s_%s", getProxy(PlayerProxy):getRawData().id, self.id, arg_8_1), 1)

	return
end

function AuctionGameActivity:GetReliefTip()
	local var_9_0 = getProxy(AuctionGameBaseProxy)

	if var_9_0.gold < pg.gameset.auction_relief_payment_limit.key_value and var_9_0.reliefCnt < pg.gameset.auction_relief_payment_count.key_value then
		return true
	end

	return false
end

return AuctionGameActivity
