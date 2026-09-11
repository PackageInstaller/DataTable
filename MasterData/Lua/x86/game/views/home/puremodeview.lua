local PureModeView = class("PureModeView", ReduxView)
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

function PureModeView:UIName()
	return "Widget/System/Main/DesktopUI"
end

function PureModeView:UIParent()
	return manager.ui.uiMain.transform
end

function PureModeView:Init()
	self:InitUI()
	self:AddUIListener()

	self.settingHandler = handler(self, self.OnPureModeSetting)
	self.editorHandler = handler(self, self.OnPureModeEditor)
end

function PureModeView:InitUI()
	self:BindCfgUI()

	self.batteryCfg = {
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
	self.batteryControll = self.fillbgControllerexcollection_:GetController("fillbg")
	self.editorController_ = self.desktopuiControllerexcollection_:GetController("edit")
	self.componentDataList_ = {}
	self.lastSaveComponentDataList_ = {}
	self.selectControllerList_ = {}
	self.componentRedControllerList_ = {}
	self.componentList_ = {}
	self.componentMoveEventTriggerList_ = {}
	self.componentScaleEventTriggerList_ = {}
	self.componentBounds_ = {}

	for iter_4_0 = 1, var_0_2 do
		self.componentDataList_[iter_4_0] = {
			id = iter_4_0
		}
		self.selectControllerList_[iter_4_0] = self["editController_" .. iter_4_0]:GetController("select")
		self.componentRedControllerList_[iter_4_0] = self["editController_" .. iter_4_0]:GetController("red")

		table.insert(self.componentList_, self["component_" .. iter_4_0])
		table.insert(self.componentMoveEventTriggerList_, self["componentMoveEventTrigger_" .. iter_4_0])
		table.insert(self.componentScaleEventTriggerList_, self["componentScaleEventTrigger_" .. iter_4_0])

		self.componentBounds_[iter_4_0] = self:GetComponentBounds(self.componentList_[iter_4_0])
	end

	local var_4_0 = manager.ui:GetCanvasSize()

	self.coordinateX_ = var_4_0.x
	self.coordinateY_ = var_4_0.y
	self.beginDragIndex_ = nil
	self.beginComponentPos_ = {}
	self.rotateVector_ = {}
	self.beginComponentAngleZ_ = nil
	self.beginComponentScale_ = nil
	self.beginComponentSize_ = {}
	self.MinScaleNum = GameSetting.pure_mode_edit_scale.value[1]
	self.MaxScaleNum = GameSetting.pure_mode_edit_scale.value[2]
	self.parentWidth = self.panelTrs_.rect.width
	self.parentHeight = self.panelTrs_.rect.height
	self.selecting_ = nil
	self.selectingIndex_ = nil
	self.isChange_ = false
	self.isIntersecting_ = false
	self.isInEditorMode_ = false
	self.intersectCheckFrameCount_ = 0
	self.fixedComponentBounds_ = {}

	for iter_4_1 = 1, var_0_3 do
		self.fixedComponentBounds_[iter_4_1] = self:GetComponentBounds(self["fixedComponent_" .. iter_4_1])
	end
end

function PureModeView:OnEnter()
	self:RefreshComponentData()
	self:RefreshComponentPos()

	self.lastSaveComponentDataList_ = clone(self.componentDataList_)

	self:RegistEventListener(ON_GAME_IN, function(arg_6_0, ...)
		JumpTools.Back()
		manager.posterGirl:EnterMiniGame(arg_6_0, ...)
	end)

	self.enterScene_ = HomeSceneSettingData:GetRealScene()

	self:RegistEventListener(PURE_MODE_SETTING, self.settingHandler)
	self:RegistEventListener(PURE_MODE_EDITOR, self.editorHandler)
end

function PureModeView:OnTop()
	self:ChangeBar()
	self:RefreshMusic()
	self:RefreshBattery()
	self:UpdateTimeTxt()
	self:StopTimer()

	self.timer = Timer.New(function()
		self:UpdateTimeTxt()
		self:RefreshBattery()
	end, 1, -1)

	self.timer:Start()
	self:StartViewHideTimer()
	self:SetPureModeValue()
	self:OnPureModeSetting()
end

function PureModeView:SetPureModeValue()
	local var_9_0

	if self.params_ then
		var_9_0 = self.params_.enterType or 2
	end

	self:RecordPureModeLog(true, var_9_0)

	self.enterMode_ = var_9_0

	PlayerData:SetIsDeskMode(true)
end

function PureModeView:ChangeBar()
	SetActive(self.settingBtn_.gameObject, true)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		manager.notify:Invoke(PUREMODE_EXIT)
		self:Back(1)
	end)
