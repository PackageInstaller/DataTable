local IslandRoleDelegationPage = class("IslandRoleDelegationPage", import("...base.IslandBasePage"))

function IslandRoleDelegationPage:getUIName()
	return "IslandRoleDelegationUI"
end

local var_0_1 = 0.6

function IslandRoleDelegationPage:AddListeners()
	self:AddListener(GAME.ISLAND_GET_DELEGATION_AWARD_DONE, self.OnGetDelegationAwardDone)
	self:AddListener(GAME.ISLAND_FINISH_DELEGATION_DONE, self.OnFinishDelegationDone)
	self:AddListener(GAME.ISLAND_START_DELEGATION_DONE, self.OnDelegationStartDone)
	self:AddListener(GAME.ISLAND_USE_TICKET_DONE, self.OnUseTicketDone)

	return
end

function IslandRoleDelegationPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_GET_DELEGATION_AWARD_DONE, self.OnGetDelegationAwardDone)
	self:RemoveListener(GAME.ISLAND_FINISH_DELEGATION_DONE, self.OnFinishDelegationDone)
	self:RemoveListener(GAME.ISLAND_START_DELEGATION_DONE, self.OnDelegationStartDone)
	self:RemoveListener(GAME.ISLAND_USE_TICKET_DONE, self.OnUseTicketDone)

	return
end

local var_0_2 = Vector3(0, 0, 0)

function IslandRoleDelegationPage:OnLoaded()
	self.backBtn = self._tf:Find("top/back")
	self.title = self._tf:Find("top/title")
	self.content = self._tf:Find("content")
	self.delegationList = UIItemList.New(self.content, self.content:Find("tpl"))

	self.delegationList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			self:InitDelegationItem(arg_5_1, arg_5_2)
		elseif arg_5_0 == UIItemList.EventUpdate then
			self:UpdateDelegationItem(arg_5_1, arg_5_2)
		end

		return
	end)

	self.leftcontent = self._tf:Find("left/left_content")
	self.delegationTabList = UIItemList.New(self.leftcontent, self.leftcontent:Find("tpl"))

	self.delegationTabList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventInit then
			self:InitDelegationTabItem(arg_6_1, arg_6_2)
		elseif arg_6_0 == UIItemList.EventUpdate then
			self:UpdateDelegationTabItem(arg_6_1, arg_6_2)
		end

		return
	end)

	self.selectPanel = IslandDelegationSelectPanel.New(self._tf, self.event, setmetatable({
		alignRight = true,
		isPermanent = true,
		ShowMsgBox = function(arg_7_0, arg_7_1)
			self:ShowMsgBox(arg_7_1)

			return
		end
	}, {
		__index = self.contextData
	}))
	self.awardDisplayPanel = IslandAwardDisplayInMainPanel.New(self._tf, self.event)

	return
end

function IslandRoleDelegationPage:OnInit()
	self:InitPlaceCfg()
	onButton(self, self.backBtn, function()
		self:Hide()
		IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_commission.tip
		})

		return
	end, SFX_PANEL)

	return
end

function IslandRoleDelegationPage:InitPlaceCfg()
	self.npcToPlaceCfg = {}

	for iter_11_0, iter_11_1 in ipairs(pg.island_production_place.all) do
		self.npcToPlaceCfg[pg.island_production_place[iter_11_1].npc_birthplace] = self.npcToPlaceCfg[pg.island_production_place[iter_11_1].npc_birthplace] or {}

		table.insert(self.npcToPlaceCfg[pg.island_production_place[iter_11_1].npc_birthplace], iter_11_1)
	end

	return
end

function IslandRoleDelegationPage:InitDelegationTabItem(arg_12_1, arg_12_2)
	onButton(self, arg_12_2, function()
		self:OnSelectTargetIndexCommission(arg_12_1)

		return
	end, SFX_PANEL)

	return
end

function IslandRoleDelegationPage:InitDelegationItem(arg_14_1, arg_14_2)
	onButton(self, arg_14_2, function()
		self:OnSelectTargetIndexCommission(arg_14_1)

		return
	end, SFX_PANEL)

	return
end

