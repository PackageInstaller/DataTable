local var_0_0 = class("AtelierMaterialDetailYumiaLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AtelierMaterialYumiaDetailUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:InitCustom()

	return
end

function var_0_0.InitCustom(arg_3_0)
	setText(arg_3_0._tf:Find("Window/Text"), i18n("yumia_atelier_tip13"))
	setText(arg_3_0._tf:Find("Window/titleBg/Name"), i18n("yumia_atelier_tip14"))

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("BG"), function()
		arg_4_0:PlayCloseAni()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0._tf:Find("Window/titleBg/closeBtn"), function()
		arg_4_0:PlayCloseAni()

		return
	end, SFX_CANCEL)
	arg_4_0:UpdateItemDetail()
	pg.UIMgr.GetInstance():BlurPanel(arg_4_0._tf)

	return
end

function var_0_0.PlayCloseAni(arg_7_0)
	local var_7_0 = GetComponent(arg_7_0._tf, typeof(Animation))

	GetComponent(arg_7_0._tf, typeof(Animation)):Play("Anim_AtelierMaterialYumiaDetailUI_Out")
	pg.UIMgr.GetInstance():LoadingOn(false)

	arg_7_0.closeTimer = FrameTimer.New(function()
		if not var_7_0:IsPlaying("Anim_AtelierMaterialYumiaDetailUI_Out") then
			arg_7_0:StopCloseTimer()
			pg.UIMgr.GetInstance():LoadingOff()
			arg_7_0:closeView()
		end

		return
	end, 1, -1)

	arg_7_0.closeTimer:Start()

	return
end

function var_0_0.StopCloseTimer(arg_9_0)
	if arg_9_0.closeTimer then
		arg_9_0.closeTimer:Stop()

		arg_9_0.closeTimer = nil
	end

	return
end

function var_0_0.UpdateItemDetail(arg_10_0)
	arg_10_0:UpdateRyzaItem(arg_10_0._tf:Find("Window/AtelierCommonYumiaItem"), arg_10_0.contextData.material)
	setText(arg_10_0._tf:Find("Window/nameBg/Name"), arg_10_0.contextData.material:GetName())
	setText(arg_10_0._tf:Find("Window/Description/Text"), arg_10_0.contextData.material:GetDesc())
	setScrollText(arg_10_0._tf:Find("Window/sourceBg/mask/sourceText"), arg_10_0.contextData.material:GetSource()[1])
	onButton(arg_10_0, arg_10_0._tf:Find("Window/Go"), function()
		local var_11_9000

		if var_0.chapterid then
			local var_11_0 = getProxy(ChapterProxy)
			local var_11_1 = var_11_0.getChapterById(var_11_9000, var_0.chapterid)
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

			arg_10_0:emit(GAME.GO_SCENE, SCENE.LEVEL, {
				openChapterId = var_0.chapterid,
				chapterId = var_0.chapterid,
				mapIdx = var_11_2.id
			})
		elseif var_0.recipeid then
			local var_11_6 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

			if not var_11_6 or var_11_6:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			local var_11_7 = var_11_6:GetFormulas()[var_0.recipeid]

			if var_11_7:GetType() ~= AtelierFormula.TYPE.TOOL and not var_11_6:IsCompleteAllTools(var_11_7:getConfig("version")) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_unlock_all_tools"))

				return
			end

			if not var_11_7:IsAvaliable() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_composite_invalid"))

				return
			end

			arg_10_0:emit(AtelierMaterialDetailMediator.GO_RECIPE, var_0.recipeid)
		elseif var_0.taskid then
			if not getProxy(TaskProxy):getTaskVO(var_0.taskid) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			arg_10_0:emit(GAME.GO_SCENE, SCENE.TASK, {
				targetId = var_0.taskid
			})
		elseif var_0.strongholdid then
			local var_11_8 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_STRONGHOLD)

			if not var_11_8 or var_11_8:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			local var_11_9 = getProxy(ContextProxy)

			pg.m02:retrieveMediator(var_11_9:getCurrentContext().mediator.__cname):addSubLayers(Context.New({
				mediator = YoumiyaStrongholdMediator,
				viewComponent = YoumiyaStrongholdLayer
			}))
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateRyzaItem(arg_12_0, arg_12_1, arg_12_2)
	AtelierTools.UpdateYumiaItem(arg_12_1, arg_12_2)

	return
end

function var_0_0.willExit(arg_13_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_13_0._tf)

	return
end

return var_0_0
