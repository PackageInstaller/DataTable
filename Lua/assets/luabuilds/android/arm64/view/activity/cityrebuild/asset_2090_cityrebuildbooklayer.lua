local CityRebuildBookLayer = class("CityRebuildBookLayer", import("view.base.BaseUI"))

CityRebuildBookLayer.Building = "building"
CityRebuildBookLayer.Chara = "chara"
CityRebuildBookLayer.Buff = "buff"

function CityRebuildBookLayer:getUIName()
	return "CityRebuildBookUI"
end

function CityRebuildBookLayer:init()
	self.bg = self._tf:Find("bg")
	self.closeBtn = self._tf:Find("panel/closeBtn")
	self.buildingTg = self._tf:Find("panel/switch/building")
	self.charaTg = self._tf:Find("panel/switch/chara")
	self.buffTg = self._tf:Find("panel/switch/buff")
	self.buildingPage = self._tf:Find("panel/subPages/buildingPage")
	self.charaPage = self._tf:Find("panel/subPages/charaPage")
	self.buffPage = self._tf:Find("panel/subPages/buffPage")

	setText(self.buildingPage:Find("left/buildingScroll/Viewport/Content/city/title/name"), i18n("ninja_game_citylevel") .. ":")
	setText(self.charaPage:Find("left/charaScroll/Viewport/Content/city/title/name"), i18n("ninja_game_citylevel") .. ":")
	setText(self.buildingPage:Find("right/consumeTitle/Text"), i18n("ninja_game_buildcost"))
	setText(self.charaPage:Find("right/consumeTitle/Text"), i18n("ninja_game_allycost"))
	setText(self.buffPage:Find("left/panel/buildingDPS"), i18n("ninja_game_citydmg"))
	setText(self.buffPage:Find("left/panel/charaDPS"), i18n("ninja_game_allydmg"))
	setText(self.buffPage:Find("left/panel/DPS"), i18n("ninja_game_dps"))
	setText(self.buffPage:Find("left/panel/time"), i18n("ninja_game_time"))
	setText(self.buffPage:Find("left/panel/pts"), i18n("ninja_game_income"))
	setText(self.buffPage:Find("left/panel/pt"), i18n("ninja_game_ptcount"))
	setText(self.buffPage:Find("right/buffScroll/Viewport/Content/buff/descTitle"), i18n("ninja_game_buffeffect"))
	setText(self.buffPage:Find("right/buffScroll/Viewport/Content/buff/nextLevelPt/title"), i18n("ninja_game_buffcost"))
	setText(self.buffPage:Find("right/buffScroll/Viewport/Content/buff/levelMax"), i18n("ninja_game_levelblock"))
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function CityRebuildBookLayer:didEnter()
	self:InitData()
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.closeBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onToggle(self, self.buildingTg, function(arg_6_0)
		setActive(self.buildingPage, arg_6_0)
		setActive(self.charaPage, not arg_6_0)
		setActive(self.buffPage, not arg_6_0)

		if arg_6_0 then
			if self.page ~= CityRebuildBookLayer.Building then
				triggerToggle(self.firstBuildingTg, true)
			end

			self.page = CityRebuildBookLayer.Building
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.charaTg, function(arg_7_0)
		setActive(self.buildingPage, not arg_7_0)
		setActive(self.charaPage, arg_7_0)
		setActive(self.buffPage, not arg_7_0)

		if arg_7_0 then
			if self.page ~= CityRebuildBookLayer.Chara then
				triggerToggle(self.firstCharaTg, true)
			end

			self.page = CityRebuildBookLayer.Chara
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.buffTg, function(arg_8_0)
		setActive(self.buildingPage, not arg_8_0)
		setActive(self.charaPage, not arg_8_0)
		setActive(self.buffPage, arg_8_0)

		if arg_8_0 then
			self.page = CityRebuildBookLayer.Buff
		end

		return
	end, SFX_PANEL)
	self:Refresh()

	return
end