end

function PureModeView:OnBehind()
	self:StopViewHideTimer()
end

function PureModeView:RefreshBattery()
	self.batteryLevel = UnityEngine.SystemInfo.batteryLevel

	local var_13_0 = "fill14"

	for iter_13_0, iter_13_1 in ipairs(self.batteryCfg) do
		if self.batteryLevel > iter_13_1.max then
			var_13_0 = iter_13_1.value
		end
	end

	self.batteryControll:SetSelectedState(var_13_0)
end

function PureModeView:StartViewHideTimer()
	if self.isInEditorMode_ then
		SetActive(self.settingBtn_.gameObject, true)
		manager.windowBar:SwitchBar({})
		self:StopViewHideTimer()
	else
		self:StopViewHideTimer()
		SetActive(self.bg01Btn_.gameObject, false)

		self.viewHideTimer_ = Timer.New(function()
			SetActive(self.bg01Btn_.gameObject, true)
			SetActive(self.settingBtn_.gameObject, false)
			manager.windowBar:SwitchBar({})
			self:StopViewHideTimer()
		end, 5, 1)

		self.viewHideTimer_:Start()
	end
end

function PureModeView:StopViewHideTimer()
	if self.viewHideTimer_ then
		self.viewHideTimer_:Stop()

		self.viewHideTimer_ = nil
	end
end

function PureModeView:UpdateTimeTxt()
	local var_17_0 = os.time()
	local var_17_1 = os.date("!*t", var_17_0 + os.difftime(var_17_0, os.time(os.date("!*t", var_17_0))))

	self.texttime2Text_.text = string.format("%s/%s/%s", var_17_1.year, var_17_1.month, var_17_1.day)
	self.texttime3Text_.text = GetTips("WEEK_DES_" .. (var_17_1.wday == 1 and 7 or var_17_1.wday - 1))
	self.texttimeText_.text = string.format("%02d:%02d", tonumber(var_17_1.hour), tonumber(var_17_1.min))
end

function PureModeView:RefreshMusic()
	local var_18_0

	if self.newSceneId and SettingData:GetHomeSceneSettingData().home_scene_scene_bgm == 1 then
		if HomeSceneSettingCfg[self.newSceneId].default_music ~= 0 and table.indexof(HomeSceneSettingCfg[self.newSceneId].scene_setting, HomeSceneSettingConst.SETTING.SCENE_BGM) then
			var_18_0 = HomeSceneSettingCfg[self.newSceneId].default_music
		end
	end

	if not var_18_0 then
		local var_18_1 = GetHomeMusicID()

		if var_18_1 ~= 0 and MusicRecordCfg[var_18_1] then
			var_18_0 = var_18_1
		else
			local var_18_2 = manager.audio:GetBgmPlayer()

			if var_18_2 and var_18_2.cueName and var_18_2.cueSheet then
				for iter_18_0, iter_18_1 in ipairs(MusicRecordCfg.all) do
					if MusicRecordCfg[iter_18_1] and MusicRecordCfg[iter_18_1].cueName == var_18_2.cueName and MusicRecordCfg[iter_18_1].cuesheet == var_18_2.cueSheet then
						var_18_0 = iter_18_1
					end
				end
			end
		end
	end

	var_18_0 = var_18_0 or MusicRecordCfg.all[1]

	PlayGameBGMID(var_18_0)

	self.text2Text_.text = GetI18NText((MusicRecordCfg[var_18_0] or nil) and (MusicRecordCfg[var_18_0].musicName or ""))
end

