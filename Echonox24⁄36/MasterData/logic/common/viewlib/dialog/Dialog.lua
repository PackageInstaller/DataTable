-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/dialog/Dialog.lua

module("logic.common.viewlib.dialog.Dialog", package.seeall)

local kCapacity = 3
local kDialogRoot = PoolRootUtil.createUIPoolRoot("Dialogs")

local function registerDialog(url, dialogClass)
	dialogClass.url = url

	dialogClass:preparePool(kCapacity)
	GameObjectCache.instance:bindUrl(url, kCapacity)
end

local function createDialog(dialogClass)
	return dialogClass:createInstance()
end

local M = class("Dialog")

M.dialogRoot = kDialogRoot

registerDialog("ui/views/common/dialog/message_tips.prefab", MessageDialogImpl)
registerDialog("ui/views/common/dialog/message_tips.prefab", NotifyDialogImpl)
registerDialog(ResName.Warn_message_tips, WarnMessageDialogImpl)

function M.showMessage(title, content, sortIndex, blockKeyWhileAni)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_error, nil, nil, nil)

	local dialog = createDialog(MessageDialogImpl)

	dialog:setTitle(title):setContent(content):setViewSort(sortIndex):setTodayWarn(false):setNeedBlockKeyWhileAni(blockKeyWhileAni):show()
	GlobalDispatcher:dispatchEvent(EventType.DIALOG_SHOWED)

	return dialog
end

function M.showDialogDaily(luaTable, storageKey)
	local roleId = PlayerModel.instance:getId() or "0"

	storageKey = string.format("%s_dialog_", storageKey)

	local isFirst = LocalStorageDailyUtil.isFirstToday(storageKey)
	local toggleKey = string.format("%s_%s_toggle", storageKey, roleId)

	if isFirst then
		Astral.LocalStorage.Instance:SetInt(toggleKey, 0)
	end

	local toggleStorage = Astral.LocalStorage.Instance:GetInt(toggleKey, 0)

	luaTable.toggleState = toggleStorage == 1 and true or false

	function luaTable.togChangeCallBack(handler, isOn)
		Astral.LocalStorage.Instance:SetInt(toggleKey, isOn and 1 or 0)
	end

	luaTable.togChangeCallBackHandle = luaTable.ensureHandler

	if isFirst or toggleStorage == 0 then
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_error, nil, nil, nil)

		local dialog = createDialog(MessageDialogImpl)

		dialog:setTitle(luaTable.title):setContent(luaTable.content):setTodayWarn(luaTable):show()
		GlobalDispatcher:dispatchEvent(EventType.DIALOG_SHOWED)

		return dialog
	elseif luaTable.ensureCallBack then
		local callbackFunc = luaTable.ensureCallBack

		callbackFunc(luaTable.ensureHandler, luaTable.ensureHandler)
	end

	return false
end

function M.showWarnMessage(title, content, blockKeyWhileAni, btnVisiableInfo)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_error, nil, nil, nil)

	local dialog = createDialog(WarnMessageDialogImpl)

	dialog:setTitle(title):setContent(content):setTodayWarn(false):setNeedBlockKeyWhileAni(blockKeyWhileAni):setBtnVisiableInfo(btnVisiableInfo):show()
	GlobalDispatcher:dispatchEvent(EventType.DIALOG_SHOWED)

	return dialog
end

function M.showNotifyMessage(title, content, blockKeyWhileAni)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_error, nil, nil, nil)

	local dialog = createDialog(NotifyDialogImpl)

	dialog:setTitle(title):setContent(content):setTodayWarn(false):setNeedBlockKeyWhileAni(blockKeyWhileAni):show()
	GlobalDispatcher:dispatchEvent(EventType.DIALOG_SHOWED)

	return dialog
end

function M.closeAllMessage()
	GlobalDispatcher:dispatchEvent(EventType.ALL_DIALOG_FORCE_CLOSE)
end

return M
