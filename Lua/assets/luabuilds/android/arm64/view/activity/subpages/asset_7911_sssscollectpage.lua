local SSSSCollectPage = class("SSSSCollectPage", import(".TemplatePage.LinkCollectTemplatePage"))
local var_0_1 = 0.45
local var_0_2 = 0.2
local var_0_3 = 1.2
local var_0_4 = "event:/ui/kaiji"

function SSSSCollectPage:OnInit()
	SSSSCollectPage.super.OnInit(self)

	self.effectBlankScreen = self.bg:Find("blank_screen_effect")
	self.effectOpen = self.bg:Find("open_effect")
	self.effectBlink = self.bg:Find("blink_effect")
	self.effectClick = self.bg:Find("click_effect")

	return
end

function SSSSCollectPage:OnFirstFlush()
	SSSSCollectPage.super.OnFirstFlush(self)

	local var_2_0 = self.activity:getConfig("config_client")

	if self.furnitureThemeBtn and var_2_0.furniture_theme_link then
		removeOnButton(self.furnitureThemeBtn)
		onButton(self, self.furnitureThemeBtn, function()
			self:PlayClickEffect(self.furnitureThemeBtn, function()
				self:DoSkip(var_2_0.furniture_theme_link[1], var_2_0.furniture_theme_link[2])

				return
			end)

			return
		end, SFX_PANEL)
	end

	if self.medalBtn and var_2_0.medal_link then
		removeOnButton(self.medalBtn)
		onButton(self, self.medalBtn, function()
			self:PlayClickEffect(self.furnitureThemeBtn, function()
				self:DoSkip(var_2_0.medal_link[1], var_2_0.medal_link[2])

				return
			end)

			return
		end, SFX_PANEL)
	end

	self:PlayOpenEffect()

	return
end

function SSSSCollectPage:PlayOpenEffect()
	setActive(self.effectBlankScreen, true)
	setActive(self.effectOpen, false)
	self:managedTween(LeanTween.delayedCall, function()
		setActive(self.effectOpen, true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)

		return
	end, var_0_2, nil)
	self:managedTween(LeanTween.delayedCall, function()
		setActive(self.effectBlankScreen, false)

		return
	end, var_0_1, nil)
	self:managedTween(LeanTween.delayedCall, function()
		setActive(self.effectOpen, false)
		setActive(self.effectBlink, true)

		return
	end, var_0_2 + var_0_3, nil)

	return
end

function SSSSCollectPage:PlayClickEffect(arg_11_1, arg_11_2)
	local var_11_0 = pg.UIMgr.GetInstance().OverlayEffect
	local var_11_1 = var_11_0:GetChild(0)
	local var_11_2 = var_11_1 and var_11_1.localPosition:Sub((Vector3(192, 60, 0))) or arg_11_1.localPosition

	setLocalPosition(self.effectClick, var_11_0)
	setActive(self.effectClick, true)
	self:managedTween(LeanTween.delayedCall, function()
		setActive(self.effectClick, false)

		if arg_11_2 then
			arg_11_2()
		end

		return
	end, 0.3, nil)

	return
end

function SSSSCollectPage:OnDestroy()
	self:cleanManagedTween()

	return
end

return SSSSCollectPage
