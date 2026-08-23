local RecruitTreeRootCell = class("RecruitTreeRootCell", require("app.fairyGUI.recruit.UI_RecruitTreeRootCell"))
local var_0_2 = g.core.const.ConstMgr.RecruitConst

function RecruitTreeRootCell:ctor(arg_1_1)
	self._selectedIndex = nil
	self._subNum = 0
	self._rootTag = 0
	self._selectTag = 1
	self._selectCallFunc = nil
	self._selectCheckFunc = nil
	self.m_title = self:getChild("title")
	self.m_buttonController = self:getController("button")

	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChanged))
	self.m_subList:setIniter(self)
	self.m_subList:setItemRenderer(handler(self, self._onSubCellRenderer))
	self.m_subList:setVisible(false)

	self._expandStatue = 0
end

function RecruitTreeRootCell:_onSubCellRenderer(arg_2_1, arg_2_2)
	if not self._cfg then
		return
	end

	arg_2_2:updateView(self._cfg.subTree[arg_2_1 + 1], arg_2_1)
	arg_2_2:playEnterAnim()
end

function RecruitTreeRootCell:_onChanged()
	if not self._subNum or self._subNum == 0 then
		return
	end

	self:onAnimPlayEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitState = true

	local var_3_0 = self.m_buttonController:getSelectedIndex()

	if not self._selectedIndex then
		if var_3_0 == 1 then
			self:_getTransition():play(handler(self, self.onAnimPlayEnd))
			self:onExpand()
		end
	else
		if self._selectedIndex == var_3_0 then
			return
		end

		local var_3_1 = self:_getTransition()

		if var_3_0 == 1 then
			var_3_1:play(handler(self, self.onAnimPlayEnd))
			self:onExpand()
		else
			var_3_1:playReverse(handler(self, self.onAnimPlayEnd))
			self:onCloseExpand()
		end
	end

	self._selectedIndex = var_3_0
end

function RecruitTreeRootCell:_setTransitionTimeScale(arg_4_1)
	self[arg_4_1]:setTimeScale(arg_4_1 == "m_size_minTransition" and self._subNum or self._subNum / 4)
end

function RecruitTreeRootCell:_setTransitionEndSize(arg_5_1)
	local var_5_0 = 87 + self.m_subList:getSize().height

	arg_5_1:setValue("endSize", {
		var_5_0,
		var_5_0
	})
end

function RecruitTreeRootCell:_getTransition()
	local var_6_0 = "m_size_minTransition"

	if self._subNum > 3 then
		var_6_0 = "m_size_maxTransition"
	end

	local var_6_1 = self[var_6_0]

	self:_setTransitionTimeScale(var_6_0)
	self:_setTransitionEndSize(var_6_1)

	return var_6_1
end

function RecruitTreeRootCell:onAnimPlayEnd()
	if self._waitState then
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end

	self:_updateSubItemRedPoint()
	self:_updateRedPoint()
end

function RecruitTreeRootCell:setSubClickEvent(arg_8_1, arg_8_2)
	self._selectCallFunc = arg_8_1
	self._selectCheckFunc = arg_8_2
end

function RecruitTreeRootCell:onExpand()
	if self._selectCallFunc then
		self.m_subList:setVisible(true)

		if self._selectTag > self._subNum then
			self._selectTag = 1
		end

		self.m_subList:setNumItems(self._subNum)
		self.m_subList:resizeToFit(self._subNum)
		self.m_subList:setSelectedIndex(self._selectTag - 1)
		self:_onSubItemClick()

		self._expandStatue = 2
	end
end

function RecruitTreeRootCell:setSelectTag(arg_10_1)
	self.m_subList:setSelectedIndex(((arg_10_1 or 0) > self._subNum - 1 or nil) and 0)
	self:_onSubItemClick()
end

