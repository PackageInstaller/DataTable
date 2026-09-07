local SSSSMainPage = class("SSSSMainPage", import(".TemplatePage.PreviewTemplatePage"))
local var_0_1 = 0.45
local var_0_2 = 0.2
local var_0_3 = 1.2
local var_0_4 = "event:/ui/kaiji"

function SSSSMainPage:OnInit()
	SSSSMainPage.super.OnInit(self)

	self.effectBlankScreen = self.bg:Find("blank_screen_effect")
	self.effectOpen = self.bg:Find("open_effect")
	self.effectBlink = self.bg:Find("blink_effect")
	self.effectClick = self.bg:Find("click_effect")

	return
end

function SSSSMainPage:OnFirstFlush()
	self.skinshopBtn = self.btnList:Find("skinshop")

	onButton(self, self.skinshopBtn, function()
		self:PlayClickEffect(self.skinshopBtn, function()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

			return
		end)

		return
	end, SFX_PANEL)

	self.mountainBtn = self.btnList:Find("mountain")

	onButton(self, self.mountainBtn, function()
		self:PlayClickEffect(self.mountainBtn, function()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SSSS_ACADEMY)

			return
		end)

		return
	end, SFX_PANEL)

	self.buildBtn = self.btnList:Find("build")

	onButton(self, self.buildBtn, function()
		self:PlayClickEffect(self.buildBtn, function()
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
				projectName = BuildShipScene.PROJECTS.ACTIVITY
			})

			return
		end)

		return
	end, SFX_PANEL)

	self.shopBtn = self.btnList:Find("shop")

	onButton(self, self.shopBtn, function()
		self:PlayClickEffect(self.shopBtn, function()
			local var_10_0

			if configClinet.shopLinkActID then
				var_10_0 = getProxy(ActivityProxy):getActivitiesById(configClinet.shopLinkActID) or underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_11_0)
					return not arg_11_0:isEnd()
				end)

				if not var_10_0 or var_10_0:isEnd() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end
			end

			self:emit(ActivityMediator.GO_SHOPS_LAYER, {
				warp = NewShopsScene.TYPE_ACTIVITY,
				actId = var_10_0.id
			})

			return
		end)

		return
	end, SFX_PANEL)

	self.fightBtn = self.btnList:Find("fight")

	onButton(self, self.fightBtn, function()
		self:PlayClickEffect(self.fightBtn, function()
			self:emit(ActivityMediator.BATTLE_OPERA)

			return
		end)

		return
	end, SFX_PANEL)
	self:PlayOpenEffect()

	return
end

function SSSSMainPage:PlayOpenEffect()
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

function SSSSMainPage:PlayClickEffect(arg_18_1, arg_18_2)
	local var_18_0 = pg.UIMgr.GetInstance().OverlayEffect
	local var_18_1 = var_18_0:GetChild(0)
	local var_18_2 = var_18_1 and var_18_1.localPosition:Sub((Vector3(192, 60, 0))) or arg_18_1.localPosition

	setLocalPosition(self.effectClick, var_18_0)
	setActive(self.effectClick, true)
	self:managedTween(LeanTween.delayedCall, function()
		setActive(self.effectClick, false)

		if arg_18_2 then
			arg_18_2()
		end

		return
	end, 0.3, nil)

	return
end

function SSSSMainPage:OnDestroy()
	self:cleanManagedTween()

	return
end

return SSSSMainPage