function IslandRoleDelegationPage:UpdateDelegationItem(arg_16_1, arg_16_2)
	local var_16_0 = Vector3(pg.island_world_objects[pg.island_production_commission[self.placeCommissionList[arg_16_1 + 1]].birthplace].param.position[1], pg.island_world_objects[pg.island_production_commission[self.placeCommissionList[arg_16_1 + 1]].birthplace].param.position[2], pg.island_world_objects[pg.island_production_commission[self.placeCommissionList[arg_16_1 + 1]].birthplace].param.position[3])
	local var_16_1 = Vector3(pg.island_world_objects[pg.island_production_commission[self.placeCommissionList[arg_16_1 + 1]].birthplace].param.rotation[1], pg.island_world_objects[pg.island_production_commission[self.placeCommissionList[arg_16_1 + 1]].birthplace].param.rotation[2], pg.island_world_objects[pg.island_production_commission[self.placeCommissionList[arg_16_1 + 1]].birthplace].param.rotation[3])

	arg_16_2.transform.localPosition = IslandCalcUtil.WorldPosition2LocalPosition(self.content, var_16_0) + var_0_2

	setActive(arg_16_2:Find("select"), false)
	setActive(arg_16_2:Find("unselect"), false)
	setButtonEnabled(arg_16_2, getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(self.placeId):GetDelegationSlotData(pg.island_production_commission[self.placeCommissionList[arg_16_1 + 1]].slot) ~= nil)
	self:emitCore(ISLAND_EVT.SELECTDELEEFFECT_SHOW, arg_16_1 + 1, self.selectedIdx, var_16_0, var_16_1)

	return
end

