local SettingsBattlePage = class("SettingsBattlePage", import("...base.BaseSubView"))
local var_0_1 = "joystick_anchorX"
local var_0_2 = "joystick_anchorY"
local var_0_3 = "skill_1_anchorX"
local var_0_4 = "skill_1_anchorY"
local var_0_5 = "skill_2_anchorX"
local var_0_6 = "skill_2_anchorY"
local var_0_7 = "skill_3_anchorX"
local var_0_8 = "skill_3_anchorY"
local var_0_9 = "skill_4_anchorX"
local var_0_10 = "skill_4_anchorY"

SettingsBattlePage.CLD_RED = Color.New(0.6, 0.05, 0.05, 0.5)
SettingsBattlePage.DEFAULT_GREY = Color.New(0.5, 0.5, 0.5, 0.5)

function SettingsBattlePage:getUIName()
	return "SettingsBattlePage"
end

function SettingsBattlePage:OnLoaded()
	self.editPanel = self._tf:Find("editor")

	local var_2_0 = findTF(self._tf, "editor/buttons")

	self.normalBtns = findTF(var_2_0, "normal")
	self.editBtns = findTF(var_2_0, "editing")
	self.saveBtn = findTF(self.editBtns, "save")
	self.cancelBtn = findTF(self.editBtns, "cancel")
	self.editBtn = findTF(self.normalBtns, "edit")
	self.revertBtn = findTF(self.normalBtns, "reset")
	self.interface = findTF(self._tf, "editor/editing_region")
	self.stick = findTF(self.interface, "Stick")
	self.skillBtn1 = findTF(self.interface, "Skill_1")
	self.skillBtn2 = findTF(self.interface, "Skill_2")
	self.skillBtn3 = findTF(self.interface, "Skill_3")
	self.skillBtn4 = findTF(self.interface, "Skill_4")
	self.eventStick = self.stick:GetComponent("EventTriggerListener")
	self.eventSkillBtn1 = self.skillBtn1:GetComponent("EventTriggerListener")
	self.eventSkillBtn2 = self.skillBtn2:GetComponent("EventTriggerListener")
	self.eventSkillBtn3 = self.skillBtn3:GetComponent("EventTriggerListener")
	self.eventSkillBtn4 = self.skillBtn4:GetComponent("EventTriggerListener")
	self.mask = findTF(self.interface, "mask")
	self.topArea = findTF(self.interface, "top")
	self.cg = self._tf:GetComponent(typeof(CanvasGroup))
	self.topLayerCg = self._parentTf.parent:Find("blur_panel"):GetComponent(typeof(CanvasGroup))

	setActive(self._tf, true)
	setText(self._tf:Find("editor/editing_region/mask/middle/Text"), i18n("settings_battle_tip"))
	setText(self._tf:Find("editor/buttons/normal/edit/Image"), i18n("settings_battle_Btn_edit"))
	setText(self._tf:Find("editor/buttons/normal/reset/Image"), i18n("settings_battle_Btn_reset"))
	setText(self._tf:Find("editor/title"), i18n("settings_battle_title"))
	setText(self._tf:Find("editor/buttons/editing/save/Image"), i18n("settings_battle_Btn_save"))
	setText(self._tf:Find("editor/buttons/editing/cancel/Image"), i18n("settings_battle_Btn_cancel"))

	return
end

function SettingsBattlePage:OnInit()
	onButton(self, self.editBtn, function()
		self:EditModeEnabled(true)

		return
	end, SFX_PANEL)
	onButton(self, self.revertBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = false,
			content = i18n("setting_interface_revert_check"),
			onYes = function()
				self:RevertInterfaceSetting(true)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		if self._currentDrag then
			LuaHelper.triggerEndDrag(self._currentDrag)
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = false,
			content = i18n("setting_interface_cancel_check"),
			onYes = function()
				self:EditModeEnabled(false)
				self:RevertInterfaceSetting(false)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.saveBtn, function()
		if self._currentDrag then
			LuaHelper.triggerEndDrag(self._currentDrag)
		end

		self:EditModeEnabled(false)
		self:SaveInterfaceSetting()
		pg.TipsMgr.GetInstance():ShowTips(i18n("setting_interface_save_success"))

		return
	end, SFX_PANEL)
	self:InitInterfaceComponents()

	return
end

