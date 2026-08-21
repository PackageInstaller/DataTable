local var_0_0 = class("PureModeView", ReduxView)
local var_0_1 = {
	{
		id = 1,
		positionY = 1084,
		positionX = 1222,
		scale = 6666
	},
	{
		id = 2,
		positionY = 1738,
		positionX = 9042,
		scale = 6666
	},
	{
		id = 3,
		positionY = 914,
		positionX = 8443,
		scale = 6666
	}
}
local var_0_2 = 3
local var_0_3 = 4

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Main/DesktopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.settingHandler = handler(arg_3_0, arg_3_0.OnPureModeSetting)
	arg_3_0.editorHandler = handler(arg_3_0, arg_3_0.OnPureModeEditor)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.batteryCfg = {
		{
			value = "fill11",
			max = 0
		},
		{
			value = "fill12",
			max = 0.25
		},
		{
			value = "fill13",
			max = 0.5
		},
		{
			value = "fill14",
			max = 0.75
		}
	}
	arg_4_0.batteryControll = arg_4_0.fillbgControllerexcollection_:GetController("fillbg")
	arg_4_0.editorController_ = arg_4_0.desktopuiControllerexcollection_:GetController("edit")
	arg_4_0.componentDataList_ = {}
	arg_4_0.lastSaveComponentDataList_ = {}
	arg_4_0.selectControllerList_ = {}
	arg_4_0.componentRedControllerList_ = {}
	arg_4_0.componentList_ = {}
	arg_4_0.componentMoveEventTriggerList_ = {}
	arg_4_0.componentScaleEventTriggerList_ = {}
	arg_4_0.componentBounds_ = {}

	for iter_4_0 = 1, var_0_2 do
		arg_4_0.componentDataList_[iter_4_0] = {
			id = iter_4_0
		}
		arg_4_0.selectControllerList_[iter_4_0] = arg_4_0["editController_" .. iter_4_0]:GetController("select")
		arg_4_0.componentRedControllerList_[iter_4_0] = arg_4_0["editController_" .. iter_4_0]:GetController("red")

		table.insert(arg_4_0.componentList_, arg_4_0["component_" .. iter_4_0])
		table.insert(arg_4_0.componentMoveEventTriggerList_, arg_4_0["componentMoveEventTrigger_" .. iter_4_0])
		table.insert(arg_4_0.componentScaleEventTriggerList_, arg_4_0["componentScaleEventTrigger_" .. iter_4_0])

		arg_4_0.componentBounds_[iter_4_0] = arg_4_0:GetComponentBounds(arg_4_0.componentList_[iter_4_0])
	end

	local var_4_0 = manager.ui:GetCanvasSize()

	arg_4_0.coordinateX_ = var_4_0.x
	arg_4_0.coordinateY_ = var_4_0.y
	arg_4_0.beginDragIndex_ = nil
	arg_4_0.beginComponentPos_ = {}
	arg_4_0.rotateVector_ = {}
	arg_4_0.beginComponentAngleZ_ = nil
	arg_4_0.beginComponentScale_ = nil
	arg_4_0.beginComponentSize_ = {}
	arg_4_0.MinScaleNum = GameSetting.pure_mode_edit_scale.value[1]
	arg_4_0.MaxScaleNum = GameSetting.pure_mode_edit_scale.value[2]
	arg_4_0.parentWidth = arg_4_0.panelTrs_.rect.width
	arg_4_0.parentHeight = arg_4_0.panelTrs_.rect.height
	arg_4_0.selecting_ = nil
	arg_4_0.selectingIndex_ = nil
	arg_4_0.isChange_ = false
	arg_4_0.isIntersecting_ = false
	arg_4_0.isInEditorMode_ = false
	arg_4_0.intersectCheckFrameCount_ = 0
	arg_4_0.fixedComponentBounds_ = {}

	for iter_4_1 = 1, var_0_3 do
		arg_4_0.fixedComponentBounds_[iter_4_1] = arg_4_0:GetComponentBounds(arg_4_0["fixedComponent_" .. iter_4_1])
	end
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:RefreshComponentData()
	arg_5_0:RefreshComponentPos()

	arg_5_0.lastSaveComponentDataList_ = clone(arg_5_0.componentDataList_)

	arg_5_0:RegistEventListener(ON_GAME_IN, function(arg_6_0, ...)
		JumpTools.Back()
		manager.posterGirl:EnterMiniGame(arg_6_0, ...)
	end)

	arg_5_0.enterScene_ = HomeSceneSettingData:GetRealScene()

	arg_5_0:RegistEventListener(PURE_MODE_SETTING, arg_5_0.settingHandler)
	arg_5_0:RegistEventListener(PURE_MODE_EDITOR, arg_5_0.editorHandler)
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:ChangeBar()
	arg_7_0:RefreshMusic()
	arg_7_0:RefreshBattery()
	arg_7_0:UpdateTimeTxt()
	arg_7_0:StopTimer()

	arg_7_0.timer = Timer.New(function()
		arg_7_0:UpdateTimeTxt()
		arg_7_0:RefreshBattery()
	end, 1, -1)

	arg_7_0.timer:Start()
	arg_7_0:StartViewHideTimer()
	arg_7_0:SetPureModeValue()
	arg_7_0:OnPureModeSetting()