function CityRebuildBookLayer:InitData()
	self.activityId = ActivityConst.NINJA_CITY_ACT_ID
	self.cityRebuildProxy = getProxy(CityRebuildProxy)
	self.cityRebuildData = self.cityRebuildProxy:GetData(self.activityId)
	self.page = self.contextData.page or CityRebuildBookLayer.Building

	if self.page == CityRebuildBookLayer.Building then
		self.showBuildingId = self.contextData.showId
	elseif self.page == CityRebuildBookLayer.Chara then
		self.showCharaId = self.contextData.showId
	end

	self.showBuildingId = self.showBuildingId or self.cityRebuildData.Levelbuildings[1][1]
	self.showCharaId = self.showCharaId or self.cityRebuildData.Levelcharas[1][1]

	return
end

function CityRebuildBookLayer:Refresh()
	self.virtualBagActivity = getProxy(ActivityProxy):getActivityById(self.activityId)

	self:RemoveTimer()
	self:RemoveAllTimers()
	self:RefreshBuildingPage()
	self:RefreshCharaPage()
	self:RefreshBuffPage()
	triggerToggle(self._tf:Find("panel/switch/" .. self.page), true)
	setActive(self.charaTg:Find("tip"), CityRebuildBookLayer.ShouldShowTip())

	return
end