function SettingsBattlePage:InitInterfaceComponents()
	self:InitInterfaceComponent(self.stick, self.eventStick, var_0_1, var_0_2, ys.Battle.BattleConfig.JOY_STICK_DEFAULT_PREFERENCE)
	self:InitInterfaceComponent(self.skillBtn1, self.eventSkillBtn1, var_0_3, var_0_4, ys.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE[1])
	self:InitInterfaceComponent(self.skillBtn2, self.eventSkillBtn2, var_0_5, var_0_6, ys.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE[2])
	self:InitInterfaceComponent(self.skillBtn3, self.eventSkillBtn3, var_0_7, var_0_8, ys.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE[3])
	self:InitInterfaceComponent(self.skillBtn4, self.eventSkillBtn4, var_0_9, var_0_10, ys.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE[4])

	local var_10_0 = self:GetScale()

	self.components = {
		self.topArea,
		self.stick,
		self.skillBtn1,
		self.skillBtn2,
		self.skillBtn3,
		self.skillBtn4
	}

	for iter_10_0 = 2, #self.components do
		setLocalScale(self.components[iter_10_0], var_10_0)
	end

	self:EditModeEnabled(false)

	return
end

function SettingsBattlePage:GetScale()
	local var_11_0 = rtf(self.interface).rect.width
	local var_11_1 = rtf(self.interface).rect.height
	local var_11_2 = rtf(self._parentTf).rect.width
	local var_11_3 = rtf(self._parentTf).rect.height
	local var_11_4 = var_11_0 / var_11_1 > var_11_2 / var_11_3 and var_11_1 / var_11_3 or var_11_0 / var_11_2

	return Vector3.New(var_11_4, var_11_4, 1)
end

