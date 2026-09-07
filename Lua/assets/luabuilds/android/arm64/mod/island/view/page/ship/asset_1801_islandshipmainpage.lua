local IslandShipMainPage = class("IslandShipMainPage", import(".IslandBaseShipDisplayPage"))

IslandShipMainPage.OPEN_PAGE = "IslandShipMainPage:OPEN_PAGE"
IslandShipMainPage.SELECT_SHIP = "IslandShipMainPage:SELECT_SHIP"
IslandShipMainPage.CLOSE_DOCK = "IslandShipMainPage:CLOSE_DOCK"
IslandShipMainPage.CLEAR_ITEM_ANIMATOR = "IslandShipMainPage:CLEAR_ITEM_ANIMATOR"
IslandShipMainPage.PAGE_DRESS = 1
IslandShipMainPage.PAGE_INFO = 2
IslandShipMainPage.PAGE_STATUS = 3
IslandShipMainPage.PAGE_PROFILE = 4

function IslandShipMainPage:getUIName()
	return "IslandShipMainUI"
end

function IslandShipMainPage:OnLoaded()
	self.backBtn = self._tf:Find("top/back")
	self.homeBtn = self._tf:Find("top/home")
	self.leftPanel = self._tf:Find("adapt/left_panel")
	self.dockBtn = self._tf:Find("adapt/left_panel/dock_btn")
	self.togglePanel = self._tf:Find("top/toggles")
	self.shipRect = self._tf:Find("adapt/left_panel/ships"):GetComponent("LScrollRect")
	self.shipContainer = self._tf:Find("adapt/left_panel/ships/content")

	function self.shipRect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.shipRect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	self.toggles = {
		[IslandShipMainPage.PAGE_INFO] = self._tf:Find("top/toggles/info"),
		[IslandShipMainPage.PAGE_DRESS] = self._tf:Find("top/toggles/dress"),
		[IslandShipMainPage.PAGE_STATUS] = self._tf:Find("top/toggles/gift"),
		[IslandShipMainPage.PAGE_PROFILE] = self._tf:Find("topapt/toggles/data")
	}
	self.pages = {
		[IslandShipMainPage.PAGE_INFO] = IslandShipInfoPage,
		[IslandShipMainPage.PAGE_DRESS] = IslandShipDressUpPageNew,
		[IslandShipMainPage.PAGE_STATUS] = IslandShipStatusPage,
		[IslandShipMainPage.PAGE_PROFILE] = IslandShipProfilePage
	}
	self.cards = {}

	setActive(self.togglePanel, true)
	setText(self._tf:Find("top/title/Text"), i18n("island_chara_totalname"))
	setText(self._tf:Find("top/title/Text/en"), i18n("island_chara_totalname_en"))

	return
end

function IslandShipMainPage:GetSmoothRotateObject()
	return self._tf:Find("adapt/char")
end

function IslandShipMainPage:AddListeners()
	self:AddListener(IslandShipMainPage.CLOSE_DOCK, self.OnCloseDock)
	self:AddListener(IslandShipMainPage.OPEN_PAGE, self.OnTriggerPage)
	self:AddListener(IslandShipMainPage.SELECT_SHIP, self.OnSelectShip)
	self:AddListener(IslandCharacterAgency.ADD_SHIP, self.OnAddShip)
	self:AddListener(GAME.ISLAND_UPGRADE_SKILL_DONE, self.OnSkillUpgrade)
	self:AddListener(IslandShipMainPage.CLEAR_ITEM_ANIMATOR, self.OnClearItemAnimator)

	return
end

function IslandShipMainPage:RemoveListeners()
	self:RemoveListener(IslandShipMainPage.CLOSE_DOCK, self.OnCloseDock)
	self:RemoveListener(IslandShipMainPage.OPEN_PAGE, self.OnTriggerPage)
	self:RemoveListener(IslandShipMainPage.SELECT_SHIP, self.OnSelectShip)
	self:RemoveListener(IslandCharacterAgency.ADD_SHIP, self.OnAddShip)
	self:RemoveListener(GAME.ISLAND_UPGRADE_SKILL_DONE, self.OnSkillUpgrade)
	self:RemoveListener(IslandShipMainPage.CLEAR_ITEM_ANIMATOR, self.OnClearItemAnimator)

	return
end

function IslandShipMainPage:OnCloseDock()
	self:SetVisible(self.leftPanel, true)

	return
end

