local RichmanConst = require("app.view.module.richman.const.RichmanConst")
local var_0_1 = g.core.model.User.guideData
local var_0_2 = g.core.const.ConstMgr.GuideConst
local var_0_3 = g.core.config.richman_event_info
local CommonKnight = require("app.view.common.CommonKnight")
local var_0_5 = g.core.const.ConstMgr.SpineConst
local var_0_6 = g.core.model.User.knightsData
local var_0_7 = g.core.model.User.richmanData
local RichmanMapWorld = class("RichmanMapWorld", require("app.fairyGUI.richman.UI_RichmanMapWorld"))

function RichmanMapWorld:ctor()
	self.m_mapHolder:addEffectSpine({
		isLoop = true,
		name = var_0_7:getMapCfg().spine
	})

	self._MAP_TILE_HW = 82
	self._MAP_TILE_HH = 41
	self._HALF_RANGE = math.ceil(math.sqrt(display.width^2 + display.height^2) / self._MAP_TILE_HW / 2) + 1
	self._HALF_WIDTH_SIZE = self._HALF_RANGE
	self._HALF_HEIGHT_SIZE = self._HALF_RANGE
	self._gridPool = {}
	self._inShowGrid = {}
	self._roleIndex = var_0_7:getCurrentIndex()
	self._gridMap = {}
	self._entityEffPosDir = {
		x = self._MAP_TILE_HW / 2 - 20,
		y = self._MAP_TILE_HH / 2 + 11
	}
	self._buildComp = {}

	self:createRole()
	self:createBuild()
end

function RichmanMapWorld:coordToPixelF(arg_2_1, arg_2_2)
	return (arg_2_1 - arg_2_2) * self._MAP_TILE_HW, -(-(arg_2_1 + arg_2_2) * self._MAP_TILE_HH)
end

function RichmanMapWorld:pixelToCoordF(arg_3_1, arg_3_2)
	arg_3_2 = -arg_3_2

	return math.round((arg_3_1 / self._MAP_TILE_HW + -arg_3_2 / self._MAP_TILE_HH) / 2), math.round((-arg_3_2 / self._MAP_TILE_HH - arg_3_1 / self._MAP_TILE_HW) / 2)
end

function RichmanMapWorld:createRole()
	self._ownEntity = fgui.UIPackage:createObject("base_new", "BasePlaceHolderComp")

	local var_4_0 = var_0_6:getMainRoleKnight()[1]

	self._entityDownEffHolder = fgui.UIPackage:createObject("base_new", "BasePlaceHolderComp")

	self._ownEntity:addChild(self._entityDownEffHolder)

	local var_4_1 = g.core.model.User:getAssistantDressId()
	local var_4_2 = CommonKnight.new((g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot((g.core.model.User:packUser()))))

	var_4_2:setScale(0.8)
	self._ownEntity:addChild(var_4_2)

	self._entityUpEffHolder = fgui.UIPackage:createObject("base_new", "BasePlaceHolderComp")

	self._ownEntity:addChild(self._entityUpEffHolder)

	local var_4_3 = var_0_7:getRoleIndexPos(self._roleIndex)
	local var_4_4, var_4_5 = self:getRoleGridPos(var_4_3.x, var_4_3.y)

	self.m_playerHolder:addChild(self._ownEntity)
	self._ownEntity:setPosition(var_4_4, var_4_5)
	var_4_2:setScaleX(var_0_7:getNextMoveDir())
end

function RichmanMapWorld:getRoleGridPos(arg_5_1, arg_5_2)
	local var_5_0, var_5_1 = self:coordToPixelF(arg_5_1, arg_5_2)

	return var_5_0 + self._MAP_TILE_HW - 50, var_5_1 + self._MAP_TILE_HH - 15
end

function RichmanMapWorld:getRolePos()
	return self:globalToLocal(self._ownEntity:localToGlobal(cc.p(0, 0)))
end

