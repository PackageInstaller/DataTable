local AtelierMaterialDetailYumiaLayer = class("AtelierMaterialDetailYumiaLayer", import("view.base.BaseUI"))

function AtelierMaterialDetailYumiaLayer:getUIName()
	return "AtelierMaterialYumiaDetailUI"
end

function AtelierMaterialDetailYumiaLayer:init()
	self:InitCustom()

	return
end

function AtelierMaterialDetailYumiaLayer:InitCustom()
	setText(self._tf:Find("Window/Text"), i18n("yumia_atelier_tip13"))
	setText(self._tf:Find("Window/titleBg/Name"), i18n("yumia_atelier_tip14"))

	return
end

function AtelierMaterialDetailYumiaLayer:didEnter()
	onButton(self, self._tf:Find("BG"), function()
		self:PlayCloseAni()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Window/titleBg/closeBtn"), function()
		self:PlayCloseAni()

		return
	end, SFX_CANCEL)
	self:UpdateItemDetail()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function AtelierMaterialDetailYumiaLayer:PlayCloseAni()
	local var_7_0 = GetComponent(self._tf, typeof(Animation))

	var_7_0:Play("Anim_AtelierMaterialYumiaDetailUI_Out")
	pg.UIMgr.GetInstance():LoadingOn(false)

	self.closeTimer = FrameTimer.New(function()
		if not var_7_0:IsPlaying("Anim_AtelierMaterialYumiaDetailUI_Out") then
			self:StopCloseTimer()
			pg.UIMgr.GetInstance():LoadingOff()
			self:closeView()
		end

		return
	end, 1, -1)

	self.closeTimer:Start()

	return
end

function AtelierMaterialDetailYumiaLayer:StopCloseTimer()
	if self.closeTimer then
		self.closeTimer:Stop()

		self.closeTimer = nil
	end

	return
end

function AtelierMaterialDetailYumiaLayer:UpdateItemDetail()
	self:UpdateRyzaItem(self._tf:Find("Window/AtelierCommonYumiaItem"), self.contextData.material)
	setText(self._tf:Find("Window/nameBg/Name"), self.contextData.material:GetName())
	setText(self._tf:Find("Window/Description/Text"), self.contextData.material:GetDesc())

	local var_10_0 = self.contextData.material:GetSource()

	setScrollText(self._tf:Find("Window/sourceBg/mask/sourceText"), var_10_0[1])
	onButton(self, self._tf:Find("Window/Go"), function()
		if var_10_0.chapterid then
			local var_11_0 = getProxy(ChapterProxy)
			local var_11_1 = var_11_0:getChapterById(var_10_0.chapterid)
			local var_11_2 = getProxy(ChapterProxy):getMapById(var_11_1:getConfig("map"))
			local var_11_3 = getProxy(ActivityProxy).getActivityByType(var_11_0, var_11_2:getConfig("on_activity"))

			if not var_11_3 or var_11_3:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			local var_11_4, var_11_5 = var_11_2:isUnlock()

			if not var_11_4 then
				pg.TipsMgr.GetInstance():ShowTips(var_11_5)

				return
			end

			if not var_11_1:isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("battle_levelScene_chapter_lock"))

				return
			end

			self:emit(GAME.GO_SCENE, SCENE.LEVEL, {
				openChapterId = var_10_0.chapterid,
				chapterId = var_10_0.chapterid,
				mapIdx = var_11_2.id
			})
		elseif var_10_0.recipeid then
			local var_11_6 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

			if not var_11_6 or var_11_6:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			local var_11_7 = var_11_6:GetFormulas()[var_10_0.recipeid]

			if var_11_7:GetType() ~= AtelierFormula.TYPE.TOOL and not var_11_6:IsCompleteAllTools(var_11_7:getConfig("version")) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_unlock_all_tools"))

				return
			end

			if not var_11_7:IsAvaliable() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_composite_invalid"))

				return
			end

			self:emit(AtelierMaterialDetailMediator.GO_RECIPE, var_10_0.recipeid)
		elseif var_10_0.taskid then
			if not getProxy(TaskProxy):getTaskVO(var_10_0.taskid) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			self:emit(GAME.GO_SCENE, SCENE.TASK, {
				targetId = var_10_0.taskid
			})
		elseif var_10_0.strongholdid then
			local var_11_8 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_STRONGHOLD)

			if not var_11_8 or var_11_8:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			pg.m02:retrieveMediator(getProxy(ContextProxy):getCurrentContext().mediator.__cname):addSubLayers(Context.New({
				mediator = YoumiyaStrongholdMediator,
				viewComponent = YoumiyaStrongholdLayer
			}))
		end

		return
	end, SFX_PANEL)

	return
end

function AtelierMaterialDetailYumiaLayer:UpdateRyzaItem(arg_12_1, arg_12_2)
	AtelierTools.UpdateYumiaItem(arg_12_1, arg_12_2)

	return
end

function AtelierMaterialDetailYumiaLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return AtelierMaterialDetailYumiaLayer
