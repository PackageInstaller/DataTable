local IslandTechnologyPage = class("IslandTechnologyPage", import("...base.IslandBasePage"))

function IslandTechnologyPage:getUIName()
	return "IslandTechnologyUI"
end

function IslandTechnologyPage:OnLoaded()
	self.rtTop = self._tf:Find("top")

	setText(self.rtTop:Find("title/Text"), i18n("island_technology_title"))

	self.centreToggleTF = self._tf:Find("adapt/types/1")
	self.centreTipTF = self.centreToggleTF:Find("tip")

	local var_2_0 = self._tf:Find("adapt/types/content")

	self.typeUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	local var_2_1 = self._tf:Find("adapt/pages")

	self.pages = {}

	local var_2_2 = setmetatable({
		onItemClick = function(arg_3_0, arg_3_1)
			self.detailPanel:ExecuteAction("Show", arg_3_0, arg_3_1)

			return
		end
	}, {
		__index = self.contextData
	})

	self.pages[IslandTechBelong.CENTRE] = IslandTechCentrePanel.New(var_2_1, self.event, var_2_2)

	for iter_2_0, iter_2_1 in ipairs(IslandTechBelong.COMMON_SHOW_TYPES) do
		self.pages[iter_2_1] = IslandTechTreePanel.New(var_2_1, self.event, setmetatable({
			type = iter_2_1
		}, {
			__index = var_2_2
		}))
	end

	self.quickPanel = IslandTechQuickPanel.New(self._tf, self.event, setmetatable({
		onGetAwardDone = function(arg_4_0)
			self:OpenPage(IslandTechAwardPage, arg_4_0)

			return
		end
	}, {
		__index = self.contextData
	}))

	self.quickPanel:RegisterView(self.viewComponent)

	self.detailPanel = IslandTechDetailPanel.New(self._tf, self.event, setmetatable({
		onSelecteShip = function(arg_5_0)
			self:OpenPage(IslandShipSelectPage, {
				needWorkSpeed = true,
				showType = IslandSelectShipCard.SHOW_TYPE.PlACE,
				attrType = pg.island_formula[arg_5_0].attribute,
				confirmFunc = function(self)
					self.detailPanel:ExecuteAction("OnShipSelected", self[1])

					return
				end,
				placeId = IslandProductConst.TechnologyPlaceId,
				energyCost = pg.island_formula[arg_5_0].stamina_cost
			})

			return
		end,
		onFinishImmd = function(arg_7_0)
			self:emit(IslandMediator.ON_FINISH_TECH_IMMD, arg_7_0, function()
				self:OpenPage(IslandTechAwardPage, arg_7_0)

				return
			end)

			return
		end,
		onGetAwardDone = function(arg_9_0)
			self:OpenPage(IslandTechAwardPage, arg_9_0)

			return
		end,
		openTicketPage = function(arg_10_0)
			self:OpenPage(IslandTicketUsePage, IslandUseTicketCommand.TYPES.APPOINT, arg_10_0)

			return
		end,
		ShowMsgBox = function(arg_11_0, arg_11_1)
			self:ShowMsgBox(arg_11_1)

			return
		end
	}, {
		__index = self.contextData
	}))

	self.detailPanel:RegisterView(self.viewComponent)

	return
end

function IslandTechnologyPage:OnInit()
	onButton(self, self.rtTop:Find("title/help"), function()
		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = i18n("island_helpbtn_technology")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.rtTop:Find("back"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.rtTop:Find("home"), function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	onToggle(self, self.centreToggleTF, function(arg_16_0)
		if arg_16_0 and self.curPage ~= IslandTechBelong.CENTRE then
			self.curPage = IslandTechBelong.CENTRE

			self:SwitchPage()
		end

		return
	end, SFX_PANEL)

	self.commonTypes = IslandTechBelong.COMMON_SHOW_TYPES

	self.typeUIList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventInit then
			self:InitTypeItem(arg_17_1, arg_17_2)
		elseif arg_17_0 == UIItemList.EventUpdate then
			self:UpdateTypeItem(arg_17_1, arg_17_2)
		end

		return
	end)

	return
end

function IslandTechnologyPage:AddListeners()
	self:AddListener(GAME.ISLAND_UNLOCK_TECH_DONE, self.Flush)
	self:AddListener(GAME.ISLAND_START_DELEGATION_DONE, self.Flush)
	self:AddListener(GAME.ISLAND_FINISH_TECH_IMMD_DONE, self.CheckAutoUnlock)
	self:AddListener(GAME.ISLAND_FINISH_DELEGATION_DONE, self.Flush)
	self:AddListener(GAME.ISLAND_GET_DELEGATION_AWARD_DONE, self.CheckAutoUnlock)

	return
end

function IslandTechnologyPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_UNLOCK_TECH_DONE, self.Flush)
	self:RemoveListener(GAME.ISLAND_START_DELEGATION_DONE, self.Flush)
	self:RemoveListener(GAME.ISLAND_FINISH_TECH_IMMD_DONE, self.CheckAutoUnlock)
	self:RemoveListener(GAME.ISLAND_FINISH_DELEGATION_DONE, self.Flush)
	self:RemoveListener(GAME.ISLAND_GET_DELEGATION_AWARD_DONE, self.CheckAutoUnlock)

	return
