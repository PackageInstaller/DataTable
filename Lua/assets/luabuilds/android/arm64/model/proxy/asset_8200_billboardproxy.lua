local BillboardProxy = class("BillboardProxy", import(".NetProxy"))

BillboardProxy.FETCH_LIST_DONE = "BillboardProxy:FETCH_LIST_DONE"
BillboardProxy.NONTIMER = {}

function BillboardProxy:register()
	BillboardProxy.NONTIMER = {
		PowerRank.TYPE_MILITARY_RANK,
		PowerRank.TYPE_BOSSRUSH
	}
	self.data = {}
	self.playerData = {}
	self.timeStamps = {}
	self.hashList = {}
	self.hashCount = 0

	return
end

function BillboardProxy:setPlayerRankData(arg_2_1, arg_2_2, arg_2_3)
	if table.contains(BillboardProxy.NONTIMER, arg_2_1) then
		return
	end

	self.playerData[self:getHashId(arg_2_1, arg_2_2)] = arg_2_3

	return
end

function BillboardProxy:getPlayerRankData(arg_3_1, arg_3_2)
	return self.playerData[self:getHashId(arg_3_1, arg_3_2)]
end

function BillboardProxy:setRankList(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = self:getHashId(arg_4_1, arg_4_2)

	if table.contains(BillboardProxy.NONTIMER, arg_4_1) then
		return
	end

	self.data[var_4_0] = arg_4_3
	self.timeStamps[var_4_0] = GetHalfHour()

	return
end

function BillboardProxy:getRankList(arg_5_1, arg_5_2)
	return self.data[self:getHashId(arg_5_1, arg_5_2)]
end

function BillboardProxy:canFetch(arg_6_1, arg_6_2)
	if table.contains(BillboardProxy.NONTIMER, arg_6_1) then
		return true
	end

	local var_6_0 = self:getHashId(arg_6_1, arg_6_2)

	if self.timeStamps[var_6_0] then
		if pg.TimeMgr.GetInstance():GetServerTime() > self.timeStamps[var_6_0] then
			return true
		end
	end

	return false
end

function BillboardProxy:getHashId(arg_7_1, arg_7_2)
	local var_7_0

	if arg_7_2 then
		self.hashList[arg_7_1] = self.hashList[arg_7_1] or {}
		var_7_0 = self.hashList[arg_7_1][arg_7_2]
	else
		var_7_0 = self.hashList[arg_7_1]
	end

	if var_7_0 then
		return var_7_0
	else
		self.hashCount = self.hashCount + 1

		if arg_7_2 then
			self.hashList[arg_7_1][arg_7_2] = self.hashCount
		else
			self.hashList[arg_7_1] = self.hashCount
		end

		return self.hashCount
	end

	return
end

return BillboardProxy
