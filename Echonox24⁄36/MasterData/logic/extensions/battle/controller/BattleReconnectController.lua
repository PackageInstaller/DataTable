-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/controller/BattleReconnectController.lua

module("logic.extensions.battle.controller.BattleReconnectController", package.seeall)

local M = class("BattleReconnectController", BaseController, IMainPopItem)

function M:onInit()
	self._unfinishedBattleType = false
	self._unfinishedPassId = false
	self._unfinishedLevelId = false
	self._isUnfinishedBattleExpired = false
	self._canReconnect = false
	self._isActiveCacheData = false
end

function M:onReset()
	self._unfinishedBattleType = false
	self._unfinishedPassId = false
	self._unfinishedLevelId = false
	self._isUnfinishedBattleExpired = false
	self._canReconnect = false
	self._isActiveCacheData = false
end

function M:getMainPopType()
	return MainPopEnum.Type.BattleReconnect
end

function M:hasPopUpData()
	if not self._isActiveCacheData then
		return false
	end

	if self._isUnfinishedBattleExpired then
		return false
	end

	if not self._unfinishedBattleType then
		return false
	end

	return true
end

function M:onTriggerMainPop()
	self:_tryShowMainViewFinish()
	self:_clearUnfinishedBattleRecord()
end

function M:setUnfinishedBattleInfo(battleInfoNO, canReconnect)
	local battleType = battleInfoNO.type

	self._canReconnect = canReconnect
	self._isActiveCacheData = true

	if battleType == BattleExtension_pb.BattleType.DUNGEON then
		self._unfinishedBattleType = battleType
		self._unfinishedPassId = battleInfoNO.passId
		self._unfinishedLevelId = battleInfoNO.levelId
	elseif battleType == BattleExtension_pb.BattleType.GM_CUSTOMIZE then
		self._unfinishedBattleType = battleType
	elseif battleType == BattleExtension_pb.BattleType.GM_LEVEL then
		self._unfinishedBattleType = battleType
		self._unfinishedLevelId = battleInfoNO.levelId
	elseif battleType == BattleExtension_pb.BattleType.RODEO_AIR then
		self._unfinishedBattleType = battleType
	elseif battleType == BattleExtension_pb.BattleType.TEST_AIR then
		self._unfinishedBattleType = battleType
	elseif battleType == BattleExtension_pb.BattleType.FREE_AIR then
		self._unfinishedBattleType = battleType
	elseif battleType == BattleExtension_pb.BattleType.ENDLESS_AIR then
		self._unfinishedBattleType = battleType
	else
		self._unfinishedBattleType = false

		if BattleLog.enableError then
			BattleLog.error("unhandle type", battleType)
		end
	end
end

function M:setUnfinishedBattleExpired()
	self._isUnfinishedBattleExpired = true
end

function M:_clearUnfinishedBattleRecord()
	self._isActiveCacheData = false
end

function M:_tryShowMainViewFinish()
	if not self._isActiveCacheData then
		self:finishMainPop()

		return
	end

	if self._isUnfinishedBattleExpired then
		FloatWordMgr.instance:show(lang("tip_unfinished_battle_expired"))
		self:finishMainPop()

		return
	end

	if not self._unfinishedBattleType then
		self:finishMainPop()

		return
	end

	local gameplayName = self:_getUnfinishedBattleName()
	local msg = string.format(lang("tip_unfinished_battle"), gameplayName)
	local dialog = Dialog.showMessage(lang("tip_unfinished_battle_title"), msg)

	dialog:setViewRootType(ViewRootType.Popup)
	dialog:setConfirmText(lang("tip_common_confirm"))
	dialog:setCancelText(lang("tip_common_cancel"))
	dialog:setConfirmListener(self._onClickConfirm, self)
	dialog:setCancelListener(self._onClickCancel, self)
	dialog:setCloseListener(self._onClickCancel, self)
end

function M:_onClickConfirm()
	self:increaseToNextMainPop()

	if self._canReconnect then
		BattleAgent.instance:sendReconnectBattleRequest()
		self:_requestControlActionInfo()
	else
		self:_requestStartGame()
	end
end

function M:_onClickCancel()
	self:finishMainPop()
	BattleAgent.instance:sendDeleteUnfinishedBattleRequest()
end

function M:_requestStartGame()
	if self._unfinishedBattleType == BattleExtension_pb.BattleType.DUNGEON then
		DungeonAgent.instance:sendStartDungeonRequest(self._unfinishedPassId, 1, false, BattleEnum.GamePlayType.NORMAL)
	elseif BattleLog.enableError then
		BattleLog.error("restart game failed, unhandle type", self._unfinishedBattleType)
	end
end

function M:_getUnfinishedBattleName()
	if self._unfinishedBattleType == BattleExtension_pb.BattleType.DUNGEON then
		local dungeonCO = DungeonConfig.instance:getDungeonCfgById(self._unfinishedPassId)
		local dungeonTypeName = DungeonConfig.instance:getDungeonTypeName(dungeonCO.type)
		local dungeonName = string.nilorempty(dungeonCO.index) and dungeonCO.name or dungeonCO.index

		return string.format("%s %s", dungeonTypeName, dungeonName)
	elseif self._unfinishedBattleType == BattleExtension_pb.BattleType.GM_CUSTOMIZE then
		return "GM_CUSTOMIZE"
	elseif self._unfinishedBattleType == BattleExtension_pb.BattleType.GM_LEVEL then
		return string.format("GM_LEVEL(%s)", self._unfinishedLevelId)
	elseif self._unfinishedBattleType == BattleExtension_pb.BattleType.RODEO_AIR then
		return "RODEO_AIR"
	elseif self._unfinishedBattleType == BattleExtension_pb.BattleType.TEST_AIR then
		return "空气工坊战斗"
	elseif self._unfinishedBattleType == BattleExtension_pb.BattleType.FREE_AIR then
		return "空气工坊战斗"
	elseif self._unfinishedBattleType == BattleExtension_pb.BattleType.ENDLESS_AIR then
		return "空气工坊战斗"
	end

	return "unknown"
end

function M:_requestControlActionInfo()
	if self._unfinishedPassId and DungeonUtil.isControlActionById(self._unfinishedPassId) then
		ControlActionAgent.instance:sendGetControlActionsRequest()
	end
end

M.instance = M.New()

return M
