local AtelierMaterialDetailLayer = class("AtelierMaterialDetailLayer", import("view.base.BaseUI"))

function AtelierMaterialDetailLayer:getUIName()
	return "AtelierMaterialDetailUI"
end

function AtelierMaterialDetailLayer:init()
	self.layerItemDetail = self._tf
	self.loader = AutoLoader.New()

	return
end

function AtelierMaterialDetailLayer:didEnter()
	onButton(self, self.layerItemDetail:Find("BG"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.layerItemDetail:Find("Window/Close"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	self:UpdateItemDetail()
	pg.UIMgr.GetInstance():BlurPanel(self.layerItemDetail)

	return
end

function AtelierMaterialDetailLayer:UpdateItemDetail()
	self:UpdateRyzaItem(self.layerItemDetail:Find("Window/IconBG"), self.contextData.material)
	setText(self.layerItemDetail:Find("Window/Name"), self.contextData.material:GetName())
	setText(self.layerItemDetail:Find("Window/Description/Text"), self.contextData.material:GetDesc())

	local var_6_0 = self.contextData.material:GetSource()

	setText(self.layerItemDetail:Find("Window/Source"), var_6_0[1])
	onButton(self, self.layerItemDetail:Find("Window/Go"), function()
		if var_6_0.chapterid then
			local var_7_0 = getProxy(ChapterProxy)
			local var_7_1 = var_7_0:getChapterById(var_6_0.chapterid)
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

			self:emit(GAME.GO_SCENE, SCENE.LEVEL, {
				openChapterId = var_6_0.chapterid,
				chapterId = var_6_0.chapterid,
				mapIdx = var_7_2.id
			})
		elseif var_6_0.recipeid then
			local var_7_6 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

			if not var_7_6 or var_7_6:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			local var_7_7 = var_7_6:GetFormulas()[var_6_0.recipeid]

			if var_7_7:GetType() ~= AtelierFormula.TYPE.TOOL and not var_7_6:IsCompleteAllTools(var_7_7:getConfig("version")) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_unlock_all_tools"))

				return
			end

			if not var_7_7:IsAvaliable() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_composite_invalid"))

				return
			end

			self:emit(AtelierMaterialDetailMediator.GO_RECIPE, var_6_0.recipeid)
		elseif var_6_0.taskid then
			local var_7_8 = getProxy(ActivityProxy):getActivityById(ActivityConst.RYZA_TASK)

			if not var_7_8 or var_7_8:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			self:emit(GAME.GO_SCENE, SCENE.CORE_ACTIVITY, {
				coreName = var_7_8:getConfig("page_core"),
				id = var_7_8.id
			})
		end

		return
	end, SFX_PANEL)

	return
end

local var_0_1 = "ui/AtelierCommonUI_atlas"

function AtelierMaterialDetailLayer:UpdateRyzaItem(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = "icon_frame_" .. arg_8_2:GetRarity()

	if arg_8_3 then
		var_8_0 = var_8_0 .. "_small"
	end

	self.loader:GetSpriteQuiet(var_0_1, var_8_0, arg_8_1)
	self.loader:GetSpriteQuiet(arg_8_2:GetIconPath(), "", arg_8_1:Find("Icon"))

	if not IsNil(arg_8_1:Find("Lv")) then
		setText(arg_8_1:Find("Lv/Text"), arg_8_2:GetLevel())
	end

	local var_8_1 = arg_8_2:GetProps()

	for iter_8_0, iter_8_1 in ipairs((CustomIndexLayer.Clone2Full(arg_8_1:Find("List"), #var_8_1))) do
		self.loader:GetSpriteQuiet(var_0_1, "element_" .. AtelierFormulaCircle.ELEMENT_NAME[var_8_1[iter_8_0]], iter_8_1)
	end

	if not IsNil(arg_8_1:Find("Text")) then
		setText(arg_8_1:Find("Text"), arg_8_2.count or "")
	end

	return
end

function AtelierMaterialDetailLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.layerItemDetail)
	self.loader:Clear()

	return
end

return AtelierMaterialDetailLayer
