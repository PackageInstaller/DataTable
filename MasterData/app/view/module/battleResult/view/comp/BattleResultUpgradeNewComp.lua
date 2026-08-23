local BattleResultUpgradeNewComp = class("BattleResultUpgradeNewComp", require("app.fairyGUI.battleResult.UI_BattleResultUpgradeNewComp"))

function BattleResultUpgradeNewComp:ctor()
	local var_1_0 = g.core.config.role_info.get((g.core.model.User:getLevel()))

	self._functions = {}

	for iter_1_0 = 1, 3 do
		if var_1_0["stronger_route_" .. iter_1_0] then
			local var_1_1 = g.core.config.source_info.get(var_1_0["stronger_route_" .. iter_1_0])
			local var_1_2 = g.core.config.function_info.get(g.core.config.source_route_info.get(var_1_1.route_id).function_id)

			if g.core.common.ModuleUnlock:isModuleUnlock(var_1_2.id) then
				table.insert(self._functions, {
					id = var_1_1.route_id,
					icon = var_1_2.icon,
					name = var_1_1.name
				})
			end
		end
	end

	self.m_upgradeList:setItemIniter(function(arg_2_0, arg_2_1)
		fgui.UIPackage.iterObject(arg_2_1)

		local var_2_0 = arg_2_1:getRemark()

		if var_2_0 then
			fgui.UIPackage.bindUIComponent(arg_2_1, var_2_0, self.m_iconList)
		end
	end)
	self.m_upgradeList:setItemRenderer(handler(self, self._onFuncItemRender))
	self.m_upgradeList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onFuncItemClick))
	self.m_enterTransition:setHook("listUpIn", handler(self, self._onLineUpIn))
end

function BattleResultUpgradeNewComp:onLoad()
	if g.core.model.User.dungeonData:getLastUnlockChapter() < 16 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_DUNGEON_FAIL",
			targetBtn = self.m_upgradeList:getChildAt(0)
		})
	end
end

function BattleResultUpgradeNewComp:_onLineUpIn()
	self.m_upgradeList:setNumItems(#self._functions)
	self.m_upgradeList:transitionShowCells("listlconUiUpln", 0.03, 1)
end

function BattleResultUpgradeNewComp:_onFuncItemRender(arg_5_1, arg_5_2)
	arg_5_2:setTitle(self._functions[arg_5_1 + 1].name)
	arg_5_2:setIcon(self._functions[arg_5_1 + 1].icon)
end

function BattleResultUpgradeNewComp:_onFuncItemClick(arg_6_1)
	local var_6_0 = arg_6_1 and arg_6_1:getDataValue() or 0
	local var_6_1 = self._functions[var_6_0 + 1]

	if not self._functions[var_6_0 + 1] then
		return
	end

	g.core.model.User.dungeonData:setFailBattleJumpFlag()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_EXIT_BATTLE_RESULT_SHOW, false, {
		srcId = var_6_1.id
	})
end

function BattleResultUpgradeNewComp:update(arg_7_1)
	if arg_7_1 and not arg_7_1.isWin and not arg_7_1.noLose then
		local var_7_0 = g.core.common.Storage:load("battle_fail_count.json") or {
			count = 0
		}

		var_7_0.count = var_7_0.count + 1

		g.core.common.Storage:save("battle_fail_count.json", var_7_0)
	end
end

function BattleResultUpgradeNewComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return BattleResultUpgradeNewComp