function SettingsBattlePage:InitInterfaceComponent(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	local var_12_0 = rtf(self._parentTf).rect.width
	local var_12_1 = rtf(self._parentTf).rect.height
	local var_12_2 = var_12_0 * 0.5 + self.interface.localPosition.x + self.interface.parent.localPosition.x + self.interface.parent.parent.localPosition.x
	local var_12_3 = var_12_1 * 0.5 + self.interface.localPosition.y + self.interface.parent.localPosition.y + self.interface.parent.parent.localPosition.y
	local var_12_4
	local var_12_5
	local var_12_6
	local var_12_7

	arg_12_2:AddBeginDragFunc(function(arg_13_0, arg_13_1)
		self._currentDrag = arg_12_2
		var_12_6 = var_12_0 / UnityEngine.Screen.width
		var_12_7 = var_12_1 / UnityEngine.Screen.height
		var_12_4 = arg_12_1.localPosition.x
		var_12_5 = arg_12_1.localPosition.y

		return
	end)
	arg_12_2:AddDragFunc(function(arg_14_0, arg_14_1)
		arg_12_1.localPosition = Vector3(arg_14_1.position.x * var_12_6 - var_12_2, arg_14_1.position.y * var_12_7 - var_12_3, 0)

		self:CheckInterfaceIntersect()

		return
	end)
	arg_12_2:AddDragEndFunc(function(arg_15_0, arg_15_1)
		self._currentDrag = nil

		if self:CheckInterfaceIntersect() then
			arg_12_1.localPosition = Vector3(var_12_4, var_12_5, 0)
		end

		self:CheckInterfaceIntersect()

		return
	end)
	self:SetInterfaceAnchor(arg_12_1, arg_12_3, arg_12_4, arg_12_5)

	return
end

function SettingsBattlePage:EditModeEnabled(arg_16_1)
	setActive(self.normalBtns, not arg_16_1)
	setActive(self.mask, not arg_16_1)
	setActive(self.editBtns, arg_16_1)

	for iter_16_0, iter_16_1 in ipairs(self.components) do
		setActive(findTF(iter_16_1, "rect"), arg_16_1)

		if iter_16_0 > 1 then
			GetOrAddComponent(iter_16_1, "EventTriggerListener").enabled = arg_16_1
		end
	end

	Input.multiTouchEnabled = not arg_16_1
	self.topLayerCg.blocksRaycasts = not arg_16_1

	return
end

function SettingsBattlePage:SetInterfaceAnchor(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0
	local var_17_1

	if arg_17_5 then
		var_17_0 = arg_17_4.x
		var_17_1 = arg_17_4.y
	else
		var_17_0 = PlayerPrefs.GetFloat(arg_17_2, arg_17_4.x)
		var_17_1 = PlayerPrefs.GetFloat(arg_17_3, arg_17_4.y)
	end

	arg_17_1.localPosition = Vector3((var_17_0 - 0.5) * rtf(self.interface).rect.width, (var_17_1 - 0.5) * rtf(self.interface).rect.height, 0)

	return
end

local function var_0_11(arg_18_0)
	local var_18_0 = rtf(arg_18_0)

	return UnityEngine.Rect.New(var_18_0.position.x - var_18_0.rect.width * var_18_0.lossyScale.x / 2, var_18_0.position.y - var_18_0.rect.height * var_18_0.lossyScale.y / 2, var_18_0.rect.width * var_18_0.lossyScale.x, var_18_0.rect.height * var_18_0.lossyScale.y)
end

function SettingsBattlePage:CheckInterfaceIntersect()
	local var_19_0 = {}
	local var_19_1 = false
	local var_19_2 = {}
	local var_19_3 = var_0_11(self.interface)

	for iter_19_0, iter_19_1 in ipairs(self.components) do
		var_19_2[iter_19_1] = var_0_11(iter_19_1:Find("rect"))
	end

	for iter_19_2, iter_19_3 in ipairs(self.components) do
		for iter_19_4, iter_19_5 in ipairs(self.components) do
			if iter_19_3 ~= iter_19_5 and var_19_2[iter_19_3]:Overlaps(var_19_2[iter_19_5]) then
				var_19_0[iter_19_5] = true
			end
		end

		if iter_19_2 > 1 then
			if not var_19_3:Contains((Vector2.New(var_19_2[iter_19_3].xMin, var_19_2[iter_19_3].yMin))) or not var_19_3:Contains((Vector2.New(var_19_2[iter_19_3].xMax, var_19_2[iter_19_3].yMax))) then
				var_19_0[iter_19_3] = true
			end
		end
	end

	for iter_19_6, iter_19_7 in ipairs(self.components) do
		local var_19_4 = findTF(iter_19_7, "rect"):GetComponent(typeof(Image))

		if var_19_0[iter_19_7] then
			var_19_4.color = SettingsBattlePage.CLD_RED
			var_19_1 = true
		else
			var_19_4.color = SettingsBattlePage.DEFAULT_GREY
		end
	end

	return var_19_1
end

function SettingsBattlePage:RevertInterfaceSetting(arg_20_1)
	self:SetInterfaceAnchor(self.stick, var_0_1, var_0_2, ys.Battle.BattleConfig.JOY_STICK_DEFAULT_PREFERENCE, arg_20_1)
	self:SetInterfaceAnchor(self.skillBtn1, var_0_3, var_0_4, ys.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE[1], arg_20_1)
	self:SetInterfaceAnchor(self.skillBtn2, var_0_5, var_0_6, ys.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE[2], arg_20_1)
	self:SetInterfaceAnchor(self.skillBtn3, var_0_7, var_0_8, ys.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE[3], arg_20_1)
	self:SetInterfaceAnchor(self.skillBtn4, var_0_9, var_0_10, ys.Battle.BattleConfig.SKILL_BUTTON_DEFAULT_PREFERENCE[4], arg_20_1)
	self:SaveInterfaceSetting()

	return
end

function SettingsBattlePage:SaveInterfaceSetting()
	self:OverrideInterfaceSetting(self.stick, var_0_1, var_0_2)
	self:OverrideInterfaceSetting(self.skillBtn1, var_0_3, var_0_4)
	self:OverrideInterfaceSetting(self.skillBtn2, var_0_5, var_0_6)
	self:OverrideInterfaceSetting(self.skillBtn3, var_0_7, var_0_8)
	self:OverrideInterfaceSetting(self.skillBtn4, var_0_9, var_0_10)

	return
end

function SettingsBattlePage:OverrideInterfaceSetting(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = rtf(self.interface).rect.width
	local var_22_1 = rtf(self.interface).rect.height

	PlayerPrefs.SetFloat(arg_22_2, (arg_22_1.localPosition.x + var_22_0 * 0.5) / var_22_0)
	PlayerPrefs.SetFloat(arg_22_3, (arg_22_1.localPosition.y + var_22_1 * 0.5) / var_22_1)

	return
end

function SettingsBattlePage:OnDestroy()
	ClearEventTrigger(self.eventStick)
	ClearEventTrigger(self.eventSkillBtn1)
	ClearEventTrigger(self.eventSkillBtn2)
	ClearEventTrigger(self.eventSkillBtn3)
	ClearEventTrigger(self.eventSkillBtn4)

	Input.multiTouchEnabled = true

	return
end

function SettingsBattlePage:Show()
	self.cg.blocksRaycasts = true
	self.cg.alpha = 1

	return
end

function SettingsBattlePage:Hide()
	self.cg.blocksRaycasts = false
	self.cg.alpha = 0

	return
end

return SettingsBattlePage
