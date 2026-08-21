-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataFashionLottery.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityFLottoryAward = require("ClientData/ResOpActivityFLottoryAward")
local ResOpActivityFLottoryRound = require("ClientData/ResOpActivityFLottoryRound")
local ResOpActivityFLottoryMisc = require("ClientData/ResOpActivityFLottoryMisc")
local UserData = require("Helper/UserData")
local ActivityDataFashionLottery = Class("ActivityDataFashionLottery", ActivityDataBase)

function ActivityDataFashionLottery:ctor()
	self.curRound = 1
	self.serverData = {}
end

function ActivityDataFashionLottery:updateClientData(actId)
	self.actId = actId
	self.roundData = ResOpActivityFLottoryRound[actId] or {}
	self.miscData = ResOpActivityFLottoryMisc[actId] or {}

	CurAvatar:registerItemChangedCallBack(self.miscData.cost_item_id, Slot(self.onItemChanged, self))
end

function ActivityDataFashionLottery:updateRoleData(roleData)
	local data = roleData.flottory

	self.curRound = math.max(1, data.round)
	self.serverData.fixedState = utils.getBitsDictFromByteString(data.fixed_awarded)
	self.serverData.choosenState = utils.getBitsDictFromByteString(data.sel_awarded)
	self.serverData.hasGotNumber = 0

	for gotId, _ in pairs(self.serverData.fixedState) do
		self.serverData.hasGotNumber = self.serverData.hasGotNumber + 1
	end

	for gotId, _ in pairs(self.serverData.choosenState) do
		self.serverData.hasGotNumber = self.serverData.hasGotNumber + 1
	end

	self.serverData.choosen = {}

	for index, info in ipairs(data.award) do
		self.serverData.choosen[index] = info.sel_index
	end

	self.hasFree = data.free_flag ~= 1
end

function ActivityDataFashionLottery:checkNew()
	if self.hasFree then
		return true
	end

	if not self.miscData.may_max_round or not (self.curRound > self.miscData.may_max_round) then
		if self.serverData.choosen == nil or next(self.serverData.choosen) == nil then
			return true
		end

		if ClientUtils.getMoney(self.miscData.cost_item_id) > 0 then
			return true
		end
	end

	if ClientUtils.getMoney(self.miscData.ext_item_id) > (self.miscData.achieve_new_num or 0) then
		local actObj = CurAvatar:getActivityObj(self.miscData.store_id)
		local isAllSoldOut = true

		if actObj and actObj:isValid() then
			isAllSoldOut = actObj.actData:isOver()
		end

		if not isAllSoldOut then
			return true
		end
	end
end

function ActivityDataFashionLottery:getCurRoundData()
	local allData = {}
	local roundConfig = self.roundData[self.curRound]

	allData.roundAward = roundConfig.pass_award
	allData.fixedAward = ResOpActivityFLottoryAward[roundConfig.fixed_lb_id]

	local fixedLength = #allData.fixedAward

	allData.chooseAward = ResOpActivityFLottoryAward[roundConfig.sel_lib_id]
	allData.chooseNum = roundConfig.sel_count
	allData.gotInfo = {
		fixedLength + roundConfig.sel_count,
		self.serverData.hasGotNumber or 0
	}
	allData.fixedState = self.serverData.fixedState or {}
	allData.choosenState = self.serverData.choosenState or {}
	allData.choosen = self.serverData.choosen

	return allData
end

function ActivityDataFashionLottery:onItemChanged()
	self.actObject:checkNew()
end

function ActivityDataFashionLottery:onDrawResp(award)
	local activityFashionLotteryDlg = UIManager.tryGetUI("activityFashionLotteryDlg")

	if activityFashionLotteryDlg then
		activityFashionLotteryDlg:onDrawResp(award)
	end
end

function ActivityDataFashionLottery:onSelBonusResp()
	local activityFashionLotteryDlg = UIManager.tryGetUI("activityFashionLotteryDlg")

	if activityFashionLotteryDlg then
		activityFashionLotteryDlg:onSelBonusResp()
	end
end

return ActivityDataFashionLottery
