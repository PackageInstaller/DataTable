-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/util/WelfareUtil.lua

module("logic.extensions.welfare.util.WelfareUtil", package.seeall)

local WelfareUtil = {}

function WelfareUtil.isSystemOpen(showLogTips)
	local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Welfare, showLogTips)

	return isOpen
end

function WelfareUtil.isSystemOpenTab(tabId)
	local tabSystemOpenId = WelfareConfig.instance:getTabSystemOpenId(tabId)

	if not tabSystemOpenId then
		return false
	end

	if tabSystemOpenId <= 0 then
		return true
	end

	local isOpen = SystemOpenFacade.instance:isOpen(tabSystemOpenId)

	return isOpen
end

function WelfareUtil.isActSystemOpenAndOnline(logicTyp, planId, showLogTips)
	if not WelfareUtil.isSystemOpen(showLogTips) then
		return false
	end

	local cfg = WelfareConfig.instance:getCfgTab(logicTyp, planId)

	if not cfg then
		return false
	end

	if cfg.systemId > 0 then
		if not SystemOpenFacade.instance:isOpen(cfg.systemId, showLogTips) then
			return false
		end

		if not SystemOpenModel.instance:getSystemIsOnline(cfg.systemId, true) and showLogTips then
			FloatWordMgr.instance:show(lang("tip_system_open_not_online"))
		end
	end

	return true
end

function WelfareUtil.canWelfareEntryActive()
	local isOpen = WelfareUtil.isSystemOpen()

	if not isOpen then
		return false
	end

	local actMOLst = ActivityModel.instance:getActivityDataList()

	for index, actMO in ipairs(actMOLst or {}) do
		if WelfareUtil.isShowActivity(actMO) then
			return true
		end
	end

	return false
end

function WelfareUtil.getActivityListByTabId(tabId)
	local activityTabCfg = WelfareConfig.instance:getActivityTabCfg(tabId)

	if not activityTabCfg or not activityTabCfg.planIds then
		return
	end

	local activityList = ActivityModel.instance:getActivityList(activityTabCfg.type, activityTabCfg.planIds)

	return activityList
end

function WelfareUtil.isShowActivity(actMo)
	if not actMo then
		return false
	end

	local logicTyp = actMo:getType()
	local planId = actMo:getConfigId()

	if not WelfareConfig.instance:isActivityTab(logicTyp, planId) then
		return false
	end

	if not actMo:getIsOpen() then
		return false
	end

	local tabId = WelfareConfig.instance:getActivityTabId(logicTyp, planId)

	if not tabId or not WelfareUtil.isSystemOpenTab(tabId) then
		return false
	end

	local tabCfg = WelfareConfig.instance:getActivityTabCfg(tabId)

	if tabCfg.isDisappear and actMo:IsDisappear() then
		return false
	end

	return true
end

function WelfareUtil.playWelfareViewAnim(DynFragmentGO, name)
	local view = DynFragmentGO.transform:GetChild(0)
	local guiAnimation = view and view:GetComponent(typeof(Astral.GUITimelineAniLua))

	if guiAnimation then
		guiAnimation:StopTimelineAni()
		guiAnimation:PlayAniByName(name)
	end
end

function WelfareUtil.fakeCreateActivity(actId, logic, planId, startedTime, endedTime, data)
	local cfg = WelfareConfig.instance:getCfgTab(logic, planId)

	if not cfg then
		printError("伪造新增活动失败，actId:", actId)

		return
	end

	printWarn("伪造新增活动->", actId)

	local fakeActNO = {
		id = actId,
		logic = logic,
		config = planId,
		data = data and data or "",
		startedTime = startedTime,
		endedTime = endedTime
	}

	ActivityController.instance:refreshActivity({
		fakeActNO
	})
end

function WelfareUtil.fakeCloseActivity(actId)
	local actMO = ActivityModel.instance:getActivityById(actId)

	if actMO then
		printWarn("伪造活动关闭->", actId)
		ActivityController.instance:refreshActivity(nil, {
			actId
		})
	end
end

function WelfareUtil.sortActivityById(idList)
	table.sort(idList, function(a, b)
		local cfgA = WelfareConfig.instance:getActivityTabCfg(a)
		local cfgB = WelfareConfig.instance:getActivityTabCfg(b)

		if cfgA.priority ~= cfgB.priority then
			return cfgA.priority > cfgB.priority
		end

		return cfgA.id < cfgB.id
	end)
end

function WelfareUtil.isTabActive(tabId)
	local activities = WelfareUtil.getActivityListByTabId(tabId)

	for _, actMO in ipairs(activities) do
		if WelfareUtil.isShowActivity(actMO) then
			return true
		end
	end

	return false
end

function WelfareUtil.getActivityRedPointKey(activityId, isTaskActivity)
	local redPointKey

	if isTaskActivity then
		redPointKey = string.format("%s_%s", GameEnum.RedPointEnum.ActivityTask, activityId)
	else
		redPointKey = string.format("%s_%s", GameEnum.RedPointEnum.Activity, activityId)
	end

	return redPointKey
end

return WelfareUtil
