-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/AirWorkShopDefSceneMainView.lua

module("logic.extensions.airworkshop.flow.defflow.view.AirWorkShopDefSceneMainView", package.seeall)

local M = class("AirWorkShopDefSceneMainView", ViewComponent)
local kRotationAngle = 90

function M:buildUI()
	self._leftTopPanelGo = self:getGoByPath("maskTop/objLeft")
	self._rightTopPanelGo = self:getGoByPath("maskTop/objRight")
	self._downPanelGo = self:getGoByPath("down")
	self._middlePanelGo = self:getGoByPath("maskTop/objMiddle")
	self._btnReturn = self:getBtnByPath("maskTop/objLeft/btnBack")
	self._btnTheme = self:getBtnByPath("maskTop/objLeft/btnTheme")
	self._btnPreview = self:getBtnByPath("maskTop/objLeft/btnPreview")
	self._btnSave = self:getBtnByPath("maskTop/objRight/btnSave")
	self._btnSettings = self:getBtnByPath("maskTop/objRight/btnSetting")
	self._btnAddVisualAngle = self:getBtnByPath("maskTop/objRight/visualAngle/btnAddVisualAngle")
	self._btnMinusVisualAngle = self:getBtnByPath("maskTop/objRight/visualAngle/btnMinusVisualAngle")
	self._savePanelGo = self:getGoByPath("maskTop/objRight/btnSave/objTips")
	self._btnSaveCurrent = self:getBtnByPath("maskTop/objRight/btnSave/objTips/btnSaveCurrent")
	self._btnSaveNew = self:getBtnByPath("maskTop/objRight/btnSave/objTips/btnSaveAsNew")
	self._editStateGo = self:getGoByPath("down/stateEdit")
	self._clearStateGo = self:getGoByPath("down/stateChange")
	self._btnTest = self:getBtnByPath("down/stateEdit/btnTest")
	self._btnRecover = self:getBtnByPath("down/stateEdit/btnRecover")
	self._emptyClickBtn = Astral.UIClickTrigger.Get(self:getGoByPath("emptyClick"))
	self._previewSelectBtn = self:getBtnByPath("maskTop/objRight/btnShow")
	self._previewSelectPanelGo = self:getGoByPath("objShow")
	self._previewCloseBtn = self:getBtnByPath("objShow/btnClose")
	self._btnChangeReset = self:getBtnByPath("down/stateChange/btnReset")
	self._btnChangeRecoverAll = self:getBtnByPath("down/stateChange/btnRecoverAll")
	self._btnChangeComplete = self:getBtnByPath("down/stateChange/btnComplete")
	self._idTxt = self:getTextByPath("maskTop/objLeft/layout/txtID")
	self._btnTeach = self:getBtnByPath("maskTop/objLeft/layout/objTeach/btnTeach")
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnTheme:AddClickListener(self._onClickTheme, self)
	self._btnPreview:AddClickListener(self._onClickPreview, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnSettings:AddClickListener(self._onClickSettings, self)
	self._btnAddVisualAngle:AddClickListener(self._onAddVisualAngle, self)
	self._btnMinusVisualAngle:AddClickListener(self._onMinusVisualAngle, self)
	self._btnTest:AddClickListener(self._onClickTest, self)
	self._btnRecover:AddClickListener(self._onClickRecover, self)
	self._btnSaveCurrent:AddClickListener(self._onClickSaveAsThis, self)
	self._btnSaveNew:AddClickListener(self._onClickSaveAsNew, self)
	self._emptyClickBtn:AddClickListener(self._onClickEmpty, self)
	self._previewSelectBtn:AddClickListener(self._onClickPreviewSelect, self)
	self._previewCloseBtn:AddClickListener(self._onClickClosePreviewPanel, self)
	self._btnChangeReset:AddClickListener(self._onClickChangeReset, self)
	self._btnChangeRecoverAll:AddClickListener(self._onClickChangeRecoverAll, self)
	self._btnChangeComplete:AddClickListener(self._onClickChangeComplete, self)
	self._btnTeach:AddClickListener(self._onClickTeach, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnTheme:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnSettings:RemoveClickListener()
	self._btnPreview:RemoveClickListener()
	self._btnAddVisualAngle:RemoveClickListener()
	self._btnMinusVisualAngle:RemoveClickListener()
	self._btnTest:RemoveClickListener()
	self._btnRecover:RemoveClickListener()
	self._btnSaveCurrent:RemoveClickListener()
	self._btnSaveNew:RemoveClickListener()
	self._emptyClickBtn:RemoveClickListener()
	self._previewSelectBtn:RemoveClickListener()
	self._previewCloseBtn:RemoveClickListener()
	self._btnChangeReset:RemoveClickListener()
	self._btnChangeRecoverAll:RemoveClickListener()
	self._btnChangeComplete:RemoveClickListener()
	self._btnTeach:RemoveClickListener()
end

function M:_onClickReturn()
	if AirWorkShopDefSceneUtil.checkModified() then
		local info = {}

		info.clickRightCallBackFunc = self._saveAndExit
		info.clickRightCallBackHandler = self
		info.clickLeftCallBackFunc = self._ensureExit
		info.clickLeftCallBackHandler = self
		info.content = "将此次编辑保存?"
		info.rightTxt = "保存"
		info.leftTxt = "不保存"

		ViewMgr.instance:open(ViewName.CommonConfirmTips, info)
	else
		self:_ensureExit()
	end
end

function M:_saveAndExit()
	self._exitAfterSave = true

	self:_saveAsThis()
end

function M:_ensureExit()
	AirWorkShopDefMgr.instance:exit()
end

function M:_onClickTheme()
	local model = AirWorkShopDefMgr.instance:getModel()
	local levelId = model:getLevelId()

	ViewMgr.instance:open(ViewName.AirWorkShopDefThemeSelectView, levelId)
end

function M:_onClickPreviewSelect()
	goutil.setActive(self._previewSelectPanelGo, true)
end

function M:_onClickClosePreviewPanel()
	goutil.setActive(self._previewSelectPanelGo, false)
end

function M:_onClickEmptyInScene()
	self:_onClickClosePreviewPanel()
end

function M:_hideForPreviewSelect()
	goutil.setActive(self._leftTopPanelGo, false)
	goutil.setActive(self._rightTopPanelGo, false)
	goutil.setActive(self._downPanelGo, false)
end

function M:_showForPreviewSelect()
	goutil.setActive(self._leftTopPanelGo, true)
	goutil.setActive(self._rightTopPanelGo, true)
	goutil.setActive(self._downPanelGo, true)
end

function M:_onClickSave()
	goutil.setActive(self._emptyClickBtn.gameObject, true)
	goutil.setActive(self._savePanelGo, true)
end

function M:_onClickSaveAsThis(ignoreOnlineCheck)
	local model = AirWorkShopDefMgr.instance:getModel()
	local levelId = model:getLevelId()
	local airLevelMO = AirWorkMapModel.instance:getLevelMOById(levelId)

	self._exitAfterSave = false

	if not ignoreOnlineCheck and airLevelMO and airLevelMO:getOnlineStatus() and AirWorkShopDefSceneUtil.checkModified() then
		local dialog = Dialog.showMessage(lang("tip_title"), "当前关卡已上架，是否下架并进行保存？")

		dialog:setConfirmListener(self._saveAsThis, self)
		dialog:setConfirmText("下架并保存")
		dialog:setCancelText("取消")
	else
		self:_saveAsThis()
	end
end

function M:_saveAsThis()
	local model = AirWorkShopDefMgr.instance:getModel()
	local levelId = model:getLevelId()
	local modifiedMapMO = model:getModiedMapMO()

	if not AirWorkShopDefSceneUtil.checkMapMOLegal(modifiedMapMO) then
		self._exitAfterSave = false

		return
	end

	if AirWorkShopDefOperateUtil.hasEntityRefresh(modifiedMapMO, levelId) then
		local dialog = Dialog.showMessage(lang("tip_title"), "关卡角色数据为旧数据，是否更新为最新数据再进行另存为?")

		dialog:setConfirmListener(self._ensureSaveWithRefreshHeroes, self)
		dialog:setCancelListener(self._ensureSave, self)
		dialog:setConfirmText("更新")
		dialog:setCancelText("不更新")
	else
		self:_ensureSave()
	end
end

function M:_ensureSaveWithRefreshHeroes()
	local model = AirWorkShopDefMgr.instance:getModel()
	local modifiedMapMO = model:getModiedMapMO()
	local levelId = model:getLevelId()

	AirWorkShopDefOperateUtil.fillNeedRefreshEntitys(modifiedMapMO, levelId)
	self:_ensureSave()
end

function M:_ensureSave()
	local model = AirWorkShopDefMgr.instance:getModel()
	local levelId = model:getLevelId()
	local modifiedMapMO = model:getModiedMapMO()

	AirWorkShopDefOperateUtil.captureCamera()

	if levelId then
		AirWorkShopDefAgent.instance:sendModifyAirMapRequest(levelId, modifiedMapMO)
	else
		local index = AirWorkShopDefSceneModel.instance:getSaveIndex()

		AirWorkShopDefAgent.instance:sendCreateAirMapRequest(modifiedMapMO, index)
	end

	self:_onClickEmpty()

	if self._exitAfterSave then
		self:_ensureExit()
	end
end

function M:_closeSavePanel()
	goutil.setActive(self._savePanelGo, false)
end

function M:_onClickSaveAsNew()
	local model = AirWorkShopDefMgr.instance:getModel()
	local modifiedMapMO = model:getModiedMapMO()

	if not AirWorkShopDefSceneUtil.checkMapMOLegal(modifiedMapMO) then
		return
	end

	ViewMgr.instance:open(ViewName.AirWorkShopLevelSaveTips)
	self:_onClickEmpty()
end

function M:_onClickEmpty()
	goutil.setActive(self._emptyClickBtn.gameObject, false)
	self:_closeSavePanel()
end

function M:_onClickSettings()
	ViewMgr.instance:open(ViewName.AirWorkShopSettingView, 1)
end

function M:_onClickPreview()
	ViewMgr.instance:open(ViewName.AirWorkShopLayoutOverView)
end

function M:_onAddVisualAngle()
	self:_adjustCameraRotation(-kRotationAngle)
end

function M:_onMinusVisualAngle()
	self:_adjustCameraRotation(kRotationAngle)
end

function M:_onClickTeach()
	ViewMgr.instance:open(ViewName.AirWorkShopExplainView)
end

function M:_adjustCameraRotation(angle)
	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()
	local rotation = virtualCamera:getRotation()
	local model = AirWorkShopDefMgr.instance:getModel()

	rotation.y = model:getCameraRotation() + angle

	model:recordCameraRotation(rotation.y)
	virtualCamera:doRotation(rotation.x, rotation.y, rotation.z, BattleConst.CameraRotationTime)
	GlobalDispatcher:dispatchEvent(EventType.ON_CAMERA_ROTATION_UPDATE, BattleConst.CameraRotationTime)
end

function M:_onClickTest()
	local function func()
		self:_onClickSaveAsThis(true)
	end

	if AirWorkShopDefSceneUtil.checkModified() then
		self._testAfterSave = true

		local dialogContent
		local model = AirWorkShopDefMgr.instance:getModel()
		local levelId = model:getLevelId()
		local airLevelMO = AirWorkMapModel.instance:getLevelMOById(levelId)

		dialogContent = airLevelMO and airLevelMO:getOnlineStatus() and "当前关卡已上架，是否下架并进行保存和测试？" or "是否进行保存并测试?"

		local dialog = Dialog.showMessage(lang("tip_title"), dialogContent)

		dialog:setConfirmListener(func)
		dialog:setConfirmText("保存并测试")
		dialog:setCancelText("取消")
	else
		self:_startTest()
	end
end

function M:_startTest()
	local model = AirWorkShopDefMgr.instance:getModel()
	local levelId = model:getLevelId()

	model:setJumpToAnotherScene(true)
	AirWorkShopDefAgent.instance:sendTestAirMapRequest(levelId)
end

function M:_onLevelSaveSuccess()
	self:_refreshLevelId()

	if self._testAfterSave then
		self._testAfterSave = false

		self:_startTest()
	end
end

function M:_onClickRecover()
	AirWorkShopDefOperateUtil.setCoverHighlandIdAndCreate(false)

	self._curState = AirWorkShopEnum.DefState.Clear

	AirWorkShopDefSceneModel.instance:setCurState(self._curState)
	self:_updatePanelOnStateChange()
	AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_EDIT_MODE_UPDATE, self._curState)

	local model = AirWorkShopDefMgr.instance:getModel()
	local modifiedMapMO = model:getModiedMapMO()

	AirWorkShopDefSceneModel.instance:bakeMap(modifiedMapMO)
end

function M:_onClickChangeReset()
	local function func()
		local model = AirWorkShopDefMgr.instance:getModel()
		local modifiedMapMO = model:getModiedMapMO()
		local bakeMapMO = AirWorkShopDefSceneModel.instance:getBakeMap()

		AirWorkShopDefSceneUtil.reset2BakeMap(modifiedMapMO, bakeMapMO, self._curState)
	end

	local info = {}

	info.clickRightCallBackFunc = func
	info.clickRightCallBackHandler = self
	info.content = lang("tip_airwork_ensure_reset_all")
	info.leftTxt = lang("tip_common_cancel_1")
	info.rightTxt = lang("tip_airwork_ensure")

	ViewMgr.instance:open(ViewName.CommonConfirmTips, info)
end

function M:_onClickChangeRecoverAll()
	if self._curState == AirWorkShopEnum.DefState.Clear then
		local function func()
			local model = AirWorkShopDefMgr.instance:getModel()
			local modifiedMapMO = model:getModiedMapMO()

			AirWorkShopDefSceneUtil.removeAllHeroAndBuildings(modifiedMapMO)
		end

		local info = {}

		info.clickRightCallBackFunc = func
		info.clickRightCallBackHandler = self
		info.content = lang("tip_airwork_recover_all")
		info.leftTxt = lang("tip_common_cancel_1")
		info.rightTxt = lang("tip_airwork_ensure_recover")

		ViewMgr.instance:open(ViewName.CommonConfirmTips, info)
	end
end

function M:_onClickChangeComplete()
	local curState = self._curState

	if curState == AirWorkShopEnum.DefState.BornPosSet then
		local model = AirWorkShopDefMgr.instance:getModel()
		local modifiedMapMO = model:getModiedMapMO()
		local borns = modifiedMapMO:getBorns()

		if #borns < 5 then
			FloatWordMgr.instance:show(lang("tip_airwork_attack_count_limit"))

			return
		end
	end

	local params = false

	if curState == AirWorkShopEnum.DefState.LeavePosSet then
		local model = AirWorkShopDefMgr.instance:getModel()
		local modifiedMapMO = model:getModiedMapMO()

		params = {}

		AirWorkShopDefSceneUtil.transLeaveMOList2Params(modifiedMapMO:getLeaveMOs(), params)

		local bakeMapMO = AirWorkShopDefSceneModel.instance:getBakeMap()

		AirWorkShopDefSceneUtil.reset2BakeMap(modifiedMapMO, bakeMapMO, curState)
	end

	self._curState = AirWorkShopEnum.DefState.Edit

	AirWorkShopDefSceneModel.instance:setCurState(self._curState)
	self:_updatePanelOnStateChange()
	AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_EDIT_MODE_UPDATE, self._curState)

	if curState == AirWorkShopEnum.DefState.BornPosSet then
		ViewMgr.instance:open(ViewName.AirWorkShopSettingView, 3)
	end

	if curState == AirWorkShopEnum.DefState.LeavePosSet then
		ViewMgr.instance:open(ViewName.AirWorkShopSettingView, 1, params, true)
	end

	AirWorkShopDefOperateUtil.closeToastTips()
