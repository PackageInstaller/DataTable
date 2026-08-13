class = var_0_10000

local var_0_0 = "AtelierMaterialDetailLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AtelierMaterialDetailUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0.layerItemDetail = arg_2_0._tf
	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.layerItemDetail
	local var_3_2 = var_4.Find(var_3_1, "BG")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.layerItemDetail
	local var_3_6 = var_4.Find(var_3_5, "Window/Close")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_3_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_3_5)
	arg_3_0:UpdateItemDetail()

	pg = var_1

	local var_3_8 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_8, arg_3_0.layerItemDetail)

	return
end

function var_0_1.UpdateItemDetail(arg_6_0)
	local var_6_0 = arg_6_0.contextData.material
	local var_6_1 = arg_6_0
	local var_6_2 = arg_6_0.UpdateRyzaItem
	local var_6_3 = arg_6_0.layerItemDetail

	var_6_2(var_6_1, var_5.Find(var_6_3, "Window/IconBG"), var_6_0)

	setText = var_6_2

	local var_6_4 = arg_6_0.layerItemDetail

	var_6_2(var_4.Find(var_6_4, "Window/Name"), var_6_0:GetName())

	setText = var_6_2

	local var_6_5 = arg_6_0.layerItemDetail

	var_6_2(var_4.Find(var_6_5, "Window/Description/Text"), var_6_0:GetDesc())

	local var_6_6 = var_6_0:GetSource()

	setText = var_1_10003

	local var_6_7 = arg_6_0.layerItemDetail

	var_1_10003(var_5.Find(var_6_7, "Window/Source"), var_6_6[1])

	onButton = var_1_10003

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.layerItemDetail
	local var_6_10 = var_6.Find(var_6_9, "Window/Go")

	local function var_6_11()
		if var_6_6.chapterid then
			getProxy = var_0
			ChapterProxy = var_2_10002
			var_2_10002 = var_0(var_2_10002)

			local var_7_0 = var_0.getChapterById(var_2_10002, var_6_6.chapterid)

			getProxy = var_2_10001
			ChapterProxy = var_2_10003
			var_2_10003 = var_2_10001(var_2_10003)
			var_2_10001 = var_2_10001.getMapById

			local var_7_1 = var_7_0

			var_2_10001 = var_2_10001(var_2_10003, var_7_0.getConfig(var_7_1, "map"))
			getProxy = var_2_10002
			ActivityProxy = var_2_10004
			var_2_10004 = var_2_10002(var_2_10004)

			if var_2_10002.getActivityByType(var_2_10004, var_2_10001:getConfig("on_activity")) then
				var_2_10005 = var_2_10002

				if var_2_10002.isEnd(var_2_10005) then
					pg = var_2_10003
					var_2_10005 = var_2_10003.TipsMgr.GetInstance()
					var_2_10003 = var_2_10003.ShowTips
					i18n = var_7_1

					var_2_10003(var_2_10005, var_7_1("common_activity_end"))

					return
				end

				var_2_10005 = var_2_10001
				var_2_10003, var_2_10004 = var_2_10001.isUnlock(var_2_10005)

				if not var_2_10003 then
					pg = var_2_10005

					local var_7_2 = var_2_10005.TipsMgr.GetInstance()

					var_2_10005.ShowTips(var_7_2, var_2_10004)

					return
				end

				if not var_7_0:isUnlock() then
					pg = var_2_10005

					local var_7_3 = var_2_10005.TipsMgr.GetInstance()

					var_2_10005 = var_2_10005.ShowTips
					i18n = var_8

					var_2_10005(var_7_3, var_8("battle_levelScene_chapter_lock"))

					return
				end

				local var_7_4 = arg_6_0

				var_2_10005 = var_2_10005.emit
				GAME = var_8

				local var_7_5 = var_8.GO_SCENE

				SCENE = var_2_10009

				var_2_10005(var_7_4, var_7_5, var_2_10009.LEVEL, {
					openChapterId = var_6_6.chapterid,
					chapterId = var_6_6.chapterid,
					mapIdx = var_2_10001.id
				})

				goto label_7_0

				if var_6_6.recipeid then
					getProxy = var_0
					ActivityProxy = var_2_10002
					var_2_10002 = var_0(var_2_10002)

					local var_7_6 = var_0.getActivityByType

					ActivityConst = var_2_10003

					if var_7_6(var_2_10002, var_2_10003.ACTIVITY_TYPE_ATELIER_LINK) then
						var_2_10003 = var_0

						if var_0.isEnd(var_2_10003) then
							pg = var_2_10001
							var_2_10003 = var_2_10001.TipsMgr.GetInstance()
							var_2_10001 = var_2_10001.ShowTips
							i18n = var_2_10004

							var_2_10001(var_2_10003, var_2_10004("common_activity_end"))

							return
						end

						var_2_10003 = var_0
						var_2_10004 = var_0.GetFormulas(var_2_10003)[var_6_6.recipeid]
						var_2_10002 = var_2_10001.GetType(var_2_10004)
						AtelierFormula = var_2_10003

						if var_2_10002 ~= var_2_10003.TYPE.TOOL then
							var_2_10004 = var_0

							if not var_0.IsCompleteAllTools(var_2_10004, var_2_10001:getConfig("version")) then
								pg = var_2_10002
								var_2_10004 = var_2_10002.TipsMgr.GetInstance()
								var_2_10002 = var_2_10002.ShowTips
								i18n = var_2_10005

								var_2_10002(var_2_10004, var_2_10005("ryza_tip_unlock_all_tools"))

								return
							end
						end

						var_2_10004 = var_2_10001

						if not var_2_10001.IsAvaliable(var_2_10004) then
							pg = var_2_10002
							var_2_10004 = var_2_10002.TipsMgr.GetInstance()
							var_2_10002 = var_2_10002.ShowTips
							i18n = var_2_10005

							var_2_10002(var_2_10004, var_2_10005("ryza_tip_composite_invalid"))

							return
						end

						var_2_10004 = arg_6_0
						var_2_10002 = var_2_10002.emit
						AtelierMaterialDetailMediator = var_2_10005

						var_2_10002(var_2_10004, var_2_10005.GO_RECIPE, var_6_6.recipeid)

						if false then
							if var_6_6.taskid then
								getProxy = var_0
								ActivityProxy = var_2_10002

								local var_7_7 = var_0(var_2_10002)
								local var_7_8 = var_0.getActivityById

								ActivityConst = var_2_10003

								if not var_7_8(var_7_7, var_2_10003.RYZA_TASK) or var_0:isEnd() then
									pg = var_2_10001

									local var_7_9 = var_2_10001.TipsMgr.GetInstance()
									local var_7_10 = var_1.ShowTips

									i18n = var_2_10004

									var_7_10(var_7_9, var_2_10004("common_activity_end"))

									return
								end

								local var_7_11 = arg_6_0
								local var_7_12 = var_1.emit

								GAME = var_2_10004

								local var_7_13 = var_2_10004.GO_SCENE

								SCENE = var_2_10005

								var_7_12(var_7_11, var_7_13, var_2_10005.CORE_ACTIVITY, {
									coreName = var_0:getConfig("page_core"),
									id = var_0.id
								})
							end
						end

						::label_7_0::

						return
					end
				end
			end
		end
	end

	SFX_PANEL = var_6_9

	var_1_10003(var_6_8, var_6_10, var_6_11, var_6_9)

	return
