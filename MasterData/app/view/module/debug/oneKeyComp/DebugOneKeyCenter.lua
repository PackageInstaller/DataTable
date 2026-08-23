local var_0_0 = g.core.event.EventManager
local OneKeyCenter = class("OneKeyCenter", require("app.fairyGUI.debug.UI_DebugOneKeyCenter"))
local var_0_2 = 3
local var_0_3 = {
	"DebugOneKeyDailyDungeon",
	"DebugOneKeyRoom",
	"DebugOneKeyFriend",
	"DebugOneKeyArena",
	"DebugOneKeyGuildTask",
	"DebugOneKeyStormMiddle",
	"DebugOneKeyTower",
	"DebugOneKeyTowerHard",
	"DebugOneKeyShop",
	"DebugOneKeyShopArtifact",
	"DebugOneKeyGuildDungeon",
	"DebugOneKeyRichman"
}

function OneKeyCenter:ctor()
	self._oneKeyList = {}
	self._curIndex = 0
	self._stepIndex = 0
	self._curDoing = nil
	self._logList = {}
	self._stepCount = 0
	self._schedule = nil
	self._errorList = {}

	self:initView()
end

function OneKeyCenter:initData()
	for iter_2_0, iter_2_1 in ipairs(var_0_3) do
		local var_2_0 = require("app.view.module.debug.oneKeyComp.oneKey." .. iter_2_1)

		if var_2_0 then
			local var_2_1 = var_2_0.new()

			var_2_1:setLogCall(handler(self, self.insertLog))
			table.insert(self._oneKeyList, var_2_1)
		end
	end

	self._logList = {}

	self.m_logList:setNumItems(0)
end

function OneKeyCenter:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RET_MSG_ASYNC, handler(self, self._onRetMsgAsync), self)
	g.core.battle.BattleShowResult:disableAll()
	self:initData()
end

function OneKeyCenter:addStepSchedule()
	self._schedule = self._schedule or self:newSchedule(handler(self, self.checkStep), 1)
	self._stepCount = 0
end

function OneKeyCenter:cancelStepSchedule()
	if self._schedule then
		self:cancelSchedule(self._schedule)
	end

	self._schedule = nil
end

function OneKeyCenter:checkStep()
	if not self._curDoing then
		return
	end

	if self._stepIndex == self._curIndex then
		self._stepCount = self._stepCount + 1

		if self._stepCount > 1 then
			self:insertLog("! 一键操作中 ")
		end
	else
		self._stepCount = 0
	end

	if self._stepCount > var_0_2 then
		self._stepCount = 0

		self:insertLog("! 一键强制跳到下一项")
		table.insert(self._errorList, self._curDoing:getOneKeyName() .. "异常！")
		self:doNext()
	end
end

function OneKeyCenter:initView()
	self.m_logList:setVirtual()
	self.m_logList:setItemRenderer(handler(self, self._onLogRenderer))
	self.m_onKey:addClickListener(handler(self, self.onClickStart))
end

function OneKeyCenter:onClickStart()
	self._logList = {}
	self._curIndex = 0

	self:addStepSchedule()
	self:doNext()
	self:isShowStart(false)
end

function OneKeyCenter:isShowStart(arg_9_1)
	self.m_onKey:setVisible(arg_9_1)
end

function OneKeyCenter:_onLogRenderer(arg_10_1, arg_10_2)
	arg_10_2:getController("showBtn"):setSelectedIndex(1)
	arg_10_2:setTitle(arg_10_1 + 1 .. ". " .. (self._logList[arg_10_1 + 1] or ""))
end

function OneKeyCenter:doing()
	if self._curDoing then
		local var_11_0 = self._curDoing:doOneKey()

		if var_11_0 then
			self:insertLog(var_11_0)
		end

		if self._curDoing:isDone() then
			self:exitDoing()
			self:newScheduleOnce(handler(self, self.doNext), 1)
		end
	else
		self:insertLog("所有内容都完成")
		self:isShowStart(true)
		self:cancelStepSchedule()
		self:updateErrorList()
	end
end

function OneKeyCenter:updateErrorList()
	table.insertto(self._logList, self._errorList)
	self.m_logList:setNumItems(#self._logList)

	if #self._logList > 0 then
		self.m_logList:scrollToView(#self._logList - 1)
	end

	self._errorList = {}
end

function OneKeyCenter:insertLog(arg_13_1)
	table.insert(self._logList, arg_13_1)
	self.m_logList:setNumItems(#self._logList)

	if #self._logList > 0 then
		self.m_logList:scrollToView(#self._logList - 1)
	end
end

function OneKeyCenter:exitDoing()
	if self._curDoing then
		for iter_14_0, iter_14_1 in pairs((self._curDoing:getNeedAddEventList())) do
			var_0_0:removeListenerWithEvent(self, iter_14_0)
		end

		self:insertLog(self._curDoing:getOneKeyName() .. " 结束↑")
	end

	self._curDoing = nil
end

function OneKeyCenter:doNext()
	self._curIndex = self._curIndex + 1
	self._stepIndex = self._curIndex

	if self._oneKeyList[self._curIndex] then
		for iter_15_0, iter_15_1 in pairs((self._oneKeyList[self._curIndex]:getNeedAddEventList())) do
			var_0_0:addEventListener(iter_15_0, handler(self, self.onS2CNet), self)
		end

		self:insertLog(self._oneKeyList[self._curIndex]:getOneKeyName() .. " 开始↓")
	end

	self._curDoing = self._oneKeyList[self._curIndex]

	self:doing()
end

function OneKeyCenter:_onRetMsgAsync()
	if self._curDoing and self._curDoing:hasDailyStep() then
		self._curDoing:releaseDailyStep()

		self._stepCount = 0
	end
end

function OneKeyCenter:onS2CNet(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = ""

	if self._curDoing then
		var_17_0 = self._curDoing:onBaseS2CNet(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
		self._stepCount = 0
	end

	self:insertLog(var_17_0)
	self:doing()
end

function OneKeyCenter:onUnload()
	self._oneKeyList = {}

	g.core.battle.BattleShowResult:enableAll()
end

return OneKeyCenter
