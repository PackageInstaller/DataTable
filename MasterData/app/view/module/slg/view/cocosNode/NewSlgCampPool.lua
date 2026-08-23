local NewSlgCampPool = class("NewSlgCampPool", require("app.core.tilemap.TilemapNodePool"))
local NewSlgCampNode = require("app.view.module.slg.view.cocosNode.NewSlgCampNode")
local var_0_2 = g.core.const.ConstMgr.NewSlgConst

function NewSlgCampPool:ctor(arg_1_1)
	self._map = arg_1_1:getMapNode()
	self._mapComp = arg_1_1

	self.super.ctor(self, {
		poolNum = var_0_2.CAMP_POOL_MAX,
		mapNode = self._map:getMapNode()
	})
end

function NewSlgCampPool:updateNode(arg_2_1)
	if not self:_checkNode(arg_2_1) then
		return
	end

	local var_2_0 = self:_getNode(arg_2_1)

	if var_2_0 == nil then
		local var_2_1 = NewSlgCampNode.new(self._map, self._mapComp)

		self._map._buildingNode:addChild(var_2_1)
		self:_addNode(var_2_1, arg_2_1)
	else
		self:_updateNode(var_2_0, arg_2_1)
	end
end

return NewSlgCampPool
