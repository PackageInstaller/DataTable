class = var_0_10000

local var_0_0 = "CityRebuildBookLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.Building = "building"
var_0_1.Chara = "chara"
var_0_1.Buff = "buff"

function var_0_1.getUIName(arg_1_0)
	return "CityRebuildBookUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_1, "panel/closeBtn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.buildingTg = var_1.Find(var_2_2, "panel/switch/building")

	local var_2_3 = arg_2_0._tf

	arg_2_0.charaTg = var_1.Find(var_2_3, "panel/switch/chara")

	local var_2_4 = arg_2_0._tf

	arg_2_0.buffTg = var_1.Find(var_2_4, "panel/switch/buff")

	local var_2_5 = arg_2_0._tf

	arg_2_0.buildingPage = var_1.Find(var_2_5, "panel/subPages/buildingPage")

	local var_2_6 = arg_2_0._tf

	arg_2_0.charaPage = var_1.Find(var_2_6, "panel/subPages/charaPage")

	local var_2_7 = arg_2_0._tf

	arg_2_0.buffPage = var_1.Find(var_2_7, "panel/subPages/buffPage")
	setText = var_1

	local var_2_8 = arg_2_0.buildingPage
	local var_2_9 = var_3.Find(var_2_8, "left/buildingScroll/Viewport/Content/city/title/name")

	i18n = var_4

	var_1(var_2_9, var_4("ninja_game_citylevel") .. ":")

	setText = var_1

	local var_2_10 = arg_2_0.charaPage
	local var_2_11 = var_3.Find(var_2_10, "left/charaScroll/Viewport/Content/city/title/name")

	i18n = var_4

	var_1(var_2_11, var_4("ninja_game_citylevel") .. ":")

	setText = var_1

	local var_2_12 = arg_2_0.buildingPage
	local var_2_13 = var_3.Find(var_2_12, "right/consumeTitle/Text")

	i18n = var_4

	var_1(var_2_13, var_4("ninja_game_buildcost"))

	setText = var_1

	local var_2_14 = arg_2_0.charaPage
	local var_2_15 = var_3.Find(var_2_14, "right/consumeTitle/Text")

	i18n = var_4

	var_1(var_2_15, var_4("ninja_game_allycost"))

	setText = var_1

	local var_2_16 = arg_2_0.buffPage
	local var_2_17 = var_3.Find(var_2_16, "left/panel/buildingDPS")

	i18n = var_4

	var_1(var_2_17, var_4("ninja_game_citydmg"))

	setText = var_1

	local var_2_18 = arg_2_0.buffPage
	local var_2_19 = var_3.Find(var_2_18, "left/panel/charaDPS")

	i18n = var_4

	var_1(var_2_19, var_4("ninja_game_allydmg"))

	setText = var_1

	local var_2_20 = arg_2_0.buffPage
	local var_2_21 = var_3.Find(var_2_20, "left/panel/DPS")

	i18n = var_4

	var_1(var_2_21, var_4("ninja_game_dps"))

	setText = var_1

	local var_2_22 = arg_2_0.buffPage
	local var_2_23 = var_3.Find(var_2_22, "left/panel/time")

	i18n = var_4

	var_1(var_2_23, var_4("ninja_game_time"))

	setText = var_1

	local var_2_24 = arg_2_0.buffPage
	local var_2_25 = var_3.Find(var_2_24, "left/panel/pts")

	i18n = var_4

	var_1(var_2_25, var_4("ninja_game_income"))

	setText = var_1

	local var_2_26 = arg_2_0.buffPage
	local var_2_27 = var_3.Find(var_2_26, "left/panel/pt")

	i18n = var_4

	var_1(var_2_27, var_4("ninja_game_ptcount"))

	setText = var_1

	local var_2_28 = arg_2_0.buffPage
	local var_2_29 = var_3.Find(var_2_28, "right/buffScroll/Viewport/Content/buff/descTitle")

	i18n = var_4

	var_1(var_2_29, var_4("ninja_game_buffeffect"))

	setText = var_1

	local var_2_30 = arg_2_0.buffPage
	local var_2_31 = var_3.Find(var_2_30, "right/buffScroll/Viewport/Content/buff/nextLevelPt/title")

	i18n = var_4

	var_1(var_2_31, var_4("ninja_game_buffcost"))

	setText = var_1

	local var_2_32 = arg_2_0.buffPage
	local var_2_33 = var_3.Find(var_2_32, "right/buffScroll/Viewport/Content/buff/levelMax")

	i18n = var_4

	var_1(var_2_33, var_4("ninja_game_levelblock"))

	pg = var_1

	local var_2_34 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_34, arg_2_0._tf)

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:InitData()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.bg

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	onToggle = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.buildingTg

	local function var_3_8(arg_6_0)
		setActive = var_2_10001

		var_2_10001(arg_3_0.buildingPage, arg_6_0)

		setActive = var_2_10001

		var_2_10001(arg_3_0.charaPage, not arg_6_0)

		setActive = var_2_10001

		var_2_10001(arg_3_0.buffPage, not arg_6_0)

		if arg_6_0 then
			if arg_3_0.page ~= var_0_1.Building then
				triggerToggle = var_1

				var_1(arg_3_0.firstBuildingTg, true)
			end

			arg_3_0.page = var_0_1.Building
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_6, var_3_7, var_3_8, var_1_10006)

	onToggle = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.charaTg

	local function var_3_11(arg_7_0)
		setActive = var_2_10001

		var_2_10001(arg_3_0.buildingPage, not arg_7_0)

		setActive = var_2_10001

		var_2_10001(arg_3_0.charaPage, arg_7_0)

		setActive = var_2_10001

		var_2_10001(arg_3_0.buffPage, not arg_7_0)

		if arg_7_0 then
			if arg_3_0.page ~= var_0_1.Chara then
				triggerToggle = var_1

				var_1(arg_3_0.firstCharaTg, true)
			end

			arg_3_0.page = var_0_1.Chara
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_9, var_3_10, var_3_11, var_1_10006)

	onToggle = var_1

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.buffTg

	local function var_3_14(arg_8_0)
		setActive = var_2_10001

		var_2_10001(arg_3_0.buildingPage, not arg_8_0)

		setActive = var_2_10001

		var_2_10001(arg_3_0.charaPage, not arg_8_0)

		setActive = var_2_10001

		var_2_10001(arg_3_0.buffPage, arg_8_0)

		if arg_8_0 then
			arg_3_0.page = var_0_1.Buff
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_12, var_3_13, var_3_14, var_1_10006)
	arg_3_0:Refresh()

	return