end

local var_0_2 = "ui/AtelierCommonUI_atlas"

function var_0_1.UpdateRyzaItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = "icon_frame_" .. arg_8_2:GetRarity()

	if arg_8_3 then
		var_8_0 = var_8_0 .. "_small"
	end

	local var_8_1 = arg_8_0.loader

	var_5.GetSpriteQuiet(var_8_1, var_0_2, var_8_0, arg_8_1)

	local var_8_2 = arg_8_0.loader

	var_5.GetSpriteQuiet(var_8_2, arg_8_2:GetIconPath(), "", arg_8_1:Find("Icon"))

	IsNil = var_5

	if not var_5(arg_8_1:Find("Lv")) then
		setText = var_5

		var_5(arg_8_1:Find("Lv/Text"), arg_8_2:GetLevel())
	end

	local var_8_3 = arg_8_2
	local var_8_4 = arg_8_2.GetProps(var_8_3)

	CustomIndexLayer = var_1_10006

	local var_8_5 = var_1_10006.Clone2Full(arg_8_1:Find("List"), #var_8_4)

	ipairs = var_8_3

	for iter_8_0, iter_8_1 in var_8_3(var_8_5) do
		local var_8_6 = arg_8_0.loader
		local var_8_7 = var_12.GetSpriteQuiet
		local var_8_8 = var_0_2
		local var_8_9 = "element_"

		AtelierFormulaCircle = var_1_10017

		var_8_7(var_8_6, var_8_8, var_8_9 .. var_1_10017.ELEMENT_NAME[var_8_4[iter_8_0]], iter_8_1)
	end

	IsNil = var_7

	if not var_7(arg_8_1:Find("Text")) then
		setText = var_7

		local var_8_10 = arg_8_1:Find("Text")
		local var_8_11

		if not arg_8_2.count then
			var_8_11 = ""
		end

		var_7(var_8_10, var_8_11)
	end

	return
end

function var_0_1.willExit(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0.layerItemDetail)

	local var_9_1 = arg_9_0.loader

	var_1.Clear(var_9_1)

	return
end

return var_0_1