end

function var_0_0.SetPureModeValue(arg_9_0)
	local var_9_0 = arg_9_0.params_ and arg_9_0.params_.enterType or 2

	arg_9_0:RecordPureModeLog(true, var_9_0)

	arg_9_0.enterMode_ = var_9_0

	PlayerData:SetIsDeskMode(true)
end

function var_0_0.ChangeBar(arg_10_0)
	SetActive(arg_10_0.settingBtn_.gameObject, true)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		manager.notify:Invoke(PUREMODE_EXIT)
		arg_10_0:Back(1)
	end)
end

function var_0_0.OnBehind(arg_12_0)
	arg_12_0:StopViewHideTimer()
end

function var_0_0.RefreshBattery(arg_13_0)
	arg_13_0.batteryLevel = UnityEngine.SystemInfo.batteryLevel

	local var_13_0 = "fill14"

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.batteryCfg) do
		if arg_13_0.batteryLevel > iter_13_1.max then
			var_13_0 = iter_13_1.value
		end
	end

	arg_13_0.batteryControll:SetSelectedState(var_13_0)
end

function var_0_0.StartViewHideTimer(arg_14_0)
	if arg_14_0.isInEditorMode_ then
		SetActive(arg_14_0.settingBtn_.gameObject, true)
		manager.windowBar:SwitchBar({})
		arg_14_0:StopViewHideTimer()
	else
		arg_14_0:StopViewHideTimer()
		SetActive(arg_14_0.bg01Btn_.gameObject, false)

		arg_14_0.viewHideTimer_ = Timer.New(function()
			SetActive(arg_14_0.bg01Btn_.gameObject, true)
			SetActive(arg_14_0.settingBtn_.gameObject, false)
			manager.windowBar:SwitchBar({})
			arg_14_0:StopViewHideTimer()
		end, 5, 1)

		arg_14_0.viewHideTimer_:Start()
	end
end

function var_0_0.StopViewHideTimer(arg_16_0)
	if arg_16_0.viewHideTimer_ then
		arg_16_0.viewHideTimer_:Stop()

		arg_16_0.viewHideTimer_ = nil
	end
end

function var_0_0.UpdateTimeTxt(arg_17_0)
	local var_17_0 = os.time()
	local var_17_1 = os.difftime(var_17_0, os.time(os.date("!*t", var_17_0)))
	local var_17_2 = os.date("!*t", var_17_0 + var_17_1)

	arg_17_0.texttime2Text_.text = string.format("%s/%s/%s", var_17_2.year, var_17_2.month, var_17_2.day)
	arg_17_0.texttime3Text_.text = GetTips("WEEK_DES_" .. (var_17_2.wday == 1 and 7 or var_17_2.wday - 1))
	arg_17_0.texttimeText_.text = string.format("%02d:%02d", tonumber(var_17_2.hour), tonumber(var_17_2.min))
end

function var_0_0.RefreshMusic(arg_18_0)
	local var_18_0
	local var_18_1 = SettingData:GetHomeSceneSettingData()

	if arg_18_0.newSceneId and var_18_1.home_scene_scene_bgm == 1 then
		local var_18_2 = HomeSceneSettingCfg[arg_18_0.newSceneId]
		local var_18_3 = var_18_2.scene_setting

		if var_18_2.default_music ~= 0 and table.indexof(var_18_3, HomeSceneSettingConst.SETTING.SCENE_BGM) then
			var_18_0 = var_18_2.default_music
		end
	end

	if not var_18_0 then
		local var_18_4 = GetHomeMusicID()

		if var_18_4 ~= 0 and MusicRecordCfg[var_18_4] then
			var_18_0 = var_18_4
		else
			local var_18_5 = manager.audio:GetBgmPlayer()

			if var_18_5 and var_18_5.cueName and var_18_5.cueSheet then
				local var_18_6 = MusicRecordCfg.all

				for iter_18_0, iter_18_1 in ipairs(var_18_6) do
					local var_18_7 = MusicRecordCfg[iter_18_1]

					if var_18_7 and var_18_7.cueName == var_18_5.cueName and var_18_7.cuesheet == var_18_5.cueSheet then
						var_18_0 = iter_18_1
					end
				end
			end
		end
	end

	var_18_0 = var_18_0 or MusicRecordCfg.all[1]

	PlayGameBGMID(var_18_0)

	arg_18_0.text2Text_.text = GetI18NText(MusicRecordCfg[var_18_0] and MusicRecordCfg[var_18_0].musicName or "")
end

