local NewSlgChariotPool = class("NewSlgChariotPool", require("app.core.tilemap.TilemapNodePool"))
local NewSlgChariotNode = require("app.view.module.slg.view.cocosNode.NewSlgChariotNode")
local NewSlg2ChariotNode = require("app.view.module.slg.view.cocosNode.NewSlg2ChariotNode")
local var_0_3 = g.core.const.ConstMgr.NewSlgConst

function NewSlgChariotPool:ctor(arg_1_1)
	self._map = arg_1_1:getMapNode()
	self._mapComp = arg_1_1

	self.super.ctor(self, {
		poolNum = var_0_3.CHARIOT_POOL_MAX,
		mapNode = self._map:getMapNode()
	})
end

function NewSlgChariotPool:updateNode(arg_2_1)
	if not self:_checkNode(arg_2_1) then
		return
	end

	local var_2_0 = self:_getNode(arg_2_1)

	if var_2_0 == nil then
		local var_2_1 = g.core.model.User.newSlgData:getSName() == "S1" and NewSlgChariotNode.new(self._map, self._mapComp) or NewSlg2ChariotNode.new(self._map, self._mapComp)

		self._map._buildingNode:addChild(var_2_1)
		self:_addNode(var_2_1, arg_2_1)
	else
		self:_updateNode(var_2_0, arg_2_1)
	end
end

function NewSlgChariotPool:update(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self._pool) do
		if not tolua.isnull(iter_3_1.node) then
			iter_3_1.node:update(arg_3_1)
		end
	end
end

return NewSlgChariotPool
