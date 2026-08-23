local FavoStoryComp = class("FavoStoryComp", require("app.fairyGUI.knightFavorability.UI_FavoStoryComp"))
local var_0_1 = g.core.model.User.knightFavoData

function FavoStoryComp:ctor(arg_1_1)
	self._knightInfo = {}
	self._plotList = {}
	self._unlockNumber = 0
	self._awardParam = nil
	self._showList = {}

	self:_initView()
end

function FavoStoryComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITY_INFO, handler(self, self._onReceivePlotData), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITY_AWARD, handler(self, self._onAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_END, handler(self, self._getAward), self)
	self:_reqPlotData()
end

function FavoStoryComp:onUnload()
	self:_setHasListener()
end

function FavoStoryComp:_setHasListener()
	if next(self._showList) and next(self._knightInfo) then
		for iter_4_0, iter_4_1 in pairs(self._showList) do
			iter_4_1.isPlayed = true

			self._knightInfo:setPlotPlayedByIndex(iter_4_1)
		end
	end

	self._showList = {}
end

function FavoStoryComp:updateView(arg_5_1)
	self:_setHasListener()
	self.m_storyList:scrollToView(0)

	self._knightInfo = arg_5_1

	if var_0_1:getReqPlotStatus() then
		self:_doUpdate()
	else
		self:_reqPlotData()
	end
end

function FavoStoryComp:_initView()
	self:addListen(self.m_storyList)
	self.m_storyList:setVirtual()
	self.m_storyList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_storyList:doFairyBatching(false)
end

function FavoStoryComp:_onItemRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateView(self._plotList[arg_7_1 + 1], arg_7_1, self._unlockNumber, self._knightInfo)

	if not self._plotList[arg_7_1 + 1].isPlayed and self._unlockNumber >= arg_7_1 + 1 then
		self._showList[arg_7_1 + 1] = self._plotList[arg_7_1 + 1]
	end
end

function FavoStoryComp:_getUnlockPlotNumber()
	local var_8_0 = 0

	for iter_8_0 = 1, #self._plotList do
		if self._plotList[iter_8_0] and self._plotList[iter_8_0].avgUnlockLevel <= self._curLevel then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function FavoStoryComp:_onReceivePlotData()
	if self._knightInfo and next(self._knightInfo) then
		self:_doUpdate()
	end
end

function FavoStoryComp:_doUpdate()
	self._plotList = self._knightInfo:getPlotList()
	self._curLevel = self._knightInfo:getBaseKnightInfo():getFavoLevel()
	self._unlockNumber = self:_getUnlockPlotNumber()

	if #self._plotList > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_storyList:setNumItems(#self._plotList)
		self.m_storyList:transitionShowCells("enter_down", 0.03)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function FavoStoryComp:_reqPlotData()
	if not var_0_1:getReqPlotStatus() then
		g.core.network.GameNetProxy:send_C2S_KnightFavorability_Info({})
	end
end

function FavoStoryComp:receiveCompEvent(arg_12_1, arg_12_2)
	if arg_12_1 == "FavoStoryCell_Award" and arg_12_2 then
		self._awardParam = arg_12_2
	end
end

function FavoStoryComp:_onAward(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self._awardParam = nil

	self:_onReceivePlotData()

	if arg_13_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_13_4.awards)
	end
end

function FavoStoryComp:_getAward()
	if self._awardParam then
		g.core.network.GameNetProxy:send_C2S_KnightFavorability_Award(self._awardParam)
	end
end

return FavoStoryComp
