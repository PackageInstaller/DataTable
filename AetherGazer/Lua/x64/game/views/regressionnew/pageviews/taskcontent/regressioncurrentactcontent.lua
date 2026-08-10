local var_0_0 = import("game.views.regressionNew.pageViews.RegressionTaskContent")
local var_0_1 = class("RegressionCurrentActContent", var_0_0)

function var_0_1.InitNode(arg_1_0)
	arg_1_0.recommendActID = RegressionDataNew:GetReturnRecommendCfgData().recommend_activity

	arg_1_0:AddBtnListener(arg_1_0.goBtn_, nil, function()
		arg_1_0.isGoToActivity = true

		local var_2_0 = ChapterResidentTools.GetResidentActMainID(arg_1_0.recommendActID)

		if var_2_0 then
			local var_2_1 = ActivityData:GetActivityData(var_2_0).stopTime

			if var_2_1 and var_2_1 <= manager.time:GetServerTime() then
				JumpTools.GoToSystem("/chapterMap", {
					chapterToggle = BattleConst.TOGGLE.RESIDENT_ACT,
					activityID = arg_1_0.recommendActID
				})

				return
			end
		end

		local var_2_2 = var_2_0 or ActivityCfg.get_id_list_by_sub_activity_list[arg_1_0.recommendActID][1]

		if not ActivityData:GetActivityIsOpen(var_2_2) then
			ShowTips("SOLO_NOT_OPEN")

			return
		end

		local var_2_3 = ActivityEntraceCfg[var_2_2].theme
		local var_2_4, var_2_5 = ActivityTools.GetActivityMainRouteByTheme(var_2_3, arg_1_0.recommendActID)

		OpenPageUntilLoaded(var_2_4, var_2_5)
	end)
end

function var_0_1.GetSelectParams(arg_3_0)
	if not arg_3_0.isGoToActivity then
		return nil, nil
	end

	arg_3_0.isGoToActivity = false

	return 1, 2
end

function var_0_1.RefreshUI(arg_4_0)
	local var_4_0 = ActivityToggleCfg.get_id_list_by_activity_id[arg_4_0.recommendActID][1]

	if not var_4_0 then
		return
	end

	local var_4_1 = ActivityToggleCfg[var_4_0]

	arg_4_0.nameTxt_.text = GetI18NText(var_4_1.name)

	local var_4_2 = RegressionDataNew:GetReturnRecommendCfgData()

	if var_4_2.recommend_tip ~= "" then
		arg_4_0.descTxt_.text = GetTips(var_4_2.recommend_tip)
	else
		arg_4_0.descTxt_.text = GetTips("NEW_REGRESSION_DEFAULT_RECOMMEND_TIPS")
	end

	if arg_4_0.recommendActID == 3740601 then
		SetActive(arg_4_0.actImg_.gameObject, true)

		arg_4_0.actImg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_OsirisHorus/Activity_OsirisHorus_Main/OsirisHorus_Main_bg_002")
	else
		SetActive(arg_4_0.actImg_.gameObject, false)

		local var_4_3 = var_4_1.class_name:GetUIName()

		if not arg_4_0.activityViewGo_ then
			local var_4_4 = Asset.Load(var_4_3)

			if var_4_4 then
				local var_4_5 = var_4_4.transform:Find("Bg")

				if var_4_5 == nil then
					var_4_5 = var_4_4.transform:Find("bg")
				end

				if var_4_5 == nil then
					var_4_5 = var_4_4.transform:Find("BG")
				end

				arg_4_0.activityViewGo_ = Object.Instantiate(var_4_5, arg_4_0.maskNode_).gameObject

				if arg_4_0.recommendActID == 3539101 or arg_4_0.recommendActID == 3740601 then
					local var_4_6 = arg_4_0.activityViewGo_:GetComponent("Image")

					if var_4_6 then
						if arg_4_0.recommendActID == 3539101 then
							var_4_6.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/MainPub/SP92601")
						elseif arg_4_0.recommendActID == 3740601 then
							var_4_6.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_OsirisHorus/Activity_OsirisHorus_Main/OsirisHorus_Main_bg_002")
						end

						SetActive(var_4_6.gameObject, true)
					end
				end

				local var_4_7 = arg_4_0.activityViewGo_.transform

				var_4_7.localScale = Vector3.one * 0.3
				var_4_7.localPosition = Vector3.zero
			end
		end
	end

	if ChapterResidentTools.GetResidentActMainID(arg_4_0.recommendActID) then
		SetActive(arg_4_0.timeObj_, false)
	else
		SetActive(arg_4_0.timeObj_, true)
	end

	arg_4_0:RefreshTime()
end

function var_0_1.RefreshTime(arg_5_0)
	arg_5_0.countDownTxt_.text = string.format(GetTips("LEFT_TIME"), ActivityTools.GetActivityLostTimeStrWith2Unit(arg_5_0.recommendActID))
	arg_5_0.timeTxt_.text = string.format(GetTips("LEFT_TIME"), ActivityTools.GetActivityLostTimeStrWith2Unit(arg_5_0.recommendActID))
end

function var_0_1.Dispose(arg_6_0)
	if not isNil(arg_6_0.activityViewGo_) then
		Object.Destroy(arg_6_0.activityViewGo_)

		arg_6_0.activityViewGo_ = nil
	end

	var_0_1.super.Dispose(arg_6_0)
end

return var_0_1