function var_0_0.OnExit(arg_19_0)
	var_0_0.super.OnExit(arg_19_0)
	PlayerData:SetDeskModeHeroSkinID(nil)

	if PlayerData:IsRandomHero() and (arg_19_0.newSkinId ~= nil or arg_19_0.oldSkinId ~= nil) then
		PlayerData:SetRandomHero(arg_19_0.newSkinId or arg_19_0.oldSkinId)
		HomeSceneSettingData:SetCurScene(arg_19_0.defaultScene_)
	elseif HomeSceneSettingCfg[arg_19_0.enterScene_] and HomeSceneSettingCfg[arg_19_0.enterScene_].limit_display == 0 then
		HomeSceneSettingData:SetCurScene(arg_19_0.enterScene_)
	end

	arg_19_0.defaultScene_ = nil
	arg_19_0.isInEditorMode_ = false
	arg_19_0.oldSkinId = nil
	arg_19_0.oldSceneId = nil
	arg_19_0.isSpecialScene = false

	arg_19_0:StopRandomTimer()
	arg_19_0:StopTimer()
	arg_19_0:StopViewHideTimer()
	arg_19_0:RecordPureModeLog(false)
	manager.windowBar:HideBar()
	arg_19_0:RemoveAllEventListener()
end

function var_0_0.OnExitInput(arg_20_0)
	if arg_20_0.isInEditorMode_ then
		return
	end

	JumpTools.Back()

	return true
end

function var_0_0.StopTimer(arg_21_0)
	if arg_21_0.timer then
		arg_21_0.timer:Stop()

		arg_21_0.timer = nil
	end
end

