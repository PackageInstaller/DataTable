local FogNightmareKeepsakeBookInfoPop = class("FogNightmareKeepsakeBookInfoPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareKeepsakeBookInfoPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareKeepsakeBookInfoPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = true,
		pkgName = "fogNightmare"
	}, ...)
end)
local var_0_1 = g.core.model.User.fogNightmareData

function FogNightmareKeepsakeBookInfoPop:ctor(arg_2_1)
	self._cfg = arg_2_1.cfg
	self._keepsakeList = {}
	self._selectIndex = 0

	self.m_infoList:setVirtual(self)
	self.m_infoList:doFairyBatching(false)
	self.m_infoList:setItemRenderer(handler(self, self._onInfoListItemRender))
	self.m_infoList:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_infoList:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_infoList:getScrollPane():setMouseWheelEnabled(false)
	self.m_infoList:getScrollPane():cancelDragging()
	self.m_btnLeft:addEventListener(fgui.UIEventType.Click, handler(self, self._onLeft))
	self.m_btnRight:addEventListener(fgui.UIEventType.Click, handler(self, self._onRight))
	self.m_knightList:setVirtual(self)
	self.m_knightList:setItemRenderer(handler(self, self._onKnightListItemRender))
	self:_initView()
	self.m_enterTransition:play()
end

function FogNightmareKeepsakeBookInfoPop:_initView()
	self._keepsakeList = var_0_1:getKeepsakeData():getKeepsakeStructsByTypeAndId(self._cfg.type, self._cfg.seal_id)

	self.m_infoList:setNumItems(#self._keepsakeList + 2)
	self:_updateKnightListView(self._selectIndex)

	if #self._keepsakeList <= 3 then
		-- block empty
	else
		self.m_btnLeft:setVisible(true)
		self.m_btnRight:setVisible(true)
	end
end

function FogNightmareKeepsakeBookInfoPop:_onInfoListItemRender(arg_4_1, arg_4_2)
	if self._keepsakeList[arg_4_1] then
		arg_4_2:setVisible(true)
		arg_4_2:updateViewByStruct(self._keepsakeList[arg_4_1])
	else
		arg_4_2:setVisible(false)
	end
end

function FogNightmareKeepsakeBookInfoPop:_onKnightListItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateIcon({
		type = g.core.common.Goods.TYPE_KNIGHT,
		value = self._curKnights[arg_5_1 + 1]
	})
end

function FogNightmareKeepsakeBookInfoPop:_checkKnightIsPut(arg_6_1)
	return g.core.config.knight_info.get(arg_6_1).put ~= 0
end

function FogNightmareKeepsakeBookInfoPop:_updateKnightListView(arg_7_1)
	if self._keepsakeList[arg_7_1 + 1] then
		local var_7_0 = {}
		local var_7_1 = self._keepsakeList[arg_7_1 + 1]:getBaseInfo()

		self._curKnights = {}

		while g.core.config.fog_seal_info.hasKey("knight_" .. 1) do
			if var_7_1["knight_" .. 1] > 0 and self:_checkKnightIsPut(var_7_1["knight_" .. 1]) then
				table.insert(self._curKnights, var_7_1["knight_" .. 1])

				var_7_0[var_7_1["knight_" .. 1]] = true
			end
		end

		local var_7_3 = 1

		while g.core.config.fog_seal_info.hasKey("profession_" .. var_7_3) do
			if var_7_1["profession_" .. var_7_3] > 0 then
				for iter_7_0, iter_7_1 in ipairs((g.core.model.User.knightsData:getProfessionList(var_7_1["profession_" .. var_7_3]))) do
					if not var_7_0[iter_7_1] and self:_checkKnightIsPut(iter_7_1) then
						table.insert(self._curKnights, iter_7_1)

						var_7_0[iter_7_1] = true
					end
				end
			end

			var_7_3 = var_7_3 + 1
		end

		table.sort(self._curKnights, function(arg_8_0, arg_8_1)
			return g.core.model.User.knightsData:getKnight({
				advance_id = arg_8_0
			}):getQuality() > g.core.model.User.knightsData:getKnight({
				advance_id = arg_8_1
			}):getQuality()
		end)
		self.m_knightList:setNumItems(#self._curKnights)
	else
		self.m_knightList:setNumItems(0)
	end

	self.m_infoList:scrollToView(0)
	self:_updateListSelectedStatus()
end

function FogNightmareKeepsakeBookInfoPop:_onLeft()
	self._scrollLock = true
	self._selectIndex = self._selectIndex - 1
	self._selectIndex = math.max(self._selectIndex, 0)

	self.m_infoList:scrollToView(self._selectIndex, true)
	self:_updateListSelectedStatus()
end

function FogNightmareKeepsakeBookInfoPop:_onRight()
	self._scrollLock = true
	self._selectIndex = self._selectIndex + 1
	self._selectIndex = math.min(self._selectIndex, #self._keepsakeList - 1)

	self.m_infoList:scrollToView(self._selectIndex, true)
	self:_updateListSelectedStatus()
end

function FogNightmareKeepsakeBookInfoPop:_onTouchBegin(arg_11_1)
	self._touchPos = arg_11_1:getInput():getTouch():getLocation()
end

function FogNightmareKeepsakeBookInfoPop:_onTouchEnd(arg_12_1)
	local var_12_0 = arg_12_1:getInput():getTouch():getLocation()

	if self._touchPos then
		if var_12_0.x - self._touchPos.x < -40 then
			self:_onRight()
		elseif var_12_0.x - self._touchPos.x > 40 then
			self:_onLeft()
		end
	end
end

function FogNightmareKeepsakeBookInfoPop:_onMouseWheel(arg_13_1)
	self:_updateListSelectedStatus()
end

function FogNightmareKeepsakeBookInfoPop:_updateListSelectedStatus()
	self._scrollLock = false

	for iter_14_0, iter_14_1 in ipairs((self.m_infoList:getChildren())) do
		iter_14_1:getController("isSelect"):setSelectedIndex(2)
	end

	local var_14_0 = self.m_infoList:numChildren()
	local var_14_1 = math.clamp(self.m_infoList:itemIndexToChildIndex(self._selectIndex + 1), 0, var_14_0 - 1)

	self.m_infoList:getChildAt(var_14_1):getController("isSelect"):setSelectedIndex(0)

	for iter_14_2 = 0, var_14_0 - 1 do
		local var_14_2 = self.m_infoList:getChildAt(iter_14_2)

		if iter_14_2 < var_14_1 then
			var_14_2:setScale(math.max(1 - (var_14_1 - iter_14_2) * 0.1, 0.8))
		else
			var_14_2:setScale(math.max(1 - (iter_14_2 - var_14_1) * 0.1, 0.8))
		end
	end
end

return FogNightmareKeepsakeBookInfoPop