function PureModeView:OnExit()
	PureModeView.super.OnExit(self)
	PlayerData:SetDeskModeHeroSkinID(nil)

	if PlayerData:IsRandomHero() then
		if self.newSkinId == nil then
			if self.oldSkinId ~= nil then
				PlayerData:SetRandomHero(self.newSkinId or self.oldSkinId)
				HomeSceneSettingData:SetCurScene(self.defaultScene_)
			elseif HomeSceneSettingCfg[self.enterScene_] and HomeSceneSettingCfg[self.enterScene_].limit_display == 0 then
				HomeSceneSettingData:SetCurScene(self.enterScene_)
			end
		end
	end

	self.defaultScene_ = nil
	self.isInEditorMode_ = false
	self.oldSkinId = nil
	self.oldSceneId = nil
	self.isSpecialScene = false

	self:StopRandomTimer()
	self:StopTimer()
	self:StopViewHideTimer()
	self:RecordPureModeLog(false)
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function PureModeView:OnExitInput()
	if self.isInEditorMode_ then
		return
	end

	JumpTools.Back()

	return true
end

function PureModeView:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function PureModeView:RecordPureModeLog(arg_22_1, arg_22_2)
	local var_22_0 = manager.posterGirl:GetInteractionsTimes()
	local var_22_1 = manager.time:GetServerTime()

	if arg_22_1 then
		SDKTools.SendMessageToSDK("duration", {
			opt = 1,
			duration_name = "homepage_heroshow_desk",
			type = arg_22_2
		})
	else
		local var_22_3 = var_22_0 - (self.lastInteractionsTimes or 0)

		SDKTools.SendMessageToSDK("duration", {
			opt = 2,
			duration_name = "homepage_heroshow_desk",
			touch_times = var_22_3,
			duration = (self.lastPureModeTime or nil) and (var_22_1 - self.lastPureModeTime or 0)
		})
	end

	self.lastInteractionsTimes = var_22_0
	self.lastPureModeTime = var_22_1
end

