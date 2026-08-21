-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Helper\\SwitchServerHelper.lua

local LuaToolkit = Framework.Tools.LuaToolkit
local EventCenter = EventCenter
local EventConst = require("EventConst")
local ChatService = require("Network/ChatService")
local SwitchServerHelper = {}
local self = SwitchServerHelper

self.PATCH_VERSION_TIMEOUT = 30
self._dstSvrMark = nil
self._recoverState = nil
self._ignoreSilent = false

function SwitchServerHelper.tryUpdatePatchVersion(svrMark)
	LuaToolkit.GetPatchVersionForLua(svrMark, self.PATCH_VERSION_TIMEOUT, nil)
end

function SwitchServerHelper.changeSvrAndTryReset(serverInfo)
	if not serverInfo then
		return
	end

	local serverInfoStr = ClientUtils.table2String(serverInfo)

	LuaToolkit.SetRuntimeData(Const.RELOAD_KEY_SERVER_INFO, serverInfoStr)

	local svrMark = serverInfo.svrMark or ""
	local openID = AccountManager.getOpenID()
	local token = AccountManager.getToken()

	if openID and token then
		LuaToolkit.SetRuntimeData(Const.RELOAD_KEY_OPEN_ID, openID)
		LuaToolkit.SetRuntimeData(Const.RELOAD_KEY_OPEN_TOKEN, token)
	end

	self._recoverState = GameFsm.getCurState().stateName
	self._dstSvrMark = svrMark

	LuaToolkit.SetAndSaveSvrMark(svrMark)
	LuaToolkit.GetPatchVersionForLua(svrMark, self.PATCH_VERSION_TIMEOUT, self._onLoadedWhenChangeSvr)
	MsgManager.onAccountChange()
	ChatService.disconnect()
	ChatService.resetConnectTime()
end

function SwitchServerHelper._onLoadedWhenChangeSvr(svrMark, patchVersion)
	if svrMark == self._dstSvrMark then
		if not IS_PUBLISH_VERSION and not patchVersion and LuaToolkit.IsEditor() then
			patchVersion = {
				lcr = VersionUtils.getDocumentPatchVersion() + math.random(2) - 1
			}
		end

		if self._recoverState == Const.STATE_LOGIN then
			LuaToolkit.SetRuntimeData(Const.RELOAD_KEY_SILENT_LOGIN, "0")
		else
			LuaToolkit.SetRuntimeData(Const.RELOAD_KEY_SILENT_LOGIN, "1")
		end

		local docPatchVersion = VersionUtils.getDocumentPatchVersion()
		local needReload = patchVersion ~= nil and patchVersion.lcr ~= docPatchVersion

		if needReload then
			self._ignoreSilent = true

			Game.Reload()
		else
			GameFsm.getState(Const.STATE_LOGIN):setAutoAction(Const.AUTO_LOGIN)
			AccountManager.logoutGame()
		end
	end
end

function SwitchServerHelper.isSilentLoginThisTime()
	local isSilentLogin = LuaToolkit.GetRuntimeData(Const.RELOAD_KEY_SILENT_LOGIN, true) == "1"

	return isSilentLogin
end

function SwitchServerHelper.tryRestoreServerInfo()
	local infoStr = LuaToolkit.GetRuntimeData(Const.RELOAD_KEY_SERVER_INFO, true)

	if infoStr ~= nil then
		local serverInfo = ClientUtils.string2Table(infoStr)

		SvrListManager.setServerInfo(serverInfo)
		SvrListManager.selectWithPriority(serverInfo.id, SvrListManager.PRIORITY_USER)
	end
end

SwitchServerHelper.ENTRY_FORBID_TIPS = Lang.get(29951)
SwitchServerHelper.RESTART_TIPS = Lang.get(29952)

function SwitchServerHelper.onSvrMarkMismatch(svrMark, hotfixMD5)
	local function onGetPatchVersion(remoteSvrMark, patchVersion)
		if remoteSvrMark ~= svrMark then
			return
		end

		local localVer = VersionUtils.getDocumentPatchVersion()
		local pkgVer = LuaToolkit.GetPkgPatchVersion().lcr
		local remoteVer

		if patchVersion then
			remoteVer = patchVersion.lcr
		else
			remoteVer = localVer
		end

		if remoteVer < pkgVer then
			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(29953), SwitchServerHelper.ENTRY_FORBID_TIPS)
		elseif remoteVer == localVer and (HotfixMD5 == "" or HotfixMD5 == hotfixMD5) then
			LuaToolkit.SetAndSaveSvrMark(svrMark)
			AccountManager.connectGameServer(nil, nil, true)
		else
			local function cbYes()
				LuaToolkit.SetAndSaveSvrMark(svrMark)

				local serverInfo = SvrListManager.getSelectedSvrInfo()
				local serverInfoStr = ClientUtils.table2String(serverInfo)

				LuaToolkit.SetRuntimeData(Const.RELOAD_KEY_SERVER_INFO, serverInfoStr)
				LuaToolkit.SetRuntimeData(Const.RELOAD_KEY_SILENT_LOGIN, "1")

				local t = Timer.New(function()
					Game.Reload()
				end, 0.5)

				t:Start()
			end

			local function cbNo()
				return
			end

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(29954), SwitchServerHelper.RESTART_TIPS, cbYes, cbNo)
		end
	end

	LuaToolkit.GetPatchVersionForLua(svrMark, 30, onGetPatchVersion)
end

return SwitchServerHelper
