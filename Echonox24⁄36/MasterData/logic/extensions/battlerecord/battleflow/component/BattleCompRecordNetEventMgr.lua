-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/battleflow/component/BattleCompRecordNetEventMgr.lua

module("logic.extensions.battlerecord.battleflow.component.BattleCompRecordNetEventMgr", package.seeall)

local BattleCompRecordNetEventMgr = class("BattleCompRecordNetEventMgr", IBattleFlowComp)

function BattleCompRecordNetEventMgr:onInit()
	self._cmdParser = BattleCmdParser.New()
	self._eventTriggeredPushList = false
	self._eventIndex = 0
end

function BattleCompRecordNetEventMgr:onStart()
	self._eventIndex = 0
	self._cmdExecuter = self.flow.cmdExecuter or false
end

function BattleCompRecordNetEventMgr:onClear()
	self._cmdExecuter = false

	self._cmdParser:internal_clear()

	self._eventIndex = 0
	self._eventTriggeredPushList = false
end

function BattleCompRecordNetEventMgr:setEventTriggeredPushList(eventTriggeredPushList)
	self._eventTriggeredPushList = eventTriggeredPushList
end

function BattleCompRecordNetEventMgr:tryNextEvent()
	self:processNextEvent()
end

function BattleCompRecordNetEventMgr:processNextEvent()
	self._eventIndex = self._eventIndex + 1

	local eventTriggeredPushNO = self._eventTriggeredPushList[self._eventIndex]

	if not eventTriggeredPushNO then
		if BattleLog.enableLog then
			BattleLog.log("process event finish!")
		end

		self._cmdParser:addCommand(BattleRecordForceExitCommand:createInstance())
		self._cmdParser:submit()

		return
	end

	local eventNOList = eventTriggeredPushNO.events

	if eventNOList and #eventNOList > 0 then
		self._cmdParser:internal_begin()
		self._cmdParser:pushCmdContainer(self._cmdExecuter)
		BattleCmdUtil.parseServerCommandBatch(self._cmdParser, eventNOList)
		self._cmdParser:addCommand(BattleRecordProcessEventFinishCommand:createInstance())
		self._cmdParser:submit()
	else
		self:processNextEvent()
	end
end

return BattleCompRecordNetEventMgr
