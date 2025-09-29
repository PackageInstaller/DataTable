-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/BattleSettingTaskFragmentView.lua

module("logic.extensions.battle.viewsetting.BattleSettingTaskFragmentView", package.seeall)

local M = class("BattleSettingTaskFragmentView", StaticFragmentView)

function M:buildUI()
	self._scrollGo = goutil.findChild(self.mainGO, "scroll")
	self._taskCompList = {
		Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "scroll/view/content/battle_setting_task_item_1"), BattleSettingTaskItem),
		Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "scroll/view/content/battle_setting_task_item_2"), BattleSettingTaskItem),
		Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "scroll/view/content/battle_setting_task_item_3"), BattleSettingTaskItem),
		Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "scroll/view/content/battle_setting_task_item_4"), BattleSettingTaskItem),
		Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "scroll/view/content/battle_setting_task_item_5"), BattleSettingTaskItem)
	}
	self._noDataGO = goutil.findChild(self.mainGO, "stateEmpty")
	self._noDataTipsTxt = goutil.findChildTextComponent(self.mainGO, "stateEmpty/txt")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.TACIT_REFRESH_TARGET_TASK, self._onRefreshTaskSuc, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.TACIT_REFRESH_TARGET_TASK, self._onRefreshTaskSuc, self)
end

function M:onEnter()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local heroIds = unitMgr:getMyUnits(true)

	self._heroIds = heroIds

	TacitAgent.instance:sendGetPrimaryTaskInfoRequest(heroIds)

	self._noDataTipsTxt.text = lang("tip_setting_task_tips_2")
end

function M:onExit()
	return
end

function M:_onRefreshTaskSuc(evt, tasks)
	self:_refreshView(tasks)
end

function M:_refreshView(tasks)
	self._tasks = tasks

	local count = #self._heroIds

	if count == 0 then
		goutil.setActive(self._noDataGO, true)
		goutil.setActive(self._scrollGo, false)
	else
		goutil.setActive(self._noDataGO, false)
		goutil.setActive(self._scrollGo, true)

		for index = 1, #self._taskCompList do
			local taskComp = self._taskCompList[index]

			if index <= count then
				local parentGo = goutil.findChild(self.mainGO, string.format("scroll/view/content/task%d_%d", count, index))

				goutil.addChildToParent(taskComp.mainGO, parentGo)
				Astral.TransformUtil.SetAnchoredPos(taskComp.mainGO.transform, 0, 0)
				goutil.setActive(taskComp.mainGO, true)

				local task = self:_getTaskByHeroId(self._heroIds[index])

				taskComp:setCellData(self._heroIds[index], task, index)
			else
				goutil.setActive(taskComp.mainGO, false)
			end
		end
	end
end

function M:_getTaskByHeroId(heroId)
	for i, v in ipairs(self._tasks) do
		if v:getHeroId() == heroId then
			return v
		end
	end

	return false
end

return M
