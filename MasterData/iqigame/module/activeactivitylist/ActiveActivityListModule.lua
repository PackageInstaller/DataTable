-- chunkname: @IQIGame\\Module\\ActiveActivityList\\ActiveActivityListModule.lua

local activityViewBase = require("IQIGame.UI.ActivityList.ActivityViewBase")
local summerActivityMainView = require("IQIGame.UI.ActiveActivityList.SummerActivity.SummerActivityMainView")
local GhostActivityMainView = require("IQIGame.UI.ActiveActivityList.GhostActivity.GhostActivityMainView")
local GhostActivityBossView = require("IQIGame.UI.ActiveActivityList.GhostActivity.GhostActivityBossView")
local GhostGameActivityView = require("IQIGame.UI.ActiveActivityList.GhostActivity.GhostGameActivityView")

ActiveActivityListModule = {}

function ActiveActivityListModule.GetActivityListByTeamID(teamID)
	local tabList = {}

	for k, v in pairsCfg(CfgActivityListTable) do
		if v.ActivityTeam == teamID and v.Branch == 0 then
			local subTabList = ActiveActivityListModule.GetSubTabByActivityType(v.ActivityType)
			local activityIDs = ActiveActivityListModule.GetSubTabActivityId(subTabList)
			local showConditionIDs = ActiveActivityListModule.GetSubTabShowConditionId(subTabList)

			if #subTabList == 0 then
				if ActivityModule.GetMultipleActivityIsOpen(v.ActivityID) and ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(v.ShowConditionID)) then
					table.insert(tabList, v)
				end
			else
				local condition1 = ActivityModule.GetMultipleActivityIsOpen(activityIDs)
				local condition2 = ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(showConditionIDs))

				if condition1 and condition2 then
					table.insert(tabList, v)
				end
			end
		end
	end

	table.sort(tabList, function(cfg1, cfg2)
		return cfg1.Sort < cfg2.Sort
	end)

	return tabList
end

function ActiveActivityListModule.GetSubTabByActivityType(activityType)
	local subTabList = {}

	for k, v in pairsCfg(CfgActivityListTable) do
		if v.ActivityType == activityType and v.Branch ~= 0 then
			table.insert(subTabList, v)
		end
	end

	table.sort(subTabList, function(cfg1, cfg2)
		return cfg1.Sort < cfg2.Sort
	end)

	return subTabList
end

function ActiveActivityListModule.GetSubTabActivityId(subTabList)
	local activityIDs = {}

	for i = 1, #subTabList do
		for j = 1, #subTabList[i].ActivityID do
			table.insert(activityIDs, subTabList[i].ActivityID[j])
		end
	end

	return activityIDs
end

function ActiveActivityListModule.GetSubTabShowConditionId(subTabList)
	local showConditionIDs = {}

	for i = 1, #subTabList do
		for j = 1, #subTabList[i].ShowConditionID do
			table.insert(showConditionIDs, subTabList[i].ShowConditionID[j])
		end
	end

	return showConditionIDs
end

function ActiveActivityListModule.GetActivityListCfgIsExist(cfgID, CfgList)
	local isExist = false

	isExist = table.search(CfgList, function(k, v)
		return v.Id == cfgID
	end)

	return isExist
end

function ActiveActivityListModule.GetCommodityDataByActivityID(shopType, activityID)
	local allCommodity = ShopModule.GetAllItemsWithShopType(shopType)
	local commodityData
	local discreteDataTable = CfgDiscreteDataTable[Constant.DiscreteData.PassActivityCommodityID]

	for i = 1, #discreteDataTable.Data, 2 do
		if discreteDataTable.Data[i] == activityID then
			for _, v in pairs(allCommodity) do
				if v.cid == discreteDataTable.Data[i + 1] then
					commodityData = v

					break
				end
			end

			break
		end
	end

	return commodityData
end

function ActiveActivityListModule.GetActivityListGameobjectLuaByType(type, branch, obj)
	if type == Constant.ActivityListCfgType.SummerActivityType then
		if branch == 1 then
			return activityViewBase.New(obj, summerActivityMainView)
		elseif branch == 2 then
			-- block empty
		end
	elseif type == Constant.ActivityListCfgType.GhostActivity then
		if branch == 1 then
			return activityViewBase.New(obj, GhostActivityMainView)
		elseif branch == 2 then
			return activityViewBase.New(obj, GhostActivityBossView)
		elseif branch == 3 then
			return activityViewBase.New(obj, GhostGameActivityView)
		end
	end

	return activityViewBase.New(obj, activityViewBase)
end

function ActiveActivityListModule.GetRedDotTypeByType(activityListCfg)
	local type = activityListCfg.ActivityType
	local branch = activityListCfg.Branch

	if type == Constant.ActivityListCfgType.SummerActivityType then
		if branch == 0 then
			-- block empty
		elseif branch == 1 then
			-- block empty
		elseif branch == 2 then
			-- block empty
		end
	elseif type == Constant.ActivityListCfgType.GhostActivity then
		if branch == 0 then
			return RedDotModule.CheckRedDot_GhostGame() or RedDotModule.CheckRedDot_GhostGameTask()
		elseif branch == 1 then
			-- block empty
		elseif branch == 2 then
			return RedDotModule.GetRedDotCntByRedDotID(Constant.E_RedDotPath.GhostActivityUI) >= 1
		elseif branch == 3 then
			return RedDotModule.CheckRedDot_GhostGame() or RedDotModule.CheckRedDot_GhostGameTask()
		end
	end

	return false
end