end

function M:_onSettingUpdateState(_, state, params)
	self._curState = state

	AirWorkShopDefSceneModel.instance:setCurState(self._curState)
	self:_updatePanelOnStateChange()
	AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_EDIT_MODE_UPDATE, self._curState)

	local model = AirWorkShopDefMgr.instance:getModel()
	local modifiedMapMO = model:getModiedMapMO()

	if self._curState == AirWorkShopEnum.DefState.LeavePosSet then
		AirWorkShopDefSceneUtil.resetLeavePointByPointList(modifiedMapMO, params)
	end

	AirWorkShopDefSceneModel.instance:bakeMap(modifiedMapMO)

	if self._curState == AirWorkShopEnum.DefState.BornPosSet then
		ToolTipsMgr.showCharacterTopToast(lang("tip_airwork_select_to_modify_attack"), false, false, true)
	elseif self._curState == AirWorkShopEnum.DefState.LeavePosSet then
		ToolTipsMgr.showCharacterTopToast(lang("tip_airwork_select_to_modify_leave"), false, false, true)
	end
end

function M:_updatePanelOnStateChange()
	local isEdit = self._curState == AirWorkShopEnum.DefState.Edit

	goutil.setActive(self._editStateGo, isEdit)
	goutil.setActive(self._clearStateGo, not isEdit)
	goutil.setActive(self._leftTopPanelGo, isEdit)
	goutil.setActive(self._btnSettings.gameObject, isEdit)
	goutil.setActive(self._btnSave.gameObject, isEdit)

	if isEdit then
		goutil.setActive(self._middlePanelGo, true)
	else
		goutil.setActive(self._middlePanelGo, self._curState == AirWorkShopEnum.DefState.Clear)
		goutil.setActive(self._btnChangeRecoverAll.gameObject, self._curState == AirWorkShopEnum.DefState.Clear)
	end