function PureModeView:AddUIListener()
	self:AddBtnListener(self.bg01Btn_, nil, function()
		self:ChangeBar()
		self:StartViewHideTimer()
	end)
	self:AddBtnListener(self.btn_arrow_hide2Btn_, nil, function()
		self:StopTimer()
		self:StopViewHideTimer()
		JumpTools.OpenPageByJump("/illuMusic", {})
	end)
	self:AddBtnListener(self.settingBtn_, nil, function()
		if self.isInEditorMode_ then
			return
		end

		self:StopRandomTimer()
		JumpTools.OpenPageByJump("pureModeSettingPopView", {})
	end)
	self:AddBtnListener(self.editBgBtn_, nil, function()
		if self.selecting_ then
			self.selectControllerList_[self.selectingIndex_]:SetSelectedState("hide")

			self.selecting_ = nil
			self.selectingIndex_ = nil

			SetActive(self.editBgBtn_.gameObject, false)
		end
	end)
	self:AddBtnListener(self.exitEditBtn_, nil, function()
		if self.isChange_ then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("PURE_MODE_EDIT_EXIT"),
				OkCallback = function()
					self:ResetComponent(true)
				end
			})
		else
			self:OnPureModeEditor(false)
			JumpTools.OpenPageByJump("pureModeSettingPopView", {})
		end
	end)
	self:AddBtnListener(self.resetEditBtn_, nil, function()
		if self.isChange_ then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("PURE_MODE_EDIT_RESET"),
				OkCallback = function()
					self:ResetComponent()
				end
			})
		else
			ShowTips("PURE_MODE_NO_CHANGE")
		end
	end)
	self:AddBtnListener(self.saveEditBtn_, nil, function()
		if self.isIntersecting_ then
			ShowTips("PURE_MODE_COMPONENT_INTERSECTING")

			return
		end

		if self.isChange_ then
			PlayerAction.SetPureModeComponent(self.componentDataList_, function()
				JumpTools.OpenPageByJump("pureModeSettingPopView", {})

				self.isChange_ = false
			end)
		else
			ShowTips("PURE_MODE_NO_CHANGE")
			self:OnPureModeEditor(false)
			JumpTools.OpenPageByJump("pureModeSettingPopView", {})
		end
	end)

	for iter_23_0 = 1, #self.componentMoveEventTriggerList_ do
		self.componentMoveEventTriggerList_[iter_23_0]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function(arg_34_0, arg_34_1)
			self:SelectComponent(iter_23_0)
		end))
	end

	for iter_23_1 = 1, #self.componentMoveEventTriggerList_ do
		self.componentMoveEventTriggerList_[iter_23_1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_35_0, arg_35_1)
			if self.selecting_ and self.selectingIndex_ == iter_23_1 then
				self.beginDragIndex_ = iter_23_1
				self.beginDragPos_ = LuaHelper.ScreenToLocal(self.panelTrs_, arg_35_1.position, manager.ui.uiCamera)
				self.beginComponentPos_.x = self.selecting_:GetAnchoredPositionX(nil)
				self.beginComponentPos_.y = self.selecting_:GetAnchoredPositionY(nil)

				for iter_35_0 = 1, var_0_2 do
					if iter_35_0 ~= iter_23_1 then
						self.componentBounds_[iter_35_0] = self:GetComponentBounds(self.componentList_[iter_35_0])
					end
				end
			end
		end))
		self.componentMoveEventTriggerList_[iter_23_1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_36_0, arg_36_1)
			if self.selectingIndex_ == iter_23_1 then
				self:CaculateSelectPos(arg_36_1.position, false)
				self:IsComponentIntersecting(iter_23_1)
			end
		end))
		self.componentMoveEventTriggerList_[iter_23_1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_37_0, arg_37_1)
			if self.selectingIndex_ == iter_23_1 then
				if self.selecting_ then
					self:SaveComponentData(self.selecting_, iter_23_1)

					self.isChange_ = true
					self.componentBounds_[iter_23_1] = self:GetComponentBounds(self.componentList_[iter_23_1])
				end

				self.beginDragPos_ = nil
				self.beginDragIndex_ = nil
			end
		end))
	end

	for iter_23_2 = 1, #self.componentScaleEventTriggerList_ do
		self.componentScaleEventTriggerList_[iter_23_2]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_38_0, arg_38_1)
			if self.selecting_ and self.selectingIndex_ == iter_23_2 then
				self.beginDragIndex_ = iter_23_2
				self.beginDragPos_ = LuaHelper.ScreenToLocal(self.panelTrs_, arg_38_1.position, manager.ui.uiCamera)
				self.rotateVector_.x = self.coordinateX_ / 2 - self.selecting_:GetAnchoredPositionX(nil)
				self.rotateVector_.y = self.coordinateY_ / 2 - self.selecting_:GetAnchoredPositionY(nil)
				self.beginComponentPos_.x = self.beginDragPos_.x + self.rotateVector_.x
				self.beginComponentPos_.y = self.beginDragPos_.y + self.rotateVector_.y
				self.beginComponentAngleZ_ = self.selecting_:GetLocalEulerAngleZ()
				self.beginComponentScale_ = self.selecting_:GetLocalScaleX()

				local var_38_0 = self.selecting_.sizeDelta * self.selecting_:GetLocalScaleX()

				self.beginComponentSize_.x = var_38_0.x
				self.beginComponentSize_.y = var_38_0.y

				for iter_38_0 = 1, var_0_2 do
					if iter_38_0 ~= iter_23_2 then
						self.componentBounds_[iter_38_0] = self:GetComponentBounds(self.componentList_[iter_38_0])
					end
				end
			end
		end))
		self.componentScaleEventTriggerList_[iter_23_2]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_39_0, arg_39_1)
			if self.selectingIndex_ == iter_23_2 then
				local var_39_0 = LuaHelper.ScreenToLocal(self.panelTrs_, arg_39_1.position, manager.ui.uiCamera)

				self.selecting_:SetLocalScaleVal(math.min(math.max(self.beginComponentScale_ * math.sqrt(((var_39_0.x + self.rotateVector_.x) * (var_39_0.x + self.rotateVector_.x) + (var_39_0.y + self.rotateVector_.y) * (var_39_0.y + self.rotateVector_.y)) / (self.beginComponentPos_.x * self.beginComponentPos_.x + self.beginComponentPos_.y * self.beginComponentPos_.y)), self.MinScaleNum), self.MaxScaleNum))
				self:CaculateSelectPos(arg_39_1.position, true)

				self.isChange_ = true
				self.componentBounds_[iter_23_2] = self:GetComponentBounds(self.componentList_[iter_23_2])

				self:IsComponentIntersecting(iter_23_2)
			end
		end))
		self.componentScaleEventTriggerList_[iter_23_2]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_40_0, arg_40_1)
			if self.selectingIndex_ == iter_23_2 then
				if self.selecting_ then
					self:SaveComponentData(self.selecting_, iter_23_2)
				end

				self.beginDragPos_ = nil
				self.beginDragIndex_ = nil
			end
		end))
	end
