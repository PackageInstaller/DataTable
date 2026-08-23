local var_0_0 = g.core.model.User.handBookData
local HandBookRightComp = class("HandBookRightComp", require("app.fairyGUI.handBook.UI_HandBookRightComp"))

function HandBookRightComp:ctor()
	self._curAttrData = {}
	self._condData = {}
	self._expand = false

	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrListRenderer))
	self.m_conditionList:setIniter()
	self.m_conditionList:setItemRenderer(handler(self, self._onCondListRenderer))
	self.m_activeBtn:addClickListener(handler(self, self._onLvUpBtnClick))
	self.m_lvUpBtn:addClickListener(handler(self, self._onLvUpBtnClick))
	self.m_touchPnl:addClickListener(handler(self, self._onPanelClick))
end

function HandBookRightComp:onLoad()
	self:_updateView()
end

function HandBookRightComp:_onPanelClick(arg_3_1)
	arg_3_1:stopPropagation()
end

function HandBookRightComp:_onLvUpBtnClick()
	if self._canLvUp or self._canActive then
		g.core.network.GameNetProxy:send_C2S_KnightBook_Upgrade({
			id = self._advId
		})
	elseif self._state == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(111531))
	elseif self._state == 1 then
		if not self._starEnough then
			g.core.module.ModuleManager:tip(g.core.lang:get(111534))
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(111535))
		end
	end
end

function HandBookRightComp:_onAttrListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateAttrShow(self._curAttrData[arg_5_1 + 1])
end

function HandBookRightComp:_onCondListRenderer(arg_6_1, arg_6_2)
	arg_6_2:setCellView(self._condData[arg_6_1 + 1].desc, self._condData[arg_6_1 + 1].finish)
end

function HandBookRightComp:setData(arg_7_1)
	self._data = arg_7_1
	self._advId = arg_7_1.advId
	self._active = arg_7_1.active
end

function HandBookRightComp:updateView()
	self._canActive = false
	self._canLvUp = false

	self:_updateView()
	self.m_activeBtn:removeAllEffect()
	self.m_lvUpBtn:removeAllEffect()

	if self._canActive then
		local var_8_0 = self.m_activeBtn:getSize()

		self.m_activeBtn:addEffectSpine({
			scale = 1,
			isLoop = true,
			name = "eff_ui_handbook_activatebtn",
			x = var_8_0.width / 2,
			y = var_8_0.height / 2
		})
	elseif self._canLvUp then
		local var_8_1 = self.m_lvUpBtn:getSize()

		self.m_lvUpBtn:addEffectSpine({
			scale = 1,
			isLoop = true,
			name = "eff_ui_handbook_activatebtn",
			x = var_8_1.width / 2,
			y = var_8_1.height / 2
		})
	end
end

function HandBookRightComp:_updateView()
	self._expand = true

	if self._expand then
		self._isMaxLevel = var_0_0:isMaxLevel(self._advId)

		if self._active then
			if self._isMaxLevel then
				self.m_stateController:setSelectedIndex(2)
				self:_updateMaxLevelShow()
			else
				self.m_stateController:setSelectedIndex(1)
				self:_updateActiveShow()
			end
		else
			self.m_stateController:setSelectedIndex(0)
			self:_updateUnActiveShow()
		end
	end
end

function HandBookRightComp:_updateMaxLevelShow()
	self._curAttrData = var_0_0:getKnightBookAttr(self._advId, (var_0_0:getKnightBookLevel(self._advId)))

	self.m_attrList:setNumItems(#self._curAttrData)

	self._state = 2

	self.m_costComp:setVisible(false)
	self.m_costBg:setVisible(false)
end

function HandBookRightComp:_updateUnActiveShow()
	if not self._data then
		return
	end

	self._state = 0
	self._curAttrData = var_0_0:getKnightBookAttr(self._advId, 0)

	self.m_attrList:setNumItems(#self._curAttrData)

	if self._data.curState == 1 then
		self._canActive = true
	end

	if self._canActive then
		self.m_activeBtn:setGrayed(false)
	else
		self.m_activeBtn:setGrayed(true)
	end
end

function HandBookRightComp:_updateActiveShow()
	local var_12_0 = var_0_0:getKnightBookLevel(self._advId)
	local var_12_1 = g.core.model.User.knightsData:getKnightByAdvanceId(self._advId):getBaseInfo()

	self._curAttrData = var_0_0:getKnightBookAttr(self._advId, var_12_0)

	self.m_attrList:setNumItems(#self._curAttrData)

	if not self._isMaxLevel then
		self._condData = {}
		self._state = 1

		local var_12_2 = var_0_0:getBookInfoByIdAndLevel(self._advId, var_12_0 + 1)
		local var_12_3 = var_0_0:getUpNeedStar(self._advId)

		if var_12_3 <= var_12_1.star then
			table.insert(self._condData, {
				finish = true,
				desc = g.core.lang:get(111503, {
					star = var_12_3
				})
			})

			self._starEnough = true
		else
			table.insert(self._condData, {
				finish = false,
				desc = g.core.lang:get(111503, {
					star = var_12_3
				})
			})

			self._starEnough = false
		end

		self.m_conditionList:setNumItems(#self._condData)

		if var_12_2.cost_value == 0 then
			self.m_costComp:setVisible(false)
			self.m_costBg:setVisible(false)

			if var_12_3 <= var_12_1.star then
				self._canLvUp = true
			end
		else
			self.m_costComp:setVisible(true)
			self.m_costBg:setVisible(true)
			self.m_costComp:updateByTVS({
				type = var_12_2.cost_type,
				value = var_12_2.cost_value,
				size = var_12_2.cost_size
			})

			if var_12_3 <= var_12_1.star and g.core.model.User.bagData:getOwnNum(var_12_2.cost_type, var_12_2.cost_value) >= var_12_2.cost_size then
				self._canLvUp = true
			end
		end
	end

	if self._canLvUp then
		self.m_lvUpBtn:setGrayed(false)
	else
		self.m_lvUpBtn:setGrayed(true)
	end
end

function HandBookRightComp:playClose(arg_13_1)
	self._expand = false

	if arg_13_1 then
		self.m_expandTransition:playReverse(arg_13_1)
	else
		self.m_expandTransition:playReverse()
	end
end

function HandBookRightComp:playExpand(arg_14_1)
	self._expand = true

	self:_updateView()

	if arg_14_1 then
		self.m_expandTransition:play(arg_14_1)
	else
		self.m_expandTransition:play()
	end
end

return HandBookRightComp
