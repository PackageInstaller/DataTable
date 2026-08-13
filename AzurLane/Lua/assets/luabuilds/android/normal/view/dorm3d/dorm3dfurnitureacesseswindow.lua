class = var_0_10000

local var_0_0 = "Dorm3dFurnitureAcessesWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dFurnitureAcessesWindow"
end

function var_0_1.init(arg_2_0)
	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	var_1_10001(var_3_0, var_3.Find(var_3_1, "Mask"), function()
		existCall = var_2_10000

		var_2_10000(arg_3_0.contextData.onClose)

		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end)

	onButton = var_1_10001

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_3.Find(var_3_3, "Window/Close")

	local function var_3_5()
		existCall = var_2_10000

		var_2_10000(arg_3_0.contextData.onClose)

		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_2, var_3_4, var_3_5, var_5)

	setText = var_1_10001

	local var_3_6 = arg_3_0._tf

	var_1_10001(var_2.Find(var_3_6, "Window/Title"), arg_3_0.contextData.title)

	setText = var_1_10001

	local var_3_7 = arg_3_0._tf
	local var_3_8 = var_2.Find(var_3_7, "Window/Acesses/Text")

	i18n = var_3_7

	var_1_10001(var_3_8, var_3_7("dorm3d_furniture_window_acesses"))
	arg_3_0:ShowSingleItemBox(arg_3_0.contextData)
	arg_3_0:ShowCommonObtainWindow(arg_3_0.contextData)

	return
end

