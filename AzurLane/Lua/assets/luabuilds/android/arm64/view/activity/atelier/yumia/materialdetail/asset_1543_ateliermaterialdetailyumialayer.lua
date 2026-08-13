class = var_0_10000

local var_0_0 = "AtelierMaterialDetailYumiaLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AtelierMaterialYumiaDetailUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:InitCustom()

	return
end

function var_0_1.InitCustom(arg_3_0)
	setText = var_1_10001

	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_3.Find(var_3_0, "Window/Text")

	i18n = var_1_10004

	var_1_10001(var_3_1, var_1_10004("yumia_atelier_tip13"))

	setText = var_1_10001

	local var_3_2 = arg_3_0._tf
	local var_3_3 = var_3.Find(var_3_2, "Window/titleBg/Name")

	i18n = var_4

	var_1_10001(var_3_3, var_4("yumia_atelier_tip14"))

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_4.Find(var_4_1, "BG")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.PlayCloseAni(var_5_0)

		return
	end

	SFX_CANCEL = var_4_1

	var_1_10001(var_4_0, var_4_2, var_4_3, var_4_1)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_4.Find(var_4_5, "Window/titleBg/closeBtn")

	local function var_4_7()
		local var_6_0 = arg_4_0

		var_0.PlayCloseAni(var_6_0)

		return
	end

	SFX_CANCEL = var_4_5

	var_1_10001(var_4_4, var_4_6, var_4_7, var_4_5)
	arg_4_0:UpdateItemDetail()

	pg = var_1

	local var_4_8 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_8, arg_4_0._tf)

	return
end

function var_0_1.PlayCloseAni(arg_7_0)
	GetComponent = var_1_10001

	local var_7_0 = arg_7_0._tf

	typeof = var_1_10004
	Animation = var_1_10006

	local var_7_1 = var_1_10001(var_7_0, var_1_10004(var_1_10006))

	var_1.Play(var_7_1, "Anim_AtelierMaterialYumiaDetailUI_Out")

	pg = var_2

	local var_7_2 = var_2.UIMgr.GetInstance()

	var_2.LoadingOn(var_7_2, false)

	FrameTimer = var_2
	arg_7_0.closeTimer = var_2.New(function()
		local var_8_0 = var_0

		if not var_0.IsPlaying(var_8_0, "Anim_AtelierMaterialYumiaDetailUI_Out") then
			local var_8_1 = arg_7_0

			var_0.StopCloseTimer(var_8_1)

			pg = var_0

			local var_8_2 = var_0.UIMgr.GetInstance()

			var_0.LoadingOff(var_8_2)

			local var_8_3 = arg_7_0

			var_0.closeView(var_8_3)
		end

		return
	end, 1, -1)

	local var_7_3 = arg_7_0.closeTimer

	var_2.Start(var_7_3)

	return
end

function var_0_1.StopCloseTimer(arg_9_0)
	if arg_9_0.closeTimer then
		local var_9_0 = arg_9_0.closeTimer

		var_1.Stop(var_9_0)

		arg_9_0.closeTimer = nil
	end

	return
end

