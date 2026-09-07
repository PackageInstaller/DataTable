local WorldBossFormationPreViewPage = class("WorldBossFormationPreViewPage", import("....base.BaseSubView"))

function WorldBossFormationPreViewPage:getUIName()
	return "WorldBossFormationPreViewPage"
end

function WorldBossFormationPreViewPage:OnLoaded()
	self.shipList = {
		self._tf:Find("frame/ships/1"),
		self._tf:Find("frame/ships/2"),
		self._tf:Find("frame/ships/3")
	}
	self.returnBtn = self._tf:Find("frame/return")

	return
end

function WorldBossFormationPreViewPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.returnBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onToggle(self, self._tf:Find("frame/toggles/main"), function(arg_6_0)
		if arg_6_0 then
			self:Switch(1)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self._tf:Find("frame/toggles/vanguard"), function(arg_7_0)
		if arg_7_0 then
			self:Switch(2)
		end

		return
	end, SFX_PANEL)

	return
end

function WorldBossFormationPreViewPage:Switch(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self.shipList) do
		self:UpdateShip(iter_8_1, self.ships[arg_8_1][iter_8_0])
	end

	return
end

function WorldBossFormationPreViewPage:Show(arg_9_1)
	WorldBossFormationPreViewPage.super.Show(self)
	setParent(self._tf, pg.UIMgr.GetInstance().UIMain)

	local var_9_0 = {}
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_2 = iter_9_1:getTeamType()

		if var_9_2 == TeamType.Vanguard then
			table.insert(var_9_1, iter_9_1)
		elseif var_9_2 == TeamType.Main then
			table.insert(var_9_0, iter_9_1)
		end
	end

	self.ships = {
		var_9_0,
		var_9_1
	}

	triggerToggle(self._tf:Find("frame/toggles/main"), true)

	return
end

function WorldBossFormationPreViewPage:OnHide()
	WorldBossFormationPreViewPage.super.OnHide(self)

	return
end

function WorldBossFormationPreViewPage:UpdateShip(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:Find("bg/info")

	setActive(var_11_0, arg_11_2)

	if arg_11_2 then
		local var_11_1 = var_11_0:Find("ship_type")
		local var_11_2 = UIItemList.New(var_11_0:Find("stars"), var_11_0:Find("stars/star_tpl"))

		var_11_0:Find("name"):GetComponent(typeof(Text)).text = shortenString(arg_11_2:getName(), 6)
		var_11_1:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("shiptype", shipType2print(pg.ship_data_statistics[arg_11_2.configId].type))

		local var_11_3 = arg_11_2:getStar()

		var_11_2:make(function(arg_12_0, arg_12_1, arg_12_2)
			if arg_12_0 == UIItemList.EventUpdate then
				setActive(arg_12_2:Find("star_tpl"), arg_12_1 <= var_11_3)
			end

			return
		end)
		var_11_2:align((arg_11_2:getMaxStar()))

		var_11_0:Find("lv").GetComponent(var_11_1, typeof(Text)).text = "Lv." .. arg_11_2.level
		var_11_0:Find("mask/icon"):GetComponent(typeof(Image)).sprite = LoadSprite("HeroHrzIcon/" .. arg_11_2:getPainting())
	end

	arg_11_1:Find("bg/line").sizeDelta = arg_11_2 and Vector2(235, 2) or Vector2(461, 2)

	self:UpdateEquipments(var_11_0, arg_11_2)

	return
end

function WorldBossFormationPreViewPage:UpdateEquipments(arg_13_1, arg_13_2)
	local var_13_0 = UIItemList.New(arg_13_1.parent:Find("equipemtns"), arg_13_1.parent:Find("equipemtns/equipment_tpl"))
	local var_13_1 = arg_13_2 and arg_13_2:getActiveEquipments() or {}

	var_13_0:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = var_13_1[arg_14_1 + 1]

			setActive(arg_14_2:Find("info"), var_13_1[arg_14_1 + 1])
			setActive(arg_14_2:Find("empty"), not var_13_1[arg_14_1 + 1])

			if var_13_1[arg_14_1 + 1] then
				updateEquipment(arg_14_2:Find("info"), var_13_1[arg_14_1 + 1])
				onButton(self, arg_14_2, function()
					self:emit(BaseUI.ON_EQUIPMENT, {
						type = EquipmentInfoMediator.TYPE_DISPLAY,
						equipment = var_14_0
					})

					return
				end, SFX_PANEL)
			else
				removeOnButton(arg_14_2)
			end
		end

		return
	end)
	var_13_0:align(5)

	return
end

function WorldBossFormationPreViewPage:OnDestroy()
	return
end

return WorldBossFormationPreViewPage
