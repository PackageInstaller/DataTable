local var_0_1 = g.core.model.User.gveDataMgr
local var_0_2 = g.core.model.User.gveDataMgr:getGveData()
local var_0_3 = 1240
local var_0_4 = 620
local var_0_5 = 290
local GveMiniMapLayer = class("GveMiniMapLayer", require("app.fairyGUI.gve.UI_GveMiniMapLayer"), function()
	return fgui.GComponent:create({
		resName = "GveMiniMapLayer",
		pkgPath = "ui/gve/gve",
		isFullScreen = true,
		pkgName = "gve"
	}, ...)
end)

function GveMiniMapLayer:ctor(arg_2_1)
	var_0_2 = var_0_1:getGveData()

	self.m_mapLoader:setURL("bg/gve/bg_pshc_ditu.jpg")
	self.m_gotoBtn:addClickListener(handler(self, self._onMiniMapGotoClick))
	self.m_showDetailBtn:addClickListener(handler(self, self._onShowDetailBtnClick))

	self._centerPos = self.m_centerComp:getPosition()

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_allBossList:setVirtual()
	self.m_allBossList:setItemRenderer(handler(self, self._onAllBossRenderer))

	self._center = arg_2_1 and arg_2_1.center

	self.m_topBarComp:hidePushGift()

	self._allNeedAddPlayer = {}
	self._allPlayerColorNode = {}
	self._allBossMap = {}
	self._allMergeBoss = {}
	self._P_HEIGHT = var_0_4 / var_0_5
	self._P_WIDTH = var_0_3 / var_0_5
	self._startPos = {
		x = self._centerPos.x,
		y = self._centerPos.y - self._P_HEIGHT * var_0_5 / 2
	}

	if self._center then
		self.m_selMapImg:setVisible(true)

		local var_2_0, var_2_1 = self:convertPointToMyPos(self._center.x, self._center.y)

		self.m_selMapImg:setPosition(var_2_0, display.height - var_2_1)
	end

	self.m_showDetailBtn:setSelected(true)
end

function GveMiniMapLayer:onLoad()
	self:updatePlayerColor()
	self:updateBoss()
	self:capturePlayer()
	self:updateSortIndex()
	self.m_enterTransition:play()
	self.m_effComp:addEffectSpine({
		anim = "play",
		name = "eff_ui_gve_miniMap",
		remove = true,
		isLoop = false
	})
	self.m_effComp:addEffectSpine({
		anim = "play",
		name = "eff_ui_gve_mapLine",
		remove = true,
		isLoop = false
	})

	local var_3_0, var_3_1 = g.core.model.User.gveDataMgr:getGveData():getIsHasFogCloud()

	if var_3_0 then
		self.m_hasFogController:setSelectedIndex(0)
	else
		self.m_hasFogController:setSelectedIndex(1)
	end

	self:_onShowDetailBtnClick()
end

