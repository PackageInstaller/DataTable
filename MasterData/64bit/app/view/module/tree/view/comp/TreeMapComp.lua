local var_0_0 = g.core.const.ConstMgr.TreeConst
local TreeMapComp = class("TreeMapComp", require("app.fairyGUI.tree.UI_TreeMapComp"))
local var_0_2 = g.core.const.ConstMgr.TreeConst.MAP.GRID_X
local var_0_3 = g.core.const.ConstMgr.TreeConst.MAP.GRID_Y
local var_0_4 = g.core.const.ConstMgr.TreeConst.MAP.GRID_WIDTH
local var_0_5 = g.core.const.ConstMgr.TreeConst.MAP.GRID_HEIGHT

function TreeMapComp:ctor()
	self._scrollComp = self:getScrollPane()
	self._lastPosX = self._scrollComp:getPosX()
	self._curShowBgDict = {}
	self._lastPosY = self._scrollComp:getPosY()
	self._viewCount = 1
	self._xShowBgCount = math.ceil(display.width / var_0_4)
	self._yShowBgCount = math.ceil(display.height / var_0_5)
	self._allGridDict = {}
	self._loadingTextureDict = {}
	self._allLoadTextureDict = {}

	self:initView()
end

function TreeMapComp:initView()
	self:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onScrollPanel))
	self.m_maxNode:setPosition(var_0_2 * var_0_4, var_0_3 * var_0_5)

	for iter_2_0 = 1, var_0_2 do
		for iter_2_1 = 1, var_0_3 do
			self._allGridDict[self:_getKey(iter_2_0, iter_2_1)] = {
				x = iter_2_0,
				y = iter_2_1,
				bgPosX = (iter_2_0 - 1) * var_0_4,
				bgPosY = (iter_2_1 - 1) * var_0_5
			}
		end
	end

	self.m_nodeComp:setSortingOrder(var_0_2 * var_0_4 * (var_0_3 * var_0_5) + 1)
end

function TreeMapComp:_getKey(arg_3_1, arg_3_2)
	if (arg_3_2 - 1) * var_0_2 + arg_3_1 < 10 then
		return "0" .. tostring((arg_3_2 - 1) * var_0_2 + arg_3_1)
	else
		return tostring((arg_3_2 - 1) * var_0_2 + arg_3_1)
	end
end

function TreeMapComp:_onScrollPanel(arg_4_1, arg_4_2)
	local var_4_0 = self._scrollComp:getPosX()

	if not arg_4_2 then
		-- block empty
	end

	local var_4_1 = self._scrollComp:getPosY()

	if math.abs(self._lastPosX - var_4_0) >= var_0_4 * math.ceil(self._viewCount / 2) then
		self._lastPosX = var_4_0

		self:_refreshBg()
	elseif math.abs(self._lastPosY - var_4_1) >= var_0_5 * math.ceil(self._viewCount / 2) then
		self._lastPosY = var_4_1

		self:_refreshBg()
	end
end

function TreeMapComp:jumpToPos(arg_5_1)
	self._scrollComp:scrollToView(cc.rect(arg_5_1.x - display.cx, arg_5_1.y - display.cy, 0, 0), true, true)
end

function TreeMapComp:getNodePos(arg_6_1)
	return self.m_nodeComp:getNodePos(arg_6_1)
end

function TreeMapComp:setSelectNode(arg_7_1, arg_7_2)
	if not arg_7_1 then
		return
	end

	self.m_nodeComp:setSelectNode(arg_7_1, arg_7_2)
end

function TreeMapComp:_refreshBg()
	local var_8_0 = math.floor(self._scrollComp:getPosX() / var_0_4) - self._viewCount
	local var_8_1 = math.floor(self._scrollComp:getPosY() / var_0_5) - self._viewCount

	for iter_8_0 = 1, self._xShowBgCount + self._viewCount * 2 do
		if var_8_0 + iter_8_0 > 0 and var_8_0 + iter_8_0 <= var_0_2 then
			for iter_8_1 = 1, self._yShowBgCount + self._viewCount * 2 do
				if var_8_1 + iter_8_1 > 0 and var_8_1 + iter_8_1 <= var_0_3 then
					local var_8_2 = self:_getKey(var_8_0 + iter_8_0, var_8_1 + iter_8_1)

					if self._curShowBgDict[var_8_2] or self._loadingTextureDict[var_8_2] then
						-- block empty
					else
						local var_8_3 = table.concat({
							"bg/tree/mapGrid/bg_",
							var_8_2,
							".jpg"
						})

						self._loadingTextureDict[var_8_2] = true

						local var_8_4 = self

						display.loadImage(var_8_3, function(arg_9_0)
							if tolua.isnull(var_8_4) or not var_8_4.loadTextureFinish then
								g.core.common.Scheduler:newScheduleOnce(function()
									display.removeImage(var_8_3)
								end, 0.1)
							else
								var_8_4:loadTextureFinish(var_8_3, var_8_2, arg_9_0)
							end
						end)
					end
				end
			end
		end
	end
end

function TreeMapComp:loadTextureFinish(arg_11_1, arg_11_2, arg_11_3)
	self._loadingTextureDict[arg_11_2] = nil

	if self._isRemoved then
		g.core.common.Scheduler:newScheduleOnce(function()
			display.removeImage(arg_11_1)
		end, 0.1)
	else
		self._allLoadTextureDict[arg_11_2] = arg_11_1

		self:_createGridBg(arg_11_2, arg_11_1)
	end
end

function TreeMapComp:_createGridBg(arg_13_1, arg_13_2)
	local var_13_0 = fgui.GLoader:create()

	var_13_0:setLoadAsync(true)
	var_13_0:setURL(arg_13_2)
	var_13_0:setAutoRelease(true)
	self:addChild(var_13_0)
	var_13_0:setPosition(self._allGridDict[arg_13_1].bgPosX, self._allGridDict[arg_13_1].bgPosY)
	var_13_0:getContentSprite():setContentSize(var_0_4, var_0_5)

	self._curShowBgDict[arg_13_1] = var_13_0
end

function TreeMapComp:onLoad()
	if not self._init then
		self._init = true

		self:jumpToCenter()
	end

	if var_0_0.MAP.GRID_X / 2 > self._viewCount then
		self:newScheduleInterval(handler(self, self.updateBgView), 1, var_0_0.MAP.GRID_X / 2 * 1)
	end

	self.m_enterTransition:play()
end

function TreeMapComp:jumpToCenter()
	self:jumpToPos(cc.p(var_0_4 * var_0_2 / 2, var_0_5 * var_0_3 / 2))
end

function TreeMapComp:updateBgView()
	self._viewCount = self._viewCount + 1

	self:_refreshBg()
end

function TreeMapComp:updateView()
	self.m_nodeComp:updateAllNode()
end

function TreeMapComp:updateStageUpNode(arg_18_1)
	self.m_nodeComp:updateStageUpNode(arg_18_1)
end

function TreeMapComp:updateLevelUpNode(arg_19_1)
	self.m_nodeComp:updateLevelUpNode(arg_19_1)
end

function TreeMapComp:updateBigNodeUpCenterNode(arg_20_1, arg_20_2)
	self.m_nodeComp:updateBigNodeUpCenterNode(arg_20_1, arg_20_2)
end

function TreeMapComp:onRemoved()
	self._isRemoved = true

	for iter_21_0, iter_21_1 in pairs(self._allLoadTextureDict) do
		display.removeImage(iter_21_1)
	end

	self._allLoadTextureDict = {}
end

return TreeMapComp
