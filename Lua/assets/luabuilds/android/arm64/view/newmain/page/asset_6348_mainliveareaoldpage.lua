local MainLiveAreaOldPage = class("MainLiveAreaOldPage", import("view.base.BaseSubView"))

function MainLiveAreaOldPage:getUIName()
	return "MainLiveAreaOldUI"
end

function MainLiveAreaOldPage:OnLoaded()
	self._academyBtn = self._tf:Find("school_btn")
	self._haremBtn = self._tf:Find("backyard_btn")
	self._commanderBtn = self._tf:Find("commander_btn")

	local var_2_0 = pg.EasyRedDotMgr.GetInstance()

	self._haremTip = self._haremBtn:Find("tip")
	self._academyTip = self._academyBtn:Find("tip")
	self._commanderTip = self._commanderBtn:Find("tip")

	var_2_0:RegisterRedDot(self._haremTip, {
		"COURTYARD"
	}, function(arg_3_0)
		setActive(arg_3_0, getProxy(DormProxy):IsShowRedDot())

		return
	end)
	var_2_0:RegisterRedDot(self._academyTip, {
		"SCHOOL"
	}, function(arg_4_0)
		setActive(arg_4_0, getProxy(NavalAcademyProxy):IsShowTip())

		return
	end)
	var_2_0:RegisterRedDot(self._commanderTip, {
		"COMMANDER"
	}, function(arg_5_0)
		if getProxy(PlayerProxy):getRawData().level < 40 then
			setActive(arg_5_0, false)

			return
		end

		local var_5_0 = getProxy(CommanderProxy):IsFinishAllBox()

		if not LOCK_CATTERY then
			local var_5_1

			if not var_5_0 then
				::label_5_0::

				var_5_1 = getProxy(CommanderProxy):AnyCatteryExistOP()
				var_5_1 = var_5_1 or getProxy(CommanderProxy):AnyCatteryCanUse()
			end

			setActive(arg_5_0, var_5_1)
		else
			setActive(arg_5_0, var_5_0)
		end

		return
	end)

	return
end

function MainLiveAreaOldPage:OnInit()
	onButton(self, self._commanderBtn, function()
		self:emit(NewMainMediator.GO_SCENE, SCENE.COMMANDERCAT, {
			fromMain = true,
			fleetType = CommanderCatScene.FLEET_TYPE_COMMON
		})
		self:Hide()

		return
	end, SFX_MAIN)
	onButton(self, self._haremBtn, function()
		self:emit(NewMainMediator.GO_SCENE, SCENE.COURTYARD)
		self:Hide()

		return
	end, SFX_MAIN)
	onButton(self, self._academyBtn, function()
		self:emit(NewMainMediator.GO_SCENE, SCENE.NAVALACADEMYSCENE)
		self:Hide()

		return
	end, SFX_MAIN)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function MainLiveAreaOldPage:Show()
	MainLiveAreaOldPage.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		staticBlur = true
	})

	local var_11_0 = getProxy(PlayerProxy):getRawData()

	self._commanderBtn:GetComponent(typeof(Image)).color = not pg.SystemOpenMgr.GetInstance():isOpenSystem(var_11_0.level, "CommanderCatMediator") and Color(0.3, 0.3, 0.3, 1) or Color(1, 1, 1, 1)
	self._haremBtn:GetComponent(typeof(Image)).color = not pg.SystemOpenMgr.GetInstance():isOpenSystem(var_11_0.level, "CourtYardMediator") and Color(0.3, 0.3, 0.3, 1) or Color(1, 1, 1, 1)

	return
end

function MainLiveAreaOldPage:Hide()
	if self:isShowing() then
		MainLiveAreaOldPage.super.Hide(self)
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	end

	return
end

function MainLiveAreaOldPage:OnDestroy()
	local var_13_0 = pg.EasyRedDotMgr.GetInstance()

	var_13_0:UnRegisterRedDot(self._haremTip)
	var_13_0:UnRegisterRedDot(self._academyTip)
	var_13_0:UnRegisterRedDot(self._commanderTip)
	self:Hide()

	return
end

return MainLiveAreaOldPage
