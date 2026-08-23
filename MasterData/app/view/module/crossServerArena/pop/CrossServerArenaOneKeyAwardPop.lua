local var_0_0 = g.core.model.User.crossServerArenaData
local CrossServerArenaOneKeyAwardPop = class("CrossServerArenaOneKeyAwardPop", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaOneKeyAwardPop"), function()
	return fgui.GComponent:create({
		resName = "CrossServerArenaOneKeyAwardPop",
		pkgName = "crossServerArena"
	})
end)

function CrossServerArenaOneKeyAwardPop:ctor(arg_2_1)
	self._timeAwardList = var_0_0:getOneKeyAwardList(arg_2_1)

	self:showAtCenter()
	self:_initBtn()
	self:_initListView()
	self:_initView()
end

function CrossServerArenaOneKeyAwardPop:_initBtn()
	self.m_doneBtn:addClickListener(handler(self, self._onDoneClick))
	self.m_continueBtn:addClickListener(handler(self, self._onContinueBtnClick))
end

function CrossServerArenaOneKeyAwardPop:_onDoneClick()
	self:removeSelf()
end

function CrossServerArenaOneKeyAwardPop:_onContinueBtnClick()
	self:dispatchCompEvent("continueSweep")
	self:removeSelf()
end

function CrossServerArenaOneKeyAwardPop:_initListView()
	self.m_awardList:setIniter()
	self.m_awardList:setItemRendererAsync1(handler(self, self._onRenderAwardList), 0.8, false, nil, nil, true)
	self.m_awardList:setTouchable(false)
end

function CrossServerArenaOneKeyAwardPop:_onRenderAwardList(arg_7_1, arg_7_2)
	if self._timeAwardList[arg_7_1 + 1].type == g.core.common.Goods.TYPE_ITEM and g.core.model.User.themeData:isActivityItem(self._timeAwardList[arg_7_1 + 1].value) then
		self._timeAwardList[arg_7_1 + 1].iconTagType = g.core.const.ConstMgr.BASE_CONST.ICON_TAG_TYPE.PROB
	end

	arg_7_2:updateCell(self._timeAwardList[arg_7_1 + 1], arg_7_1 + 1)
end

function CrossServerArenaOneKeyAwardPop:_initView()
	self.m_awardList:setNumItems(#self._timeAwardList)
	self:newScheduleOnce(handler(self, function(arg_9_0)
		arg_9_0.m_awardList:setTouchable(true)
	end), math.max(0, #self._timeAwardList - 4) * 0.8)
end

return CrossServerArenaOneKeyAwardPop
