local var_0_0 = class("CityRebuildBookLayer", import("view.base.BaseUI"))

var_0_0.Building = "building"
var_0_0.Chara = "chara"
var_0_0.Buff = "buff"

function var_0_0.getUIName(arg_1_0)
	return "CityRebuildBookUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.bg = arg_2_0._tf:Find("bg")
	arg_2_0.closeBtn = arg_2_0._tf:Find("panel/closeBtn")
	arg_2_0.buildingTg = arg_2_0._tf:Find("panel/switch/building")
	arg_2_0.charaTg = arg_2_0._tf:Find("panel/switch/chara")
	arg_2_0.buffTg = arg_2_0._tf:Find("panel/switch/buff")
	arg_2_0.buildingPage = arg_2_0._tf:Find("panel/subPages/buildingPage")
	arg_2_0.charaPage = arg_2_0._tf:Find("panel/subPages/charaPage")
	arg_2_0.buffPage = arg_2_0._tf:Find("panel/subPages/buffPage")

	setText(arg_2_0.buildingPage:Find("left/buildingScroll/Viewport/Content/city/title/name"), i18n("ninja_game_citylevel") .. ":")
	setText(arg_2_0.charaPage:Find("left/charaScroll/Viewport/Content/city/title/name"), i18n("ninja_game_citylevel") .. ":")
	setText(arg_2_0.buildingPage:Find("right/consumeTitle/Text"), i18n("ninja_game_buildcost"))
	setText(arg_2_0.charaPage:Find("right/consumeTitle/Text"), i18n("ninja_game_allycost"))
	setText(arg_2_0.buffPage:Find("left/panel/buildingDPS"), i18n("ninja_game_citydmg"))
	setText(arg_2_0.buffPage:Find("left/panel/charaDPS"), i18n("ninja_game_allydmg"))
	setText(arg_2_0.buffPage:Find("left/panel/DPS"), i18n("ninja_game_dps"))
	setText(arg_2_0.buffPage:Find("left/panel/time"), i18n("ninja_game_time"))
	setText(arg_2_0.buffPage:Find("left/panel/pts"), i18n("ninja_game_income"))
	setText(arg_2_0.buffPage:Find("left/panel/pt"), i18n("ninja_game_ptcount"))
	setText(arg_2_0.buffPage:Find("right/buffScroll/Viewport/Content/buff/descTitle"), i18n("ninja_game_buffeffect"))
	setText(arg_2_0.buffPage:Find("right/buffScroll/Viewport/Content/buff/nextLevelPt/title"), i18n("ninja_game_buffcost"))
	setText(arg_2_0.buffPage:Find("right/buffScroll/Viewport/Content/buff/levelMax"), i18n("ninja_game_levelblock"))
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:InitData()
	onButton(arg_3_0, arg_3_0.bg, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onToggle(arg_3_0, arg_3_0.buildingTg, function(arg_6_0)
		setActive(arg_3_0.buildingPage, arg_6_0)
		setActive(arg_3_0.charaPage, not arg_6_0)
		setActive(arg_3_0.buffPage, not arg_6_0)

		if arg_6_0 then
			if arg_3_0.page ~= var_0_0.Building then
				triggerToggle(arg_3_0.firstBuildingTg, true)
			end

			arg_3_0.page = var_0_0.Building
		end

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.charaTg, function(arg_7_0)
		setActive(arg_3_0.buildingPage, not arg_7_0)
		setActive(arg_3_0.charaPage, arg_7_0)
		setActive(arg_3_0.buffPage, not arg_7_0)

		if arg_7_0 then
			if arg_3_0.page ~= var_0_0.Chara then
				triggerToggle(arg_3_0.firstCharaTg, true)
			end

			arg_3_0.page = var_0_0.Chara
		end

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.buffTg, function(arg_8_0)
		setActive(arg_3_0.buildingPage, not arg_8_0)
		setActive(arg_3_0.charaPage, not arg_8_0)
		setActive(arg_3_0.buffPage, arg_8_0)

		if arg_8_0 then
			arg_3_0.page = var_0_0.Buff
		end

		return
	end, SFX_PANEL)
	arg_3_0:Refresh()

	return
end

function var_0_0.InitData(arg_9_0)
	arg_9_0.activityId = ActivityConst.NINJA_CITY_ACT_ID
	arg_9_0.cityRebuildProxy = getProxy(CityRebuildProxy)
	arg_9_0.cityRebuildData = arg_9_0.cityRebuildProxy:GetData(arg_9_0.activityId)
	arg_9_0.page = arg_9_0.contextData.page or var_0_0.Building

	if arg_9_0.page == var_0_0.Building then
		arg_9_0.showBuildingId = arg_9_0.contextData.showId
	elseif arg_9_0.page == var_0_0.Chara then
		arg_9_0.showCharaId = arg_9_0.contextData.showId
	end

	arg_9_0.showBuildingId = arg_9_0.showBuildingId or arg_9_0.cityRebuildData.Levelbuildings[1][1]
	arg_9_0.showCharaId = arg_9_0.showCharaId or arg_9_0.cityRebuildData.Levelcharas[1][1]

	return
end

function var_0_0.Refresh(arg_10_0)
	arg_10_0.virtualBagActivity = getProxy(ActivityProxy):getActivityById(arg_10_0.activityId)

	arg_10_0:RemoveTimer()
	arg_10_0:RemoveAllTimers()
	arg_10_0:RefreshBuildingPage()
	arg_10_0:RefreshCharaPage()
	arg_10_0:RefreshBuffPage()
	triggerToggle(arg_10_0._tf:Find("panel/switch/" .. arg_10_0.page), true)
	setActive(arg_10_0.charaTg:Find("tip"), var_0_0.ShouldShowTip())

	return
end

function var_0_0.RefreshBuildingPage(arg_11_0)
	local var_11_0 = UIItemList.New(arg_11_0.buildingPage:Find("left/buildingScroll/Viewport/Content"), arg_11_0.buildingPage:Find("left/buildingScroll/Viewport/Content/city"))
	local var_11_1 = arg_11_0.cityRebuildData.Levelbuildings

	var_11_0:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			local var_12_0 = var_11_1[arg_12_1 + 1]
			local var_12_1 = arg_11_0.cityRebuildData.cityLevel >= arg_12_1 + 1 and Color.New(1, 1, 1, 1) or Color.New(0.8196078431372549, 0.8196078431372549, 0.8196078431372549, 1)
			local var_12_2 = arg_12_2:Find("title/name")

			var_12_2:GetComponent(typeof(Text)).color = var_12_1
			arg_12_2:Find("title/name/Text"):GetComponent(typeof(Text)).color = var_12_1

			setText(arg_12_2:Find("title/name/Text"), "Lv." .. arg_12_1 + 1)
			setActive(arg_12_2:Find("title/name/lock"), arg_11_0.cityRebuildData.cityLevel < arg_12_1 + 1)

			local var_12_3 = UIItemList.New(arg_12_2:Find("buildings"), arg_12_2:Find("buildings/building"))

			var_12_3:make(function(arg_13_0, arg_13_1, arg_13_2)
				if arg_13_0 == UIItemList.EventUpdate then
					local var_13_0 = pg.activity_ninja_building[var_12_0[arg_13_1 + 1]]
					local var_13_1 = table.contains(arg_11_0.cityRebuildData.buildings, pg.activity_ninja_building[var_12_0[arg_13_1 + 1]].id)

					setActive(arg_13_2:Find("iconBg/lock"), arg_11_0.cityRebuildData.cityLevel < arg_12_1 + 1)
					setActive(arg_13_2:Find("iconBg/icon"), arg_11_0.cityRebuildData.cityLevel >= arg_12_1 + 1)

					local var_13_2 = ""

					if arg_11_0.cityRebuildData.cityLevel >= arg_12_1 + 1 then
						var_13_2 = var_13_1 and var_13_0.handbook_pic[2] or var_13_0.handbook_pic[1]
					end

					if var_13_2 ~= "" then
						GetImageSpriteFromAtlasAsync(var_13_2, "", arg_13_2:Find("iconBg/icon"))
					end

					local var_13_3 = arg_13_2:Find("nameMask/name"):GetComponent(typeof(Text))

					var_13_3.color = arg_11_0.cityRebuildData.cityLevel >= arg_12_1 + 1 and Color.New(0, 0, 0, 1) or Color.New(0.34509803921568627, 0.3843137254901961, 0.4, 1)

					if var_13_1 then
						local var_13_4 = var_13_0.name[2] or var_13_0.name[1]

						setScrollText(arg_13_2:Find("nameMask/name"), var_13_4)
						setActive(arg_13_2:Find("isRepaired"), var_13_1)

						if arg_11_0.cityRebuildData.cityLevel >= arg_12_1 + 1 then
							arg_13_2:GetComponent(typeof(Toggle)).interactable = true

							onToggle(arg_11_0, arg_13_2, function(arg_14_0)
								if arg_14_0 then
									arg_11_0.showBuildingId = var_13_0.id

									setText(arg_11_0.buildingPage:Find("right/name"), var_13_4)
									GetImageSpriteFromAtlasAsync(var_13_2, "", arg_11_0.buildingPage:Find("right/iconBg/icon"))

									if var_13_1 then
										local var_14_0 = var_13_0.desc[2] or var_13_0.desc[1]

										setText(arg_11_0.buildingPage:Find("right/desc"), var_14_0)
										setActive(arg_11_0.buildingPage:Find("right/consumeTitle"), not var_13_1)
										setActive(arg_11_0.buildingPage:Find("right/consume"), not var_13_1)
										setActive(arg_11_0.buildingPage:Find("right/rebuildBtn"), not var_13_1)

										if not var_13_1 then
											updateDrop(arg_11_0.buildingPage:Find("right/consume/cost/mask/item"), {
												type = var_13_0.cost[1],
												id = var_13_0.cost[2],
												count = var_13_0.cost[3]
											})
											onButton(arg_11_0, arg_11_0.buildingPage:Find("right/consume/cost"), function()
												arg_11_0:emit(BaseUI.ON_DROP, var_0)

												return
											end, SFX_PANEL)

											local var_14_1 = arg_11_0.buildingPage:Find("right/consume/cost/mask/item/icon_bg/count"):GetComponent(typeof(Text))

											var_14_1.color = arg_11_0.virtualBagActivity:getVitemNumber(var_13_0.cost[2]) < var_13_0.cost[3] and Color.New(0.8352941176470589, 0.4627450980392157, 0.4627450980392157, 1) or Color.New(1, 1, 1, 1)

											updateDrop(arg_11_0.buildingPage:Find("right/consume/ptCost/mask/item"), {
												type = var_13_0.pt_cost[1],
												id = var_13_0.pt_cost[2],
												count = var_13_0.pt_cost[3]
											})
											onButton(arg_11_0, arg_11_0.buildingPage:Find("right/consume/ptCost"), function()
												arg_11_0:emit(BaseUI.ON_DROP, var_0)

												return
											end, SFX_PANEL)

											local var_14_2 = arg_11_0.buildingPage:Find("right/consume/ptCost/mask/item/icon_bg/count"):GetComponent(typeof(Text))

											var_14_2.color = arg_11_0.cityRebuildData.pt < var_13_0.pt_cost[3] and Color.New(0.8352941176470589, 0.4627450980392157, 0.4627450980392157, 1) or Color.New(1, 1, 1, 1)

											onButton(arg_11_0, arg_11_0.buildingPage:Find("right/rebuildBtn"), function()
												if var_0 < var_13_0.cost[3] or arg_11_0.cityRebuildData.pt < var_13_0.pt_cost[3] then
													pg.TipsMgr.GetInstance():ShowTips(i18n("ninja_game_update_failed"))

													return
												end

												arg_11_0:emit(CityRebuildBookMediator.REBUILD_OR_START_RECRUIT, arg_11_0.activityId, var_13_0.id, var_13_0.cost, var_13_0.pt_cost)

												return
											end, SFX_PANEL)
										end

										return
									end
								end
							end, SFX_PANEL)

							if arg_11_0.showBuildingId == var_13_0.id then
								triggerToggle(arg_13_2, true)
							end
						else
							arg_13_2:GetComponent(typeof(Toggle)).interactable = false
						end

						if arg_12_1 == 0 and arg_13_1 == 0 then
							arg_11_0.firstBuildingTg = arg_13_2
						end

						return
					end
				end
			end)
			var_12_3:align(#var_12_0)
		end

		return
	end)
	var_11_0:align(#arg_11_0.cityRebuildData.Levelbuildings)

	return
end

function var_0_0.RefreshCharaPage(arg_18_0)
	local var_18_0 = UIItemList.New(arg_18_0.charaPage:Find("left/charaScroll/Viewport/Content"), arg_18_0.charaPage:Find("left/charaScroll/Viewport/Content/city"))
	local var_18_1 = arg_18_0.cityRebuildData.Levelcharas

	var_18_0:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = var_18_1[arg_19_1 + 1]

			setActive(arg_19_2, #var_18_1[arg_19_1 + 1] > 0)

			if #var_19_0 > 0 then
				local var_19_1 = arg_18_0.cityRebuildData.cityLevel >= arg_19_1 + 1 and Color.New(1, 1, 1, 1) or Color.New(0.8196078431372549, 0.8196078431372549, 0.8196078431372549, 1)
				local var_19_2 = arg_19_2:Find("title/name")

				var_19_2:GetComponent(typeof(Text)).color = var_19_1
				arg_19_2:Find("title/name/Text"):GetComponent(typeof(Text)).color = var_19_1

				setText(arg_19_2:Find("title/name/Text"), "Lv." .. arg_19_1 + 1)
				setActive(arg_19_2:Find("title/name/lock"), arg_18_0.cityRebuildData.cityLevel < arg_19_1 + 1)

				local var_19_3 = UIItemList.New(arg_19_2:Find("charas"), arg_19_2:Find("charas/chara"))

				var_19_3:make(function(arg_20_0, arg_20_1, arg_20_2)
					if arg_20_0 == UIItemList.EventUpdate then
						local var_20_0 = pg.activity_ninja_building[var_19_0[arg_20_1 + 1]]
						local var_20_1 = table.contains(arg_18_0.cityRebuildData.roles, pg.activity_ninja_building[var_19_0[arg_20_1 + 1]].id)
						local var_20_2 = arg_18_0.cityRebuildData.recruiting[pg.activity_ninja_building[var_19_0[arg_20_1 + 1]].id] ~= nil
						local var_20_3 = false

						if arg_18_0.cityRebuildData.recruiting[pg.activity_ninja_building[var_19_0[arg_20_1 + 1]].id] ~= nil then
							var_20_3 = pg.TimeMgr.GetInstance():GetServerTime() - arg_18_0.cityRebuildData.recruiting[var_20_0.id] >= var_20_0.time
						end

						setActive(arg_20_2:Find("iconBg/time"), var_20_2 and not var_20_3)

						local var_20_4 = arg_18_0.cityRebuildData.recruiting[var_20_0.id]

						if var_20_2 and not var_20_3 then
							arg_18_0:StartTimers(function()
								local var_21_0 = pg.TimeMgr.GetInstance():GetServerTime() - var_20_4

								if var_21_0 < var_20_0.time then
									setText(arg_20_2:Find("iconBg/time/Text"), arg_18_0:DescCDTime(var_20_0.time - var_21_0))

									arg_20_2:Find("iconBg/time"):GetComponent(typeof(Image)).fillAmount = (var_20_0.time - var_21_0) / var_20_0.time
								else
									setActive(arg_20_2:Find("iconBg/time"), false)
									arg_18_0.timerList[var_20_0.id]:Stop()

									arg_18_0.timerList[var_20_0.id] = nil
								end

								return
							end, var_20_0.id)
						end

						setActive(arg_20_2:Find("iconBg/lock"), arg_18_0.cityRebuildData.cityLevel < arg_19_1 + 1)
						setActive(arg_20_2:Find("iconBg/icon"), arg_18_0.cityRebuildData.cityLevel >= arg_19_1 + 1)

						local var_20_5 = ""

						if arg_18_0.cityRebuildData.cityLevel >= arg_19_1 + 1 then
							var_20_5 = var_20_1 and var_20_0.handbook_pic[2] or var_20_0.handbook_pic[1]
						end

						if var_20_5 ~= "" then
							GetImageSpriteFromAtlasAsync(var_20_5, "", arg_20_2:Find("iconBg/icon"))
						end

						local var_20_6 = arg_20_2:Find("nameMask/name"):GetComponent(typeof(Text))

						var_20_6.color = arg_18_0.cityRebuildData.cityLevel >= arg_19_1 + 1 and Color.New(0, 0, 0, 1) or Color.New(0.34509803921568627, 0.3843137254901961, 0.4, 1)

						if var_20_1 then
							local var_20_7 = var_20_0.name[2] or var_20_0.name[1]

							setScrollText(arg_20_2:Find("nameMask/name"), var_20_7)
							setActive(arg_20_2:Find("isRepaired"), var_20_1)

							if arg_18_0.cityRebuildData.cityLevel >= arg_19_1 + 1 then
								arg_20_2:GetComponent(typeof(Toggle)).interactable = true

								onToggle(arg_18_0, arg_20_2, function(arg_22_0)
									if arg_22_0 then
										arg_18_0.showCharaId = var_20_0.id

										arg_18_0:RemoveTimer()
										setText(arg_18_0.charaPage:Find("right/name"), var_20_7)
										GetImageSpriteFromAtlasAsync(var_20_5, "", arg_18_0.charaPage:Find("right/iconBg/icon"))

										if var_20_1 then
											local var_22_0 = var_20_0.desc[2] or var_20_0.desc[1]

											setText(arg_18_0.charaPage:Find("right/desc"), var_22_0)
											setActive(arg_18_0.charaPage:Find("right/consumeTitle"), not var_20_1 and not var_20_2)
											setActive(arg_18_0.charaPage:Find("right/consume"), not var_20_1 and not var_20_2)
											setActive(arg_18_0.charaPage:Find("right/recruitBtn"), not var_20_1 and not var_20_2)

											if not var_20_1 and not var_20_2 then
												updateDrop(arg_18_0.charaPage:Find("right/consume/cost/mask/item"), {
													type = var_20_0.cost[1],
													id = var_20_0.cost[2],
													count = var_20_0.cost[3]
												})
												onButton(arg_18_0, arg_18_0.charaPage:Find("right/consume/cost"), function()
													arg_18_0:emit(BaseUI.ON_DROP, var_0)

													return
												end, SFX_PANEL)

												local var_22_1 = arg_18_0.charaPage:Find("right/consume/cost/mask/item/icon_bg/count"):GetComponent(typeof(Text))

												var_22_1.color = arg_18_0.virtualBagActivity:getVitemNumber(var_20_0.cost[2]) < var_20_0.cost[3] and Color.New(0.8352941176470589, 0.4627450980392157, 0.4627450980392157, 1) or Color.New(1, 1, 1, 1)

												updateDrop(arg_18_0.charaPage:Find("right/consume/ptCost/mask/item"), {
													type = var_20_0.pt_cost[1],
													id = var_20_0.pt_cost[2],
													count = var_20_0.pt_cost[3]
												})
												onButton(arg_18_0, arg_18_0.charaPage:Find("right/consume/ptCost"), function()
													arg_18_0:emit(BaseUI.ON_DROP, var_0)

													return
												end, SFX_PANEL)

												local var_22_2 = arg_18_0.charaPage:Find("right/consume/ptCost/mask/item/icon_bg/count"):GetComponent(typeof(Text))

												var_22_2.color = arg_18_0.cityRebuildData.pt < var_20_0.pt_cost[3] and Color.New(0.8352941176470589, 0.4627450980392157, 0.4627450980392157, 1) or Color.New(1, 1, 1, 1)

												onButton(arg_18_0, arg_18_0.charaPage:Find("right/recruitBtn"), function()
													if var_0 < var_20_0.cost[3] or arg_18_0.cityRebuildData.pt < var_20_0.pt_cost[3] then
														pg.TipsMgr.GetInstance():ShowTips(i18n("ninja_game_update_failed"))

														return
													end

													arg_18_0:emit(CityRebuildBookMediator.REBUILD_OR_START_RECRUIT, arg_18_0.activityId, var_20_0.id, var_20_0.cost, var_20_0.pt_cost)

													return
												end, SFX_PANEL)
											end

											if var_20_2 then
												local var_22_3 = pg.TimeMgr.GetInstance()

												var_20_3 = var_22_3:GetServerTime() - arg_18_0.cityRebuildData.recruiting[var_20_0.id] >= var_20_0.time
											end

											local var_22_5 = var_20_2 and not var_20_3

											var_22_4(arg_18_0.charaPage:Find("right/recruiting"), var_22_5)

											local var_22_6 = var_20_2 and var_20_3

											setActive(arg_18_0.charaPage:Find("right/endRecruitBtn"), var_22_6)

											if var_20_2 then
												if var_20_3 then
													local var_22_7 = {
														var_20_0.id
													}

													onButton(arg_18_0, arg_18_0.charaPage:Find("right/endRecruitBtn"), function()
														arg_18_0:emit(CityRebuildBookMediator.END_RECRUIT, arg_18_0.activityId, var_22_7)

														return
													end, SFX_PANEL)
												else
													arg_18_0:StartTimer(function()
														local var_27_0 = pg.TimeMgr.GetInstance():GetServerTime() - var_20_4

														if var_27_0 < var_20_0.time then
															setText(arg_18_0.charaPage:Find("right/recruiting/Text"), arg_18_0:DescCDTime(var_20_0.time - var_27_0))
														else
															setActive(arg_18_0.charaPage:Find("right/recruiting"), false)
															setActive(arg_18_0.charaPage:Find("right/endRecruitBtn"), true)

															local var_27_1 = {
																var_20_0.id
															}

															onButton(arg_18_0, arg_18_0.charaPage:Find("right/endRecruitBtn"), function()
																arg_18_0:emit(CityRebuildBookMediator.END_RECRUIT, arg_18_0.activityId, var_27_1)

																return
															end, SFX_PANEL)
															arg_18_0:RemoveTimer()
														end

														return
													end)
												end
											end

											return
										end
									end
								end, SFX_PANEL)

								if arg_18_0.showCharaId == var_20_0.id then
									triggerToggle(arg_20_2, true)
								end
							else
								arg_20_2:GetComponent(typeof(Toggle)).interactable = false
							end

							if arg_19_1 == 0 and arg_20_1 == 0 then
								arg_18_0.firstCharaTg = arg_20_2
							end

							return
						end
					end
				end)
				var_19_3:align(#var_19_0)
			end
		end

		return
	end)
	var_18_0:align(#arg_18_0.cityRebuildData.Levelcharas)

	return
end

function var_0_0.RefreshBuffPage(arg_29_0)
	arg_29_0:SetSummaryPanel()

	local var_29_0 = arg_29_0.cityRebuildData.buffs
	local var_29_1 = arg_29_0.cityRebuildData.buffLevels

	table.sort(arg_29_0.cityRebuildData.buffs, CompareFuncs({
		function(arg_30_0)
			return pg.activity_ninja_buff[arg_30_0].group
		end
	}))

	local var_29_2 = pg.activity_ninja_city[arg_29_0.cityRebuildData.cityLevel].buff
	local var_29_3 = UIItemList.New(arg_29_0.buffPage:Find("right/buffScroll/Viewport/Content"), arg_29_0.buffPage:Find("right/buffScroll/Viewport/Content/buff"))

	var_29_3:make(function(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_0 == UIItemList.EventUpdate then
			local var_31_0 = pg.activity_ninja_buff[var_29_0[arg_31_1 + 1]]
			local var_31_1 = pg.activity_ninja_buff[pg.activity_ninja_buff.get_id_list_by_group[arg_31_1 + 1][pg.activity_ninja_buff[var_29_0[arg_31_1 + 1]].level + 1]]
			local var_31_2 = var_29_2[arg_31_1 + 1]
			local var_31_3 = pg.activity_ninja_city[5].buff[arg_31_1 + 1]

			GetImageSpriteFromAtlasAsync(pg.activity_ninja_buff[var_29_0[arg_31_1 + 1]].icon, "", arg_31_2:Find("icon"))
			setText(arg_31_2:Find("name"), i18n(pg.activity_ninja_buff[pg.activity_ninja_buff.get_id_list_by_group[arg_31_1 + 1][1]].name))
			setText(arg_31_2:Find("level"), "LV." .. var_31_0.level)
			setText(arg_31_2:Find("desc"), i18n("ninja_buff_effect" .. var_31_0.group, string.format("%.2f", (switch(var_31_0.group, {
				function()
					return arg_29_0:GetParam(5)^(var_29_1[1] - 1)
				end,
				function()
					return arg_29_0:GetParam(6) * var_29_1[2]
				end,
				function()
					return (1 - arg_29_0:GetParam(11)^(var_29_1[3] - 1)) * 100
				end,
				function()
					return arg_29_0:GetParam(15)^var_29_1[4]
				end,
				function()
					return var_29_1[5]
				end,
				function()
					return arg_29_0:GetParam(7) * var_29_1[6] * 100
				end,
				function()
					return arg_29_0:GetParam(4) * var_29_1[7]
				end,
				function()
					return arg_29_0:GetParam(1)^(var_29_1[8] - 1)
				end,
				function()
					return arg_29_0:GetParam(3)^(var_29_1[9] - 1)
				end,
				function()
					return var_29_1[10]
				end
			})))))

			local var_31_5 = var_31_2 > var_31_0.level and var_31_1

			setActive(arg_31_2:Find("nextLevelPt"), var_31_2 > var_31_0.level and var_31_1)
			setActive(arg_31_2:Find("upgradeBtn"), var_31_5)
			setActive(arg_31_2:Find("upgradeTenBtn"), var_31_5)
			setActive(arg_31_2:Find("levelMax"), not var_31_5)

			if var_31_0.level == var_31_3 then
				setActive(arg_31_2:Find("levelMax"), false)
			end

			if var_31_5 then
				setText(arg_31_2:Find("nextLevelPt/Text"), (math.ceil(var_31_1.basic_cost * var_31_1.cost^(var_31_1.level - 1) * (1 - arg_29_0:GetParam(7) * var_29_1[6]))))
				onButton(arg_29_0, arg_31_2:Find("upgradeBtn"), function()
					if arg_29_0.cityRebuildData.pt < var_0 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("ninja_game_update_failed"))

						return
					end

					arg_29_0:emit(CityRebuildBookMediator.UPGRADE_BUFF, arg_29_0.activityId, arg_31_1 + 1, 1, var_0)

					return
				end, SFX_PANEL)
				onButton(arg_29_0, arg_31_2:Find("upgradeTenBtn"), function()
					local var_43_0 = 1
					local var_43_1 = var_0

					for iter_43_0 = 2, 10 do
						if var_31_0.level + iter_43_0 > var_31_2 or not pg.activity_ninja_buff[var_0[var_31_0.level + iter_43_0]] then
							break
						end

						var_43_0 = var_43_0 + 1
						var_43_1 = arg_31_1 + 1 == 6 and var_43_1 + math.ceil(pg.activity_ninja_buff[var_0[var_31_0.level + iter_43_0]].basic_cost * pg.activity_ninja_buff[var_0[var_31_0.level + iter_43_0]].cost^(pg.activity_ninja_buff[var_0[var_31_0.level + iter_43_0]].level - 1) * (1 - arg_29_0:GetParam(7) * (var_31_0.level + iter_43_0 - 1))) or var_43_1 + math.ceil(pg.activity_ninja_buff[var_0[var_31_0.level + iter_43_0]].basic_cost * pg.activity_ninja_buff[var_0[var_31_0.level + iter_43_0]].cost^(pg.activity_ninja_buff[var_0[var_31_0.level + iter_43_0]].level - 1) * (1 - arg_29_0:GetParam(7) * var_29_1[6]))
					end

					if var_43_1 > arg_29_0.cityRebuildData.pt then
						pg.TipsMgr.GetInstance():ShowTips(i18n("ninja_game_update_failed"))

						return
					end

					arg_29_0:emit(CityRebuildBookMediator.UPGRADE_BUFF, arg_29_0.activityId, arg_31_1 + 1, var_43_0, var_43_1)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	var_29_3:align(#arg_29_0.cityRebuildData.buffs)

	return
end

function var_0_0.SetSummaryPanel(arg_44_0)
	local var_44_0 = arg_44_0.cityRebuildData.buildings
	local var_44_1 = arg_44_0.cityRebuildData.roles
	local var_44_2 = arg_44_0.cityRebuildData.buffLevels
	local var_44_3 = arg_44_0.cityRebuildData.curLevel
	local var_44_4 = arg_44_0.cityRebuildData.curLevel % 5 == 0
	local var_44_5 = 0
	local var_44_6 = pg.activity_ninja_enemy[arg_44_0.cityRebuildData.curLevel].basic
	local var_44_8
	local var_44_11
	local var_44_9
	local var_44_10

	if arg_44_0.cityRebuildData.curLevel < 51 then
		local var_44_7 = var_44_4 and arg_44_0:GetParam(10) or 1

		var_44_5 = math.ceil(var_44_6 * (var_44_3 - 1 + arg_44_0:GetParam(9)^(var_44_3 - 1)) * var_44_7 * arg_44_0:GetParam(11)^(var_44_2[3] - 1))

		goto label_44_0

		var_44_8 = var_44_4 and arg_44_0:GetParam(10) or 1
	end

	var_44_5 = math.ceil(var_44_6 * (arg_44_0:GetParam(16) + arg_44_0:GetParam(9)^arg_44_0:GetParam(16) * arg_44_0:GetParam(13)^(var_44_3 - (arg_44_0:GetParam(16) + 1))) * var_44_8 * arg_44_0:GetParam(11)^(var_44_2[3] - 1))

	do
		var_44_9 = math.ceil((#var_44_0 + var_44_2[10] + (#var_44_0 + var_44_2[10]) * arg_44_0:GetParam(1)^(var_44_2[8] - 1) / arg_44_0:GetParam(2)) * arg_44_0:GetParam(3)^(var_44_2[9] - 1) + arg_44_0:GetParam(4) * var_44_2[7])
		var_44_10 = math.ceil((#var_44_1 + var_44_2[5]) * arg_44_0:GetParam(5)^(var_44_2[1] - 1) + arg_44_0:GetParam(6) * var_44_2[2])
		var_44_11 = math.ceil(var_44_5 / (var_44_9 + var_44_10))
	end

	::label_44_0::

	setText(arg_44_0.buffPage:Find("left/panel/buildingDPS/Text"), var_44_9)
	setText(arg_44_0.buffPage:Find("left/panel/charaDPS/Text"), var_44_10)
	setText(arg_44_0.buffPage:Find("left/panel/DPS/Text"), var_44_9 + var_44_10)
	setText(arg_44_0.buffPage:Find("left/panel/time/Text"), var_44_11 .. "s")
	setText(arg_44_0.buffPage:Find("left/panel/pts/Text"), "+" .. var_44_12 .. "/s")
	setText(arg_44_0.buffPage:Find("left/panel/pt/Text"), (CityRebuildData.PtToShow(arg_44_0.cityRebuildData.pt)))

	return
end

function var_0_0.GetParam(arg_45_0, arg_45_1)
	if pg.gameset["ninja_Param" .. arg_45_1].key_value ~= 0 then
		return pg.gameset["ninja_Param" .. arg_45_1].key_value or tonumber(pg.gameset["ninja_Param" .. arg_45_1].description)
	end
end

function var_0_0.StartTimer(arg_46_0, arg_46_1)
	arg_46_0.timer = Timer.New(arg_46_1, 1, -1)

	arg_46_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_47_0)
	if arg_47_0.timer then
		arg_47_0.timer:Stop()

		arg_47_0.timer = nil
	end

	return
end

function var_0_0.StartTimers(arg_48_0, arg_48_1, arg_48_2)
	arg_48_0.timerList = arg_48_0.timerList or {}

	local var_48_0 = Timer.New(arg_48_1, 1, -1)

	var_48_0:Start()

	arg_48_0.timerList[arg_48_2] = var_48_0

	return
end

function var_0_0.RemoveAllTimers(arg_49_0)
	if arg_49_0.timerList then
		for iter_49_0, iter_49_1 in pairs(arg_49_0.timerList) do
			iter_49_1:Stop()
		end

		arg_49_0.timerList = {}
	end

	return
end

function var_0_0.DescCDTime(arg_50_0, arg_50_1)
	arg_50_1 = arg_50_1 % 60

	return string.format("%02d:%02d", math.floor(arg_50_1 / 60), arg_50_1)
end

function var_0_0.willExit(arg_51_0)
	arg_51_0:RemoveTimer()
	arg_51_0:RemoveAllTimers()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_51_0._tf)

	return
end

function var_0_0.ShouldShowTip()
	local var_52_0 = getProxy(CityRebuildProxy):GetData(ActivityConst.NINJA_CITY_ACT_ID)

	if not var_52_0 then
		return false
	end

	for iter_52_0, iter_52_1 in pairs(var_52_0.recruiting) do
		local var_52_1 = pg.TimeMgr.GetInstance()

		if var_52_1:GetServerTime() - iter_52_1 >= pg.activity_ninja_building[iter_52_0].time then
			return true
		end
	end

	return false
end

return var_0_0
