local var_0_0 = class("AtelierMaterialDetailLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AtelierMaterialDetailUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.layerItemDetail = arg_2_0._tf
	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.layerItemDetail:Find("BG"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.layerItemDetail:Find("Window/Close"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	arg_3_0:UpdateItemDetail()
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0.layerItemDetail)

	return
end

function var_0_0.UpdateItemDetail(arg_6_0)
	arg_6_0:UpdateRyzaItem(arg_6_0.layerItemDetail:Find("Window/IconBG"), arg_6_0.contextData.material)
	setText(arg_6_0.layerItemDetail:Find("Window/Name"), arg_6_0.contextData.material:GetName())
	setText(arg_6_0.layerItemDetail:Find("Window/Description/Text"), arg_6_0.contextData.material:GetDesc())
	setText(arg_6_0.layerItemDetail:Find("Window/Source"), arg_6_0.contextData.material:GetSource()[1])
	onButton(arg_6_0, arg_6_0.layerItemDetail:Find("Window/Go"), function()
		local var_7_9000

		if var_0.chapterid then
			local var_7_0 = getProxy(ChapterProxy)
			local var_7_1 = var_7_0.getChapterById(var_7_9000, var_0.chapterid)
			local var_7_2 = getProxy(ChapterProxy):getMapById(var_7_1:getConfig("map"))
			local var_7_3 = getProxy(ActivityProxy).getActivityByType(var_7_0, var_7_2:getConfig("on_activity"))

			if not var_7_3 or var_7_3:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			local var_7_4, var_7_5 = var_7_2:isUnlock()

			if not var_7_4 then
				pg.TipsMgr.GetInstance():ShowTips(var_7_5)

				return
			end

			if not var_7_1:isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("battle_levelScene_chapter_lock"))

				return
			end

			arg_6_0:emit(GAME.GO_SCENE, SCENE.LEVEL, {
				openChapterId = var_0.chapterid,
				chapterId = var_0.chapterid,
				mapIdx = var_7_2.id
			})
		elseif var_0.recipeid then
			local var_7_6 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

			if not var_7_6 or var_7_6:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			local var_7_7 = var_7_6:GetFormulas()[var_0.recipeid]

			if var_7_7:GetType() ~= AtelierFormula.TYPE.TOOL and not var_7_6:IsCompleteAllTools(var_7_7:getConfig("version")) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_unlock_all_tools"))

				return
			end

			if not var_7_7:IsAvaliable() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_composite_invalid"))

				return
			end

			arg_6_0:emit(AtelierMaterialDetailMediator.GO_RECIPE, var_0.recipeid)
		elseif var_0.taskid then
			local var_7_8 = getProxy(ActivityProxy):getActivityById(ActivityConst.RYZA_TASK)

			if not var_7_8 or var_7_8:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			arg_6_0:emit(GAME.GO_SCENE, SCENE.CORE_ACTIVITY, {
				coreName = var_7_8:getConfig("page_core"),
				id = var_7_8.id
			})
		end

		return
	end, SFX_PANEL)

	return
end

local var_0_1 = "ui/AtelierCommonUI_atlas"

function var_0_0.UpdateRyzaItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = "icon_frame_" .. arg_8_2:GetRarity()

	if arg_8_3 then
		var_8_0 = var_8_0 .. "_small"
	end

	arg_8_0.loader:GetSpriteQuiet(var_0_1, var_8_0, arg_8_1)
	arg_8_0.loader:GetSpriteQuiet(arg_8_2:GetIconPath(), "", arg_8_1:Find("Icon"))

	if not IsNil(arg_8_1:Find("Lv")) then
		setText(arg_8_1:Find("Lv/Text"), arg_8_2:GetLevel())
	end

	local var_8_1 = arg_8_2:GetProps()

	for iter_8_0, iter_8_1 in ipairs((CustomIndexLayer.Clone2Full(arg_8_1:Find("List"), #var_8_1))) do
		arg_8_0.loader:GetSpriteQuiet(var_0_1, "element_" .. AtelierFormulaCircle.ELEMENT_NAME[var_8_1[iter_8_0]], iter_8_1)
	end

	if not IsNil(arg_8_1:Find("Text")) then
		local var_8_2 = arg_8_2.count or ""

		setText(arg_8_1:Find("Text"), var_8_2)
	end

	return
end

function var_0_0.willExit(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0.layerItemDetail)
	arg_9_0.loader:Clear()

	return
end

return var_0_0