end

function PureModeView:RefreshComponentData()
	local var_41_0 = PlayerData:GetPureModeComponentData()

	if var_41_0 and #var_41_0 > 0 then
		for iter_41_0, iter_41_1 in ipairs(var_41_0) do
			self.componentDataList_[iter_41_1.id] = iter_41_1
		end
	else
		self.componentDataList_ = clone(var_0_1)
	end
end

function PureModeView:RefreshComponentPos()
	for iter_42_0, iter_42_1 in ipairs(self.componentDataList_) do
		self.componentList_[iter_42_1.id]:SetAnchoredPositionEx(math.max(self.componentList_[iter_42_1.id].pivot.x * (self.componentList_[iter_42_1.id].sizeDelta.x * (iter_42_1.scale / 10000 * self.MaxScaleNum)) - self.componentList_[iter_42_1.id].anchorMin.x * self.parentWidth, math.min(iter_42_1.positionX / 10000 * self.coordinateX_ - self.componentList_[iter_42_1.id].anchorMin.x * self.parentWidth, self.parentWidth - (1 - self.componentList_[iter_42_1.id].pivot.x) * (self.componentList_[iter_42_1.id].sizeDelta.x * (iter_42_1.scale / 10000 * self.MaxScaleNum)) - self.componentList_[iter_42_1.id].anchorMin.x * self.parentWidth)), (math.max(self.componentList_[iter_42_1.id].pivot.y * (self.componentList_[iter_42_1.id].sizeDelta.y * (iter_42_1.scale / 10000 * self.MaxScaleNum)) - self.componentList_[iter_42_1.id].anchorMin.y * self.parentHeight, math.min(iter_42_1.positionY / 10000 * self.coordinateY_ - self.componentList_[iter_42_1.id].anchorMin.y * self.parentHeight, self.parentHeight - (1 - self.componentList_[iter_42_1.id].pivot.y) * (self.componentList_[iter_42_1.id].sizeDelta.y * (iter_42_1.scale / 10000 * self.MaxScaleNum)) - self.componentList_[iter_42_1.id].anchorMin.y * self.parentHeight))))
		self.componentList_[iter_42_1.id]:SetLocalScaleVal(iter_42_1.scale / 10000 * self.MaxScaleNum)
	end
end

function PureModeView:OnPureModeEditor(arg_43_1, arg_43_2)
	if arg_43_2 then
		self.lastSaveComponentDataList_ = clone(self.componentDataList_)
	end

	self.isInEditorMode_ = arg_43_1

	self.editorController_:SetSelectedState(arg_43_1 and "show" or "hide")
	SetActive(self.editBgBtn_.gameObject, arg_43_1 and self.selecting_ ~= nil)

	if arg_43_1 then
		SetActive(self.settingBtn_.gameObject, true)
		manager.windowBar:SwitchBar({})
	else
		self:StartViewHideTimer()
	end
end

function PureModeView:SaveComponentData(arg_44_1, arg_44_2)
	self.componentDataList_[arg_44_2].positionX = math.floor((arg_44_1.anchorMin.x * self.parentWidth + arg_44_1:GetAnchoredPositionX(nil)) / self.coordinateX_ * 10000)
	self.componentDataList_[arg_44_2].positionY = math.floor((arg_44_1.anchorMin.y * self.parentHeight + arg_44_1:GetAnchoredPositionY(nil)) / self.coordinateY_ * 10000)
	self.componentDataList_[arg_44_2].scale = math.floor(arg_44_1:GetLocalScaleX() / self.MaxScaleNum * 10000)
