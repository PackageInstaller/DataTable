local IslandShipFirstDressupPage = class("IslandShipFirstDressupPage", import(".IslandBaseDressupPage"))

function IslandShipFirstDressupPage:getUIName()
	return "IslandCommanderMainUI"
end

function IslandShipFirstDressupPage:CanEsc()
	return false
end

function IslandShipFirstDressupPage:OnLoaded()
	self.leftPlane = self._tf:Find("adapt/left_panel")
	self.backBtn = self._tf:Find("adapt/left_panel/back")
	self.homeBtn = self._tf:Find("adapt/home")

	setText(self._tf:Find("adapt/left_panel/title/Text"), i18n("island_dressup_titile"))
	setActive(self.leftPlane, false)
	setActive(self.homeBtn, false)

	return
end

function IslandShipFirstDressupPage:AddListeners()
	self:AddListener(GAME.ISLAND_CHANGE_COMMANDER_DRESS_DONE, self.OnDressUpDone)

	return
end

function IslandShipFirstDressupPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_CHANGE_COMMANDER_DRESS_DONE, self.OnDressUpDone)

	return
end

function IslandShipFirstDressupPage:OnInit()
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

function IslandShipFirstDressupPage:Show(arg_11_1)
	self.callback = arg_11_1

	IslandShipFirstDressupPage.super.Show(self)
	self:Flush()

	self.shipDressHelper = IslandShipDressHelperNew.New()

	self.shipDressHelper:SetShipId(0)

	self.currentChildPage = self:OpenPage(IslandShipDressUpPageNew, 0, true, self.shipDressHelper)

	self:LoadCharacter({
		model = pg.island_unit_character[0].model,
		animator = pg.island_unit_character[0].animator
	})

	return
end

function IslandShipFirstDressupPage:Flush()
	return
end

function IslandShipFirstDressupPage:GetSmoothRotateObject()
	return self._tf:Find("adapt/char")
end

function IslandShipFirstDressupPage:OnCharLoaded()
	self.shipDressHelper:OnRoleLoaded(self.role.transform)

	return
end

function IslandShipFirstDressupPage:Hide()
	self.currentChildPage:Destroy()
	self.shipDressHelper:Destroy()
	IslandShipFirstDressupPage.super.Hide(self)

	return
end

function IslandShipFirstDressupPage:OnDressUpDone()
	self:Hide()
	self:ClearCharacterScene(self.callback)

	return
end

function IslandShipFirstDressupPage:CheckDressIsDirty()
	return self.currentChildPage:CheckDressIsDirty()
end

function IslandShipFirstDressupPage:OnDestroy()
	return
end

return IslandShipFirstDressupPage