function var_0_0.RecordPureModeLog(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = manager.posterGirl:GetInteractionsTimes()
	local var_22_1 = manager.time:GetServerTime()

	if arg_22_1 then
		SDKTools.SendMessageToSDK("duration", {
			opt = 1,
			duration_name = "homepage_heroshow_desk",
			type = arg_22_2
		})
	else
		local var_22_2 = var_22_0 - (arg_22_0.lastInteractionsTimes or 0)
		local var_22_3 = arg_22_0.lastPureModeTime and var_22_1 - arg_22_0.lastPureModeTime or 0

		SDKTools.SendMessageToSDK("duration", {
			opt = 2,
			duration_name = "homepage_heroshow_desk",
			touch_times = var_22_2,
			duration = var_22_3
		})
	end

	arg_22_0.lastInteractionsTimes = var_22_0
	arg_22_0.lastPureModeTime = var_22_1
end

function var_0_0.AddUIListener(arg_23_0)
	arg_23_0:AddBtnListener(arg_23_0.bg01Btn_, nil, function()
		arg_23_0:ChangeBar()
		arg_23_0:StartViewHideTimer()
	end)
	arg_23_0:AddBtnListener(arg_23_0.btn_arrow_hide2Btn_, nil, function()
		arg_23_0:StopTimer()
		arg_23_0:StopViewHideTimer()
		JumpTools.OpenPageByJump("/illuMusic", {})
	end)
	arg_23_0:AddBtnListener(arg_23_0.settingBtn_, nil, function()
		if arg_23_0.isInEditorMode_ then
			return
		end

		arg_23_0:StopRandomTimer()
		JumpTools.OpenPageByJump("pureModeSettingPopView", {})
	end)
	arg_23_0:AddBtnListener(arg_23_0.editBgBtn_, nil, function()
		if arg_23_0.selecting_ then
			arg_23_0.selectControllerList_[arg_23_0.selectingIndex_]:SetSelectedState("hide")

			arg_23_0.selecting_ = nil
			arg_23_0.selectingIndex_ = nil

			SetActive(arg_23_0.editBgBtn_.gameObject, false)
		end
	end)
	arg_23_0:AddBtnListener(arg_23_0.exitEditBtn_, nil, function()
		if arg_23_0.isChange_ then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("PURE_MODE_EDIT_EXIT"),
				OkCallback = function()
					arg_23_0:ResetComponent(true)
				end
			})
		else
			arg_23_0:OnPureModeEditor(false)
			JumpTools.OpenPageByJump("pureModeSettingPopView", {})
		end
	end)
	arg_23_0:AddBtnListener(arg_23_0.resetEditBtn_, nil, function()
		if arg_23_0.isChange_ then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("PURE_MODE_EDIT_RESET"),
				OkCallback = function()
					arg_23_0:ResetComponent()
				end
			})
		else
			ShowTips("PURE_MODE_NO_CHANGE")
		end
	end)
	arg_23_0:AddBtnListener(arg_23_0.saveEditBtn_, nil, function()
		if arg_23_0.isIntersecting_ then
			ShowTips("PURE_MODE_COMPONENT_INTERSECTING")

			return
		end

		if arg_23_0.isChange_ then
			PlayerAction.SetPureModeComponent(arg_23_0.componentDataList_, function()
				JumpTools.OpenPageByJump("pureModeSettingPopView", {})

				arg_23_0.isChange_ = false
			end)
		else
			ShowTips("PURE_MODE_NO_CHANGE")
			arg_23_0:OnPureModeEditor(false)
			JumpTools.OpenPageByJump("pureModeSettingPopView", {})
		end
	end)

	for iter_23_0 = 1, #arg_23_0.componentMoveEventTriggerList_ do
		arg_23_0.componentMoveEventTriggerList_[iter_23_0]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function(arg_34_0, arg_34_1)
			arg_23_0:SelectComponent(iter_23_0)
		end))
	end

	for iter_23_1 = 1, #arg_23_0.componentMoveEventTriggerList_ do
		arg_23_0.componentMoveEventTriggerList_[iter_23_1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_35_0, arg_35_1)
			if arg_23_0.selecting_ and arg_23_0.selectingIndex_ == iter_23_1 then
				arg_23_0.beginDragIndex_ = iter_23_1
				arg_23_0.beginDragPos_ = LuaHelper.ScreenToLocal(arg_23_0.panelTrs_, arg_35_1.position, manager.ui.uiCamera)
				arg_23_0.beginComponentPos_.x = arg_23_0.selecting_:GetAnchoredPositionX(nil)
				arg_23_0.beginComponentPos_.y = arg_23_0.selecting_:GetAnchoredPositionY(nil)

				for iter_35_0 = 1, var_0_2 do
					if iter_35_0 ~= iter_23_1 then
						arg_23_0.componentBounds_[iter_35_0] = arg_23_0:GetComponentBounds(arg_23_0.componentList_[iter_35_0])
					end
				end
			end
		end))
		arg_23_0.componentMoveEventTriggerList_[iter_23_1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_36_0, arg_36_1)
			if arg_23_0.selectingIndex_ == iter_23_1 then
				arg_23_0:CaculateSelectPos(arg_36_1.position, false)
				arg_23_0:IsComponentIntersecting(iter_23_1)
			end
		end))
		arg_23_0.componentMoveEventTriggerList_[iter_23_1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_37_0, arg_37_1)
			if arg_23_0.selectingIndex_ == iter_23_1 then
				if arg_23_0.selecting_ then
					arg_23_0:SaveComponentData(arg_23_0.selecting_, iter_23_1)

					arg_23_0.isChange_ = true
					arg_23_0.componentBounds_[iter_23_1] = arg_23_0:GetComponentBounds(arg_23_0.componentList_[iter_23_1])
				end

				arg_23_0.beginDragPos_ = nil
				arg_23_0.beginDragIndex_ = nil
			end
		end))
	end

	for iter_23_2 = 1, #arg_23_0.componentScaleEventTriggerList_ do
		arg_23_0.componentScaleEventTriggerList_[iter_23_2]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_38_0, arg_38_1)
			if arg_23_0.selecting_ and arg_23_0.selectingIndex_ == iter_23_2 then
				arg_23_0.beginDragIndex_ = iter_23_2
				arg_23_0.beginDragPos_ = LuaHelper.ScreenToLocal(arg_23_0.panelTrs_, arg_38_1.position, manager.ui.uiCamera)
				arg_23_0.rotateVector_.x = arg_23_0.coordinateX_ / 2 - arg_23_0.selecting_:GetAnchoredPositionX(nil)
				arg_23_0.rotateVector_.y = arg_23_0.coordinateY_ / 2 - arg_23_0.selecting_:GetAnchoredPositionY(nil)
				arg_23_0.beginComponentPos_.x = arg_23_0.beginDragPos_.x + arg_23_0.rotateVector_.x
				arg_23_0.beginComponentPos_.y = arg_23_0.beginDragPos_.y + arg_23_0.rotateVector_.y
				arg_23_0.beginComponentAngleZ_ = arg_23_0.selecting_:GetLocalEulerAngleZ()
				arg_23_0.beginComponentScale_ = arg_23_0.selecting_:GetLocalScaleX()

				local var_38_0 = arg_23_0.selecting_.sizeDelta * arg_23_0.selecting_:GetLocalScaleX()

				arg_23_0.beginComponentSize_.x = var_38_0.x
				arg_23_0.beginComponentSize_.y = var_38_0.y

				for iter_38_0 = 1, var_0_2 do
					if iter_38_0 ~= iter_23_2 then
						arg_23_0.componentBounds_[iter_38_0] = arg_23_0:GetComponentBounds(arg_23_0.componentList_[iter_38_0])
					end
				end
			end
		end))
		arg_23_0.componentScaleEventTriggerList_[iter_23_2]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_39_0, arg_39_1)
			if arg_23_0.selectingIndex_ == iter_23_2 then
				local var_39_0 = LuaHelper.ScreenToLocal(arg_23_0.panelTrs_, arg_39_1.position, manager.ui.uiCamera)
				local var_39_1 = var_39_0.x + arg_23_0.rotateVector_.x
				local var_39_2 = var_39_0.y + arg_23_0.rotateVector_.y
				local var_39_3 = math.sqrt((var_39_1 * var_39_1 + var_39_2 * var_39_2) / (arg_23_0.beginComponentPos_.x * arg_23_0.beginComponentPos_.x + arg_23_0.beginComponentPos_.y * arg_23_0.beginComponentPos_.y))

				arg_23_0.selecting_:SetLocalScaleVal(math.min(math.max(arg_23_0.beginComponentScale_ * var_39_3, arg_23_0.MinScaleNum), arg_23_0.MaxScaleNum))
				arg_23_0:CaculateSelectPos(arg_39_1.position, true)

				arg_23_0.isChange_ = true
				arg_23_0.componentBounds_[iter_23_2] = arg_23_0:GetComponentBounds(arg_23_0.componentList_[iter_23_2])

				arg_23_0:IsComponentIntersecting(iter_23_2)
			end
		end))
		arg_23_0.componentScaleEventTriggerList_[iter_23_2]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_40_0, arg_40_1)
			if arg_23_0.selectingIndex_ == iter_23_2 then
				if arg_23_0.selecting_ then
					arg_23_0:SaveComponentData(arg_23_0.selecting_, iter_23_2)
				end

				arg_23_0.beginDragPos_ = nil
				arg_23_0.beginDragIndex_ = nil
			end
		end))
	end
