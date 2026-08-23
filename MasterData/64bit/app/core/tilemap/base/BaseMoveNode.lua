local BaseMoveNode = class("BaseMoveNode", require("app.core.tilemap.base.BaseNode"))

function BaseMoveNode:updatePath(arg_1_1, arg_1_2)
	self._path = {}
	self._moveDelta = cc.p(0, 0)
	self._deltaDt = 0

	if arg_1_1 and #arg_1_1 > 1 then
		if arg_1_2 and arg_1_2 < 0 then
			g.core.log:info("BaseMoveNode:updatePath hasGoneTime = " .. arg_1_2)

			arg_1_2 = 0
		end

		if arg_1_2 and arg_1_2 >= 0 then
			if arg_1_2 >= (#arg_1_1 - 1) / self._speed then
				self._isRunning = false

				self:setRealPos(arg_1_1[#arg_1_1].pos.x, arg_1_1[#arg_1_1].pos.y)
				self:_removePath(arg_1_1, #arg_1_1)
				self:playReadyAction()
				self._map:eventHandler("node_move_end", {
					data = self._data,
					cell = self
				})

				return
			else
				self:_removePath(arg_1_1, (math.floor(arg_1_2 * self._speed)))

				if #arg_1_1 > 0 and arg_1_1[1].pos then
					self:setRealPos(arg_1_1[1].pos.x, arg_1_1[1].pos.y)
				end

				self:_removePath(arg_1_1, 1)

				if #arg_1_1 > 0 then
					self._moveDelta = cc.p(arg_1_1[1].pos.x - self._mapPos.x, arg_1_1[1].pos.y - self._mapPos.y)

					self:_changeFace(self._moveDelta)

					self._deltaDt = self._deltaDt + arg_1_2 % self._speedTime

					if self._deltaDt > self._speedTime then
						self._deltaDt = self._speedTime or self._deltaDt
					end

					local var_1_0 = cc.p(self._moveDelta.x * self._deltaDt * self._speed, self._moveDelta.y * self._deltaDt * self._speed)
					local var_1_1 = cc.p(self._mapPos.x + var_1_0.x, self._mapPos.y + var_1_0.y)

					self._curSprLine = arg_1_1[1].line

					self:_setRolePosition(var_1_1.x, var_1_1.y)
				end
			end
		end

		self._path = arg_1_1
	end

	if next(self._path) then
		if not arg_1_2 or arg_1_2 < 0 then
			self._moveDelta = cc.p(0, 0)
		end

		self._isRunning = true

		self:playRunAction()

		self._lastMoveTime = cc.utils.gettime() / 1000
		self._beginTestTime = g.core.common.ServerTime:getTime()
	end
end

return BaseMoveNode