end

function PureModeView:ResetComponent(arg_45_1)
	if self.selecting_ then
		self.selectControllerList_[self.selectingIndex_]:SetSelectedState("hide")

		self.selecting_ = nil
		self.selectingIndex_ = nil
	end

	self.componentDataList_ = clone(self.lastSaveComponentDataList_)

	self:RefreshComponentPos()

	self.isChange_ = false
	self.isIntersecting_ = false

	if arg_45_1 then
		self:OnPureModeEditor(false)
	end
end

function PureModeView:SelectComponent(arg_46_1)
	if self.selecting_ then
		self.selectControllerList_[self.selectingIndex_]:SetSelectedState("hide")

		self.selecting_ = nil
		self.selectingIndex_ = nil
	end

	SetActive(self.editBgBtn_.gameObject, true)

	self.selecting_ = self.componentList_[arg_46_1]
	self.selectingIndex_ = arg_46_1

	self.selectControllerList_[arg_46_1]:SetSelectedState("show")
end

function PureModeView:CaculateSelectPos(arg_47_1, arg_47_2)
	local var_47_0 = self.selecting_.sizeDelta.x * self.selecting_:GetLocalScaleX()
	local var_47_1 = self.selecting_.sizeDelta.y * self.selecting_:GetLocalScaleX()
	local var_47_3 = self.selecting_.pivot.x * var_47_0 - self.selecting_.anchorMin.x * self.parentWidth
	local var_47_4 = self.parentWidth - (1 - self.selecting_.pivot.x) * var_47_0 - self.selecting_.anchorMin.x * self.parentWidth
	local var_47_5 = self.selecting_.pivot.y * var_47_1 - self.selecting_.anchorMin.y * self.parentHeight
	local var_47_6 = self.parentHeight - (1 - self.selecting_.pivot.y) * var_47_1 - self.selecting_.anchorMin.y * self.parentHeight
	local var_47_7
	local var_47_8

	if arg_47_2 then
		var_47_7 = self.selecting_:GetAnchoredPositionX(nil)
		var_47_8 = self.selecting_:GetAnchoredPositionY(nil)
	else
		local var_47_9 = LuaHelper.ScreenToLocal(self.panelTrs_, arg_47_1, manager.ui.uiCamera)

		var_47_7 = var_47_9.x - self.beginDragPos_.x + self.beginComponentPos_.x
		var_47_8 = var_47_9.y - self.beginDragPos_.y + self.beginComponentPos_.y
	end

	self.selecting_:SetAnchoredPositionEx(math.max(var_47_3, math.min(var_47_7, var_47_4)), (math.max(var_47_5, math.min(var_47_8, var_47_6))))
end

function PureModeView:GetComponentBounds(arg_48_1)
	local var_48_0 = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)

	arg_48_1:GetWorldCorners(var_48_0)

	local var_48_1 = {}

	for iter_48_0 = 1, 4 do
		var_48_1[iter_48_0] = self.panelTrs_:InverseTransformPoint(var_48_0[iter_48_0 - 1])
	end

	return {
		left = math.min(var_48_1[1].x, var_48_1[2].x, var_48_1[3].x, var_48_1[4].x),
		right = math.max(var_48_1[1].x, var_48_1[2].x, var_48_1[3].x, var_48_1[4].x),
		bottom = math.min(var_48_1[1].y, var_48_1[2].y, var_48_1[3].y, var_48_1[4].y),
		top = math.max(var_48_1[1].y, var_48_1[2].y, var_48_1[3].y, var_48_1[4].y)
	}
end

