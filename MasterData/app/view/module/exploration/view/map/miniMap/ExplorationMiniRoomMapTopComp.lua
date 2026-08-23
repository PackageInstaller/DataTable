local var_0_0 = g.core.model.User.explorationData
local ExplorationMapCommon = require("app.view.module.exploration.common.ExplorationMapCommon")
local ExplorationMiniRoomMapTopComp = class("ExplorationMiniRoomMapTopComp", require("app.fairyGUI.exploration.UI_ExplorationMiniRoomMapTopComp"))

function ExplorationMiniRoomMapTopComp:ctor()
	self._followFunc = nil
	self._battleIconLoaderDict = {}
	self._effectEnable = false
	self._mirrorEffUp = nil
	self._mirrorEffDown = nil
end

function ExplorationMiniRoomMapTopComp:updateRoomComp()
	local var_2_0 = var_0_0:getMapData():getCurMapInfo()

	self._roomData = var_2_0.roomTab

	local var_2_1 = var_0_0:getMapData()
	local var_2_2 = ExplorationMapCommon.getRoomCoordinateAndCoordinateByGlobalCoordinate((var_2_1:getMirrorCoordinate()))
	local var_2_3 = ExplorationMapCommon.getRoomCoordinateAndCoordinateByGlobalCoordinate((var_2_1:getMainRoleCoordinate()))
	local var_2_4 = self.m_firstPosNode:getPosition()

	for iter_2_0 = 1, var_2_0.maxY do
		for iter_2_1 = 1, var_2_0.maxX do
			local var_2_5 = var_2_1:getRoomStructByCoordinate(cc.p(iter_2_1, iter_2_0))

			if var_2_5 then
				local var_2_6 = var_2_2.x == iter_2_1 and var_2_2.y == iter_2_0
				local var_2_7 = var_2_3.x == iter_2_1 and var_2_3.y == iter_2_0
				local var_2_8 = cc.size(144, 72)
				local var_2_9 = var_2_4.x + (iter_2_1 - iter_2_0) * var_2_8.width / 2
				local var_2_10 = var_2_4.y + (iter_2_1 + iter_2_0 - 2) * var_2_8.height / 2
				local var_2_11 = var_2_5:getCfg().difficulty
				local var_2_12 = iter_2_1 .. "_" .. iter_2_0

				if var_2_3.x == iter_2_1 and var_2_3.y == iter_2_0 then
					local var_2_13 = self._battleIconLoaderDict[var_2_12]

					if not self._battleIconLoaderDict[var_2_12] then
						var_2_13 = fgui.GLoader:create()
						self._battleIconLoaderDict[var_2_12] = var_2_13

						var_2_13:setPivot(0.5, 1, true)
						var_2_13:setAutoSize(true)
						var_2_13:setPosition(var_2_9, var_2_10)
						self.m_roomRootNode:addChild(var_2_13)
					end

					var_2_13:setURL("ui://exploration/pic_slmj_map1_dangqian")
					var_2_13:setVisible(true)
				elseif var_2_11 == 1 then
					if self._battleIconLoaderDict[var_2_12] then
						self._battleIconLoaderDict[var_2_12]:setVisible(false)
					end
				else
					local var_2_14 = self._battleIconLoaderDict[var_2_12]

					if not self._battleIconLoaderDict[var_2_12] then
						var_2_14 = fgui.GLoader:create()
						self._battleIconLoaderDict[var_2_12] = var_2_14

						var_2_14:setPivot(0.5, 1, true)
						var_2_14:setAutoSize(true)
						var_2_14:setPosition(var_2_9, var_2_10)
						self.m_roomRootNode:addChild(var_2_14)
					end

					if var_2_11 == 2 then
						var_2_14:setURL("ui://exploration/pic_slmj_map3_tiaozhan")
					else
						var_2_14:setURL("ui://exploration/pic_slmj_map2_gaonan")
					end

					var_2_14:setVisible(true)
				end

				local var_2_15 = self._battleIconLoaderDict[var_2_12]

				if var_2_6 then
					if not self._mirrorLoader then
						self._mirrorLoader = fgui.GLoader:create()

						self._mirrorLoader:setURL("ui://exploration/pic_slmj_map4_baozang")
						self._mirrorLoader:setPivot(0.5, 1, true)
						self._mirrorLoader:setAutoSize(true)
						self._mirrorLoader:setPosition(var_2_9, var_2_10)
						self.m_roomRootNode:addChild(self._mirrorLoader)
						self:_playMirrorEffect(var_2_9, var_2_10)
					end

					self._mirrorLoader:setVisible(true)

					if var_2_15 then
						var_2_15:setVisible(false)
					end
				else
					if self._mirrorLoader then
						self._mirrorLoader:setVisible(false)
					end

					if var_2_15 and var_2_7 then
						var_2_15:setVisible(true)
					end
				end
			end
		end
	end
end

function ExplorationMiniRoomMapTopComp:setEffectEnable(arg_3_1)
	self._effectEnable = arg_3_1
end

function ExplorationMiniRoomMapTopComp:_playMirrorEffect(arg_4_1, arg_4_2)
	if self._effectEnable then
		if not self._mirrorEffUp then
			self._mirrorEffUp = self.m_roomRootNode:addEffectSpine({
				anim = "playUp",
				name = "eff_ui_explorationMap_iconIdle",
				remove = false,
				isLoop = true
			})

			self._mirrorEffUp:setPosition(arg_4_1, -arg_4_2 + 50)
		end

		self._mirrorEffUp:setVisible(true)

		if not self._mirrorEffDown then
			self._mirrorEffDown = self.m_roomRootNode:addEffectSpine({
				anim = "playDown",
				name = "eff_ui_explorationMap_iconIdle",
				isLoop = true,
				remove = false,
				zorder = -1
			})

			self._mirrorEffDown:setPosition(arg_4_1, arg_4_2 + 50)
		end

		self._mirrorEffDown:setVisible(true)
	else
		if self._mirrorEffUp then
			self._mirrorEffUp:setVisible(false)
		end

		if self._mirrorEffDown then
			self._mirrorEffDown:setVisible(false)
		end
	end
end

function ExplorationMiniRoomMapTopComp:setRootPos(arg_5_1)
	self.m_roomRootNode:setPosition(arg_5_1)
end

return ExplorationMiniRoomMapTopComp