end

function var_0_1.InitData(arg_9_0)
	ActivityConst = var_1_10001
	arg_9_0.activityId = var_1_10001.NINJA_CITY_ACT_ID
	getProxy = var_1
	CityRebuildProxy = var_1_10003
	arg_9_0.cityRebuildProxy = var_1(var_1_10003)

	local var_9_0 = arg_9_0.cityRebuildProxy

	arg_9_0.cityRebuildData = var_1.GetData(var_9_0, arg_9_0.activityId)

	local var_9_1

	if not arg_9_0.contextData.page then
		var_9_1 = var_0_1.Building
	end

	arg_9_0.page = var_9_1

	if arg_9_0.page == var_0_1.Building then
		arg_9_0.showBuildingId = arg_9_0.contextData.showId
	elseif arg_9_0.page == var_0_1.Chara then
		arg_9_0.showCharaId = arg_9_0.contextData.showId
	end

	if not arg_9_0.showBuildingId then
		arg_9_0.showBuildingId = arg_9_0.cityRebuildData.Levelbuildings[1][1]
	end

	if not arg_9_0.showCharaId then
		arg_9_0.showCharaId = arg_9_0.cityRebuildData.Levelcharas[1][1]
	end

	return
end

function var_0_1.Refresh(arg_10_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_10_0 = var_1_10001(var_1_10003)

	arg_10_0.virtualBagActivity = var_1.getActivityById(var_10_0, arg_10_0.activityId)

	arg_10_0:RemoveTimer()
	arg_10_0:RemoveAllTimers()
	arg_10_0:RefreshBuildingPage()
	arg_10_0:RefreshCharaPage()
	arg_10_0:RefreshBuffPage()

	triggerToggle = var_1

	local var_10_1 = arg_10_0._tf

	var_1(var_3.Find(var_10_1, "panel/switch/" .. arg_10_0.page), true)

	setActive = var_1

	local var_10_2 = arg_10_0.charaTg

	var_1(var_3.Find(var_10_2, "tip"), var_0_1.ShouldShowTip())

	return
end

function var_0_1.RefreshBuildingPage(arg_11_0)
	UIItemList = var_1_10001

	local var_11_0 = var_1_10001.New
	local var_11_1 = arg_11_0.buildingPage
	local var_11_2 = var_3.Find(var_11_1, "left/buildingScroll/Viewport/Content")
	local var_11_3 = arg_11_0.buildingPage
	local var_11_4 = var_11_0(var_11_2, var_4.Find(var_11_3, "left/buildingScroll/Viewport/Content/city"))
	local var_11_5 = arg_11_0.cityRebuildData.Levelbuildings

	var_11_4:make(function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = var_11_5[arg_12_1 + 1]

			if arg_11_0.cityRebuildData.cityLevel >= arg_12_1 + 1 then
				Color = var_12_1

				local var_12_1

				if not var_12_1.New(1, 1, 1, 1) then
					Color = var_12_1
					var_12_1 = var_12_1.New(0.8196078431372549, 0.8196078431372549, 0.8196078431372549, 1)
				end

				local var_12_2 = arg_12_2:Find("title/name")
				local var_12_3 = var_5.GetComponent

				typeof = var_8
				Text = var_2_10010
				var_12_3(var_12_2, var_8(var_2_10010)).color = var_12_1

				local var_12_4 = arg_12_2:Find("title/name/Text")
				local var_12_5 = var_5.GetComponent

				typeof = var_8
				Text = var_2_10010

				local var_12_6 = var_12_5(var_12_4, var_8(var_2_10010))

				var_12_6.color = var_12_1
				setText = var_12_6

				var_12_6(arg_12_2:Find("title/name/Text"), "Lv." .. arg_12_1 + 1)

				setActive = var_12_6

				var_12_6(arg_12_2:Find("title/name/lock"), arg_11_0.cityRebuildData.cityLevel < arg_12_1 + 1)

				UIItemList = var_12_6

				local var_12_7 = var_12_6.New(arg_12_2:Find("buildings"), arg_12_2:Find("buildings/building"))

				var_5.make(var_12_7, function(arg_13_0, arg_13_1, arg_13_2)
					UIItemList = var_3_10003

					if arg_13_0 == var_3_10003.EventUpdate then
						pg = var_3

						local var_13_0 = var_3.activity_ninja_building[var_12_0[arg_13_1 + 1]]

						table = var_4

						local var_13_1 = var_4.contains(arg_11_0.cityRebuildData.buildings, var_13_0.id)

						setActive = var_5

						var_5(arg_13_2:Find("iconBg/lock"), arg_11_0.cityRebuildData.cityLevel < arg_12_1 + 1)

						setActive = var_5

						var_5(arg_13_2:Find("iconBg/icon"), arg_11_0.cityRebuildData.cityLevel >= arg_12_1 + 1)

						local var_13_2 = ""

						if arg_11_0.cityRebuildData.cityLevel >= arg_12_1 + 1 then
							var_13_2 = var_13_1 and var_13_0.handbook_pic[2] or var_13_0.handbook_pic[1]
						end

						if var_13_2 ~= "" then
							GetImageSpriteFromAtlasAsync = var_6

							var_6(var_13_2, "", arg_13_2:Find("iconBg/icon"))
						end

						local var_13_3 = arg_13_2:Find("nameMask/name")
						local var_13_4 = var_6.GetComponent

						typeof = var_9
						Text = var_3_10011

						local var_13_5 = var_13_4(var_13_3, var_9(var_3_10011))

						if arg_11_0.cityRebuildData.cityLevel >= arg_12_1 + 1 then
							Color = var_13_6

							local var_13_6

							if not var_13_6.New(0, 0, 0, 1) then
								Color = var_13_6
								var_13_6 = var_13_6.New(0.34509803921568627, 0.3843137254901961, 0.4, 1)
							end

							var_13_5.color = var_13_6

							local var_13_7

							if not var_13_1 or not var_13_0.name[2] then
								var_13_7 = var_13_0.name[1]
							end

							setScrollText = var_13_6

							var_13_6(arg_13_2:Find("nameMask/name"), var_13_7)

							setActive = var_13_6

							var_13_6(arg_13_2:Find("isRepaired"), var_13_1)

							local var_13_12

							if arg_11_0.cityRebuildData.cityLevel >= arg_12_1 + 1 then
								local var_13_8 = arg_13_2
								local var_13_9 = arg_13_2.GetComponent

								typeof = var_13_12
								Toggle = var_12

								local var_13_10 = var_13_9(var_13_8, var_13_12(var_12))

								var_13_10.interactable = true
								onToggle = var_13_10

								local var_13_11 = arg_11_0

								var_13_12 = arg_13_2

								local function var_13_13(arg_14_0)
									if arg_14_0 then
										local var_14_0 = arg_11_0

										var_14_0.showBuildingId = var_13_0.id
										setText = var_14_0

										local var_14_1 = arg_11_0.buildingPage

										var_14_0(var_3.Find(var_14_1, "right/name"), var_13_7)

										GetImageSpriteFromAtlasAsync = var_14_0

										local var_14_2 = var_13_2
										local var_14_3 = ""
										local var_14_4 = arg_11_0.buildingPage

										var_14_0(var_14_2, var_14_3, var_5.Find(var_14_4, "right/iconBg/icon"))

										local var_14_5

										if not var_13_1 or not var_13_0.desc[2] then
											var_14_5 = var_13_0.desc[1]
										end

										setText = var_2

										local var_14_6 = arg_11_0.buildingPage

										var_2(var_4.Find(var_14_6, "right/desc"), var_14_5)

										setActive = var_2

										local var_14_7 = arg_11_0.buildingPage

										var_2(var_4.Find(var_14_7, "right/consumeTitle"), not var_13_1)

										setActive = var_2

										local var_14_8 = arg_11_0.buildingPage

										var_2(var_4.Find(var_14_8, "right/consume"), not var_13_1)

										setActive = var_2

										local var_14_9 = arg_11_0.buildingPage

										var_2(var_4.Find(var_14_9, "right/rebuildBtn"), not var_13_1)

										if not var_13_1 then
											local var_14_10 = {
												type = var_13_0.cost[1],
												id = var_13_0.cost[2],
												count = var_13_0.cost[3]
											}

											updateDrop = var_3

											local var_14_11 = arg_11_0.buildingPage

											var_3(var_5.Find(var_14_11, "right/consume/cost/mask/item"), var_14_10)

											onButton = var_3

											local var_14_12 = arg_11_0
											local var_14_13 = arg_11_0.buildingPage
											local var_14_14 = var_6.Find(var_14_13, "right/consume/cost")

											local function var_14_15()
												local var_15_0 = arg_11_0
												local var_15_1 = var_0.emit

												BaseUI = var_5_10003

												var_15_1(var_15_0, var_5_10003.ON_DROP, var_14_10)

												return
											end

											SFX_PANEL = var_14_13

											var_3(var_14_12, var_14_14, var_14_15, var_14_13)

											local var_14_16 = arg_11_0.virtualBagActivity
											local var_14_17 = var_3.getVitemNumber(var_14_16, var_13_0.cost[2])
											local var_14_18 = arg_11_0.buildingPage
											local var_14_19 = var_4.Find(var_14_18, "right/consume/cost/mask/item/icon_bg/count")
											local var_14_20 = var_4.GetComponent

											typeof = var_7
											Text = var_9

											local var_14_21 = var_14_20(var_14_19, var_7(var_9))

											if var_14_17 < var_13_0.cost[3] then
												Color = var_14_22

												local var_14_22

												if not var_14_22.New(0.8352941176470589, 0.4627450980392157, 0.4627450980392157, 1) then
													Color = var_14_22
													var_14_22 = var_14_22.New(1, 1, 1, 1)
												end

												var_14_21.color = var_14_22

												local var_14_23 = {
													type = var_13_0.pt_cost[1],
													id = var_13_0.pt_cost[2],
													count = var_13_0.pt_cost[3]
												}

												updateDrop = var_5

												local var_14_24 = arg_11_0.buildingPage

												var_5(var_7.Find(var_14_24, "right/consume/ptCost/mask/item"), var_14_23)

												onButton = var_5

												local var_14_25 = arg_11_0
												local var_14_26 = arg_11_0.buildingPage
												local var_14_27 = var_8.Find(var_14_26, "right/consume/ptCost")

												local function var_14_28()
													local var_16_0 = arg_11_0
													local var_16_1 = var_0.emit

													BaseUI = var_5_10003

													var_16_1(var_16_0, var_5_10003.ON_DROP, var_14_23)

													return
												end

												SFX_PANEL = var_14_26

												var_5(var_14_25, var_14_27, var_14_28, var_14_26)

												local var_14_29 = arg_11_0.buildingPage
												local var_14_30 = var_5.Find(var_14_29, "right/consume/ptCost/mask/item/icon_bg/count")
												local var_14_31 = var_5.GetComponent

												typeof = var_8
												Text = var_14_26

												local var_14_32 = var_14_31(var_14_30, var_8(var_14_26))

												if arg_11_0.cityRebuildData.pt < var_13_0.pt_cost[3] then
													Color = var_14_33

													local var_14_33

													if not var_14_33.New(0.8352941176470589, 0.4627450980392157, 0.4627450980392157, 1) then
														Color = var_14_33
														var_14_33 = var_14_33.New(1, 1, 1, 1)
													end

													var_14_32.color = var_14_33
													onButton = var_14_32

													local var_14_34 = arg_11_0
													local var_14_35 = arg_11_0.buildingPage
													local var_14_36 = var_8.Find(var_14_35, "right/rebuildBtn")

													local function var_14_37()
														if var_14_17 < var_13_0.cost[3] or arg_11_0.cityRebuildData.pt < var_13_0.pt_cost[3] then
															pg = var_0

															local var_17_0 = var_0.TipsMgr.GetInstance()
															local var_17_1 = var_0.ShowTips

															i18n = var_5_10003

															var_17_1(var_17_0, var_5_10003("ninja_game_update_failed"))

															return
														end

														local var_17_2 = arg_11_0
														local var_17_3 = var_0.emit

														CityRebuildBookMediator = var_5_10003

														var_17_3(var_17_2, var_5_10003.REBUILD_OR_START_RECRUIT, arg_11_0.activityId, var_13_0.id, var_13_0.cost, var_13_0.pt_cost)

														return
													end

													SFX_PANEL = var_14_35

													var_14_32(var_14_34, var_14_36, var_14_37, var_14_35)

													return
												end
											end
										end
									end
								end

								SFX_PANEL = var_12

								var_13_10(var_13_11, var_13_12, var_13_13, var_12)

								if arg_11_0.showBuildingId == var_13_0.id then
									triggerToggle = var_7

									var_7(arg_13_2, true)
								end
							else
								local var_13_14 = arg_13_2
								local var_13_15 = arg_13_2.GetComponent

								typeof = var_13_12
								Toggle = var_12
								var_13_15(var_13_14, var_13_12(var_12)).interactable = false
							end

							if arg_12_1 == 0 and arg_13_1 == 0 then
								arg_11_0.firstBuildingTg = arg_13_2
							end

							return
						end
					end
				end)
				var_5:align(#var_12_0)

				return
			end
		end
	end)
	var_11_4:align(#var_11_5)

	return
end

function var_0_1.RefreshCharaPage(arg_18_0)
	UIItemList = var_1_10001

	local var_18_0 = var_1_10001.New
	local var_18_1 = arg_18_0.charaPage
	local var_18_2 = var_3.Find(var_18_1, "left/charaScroll/Viewport/Content")
	local var_18_3 = arg_18_0.charaPage
	local var_18_4 = var_18_0(var_18_2, var_4.Find(var_18_3, "left/charaScroll/Viewport/Content/city"))
	local var_18_5 = arg_18_0.cityRebuildData.Levelcharas

	var_18_4:make(function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = var_18_5[arg_19_1 + 1]

			setActive = var_4

			var_4(arg_19_2, #var_19_0 > 0)

			if #var_19_0 > 0 then
				if arg_18_0.cityRebuildData.cityLevel >= arg_19_1 + 1 then
					Color = var_19_1

					local var_19_1

					if not var_19_1.New(1, 1, 1, 1) then
						Color = var_19_1
						var_19_1 = var_19_1.New(0.8196078431372549, 0.8196078431372549, 0.8196078431372549, 1)
					end

					local var_19_2 = arg_19_2:Find("title/name")
					local var_19_3 = var_5.GetComponent

					typeof = var_8
					Text = var_2_10010
					var_19_3(var_19_2, var_8(var_2_10010)).color = var_19_1

					local var_19_4 = arg_19_2:Find("title/name/Text")
					local var_19_5 = var_5.GetComponent

					typeof = var_8
					Text = var_2_10010

					local var_19_6 = var_19_5(var_19_4, var_8(var_2_10010))

					var_19_6.color = var_19_1
					setText = var_19_6

					var_19_6(arg_19_2:Find("title/name/Text"), "Lv." .. arg_19_1 + 1)

					setActive = var_19_6

					var_19_6(arg_19_2:Find("title/name/lock"), arg_18_0.cityRebuildData.cityLevel < arg_19_1 + 1)

					UIItemList = var_19_6

					local var_19_7 = var_19_6.New(arg_19_2:Find("charas"), arg_19_2:Find("charas/chara"))

					var_5.make(var_19_7, function(arg_20_0, arg_20_1, arg_20_2)
						UIItemList = var_3_10003

						if arg_20_0 == var_3_10003.EventUpdate then
							pg = var_3

							local var_20_0 = var_3.activity_ninja_building[var_19_0[arg_20_1 + 1]]

							table = var_4

							local var_20_1 = var_4.contains(arg_18_0.cityRebuildData.roles, var_20_0.id)
							local var_20_2 = arg_18_0.cityRebuildData.recruiting[var_20_0.id] ~= nil
							local var_20_3 = false

							if var_20_2 then
								pg = var_7

								local var_20_4 = var_7.TimeMgr.GetInstance()

								var_20_3 = var_7.GetServerTime(var_20_4) - arg_18_0.cityRebuildData.recruiting[var_20_0.id] >= var_20_0.time
							end

							setActive = var_7

							var_7(arg_20_2:Find("iconBg/time"), var_20_2 and not var_20_3)

							local var_20_5 = arg_18_0.cityRebuildData.recruiting[var_20_0.id]

							if var_20_2 and not var_20_3 then
								local var_20_6 = arg_18_0

								var_8.StartTimers(var_20_6, function()
									pg = var_4_10000

									local var_21_0 = var_4_10000.TimeMgr.GetInstance()
									local var_21_6

									if var_0.GetServerTime(var_21_0) - var_20_5 < var_20_0.time then
										setText = var_21_6

										local var_21_1 = arg_20_2
										local var_21_2 = var_3.Find(var_21_1, "iconBg/time/Text")
										local var_21_3 = arg_18_0

										var_21_6(var_21_2, var_4.DescCDTime(var_21_3, var_20_0.time - var_0))

										local var_21_4 = arg_20_2
										local var_21_5 = var_21_6.Find(var_21_4, "iconBg/time")

										var_21_6 = var_21_6.GetComponent
										typeof = var_4
										Image = var_21_3
										var_21_6 = var_21_6(var_21_5, var_4(var_21_3))
										var_21_6.fillAmount = (var_20_0.time - var_0) / var_20_0.time
									else
										setActive = var_21_6

										local var_21_7 = arg_20_2

										var_21_6(var_3.Find(var_21_7, "iconBg/time"), false)

										local var_21_8 = arg_18_0.timerList[var_20_0.id]

										var_1.Stop(var_21_8)

										arg_18_0.timerList[var_20_0.id] = nil
									end

									return
								end, var_20_0.id)
							end

							setActive = var_8

							var_8(arg_20_2:Find("iconBg/lock"), arg_18_0.cityRebuildData.cityLevel < arg_19_1 + 1)

							setActive = var_8

							var_8(arg_20_2:Find("iconBg/icon"), arg_18_0.cityRebuildData.cityLevel >= arg_19_1 + 1)

							local var_20_7 = ""

							if arg_18_0.cityRebuildData.cityLevel >= arg_19_1 + 1 then
								var_20_7 = var_20_1 and var_20_0.handbook_pic[2] or var_20_0.handbook_pic[1]
							end

							if var_20_7 ~= "" then
								GetImageSpriteFromAtlasAsync = var_9

								var_9(var_20_7, "", arg_20_2:Find("iconBg/icon"))
							end

							local var_20_8 = arg_20_2:Find("nameMask/name")
							local var_20_9 = var_9.GetComponent

							typeof = var_12
							Text = var_3_10014

							local var_20_10 = var_20_9(var_20_8, var_12(var_3_10014))

							if arg_18_0.cityRebuildData.cityLevel >= arg_19_1 + 1 then
								Color = var_20_11

								local var_20_11

								if not var_20_11.New(0, 0, 0, 1) then
									Color = var_20_11
									var_20_11 = var_20_11.New(0.34509803921568627, 0.3843137254901961, 0.4, 1)
								end

								var_20_10.color = var_20_11

								local var_20_12

								if not var_20_1 or not var_20_0.name[2] then
									var_20_12 = var_20_0.name[1]
								end

								setScrollText = var_20_11

								var_20_11(arg_20_2:Find("nameMask/name"), var_20_12)

								setActive = var_20_11

								var_20_11(arg_20_2:Find("isRepaired"), var_20_1)

								local var_20_17

								if arg_18_0.cityRebuildData.cityLevel >= arg_19_1 + 1 then
									local var_20_13 = arg_20_2
									local var_20_14 = arg_20_2.GetComponent

									typeof = var_20_17
									Toggle = var_15

									local var_20_15 = var_20_14(var_20_13, var_20_17(var_15))

									var_20_15.interactable = true
									onToggle = var_20_15

									local var_20_16 = arg_18_0

									var_20_17 = arg_20_2

									local function var_20_18(arg_22_0)
										if arg_22_0 then
											arg_18_0.showCharaId = var_20_0.id

											local var_22_0 = arg_18_0

											var_1.RemoveTimer(var_22_0)

											setText = var_1

											local var_22_1 = arg_18_0.charaPage

											var_1(var_3.Find(var_22_1, "right/name"), var_20_12)

											GetImageSpriteFromAtlasAsync = var_1

											local var_22_2 = var_20_7
											local var_22_3 = ""
											local var_22_4 = arg_18_0.charaPage

											var_1(var_22_2, var_22_3, var_5.Find(var_22_4, "right/iconBg/icon"))

											local var_22_5

											if not var_20_1 or not var_20_0.desc[2] then
												var_22_5 = var_20_0.desc[1]
											end

											setText = var_2

											local var_22_6 = arg_18_0.charaPage

											var_2(var_4.Find(var_22_6, "right/desc"), var_22_5)

											setActive = var_2

											local var_22_7 = arg_18_0.charaPage

											var_2(var_4.Find(var_22_7, "right/consumeTitle"), not var_20_1 and not var_20_2)

											setActive = var_2

											local var_22_8 = arg_18_0.charaPage

											var_2(var_4.Find(var_22_8, "right/consume"), not var_20_1 and not var_20_2)

											setActive = var_2

											local var_22_9 = arg_18_0.charaPage

											var_2(var_4.Find(var_22_9, "right/recruitBtn"), not var_20_1 and not var_20_2)

											if not var_20_1 and not var_20_2 then
												local var_22_10 = {
													type = var_20_0.cost[1],
													id = var_20_0.cost[2],
													count = var_20_0.cost[3]
												}

												updateDrop = var_3

												local var_22_11 = arg_18_0.charaPage

												var_3(var_5.Find(var_22_11, "right/consume/cost/mask/item"), var_22_10)

												onButton = var_3

												local var_22_12 = arg_18_0
												local var_22_13 = arg_18_0.charaPage
												local var_22_14 = var_6.Find(var_22_13, "right/consume/cost")

												local function var_22_15()
													local var_23_0 = arg_18_0
													local var_23_1 = var_0.emit

													BaseUI = var_5_10003

													var_23_1(var_23_0, var_5_10003.ON_DROP, var_22_10)

													return
												end

												SFX_PANEL = var_22_13

												var_3(var_22_12, var_22_14, var_22_15, var_22_13)

												local var_22_16 = arg_18_0.virtualBagActivity
												local var_22_17 = var_3.getVitemNumber(var_22_16, var_20_0.cost[2])
												local var_22_18 = arg_18_0.charaPage
												local var_22_19 = var_4.Find(var_22_18, "right/consume/cost/mask/item/icon_bg/count")
												local var_22_20 = var_4.GetComponent

												typeof = var_7
												Text = var_9

												local var_22_21 = var_22_20(var_22_19, var_7(var_9))

												if var_22_17 < var_20_0.cost[3] then
													Color = var_22_22

													local var_22_22

													if not var_22_22.New(0.8352941176470589, 0.4627450980392157, 0.4627450980392157, 1) then
														Color = var_22_22
														var_22_22 = var_22_22.New(1, 1, 1, 1)
													end

													var_22_21.color = var_22_22

													local var_22_23 = {
														type = var_20_0.pt_cost[1],
														id = var_20_0.pt_cost[2],
														count = var_20_0.pt_cost[3]
													}

													updateDrop = var_5

													local var_22_24 = arg_18_0.charaPage

													var_5(var_7.Find(var_22_24, "right/consume/ptCost/mask/item"), var_22_23)

													onButton = var_5

													local var_22_25 = arg_18_0
													local var_22_26 = arg_18_0.charaPage
													local var_22_27 = var_8.Find(var_22_26, "right/consume/ptCost")

													local function var_22_28()
														local var_24_0 = arg_18_0
														local var_24_1 = var_0.emit

														BaseUI = var_5_10003

														var_24_1(var_24_0, var_5_10003.ON_DROP, var_22_23)

														return
													end

													SFX_PANEL = var_22_26

													var_5(var_22_25, var_22_27, var_22_28, var_22_26)

													local var_22_29 = arg_18_0.charaPage
													local var_22_30 = var_5.Find(var_22_29, "right/consume/ptCost/mask/item/icon_bg/count")
													local var_22_31 = var_5.GetComponent

													typeof = var_8
													Text = var_22_26

													local var_22_32 = var_22_31(var_22_30, var_8(var_22_26))

													if arg_18_0.cityRebuildData.pt < var_20_0.pt_cost[3] then
														Color = var_22_33

														local var_22_33

														if not var_22_33.New(0.8352941176470589, 0.4627450980392157, 0.4627450980392157, 1) then
															Color = var_22_33
															var_22_33 = var_22_33.New(1, 1, 1, 1)
														end

														var_22_32.color = var_22_33
														onButton = var_22_32

														local var_22_34 = arg_18_0
														local var_22_35 = arg_18_0.charaPage
														local var_22_36 = var_8.Find(var_22_35, "right/recruitBtn")

														local function var_22_37()
															if var_22_17 < var_20_0.cost[3] or arg_18_0.cityRebuildData.pt < var_20_0.pt_cost[3] then
																pg = var_0

																local var_25_0 = var_0.TipsMgr.GetInstance()
																local var_25_1 = var_0.ShowTips

																i18n = var_5_10003

																var_25_1(var_25_0, var_5_10003("ninja_game_update_failed"))

																return
															end

															local var_25_2 = arg_18_0
															local var_25_3 = var_0.emit

															CityRebuildBookMediator = var_5_10003

															var_25_3(var_25_2, var_5_10003.REBUILD_OR_START_RECRUIT, arg_18_0.activityId, var_20_0.id, var_20_0.cost, var_20_0.pt_cost)

															return
														end

														SFX_PANEL = var_22_35

														var_22_32(var_22_34, var_22_36, var_22_37, var_22_35)

														local var_22_39

														if var_20_2 then
															pg = var_22_39

															local var_22_38 = var_22_39.TimeMgr.GetInstance()

															var_22_39 = var_22_39.GetServerTime(var_22_38) - arg_18_0.cityRebuildData.recruiting[var_20_0.id] >= var_20_0.time
															var_20_3 = var_22_39
														end

														setActive = var_22_39

														local var_22_40 = arg_18_0.charaPage
														local var_22_41 = var_4.Find(var_22_40, "right/recruiting")
														local var_22_42

														if var_20_2 then
															var_22_42 = not var_20_3
														end

														var_22_39(var_22_41, var_22_42)

														setActive = var_22_39

														local var_22_43 = arg_18_0.charaPage
														local var_22_44 = var_4.Find(var_22_43, "right/endRecruitBtn")
														local var_22_45

														if var_20_2 then
															var_22_45 = var_20_3
														end

														var_22_39(var_22_44, var_22_45)

														if var_20_2 then
															if var_20_3 then
																local var_22_46 = {
																	var_20_0.id
																}

																onButton = var_3

																local var_22_47 = arg_18_0
																local var_22_48 = arg_18_0.charaPage
																local var_22_49 = var_6.Find(var_22_48, "right/endRecruitBtn")

																local function var_22_50()
																	local var_26_0 = arg_18_0
																	local var_26_1 = var_0.emit

																	CityRebuildBookMediator = var_5_10003

																	var_26_1(var_26_0, var_5_10003.END_RECRUIT, arg_18_0.activityId, var_22_46)

																	return
																end

																SFX_PANEL = var_22_48

																var_3(var_22_47, var_22_49, var_22_50, var_22_48)
															else
																local var_22_51 = arg_18_0

																var_2.StartTimer(var_22_51, function()
																	pg = var_5_10000

																	local var_27_0 = var_5_10000.TimeMgr.GetInstance()

																	if var_0.GetServerTime(var_27_0) - var_20_5 < var_20_0.time then
																		setText = var_1

																		local var_27_1 = arg_18_0.charaPage
																		local var_27_2 = var_3.Find(var_27_1, "right/recruiting/Text")
																		local var_27_3 = arg_18_0

																		var_1(var_27_2, var_4.DescCDTime(var_27_3, var_20_0.time - var_0))
																	else
																		setActive = var_1

																		local var_27_4 = arg_18_0.charaPage

																		var_1(var_3.Find(var_27_4, "right/recruiting"), false)

																		setActive = var_1

																		local var_27_5 = arg_18_0.charaPage

																		var_1(var_3.Find(var_27_5, "right/endRecruitBtn"), true)

																		local var_27_6 = {
																			var_20_0.id
																		}

																		onButton = var_2

																		local var_27_7 = arg_18_0
																		local var_27_8 = arg_18_0.charaPage
																		local var_27_9 = var_5.Find(var_27_8, "right/endRecruitBtn")

																		local function var_27_10()
																			local var_28_0 = arg_18_0
																			local var_28_1 = var_0.emit

																			CityRebuildBookMediator = var_6_10003

																			var_28_1(var_28_0, var_6_10003.END_RECRUIT, arg_18_0.activityId, var_27_6)

																			return
																		end

																		SFX_PANEL = var_27_8

																		var_2(var_27_7, var_27_9, var_27_10, var_27_8)

																		local var_27_11 = arg_18_0

																		var_2.RemoveTimer(var_27_11)
																	end

																	return
																end)
															end
														end

														return
													end
												end
											end
										end
									end

									SFX_PANEL = var_15

									var_20_15(var_20_16, var_20_17, var_20_18, var_15)

									if arg_18_0.showCharaId == var_20_0.id then
										triggerToggle = var_10

										var_10(arg_20_2, true)
									end
								else
									local var_20_19 = arg_20_2
									local var_20_20 = arg_20_2.GetComponent

									typeof = var_20_17
									Toggle = var_15
									var_20_20(var_20_19, var_20_17(var_15)).interactable = false
								end

								if arg_19_1 == 0 and arg_20_1 == 0 then
									arg_18_0.firstCharaTg = arg_20_2
								end

								return
							end
						end
					end)
					var_5:align(#var_19_0)

					return
				end
			end
		end
	end)
	var_18_4:align(#var_18_5)

	return
end

function var_0_1.RefreshBuffPage(arg_29_0)
	local var_29_0 = arg_29_0

	arg_29_0.SetSummaryPanel(var_29_0)

	local var_29_1 = arg_29_0.cityRebuildData.buffs
	local var_29_2 = arg_29_0.cityRebuildData.buffLevels

	table = var_29_0

	local var_29_3 = var_29_0.sort
	local var_29_4 = var_29_1

	CompareFuncs = var_1_10006

	var_29_3(var_29_4, var_1_10006({
		function(arg_30_0)
			pg = var_2_10001

			return var_2_10001.activity_ninja_buff[arg_30_0].group
		end
	}))

	pg = var_29_3

	local var_29_5 = var_29_3.activity_ninja_city[arg_29_0.cityRebuildData.cityLevel].buff

	UIItemList = var_4

	local var_29_6 = var_4.New
	local var_29_7 = arg_29_0.buffPage
	local var_29_8 = var_6.Find(var_29_7, "right/buffScroll/Viewport/Content")
	local var_29_9 = arg_29_0.buffPage
	local var_29_10 = var_29_6(var_29_8, var_7.Find(var_29_9, "right/buffScroll/Viewport/Content/buff"))

	var_4.make(var_29_10, function(arg_31_0, arg_31_1, arg_31_2)
		UIItemList = var_2_10003

		if arg_31_0 == var_2_10003.EventUpdate then
			pg = var_3

			local var_31_0 = var_3.activity_ninja_buff[var_29_1[arg_31_1 + 1]]

			pg = var_4

			local var_31_1 = var_4.activity_ninja_buff.get_id_list_by_group[arg_31_1 + 1]

			pg = var_5

			local var_31_2 = var_5.activity_ninja_buff[var_31_1[1]]

			pg = var_6

			local var_31_3 = var_6.activity_ninja_buff[var_31_1[var_31_0.level + 1]]
			local var_31_4 = var_29_5[arg_31_1 + 1]

			pg = var_8

			local var_31_5 = var_8.activity_ninja_city[5].buff[arg_31_1 + 1]

			GetImageSpriteFromAtlasAsync = var_9

			var_9(var_31_0.icon, "", arg_31_2:Find("icon"))

			setText = var_9

			local var_31_6 = arg_31_2:Find("name")

			i18n = var_12

			var_9(var_31_6, var_12(var_31_2.name))

			setText = var_9

			var_9(arg_31_2:Find("level"), "LV." .. var_31_0.level)

			local var_31_7 = 0

			switch = var_2_10010

			local var_31_8 = var_2_10010(var_31_0.group, {
				function()
					local var_32_0 = arg_29_0

					return var_0.GetParam(var_32_0, 5)^(var_29_2[1] - 1)
				end,
				function()
					local var_33_0 = arg_29_0

					return var_0.GetParam(var_33_0, 6) * var_29_2[2]
				end,
				function()
					local var_34_0 = arg_29_0

					return (1 - var_0.GetParam(var_34_0, 11)^(var_29_2[3] - 1)) * 100
				end,
				function()
					local var_35_0 = arg_29_0

					return var_0.GetParam(var_35_0, 15)^var_29_2[4]
				end,
				function()
					return var_29_2[5]
				end,
				function()
					local var_37_0 = arg_29_0

					return var_0.GetParam(var_37_0, 7) * var_29_2[6] * 100
				end,
				function()
					local var_38_0 = arg_29_0

					return var_0.GetParam(var_38_0, 4) * var_29_2[7]
				end,
				function()
					local var_39_0 = arg_29_0

					return var_0.GetParam(var_39_0, 1)^(var_29_2[8] - 1)
				end,
				function()
					local var_40_0 = arg_29_0

					return var_0.GetParam(var_40_0, 3)^(var_29_2[9] - 1)
				end,
				function()
					return var_29_2[10]
				end
			})

			setText = var_10

			local var_31_9 = arg_31_2:Find("desc")

			i18n = var_13

			local var_31_10 = "ninja_buff_effect" .. var_31_0.group

			string = var_16

			var_10(var_31_9, var_13(var_31_10, var_16.format("%.2f", var_31_8)))

			local var_31_11 = var_31_4 > var_31_0.level and var_31_3

			setActive = var_11

			var_11(arg_31_2:Find("nextLevelPt"), var_31_11)

			setActive = var_11

			var_11(arg_31_2:Find("upgradeBtn"), var_31_11)

			setActive = var_11

			var_11(arg_31_2:Find("upgradeTenBtn"), var_31_11)

			setActive = var_11

			var_11(arg_31_2:Find("levelMax"), not var_31_11)

			if var_31_0.level == var_31_5 then
				setActive = var_11

				var_11(arg_31_2:Find("levelMax"), false)
			end

			if var_31_11 then
				math = var_11

				local var_31_12 = var_11.ceil
				local var_31_13 = var_31_3.basic_cost * var_31_3.cost^(var_31_3.level - 1)
				local var_31_14 = arg_29_0
				local var_31_15 = var_31_12(var_31_13 * (1 - var_14.GetParam(var_31_14, 7) * var_29_2[6]))

				setText = var_31_9

				var_31_9(arg_31_2:Find("nextLevelPt/Text"), var_31_15)

				onButton = var_31_9

				local var_31_16 = arg_29_0
				local var_31_17 = arg_31_2
				local var_31_18 = arg_31_2.Find(var_31_17, "upgradeBtn")

				local function var_31_19()
					if arg_29_0.cityRebuildData.pt < var_31_15 then
						pg = var_0

						local var_42_0 = var_0.TipsMgr.GetInstance()
						local var_42_1 = var_0.ShowTips

						i18n = var_3_10003

						var_42_1(var_42_0, var_3_10003("ninja_game_update_failed"))

						return
					end

					local var_42_2 = arg_29_0
					local var_42_3 = var_0.emit

					CityRebuildBookMediator = var_3_10003

					var_42_3(var_42_2, var_3_10003.UPGRADE_BUFF, arg_29_0.activityId, arg_31_1 + 1, 1, var_31_15)

					return
				end

				SFX_PANEL = var_31_17

				var_31_9(var_31_16, var_31_18, var_31_19, var_31_17)

				onButton = var_31_9

				local var_31_20 = arg_29_0
				local var_31_21 = arg_31_2
				local var_31_22 = arg_31_2.Find(var_31_21, "upgradeTenBtn")

				local function var_31_23()
					local var_43_0 = 1
					local var_43_1 = var_31_15

					for iter_43_0 = 2, 10 do
						pg = var_3_10006
						var_3_10006 = var_3_10006.activity_ninja_buff[var_31_1[var_31_0.level + iter_43_0]]

						if var_31_0.level + iter_43_0 > var_31_4 or not var_3_10006 then
							break
						end

						var_43_0 = var_43_0 + 1

						local var_43_2

						if arg_31_1 + 1 == 6 then
							math = var_43_2
							var_43_2 = var_43_2.ceil

							local var_43_3 = var_3_10006.basic_cost * var_3_10006.cost^(var_3_10006.level - 1)
							local var_43_4 = arg_29_0

							var_43_1 = var_43_1 + var_43_2(var_43_3 * (1 - var_10.GetParam(var_43_4, 7) * (var_31_0.level + iter_43_0 - 1)))
						else
							math = var_43_2

							local var_43_5 = var_43_2.ceil
							local var_43_6 = var_3_10006.basic_cost * var_3_10006.cost^(var_3_10006.level - 1)
							local var_43_7 = arg_29_0

							var_43_1 = var_43_1 + var_43_5(var_43_6 * (1 - var_10.GetParam(var_43_7, 7) * var_29_2[6]))
						end
					end

					if arg_29_0.cityRebuildData.pt < var_43_1 then
						pg = var_2

						local var_43_8 = var_2.TipsMgr.GetInstance()
						local var_43_9 = var_2.ShowTips

						i18n = iter_43_0

						var_43_9(var_43_8, iter_43_0("ninja_game_update_failed"))

						return
					end

					local var_43_10 = arg_29_0
					local var_43_11 = var_2.emit

					CityRebuildBookMediator = iter_43_0

					var_43_11(var_43_10, iter_43_0.UPGRADE_BUFF, arg_29_0.activityId, arg_31_1 + 1, var_43_0, var_43_1)

					return
				end

				SFX_PANEL = var_31_21

				var_31_9(var_31_20, var_31_22, var_31_23, var_31_21)
			end
		end

		return
	end)
	var_4:align(#var_29_1)

	return
end

function var_0_1.SetSummaryPanel(arg_44_0)
	local var_44_0 = arg_44_0.cityRebuildData.buildings
	local var_44_1 = arg_44_0.cityRebuildData.roles
	local var_44_2 = arg_44_0.cityRebuildData.buffLevels
	local var_44_3 = arg_44_0.cityRebuildData.curLevel % 5 == 0
	local var_44_4 = 0

	pg = var_1_10007

	local var_44_5 = var_1_10007.activity_ninja_enemy[var_4].basic
	local var_44_6

	if var_4 < 51 then
		math = var_44_6
		var_44_6 = var_44_6.ceil

		local var_44_7 = var_44_5 * (var_4 - 1 + arg_44_0:GetParam(9)^(var_4 - 1))
		local var_44_8

		if not var_44_3 or not arg_44_0:GetParam(10) then
			var_44_8 = 1
		end

		var_44_4 = var_44_6(var_44_7 * var_44_8 * arg_44_0:GetParam(11)^(var_44_2[3] - 1))
	else
		math = var_44_6
		var_44_6 = var_44_6.ceil

		local var_44_9 = var_44_5 * (arg_44_0:GetParam(16) + arg_44_0:GetParam(9)^arg_44_0:GetParam(16) * arg_44_0:GetParam(13)^(var_4 - (arg_44_0:GetParam(16) + 1)))
		local var_44_10

		if not var_44_3 or not arg_44_0:GetParam(10) then
			var_44_10 = 1
		end

		var_44_4 = var_44_6(var_44_9 * var_44_10 * arg_44_0:GetParam(11)^(var_44_2[3] - 1))
	end

	math = var_44_6

	local var_44_11 = var_44_6.ceil(arg_44_0:GetParam(14)^var_4 * arg_44_0:GetParam(15)^var_44_2[4])

	math = var_1_10009

	local var_44_12 = var_1_10009.ceil((#var_44_0 + var_44_2[10] + (#var_44_0 + var_44_2[10]) * arg_44_0:GetParam(1)^(var_44_2[8] - 1) / arg_44_0:GetParam(2)) * arg_44_0:GetParam(3)^(var_44_2[9] - 1) + arg_44_0:GetParam(4) * var_44_2[7])

	math = var_10

	local var_44_13 = var_44_12 + var_10.ceil((#var_44_1 + var_44_2[5]) * arg_44_0:GetParam(5)^(var_44_2[1] - 1) + arg_44_0:GetParam(6) * var_44_2[2])

	CityRebuildData = var_12

	local var_44_14 = var_12.PtToShow(arg_44_0.cityRebuildData.pt)

	math = var_13

	local var_44_15 = var_13.ceil(var_44_4 / var_44_13)

	string = var_14

	local var_44_16 = var_14.format("%.2f", var_44_11 / var_44_15)

	setText = var_15

	local var_44_17 = arg_44_0.buffPage

	var_15(var_17.Find(var_44_17, "left/panel/buildingDPS/Text"), var_44_12)

	setText = var_15

	local var_44_18 = arg_44_0.buffPage

	var_15(var_17.Find(var_44_18, "left/panel/charaDPS/Text"), var_10)

	setText = var_15

	local var_44_19 = arg_44_0.buffPage

	var_15(var_17.Find(var_44_19, "left/panel/DPS/Text"), var_44_13)

	setText = var_15

	local var_44_20 = arg_44_0.buffPage

	var_15(var_17.Find(var_44_20, "left/panel/time/Text"), var_44_15 .. "s")

	setText = var_15

	local var_44_21 = arg_44_0.buffPage

	var_15(var_17.Find(var_44_21, "left/panel/pts/Text"), "+" .. var_44_16 .. "/s")

	setText = var_15

	local var_44_22 = arg_44_0.buffPage

	var_15(var_17.Find(var_44_22, "left/panel/pt/Text"), var_44_14)

	return
end

function var_0_1.GetParam(arg_45_0, arg_45_1)
	pg = var_1_10002

	local var_45_0

	if var_1_10002.gameset["ninja_Param" .. arg_45_1].key_value == 0 or not var_2.key_value then
		tonumber = var_45_0
		var_45_0 = var_45_0(var_2.description)
	end

	return var_45_0
end

function var_0_1.StartTimer(arg_46_0, arg_46_1)
	Timer = var_1_10002
	arg_46_0.timer = var_1_10002.New(arg_46_1, 1, -1)

	local var_46_0 = arg_46_0.timer

	var_2.Start(var_46_0)

	return
end

function var_0_1.RemoveTimer(arg_47_0)
	if arg_47_0.timer then
		local var_47_0 = arg_47_0.timer

		var_1.Stop(var_47_0)

		arg_47_0.timer = nil
	end

	return
end

function var_0_1.StartTimers(arg_48_0, arg_48_1, arg_48_2)
	if not arg_48_0.timerList then
		arg_48_0.timerList = {}
	end

	Timer = var_3

	local var_48_0 = var_3.New(arg_48_1, 1, -1)

	var_3.Start(var_48_0)

	arg_48_0.timerList[arg_48_2] = var_3

	return
end

function var_0_1.RemoveAllTimers(arg_49_0)
	if arg_49_0.timerList then
		pairs = var_1

		for iter_49_0, iter_49_1 in var_1(arg_49_0.timerList) do
			iter_49_1:Stop()
		end

		arg_49_0.timerList = {}
	end

	return
end

function var_0_1.DescCDTime(arg_50_0, arg_50_1)
	math = var_1_10002

	local var_50_0 = var_1_10002.floor(arg_50_1 / 60)

	arg_50_1 = arg_50_1 % 60
	string = var_1_10003

	return var_1_10003.format("%02d:%02d", var_50_0, arg_50_1)
end

function var_0_1.willExit(arg_51_0)
	arg_51_0:RemoveTimer()
	arg_51_0:RemoveAllTimers()

	pg = var_1

	local var_51_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_51_0, arg_51_0._tf)

	return
end

function var_0_1.ShouldShowTip()
	getProxy = var_1_10000
	CityRebuildProxy = var_1_10002

	local var_52_0 = var_1_10000(var_1_10002)
	local var_52_1 = var_0.GetData

	ActivityConst = var_1_10003

	if not var_52_1(var_52_0, var_1_10003.NINJA_CITY_ACT_ID) then
		return false
	end

	pairs = var_1_10001

	for iter_52_0, iter_52_1 in var_1_10001(var_0.recruiting) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.activity_ninja_building[iter_52_0]
		pg = var_1_10007

		local var_52_2 = var_1_10007.TimeMgr.GetInstance()

		if var_1_10007.GetServerTime(var_52_2) - iter_52_1 >= var_1_10006.time then
			return true
		end
	end

	return false
end

return var_0_1