function RichmanMapWorld:addGirdFromPool(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0, var_7_1 = self:coordToPixelF(arg_7_1, arg_7_2)

	if not self._gridPool[1] then
		local var_7_2 = fgui.UIPackage:createObject("richman", "RichmanPathGridComp")

		self.m_pathHolder:addChild(var_7_2)
		var_7_2:changeGridType(arg_7_3, arg_7_1, arg_7_2)
		var_7_2:setPosition(var_7_0, var_7_1)

		self._inShowGrid[arg_7_1 .. "_" .. arg_7_2] = var_7_2
	else
		local var_7_3 = table.remove(self._gridPool, 1)

		var_7_3:setVisible(true)
		var_7_3:setPosition(var_7_0, var_7_1)
		var_7_3:changeGridType(arg_7_3, arg_7_1, arg_7_2)

		self._inShowGrid[arg_7_1 .. "_" .. arg_7_2] = var_7_3
	end
end

function RichmanMapWorld:returnGridIntoPool(arg_8_1, arg_8_2)
	if self._inShowGrid[arg_8_1 .. "_" .. arg_8_2] then
		self._inShowGrid[arg_8_1 .. "_" .. arg_8_2]:setVisible(false)
		table.insert(self._gridPool, self._inShowGrid[arg_8_1 .. "_" .. arg_8_2])

		self._inShowGrid[arg_8_1 .. "_" .. arg_8_2] = nil
	end
end

function RichmanMapWorld:updateGridShow(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self._inShowGrid) do
		iter_9_1:updateGridShow(arg_9_1)
	end
end

function RichmanMapWorld:addAnimIntoAnimList(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = 0
	local var_10_1, var_10_2 = self:getRoleGridPos(arg_10_2.endPos.x, arg_10_2.endPos.y)
	local var_10_3 = math.abs(arg_10_2.endPos.x - arg_10_2.startPos.x) + math.abs(arg_10_2.endPos.y - arg_10_2.startPos.y)
	local var_10_4 = 1

	var_10_4 = arg_10_2.endPos.y ~= arg_10_2.startPos.y and (arg_10_2.endPos.y > arg_10_2.startPos.y and -1 or 1) or arg_10_2.endPos.x > arg_10_2.startPos.x and 1 or -1

	table.insert(arg_10_1, fgui.FCallFunc:create(handler(self, function(arg_11_0)
		arg_11_0._ownEntity:getChild("CommonKnight"):setScaleX(var_10_4)
	end)))
	table.insert(arg_10_1, fgui.FMoveTo:create(RichmanConst.PER_GRID_RUN_TIME * var_10_3, cc.p(var_10_1, var_10_2)))

	if arg_10_2.pauseEvent then
		table.insert(arg_10_1, fgui.FCallFunc:create(handler(self, function(arg_12_0)
			arg_12_0:playIdleAnim()
		end)))

		if RichmanConst.EVENT_PAUSE_EFFECT[arg_10_2.pauseEvent] then
			table.insert(arg_10_1, fgui.FCallFunc:create(handler(self, function(arg_13_0)
				arg_13_0:playRoleSpineEff(RichmanConst.EVENT_PAUSE_EFFECT[arg_10_2.pauseEvent])
				arg_13_0:dispatchCompEvent(RichmanConst.EVENT_PAUSE_EVENT[arg_10_2.pauseEvent])
				g.core.sound.SoundManager:playSound(RichmanConst.EVENT_PAUSE_SOUND[arg_10_2.pauseEvent])
			end)))

			if arg_10_3 < arg_10_4 then
				table.insert(arg_10_1, fgui.FDelayTime:create(1))
				table.insert(arg_10_1, fgui.FCallFunc:create(handler(self, function(arg_14_0)
					arg_14_0:playRunAnim()
				end)))
			end
		end

		if arg_10_2.pauseEvent == RichmanConst.GRID_TYPE.START_GRID then
			var_10_0 = 1

			table.insert(arg_10_1, fgui.FCallFunc:create(handler(self, function(arg_15_0)
				arg_15_0:playIdleAnim()
			end)))
			table.insert(arg_10_1, fgui.FDelayTime:create(0.5))
			table.insert(arg_10_1, fgui.FCallFunc:create(handler(self, self.playAnimStartPointChange)))
		end
	end

	return var_10_0
end

function RichmanMapWorld:roleMove(arg_16_1, arg_16_2)
	self._ownEntity:stopAllFGActions()

	local var_16_0 = var_0_7:gotoPathWithStepAddAfter(arg_16_1)
	local var_16_1, var_16_2 = self:getRoleGridPos(var_16_0[1].startPos.x, var_16_0[1].startPos.y)

	self._ownEntity:setPosition(var_16_1, var_16_2)
	self:playRunAnim()

	local var_16_3, var_16_4 = self:getMoveActionByList(var_16_0, arg_16_2)

	self._moveAnimCacheList = var_16_4

	self._ownEntity:runFGAction(fgui.FSequence:create(var_16_3))
end

function RichmanMapWorld:getMoveActionByList(arg_17_1, arg_17_2)
	local var_17_0 = {}
	local var_17_1 = {}
	local var_17_2 = 0

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		if var_17_2 == 0 then
			var_17_2 = self:addAnimIntoAnimList(var_17_0, iter_17_1, iter_17_0, #arg_17_1)
		else
			table.insert(var_17_1, iter_17_1)
		end
	end

	if not next(var_17_1) then
		if var_17_2 ~= 0 then
			table.insert(var_17_0, fgui.FCallFunc:create(handler(self, function(arg_18_0)
				arg_18_0:playIdleAnim()
			end)))

			self._mapRefreshFinishCall = arg_17_2
		else
			table.insert(var_17_0, fgui.FCallFunc:create(handler(self, function(arg_19_0)
				arg_17_2()
				arg_19_0:playIdleAnim()
			end)))
		end
	else
		var_17_1.finishCall = arg_17_2
	end

	return var_17_0, var_17_1
end

function RichmanMapWorld:playAnimStartPointChange()
	self:dispatchCompEvent("RICH_MAN_PASS_START_GRID", {
		worldPos = self._ownEntity:localToGlobal(cc.p(-30, -30))
	})
	self:updateGridShow(true)

	if self._moveAnimCacheList and next(self._moveAnimCacheList) then
		local var_20_0, var_20_1 = self:getMoveActionByList(self._moveAnimCacheList, self._moveAnimCacheList.finishCall)

		table.insert(var_20_0, 1, fgui.FCallFunc:create(handler(self, self.playRunAnim)))
		table.insert(var_20_0, 1, fgui.FDelayTime:create(1))

		self._moveAnimCacheList = var_20_1

		self._ownEntity:runFGAction(fgui.FSequence:create(var_20_0))
	end

	if self._mapRefreshFinishCall then
		self._mapRefreshFinishCall()

		self._mapRefreshFinishCall = nil
	end
end

function RichmanMapWorld:playBuildLevelUpAnim(arg_21_1)
	if self._buildComp[arg_21_1] then
		self._buildComp[arg_21_1]:playLevelUpAnim()
	end
end

function RichmanMapWorld:showPlayerHeardReward(arg_22_1)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		local var_22_1 = fgui.UIPackage:createObject("richman", "RichmanRewardItemComp")

		var_22_1:updateRewardItem(iter_22_1)
		self._ownEntity:addChild(var_22_1)
		table.insert(var_22_0, var_22_1)
	end

	local var_22_2 = 0

	for iter_22_2, iter_22_3 in ipairs(var_22_0) do
		var_22_2 = var_22_2 < iter_22_3:getWidth() and iter_22_3:getWidth() or var_22_2
	end

	for iter_22_4, iter_22_5 in ipairs(var_22_0) do
		iter_22_5:setPosition(var_22_2 * (#var_22_0 - 1) / 2 + var_22_2 * (iter_22_4 - 1), -150)
		iter_22_5:runFGAction(fgui.FSequence:create({
			fgui.FSpawn:create(fgui.FMoveBy:create(2, cc.p(0, -40)), fgui.FFadeOut:create(2)),
			fgui.FRemoveSelf:create()
		}))
	end

	self:dispatchCompEvent("RICH_MAN_SHOW_ICON_EFF", {
		award = arg_22_1[1],
		worldPos = self._ownEntity:localToGlobal(cc.p(-30, -30)),
		flyNum = arg_22_1.flyNum
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Prizehead)
end

function RichmanMapWorld:showBuildHeardReward(arg_23_1, arg_23_2)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		local var_23_1 = fgui.UIPackage:createObject("richman", "RichmanRewardItemComp")

		var_23_1:updateRewardItem(iter_23_1)
		self._buildComp[arg_23_2]:addChild(var_23_1)
		table.insert(var_23_0, var_23_1)
	end

	local var_23_2 = 0

	for iter_23_2, iter_23_3 in ipairs(var_23_0) do
		var_23_2 = var_23_2 < iter_23_3:getWidth() and iter_23_3:getWidth() or var_23_2
	end

	local var_23_3 = self._buildComp[arg_23_2]:getDir() == 1
	local var_23_4 = var_23_3 and 100 or 300

	for iter_23_4, iter_23_5 in ipairs(var_23_0) do
		iter_23_5:setPosition(var_23_2 * (iter_23_4 - 1) + var_23_4, 100)
		iter_23_5:runFGAction(fgui.FSequence:create({
			fgui.FSpawn:create(fgui.FMoveBy:create(2, cc.p(0, -40)), fgui.FFadeOut:create(2)),
			fgui.FRemoveSelf:create()
		}))
	end

	local var_23_5 = var_23_3 and cc.p(-90, -120) or cc.p(132, -158)

	self:dispatchCompEvent("RICH_MAN_SHOW_ICON_EFF", {
		award = arg_23_1[1],
		worldPos = self._buildComp[arg_23_2]:localToGlobal(var_23_5),
		flyNum = arg_23_1.flyNum
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Prizehead)
end

function RichmanMapWorld:playTickEventEffect(arg_24_1)
	local var_24_0 = var_0_3.get(arg_24_1.base_id)

	if var_24_0 and var_24_0.type ~= RichmanConst.EVENT_TYPE.STEAL_OTHER and var_24_0.type ~= RichmanConst.EVENT_TYPE.MONSTER then
		if var_24_0.type == RichmanConst.EVENT_TYPE.DOUBLE_REWARD then
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_DoublePrz)
		end

		if var_24_0.type == RichmanConst.EVENT_TYPE.RANDOM_REWARD and var_24_0.sort ~= 1 then
			self:playRoleSpineEff("eff_ui_richman_rewardUp", "eff_ui_richman_rewardDown", "play" .. 5 - ((var_24_0.sort <= 4 or nil) and (var_24_0.sort or 4)))
		elseif var_24_0.spine ~= "" then
			local var_24_1

			if RichmanConst.TICK_GAME_MAP[arg_24_1.tp] then
				function var_24_1(arg_25_0)
					if arg_25_0.type == "complete" then
						if g.core.guide.GuideProxy:isGuideRunning() then
							return
						end

						if not var_0_1:getServerDataById(var_0_2.SAVE_SERVER_DATA_IDS.RICH_MAN_FIRST_STEAL) and var_0_7:isHasStealEvent() then
							return
						end

						if not var_0_1:getServerDataById(var_0_2.SAVE_SERVER_DATA_IDS.RICH_MAN_FIRST_MONSTER) and #var_0_7:getMonsterEventList() > 0 then
							return
						end

						if not var_0_7:isAuto() then
							g.core.module.ModuleManager:pushPopup(require("app.view.module.richman.view.game.RichmanTickGamePop").new(arg_24_1), {
								touchDisappear = true,
								hideContinue = true
							})
						end
					end
				end

				g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_StartGame)
			end

			self:playRoleSpineEff(var_24_0.spine, nil, nil, var_24_1)
		end
	end
end

function RichmanMapWorld:playRoleSpineEff(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = false

	if arg_26_1 then
		self._entityUpEffHolder:addEffectSpine({
			isLoop = false,
			remove = true,
			name = arg_26_1,
			x = self._entityEffPosDir.x,
			y = self._entityEffPosDir.y,
			anim = arg_26_3 or "play",
			eventHandler = arg_26_4
		})

		var_26_0 = true
	end

	if arg_26_2 then
		local var_26_1 = {
			isLoop = false,
			remove = true,
			name = arg_26_2,
			x = self._entityEffPosDir.x,
			y = self._entityEffPosDir.y,
			anim = arg_26_3 or "play"
		}

		if var_26_0 then
			-- block empty
		end

		var_26_1.finishCall = arg_26_4

		self._entityDownEffHolder:addEffectSpine(var_26_1)
	end
end

function RichmanMapWorld:updateMapState()
	if not var_0_7:getCurRobData() then
		self.m_playerHolder:setVisible(true)
		self.m_pathHolder:setVisible(true)
	else
		self.m_pathHolder:setVisible(false)
		self.m_playerHolder:setVisible(false)
	end

	self:updateBuildReward()
end

function RichmanMapWorld:checkVisibleGrid()
	local var_28_0 = self.m_pathHolder:globalToLocal(cc.p(display.cx, display.cy))
	local var_28_1, var_28_2 = self:pixelToCoordF(var_28_0.x, var_28_0.y)

	for iter_28_0, iter_28_1 in pairs(self._inShowGrid) do
		local var_28_3 = string.split(iter_28_0, "_")
		local var_28_4 = tonumber(var_28_3[1])
		local var_28_5 = tonumber(var_28_3[2])

		if var_28_4 < var_28_1 - self._HALF_WIDTH_SIZE or var_28_4 > var_28_1 + self._HALF_WIDTH_SIZE or var_28_5 < var_28_2 - self._HALF_HEIGHT_SIZE or var_28_5 > var_28_2 + self._HALF_HEIGHT_SIZE then
			self:returnGridIntoPool(var_28_4, var_28_5)
		end
	end

	local var_28_6 = var_0_7:getRichMapTypeMap()

	for iter_28_2 = var_28_1 - self._HALF_WIDTH_SIZE, var_28_1 + self._HALF_WIDTH_SIZE do
		if iter_28_2 >= 0 then
			for iter_28_3 = var_28_2 - self._HALF_HEIGHT_SIZE, var_28_2 + self._HALF_HEIGHT_SIZE do
				if iter_28_3 >= 0 and not self._inShowGrid[iter_28_2 .. "_" .. iter_28_3] and var_28_6[iter_28_2 .. "_" .. iter_28_3] then
					self:addGirdFromPool(iter_28_2, iter_28_3, var_28_6[iter_28_2 .. "_" .. iter_28_3])
				end
			end
		end
	end

	if not self._isCheckInit then
		self._isCheckInit = true

		self:updateGridShow()
	end
end

function RichmanMapWorld:createBuild()
	for iter_29_0, iter_29_1 in ipairs((var_0_7:getBuildPos())) do
		local var_29_0, var_29_1 = self:coordToPixelF(iter_29_1.x, iter_29_1.y)
		local var_29_2 = fgui.UIPackage:createObject("richman", "RichmanBuildComp" .. iter_29_1.dir)

		self.m_buildFloor:addChild(var_29_2)
		var_29_2:setName("build" .. iter_29_1.type)
		var_29_2:setBuildType(iter_29_1.type)
		var_29_2:setPosition(var_29_0, var_29_1)
		var_29_2:setDir(iter_29_1.dir)

		self._buildComp[iter_29_1.type] = var_29_2
	end
end

function RichmanMapWorld:getBuildPosByType(arg_30_1)
	if self._buildComp[arg_30_1] then
		return self:globalToLocal(self._buildComp[arg_30_1]:localToGlobal(cc.p(0, 0)))
	end

	return cc.p(0, 0)
end

function RichmanMapWorld:playRunAnim()
	self._ownEntity:getChild("CommonKnight"):playAction(var_0_5.LOOP_ACTION.RUN)
end

function RichmanMapWorld:playIdleAnim()
	self._ownEntity:getChild("CommonKnight"):playAction(var_0_5.LOOP_ACTION.IDLE)
end

function RichmanMapWorld:updateMapBuild()
	for iter_33_0, iter_33_1 in pairs(self._buildComp) do
		iter_33_1:updateRewardProgress()
	end
end

function RichmanMapWorld:playAllGridLevelUpAnim()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_BuildingUp_3)

	for iter_34_0, iter_34_1 in pairs(self._inShowGrid) do
		local var_34_0 = iter_34_0:split("_")
		local var_34_1, var_34_2 = self:coordToPixelF(tonumber(var_34_0[1]), (tonumber(var_34_0[2])))

		self.m_gridEffHolder:addEffectSpine({
			isLoop = false,
			name = "eff_ui_richman_levelUp",
			remove = true,
			x = var_34_1,
			y = -var_34_2 - self._MAP_TILE_HH
		})
	end

	self:dispatchCompEvent("RICH_MAN_MAP_GRID_ERR_PLAY")
end

function RichmanMapWorld:updateBuildReward()
	for iter_35_0, iter_35_1 in pairs(self._buildComp) do
		iter_35_1:updateRewardProgress()
	end
end

return RichmanMapWorld
