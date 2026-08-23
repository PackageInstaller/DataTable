local UpgradeConst = require("upgrade.UpgradeConst")
local UpgradeUtil = require("upgrade.UpgradeUtil")
local var_0_2 = g.core.platform.PlatformProxy
local UpInfoState = class("UpInfoState", require("app.core.fsm.KSSimpleState"))

function UpInfoState:ctor()
	UpInfoState.super.ctor(self)

	self._stUUID = UpgradeConst.EN_FSM_ST.UPGRADE_INFO
	self._nextState = nil
end

function UpInfoState:doBeforeEntering()
	if self:_checkNeedUpgrade() then
		self:_fetchUpgradeInfo()
	else
		self:_setJumpState(UpgradeConst.EN_FSM_ST.LANG_INFO)
	end
end

function UpInfoState:doBeforeLeaving()
	return
end

function UpInfoState:doReasonState()
	if self:_isTaskFinish() then
		return self._nextState
	end

	return nil
end

function UpInfoState:_setJumpState(arg_5_1)
	self._nextState = arg_5_1

	self:_setTaskFinish()
end

function UpInfoState:_fetchUpgradeInfo()
	local var_6_0 = self._ownerFSM.versionCfg
	local var_6_1

	if not config.USE_CDN_UPGRADE then
		var_6_1 = var_6_0.android_upgrade_config_test or var_6_0.android_upgrade_config
	end

	UpgradeUtil.httpGet((device.isMac() or device.isIOS()) and (not config.USE_CDN_UPGRADE and var_6_0.ios_upgrade_config_test or var_6_0.ios_upgrade_config), handler(self, self._handleFetchUpInfoOK), handler(self, self._handleFetchUpInfoErr))
end

function UpInfoState:_handleFetchUpInfoOK(arg_7_1)
	self._ownerFSM:setDownInfoConfig(arg_7_1)

	local var_7_0 = self._ownerFSM.curVersion
	local var_7_1 = arg_7_1.version_no or g.core.utils.Tools.getSilentObbVersion()

	self._ownerFSM.upgradeVersion = var_7_0 < var_7_1 and var_7_1 or var_7_0

	if var_7_0 >= self._ownerFSM.upgradeVersion then
		self:_setJumpState(UpgradeConst.EN_FSM_ST.LANG_INFO)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = g.core.const.ConstMgr.SuperSdkConst.NEED_UPGRADE
		})
		self:_setJumpState(UpgradeConst.EN_FSM_ST.DOWNLOAD)
	end
end

function UpInfoState:_handleFetchUpInfoErr(arg_8_1)
	local var_8_0 = ""

	if arg_8_1.status then
		var_8_0 = "s" .. arg_8_1.status
	elseif arg_8_1.readyState then
		var_8_0 = "r" .. arg_8_1.readyState
	end

	if var_0_2:hasNetwork() then
		self:_fetchUpgradeInfo()
	else
		local var_8_1 = {}

		var_8_1.text = g.core.lang:get(100011, {
			errcode = var_8_0
		})
		var_8_1.handler_ok = handler(self, self._fetchUpgradeInfo)
		var_8_1.handler_cancel = handler(self, self._fetchUpgradeInfo)

		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseTxtPopComp").new(var_8_1), {
			ignoreTouch = true
		})
	end
end

function UpInfoState:_checkNeedUpgrade()
	local var_9_0 = self._ownerFSM.curVersion
	local var_9_1 = checknumber(self._ownerFSM.versionCfg.version_no) or g.core.utils.Tools.getSilentObbVersion()

	self._ownerFSM.upgradeVersion = self._ownerFSM.curVersion < var_9_1 and var_9_1 or var_9_0

	return var_9_0 < var_9_1
end

return UpInfoState
