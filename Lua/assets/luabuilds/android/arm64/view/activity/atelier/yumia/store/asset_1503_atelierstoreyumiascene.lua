local AtelierStoreYumiaScene = class("AtelierStoreYumiaScene", import("view.activity.Atelier.Store.AtelierStoreBaseScene"))

function AtelierStoreYumiaScene:getUIName()
	return "AtelierStoreYumiaUI"
end

function AtelierStoreYumiaScene:InitCustom()
	setText(self._tf:Find("Window/Text"), i18n("yumia_atelier_tip13"))
	setText(self._tf:Find("Window/textBg/Name"), i18n("yumia_atelier_tip16"))

	return
end

function AtelierStoreYumiaScene:didEnter()
	self.activity = self.contextData.activity

	onButton(self, self._tf:Find("Window/textBg/closeBtn"), function()
		self:PlayCloseAni()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("BG"), function()
		self:PlayCloseAni()

		return
	end, SFX_CANCEL)
	self:ShowStoreHouseWindow()

	return
end

function AtelierStoreYumiaScene:PlayCloseAni()
	local var_6_0 = GetComponent(self._tf, typeof(Animation))

	var_6_0:Play("Anim_AtelierStoreYumiaUI_Out")
	pg.UIMgr.GetInstance():LoadingOn(false)

	self.closeTimer = FrameTimer.New(function()
		if not var_6_0:IsPlaying("Anim_AtelierStoreYumiaUI_Out") then
			self:StopCloseTimer()
			pg.UIMgr.GetInstance():LoadingOff()
			self:closeView()
		end

		return
	end, 1, -1)

	self.closeTimer:Start()

	return
end

function AtelierStoreYumiaScene:StopCloseTimer()
	if self.closeTimer then
		self.closeTimer:Stop()

		self.closeTimer = nil
	end

	return
end

function AtelierStoreYumiaScene:ShowStoreHouseWindow()
	local var_9_0 = self.contextData.versionIndex or 2

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	local var_9_1 = _.filter(_.values(self.activity:GetItems()), function(arg_10_0)
		return arg_10_0.count > 0 and arg_10_0:GetVersion() == var_9_0 and arg_10_0:IsShow() ~= 0
	end)

	table.sort(var_9_1, function(arg_11_0, arg_11_1)
		return arg_11_0:GetConfigID() < arg_11_1:GetConfigID()
	end)
	setActive(self._tf:Find("Window/Empty"), #var_9_1 == 0)
	setActive(self._tf:Find("Window/ScrollView"), #var_9_1 > 0)

	if #var_9_1 == 0 then
		return
	end

	function self.storehouseRect.onUpdateItem(arg_12_0, arg_12_1)
		arg_12_0 = arg_12_0 + 1

		local var_12_0 = tf(arg_12_1)
		local var_12_1 = var_9_1[arg_12_0]

		self:UpdateRyzaItem(var_12_0, var_9_1[arg_12_0])
		onButton(self, var_12_0, function()
			self:ShowItemDetail(var_12_1)

			return
		end, SFX_PANEL)

		return
	end

	self.storehouseRect:SetTotalCount(#var_9_1)
	self:AddTimer(#var_9_1)

	return
end

function AtelierStoreYumiaScene:UpdateRyzaItem(arg_14_1, arg_14_2)
	AtelierTools.UpdateYumiaItem(arg_14_1, arg_14_2)

	return
end

function AtelierStoreYumiaScene:ShowItemDetail(arg_15_1)
	self:emit(AtelierMaterialDetailMediator.SHOW_DETAIL, arg_15_1)

	return
end

function AtelierStoreYumiaScene:AddTimer(arg_16_1)
	local var_16_1 = self._tf:Find("Window/ScrollView/Viewport/Content")

	self.timer = FrameTimer.New(function()
		if math.min(var_16_1.childCount, 15) <= arg_16_1 then
			self:StopTimer()
			self:AddTimer2()
		end

		return
	end, 1, -1)

	self.timer:Start()

	return
end

function AtelierStoreYumiaScene:AddTimer2()
	local var_18_0 = self._tf:Find("Window/ScrollView/Viewport/Content")
	local var_18_1 = var_18_0.childCount

	SetComponentEnabled(self._tf:Find("Window/ScrollView"), "LScrollRect", false)

	for iter_18_0 = 0, var_18_0.childCount - 1 do
		SetComponentEnabled(var_18_0:GetChild(iter_18_0), typeof(Animation), false)

		GetComponent(var_18_0:GetChild(iter_18_0), typeof(CanvasGroup)).alpha = 0
	end

	local var_18_2 = 0

	self.timer = Timer.New(function()
		if var_18_2 >= var_18_1 then
			self:StopTimer()
			SetComponentEnabled(self._tf:Find("Window/ScrollView"), "LScrollRect", true)

			return
		end

		local var_19_0 = GetComponent(var_18_0:GetChild(var_18_2), typeof(Animation))

		var_19_0.enabled = true

		var_19_0:Stop()
		var_19_0:Play("Anim_AtelierStoreYumiaUI_Tpl_In")

		var_18_2 = var_18_2 + 1

		return
	end, 0.08, -1)

	self.timer:Start()

	return
end

function AtelierStoreYumiaScene:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function AtelierStoreYumiaScene:willExit()
	self:StopTimer()
	AtelierStoreYumiaScene.super.willExit(self)

	return
end

return AtelierStoreYumiaScene
