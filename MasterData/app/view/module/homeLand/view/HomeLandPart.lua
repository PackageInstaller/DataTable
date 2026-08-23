local var_0_0 = g.core.const.ConstMgr.HomeConst
local HLBuildNameComp = import(".HLBuildNameComp")
local var_0_2 = g.core.common.ModuleUnlock
local var_0_3 = g.core.const.ConstMgr.FUNCTION_TYPE
local HomeLandPart = class("HomeLandPart", require("app.fairyGUI.homeLand.UI_HomeLandPart"))
local KsMath = require("app.core.utils.KsMath")

function HomeLandPart:ctor()
	self._ownerStage = nil
	self._buildIdArr = nil
	self._buildInfoDict = nil
	self._landSpine = nil
	self._landDuration = 0
	self._landScale = 0.6

	self:_initDefaultData()
	self:_initLoadLand()
	self:_initRegisterUI()

	self._nameCompList = {}

	self.m_leftBtn:addClickListener(handler(self, self._onLeftBtnClick))
	self.m_rightBtn:addClickListener(handler(self, self._onRightBtnClick))
	self.m_leftBtn:setVisible(false)
	self.m_rightBtn:setVisible(false)
	self.m_leftBtn:setRedPointStyle(0)
	self.m_rightBtn:setRedPointStyle(0)

	self.m_leftBtnCtrl = self.m_leftBtn:getController("direction")
	self.m_rightBtnCtrl = self.m_rightBtn:getController("direction")
	self._offMoveX = 50
end

function HomeLandPart:onLoad()
	self:_initLandName()
	self:_updateRed()
end

function HomeLandPart:onUnload()
	self._ownerStage = nil
end

function HomeLandPart:startUp(arg_4_1)
	self._ownerStage = arg_4_1
end

function HomeLandPart:setCurLandPercent(arg_5_1)
	self._offMoveX = arg_5_1

	self._landSpine:play(self._landDuration * arg_5_1 / 100, self._landDuration * arg_5_1 / 100)
	self:_updateRed()
	self:dispatchCompEvent("Home_land_percent_change", {
		percent = arg_5_1
	})
end

function HomeLandPart:_updateRed()
	local var_6_0
	local var_6_1

	for iter_6_0, iter_6_1 in pairs(self._nameCompList or {}) do
		if iter_6_1:getFuncId() == 25003 then
			var_6_0 = iter_6_1
		elseif iter_6_1:getFuncId() == 25004 then
			var_6_1 = iter_6_1
		end
	end

	if var_6_0 == nil or var_6_1 == nil then
		return
	end

	local var_6_2 = 1334
	local var_6_3 = 26
	local var_6_4 = var_6_0:getRedPointStyle()
	local var_6_5 = var_6_3 - (display.width - 1334) / 10 > self._offMoveX and var_6_4 > 0

	self.m_leftBtn:setVisible(var_6_3 - (display.width - 1334) / 10 > self._offMoveX and var_6_4 > 0)

	if var_6_5 then
		if var_6_4 == 1 then
			self.m_leftBtnCtrl:setSelectedIndex(0)
		elseif var_6_4 == 2 then
			self.m_leftBtnCtrl:setSelectedIndex(1)
		end

		self.m_leftBtn:setRedPointStyle(var_6_4)
	end

	local var_6_6 = 37
	local var_6_7 = var_6_1:getRedPointStyle()
	local var_6_8 = var_6_6 + (display.width - var_6_2) / 6 < self._offMoveX and var_6_7 > 0

	self.m_rightBtn:setVisible(var_6_6 + (display.width - var_6_2) / 6 < self._offMoveX and var_6_7 > 0)

	if var_6_8 then
		if var_6_7 == 1 then
			self.m_rightBtnCtrl:setSelectedIndex(2)
		elseif var_6_7 == 2 then
			self.m_rightBtnCtrl:setSelectedIndex(3)
		end

		self.m_rightBtn:setRedPointStyle(var_6_7)
	end
end

function HomeLandPart:checkClickHit(arg_7_1)
	local var_7_0 = self._landSpine:convertToNodeSpace(arg_7_1)
	local var_7_1 = self._landSpine:getBaseSpine()

	for iter_7_0, iter_7_1 in ipairs(self._buildIdArr) do
		if var_7_1:checkHitSlotBound(iter_7_1 .. "_box", var_7_0.x, var_7_0.y) then
			if var_0_2:isModuleUnlock(iter_7_1, nil, true) then
				self:_onOpenBuildClick(self._buildInfoDict[iter_7_1])
			else
				g.core.module.ModuleManager:tip(g.core.config.function_info.get(iter_7_1).lock_direction)
			end

			return
		end
	end
end

function HomeLandPart:_initDefaultData()
	self._buildIdArr = {}
	self._buildInfoDict = {}
	self._buildingRedPointId = {}

	local var_8_0 = {
		[1] = 161,
		[4] = 147
	}

	for iter_8_0 = 1, g.core.config.homeland_building_info.getLength() do
		local var_8_1 = g.core.config.homeland_building_info.indexOf(iter_8_0)

		if var_8_0[iter_8_0] then
			self._buildingRedPointId[var_8_1.function_id] = {
				id = var_8_0[iter_8_0]
			}
		end

		table.insert(self._buildIdArr, var_8_1.function_id)

		self._buildInfoDict[var_8_1.function_id] = var_8_1
	end