function IslandRoleDelegationPage:OnSelectTargetIndexCommission(arg_17_1, arg_17_2)
	if self.selectedIdx == arg_17_1 + 1 and not arg_17_2 then
		return
	end

	if not arg_17_2 then
		self.selectedShip = nil

		self:UnloadPreconcenCharacter()
	end

	self.selectedIdx = arg_17_1 + 1
	self.contextData.selectedIdx = self.selectedIdx

	self.selectPanel:ExecuteAction("Show", self.placeCommissionList[self.selectedIdx], self.selectedShip, function(arg_18_0)
		self.contextData.selectedShip = arg_18_0
		self.selectedShip = arg_18_0

		self:LoadPreconcenCharacter(arg_18_0)

		return
	end, function()
		self.contextData.selectedShip = nil
		self.selectedShip = nil

		self:UnloadPreconcenCharacter()

		return
	end)
	self.delegationTabList:align(#self.placeCommissionList)
	self.delegationList:align(#self.placeCommissionList)

	return
end

function IslandRoleDelegationPage:UpdateDelegationTabItem(arg_20_1, arg_20_2)
	setActive(arg_20_2:Find("select"), self.selectedIdx == arg_20_1 + 1)
	setActive(arg_20_2:Find("unselect"), self.selectedIdx ~= arg_20_1 + 1)

	local var_20_0 = getProxy(IslandProxy)
	local var_20_1 = var_20_0:GetIsland():GetBuildingAgency():GetBuilding(self.placeId):GetDelegationSlotData(pg.island_production_commission[self.placeCommissionList[arg_20_1 + 1]].slot)

	setActive(arg_20_2:Find("lock"), not var_20_0)
	setActive(arg_20_2:Find("slotName"), var_20_1)
	setButtonEnabled(arg_20_2, var_20_1 ~= nil)

	if self.selectedIdx == arg_20_1 + 1 then
		self.selectPanel:ExecuteAction("Flush")
	end

	if not var_20_1 then
		setActive(arg_20_2:Find("complete "), false)
		setActive(arg_20_2:Find("product_icon"), false)

		return
	end

	local var_20_2 = var_20_1:GetSlotRoleData()
	local var_20_3 = var_20_1:GetSlotRewardData()

	setActive(arg_20_2:Find("complete "), var_20_2 == nil and var_20_3 ~= nil)

	local var_20_4

	if var_20_2 then
		var_20_4 = var_20_2.formula_id or nil
	end

	var_20_4 = var_20_4 or var_20_3 and var_20_3.formula_id or nil

	if var_20_4 then
		setActive(arg_20_2:Find("product_icon"), true)
		GetImageSpriteFromAtlasAsync("island/" .. pg.island_item_data_template[pg.island_formula[var_20_4].item_id].icon, "", arg_20_2:Find("product_icon"))
	else
		setActive(arg_20_2:Find("product_icon"), false)
	end

	return
end

function IslandRoleDelegationPage:Flush()
	self.delegationList:align(#self.placeCommissionList)
	self.delegationTabList:align(#self.placeCommissionList)

	return
end

function IslandRoleDelegationPage:OnShow(arg_22_1, arg_22_2)
	self.placeId = arg_22_1 and arg_22_1 or self.npcToPlaceCfg[arg_22_2][1]
	self.placeCfg = pg.island_production_place[self.placeId]
	self.placeCommissionList = self.placeCfg.commission_slot

	if self.placeCfg.delegationCamera then
		IslandCameraMgr.instance:ActiveVirtualCamera(self.placeCfg.delegationCamera)
	end

	self.timeMgr = pg.TimeMgr.GetInstance()
	self.selectedShip = self.contextData.selectedShip

	self:DefaultTargetTabIndex()

	if self.selectedShip then
		self:LoadPreconcenCharacter(self.selectedShip)
	end

	self:StopTimer()
	self:StartTimer()
	setText(self._tf:Find("top/title/Text"), self.placeCfg.name)
	setText(self._tf:Find("top/title/Text/en"), "PRODUCTING")

	return
end

function IslandRoleDelegationPage:DefaultTargetTabIndex()
	self:OnSelectTargetIndexCommission((self.contextData.selectedIdx or 1) - 1, true)

	return
end

function IslandRoleDelegationPage:OnHide()
	self:StopTimer()
	self:emitCore(ISLAND_EVT.RECYCLE_ALL_SLOTDELEEFFECT)
	self:UnloadPreconcenCharacter()

	if self.awardDisplayPanel then
		self.awardDisplayPanel:Hide()
	end

	return
end

function IslandRoleDelegationPage:OnExit()
	self.contextData.selectedIdx = nil
	self.contextData.selectedShip = nil

	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME)

	return
end

function IslandRoleDelegationPage:StartTimer()
	setActive(self.content, false)

	self.timer = Timer.New(function()
		setActive(self.content, true)
		self:Flush()

		return
	end, var_0_1, 0)

	self.timer:Start()

	return
end

function IslandRoleDelegationPage:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandRoleDelegationPage:OnDestroy()
	self:StopTimer()

	if self.selectPanel then
		self.selectPanel:Destroy()

		self.selectPanel = nil
	end

	if self.awardDisplayPanel then
		self.awardDisplayPanel:Destroy()

		self.awardDisplayPanel = nil
	end

	return
end

function IslandRoleDelegationPage:OnGetDelegationAwardDone(arg_30_1)
	if arg_30_1.addShipExpData then
		self:UpdateMainAwardReward({
			shipExp = true,
			icon = "island/IslandShipIcon/" .. IslandShip.StaticGetPrefab(arg_30_1.addShipExpData.addShipId),
			num = arg_30_1.addShipExpData.addExp
		})
	end

	self.delegationTabList:align(#self.placeCommissionList)

	return
end

function IslandRoleDelegationPage:OnFinishDelegationDone(arg_31_1)
	if arg_31_1.addShipExpData then
		self:UpdateMainAwardReward({
			shipExp = true,
			icon = "island/IslandShipIcon/" .. IslandShip.StaticGetPrefab(arg_31_1.addShipExpData.addShipId),
			num = arg_31_1.addShipExpData.addExp
		})
	end

	self.delegationTabList:align(#self.placeCommissionList)

	return
end

function IslandRoleDelegationPage:OnUseTicketDone(arg_32_1)
	if arg_32_1.type == IslandUseTicketCommand.TYPES.APPOINT then
		self.delegationTabList:align(#self.placeCommissionList)
	end

	return
end

function IslandRoleDelegationPage:OnDelegationStartDone()
	self.delegationTabList:align(#self.placeCommissionList)

	return
end

function IslandRoleDelegationPage:LoadPreconcenCharacter(arg_34_1)
	self:UnloadPreconcenCharacter()
	self:emitCore(ISLAND_EVT.LOAD_DELEGATE_PREVIEW_ROLE, getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_34_1):GetModel(), pg.island_production_commission[self.placeCommissionList[self.selectedIdx]].birthplace)

	return
end

function IslandRoleDelegationPage:UnloadPreconcenCharacter()
	self:emitCore(ISLAND_EVT.UN_LOAD_DELEGATE_PREVIEW_ROLE)

	return
end

function IslandRoleDelegationPage:UpdateMainAwardReward(arg_36_1)
	self.awardDisplayPanel:ExecuteAction("ShowAwards", arg_36_1)

	return
end

return IslandRoleDelegationPage
