local NewSlgMarchPool = class("NewSlgMarchPool", require("app.core.tilemap.TilemapNodePool"))
local NewSlgMarchNode = require("app.view.module.slg.view.cocosNode.NewSlgMarchNode")
local var_0_2 = g.core.const.ConstMgr.NewSlgConst

function NewSlgMarchPool:ctor(arg_1_1)
	self._map = arg_1_1:getMapNode()
	self._mapComp = arg_1_1

	self.super.ctor(self, {
		poolNum = var_0_2.MARCH_POOL_MAX,
		mapNode = self._map:getMapNode()
	})
end

function NewSlgMarchPool:_isOutOfEye(arg_2_1, arg_2_2)
	return false
end

function NewSlgMarchPool:findNode(arg_3_1)
	if not arg_3_1 then
		return nil
	end

	for iter_3_0, iter_3_1 in ipairs(self._pool) do
		if arg_3_1.id ~= nil and arg_3_1.id == iter_3_1.id then
			return iter_3_1, iter_3_0
		end
	end

	return nil
end

function NewSlgMarchPool:updateNode(arg_4_1)
	if not self:_checkNode(arg_4_1) then
		return
	end

	local var_4_0 = self:_getNode(arg_4_1)

	if var_4_0 == nil then
		local var_4_1 = NewSlgMarchNode.new(self._map, self._mapComp)

		self._map._pathHeadNode:addChild(var_4_1)
		self:_addNode(var_4_1, arg_4_1)
	else
		self:_updateNode(var_4_0, arg_4_1)
	end
end

function NewSlgMarchPool:update(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self._pool) do
		if not tolua.isnull(iter_5_1.node) then
			iter_5_1.node:update(arg_5_1)
		end
	end
end

return NewSlgMarchPool