function CityRebuildBookLayer:RefreshBuildingPage()
	local var_11_0 = UIItemList.New(self.buildingPage:Find("left/buildingScroll/Viewport/Content"), self.buildingPage:Find("left/buildingScroll/Viewport/Content/city"))
	local var_11_1 = self.cityRebuildData.Levelbuildings

	var_11_0:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			local var_12_0 = var_11_1[arg_12_1 + 1]
			local var_12_1 = self.cityRebuildData.cityLevel >= arg_12_1 + 1 and Color.New(1, 1, 1, 1) or Color.New(0.8196078431372549, 0.8196078431372549, 0.8196078431372549, 1)

			arg_12_2:Find("title/name"):GetComponent(typeof(Text)).color = var_12_1
			arg_12_2:Find("title/name/Text"):GetComponent(typeof(Text)).color = var_12_1

			setText(arg_12_2:Find("title/name/Text"), "Lv." .. arg_12_1 + 1)
			setActive(arg_12_2:Find("title/name/lock"), self.cityRebuildData.cityLevel < arg_12_1 + 1)

			local var_12_2 = UIItemList.New(arg_12_2:Find("buildings"), arg_12_2:Find("buildings/building"))

			var_12_2:make(function(arg_13_0, arg_13_1, arg_13_2)
				if arg_13_0 == UIItemList.EventUpdate then
					local var_13_0 = pg.activity_ninja_building[var_12_0[arg_13_1 + 1]]
					local var_13_1 = table.contains(self.cityRebuildData.buildings, pg.activity_ninja_building[var_12_0[arg_13_1 + 1]].id)

					setActive(arg_13_2:Find("iconBg/lock"), self.cityRebuildData.cityLevel < arg_12_1 + 1)
					setActive(arg_13_2:Find("iconBg/icon"), self.cityRebuildData.cityLevel >= arg_12_1 + 1)

					local var_13_2 = ""

					if self.cityRebuildData.cityLevel >= arg_12_1 + 1 then
						var_13_2 = var_13_1 and var_13_0.handbook_pic[2] or var_13_0.handbook_pic[1]
					end

					if var_13_2 ~= "" then
						GetImageSpriteFromAtlasAsync(var_13_2, "", arg_13_2:Find("iconBg/icon"))
					end

					arg_13_2:Find("nameMask/name"):GetComponent(typeof(Text)).color = self.cityRebuildData.cityLevel >= arg_12_1 + 1 and Color.New(0, 0, 0, 1) or Color.New(0.34509803921568627, 0.3843137254901961, 0.4, 1)

					local var_13_4

					if var_13_1 then
						var_13_4 = var_13_0.name[2] or var_13_0.name[1]
					end

					setScrollText(arg_13_2:Find("nameMask/name"), var_13_4)
					setActive(arg_13_2:Find("isRepaired"), var_13_1)

					if self.cityRebuildData.cityLevel >= arg_12_1 + 1 then
						arg_13_2:GetComponent(typeof(Toggle)).interactable = true

						onToggle(self, arg_13_2, function(arg_14_0)
							if arg_14_0 then
								self.showBuildingId = var_13_0.id

								setText(self.buildingPage:Find("right/name"), var_13_4)
								GetImageSpriteFromAtlasAsync(var_13_2, "", self.buildingPage:Find("right/iconBg/icon"))
								setText(self.buildingPage:Find("right/desc"), (var_13_1 or nil) and (var_13_0.desc[2] or var_13_0.desc[1]))
								setActive(self.buildingPage:Find("right/consumeTitle"), not var_13_1)
								setActive(self.buildingPage:Find("right/consume"), not var_13_1)
								setActive(self.buildingPage:Find("right/rebuildBtn"), not var_13_1)

								if not var_13_1 then
									local var_14_0 = {
										type = var_13_0.cost[1],
										id = var_13_0.cost[2],
										count = var_13_0.cost[3]
									}

									updateDrop(self.buildingPage:Find("right/consume/cost/mask/item"), var_14_0)
									onButton(self, self.buildingPage:Find("right/consume/cost"), function()
										self:emit(BaseUI.ON_DROP, var_14_0)

										return
									end, SFX_PANEL)

									local var_14_1 = self.virtualBagActivity:getVitemNumber(var_13_0.cost[2])

									self.buildingPage:Find("right/consume/cost/mask/item/icon_bg/count"):GetComponent(typeof(Text)).color = var_14_1 < var_13_0.cost[3] and Color.New(0.8352941176470589, 0.4627450980392157, 0.4627450980392157, 1) or Color.New(1, 1, 1, 1)

									local var_14_3 = {
										type = var_13_0.pt_cost[1],
										id = var_13_0.pt_cost[2],
										count = var_13_0.pt_cost[3]
									}

									updateDrop(self.buildingPage:Find("right/consume/ptCost/mask/item"), var_14_3)
									onButton(self, self.buildingPage:Find("right/consume/ptCost"), function()
										self:emit(BaseUI.ON_DROP, var_14_3)

										return
									end, SFX_PANEL)

									self.buildingPage:Find("right/consume/ptCost/mask/item/icon_bg/count"):GetComponent(typeof(Text)).color = self.cityRebuildData.pt < var_13_0.pt_cost[3] and Color.New(0.8352941176470589, 0.4627450980392157, 0.4627450980392157, 1) or Color.New(1, 1, 1, 1)

									onButton(self, self.buildingPage:Find("right/rebuildBtn"), function()
										if var_14_1 < var_13_0.cost[3] or self.cityRebuildData.pt < var_13_0.pt_cost[3] then
											pg.TipsMgr.GetInstance():ShowTips(i18n("ninja_game_update_failed"))

											return
										end

										self:emit(CityRebuildBookMediator.REBUILD_OR_START_RECRUIT, self.activityId, var_13_0.id, var_13_0.cost, var_13_0.pt_cost)

										return
									end, SFX_PANEL)
								end
							end

							return
						end, SFX_PANEL)

						if self.showBuildingId == var_13_0.id then
							triggerToggle(arg_13_2, true)
						end
					else
						arg_13_2:GetComponent(typeof(Toggle)).interactable = false
					end

					if arg_12_1 == 0 and arg_13_1 == 0 then
						self.firstBuildingTg = arg_13_2
					end
				end

				return
			end)
			var_12_2:align(#var_12_0)
		end

		return
	end)
	var_11_0:align(#self.cityRebuildData.Levelbuildings)

	return
end

function CityRebuildBookLayer:RefreshCharaPage()
	local var_18_0 = UIItemList.New(self.charaPage:Find("left/charaScroll/Viewport/Content"), self.charaPage:Find("left/charaScroll/Viewport/Content/city"))
	local var_18_1 = self.cityRebuildData.Levelcharas

	var_18_0:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = var_18_1[arg_19_1 + 1]

			setActive(arg_19_2, #var_18_1[arg_19_1 + 1] > 0)

			if #var_19_0 > 0 then
				local var_19_1 = self.cityRebuildData.cityLevel >= arg_19_1 + 1 and Color.New(1, 1, 1, 1) or Color.New(0.8196078431372549, 0.8196078431372549, 0.8196078431372549, 1)

				arg_19_2:Find("title/name"):GetComponent(typeof(Text)).color = var_19_1
				arg_19_2:Find("title/name/Text"):GetComponent(typeof(Text)).color = var_19_1

				setText(arg_19_2:Find("title/name/Text"), "Lv." .. arg_19_1 + 1)
				setActive(arg_19_2:Find("title/name/lock"), self.cityRebuildData.cityLevel < arg_19_1 + 1)

				local var_19_2 = UIItemList.New(arg_19_2:Find("charas"), arg_19_2:Find("charas/chara"))

				var_19_2:make(function(arg_20_0, arg_20_1, arg_20_2)
					if arg_20_0 == UIItemList.EventUpdate then
						local var_20_0 = pg.activity_ninja_building[var_19_0[arg_20_1 + 1]]
						local var_20_1 = table.contains(self.cityRebuildData.roles, pg.activity_ninja_building[var_19_0[arg_20_1 + 1]].id)
						local var_20_2 = self.cityRebuildData.recruiting[pg.activity_ninja_building[var_19_0[arg_20_1 + 1]].id] ~= nil
						local var_20_3 = false

						if self.cityRebuildData.recruiting[pg.activity_ninja_building[var_19_0[arg_20_1 + 1]].id] ~= nil then
							var_20_3 = pg.TimeMgr.GetInstance():GetServerTime() - self.cityRebuildData.recruiting[var_20_0.id] >= var_20_0.time
						end

						setActive(arg_20_2:Find("iconBg/time"), var_20_2 and not var_20_3)

						local var_20_4 = self.cityRebuildData.recruiting[var_20_0.id]

						if var_20_2 and not var_20_3 then
							self:StartTimers(function()
								local var_21_0 = pg.TimeMgr.GetInstance():GetServerTime() - var_20_4

								if var_21_0 < var_20_0.time then
									setText(arg_20_2:Find("iconBg/time/Text"), self:DescCDTime(var_20_0.time - var_21_0))

									arg_20_2:Find("iconBg/time"):GetComponent(typeof(Image)).fillAmount = (var_20_0.time - var_21_0) / var_20_0.time
								else
									setActive(arg_20_2:Find("iconBg/time"), false)
									self.timerList[var_20_0.id]:Stop()

									self.timerList[var_20_0.id] = nil
								end

								return
							end, var_20_0.id)
						end

						setActive(arg_20_2:Find("iconBg/lock"), self.cityRebuildData.cityLevel < arg_19_1 + 1)
						setActive(arg_20_2:Find("iconBg/icon"), self.cityRebuildData.cityLevel >= arg_19_1 + 1)

						local var_20_5 = ""

						if self.cityRebuildData.cityLevel >= arg_19_1 + 1 then
							var_20_5 = var_20_1 and var_20_0.handbook_pic[2] or var_20_0.handbook_pic[1]
						end

						if var_20_5 ~= "" then
							GetImageSpriteFromAtlasAsync(var_20_5, "", arg_20_2:Find("iconBg/icon"))
						end

						arg_20_2:Find("nameMask/name"):GetComponent(typeof(Text)).color = self.cityRebuildData.cityLevel >= arg_19_1 + 1 and Color.New(0, 0, 0, 1) or Color.New(0.34509803921568627, 0.3843137254901961, 0.4, 1)

						local var_20_7

						if var_20_1 then
							var_20_7 = var_20_0.name[2] or var_20_0.name[1]
						end

						setScrollText(arg_20_2:Find("nameMask/name"), var_20_7)
						setActive(arg_20_2:Find("isRepaired"), var_20_1)

						if self.cityRebuildData.cityLevel >= arg_19_1 + 1 then
							arg_20_2:GetComponent(typeof(Toggle)).interactable = true

							onToggle(self, arg_20_2, function(arg_22_0)
								if arg_22_0 then
									self.showCharaId = var_20_0.id

									self:RemoveTimer()
									setText(self.charaPage:Find("right/name"), var_20_7)
									GetImageSpriteFromAtlasAsync(var_20_5, "", self.charaPage:Find("right/iconBg/icon"))
									setText(self.charaPage:Find("right/desc"), (var_20_1 or nil) and (var_20_0.desc[2] or var_20_0.desc[1]))
									setActive(self.charaPage:Find("right/consumeTitle"), not var_20_1 and not var_20_2)
									setActive(self.charaPage:Find("right/consume"), not var_20_1 and not var_20_2)
									setActive(self.charaPage:Find("right/recruitBtn"), not var_20_1 and not var_20_2)

									if not var_20_1 and not var_20_2 then
										local var_22_0 = {
											type = var_20_0.cost[1],
											id = var_20_0.cost[2],
											count = var_20_0.cost[3]
										}

										updateDrop(self.charaPage:Find("right/consume/cost/mask/item"), var_22_0)
										onButton(self, self.charaPage:Find("right/consume/cost"), function()
											self:emit(BaseUI.ON_DROP, var_22_0)

											return
										end, SFX_PANEL)

										local var_22_1 = self.virtualBagActivity:getVitemNumber(var_20_0.cost[2])

										self.charaPage:Find("right/consume/cost/mask/item/icon_bg/count"):GetComponent(typeof(Text)).color = var_22_1 < var_20_0.cost[3] and Color.New(0.8352941176470589, 0.4627450980392157, 0.4627450980392157, 1) or Color.New(1, 1, 1, 1)

										local var_22_3 = {
											type = var_20_0.pt_cost[1],
											id = var_20_0.pt_cost[2],
											count = var_20_0.pt_cost[3]
										}

										updateDrop(self.charaPage:Find("right/consume/ptCost/mask/item"), var_22_3)
										onButton(self, self.charaPage:Find("right/consume/ptCost"), function()
											self:emit(BaseUI.ON_DROP, var_22_3)

											return
										end, SFX_PANEL)

										self.charaPage:Find("right/consume/ptCost/mask/item/icon_bg/count"):GetComponent(typeof(Text)).color = self.cityRebuildData.pt < var_20_0.pt_cost[3] and Color.New(0.8352941176470589, 0.4627450980392157, 0.4627450980392157, 1) or Color.New(1, 1, 1, 1)

										onButton(self, self.charaPage:Find("right/recruitBtn"), function()
											if var_22_1 < var_20_0.cost[3] or self.cityRebuildData.pt < var_20_0.pt_cost[3] then
												pg.TipsMgr.GetInstance():ShowTips(i18n("ninja_game_update_failed"))

												return
											end

											self:emit(CityRebuildBookMediator.REBUILD_OR_START_RECRUIT, self.activityId, var_20_0.id, var_20_0.cost, var_20_0.pt_cost)

											return
										end, SFX_PANEL)
									end

									if var_20_2 then
										var_20_3 = pg.TimeMgr.GetInstance():GetServerTime() - self.cityRebuildData.recruiting[var_20_0.id] >= var_20_0.time
									end

									setActive(self.charaPage:Find("right/recruiting"), var_20_2 and not var_20_3)
									setActive(self.charaPage:Find("right/endRecruitBtn"), var_20_2 and var_20_3)

									if var_20_2 then
										if var_20_3 then
											local var_22_5 = {
												var_20_0.id
											}

											onButton(self, self.charaPage:Find("right/endRecruitBtn"), function()
												self:emit(CityRebuildBookMediator.END_RECRUIT, self.activityId, var_22_5)

												return
											end, SFX_PANEL)
										else
											self:StartTimer(function()
												local var_27_0 = pg.TimeMgr.GetInstance():GetServerTime() - var_20_4

												if var_27_0 < var_20_0.time then
													setText(self.charaPage:Find("right/recruiting/Text"), self:DescCDTime(var_20_0.time - var_27_0))
												else
													setActive(self.charaPage:Find("right/recruiting"), false)
													setActive(self.charaPage:Find("right/endRecruitBtn"), true)

													local var_27_1 = {
														var_20_0.id
													}

													onButton(self, self.charaPage:Find("right/endRecruitBtn"), function()
														self:emit(CityRebuildBookMediator.END_RECRUIT, self.activityId, var_27_1)

														return
													end, SFX_PANEL)
													self:RemoveTimer()
												end

												return
											end)
										end
									end
								end

								return
							end, SFX_PANEL)

							if self.showCharaId == var_20_0.id then
								triggerToggle(arg_20_2, true)
							end
						else
							arg_20_2:GetComponent(typeof(Toggle)).interactable = false
						end

						if arg_19_1 == 0 and arg_20_1 == 0 then
							self.firstCharaTg = arg_20_2
						end
					end

					return
				end)
				var_19_2:align(#var_19_0)
			end
		end

		return
	end)
	var_18_0:align(#self.cityRebuildData.Levelcharas)

	return
end

function CityRebuildBookLayer:RefreshBuffPage()
	self:SetSummaryPanel()

	local var_29_0 = self.cityRebuildData.buffs
	local var_29_1 = self.cityRebuildData.buffLevels

	table.sort(self.cityRebuildData.buffs, CompareFuncs({
		function(arg_30_0)
			return pg.activity_ninja_buff[arg_30_0].group
		end
	}))

	local var_29_2 = pg.activity_ninja_city[self.cityRebuildData.cityLevel].buff
	local var_29_3 = UIItemList.New(self.buffPage:Find("right/buffScroll/Viewport/Content"), self.buffPage:Find("right/buffScroll/Viewport/Content/buff"))

	var_29_3:make(function(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_0 == UIItemList.EventUpdate then
			local var_31_0 = pg.activity_ninja_buff[var_29_0[arg_31_1 + 1]]
			local var_31_1 = pg.activity_ninja_buff.get_id_list_by_group[arg_31_1 + 1]
			local var_31_2 = pg.activity_ninja_buff[pg.activity_ninja_buff.get_id_list_by_group[arg_31_1 + 1][pg.activity_ninja_buff[var_29_0[arg_31_1 + 1]].level + 1]]
			local var_31_3 = var_29_2[arg_31_1 + 1]
			local var_31_4 = pg.activity_ninja_city[5].buff[arg_31_1 + 1]

			GetImageSpriteFromAtlasAsync(pg.activity_ninja_buff[var_29_0[arg_31_1 + 1]].icon, "", arg_31_2:Find("icon"))
			setText(arg_31_2:Find("name"), i18n(pg.activity_ninja_buff[pg.activity_ninja_buff.get_id_list_by_group[arg_31_1 + 1][1]].name))
			setText(arg_31_2:Find("level"), "LV." .. var_31_0.level)
			setText(arg_31_2:Find("desc"), i18n("ninja_buff_effect" .. var_31_0.group, string.format("%.2f", (switch(var_31_0.group, {
				function()
					return self:GetParam(5)^(var_29_1[1] - 1)
				end,
				function()
					return self:GetParam(6) * var_29_1[2]
				end,
				function()
					return (1 - self:GetParam(11)^(var_29_1[3] - 1)) * 100
				end,
				function()
					return self:GetParam(15)^var_29_1[4]
				end,
				function()
					return var_29_1[5]
				end,
				function()
					return self:GetParam(7) * var_29_1[6] * 100
				end,
				function()
					return self:GetParam(4) * var_29_1[7]
				end,
				function()
					return self:GetParam(1)^(var_29_1[8] - 1)
				end,
				function()
					return self:GetParam(3)^(var_29_1[9] - 1)
				end,
				function()
					return var_29_1[10]
				end
			})))))

			local var_31_6 = var_31_3 > var_31_0.level and var_31_2

			setActive(arg_31_2:Find("nextLevelPt"), var_31_3 > var_31_0.level and var_31_2)
			setActive(arg_31_2:Find("upgradeBtn"), var_31_6)
			setActive(arg_31_2:Find("upgradeTenBtn"), var_31_6)
			setActive(arg_31_2:Find("levelMax"), not var_31_6)

			if var_31_0.level == var_31_4 then
				setActive(arg_31_2:Find("levelMax"), false)
			end

			if var_31_6 then
				local var_31_7 = math.ceil(var_31_2.basic_cost * var_31_2.cost^(var_31_2.level - 1) * (1 - self:GetParam(7) * var_29_1[6]))

				setText(arg_31_2:Find("nextLevelPt/Text"), var_31_7)
				onButton(self, arg_31_2:Find("upgradeBtn"), function()
					if self.cityRebuildData.pt < var_31_7 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("ninja_game_update_failed"))

						return
					end

					self:emit(CityRebuildBookMediator.UPGRADE_BUFF, self.activityId, arg_31_1 + 1, 1, var_31_7)

					return
				end, SFX_PANEL)
				onButton(self, arg_31_2:Find("upgradeTenBtn"), function()
					local var_43_0 = 1
					local var_43_1 = var_31_7

					for iter_43_0 = 2, 10 do
						if var_31_0.level + iter_43_0 > var_31_3 or not pg.activity_ninja_buff[var_31_1[var_31_0.level + iter_43_0]] then
							break
						end

						var_43_0 = var_43_0 + 1
						var_43_1 = arg_31_1 + 1 == 6 and var_43_1 + math.ceil(pg.activity_ninja_buff[var_31_1[var_31_0.level + iter_43_0]].basic_cost * pg.activity_ninja_buff[var_31_1[var_31_0.level + iter_43_0]].cost^(pg.activity_ninja_buff[var_31_1[var_31_0.level + iter_43_0]].level - 1) * (1 - self:GetParam(7) * (var_31_0.level + iter_43_0 - 1))) or var_43_1 + math.ceil(pg.activity_ninja_buff[var_31_1[var_31_0.level + iter_43_0]].basic_cost * pg.activity_ninja_buff[var_31_1[var_31_0.level + iter_43_0]].cost^(pg.activity_ninja_buff[var_31_1[var_31_0.level + iter_43_0]].level - 1) * (1 - self:GetParam(7) * var_29_1[6]))
					end

					if var_43_1 > self.cityRebuildData.pt then
						pg.TipsMgr.GetInstance():ShowTips(i18n("ninja_game_update_failed"))

						return
					end

					self:emit(CityRebuildBookMediator.UPGRADE_BUFF, self.activityId, arg_31_1 + 1, var_43_0, var_43_1)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	var_29_3:align(#self.cityRebuildData.buffs)

	return
end

function CityRebuildBookLayer:SetSummaryPanel()
	local var_44_0 = self.cityRebuildData.buildings
	local var_44_1 = self.cityRebuildData.roles
	local var_44_2 = self.cityRebuildData.buffLevels
	local var_44_3 = self.cityRebuildData.curLevel
	local var_44_4 = self.cityRebuildData.curLevel % 5 == 0
	local var_44_5 = 0
	local var_44_6 = pg.activity_ninja_enemy[self.cityRebuildData.curLevel].basic

	if self.cityRebuildData.curLevel < 51 then
		var_44_5 = math.ceil(var_44_6 * (var_44_3 - 1 + self:GetParam(9)^(var_44_3 - 1)) * (var_44_4 and self:GetParam(10) or 1) * self:GetParam(11)^(var_44_2[3] - 1))
	end

	local var_44_9
	local var_44_8
	local var_44_7

	do
		var_44_5 = math.ceil(var_44_6 * (self:GetParam(16) + self:GetParam(9)^self:GetParam(16) * self:GetParam(13)^(var_44_3 - (self:GetParam(16) + 1))) * (var_44_4 and self:GetParam(10) or 1) * self:GetParam(11)^(var_44_2[3] - 1))
		var_44_7 = math.ceil((#var_44_0 + var_44_2[10] + (#var_44_0 + var_44_2[10]) * self:GetParam(1)^(var_44_2[8] - 1) / self:GetParam(2)) * self:GetParam(3)^(var_44_2[9] - 1) + self:GetParam(4) * var_44_2[7])
		var_44_8 = math.ceil((#var_44_1 + var_44_2[5]) * self:GetParam(5)^(var_44_2[1] - 1) + self:GetParam(6) * var_44_2[2])
		var_44_9 = math.ceil(var_44_5 / (var_44_7 + var_44_8))
	end

	local var_44_10 = string.format("%.2f", math.ceil(self:GetParam(14)^var_44_3 * self:GetParam(15)^var_44_2[4]) / var_44_9)

	setText(self.buffPage:Find("left/panel/buildingDPS/Text"), var_44_7)
	setText(self.buffPage:Find("left/panel/charaDPS/Text"), var_44_8)
	setText(self.buffPage:Find("left/panel/DPS/Text"), var_44_7 + var_44_8)
	setText(self.buffPage:Find("left/panel/time/Text"), var_44_9 .. "s")
	setText(self.buffPage:Find("left/panel/pts/Text"), "+" .. var_44_10 .. "/s")
	setText(self.buffPage:Find("left/panel/pt/Text"), (CityRebuildData.PtToShow(self.cityRebuildData.pt)))

	return
end

function CityRebuildBookLayer:GetParam(arg_45_1)
	return (pg.gameset["ninja_Param" .. arg_45_1].key_value ~= 0 or nil) and (pg.gameset["ninja_Param" .. arg_45_1].key_value or tonumber(pg.gameset["ninja_Param" .. arg_45_1].description))
end

function CityRebuildBookLayer:StartTimer(arg_46_1)
	self.timer = Timer.New(arg_46_1, 1, -1)

	self.timer:Start()

	return
end

function CityRebuildBookLayer:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CityRebuildBookLayer:StartTimers(arg_48_1, arg_48_2)
	self.timerList = self.timerList or {}

	local var_48_0 = Timer.New(arg_48_1, 1, -1)

	var_48_0:Start()

	self.timerList[arg_48_2] = var_48_0

	return
end

function CityRebuildBookLayer:RemoveAllTimers()
	if self.timerList then
		for iter_49_0, iter_49_1 in pairs(self.timerList) do
			iter_49_1:Stop()
		end

		self.timerList = {}
	end

	return
end

function CityRebuildBookLayer:DescCDTime(arg_50_1)
	arg_50_1 = arg_50_1 % 60

	return string.format("%02d:%02d", math.floor(arg_50_1 / 60), arg_50_1)
end

function CityRebuildBookLayer:willExit()
	self:RemoveTimer()
	self:RemoveAllTimers()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function CityRebuildBookLayer.ShouldShowTip()
	local var_52_0 = getProxy(CityRebuildProxy):GetData(ActivityConst.NINJA_CITY_ACT_ID)

	if not var_52_0 then
		return false
	end

	for iter_52_0, iter_52_1 in pairs(var_52_0.recruiting) do
		if pg.TimeMgr.GetInstance():GetServerTime() - iter_52_1 >= pg.activity_ninja_building[iter_52_0].time then
			return true
		end
	end

	return false
end

return CityRebuildBookLayer