end

function HomeLandPart:_initRegisterUI()
	return
end

function HomeLandPart:_initLoadLand()
	self._landSpine = require("app.view.common.SpineBase").new({
		anim = "horizontal",
		resId = "homeland",
		isLoop = false,
		path = g.core.common.Path:getEffSpine("homeland")
	})

	self._landSpine:setPosition(display.width / 2, display.height / 2 + 40)
	self._landSpine:setScale(self._landScale)
	self:addNode(self._landSpine, -1)

	self._landDuration = self._landSpine:getAnimationDuration()

	self:setCurLandPercent(50)
	self:_refreshBuildOpen()
end

function HomeLandPart:_initLandName()
	for iter_11_0, iter_11_1 in pairs(self._buildInfoDict) do
		local var_11_0 = self._landSpine:getNodeForSlot(iter_11_0 .. "_title")

		if self._nameCompList[iter_11_0] then
			self._nameCompList[iter_11_0]:refreshRed()
		else
			local var_11_1 = HLBuildNameComp.new(iter_11_1)

			self:addAutoRetain(var_11_1)

			if var_0_0.LAND_PART_POS_OFF[iter_11_0] then
				var_11_1:setPosition(var_0_0.LAND_PART_POS_OFF[iter_11_0])
			else
				var_11_1:setPosition(var_0_0.LAND_PART_POS_OFF[0])
			end

			var_11_1:setScale(1 / self._landScale)
			var_11_0:addChild((var_11_1:displayObject()))

			self._nameCompList[iter_11_0] = var_11_1
		end
	end
end

function HomeLandPart:_refreshBuildOpen()
	local var_12_0 = self._landSpine:getBaseSpine()

	for iter_12_0, iter_12_1 in ipairs(self._buildIdArr) do
		if var_0_2:isModuleUnlock(iter_12_1, nil, true) then
			var_12_0:setSlotColor(iter_12_1, 1, 1, 1, 1)
		else
			var_12_0:setSlotColor(iter_12_1, 0.5, 0.5, 0.5, 1)
		end
	end
end

function HomeLandPart:_stopMoveland()
	if self._scheduleHandler then
		self:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end
end

function HomeLandPart:_moveLand(arg_14_1)
	self._direction = arg_14_1

	self:_stopMoveland()

	self._scheduleHandler = self:newSchedule(handler(self, self._updateLandPos), 0.01)
end

function HomeLandPart:_updateLandPos()
	self._offMoveX = self._direction == 1 and KsMath.rangeIn(self._offMoveX + 8, 0, 100) or KsMath.rangeIn(self._offMoveX - 8, 0, 100)

	self:setCurLandPercent(self._offMoveX)

	if self._offMoveX <= 0 or self._offMoveX >= 100 then
		self:_stopMoveland()
	end
end

function HomeLandPart:_onLeftBtnClick()
	self:_moveLand(1)
end

function HomeLandPart:_onRightBtnClick()
	self:_moveLand(2)
end

function HomeLandPart:_onOpenBuildClick(arg_18_1)
	if arg_18_1.function_id == var_0_3.HOME_LAND_TRAIN then
		self:_onOpenTrainClick()
	elseif arg_18_1.function_id == var_0_3.HOME_LAND_FAVO_MAIN then
		self:_onOpenFavoriteClick()
	elseif arg_18_1.function_id == var_0_3.HOME_LAND_SHOWROOM then
		self:_onOpenTissueClick()
	elseif arg_18_1.function_id == var_0_3.HOME_LAND_TMP2 then
		self:_onOpenHonorRoomClick()
	elseif arg_18_1.function_id == var_0_3.HOME_LAND_FURNITURE then
		self:_onOpenFurnitureClick()
	elseif arg_18_1.function_id == var_0_3.GENE then
		self:_onOpenGeneClick()
	elseif arg_18_1.function_id == var_0_3.OUTPOST then
		self:_onOpenOutpostClick()
	end
end

function HomeLandPart:_onOpenTrainClick()
	g.core.network.GameNetProxy:send_C2S_HomeLandTrain_GetInfo({})
end

function HomeLandPart:_onOpenFavoriteClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_3.HOME_LAND_FAVO_MAIN) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.KNIGHT_FAVO_MAIN)
	end
end

function HomeLandPart:_onOpenTissueClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_3.HOME_LAND_SHOWROOM) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.SHOW_ROOM)
	end
end

function HomeLandPart:_onOpenHonorRoomClick()
	if g.core.common.ModuleUnlock:isModuleUnlock(var_0_3.KINGDOM_FATE) and g.view.entrance.WARRIOR then
		g.core.module.ModuleManager:pushModule(g.view.entrance.WARRIOR)
	else
		g.core.module.ModuleManager:tip(g.core.config.function_info.get(var_0_3.HOME_LAND_TMP2).lock_direction)
	end
end

function HomeLandPart:_onOpenFurnitureClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_3.HOME_LAND_FURNITURE) then
		g.core.network.GameNetProxy:send_C2S_FurnitureRoom_GetInfo({})
	end
end

function HomeLandPart:_onOpenGeneClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_3.GENE) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.GENE)
	end
end

function HomeLandPart:_onOpenOutpostClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_3.OUTPOST) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_STAGE)
	end
end

function HomeLandPart:scrollToLeft()
	self._offMoveX = 100

	self:_updateLandPos()
end

return HomeLandPart
