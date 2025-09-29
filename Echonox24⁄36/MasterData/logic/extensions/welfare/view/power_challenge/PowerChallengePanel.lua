-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/power_challenge/PowerChallengePanel.lua

module("logic.extensions.welfare.view.power_challenge.PowerChallengePanel", package.seeall)

local M = class("PowerChallengePanel", DynamicFragmentView)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnTask = self._registry:getBtn("4&btn_left_-1571983320")
	self._btnStart = self._registry:getBtn("3&btn_right_1251431307")
	self._rewards = {
		self._registry:getGo("0&rewards_detail_item_2141037416"),
		self._registry:getGo("1&rewards_detail_item_2141037416"),
		self._registry:getGo("2&rewards_detail_item_2141037416")
	}
	self._redPoint = goutil.findChild(self._btnTask.gameObject, "red_point")
	self._guiAnimation = self._registry:getGo("power_challenge_panel_-1851178083"):GetComponent(typeof(Astral.GUITimelineAniLua))
end

function M:onEnter()
	self._guiAnimation:PlayOpenAni()

	local tabId = self.params[1]
	local activityList = WelfareUtil.getActivityListByTabId(tabId)
	local activeData = activityList and activityList[1]

	self._planId = activeData:getConfigId()

	PowerChallengeModel.instance:setActivityData(activeData)
	GlobalDispatcher:dispatchEvent(EventType.POWER_CHALLENGE_TASK_REFRESH)

	if activeData then
		local activeConf = WelfareConfig.instance:getCfgTab(ActivityEnum.LogicType.POWER_CHALLENGE, self._planId)

		for idx, rewardId in ipairs(activeConf.rewards) do
			local itemView = Astral.LuaComponentContainer.Add(self._rewards[idx], ItemCell)

			itemView:setShowSelectedEffect(false)
			itemView:updateData(ItemUtil.createItemData({
				count = 0,
				itemId = rewardId
			}))
			itemView:getComponent("num"):setVisible(false)
		end
	end
end

function M:onExit()
	return
end

function M:bindEvents()
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnTask:AddClickListener(self._onClickReward, self)
	GlobalDispatcher:addEventListener(EventType.POWER_CHALLENGE_TASK_REFRESH, self._refreshRedPoint, self)
end

function M:unbindEvents()
	self._btnStart:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.POWER_CHALLENGE_TASK_REFRESH, self._refreshRedPoint, self)
end

function M:_onClickStart()
	local txtBtn = goutil.findChildTextComponent(self._btnStart.gameObject, "normal/Text1")

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtBtn and txtBtn.text or "")
	ViewMgr.instance:open(ViewName.PowerChallengeBattleView, self._planId)
end

function M:_onClickReward()
	local txtBtn = goutil.findChildTextComponent(self._btnTask.gameObject, "normal/Text1")

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtBtn and txtBtn.text or "")
	ViewMgr.instance:open(ViewName.PowerChallengeReward, self._planId)
end

function M:_onStartBattle()
	local cfgId = self._roleCellToActivityData[self._roleCellList[self._selectIndex]]:getConfigId()
	local roleExperienceCfg = RoleExperienceConfig.instance:getRoleExperienceCfg(cfgId)

	if roleExperienceCfg then
		local info = {}

		info.dungeonCode = roleExperienceCfg.levelId
		info.afflatusBuff = false
		info.isShowPlot = false
		info.multiCount = 1
		info.gamePlay = BattleEnum.GamePlayType.NORMAL

		DungeonController.instance:startDungeonBattle(info)
	end
end

function M:_refreshRedPoint()
	local isVisible = PowerChallengeModel.instance:getCanReceive()

	goutil.setActive(self._redPoint, isVisible)
end

function M:destroyUI()
	M.super.destroyUI(self)
end

return M