function IslandShipMainPage:OnSkillUpgrade()
	for iter_9_0, iter_9_1 in pairs(self.cards) do
		iter_9_1:FlushRedDot()
	end

	return
end

function IslandShipMainPage:OnGotExtra()
	if not self.contextData.selectedId then
		return
	end

	self:FlushExtraAward((getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(self.contextData.selectedId)))

	return
end

function IslandShipMainPage:OnAddShip()
	self:Flush()

	if not self.contextData.selectedId then
		-- block empty
	end

	return
end

function IslandShipMainPage:OnSelectShip(arg_12_1)
	self:ClickCard(getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_12_1), arg_12_1)

	return
end

function IslandShipMainPage:OnTriggerPage(arg_13_1)
	self:TriggerPage(arg_13_1)

	return
end

function IslandShipMainPage:OnInit()
	onButton(self, self._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_character_info.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.homeBtn, function()
		self:OnHome()

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		if self.childPage then
			self.childPage:CheckInReturn(function()
				self:Hide()

				self.childPage = nil

				return
			end)
		else
			self:Hide()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.dockBtn, function()
		self:OpenPage(IslandDockPage, self:GetNeedHideUnlockShipFlag())
		self:SetVisible(self.leftPanel, false)

		return
	end, SFX_PANEL)

	for iter_14_0, iter_14_1 in ipairs(self.toggles) do
		onToggle(self, iter_14_1, function(arg_20_0)
			if arg_20_0 then
				if self.childPage then
					self.childPage:CheckInReturn(function()
						self:SwitchPage(iter_14_0)

						return
					end)
				else
					self:SwitchPage(iter_14_0)
				end
			end

			return
		end, SFX_PANEL)
	end

	return
end

function IslandShipMainPage:SwitchPage(arg_22_1)
	if not self.contextData.selectedId then
		return
	end

	if self.page then
		self:ClosePage(self.page)

		self.page = nil
	end

	local var_22_0 = self.pages[arg_22_1]

	if arg_22_1 == 1 then
		self.childPage = self:OpenPage(var_22_0, self.contextData.selectedId, false, self.shipDressHelper, function(arg_23_0)
			self:SetObjInitRotaion(arg_23_0)

			return
		end)
	else
		self:OpenPage(var_22_0, self.contextData.selectedId)

		self.childPage = nil
	end

	self.page = var_22_0

	return
end

function IslandShipMainPage:TriggerPage(arg_24_1)
	triggerToggle(self.toggles[arg_24_1], true)

	return
end

function IslandShipMainPage:Show()
	IslandShipMainPage.super.Show(self)
	self:Flush()
	setActive(self.togglePanel, true)

	return
end

function IslandShipMainPage:Flush()
	self:FlushShips((getProxy(IslandProxy):GetIsland():GetCharacterAgency()))
	self:ActiveDefaultCard()

	return
end

function IslandShipMainPage:ActiveDefaultCard()
	if self.contextData.selectedId then
		self.contextData.selectedId = nil

		self:UpdateMainView((getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(self.contextData.selectedId)))
		setActive(self.togglePanel, true)
	end

	return
end

function IslandShipMainPage:OnInitItem(arg_28_1)
	local var_28_0 = IslandMiniShipCard.New(arg_28_1)

	onButton(self, var_28_0.go, function()
		if self.childPage then
			self.childPage:CheckInReturn(function()
				self.childPage = nil

				self:ClickCard(var_28_0.ship, var_28_0.configId)

				return
			end)
		else
			self:ClickCard(var_28_0.ship, var_28_0.configId)
		end

		return
	end, SFX_PANEL)

	self.cards[arg_28_1] = var_28_0

	return
end

function IslandShipMainPage:ClickCard(arg_31_1, arg_31_2)
	if arg_31_1 then
		self:ClearSelected(self.contextData.selectedId)
		self:UpdateMainView(arg_31_1)
		self:MarkSelected(arg_31_2)
	else
		self:UpdateUnlockView(arg_31_2)
	end

	return
end

function IslandShipMainPage:ClearSelected(arg_32_1)
	for iter_32_0, iter_32_1 in pairs(self.cards) do
		if iter_32_1.configId == arg_32_1 then
			iter_32_1:UpdateSelected(nil)

			break
		end
	end

	return
end

