local NewSlgBossPool = class("NewSlgBossPool", require("app.core.tilemap.TilemapNodePool"))
local NewSlgBossNode = require("app.view.module.slg.view.cocosNode.NewSlgBossNode")
local var_0_2 = g.core.const.ConstMgr.NewSlgConst

function NewSlgBossPool:ctor(arg_1_1)
	self._map = arg_1_1:getMapNode()
	self._mapComp = arg_1_1

	self.super.ctor(self, {
		poolNum = var_0_2.BOSS_POOL_MAX,
		mapNode = self._map:getMapNode()
	})
end

function NewSlgBossPool:updateNode(arg_2_1)
	if not self:_checkNode(arg_2_1) then
		return
	end

	local var_2_0 = self:_getNode(arg_2_1)

	if var_2_0 == nil then
		local var_2_1 = NewSlgBossNode.new(self._map, self._mapComp)

		self._map._buildingNode:addChild(var_2_1)
		self:_addNode(var_2_1, arg_2_1)
	else
		self:_updateNode(var_2_0, arg_2_1)
	end
end

function NewSlgBossPool:update(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self._pool) do
		if not tolua.isnull(iter_3_1.node) then
			iter_3_1.node:update(arg_3_1)
		end
	end
end

return NewSlgBossPool