end

function var_0_0.RefreshComponentData(arg_41_0)
	local var_41_0 = PlayerData:GetPureModeComponentData()

	if var_41_0 and #var_41_0 > 0 then
		for iter_41_0, iter_41_1 in ipairs(var_41_0) do
			arg_41_0.componentDataList_[iter_41_1.id] = iter_41_1
		end
	else
		arg_41_0.componentDataList_ = clone(var_0_1)
	end
end

function var_0_0.RefreshComponentPos(arg_42_0)
	for iter_42_0, iter_42_1 in ipairs(arg_42_0.componentDataList_) do
		local var_42_0 = iter_42_1.positionX / 10000 * arg_42_0.coordinateX_
		local var_42_1 = iter_42_1.positionY / 10000 * arg_42_0.coordinateY_
		local var_42_2 = iter_42_1.scale / 10000 * arg_42_0.MaxScaleNum
		local var_42_3 = arg_42_0.componentList_[iter_42_1.id].sizeDelta.x * var_42_2
		local var_42_4 = arg_42_0.componentList_[iter_42_1.id].sizeDelta.y * var_42_2
		local var_42_5 = arg_42_0.componentList_[iter_42_1.id].pivot.x
		local var_42_6 = arg_42_0.componentList_[iter_42_1.id].pivot.y
		local var_42_7 = arg_42_0.componentList_[iter_42_1.id].anchorMin
		local var_42_8 = var_42_7.x
		local var_42_9 = var_42_7.y
		local var_42_10 = var_42_5 * var_42_3 - var_42_8 * arg_42_0.parentWidth
		local var_42_11 = arg_42_0.parentWidth - (1 - var_42_5) * var_42_3 - var_42_8 * arg_42_0.parentWidth
		local var_42_12 = var_42_6 * var_42_4 - var_42_9 * arg_42_0.parentHeight
		local var_42_13 = arg_42_0.parentHeight - (1 - var_42_6) * var_42_4 - var_42_9 * arg_42_0.parentHeight
		local var_42_14 = var_42_0 - var_42_8 * arg_42_0.parentWidth
		local var_42_15 = var_42_1 - var_42_9 * arg_42_0.parentHeight
		local var_42_16 = math.max(var_42_10, math.min(var_42_14, var_42_11))
		local var_42_17 = math.max(var_42_12, math.min(var_42_15, var_42_13))

		arg_42_0.componentList_[iter_42_1.id]:SetAnchoredPositionEx(var_42_16, var_42_17)
		arg_42_0.componentList_[iter_42_1.id]:SetLocalScaleVal(var_42_2)
	end
end

