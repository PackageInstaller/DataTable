local var_0_0 = g.core.const.ConstMgr.CrossServerArenaConst
local ArenaRecordLayer = class("ArenaRecordLayer", require("app.fairyGUI.arena.UI_ArenaRecordLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/arena/arena",
		resName = "ArenaRecordLayer",
		pkgName = "arena"
	})
end)

function ArenaRecordLayer:ctor(arg_2_1)
	self._playListCellAni = true
	self._isInit = false
	self._curTab = var_0_0.CTRL_RECORD_TYPE.WHOLE
	self._recordList = {}

	self:_initView()
	self:_initListView()
end

function ArenaRecordLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARENA_CHALLENGERECORD, self._onCrossServerArenaRecord, self)

	if not self._isInit then
		self._isInit = true

		g.core.network.GameNetProxy:send_C2S_Arena_ChallengeRecord({
			type = self._curTab
		})
	end
end

function ArenaRecordLayer:receiveCompEvent(arg_4_1)
	if arg_4_1 == "BattleResult_continue" then
		self:_execute()
	end
end

function ArenaRecordLayer:_initView()
	self:addBg("bg/arena/bg_jjc_zhujiemian.jpg")
	self.m_topBarComp:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.ARENA)
	self.m_tabSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
end

function ArenaRecordLayer:_initListView()
	self.m_recordList:setVirtual()
	self.m_recordList:setItemRenderer(handler(self, self._onRenderRecordList))
end

function ArenaRecordLayer:_onRenderRecordList(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._recordList[self._curTab][arg_7_1 + 1], self._curTab)
end

function ArenaRecordLayer:_onTabSelChanged()
	self._playListCellAni = true
	self._curTab = self.m_tabSelController:getSelectedIndex() + 1

	local var_8_0 = self._recordList[self._curTab]

	if not self._recordList[self._curTab] then
		self.m_emptyController:setSelectedIndex(1)
		g.core.network.GameNetProxy:send_C2S_Arena_ChallengeRecord({
			type = self._curTab
		})
	else
		local var_8_1 = #var_8_0

		self.m_emptyController:setSelectedIndex(#var_8_0 <= 0 and 1 or 0)
		self.m_recordList:setNumItems(var_8_1)
		self.m_recordList:scrollToView(0, false)
		self:_transShowListCells()
	end
end

function ArenaRecordLayer:_onCrossServerArenaRecord(arg_9_1, arg_9_2, arg_9_3)
	self._curTab = arg_9_3.type
	self._recordList[self._curTab] = {}

	if arg_9_3.records then
		for iter_9_0, iter_9_1 in ipairs(arg_9_3.records) do
			table.insert(self._recordList[self._curTab], iter_9_1)
		end
	end

	if #self._recordList[self._curTab] > 0 then
		table.sort(self._recordList[self._curTab], function(arg_10_0, arg_10_1)
			if arg_10_0.battle_id ~= arg_10_1.battle_id then
				return arg_10_0.battle_id > arg_10_1.battle_id
			end
		end)
	end

	if #self._recordList[self._curTab] > 0 then
		self.m_emptyController:setSelectedIndex(0)
		self.m_recordList:setNumItems(#self._recordList[self._curTab])
		self.m_recordList:scrollToView(0, false)
		self:_transShowListCells()
	else
		self.m_emptyController:setSelectedIndex(1)
	end
end

function ArenaRecordLayer:_transShowListCells()
	if self._playListCellAni then
		self._playListCellAni = false

		self.m_recordList:transitionShowCells("enter_left", 0.03)
	end
end

return ArenaRecordLayer
