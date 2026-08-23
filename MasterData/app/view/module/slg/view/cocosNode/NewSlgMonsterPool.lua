local NewSlgMonsterPool = class("NewSlgMonsterPool", require("app.core.tilemap.TilemapNodePool"))
local NewSlgMonsterNode = require("app.view.module.slg.view.cocosNode.NewSlgMonsterNode")
local var_0_2 = g.core.const.ConstMgr.NewSlgConst

function NewSlgMonsterPool:ctor(arg_1_1)
	self._map = arg_1_1:getMapNode()
	self._mapComp = arg_1_1

	self.super.ctor(self, {
		poolNum = var_0_2.MONSTER_POOL_MAX,
		mapNode = self._map:getMapNode()
	})
end

function NewSlgMonsterPool:updateNode(arg_2_1, arg_2_2)
	if not self:_checkNode(arg_2_1) and not arg_2_2 then
		return
	end

	local var_2_0 = self:_getNode(arg_2_1)

	if var_2_0 == nil then
		local var_2_1 = NewSlgMonsterNode.new(self._map, self._mapComp)

		self._map._buildingNode:addChild(var_2_1)
		self:_addNode(var_2_1, arg_2_1)
	else
		self:_updateNode(var_2_0, arg_2_1)
	end
end

function NewSlgMonsterPool:update(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self._pool) do
		if not tolua.isnull(iter_3_1.node) then
			iter_3_1.node:update(arg_3_1)
		end
	end
end

return NewSlgMonsterPool