function var_0_0.OnPureModeEditor(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_2 then
		arg_43_0.lastSaveComponentDataList_ = clone(arg_43_0.componentDataList_)
	end

	arg_43_0.isInEditorMode_ = arg_43_1

	arg_43_0.editorController_:SetSelectedState(arg_43_1 and "show" or "hide")
	SetActive(arg_43_0.editBgBtn_.gameObject, arg_43_1 and arg_43_0.selecting_ ~= nil)

	if arg_43_1 then
		SetActive(arg_43_0.settingBtn_.gameObject, true)
		manager.windowBar:SwitchBar({})
	else
		arg_43_0:StartViewHideTimer()
	end
end

function var_0_0.SaveComponentData(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_1.anchorMin
	local var_44_1 = var_44_0.x * arg_44_0.parentWidth + arg_44_1:GetAnchoredPositionX(nil)
	local var_44_2 = var_44_0.y * arg_44_0.parentHeight + arg_44_1:GetAnchoredPositionY(nil)

	arg_44_0.componentDataList_[arg_44_2].positionX = math.floor(var_44_1 / arg_44_0.coordinateX_ * 10000)
	arg_44_0.componentDataList_[arg_44_2].positionY = math.floor(var_44_2 / arg_44_0.coordinateY_ * 10000)
	arg_44_0.componentDataList_[arg_44_2].scale = math.floor(arg_44_1:GetLocalScaleX() / arg_44_0.MaxScaleNum * 10000)
end

function var_0_0.ResetComponent(arg_45_0, arg_45_1)
	if arg_45_0.selecting_ then
		arg_45_0.selectControllerList_[arg_45_0.selectingIndex_]:SetSelectedState("hide")

		arg_45_0.selecting_ = nil
		arg_45_0.selectingIndex_ = nil
	end

	arg_45_0.componentDataList_ = clone(arg_45_0.lastSaveComponentDataList_)

	arg_45_0:RefreshComponentPos()

	arg_45_0.isChange_ = false
	arg_45_0.isIntersecting_ = false

	if arg_45_1 then
		arg_45_0:OnPureModeEditor(false)
	end
end

function var_0_0.SelectComponent(arg_46_0, arg_46_1)
	if arg_46_0.selecting_ then
		arg_46_0.selectControllerList_[arg_46_0.selectingIndex_]:SetSelectedState("hide")

		arg_46_0.selecting_ = nil
		arg_46_0.selectingIndex_ = nil
	end

	SetActive(arg_46_0.editBgBtn_.gameObject, true)

	arg_46_0.selecting_ = arg_46_0.componentList_[arg_46_1]
	arg_46_0.selectingIndex_ = arg_46_1

	arg_46_0.selectControllerList_[arg_46_1]:SetSelectedState("show")
end

function var_0_0.CaculateSelectPos(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_0.selecting_.sizeDelta.x * arg_47_0.selecting_:GetLocalScaleX()
	local var_47_1 = arg_47_0.selecting_.sizeDelta.y * arg_47_0.selecting_:GetLocalScaleX()
	local var_47_2 = arg_47_0.selecting_.pivot.x
	local var_47_3 = arg_47_0.selecting_.pivot.y
	local var_47_4 = arg_47_0.selecting_.anchorMin
	local var_47_5 = arg_47_0.selecting_.anchorMax
	local var_47_6 = var_47_4.x
	local var_47_7 = var_47_4.y
	local var_47_8 = var_47_2 * var_47_0 - var_47_6 * arg_47_0.parentWidth
	local var_47_9 = arg_47_0.parentWidth - (1 - var_47_2) * var_47_0 - var_47_6 * arg_47_0.parentWidth
	local var_47_10 = var_47_3 * var_47_1 - var_47_7 * arg_47_0.parentHeight
	local var_47_11 = arg_47_0.parentHeight - (1 - var_47_3) * var_47_1 - var_47_7 * arg_47_0.parentHeight
	local var_47_12
	local var_47_13

	if arg_47_2 then
		var_47_12 = arg_47_0.selecting_:GetAnchoredPositionX(nil)
		var_47_13 = arg_47_0.selecting_:GetAnchoredPositionY(nil)
	else
		local var_47_14 = LuaHelper.ScreenToLocal(arg_47_0.panelTrs_, arg_47_1, manager.ui.uiCamera)

		var_47_12 = var_47_14.x - arg_47_0.beginDragPos_.x + arg_47_0.beginComponentPos_.x
		var_47_13 = var_47_14.y - arg_47_0.beginDragPos_.y + arg_47_0.beginComponentPos_.y
	end

	local var_47_15 = math.max(var_47_8, math.min(var_47_12, var_47_9))
	local var_47_16 = math.max(var_47_10, math.min(var_47_13, var_47_11))

	arg_47_0.selecting_:SetAnchoredPositionEx(var_47_15, var_47_16)
end

function var_0_0.GetComponentBounds(arg_48_0, arg_48_1)
	local var_48_0 = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)

	arg_48_1:GetWorldCorners(var_48_0)

	local var_48_1 = {}

	for iter_48_0 = 1, 4 do
		var_48_1[iter_48_0] = arg_48_0.panelTrs_:InverseTransformPoint(var_48_0[iter_48_0 - 1])
	end

	local var_48_2 = math.min(var_48_1[1].x, var_48_1[2].x, var_48_1[3].x, var_48_1[4].x)
	local var_48_3 = math.max(var_48_1[1].x, var_48_1[2].x, var_48_1[3].x, var_48_1[4].x)
	local var_48_4 = math.min(var_48_1[1].y, var_48_1[2].y, var_48_1[3].y, var_48_1[4].y)
	local var_48_5 = math.max(var_48_1[1].y, var_48_1[2].y, var_48_1[3].y, var_48_1[4].y)

	return {
		left = var_48_2,
		right = var_48_3,
		bottom = var_48_4,
		top = var_48_5
	}
end

function var_0_0.IsComponentIntersecting(arg_49_0, arg_49_1)
	arg_49_0.intersectCheckFrameCount_ = arg_49_0.intersectCheckFrameCount_ + 1

	if arg_49_0.intersectCheckFrameCount_ % 5 ~= 0 then
		return arg_49_0.isIntersecting_
	end

	local var_49_0 = arg_49_0:GetComponentBounds(arg_49_0.componentList_[arg_49_1])
	local var_49_1 = {}
	local var_49_2 = {}

	for iter_49_0 = 1, var_0_2 do
		if iter_49_0 ~= arg_49_1 then
			local var_49_3 = arg_49_0.componentBounds_[iter_49_0]

			if not (var_49_0.right < var_49_3.left) and not (var_49_0.left > var_49_3.right) and not (var_49_0.top < var_49_3.bottom) and not (var_49_0.bottom > var_49_3.top) then
				table.insert(var_49_1, iter_49_0)
			end
		end
	end

	for iter_49_1 = 1, var_0_3 do
		local var_49_4 = arg_49_0.fixedComponentBounds_[iter_49_1]

		if not (var_49_0.right < var_49_4.left) and not (var_49_0.left > var_49_4.right) and not (var_49_0.top < var_49_4.bottom) and not (var_49_0.bottom > var_49_4.top) then
			table.insert(var_49_2, iter_49_1)
		end
	end

	local var_49_5 = #var_49_1 > 0 or #var_49_2 > 0

	arg_49_0.isIntersecting_ = var_49_5

	for iter_49_2 = 1, var_0_2 do
		arg_49_0.componentRedControllerList_[iter_49_2]:SetSelectedState("hide")
	end

	if var_49_5 then
		for iter_49_3, iter_49_4 in ipairs(var_49_1) do
			arg_49_0.componentRedControllerList_[iter_49_4]:SetSelectedState("show")
		end

		arg_49_0.componentRedControllerList_[arg_49_1]:SetSelectedState("show")
	end

	return var_49_5
end

function var_0_0.StopRandomTimer(arg_50_0)
	if arg_50_0.randomHeroTimer then
		arg_50_0.randomHeroTimer:Stop()

		arg_50_0.randomHeroTimer = nil
	end
end

function var_0_0.OnPureModeSetting(arg_51_0, arg_51_1)
	arg_51_0.pureModeSettingData = PlayerData:GetPureModeData()
	arg_51_0.randomModeIndex = arg_51_0.pureModeSettingData.randomModeIndex
	arg_51_0.listRandom = arg_51_0.pureModeSettingData.randomModeRangeIndex == 1
	arg_51_0.allRandom = arg_51_0.pureModeSettingData.randomModeRangeIndex == 2

	local var_51_0 = HomeSceneSettingCfg.get_id_list_by_limit_display[1]
	local var_51_1 = HomeSceneSettingData:GetRealScene()

	arg_51_0.defaultScene_ = table.indexof(var_51_0, var_51_1) and var_51_1 or HomeSceneSettingData:GetDefaultScene()

	if arg_51_0.randomModeIndex ~= 0 and not arg_51_0.isInEditorMode_ then
		arg_51_0:StartRandomHero()
	end
end

function var_0_0.StartRandomHero(arg_52_0)
	arg_52_0:StopRandomTimer()

	if arg_52_0.listRandom and not PlayerData:IsRandomHero() then
		return
	end

	arg_52_0.oldSkinId = arg_52_0.oldSkinId or PlayerData:GetPosterGirlHeroSkinId()
	arg_52_0.oldSceneId = arg_52_0.oldSceneId or HomeSceneSettingData:GetCurScene()

	local var_52_0 = arg_52_0.pureModeSettingData.randomTimeIndex
	local var_52_1 = GameSetting.random_skin_time.value[var_52_0]

	arg_52_0.randomHeroTimer = Timer.New(function()
		arg_52_0:SetRandomHero()
	end, var_52_1, -1)

	arg_52_0.randomHeroTimer:Start()
end

function var_0_0.SetRandomHero(arg_54_0)
	arg_54_0.newSkinId = arg_54_0:GetNewSkinId()

	local var_54_0 = CustomCenterTools.PickRndSkinMatchedScene(arg_54_0.newSkinId)
	local var_54_1 = CustomCenterTools.PickRndSkinMatchedScene(arg_54_0.oldSkinId)

	arg_54_0.newSceneId = nil

	if var_54_0 and #var_54_0 > 0 then
		local var_54_2 = SkinSceneActionCfg[var_54_0[1]].special_scene_id

		if not (HomeSceneSettingData:GetUsedState(var_54_2) == SceneConst.HOME_SCENE_TYPE.LOCK) then
			arg_54_0.newSceneId = var_54_2
		end
	end

	local var_54_3 = false

	if var_54_1 and #var_54_1 > 0 then
		local var_54_4 = SkinSceneActionCfg[var_54_1[1]].special_scene_id

		var_54_3 = HomeSceneSettingData:GetUsedState(var_54_4) == SceneConst.HOME_SCENE_TYPE.LOCK
	end

	if arg_54_0.newSceneId ~= nil or var_54_1 and #var_54_1 > 0 and not var_54_3 then
		arg_54_0.isSpecialScene = true
	end

	if not arg_54_0.newSceneId then
		arg_54_0.newSceneId = arg_54_0.defaultScene_
	end

	if arg_54_0.oldSkinId ~= arg_54_0.newSkinId then
		arg_54_0:UpdateAvatarView()
	end
end

function var_0_0.GetNewSkinId(arg_55_0)
	local var_55_0, var_55_1 = HeroTools.GetAllOwnedHeroSkinList()
	local var_55_2

	if arg_55_0.randomModeIndex == 1 then
		local var_55_3 = SkinCfg[arg_55_0.oldSkinId].hero

		if arg_55_0.listRandom then
			local var_55_4 = PlayerData:GetRandomHeroList()
			local var_55_5 = {}

			for iter_55_0 = #var_55_4, 1, -1 do
				local var_55_6 = var_55_4[iter_55_0]

				if SkinCfg[var_55_6].hero == var_55_3 and var_55_6 ~= arg_55_0.oldSkinId then
					table.insert(var_55_5, var_55_6)
				end
			end

			if #var_55_5 > 0 then
				var_55_2 = var_55_5[math.random(1, #var_55_5)]
			end
		elseif arg_55_0.allRandom then
			local var_55_7 = var_55_1[var_55_3]
			local var_55_8 = table.indexof(var_55_7, arg_55_0.oldSkinId)

			if var_55_8 and var_55_8 > 0 then
				table.remove(var_55_7, var_55_8)
			end

			if #var_55_7 > 0 then
				var_55_2 = var_55_7[math.random(1, #var_55_7)]
			end
		end
	elseif arg_55_0.randomModeIndex == 2 then
		if arg_55_0.listRandom then
			var_55_2 = PlayerData:CalcNextRandomHero()
		elseif arg_55_0.allRandom then
			local var_55_9 = table.indexof(var_55_0, arg_55_0.oldSkinId)

			if var_55_9 and var_55_9 > 0 then
				table.remove(var_55_0, var_55_9)
			end

			var_55_2 = var_55_0[math.random(1, #var_55_0)]
		end
	end

	if var_55_2 == nil then
		var_55_2 = arg_55_0.oldSkinId
	end

	return var_55_2
end

function var_0_0.UpdateAvatarView(arg_56_0)
	PlayerData:SetDeskModeHeroSkinID(arg_56_0.newSkinId)

	if arg_56_0.newSceneId and arg_56_0.oldSceneId ~= arg_56_0.newSceneId then
		HomeSceneSettingData:SetCurScene(arg_56_0.newSceneId)
		arg_56_0:OnHomeSceneChange()
	elseif arg_56_0.isSpecialScene then
		arg_56_0:OnHomeSceneChange()

		arg_56_0.isSpecialScene = false
	else
		arg_56_0:SkinChange()
	end
end

function var_0_0.OnHomeSceneChange(arg_57_0)
	manager.ui:UIEventEnabled(false)

	if arg_57_0.sceneTransitionView_ == nil then
		arg_57_0.sceneTransitionView_ = CustomCenterSceneTransition.New(arg_57_0.vagueParent_)
	end

	arg_57_0.sceneTransitionView_:SnapShot()
	arg_57_0.sceneTransitionView_:PlayVagueAnimator(function()
		manager.loadScene:ForceSetShouldLoadSceneName("home", function()
			manager.ui:UIEventEnabled(true)
			arg_57_0.sceneTransitionView_:PlayAlphaAnimator()

			arg_57_0.oldSceneId = arg_57_0.newSceneId

			arg_57_0:SkinChange()
		end)
	end)
end

function var_0_0.SkinChange(arg_60_0)
	manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.home, {
		skinID = arg_60_0.newSkinId
	}, true)
	LuaForUtil.PlayEffect(manager.posterGirl:GetModel().transform, SectionSelectHeroConst.HERO_CHANGE_FX_PATH, Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
	manager.loadScene:SetHomeSceneSoundEffect()
	arg_60_0:SetCamera()
	arg_60_0:RefreshMusic()

	if arg_60_0.sceneTransitionView_ then
		arg_60_0.sceneTransitionView_:Show(false)
	end

	arg_60_0.oldSkinId = arg_60_0.newSkinId

	manager.notify:Invoke(HOME_BTN_VISIBE, true)
end

function var_0_0.SetCamera(arg_61_0)
	local var_61_0 = "home_" .. arg_61_0.newSceneId

	if CameraCfg[var_61_0] then
		manager.ui:SetMainCamera(var_61_0)
	else
		manager.ui:SetMainCamera("home")
	end
end

function var_0_0.Dispose(arg_62_0)
	var_0_0.super.Dispose(arg_62_0)
end

return var_0_0