end

function M:_switchToEdit()
	AirWorkShopDefSceneModel.instance:setEnableAdjustment(true)

	self._curState = AirWorkShopEnum.DefState.Edit

	AirWorkShopDefSceneModel.instance:setCurState(self._curState)
	self:_updatePanelOnStateChange()
	AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_EDIT_MODE_UPDATE, self._curState)
end

function M:_onclickUnitToEnterEdit()
	self:_switchToEdit()
end

function M:onEnter()
	self:_init()

	self._testAfterSave = false
	self._exitAfterSave = false

	self:_setEvents(true)

	self._curState = AirWorkShopEnum.DefState.Edit

	self:_switchToEdit()
	AirWorkBattleResultController.instance:clearResultData()
	AirWorkShopDefSceneModel.instance:setDefMainViewOpenStatus(true)
end

function M:_init()
	self:_refreshLevelId()
end

function M:_refreshLevelId()
	local model = AirWorkShopDefMgr.instance:getModel()
	local levelId = model:getLevelId()

	if levelId then
		self._idTxt.text = string.format("ID:%s", levelId)
	else
		self._idTxt.text = ""
	end
end

function M:onExit()
	self._testAfterSave = false
	self._exitAfterSave = false

	self:_setEvents(false)
end

function M:_setEvents(isAdd)
	if isAdd then
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_CLICK_UNIT_TO_ENTER_EDIT, self._onclickUnitToEnterEdit, self)
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_CLICK_EMPTY_PLACE, self._onClickEmptyInScene, self)
		GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_SETTING_GOSELECT, self._onSettingUpdateState, self)
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_LEVEL_SAVED_SUCCESS, self._onLevelSaveSuccess, self)
	else
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_CLICK_UNIT_TO_ENTER_EDIT, self._onclickUnitToEnterEdit, self)
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_CLICK_EMPTY_PLACE, self._onClickEmptyInScene, self)
		GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_SETTING_GOSELECT, self._onSettingUpdateState, self)
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_LEVEL_SAVED_SUCCESS, self._onLevelSaveSuccess, self)
	end
end

return M
