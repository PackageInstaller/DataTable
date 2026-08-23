local var_0_0 = g.core.config.battle_rating_info
local var_0_1 = g.core.config.gve_base_info
local var_0_2 = g.core.model.User.gveDataMgr
local BattleResultGveComp = class("BattleResultGveComp", require("app.fairyGUI.battleResult.UI_BattleResultGveComp"))

function BattleResultGveComp:ctor()
	self._knightList = {}
	self._starList = {}
	self._formationData = var_0_2:getGveFormationData()

	self.m_knightList:setVirtual()
	self.m_knightList:doFairyBatching(false)
	self.m_knightList:setItemRenderer(handler(self, self._onKnightListItemRender))
	self.m_starList:setVirtual()
	self.m_starList:setItemRenderer(handler(self, self._onStarListRender))
	self.m_enterTransition:setHook("listLeftIn", handler(self, self._onListEnter))
end

function BattleResultGveComp:update(arg_2_1)
	local var_2_0 = arg_2_1.content or {}
	local var_2_1 = var_2_0.recover_action or 0
	local var_2_2 = var_2_0.star or {}
	local var_2_3 = var_0_1.get(var_0_2:getGveData():getBuildDataByPos({
		x = var_2_0.x,
		y = var_2_0.y
	}).cfg.base_id)
	local var_2_4 = 0

	self._starList = {}

	for iter_2_0 = 1, 3 do
		table.insert(self._starList, {
			isActive = var_2_2[iter_2_0] == true,
			desc = var_0_0.fetch(var_2_3["battle_rating_id_" .. iter_2_0]).name
		})

		if var_2_2[iter_2_0] == true then
			var_2_4 = var_2_4 + 1
		end
	end

	self.m_starList:setNumItems(#self._starList)

	self._knightList = {}

	for iter_2_1 = 1, 6 do
		local var_2_5 = self._formationData:getKnightByPos(iter_2_1)

		if var_2_5 then
			table.insert(self._knightList, {
				knight = var_2_5,
				action = self._formationData:getKnightActionBySid(var_2_5:getServerId()),
				addAction = var_2_1
			})
		end
	end
end

function BattleResultGveComp:_onListEnter()
	self.m_knightList:setNumItems(#self._knightList)
	self.m_knightList:transitionShowCells("listIconUiLeftIn", 0.03, 1)
end

function BattleResultGveComp:_onStarListRender(arg_4_1, arg_4_2)
	local var_4_0 = self._starList[arg_4_1 + 1] or {}

	arg_4_2:setTitle(arg_4_1 + 1 .. "." .. var_4_0.desc)
	arg_4_2:getController("isActive"):setSelectedIndex(var_4_0.isActive and 1 or 0)
end

function BattleResultGveComp:_onKnightListItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateComp(self._knightList[arg_5_1 + 1], (arg_5_1 + 1) * 0.03)
end

return BattleResultGveComp