function GveMiniMapLayer:updateSortIndex()
	self:getView():setChildIndex(self.m_selMapImg, #self:getView():getChildren() - 1)
end

function GveMiniMapLayer:updateBoss()
	self._allMergeBoss = {}

	local var_5_0 = {}
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs((var_0_2:getAllBossMap())) do
		local var_5_2 = string.split(iter_5_0, "_")
		local var_5_3 = tonumber(var_5_2[1])
		local var_5_4 = tonumber(var_5_2[2])
		local var_5_5 = var_0_2:getPosNowBossCfg(var_5_3, var_5_4)

		if not var_0_2:isCurPosInFogCloud({
			x = var_5_3,
			y = var_5_4
		}) and var_5_5 then
			if var_5_5.boss_type == 1 then
				local var_5_6 = fgui.UIPackage:createObject("gve", "GveMiniMapBossComp")

				self.m_colorComp:addChild(var_5_6)
				var_5_6:updateIcon(g.core.common.Path:getKnightIconById(var_5_5.image))

				if not var_5_0[var_5_5.image] then
					var_5_0[var_5_5.image] = true

					table.insert(self._allMergeBoss, var_5_5)
				end

				var_5_6:setPosition(self:convertPointToMyPosNew(var_5_3, var_5_4))
				table.insert(self._allBossMap, var_5_6)
			else
				if not var_5_1[var_5_5.image] then
					var_5_1[var_5_5.image] = true

					table.insert(self._allMergeBoss, var_5_5)
				end

				local var_5_7 = fgui.UIPackage:createObject("gve", "GveMiniMapRandBoss")

				self.m_colorComp:addChild(var_5_7)
				var_5_7:setPosition(self:convertPointToMyPosNew(var_5_3, var_5_4))
				table.insert(self._allBossMap, var_5_7)
			end
		end
	end

	table.sort(self._allMergeBoss, function(arg_6_0, arg_6_1)
		if arg_6_0.id ~= arg_6_1.id then
			return arg_6_0.id < arg_6_1.id
		end

		return false
	end)
	self.m_allBossList:setNumItems(#self._allMergeBoss)
end

function GveMiniMapLayer:_onMiniMapGotoClick()
	if self._curSelPos then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
			isSpine = true,
			forceCallFunc = true,
			callback = function()
				var_0_2:setJumpPos(self._curSelPos)
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(309129))
	end
end

function GveMiniMapLayer:_onShowDetailBtnClick()
	self:showMiniMapDetail((self.m_showDetailBtn:isSelected()))
end

function GveMiniMapLayer:convertPointToMyPos(arg_10_1, arg_10_2)
	local var_10_0 = self:coordToPixel(arg_10_1, arg_10_2)

	return self._startPos.x + var_10_0.x, display.height - (self._startPos.y - var_10_0.y)
end

function GveMiniMapLayer:convertPointToMyPosNew(arg_11_1, arg_11_2)
	local var_11_0, var_11_1 = self:convertPointToMyPos(arg_11_1, arg_11_2)

	return var_11_0, display.height - var_11_1
end

function GveMiniMapLayer:updatePlayerColor()
	self:createNormalTexture()

	for iter_12_0, iter_12_1 in pairs((var_0_2:getAllOccupiedPoint())) do
		local var_12_0 = string.split(iter_12_0, "_")

		self:addPlayerComp({
			x = tonumber(var_12_0[1]),
			y = tonumber(var_12_0[2])
		})
	end
end

function GveMiniMapLayer:tickAddPlayer()
	for iter_13_0 = 1, 20 do
		if not self._allNeedAddPlayer[1] then
			self:cancelSchedule(self._addPlayerScheduler)

			self._addPlayerScheduler = nil

			self:capturePlayer()

			return
		end

		self:addPlayerComp((table.remove(self._allNeedAddPlayer, 1)))
	end
end

function GveMiniMapLayer:addPlayerComp(arg_14_1)
	local var_14_0 = cc.Texture2D:new()

	if var_0_2:getMinePointData(arg_14_1.x, arg_14_1.y) then
		var_14_0:initWithImage(self._mineTextureCache)
	else
		var_14_0:initWithImage(self._otherTextureCache)
	end

	local var_14_1 = cc.Sprite:createWithTexture(var_14_0)

	self.m_colorComp:addNode(var_14_1, -1)
	table.insert(self._allPlayerColorNode, var_14_1)
	var_14_1:setPosition(self:convertPointToMyPos(arg_14_1.x, arg_14_1.y))
end

function GveMiniMapLayer:createNormalTexture()
	if not self._mineTextureCache or not self._otherTextureCache then
		local var_15_0 = fgui.UIPackage:createObject("gve", "GveMiniMapColor", self)

		self:addChild(var_15_0)

		if not self._mineTextureCache then
			var_15_0:setCtrlState("ctrl", {
				index = 0
			})

			self._mineTextureCache = cc.utils:captureNode(var_15_0)

			self._mineTextureCache:retain()
		end

		if not self._otherTextureCache then
			var_15_0:setCtrlState("ctrl", {
				index = 1
			})

			self._otherTextureCache = cc.utils:captureNode(var_15_0)

			self._otherTextureCache:retain()
		end

		var_15_0:removeSelf()
	end
end

function GveMiniMapLayer:capturePlayer()
	self.m_colorComp:setSize(display.width, display.height)

	local var_16_0 = cc.utils:captureNode(self.m_colorComp)
	local var_16_1 = cc.Texture2D:new()

	var_16_1:initWithImage(var_16_0)
	var_16_0:release()

	local var_16_2 = cc.Sprite:createWithTexture(var_16_1)

	self.m_colorComp:addNode(var_16_2)

	for iter_16_0, iter_16_1 in ipairs(self._allPlayerColorNode) do
		iter_16_1:removeSelf()
	end

	for iter_16_2, iter_16_3 in ipairs(self._allBossMap) do
		iter_16_3:removeSelf()
	end

	var_16_2:setPosition(display.width, 0)

	self._allPlayerColorNode = {}
	self._allBossMap = {}
end

function GveMiniMapLayer:getMapPosByPosition(arg_17_1)
	return math.round(((arg_17_1.x - self._startPos.x) / (self._P_WIDTH / 2) + (arg_17_1.y - self._startPos.y) / (self._P_HEIGHT / 2)) / 2), math.round(((arg_17_1.y - self._startPos.y) / (self._P_HEIGHT / 2) - (arg_17_1.x - self._startPos.x) / (self._P_WIDTH / 2)) / 2)
end

function GveMiniMapLayer:coordToPixel(arg_18_1, arg_18_2)
	return {
		x = (arg_18_1 - arg_18_2) * (self._P_WIDTH / 2),
		y = -(arg_18_1 + arg_18_2) * (self._P_HEIGHT / 2)
	}
end

function GveMiniMapLayer:_onTouchBegin(arg_19_1)
	arg_19_1:captureTouch()
	self:onTouchPosChange(arg_19_1)
end

function GveMiniMapLayer:_onTouchMove(arg_20_1)
	self:onTouchPosChange(arg_20_1)
end

function GveMiniMapLayer:_onTouchEnd(arg_21_1)
	return
end

function GveMiniMapLayer:onTouchPosChange(arg_22_1)
	self.m_selMapImg:setVisible(true)

	local var_22_0 = arg_22_1:getInput():getPosition()
	local var_22_1, var_22_2 = self:getMapPosByPosition(var_22_0)

	if var_22_1 < 0 or var_22_1 > 290 or var_22_2 < 0 or var_22_2 > 290 then
		-- block empty
	else
		self.m_selMapImg:setPosition(var_22_0)

		self._curSelPos = {
			x = var_22_1,
			y = var_22_2
		}
	end
end

function GveMiniMapLayer:showMiniMapDetail(arg_23_1)
	self.m_showRangeController:setSelectedIndex(arg_23_1 and 1 or 0)
	var_0_2:saveShowMiniMapDetail(arg_23_1)

	if self.m_hasFogController:getSelectedIndex() == 0 then
		self.m_display1Transition:play()
	else
		self.m_display3Transition:play()
	end
end

function GveMiniMapLayer:_onAllBossRenderer(arg_24_1, arg_24_2)
	arg_24_2:updateCellInfo(self._allMergeBoss[arg_24_1 + 1])
end

function GveMiniMapLayer:onUnload()
	if self._addPlayerScheduler then
		self:cancelSchedule(self._addPlayerScheduler)

		self._addPlayerScheduler = nil
	end

	if self._otherTextureCache then
		self._otherTextureCache:release()

		self._otherTextureCache = nil
	end

	if self._mineTextureCache then
		self._mineTextureCache:release()

		self._mineTextureCache = nil
	end
end

return GveMiniMapLayer
