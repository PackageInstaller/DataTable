local NewSlgMarchNode = class("NewSlgMarchNode", require("app.core.tilemap.base.BaseMoveNode"))
local TileMapFunc = require("app.core.tilemap.TileMapFunc")
local var_0_3 = g.core.const.ConstMgr.NewSlgConst
local NewSlgIconNode = require("app.view.module.slg.view.cocosNode.NewSlgIconNode")

function NewSlgMarchNode:ctor(arg_1_1, arg_1_2)
	self.super.ctor(self, arg_1_1, arg_1_2)

	self._pathData = nil
	self._lineDir = 0
end

function NewSlgMarchNode:_initFGui()
	self._cocosNode = NewSlgIconNode:create()

	self._cocosNode:setScale(0.8)
	self._cocosNode:setVisible(false)
	self:addChild(self._cocosNode)
end

function NewSlgMarchNode:_findPath()
	return self._objectData.path
end

function NewSlgMarchNode:setData(arg_4_1)
	self:setCustomVisible(true)

	self._data = arg_4_1
	self._objectData = arg_4_1.objectData

	local var_4_0 = self._objectData.teamData
	local var_4_1 = {
		authority = self._objectData.authority
	}

	if self._objectData.teamData.uid == g.core.model.User:getId() then
		var_4_1.roleType = var_0_3.BATTLE_PLAYER_TYPE.SELF or var_0_3.BATTLE_PLAYER_TYPE.FRIEND
	end

	var_4_1.deltaInfo = {
		name = var_4_0.name,
		troop_type = var_4_0.troop_type,
		character = var_4_0.show_character,
		cur_troops = var_4_0.cur_troops,
		max_troops = var_4_0.max_troops
	}

	self._cocosNode:setData(var_4_1)

	local var_4_2 = g.core.common.ServerTime:getTime() - self._objectData.startTime
	local var_4_3 = self:_findPath()

	if var_4_3 and #var_4_3 > 1 then
		self._speedTime = self._objectData.duration / (#var_4_3 - 1)
		self._speedTime = math.max(self._speedTime, 1)
		self._speed = 1 / self._speedTime

		self._cocosNode:setVisible(true)
		self:updatePath(self._map:drawPath(var_4_3, var_4_0.uid == g.core.model.User:getId()), var_4_2)
	end
end

function NewSlgMarchNode:updatePath(arg_5_1, arg_5_2)
	self.super.updatePath(self, arg_5_1, arg_5_2)

	self._pathData = arg_5_1

	self:updateShowPath()
end

function NewSlgMarchNode:updateShowPath()
	if not self._pathData then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(self._pathData) do
		if iter_6_1.line then
			if self._map:isOutOfEye(TileMapFunc.rc2p(iter_6_1.pos.x, iter_6_1.pos.y)) then
				iter_6_1.line:setVisible(false)
			else
				iter_6_1.line:setVisible(true)
			end
		end
	end
end

function NewSlgMarchNode:update(arg_7_1)
	if not self:isVisible() then
		return
	end

	if self._path and next(self._path) and self._mapPos then
		self:_updateMove()

		self._lineDir = self._lineDir - 0.25

		self:updatePathAnim()
	end

	self:updateShowPath()
end

function NewSlgMarchNode:updatePathAnim()
	for iter_8_0, iter_8_1 in ipairs(self._path) do
		if iter_8_1.line and iter_8_1.line:isVisible() then
			local var_8_0 = iter_8_1.line:getChildren()[1]
			local var_8_1, var_8_2 = var_8_0:getPosition()

			if self._lineDir < -53.5 then
				self._lineDir = 0

				var_8_0:setPosition(self._lineDir, var_8_2)
			else
				var_8_0:setPosition(self._lineDir, var_8_2)
			end
		end
	end
end

function NewSlgMarchNode:_removeSelf()
	self:setCustomVisible(false)
	self._map:eventHandler("newSlg_march_node_move_end", {
		data = self._data,
		cell = self
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NEW_SLG_PATH_FINISH)
end

return NewSlgMarchNode
