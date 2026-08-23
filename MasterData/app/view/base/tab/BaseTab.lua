local BaseTab = class("BaseTab")

function BaseTab:ctor()
	self._curIndex = 1
	self._tabDatas = {}
	self._listener = nil
	self._refreshRedPoint = false
	self._refreshFuncUnlock = false
	self._clearRedCon = false
	self._canDrag = false
	self._offestX = nil
	self._data = nil
	self._redCustomData = nil
	self._isFirst = true

	self:_initTabList()
end

function BaseTab:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_REQUEST_RESPONSE, handler(self, self._onRequestResponse), self)
end

function BaseTab:updateTab(arg_3_1)
	if arg_3_1 then
		self._tabDatas = arg_3_1.tabs or {}
	end

	self._data = arg_3_1.data or self._data
	self._redCustomData = arg_3_1.customData or self._redCustomData
	self._effect = arg_3_1.effect or self._effect

	if arg_3_1 then
		self._curIndex = arg_3_1.initIndex or self._curIndex
	end

	if arg_3_1 then
		self._listener = arg_3_1.listener or nil
	end

	self:refreshTab()

	if self._isFirst then
		self:addSelection(self._curIndex - 1, true)

		self._isFirst = false
	end

	if self._listener then
		arg_3_1.listener(self._curIndex, self)
	end

	local var_3_0 = self:getNumItems()

	if var_3_0 > 0 then
		if self:getLayout() == 0 then
			self._canDrag = self:getFitSize(var_3_0) > self:getViewHeight()

			self:setScrollEnabled(self:getFitSize(var_3_0) > self:getViewHeight())
		else
			self._canDrag = self:getFitSize(var_3_0) > self:getViewWidth()

			self:setScrollEnabled(self:getFitSize(var_3_0) > self:getViewWidth())
		end
	else
		self:setScrollEnabled(false)
	end
end

function BaseTab:refreshTab()
	self:setNumItems(#self._tabDatas > 0 and #self._tabDatas or self:getNumItems())
end

function BaseTab:getCurTabIndex()
	return self._curIndex
end

function BaseTab:setCurTabIndex(arg_6_1)
	self._curIndex = arg_6_1
end

function BaseTab:_initTabList()
	self:setItemIniter(function(arg_8_0, arg_8_1)
		fgui.UIPackage.iterObject(arg_8_1, self)

		local var_8_0 = arg_8_1:getRemark()

		if var_8_0 then
			fgui.UIPackage.bindUIComponent(arg_8_1, var_8_0, self)
		end
	end)
	self:setItemRenderer(handler(self, self._onTabRenderer))
	self:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabClick))
end

function BaseTab:_onTabRenderer(arg_9_1, arg_9_2)
	if not next(self._tabDatas) then
		return
	end

	local var_9_0 = self._tabDatas[arg_9_1 + 1]

	if self._tabDatas[arg_9_1 + 1].title then
		arg_9_2:setTitle(var_9_0.title)
	end

	if var_9_0.normalIcon and var_9_0.normalIcon ~= "" then
		arg_9_2:setIcon(var_9_0.normalIcon)
	end

	if var_9_0.selectIcon and var_9_0.selectIcon ~= "" then
		arg_9_2:setSelectedIcon(var_9_0.selectIcon)
	end

	if var_9_0.newRedPointId then
		local var_9_1 = arg_9_2:getChild("redPointComp")

		if var_9_1 then
			var_9_1:setId(var_9_0.newRedPointId)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = var_9_1,
				customData = self._redCustomData
			})
		end
	end

	if var_9_0.cond then
		local var_9_2, var_9_3 = var_9_0:cond(self._data)

		arg_9_2:getController("isLock"):setSelectedIndex(var_9_3 and 0 or 1)
	end
end

function BaseTab:_onTabClick(arg_10_1)
	local var_10_0 = arg_10_1:getDataValue()

	if self._curIndex == var_10_0 + 1 then
		return
	end

	local var_10_1 = self._tabDatas[var_10_0 + 1]
	local var_10_2 = true
	local var_10_3 = ""

	if self._tabDatas[var_10_0 + 1] and var_10_1.cond then
		var_10_3, var_10_2 = var_10_1:cond(self._data)
	end

	if var_10_2 and self._listener then
		self._listener(var_10_0 + 1, self)

		self._curIndex = var_10_0 + 1
	elseif not var_10_2 then
		g.core.module.ModuleManager:tip(var_10_3)
		self:setSelectedIndex(self._curIndex - 1)
	end

	local var_10_4 = self:getChildAt((self:itemIndexToChildIndex(var_10_0)))

	if var_10_4 then
		local var_10_5 = var_10_4:getChild("effectHolder")

		if var_10_5 and self._effect then
			var_10_5:addEffectSpine(self._effect)
		end
	end

	if var_10_1.sound then
		g.core.sound.SoundManager:playSound(var_10_1.sound)
	end
end

function BaseTab:canListScroll()
	return self._canDrag
end

function BaseTab:_onRequestResponse()
	if not next(self._tabDatas) then
		return
	end

	for iter_12_0, iter_12_1 in ipairs(self._tabDatas) do
		if iter_12_1.cond then
			iter_12_1:cond(self._data)
		end
	end

	self:refreshTab()
end

function BaseTab:refreshRedPoint()
	self._refreshRedPoint = true

	self:refreshTab()

	self._refreshRedPoint = false
end

function BaseTab:clearRedPointCond()
	self._clearRedCon = true

	self:refreshTab()

	self._clearRedCon = false
end

function BaseTab:refreshFuncUnlock()
	self._refreshFuncUnlock = true

	self:refreshTab()

	self._refreshFuncUnlock = false
end

return BaseTab