function PureModeView:IsComponentIntersecting(arg_49_1)
	self.intersectCheckFrameCount_ = self.intersectCheckFrameCount_ + 1

	if self.intersectCheckFrameCount_ % 5 ~= 0 then
		return self.isIntersecting_
	end

	local var_49_0 = self:GetComponentBounds(self.componentList_[arg_49_1])
	local var_49_1 = {}
	local var_49_2 = {}

	for iter_49_0 = 1, var_0_2 do
		if iter_49_0 ~= arg_49_1 then
			if var_49_0.right >= self.componentBounds_[iter_49_0].left and var_49_0.left <= self.componentBounds_[iter_49_0].right and var_49_0.top >= self.componentBounds_[iter_49_0].bottom and var_49_0.bottom <= self.componentBounds_[iter_49_0].top then
				table.insert(var_49_1, iter_49_0)
			end
		end
	end

	for iter_49_1 = 1, var_0_3 do
		if var_49_0.right >= self.fixedComponentBounds_[iter_49_1].left and var_49_0.left <= self.fixedComponentBounds_[iter_49_1].right and var_49_0.top >= self.fixedComponentBounds_[iter_49_1].bottom and var_49_0.bottom <= self.fixedComponentBounds_[iter_49_1].top then
			table.insert(var_49_2, iter_49_1)
		end
	end

	local var_49_3 = #var_49_1 > 0 or #var_49_2 > 0

	self.isIntersecting_ = #var_49_1 > 0 or #var_49_2 > 0

	for iter_49_2 = 1, var_0_2 do
		self.componentRedControllerList_[iter_49_2]:SetSelectedState("hide")
	end

	if var_49_3 then
		for iter_49_3, iter_49_4 in ipairs(var_49_1) do
			self.componentRedControllerList_[iter_49_4]:SetSelectedState("show")
		end

		self.componentRedControllerList_[arg_49_1]:SetSelectedState("show")
	end

	return var_49_3
end

function PureModeView:StopRandomTimer()
	if self.randomHeroTimer then
		self.randomHeroTimer:Stop()

		self.randomHeroTimer = nil
	end
end

function PureModeView:OnPureModeSetting(arg_51_1)
	self.pureModeSettingData = PlayerData:GetPureModeData()
	self.randomModeIndex = self.pureModeSettingData.randomModeIndex
	self.listRandom = self.pureModeSettingData.randomModeRangeIndex == 1
	self.allRandom = self.pureModeSettingData.randomModeRangeIndex == 2

	local var_51_0 = HomeSceneSettingData:GetRealScene()

	self.defaultScene_ = table.indexof(HomeSceneSettingCfg.get_id_list_by_limit_display[1], var_51_0) and var_51_0 or HomeSceneSettingData:GetDefaultScene()

	if self.randomModeIndex ~= 0 and not self.isInEditorMode_ then
		self:StartRandomHero()
	end
end

function PureModeView:StartRandomHero()
	self:StopRandomTimer()

	if self.listRandom and not PlayerData:IsRandomHero() then
		return
	end

	self.oldSkinId = self.oldSkinId or PlayerData:GetPosterGirlHeroSkinId()
	self.oldSceneId = self.oldSceneId or HomeSceneSettingData:GetCurScene()
	self.randomHeroTimer = Timer.New(function()
		self:SetRandomHero()
	end, GameSetting.random_skin_time.value[self.pureModeSettingData.randomTimeIndex], -1)

	self.randomHeroTimer:Start()
end

function PureModeView:SetRandomHero()
	self.newSkinId = self:GetNewSkinId()

	local var_54_0 = CustomCenterTools.PickRndSkinMatchedScene(self.newSkinId)
	local var_54_1 = CustomCenterTools.PickRndSkinMatchedScene(self.oldSkinId)

	self.newSceneId = nil

	if var_54_0 and #var_54_0 > 0 then
		if HomeSceneSettingData:GetUsedState(SkinSceneActionCfg[var_54_0[1]].special_scene_id) ~= SceneConst.HOME_SCENE_TYPE.LOCK then
			self.newSceneId = SkinSceneActionCfg[var_54_0[1]].special_scene_id
		end
	end

	if self.newSceneId ~= nil or var_54_1 and #var_54_1 > 0 and not ((var_54_1 and #var_54_1 > 0 or nil) and HomeSceneSettingData:GetUsedState(SkinSceneActionCfg[var_54_1[1]].special_scene_id) == SceneConst.HOME_SCENE_TYPE.LOCK) then
		self.isSpecialScene = true
	end

	self.newSceneId = self.newSceneId or self.defaultScene_

	if self.oldSkinId ~= self.newSkinId then
		self:UpdateAvatarView()
	end
