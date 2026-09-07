local IslandShipIslandCommanderMainPage = class("IslandShipIslandCommanderMainPage", import(".IslandBaseShipDisplayPage"))

function IslandShipIslandCommanderMainPage:getUIName()
	return "IslandCommanderMainUI"
end

function IslandShipIslandCommanderMainPage:OnLoaded()
	self.backBtn = self._tf:Find("adapt/left_panel/back")
	self.homeBtn = self._tf:Find("adapt/home")

	setText(self._tf:Find("adapt/left_panel/title/Text"), i18n("island_dressup_titile"))
	setActive(self.homeBtn, false)

	return
end

function IslandShipIslandCommanderMainPage:AddListeners()
	return
end

function IslandShipIslandCommanderMainPage:RemoveListeners()
	return
end

function IslandShipIslandCommanderMainPage:OnInit()
	onButton(self, self.homeBtn, function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		if self:CheckDressIsDirty() then
			self:ShowMsgBox({
				type = IslandMsgBox.TYPE_COMMON,
				content = i18n("island_dressup_tip_1"),
				onYes = function()
					self.currentChildPage:SaveDressUpData()
					self:Hide()

					return
				end,
				onNo = function()
					self:Hide()

					return
				end
			})
		else
			self:Hide()
		end

		return
	end, SFX_PANEL)

	return
end

function IslandShipIslandCommanderMainPage:Show()
	IslandShipIslandCommanderMainPage.super.Show(self)
	self:Flush()

	self.shipDressHelper = IslandShipDressHelperNew.New()

	self.shipDressHelper:SetShipId(0)
	self:LoadCharacter({
		model = pg.island_unit_character[0].model,
		animator = pg.island_unit_character[0].animator
	}, true)

	self.currentChildPage = self:OpenPage(IslandShipDressUpPageNew, 0, false, self.shipDressHelper, function(arg_11_0)
		self:SetObjInitRotaion(arg_11_0)

		return
	end)

	return
end

function IslandShipIslandCommanderMainPage:Flush()
	return
end

function IslandShipIslandCommanderMainPage:GetSmoothRotateObject()
	return self._tf:Find("adapt/char")
end

function IslandShipIslandCommanderMainPage:OnCharLoaded()
	self.shipDressHelper:OnRoleLoaded(self.role.transform)

	return
end

function IslandShipIslandCommanderMainPage:Hide()
	self.currentChildPage:Destroy()
	self.shipDressHelper:Destroy()
	IslandShipIslandCommanderMainPage.super.Hide(self)

	if self.timer then
		self.timer:Stop()
	end

	return
end

function IslandShipIslandCommanderMainPage:OnDestroy()
	return
end

function IslandShipIslandCommanderMainPage:SetObjInitRotaion(arg_17_1)
	local var_17_0 = GetOrAddComponent(self:GetSmoothRotateObject(), typeof(SmoothRotateObject))

	var_17_0.rotationSpeed = 5

	ReflectionHelp.RefSetProperty(typeof(SmoothRotateObject), "targetRotation", var_17_0, arg_17_1)

	if self.timer then
		self.timer:Stop()
	end

	self.timer = Timer.New(function()
		var_17_0.rotationSpeed = pg.island_set.character_detail_camera_speed.key_value_int

		return
	end, 0.5, 1)

	self.timer:Start()

	return
end

function IslandShipIslandCommanderMainPage:CheckDressIsDirty()
	return self.currentChildPage:CheckDressIsDirty()
end

function IslandShipIslandCommanderMainPage:CanEsc()
	if not self:CheckDressIsDirty() then
		return true
	end

	self:ShowMsgBox({
		type = IslandMsgBox.TYPE_COMMON,
		content = i18n("island_dressup_tip_1"),
		onYes = function()
			self.currentChildPage:SaveDressUpData()
			self:Hide()

			return
		end,
		onNo = function()
			self:Hide()

			return
		end
	})

	return
end

return IslandShipIslandCommanderMainPage
