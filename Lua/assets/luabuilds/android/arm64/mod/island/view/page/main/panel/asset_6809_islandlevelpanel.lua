local IslandLevelPanel = class("IslandLevelPanel", import("view.base.BaseSubView"))

function IslandLevelPanel:getUIName()
	return "IslandLevelPanel"
end

function IslandLevelPanel:OnLoaded()
	self.levelPanel = self._tf:Find("level_panel")
	self.levelTxt = self.levelPanel:Find("level"):GetComponent(typeof(Text))
	self.nameTxt = self.levelPanel:Find("name"):GetComponent(typeof(Text))
	self.expTr = self.levelPanel:Find("exp")
	self.prosperityTxt = self.levelPanel:Find("prosperity/Text"):GetComponent(typeof(Text))
	self.prosperityLabel = self.levelPanel:Find("prosperity"):GetComponent(typeof(Text))
	self.levelTip = self.levelPanel:Find("red_dot")

	setActive(self.levelPanel:Find("edit"), false)

	self.expBtn = self.levelPanel:Find("level")
	self.expPanel = self._tf:Find("exp")

	setActive(self.expPanel, false)

	self.expPanelTxt = self.expPanel:Find("Text"):GetComponent(typeof(Text))
	self.expPanelAddTF = self.expPanel:Find("add")
	self.expAnimation = self.expPanel:GetComponent(typeof(Animation))

	return
end

function IslandLevelPanel:OnInit()
	onButton(self, self.nameTxt.gameObject, function()
		self:emit(IslandMediator.OPEN_PAGE, "IslandSelfCardPage")

		return
	end, SFX_PANEL)
	onButton(self, self.expBtn, function()
		self:ShowExp()

		return
	end, SFX_PANEL)

	return
end

function IslandLevelPanel:Show()
	IslandLevelPanel.super.Show(self)
	self:UpdateIslandInfo()
	self:UpdateTip()

	return
end

function IslandLevelPanel:UpdateIslandInfo()
	local var_7_0 = getProxy(IslandProxy):GetIsland()

	self.levelTxt.text = var_7_0:GetLevel()
	self.nameTxt.text = var_7_0:GetName()

	if var_7_0:IsMaxLevel() then
		setFillAmount(self.expTr, 1)
	else
		setFillAmount(self.expTr, var_7_0:GetExp() / var_7_0:GetTargeExp())
	end

	self.prosperityTxt.text = var_7_0:CanAddProsperity() and var_7_0:GetProsperity() .. "/" .. var_7_0:GetTargetProsperity() or "MAX"
	self.prosperityLabel.text = i18n("island_prosperity_level")

	return
end

function IslandLevelPanel:UpdateTip()
	setActive(self.levelTip, getProxy(IslandProxy):ShouldTip())

	return
end

function IslandLevelPanel:ShowExp()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	local var_9_0 = getProxy(IslandProxy):GetIsland()

	self.expPanelTxt.text = "<color=#39bfff>" .. var_9_0:GetExp() .. "</color><color=#ffffff>/" .. var_9_0:GetTargeExp() .. "</color>"

	setActive(self.expPanel:Find("effect"), false)
	setActive(self.expPanelAddTF, false)
	setActive(self.expPanel, true)
	self.expAnimation:Play("anim_IslandUI_Exp_In")

	self.timer = Timer.New(function()
		self.expAnimation:Play("anim_IslandUI_Exp_Out")

		return
	end, 5, 1)

	self.timer:Start()

	return
end

function IslandLevelPanel:ShowExpAdd(arg_11_1, arg_11_2)
	onDelayTick(function()
		existCall(arg_11_2)

		return
	end, 0.5)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	local var_11_0 = getProxy(IslandProxy):GetIsland()

	self.expPanelTxt.text = "<color=#39bfff>" .. var_11_0:GetExp() .. "</color><color=#ffffff>/" .. var_11_0:GetTargeExp() .. "</color>"

	setActive(self.expPanel:Find("effect"), true)
	setActive(self.expPanelAddTF, true)
	setText(self.expPanelAddTF, "+" .. arg_11_1)
	setActive(self.expPanel, true)
	self.expAnimation:Play("anim_IslandUI_Exp_In")

	self.timer = Timer.New(function()
		self.expAnimation:Play("anim_IslandUI_Exp_Out")

		return
	end, 3, 1)

	self.timer:Start()

	return
end

function IslandLevelPanel:OnDestroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

return IslandLevelPanel