function IslandShipMainPage:MarkSelected(arg_33_1)
	for iter_33_0, iter_33_1 in pairs(self.cards) do
		if iter_33_1.configId == arg_33_1 then
			iter_33_1:UpdateSelected(iter_33_1.configId)

			break
		end
	end

	return
end

function IslandShipMainPage:OnUpdateItem(arg_34_1, arg_34_2)
	local var_34_0 = self.cards[arg_34_2]

	if not self.cards[arg_34_2] then
		self:OnInitItem(arg_34_2)

		var_34_0 = self.cards[arg_34_2]
	end

	local var_34_1 = self.displays[arg_34_1 + 1]

	if not self.displays[arg_34_1 + 1] then
		return
	end

	var_34_0:Update(var_34_1, self.contextData.selectedId)

	return
end

function IslandShipMainPage:FlushShips(arg_35_1)
	self.displays = {}
	self.displays = arg_35_1:GetUnlockOrCanUnlockShipConfigIds()

	local var_35_0

	if #self.displays > 0 then
		var_35_0 = arg_35_1:GetShipById(self.displays[1])
	end

	self.contextData.selectedId = self.contextData.selectedId or var_35_0 and var_35_0.configId

	self.shipRect:SetTotalCount(#self.displays)

	return
end

function IslandShipMainPage:CalcShipLayout()
	if self.shipContainer.rect.height < self.shipRect.gameObject.transform.rect.height then
		self.shipRect.gameObject.transform.offsetMax = Vector2(self.shipRect.gameObject.transform.offsetMax.x, -((self._tf.rect.height - self.shipContainer.rect.height) * 0.5))
		self.shipRect.gameObject.transform.offsetMin = Vector2(self.shipRect.gameObject.transform.offsetMin.x, (self._tf.rect.height - self.shipContainer.rect.height) * 0.5)
	end

	return
end

function IslandShipMainPage:UpdateMainView(arg_37_1)
	if self.contextData.selectedId == arg_37_1.configId then
		return
	end

	self.shipDressHelper = self.shipDressHelper or IslandShipDressHelperNew.New()

	self.shipDressHelper:SetShipId(arg_37_1.configId)
	self:LoadCharacter(arg_37_1:GetModel())

	self.contextData.selectedId = arg_37_1.configId

	self:TriggerPage(IslandShipMainPage.PAGE_INFO)

	return
end

function IslandShipMainPage:UpdateUnlockView(arg_38_1)
	self:ShowMsgBox({
		content = i18n("island_open_ship_tip"),
		onYes = function()
			self:Hide()
			self:emit(IslandBaseMediator.SWITCH_MAP, IslandConst.LABORATORY_MAP_ID, IslandConst.LETTEROFINVITATION_SP)

			return
		end
	})

	return
end

function IslandShipMainPage:OnDestroy()
	IslandShipMainPage.super.OnDestroy(self)
	ClearLScrollrect(self.shipRect)

	for iter_40_0, iter_40_1 in pairs(self.cards or {}) do
		iter_40_1:Dispose()
	end

	self.cards = nil

	if self.timer then
		self.timer:Stop()
	end

	if self.shipDressHelper then
		self.shipDressHelper:Destroy()
	end

	return
end

function IslandShipMainPage:OnHide()
	if self.shipDressHelper then
		self.shipDressHelper:Destroy()
	end

	return
end

function IslandShipMainPage:CanEsc()
	if self.childPage then
		self.childPage:CheckInReturn(function()
			self:Hide()

			self.childPage = nil

			return
		end)

		return false
	else
		return true
	end

	return
end

function IslandShipMainPage:OnCharLoaded(arg_44_1)
	if self.shipDressHelper then
		self.shipDressHelper:OnRoleLoaded(self.role.transform, arg_44_1)
	end

	return
end

function IslandShipMainPage:SetObjInitRotaion(arg_45_1)
	local var_45_0 = GetOrAddComponent(self:GetSmoothRotateObject(), typeof(SmoothRotateObject))

	var_45_0.rotationSpeed = 5

	ReflectionHelp.RefSetProperty(typeof(SmoothRotateObject), "targetRotation", var_45_0, arg_45_1)

	if self.timer then
		self.timer:Stop()
	end

	self.timer = Timer.New(function()
		var_45_0.rotationSpeed = pg.island_set.character_detail_camera_speed.key_value_int

		return
	end, 0.5, 1)

	self.timer:Start()

	return
end

function IslandShipMainPage:GetNeedHideUnlockShipFlag()
	return false
end

return IslandShipMainPage