end

function PureModeView:GetNewSkinId()
	local var_55_0, var_55_1 = HeroTools.GetAllOwnedHeroSkinList()
	local var_55_2

	if self.randomModeIndex == 1 then
		if self.listRandom then
			local var_55_3 = PlayerData:GetRandomHeroList()
			local var_55_4 = {}

			for iter_55_0 = #var_55_3, 1, -1 do
				if SkinCfg[var_55_3[iter_55_0]].hero == SkinCfg[self.oldSkinId].hero and var_55_3[iter_55_0] ~= self.oldSkinId then
					table.insert(var_55_4, var_55_3[iter_55_0])
				end
			end

			if #var_55_4 > 0 then
				var_55_2 = var_55_4[math.random(1, #var_55_4)]
			end
		elseif self.allRandom then
			local var_55_5 = table.indexof(var_55_1[SkinCfg[self.oldSkinId].hero], self.oldSkinId)

			if var_55_5 and var_55_5 > 0 then
				table.remove(var_55_1[SkinCfg[self.oldSkinId].hero], var_55_5)
			end

			if #var_55_1[SkinCfg[self.oldSkinId].hero] > 0 then
				var_55_2 = var_55_1[SkinCfg[self.oldSkinId].hero][math.random(1, #var_55_1[SkinCfg[self.oldSkinId].hero])]
			end
		end
	elseif self.randomModeIndex == 2 then
		if self.listRandom then
			var_55_2 = PlayerData:CalcNextRandomHero()
		elseif self.allRandom then
			local var_55_6 = table.indexof(var_55_0, self.oldSkinId)

			if var_55_6 and var_55_6 > 0 then
				table.remove(var_55_0, var_55_6)
			end

			var_55_2 = var_55_0[math.random(1, #var_55_0)]
		end
	end

	if var_55_2 == nil then
		var_55_2 = self.oldSkinId
	end

	return var_55_2
end

function PureModeView:UpdateAvatarView()
	PlayerData:SetDeskModeHeroSkinID(self.newSkinId)

	if self.newSceneId and self.oldSceneId ~= self.newSceneId then
		HomeSceneSettingData:SetCurScene(self.newSceneId)
		self:OnHomeSceneChange()
	elseif self.isSpecialScene then
		self:OnHomeSceneChange()

		self.isSpecialScene = false
	else
		self:SkinChange()
	end
end

function PureModeView:OnHomeSceneChange()
	manager.ui:UIEventEnabled(false)

	if self.sceneTransitionView_ == nil then
		self.sceneTransitionView_ = CustomCenterSceneTransition.New(self.vagueParent_)
	end

	self.sceneTransitionView_:SnapShot()
	self.sceneTransitionView_:PlayVagueAnimator(function()
		manager.loadScene:ForceSetShouldLoadSceneName("home", function()
			manager.ui:UIEventEnabled(true)
			self.sceneTransitionView_:PlayAlphaAnimator()

			self.oldSceneId = self.newSceneId

			self:SkinChange()
		end)
	end)
end

function PureModeView:SkinChange()
	manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.home, {
		skinID = self.newSkinId
	}, true)
	LuaForUtil.PlayEffect(manager.posterGirl:GetModel().transform, SectionSelectHeroConst.HERO_CHANGE_FX_PATH, Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
	manager.loadScene:SetHomeSceneSoundEffect()
	self:SetCamera()
	self:RefreshMusic()

	if self.sceneTransitionView_ then
		self.sceneTransitionView_:Show(false)
	end

	self.oldSkinId = self.newSkinId

	manager.notify:Invoke(HOME_BTN_VISIBE, true)
end

function PureModeView:SetCamera()
	if CameraCfg["home_" .. self.newSceneId] then
		manager.ui:SetMainCamera("home_" .. self.newSceneId)
	else
		manager.ui:SetMainCamera("home")
	end
end

function PureModeView:Dispose()
	PureModeView.super.Dispose(self)
end

return PureModeView
