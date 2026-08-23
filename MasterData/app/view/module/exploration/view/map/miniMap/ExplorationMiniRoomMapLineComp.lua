local var_0_0 = g.core.model.User.explorationData
local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")
local ExplorationMiniRoomMapLineComp = class("ExplorationMiniRoomMapLineComp", require("app.fairyGUI.exploration.UI_ExplorationMiniRoomMapLineComp"))

function ExplorationMiniRoomMapLineComp:ctor()
	self._lineDict = {}
end

function ExplorationMiniRoomMapLineComp:setRootPos(arg_2_1)
	self.m_roomRootNode:setPosition(arg_2_1)
end

function ExplorationMiniRoomMapLineComp:updateRoomComp()
	local var_3_0 = var_0_0:getMapData():getCurMapInfo()

	self._roomData = var_3_0.roomTab

	self:updateView(var_3_0.maxX, var_3_0.maxY)
end

function ExplorationMiniRoomMapLineComp:updateView(arg_4_1, arg_4_2)
	local var_4_0 = var_0_0:getMapData()
	local var_4_1 = {}

	for iter_4_0 = 1, arg_4_2 do
		var_4_1[iter_4_0] = {}

		local var_4_2 = 1

		while var_4_2 <= arg_4_1 do
			local var_4_3 = true

			local function var_4_4(arg_5_0)
				local var_5_0 = var_4_0:getRoomStructByCoordinate(cc.p(arg_5_0, iter_4_0))

				if var_5_0 then
					local var_5_1 = var_5_0:getEntranceList()[ExplorationConst.DIRECTION.RIGHT]

					if var_5_1 then
						if var_5_1:getCfg().difficulty == var_5_0:getCfg().difficulty or var_4_3 then
							var_4_3 = false
							arg_5_0 = arg_5_0 + 1
							var_4_1[iter_4_0][var_4_2] = arg_5_0

							return var_4_4(arg_5_0)
						elseif var_5_1:getCfg().difficulty < var_5_0:getCfg().difficulty then
							arg_5_0 = arg_5_0 + 1
							var_4_1[iter_4_0][var_4_2] = arg_5_0

							return arg_5_0
						else
							var_4_3 = true

							return arg_5_0
						end
					else
						return arg_5_0 + 1
					end
				else
					return arg_5_0 + 1
				end
			end

			var_4_2 = var_4_4(var_4_2)
		end
	end

	local var_4_5 = {}

	for iter_4_1 = 1, arg_4_1 do
		var_4_5[iter_4_1] = {}

		local var_4_6 = 1

		while var_4_6 <= arg_4_2 do
			local var_4_7 = true

			local function var_4_8(arg_6_0)
				local var_6_0 = var_4_0:getRoomStructByCoordinate(cc.p(iter_4_1, arg_6_0))

				if var_6_0 then
					local var_6_1 = var_6_0:getEntranceList()[ExplorationConst.DIRECTION.DOWN]

					if var_6_1 then
						if var_6_1:getCfg().difficulty == var_6_0:getCfg().difficulty or var_4_7 then
							var_4_7 = false
							arg_6_0 = arg_6_0 + 1
							var_4_5[iter_4_1][var_4_6] = arg_6_0

							return var_4_8(arg_6_0)
						elseif var_6_1:getCfg().difficulty < var_6_0:getCfg().difficulty then
							arg_6_0 = arg_6_0 + 1
							var_4_5[iter_4_1][var_4_6] = arg_6_0

							return arg_6_0
						else
							var_4_7 = true

							return arg_6_0
						end
					else
						return arg_6_0 + 1
					end
				else
					return arg_6_0 + 1
				end
			end

			var_4_6 = var_4_8(var_4_6)
		end
	end

	local var_4_9 = self.m_firstPosNode:getPosition()

	for iter_4_2, iter_4_3 in pairs(var_4_1) do
		for iter_4_4, iter_4_5 in pairs(iter_4_3) do
			if iter_4_4 < iter_4_5 then
				local var_4_10 = var_4_0:getRoomStructByCoordinate(cc.p(iter_4_4 + 1, iter_4_2))
				local var_4_11 = self._lineDict[iter_4_2 .. "y" .. iter_4_4 .. "_" .. iter_4_5]

				if not self._lineDict[iter_4_2 .. "y" .. iter_4_4 .. "_" .. iter_4_5] then
					var_4_11 = fgui.GLoader:create()
					self._lineDict[iter_4_2 .. "y" .. iter_4_4 .. "_" .. iter_4_5] = var_4_11

					var_4_11:setPivot(1, 0.5, true)
					var_4_11:setSize(81 * (iter_4_5 - iter_4_4), 12)
					var_4_11:setFill(4)
					self.m_roomRootNode:addChild(var_4_11)
					var_4_11:setPosition(cc.p(var_4_9.x + (iter_4_4 - iter_4_2) * 144 / 2, var_4_9.y + (iter_4_4 + iter_4_2 - 2) * 72 / 2))
				end

				var_4_11:setRotation(206.5)
				var_4_11:setURL("ui://exploration/pic_slmj_line" .. var_4_10:getCfg().difficulty)
			end
		end
	end

	for iter_4_6, iter_4_7 in pairs(var_4_5) do
		for iter_4_8, iter_4_9 in pairs(iter_4_7) do
			if iter_4_8 < iter_4_9 then
				local var_4_12 = var_4_0:getRoomStructByCoordinate(cc.p(iter_4_6, iter_4_8 + 1))
				local var_4_13 = self._lineDict[iter_4_6 .. "x" .. iter_4_8 .. "_" .. iter_4_9]

				if not self._lineDict[iter_4_6 .. "x" .. iter_4_8 .. "_" .. iter_4_9] then
					var_4_13 = fgui.GLoader:create()
					self._lineDict[iter_4_6 .. "x" .. iter_4_8 .. "_" .. iter_4_9] = var_4_13

					var_4_13:setPivot(1, 0.5, true)
					var_4_13:setSize(81 * (iter_4_9 - iter_4_8), 12)
					var_4_13:setFill(4)
					self.m_roomRootNode:addChild(var_4_13)
					var_4_13:setPosition(cc.p(var_4_9.x + (iter_4_6 - iter_4_8) * 144 / 2, var_4_9.y + (iter_4_6 + iter_4_8 - 2) * 72 / 2))
				end

				var_4_13:setRotation(333.5)
				var_4_13:setURL("ui://exploration/pic_slmj_line" .. var_4_12:getCfg().difficulty)
			end
		end
	end
end

return ExplorationMiniRoomMapLineComp