function RecruitTreeRootCell:_onSubItemClick()
	local var_11_0 = self.m_subList:getSelectedIndex() + 1

	if self._cfg.subTree[var_11_0] and self._selectCheckFunc(self._cfg.subTree[var_11_0]) then
		self._selectTag = var_11_0

		self._selectCallFunc(self._cfg.subTree[var_11_0], self._rootTag .. "_" .. self._selectTag)

		if self._cfg.subTree[var_11_0].redId == 455 then
			g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_PRIMARY)
		end

		if self._cfg.subTree[var_11_0].redId == 731 then
			g.core.model.User.recruitData:setLimitKnightSoulOpen(self._cfg.subTree[var_11_0].id)
		end

		if self._cfg.subTree[var_11_0].redId == 762 then
			g.core.model.User.recruitData:setLimitPreciousOpen(self._cfg.subTree[var_11_0].actId)
		end

		self:_updateSubItemRedPoint()
		self:_updateRedPoint()
	else
		self.m_subList:setSelectedIndex(self._selectTag - 1)
	end
end

function RecruitTreeRootCell:onCloseExpand()
	self.m_subList:setNumItems(0)
	self.m_subList:setVisible(false)

	self._expandStatue = 1
end

function RecruitTreeRootCell:updateView(arg_13_1, arg_13_2)
	self._rootTag = arg_13_2 + 1
	self._cfg = arg_13_1

	local var_13_0 = self._subNum

	self._subNum = #self._cfg.subTree

	if not arg_13_1 then
		return
	end

	self.m_icon1:setURL(arg_13_1.iconUrl1)
	self.m_icon2:setURL(arg_13_1.iconUrl2)

	if arg_13_1.cellRootBgUrl then
		self.m_bgLoader:setURL(arg_13_1.cellRootBgUrl)
	else
		self.m_bgLoader:setURL("ui://recruit/tab_zm_off")
	end

	self:setTitle(arg_13_1.title)
	self.m_tipText:setText(arg_13_1.titleTip)
	self.m_subList:setNumItems(self._subNum)
	self.m_subList:resizeToFit(self._subNum)

	if self._expandStatue == 2 and var_13_0 ~= self._subNum then
		self:_getTransition():play(handler(self, self.onAnimPlayEnd))
	else
		self:_updateRedPoint()
	end
end

function RecruitTreeRootCell:_updateRedPoint()
	if self._cfg and self._cfg.redId then
		self.m_redPoint:setId(self._cfg.redId)

		local var_14_0 = self._cfg.tabType == var_0_2.RECRUIT_TAB_TYPE.KNIGHT_TAB and var_0_2.RECRUIT_TYPE.LIMIT or self._cfg.tabType == var_0_2.RECRUIT_TAB_TYPE.UNITE_TAB and var_0_2.RECRUIT_TYPE.UNITE_TOKEN_LIMIT or var_0_2.RECRUIT_TYPE.ARTIFACT_LIMIT

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPoint,
			customData = {
				type = var_14_0,
				recruitId = self._cfg.id
			}
		})
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPoint,
			customData = {
				type = var_0_2.RECRUIT_TYPE.UNITE_TOKEN_LIMIT
			}
		})
	end
end

function RecruitTreeRootCell:_updateSubItemRedPoint()
	local var_15_0 = self.m_subList:getSelectedIndex()

	if var_15_0 > -1 then
		local var_15_1 = self.m_subList:getChildAt((self.m_subList:itemIndexToChildIndex(var_15_0)))

		var_15_1:updateRedPoint(true)
		var_15_1:updateRedPoint()
	end
end

function RecruitTreeRootCell:onUnload()
	if self._waitState then
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

function RecruitTreeRootCell:setSubListVisible(arg_17_1)
	self.m_subList:setVisible(arg_17_1)
end

function RecruitTreeRootCell:receiveCompEvent(arg_18_1, arg_18_2)
	if arg_18_1 == "cellIndexChange" then
		self:_onSubItemClick()

		return true
	end
end

return RecruitTreeRootCell