function var_0_1.UpdateItemDetail(arg_10_0)
	local var_10_0 = arg_10_0.contextData.material
	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.UpdateRyzaItem
	local var_10_3 = arg_10_0._tf

	var_10_2(var_10_1, var_5.Find(var_10_3, "Window/AtelierCommonYumiaItem"), var_10_0)

	setText = var_10_2

	local var_10_4 = arg_10_0._tf

	var_10_2(var_4.Find(var_10_4, "Window/nameBg/Name"), var_10_0:GetName())

	setText = var_10_2

	local var_10_5 = arg_10_0._tf

	var_10_2(var_4.Find(var_10_5, "Window/Description/Text"), var_10_0:GetDesc())

	local var_10_6 = var_10_0:GetSource()

	setScrollText = var_1_10003

	local var_10_7 = arg_10_0._tf

	var_1_10003(var_5.Find(var_10_7, "Window/sourceBg/mask/sourceText"), var_10_6[1])

	onButton = var_1_10003

	local var_10_8 = arg_10_0
	local var_10_9 = arg_10_0._tf
	local var_10_10 = var_6.Find(var_10_9, "Window/Go")

	local function var_10_11()
		if var_10_6.chapterid then
			getProxy = var_0
			ChapterProxy = var_2_10002
			var_2_10002 = var_0(var_2_10002)

			local var_11_0 = var_0.getChapterById(var_2_10002, var_10_6.chapterid)

			getProxy = var_2_10001
			ChapterProxy = var_2_10003
			var_2_10003 = var_2_10001(var_2_10003)
			var_2_10001 = var_2_10001.getMapById

			local var_11_1 = var_11_0

			var_2_10001 = var_2_10001(var_2_10003, var_11_0.getConfig(var_11_1, "map"))
			getProxy = var_2_10002
			ActivityProxy = var_2_10004
			var_2_10004 = var_2_10002(var_2_10004)
			var_2_10002 = var_2_10002.getActivityByType
			var_2_10007 = var_2_10001

			if var_2_10002(var_2_10004, var_2_10001.getConfig(var_2_10007, "on_activity")) then
				var_2_10005 = var_2_10002

				if var_2_10002.isEnd(var_2_10005) then
					pg = var_2_10003
					var_2_10005 = var_2_10003.TipsMgr.GetInstance()
					var_2_10003 = var_2_10003.ShowTips
					i18n = var_11_1

					var_2_10003(var_2_10005, var_11_1("common_activity_end"))

					return
				end

				var_2_10005 = var_2_10001
				var_2_10003, var_2_10004 = var_2_10001.isUnlock(var_2_10005)

				if not var_2_10003 then
					pg = var_2_10005
					var_2_10007 = var_2_10005.TipsMgr.GetInstance()

					var_2_10005.ShowTips(var_2_10007, var_2_10004)

					return
				end

				var_2_10007 = var_11_0

				if not var_11_0.isUnlock(var_2_10007) then
					pg = var_2_10005
					var_2_10007 = var_2_10005.TipsMgr.GetInstance()
					var_2_10005 = var_2_10005.ShowTips
					i18n = var_8

					var_2_10005(var_2_10007, var_8("battle_levelScene_chapter_lock"))

					return
				end

				var_2_10007 = arg_10_0
				var_2_10005 = var_2_10005.emit
				GAME = var_8

				local var_11_2 = var_8.GO_SCENE

				SCENE = var_2_10009

				var_2_10005(var_2_10007, var_11_2, var_2_10009.LEVEL, {
					openChapterId = var_10_6.chapterid,
					chapterId = var_10_6.chapterid,
					mapIdx = var_2_10001.id
				})

				goto label_11_0

				if var_10_6.recipeid then
					getProxy = var_0
					ActivityProxy = var_2_10002
					var_2_10002 = var_0(var_2_10002)

					local var_11_3 = var_0.getActivityByType

					ActivityConst = var_2_10003

					if var_11_3(var_2_10002, var_2_10003.ACTIVITY_TYPE_ATELIER_LINK) then
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
						var_2_10004 = var_0.GetFormulas(var_2_10003)[var_10_6.recipeid]
						var_2_10002 = var_2_10001.GetType(var_2_10004)
						AtelierFormula = var_2_10003

						if var_2_10002 ~= var_2_10003.TYPE.TOOL then
							var_2_10004 = var_0
							var_2_10002 = var_0.IsCompleteAllTools
							var_2_10007 = var_2_10001

							if not var_2_10002(var_2_10004, var_2_10001.getConfig(var_2_10007, "version")) then
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

						var_2_10004 = arg_10_0
						var_2_10002 = var_2_10002.emit
						AtelierMaterialDetailMediator = var_2_10005

						var_2_10002(var_2_10004, var_2_10005.GO_RECIPE, var_10_6.recipeid)

						goto label_11_0

						if var_10_6.taskid then
							getProxy = var_0
							TaskProxy = var_2_10002
							var_2_10002 = var_0(var_2_10002)

							if not var_0.getTaskVO(var_2_10002, var_10_6.taskid) then
								pg = var_2_10001
								var_2_10003 = var_2_10001.TipsMgr.GetInstance()
								var_2_10001 = var_2_10001.ShowTips
								i18n = var_2_10004

								var_2_10001(var_2_10003, var_2_10004("common_activity_end"))

								return
							end

							var_2_10003 = arg_10_0
							var_2_10001 = var_2_10001.emit
							GAME = var_2_10004
							var_2_10004 = var_2_10004.GO_SCENE
							SCENE = var_2_10005

							var_2_10001(var_2_10003, var_2_10004, var_2_10005.TASK, {
								targetId = var_10_6.taskid
							})

							goto label_11_0
						end

						if var_10_6.strongholdid then
							getProxy = var_0
							ActivityProxy = var_2_10002

							local var_11_4 = var_0(var_2_10002)
							local var_11_5 = var_0.getActivityByType

							ActivityConst = var_2_10003

							if var_11_5(var_11_4, var_2_10003.ACTIVITY_TYPE_STRONGHOLD) then
								do
									local var_11_6 = var_0

									if var_0.isEnd(var_11_6) then
										pg = var_2_10001
										var_11_6 = var_2_10001.TipsMgr.GetInstance()
										var_2_10001 = var_2_10001.ShowTips
										i18n = var_2_10004

										var_2_10001(var_11_6, var_2_10004("common_activity_end"))

										return
									end

									getProxy = var_2_10001
									ContextProxy = var_11_6

									local var_11_7 = var_2_10001(var_11_6)
									local var_11_8 = var_1.getCurrentContext(var_11_7)

									pg = var_11_6

									local var_11_9 = var_11_6.m02
									local var_11_10 = var_3.retrieveMediator(var_11_9, var_11_8.mediator.__cname)
									local var_11_11 = var_3.addSubLayers

									Context = var_2_10007

									local var_11_12 = var_2_10007.New
									local var_11_13 = {}

									YoumiyaStrongholdMediator = var_2_10010
									var_11_13.mediator = var_2_10010
									YoumiyaStrongholdLayer = var_2_10010
									var_11_13.viewComponent = var_2_10010

									var_11_11(var_11_10, var_11_12(var_11_13))
								end

								::label_11_0::

								return
							end
						end
					end
				end
			end
		end
	end

	SFX_PANEL = var_10_9

	var_1_10003(var_10_8, var_10_10, var_10_11, var_10_9)

	return
end

function var_0_1.UpdateRyzaItem(arg_12_0, arg_12_1, arg_12_2)
	AtelierTools = var_1_10003

	var_1_10003.UpdateYumiaItem(arg_12_1, arg_12_2)

	return
end

function var_0_1.willExit(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_0, arg_13_0._tf)

	return
end

return var_0_1