function var_0_1.ShowSingleItemBox(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_2.Find(var_6_0, "Window/Icon")

	updateDrop = var_6_0

	var_6_0(var_6_1, arg_6_1.drop)

	local var_6_2 = arg_6_1.drop
	local var_6_3 = var_3.getConfig(var_6_2, "rarity")

	GetImageSpriteFromAtlasAsync = var_6_2

	local var_6_4 = "weaponframes"
	local var_6_5 = "dorm3d_"

	ItemRarity = var_1_10007

	var_6_2(var_6_4, var_6_5 .. var_1_10007.Rarity2Print(var_6_3), var_6_1)

	local var_6_6

	if not arg_6_1.name and not arg_6_1.drop.cfg.name then
		var_6_6 = ""
	end

	setText = var_6_4

	local var_6_7 = arg_6_0._tf

	var_6_4(var_6.Find(var_6_7, "Window/Name"), var_6_6)

	setText = var_6_4

	local var_6_8 = arg_6_0._tf
	local var_6_9 = var_6.Find(var_6_8, "Window/Count")

	i18n = var_6_8

	local var_6_10 = "child_msg_owned"

	setColorStr = var_1_10009

	var_6_4(var_6_9, var_6_8(var_6_10, var_1_10009(arg_6_1.drop.count, "#39bfff")))

	local var_6_11 = arg_6_0._tf
	local var_6_12 = var_5.Find(var_6_11, "Window/Content")

	setText = var_6_11

	var_6_11(var_6_12, arg_6_1.drop.cfg.desc)

	return
end

function var_0_1.ShowCommonObtainWindow(arg_7_0, arg_7_1)
	defaultValue = var_1_10002

	local var_7_0 = var_1_10002(arg_7_1.showGOBtn, false)
	local var_7_1

	if not arg_7_0.obtainSkipList then
		UIItemList = var_7_1
		var_7_1 = var_7_1.New

		local var_7_2 = arg_7_0._tf
		local var_7_3 = var_4.Find(var_7_2, "Window/List")
		local var_7_4 = arg_7_0._tf
		local var_7_5 = var_5.Find(var_7_4, "Window/List")

		var_7_1 = var_7_1(var_7_3, var_5.GetChild(var_7_5, 0))
	end

	arg_7_0.obtainSkipList = var_7_1

	local var_7_6 = arg_7_0.obtainSkipList

	var_3.make(var_7_6, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_7_1.list[arg_8_1 + 1][1]
			local var_8_1 = var_3[2]
			local var_8_2 = var_3[3]

			HXSet = var_2_10007

			local var_8_3 = var_2_10007.hxLan(var_8_0)
			local var_8_4 = arg_8_2:Find("Mask/Text")
			local var_8_5 = var_7.GetComponent(var_8_4, "ScrollText")

			var_7.SetText(var_8_5, var_8_3)

			setActive = var_7

			local var_8_6 = arg_8_2:Find("Button")
			local var_8_7

			if var_7_0 then
				var_8_7 = var_8_1[1] ~= "" and var_8_1[1] ~= "COLLECTSHIP"
			end

			var_7(var_8_6, var_8_7)

			if var_8_1[1] ~= "" then
				onButton = var_7

				local var_8_8 = arg_7_0
				local var_8_9 = arg_8_2:Find("Button")

				local function var_8_10()
					if var_8_2 and var_8_2 ~= 0 then
						getProxy = var_0
						ActivityProxy = var_3_10001
						var_3_10001 = var_0(var_3_10001)

						if var_0.getActivityById(var_3_10001, var_8_2) then
							var_3_10002 = var_0

							if var_0.isEnd(var_3_10002) then
								pg = var_3_10001
								var_3_10002 = var_3_10001.TipsMgr.GetInstance()
								var_3_10001 = var_3_10001.ShowTips
								i18n = var_3_10003

								var_3_10001(var_3_10002, var_3_10003("collection_way_is_unopen"))

								do return end

								goto label_9_0

								if var_8_1[1] == "SHOP" then
									local var_9_0 = var_8_1[2].warp

									NewShopsScene = var_3_10001

									if var_9_0 == var_3_10001.TYPE_MILITARY_SHOP then
										pg = var_9_0
										var_3_10001 = var_9_0.SystemOpenMgr.GetInstance()

										local var_9_1 = var_0.isOpenSystem

										getProxy = var_3_10002
										PlayerProxy = var_3_10003
										var_3_10003 = var_3_10002(var_3_10003)

										if not var_9_1(var_3_10001, var_3_10002.getData(var_3_10003).level, "MilitaryExerciseMediator") then
											pg = var_0
											var_3_10001 = var_0.TipsMgr.GetInstance()

											local var_9_2 = var_0.ShowTips

											i18n = var_3_10002

											var_9_2(var_3_10001, var_3_10002("military_shop_no_open_tip"))

											do return end

											goto label_9_0
										end
									end
								end

								if var_8_1[1] == "LEVEL" and var_8_1[2] then
									local var_9_3 = var_8_1[2].chapterid

									getProxy = var_3_10001
									ChapterProxy = var_3_10002
									var_3_10003 = var_3_10001(var_3_10002)

									local var_9_4 = var_3_10001.getChapterById(var_3_10003, var_9_3)

									if var_3_10002.isUnlock(var_9_4) then
										if var_3_10001:getActiveChapter() and var_3_10003.id ~= var_9_3 then
											pg = var_4
											var_3_10005 = var_4.TipsMgr.GetInstance()

											local var_9_5 = var_4.ShowTips

											i18n = var_3_10006

											var_9_5(var_3_10005, var_3_10006("collect_chapter_is_activation"))

											return
										else
											local var_9_6 = {
												mapIdx = var_3_10002:getConfig("map")
											}

											if var_3_10002.active then
												var_9_6.chapterId = var_3_10002.id
											else
												var_9_6.openChapterId = var_9_3
											end

											pg = var_3_10005

											local var_9_7 = var_3_10005.m02

											var_3_10005 = var_3_10005.sendNotification
											GAME = var_7

											local var_9_8 = var_7.GO_SCENE

											SCENE = var_3_10008

											var_3_10005(var_9_7, var_9_8, var_3_10008.LEVEL, var_9_6)
										end
									else
										pg = var_3_10003

										local var_9_9 = var_3_10003.TipsMgr.GetInstance()

										var_3_10003 = var_3_10003.ShowTips
										i18n = var_3_10005

										var_3_10003(var_9_9, var_3_10005("acquisitionmode_is_not_open"))

										return
									end
								elseif var_8_1[1] == "COLLECTSHIP" then
									local var_9_10 = arg_7_1.mediatorName

									CollectionMediator = var_3_10001

									if var_9_10 == var_3_10001.__cname then
										pg = var_9_10

										local var_9_11 = var_9_10.m02

										var_9_10 = var_9_10.sendNotification
										CollectionMediator = var_3_10002

										var_9_10(var_9_11, var_3_10002.EVENT_OBTAIN_SKIP, {
											toggle = 2,
											displayGroupId = var_8_1[2].shipGroupId
										})
									else
										pg = var_9_10

										local var_9_12 = var_9_10.m02
										local var_9_13 = var_0.sendNotification

										GAME = var_3_10002
										var_3_10002 = var_3_10002.GO_SCENE
										SCENE = var_3_10003

										var_9_13(var_9_12, var_3_10002, var_3_10003.COLLECTSHIP, {
											toggle = 2,
											displayGroupId = var_8_1[2].shipGroupId
										})
									end
								else
									local var_9_15

									if var_8_1[1] == "SHOP" then
										pg = var_9_15

										local var_9_14 = var_9_15.m02

										var_9_15 = var_9_15.sendNotification
										GAME = var_3_10002
										var_3_10002 = var_3_10002.GO_SCENE
										SCENE = var_3_10003

										var_9_15(var_9_14, var_3_10002, var_3_10003[var_8_1[1]], var_8_1[2])
									else
										pg = var_9_15

										local var_9_16 = var_9_15.m02
										local var_9_17 = var_0.sendNotification

										GAME = var_3_10002

										local var_9_18 = var_3_10002.GO_SCENE

										SCENE = var_3_10003

										var_9_17(var_9_16, var_9_18, var_3_10003[var_8_1[1]], var_8_1[2])
									end
								end
							end

							::label_9_0::

							local var_9_19 = arg_7_0

							var_0.closeView(var_9_19)

							return
						end
					end
				end

				SFX_PANEL = var_11

				var_7(var_8_8, var_8_9, var_8_10, var_11)
			end
		end

		return
	end)

	local var_7_7 = arg_7_0.obtainSkipList

	var_3.align(var_7_7, #arg_7_1.list)

	return
end

function var_0_1.willExit(arg_10_0)
	return
end

return var_0_1