end

function IslandTechnologyPage:InitTypeItem(arg_20_1, arg_20_2)
	local var_20_0 = self.commonTypes[arg_20_1 + 1]

	arg_20_2.name = self.commonTypes[arg_20_1 + 1]

	setText(arg_20_2:Find("unsel"), IslandTechBelong.Names[self.commonTypes[arg_20_1 + 1]])
	setText(arg_20_2:Find("sel/content/Text"), IslandTechBelong.Names[self.commonTypes[arg_20_1 + 1]])
	LoadImageSpriteAsync("island/islandtechnology/tech_type_" .. IslandTechBelong.Fields[self.commonTypes[arg_20_1 + 1]], arg_20_2:Find("sel/content/Image"), true)
	onToggle(self, arg_20_2, function(arg_21_0)
		if arg_21_0 and self.curPage ~= var_20_0 then
			self.curPage = var_20_0

			self:SwitchPage()
		end

		return
	end, SFX_PANEL)

	return
end

function IslandTechnologyPage:UpdateTypeItem(arg_22_1, arg_22_2)
	setActive(arg_22_2:Find("unsel/tip"), self:IsReceiveByType(self.commonTypes[arg_22_1 + 1]))
	setActive(arg_22_2:Find("sel/tip"), self:IsReceiveByType(self.commonTypes[arg_22_1 + 1]))

	return
end

function IslandTechnologyPage:IsReceiveByType(arg_23_1)
	for iter_23_0, iter_23_1 in pairs(self.techAgency:GetTechnologys()) do
		if iter_23_1:getConfig("tech_belong") == arg_23_1 and iter_23_1:GetStatus() == IslandTechnology.STATUS.RECEIVE then
			return true
		end
	end

	return false
end

function IslandTechnologyPage:FlushCentreTip()
	setActive(self.centreTipTF, self:IsReceiveByType(IslandTechBelong.CENTRE))

	return
end

function IslandTechnologyPage:SwitchPage()
	for iter_25_0, iter_25_1 in pairs(self.pages) do
		if iter_25_0 == self.curPage then
			iter_25_1:ExecuteAction("Show")
		else
			iter_25_1:ExecuteAction("Hide")
		end
	end

	return
end

function IslandTechnologyPage:OnShow()
	triggerToggle(self.centreToggleTF, true)
	self.quickPanel:ExecuteAction("Show")
	self:CheckAutoUnlock()

	return
end

function IslandTechnologyPage:CheckAutoUnlock()
	getProxy(IslandProxy):GetIsland():GetTechnologyAgency():TryAutoUnlock(function()
		self:Flush()

		return
	end)

	return
end

function IslandTechnologyPage:Flush()
	self.techAgency = getProxy(IslandProxy):GetIsland():GetTechnologyAgency()

	self.typeUIList:align(#self.commonTypes)
	self:FlushCentreTip()
	self.pages[self.curPage]:ExecuteAction("Flush")
	self.quickPanel:ExecuteAction("Flush")

	if self.detailPanel:isShowing() then
		self.detailPanel:ExecuteAction("Flush")
	end

	return
end

function IslandTechnologyPage:OnHide()
	self.quickPanel:ExecuteAction("Hide")
	self.detailPanel:ExecuteAction("Hide")

	return
end

function IslandTechnologyPage:OnDisable()
	self:OnHide()

	return
end

function IslandTechnologyPage:OnDestroy()
	if self.quickPanel then
		self.quickPanel:Destroy()

		self.quickPanel = nil
	end

	if self.detailPanel then
		self.detailPanel:Destroy()

		self.detailPanel = nil
	end

	for iter_32_0, iter_32_1 in pairs(self.pages) do
		if iter_32_1 then
			iter_32_1:Destroy()

			iter_32_1 = nil
		end
	end

	return
end

return IslandTechnologyPage
