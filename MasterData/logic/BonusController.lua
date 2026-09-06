-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/controller/BonusController.lua

module("logic.extensions.bonus.controller.BonusController", package.seeall)

local BonusController = class("BonusController", BaseController)

BonusController.UserDataKeyPrefix = "Preferential_Goto_"
BonusController.UserDataSaveType = {
	Weekly = 2,
	Daily = 1,
	First = 0
}

function BonusController:onInit()
	RedPointAgent.instance:addHandler(RedPointAgent.PM_LoadAllRedPointRes, self.onRedPointChange, self)
end

function BonusController:onRedPointChange()
	self:updateRD(RedPointModel.ID_PREFERENTIAL_RECOMMEND_JUMP_WEEKLY_1, BonusController.UserDataSaveType.Weekly)
	self:updateRD(RedPointModel.ID_PREFERENTIAL_RECOMMEND_JUMP_WEEKLY_2, BonusController.UserDataSaveType.Weekly)
end

function BonusController:updateRD(redId, dataSaveType)
	local rpKey = BonusController.UserDataKeyPrefix .. redId
	local isShow = false

	isShow = dataSaveType == BonusController.UserDataSaveType.Daily and checknumber(GameUtil.getUserDayData(rpKey)) <= 0 or dataSaveType == BonusController.UserDataSaveType.Weekly and checknumber(GameUtil.getUserWeekData(rpKey)) <= 0 or checknumber(GameUtil.getUserData(rpKey)) <= 0

	RedPointController.instance:setRedPointInfo(redId, isShow)
end

function BonusController:setRDInfo(redId, dataSaveType)
	local rpKey = BonusController.UserDataKeyPrefix .. redId

	if dataSaveType == BonusController.UserDataSaveType.Daily then
		GameUtil.saveUserDayData(rpKey, 1)
	elseif dataSaveType == BonusController.UserDataSaveType.Weekly then
		GameUtil.saveUserWeekData(rpKey, 1)
	else
		GameUtil.saveUserData(rpKey, 1)
	end

	RedPointController.instance:setRedPointInfo(redId, false)
end

function BonusController:openBonusView(viewName)
	local parentViewName = self:getParentViewName(viewName)

	print("viewName = " .. viewName .. " parentViewName = " .. parentViewName)
	UIStateManager.instance:push(parentViewName, viewName)
end

function BonusController:getParentViewName(viewName)
	return ViewName.bonus
end

function BonusController:getCfgByViewName(cfgs, viewName)
	for _, v in ipairs(cfgs) do
		if v.viewname == viewName then
			return v
		end
	end
end

function BonusController:isDoubleDayWeekTask(index)
	local isInTime, title, startTime, endTime, cfg = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.DiamondTask, index)

	return cfg
end

function BonusController:getDayWeekTaskDoubleMats(str, index)
	local cfg = self:isDoubleDayWeekTask(index)

	if cfg == nil or string.nilorempty(cfg.featureParam) then
		return str
	end

	local list = string.split(str, ":")

	if list == nil or #list == 0 then
		return str
	end

	local params = string.split(cfg.featureParam, "#")
	local double = checknumber(params[1])

	if double <= 0 then
		return str
	end

	local excludes = string.nilorempty(params[2]) and {} or string.split(params[2], ",")
	local isExd = false

	if excludes and #excludes > 0 then
		for i = 1, #excludes do
			local aa = string.split(excludes[i], ":")

			if checknumber(aa[1]) == checknumber(list[1]) and checknumber(aa[2]) == checknumber(list[2]) then
				isExd = true

				break
			end
		end
	end

	if isExd then
		return str
	end

	local count = checknumber(table.remove(list)) * double

	table.insert(list, tostring(count))

	return table.concat(list, ":")
end

function BonusController:getSummerDoubleRedpoint()
	local value = GameUtil.getUserDayData("SummerDoubleRedpoint")

	return checknumber(value) ~= 1
end

function BonusController:getVersionGiftViewRed()
	local list = VersionGiftConfig.instance:getShowVersionGiftTables()

	if list == nil or #list == 0 then
		return false
	end

	for i = 1, #list do
		if list[i] and self:getVersionGiftRedByTableId(list[i].tabId) then
			return true
		end
	end

	return false
end

function BonusController:getVersionGiftRedByTableId(tabId)
	local cfg = VersionGiftConfig.instance:getVersionGiftTable(tabId)

	if cfg == nil or not GameUtil.getTimePeriodType(cfg.startTime, cfg.endTime) then
		return false
	end

	local list = VersionGiftConfig.instance:getShowVersionGiftShopCfgs(cfg.planId)

	if list == nil or #list == 0 then
		return false
	end

	for i = 1, #list do
		if list[i] and list[i].goodsData and PayShopModel.instance:checGoodsFreeBuyDot(list[i].goodsData.id) then
			return true
		end
	end

	return false
end

BonusController.instance = BonusController.New()

return BonusController
