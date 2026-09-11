local RegressionCurrentActContent = class("RegressionCurrentActContent", (import("game.views.regressionNew.pageViews.RegressionTaskContent")))

function RegressionCurrentActContent:InitNode()
	self.recommendActID = RegressionDataNew:GetReturnRecommendCfgData().recommend_activity

	self:AddBtnListener(self.goBtn_, nil, function()
		self.isGoToActivity = true

		local var_2_0 = ChapterResidentTools.GetResidentActMainID(self.recommendActID)

		if var_2_0 then
			local var_2_1 = ActivityData:GetActivityData(var_2_0).stopTime

			if var_2_1 and var_2_1 <= manager.time:GetServerTime() then
				JumpTools.GoToSystem("/chapterMap", {
					chapterToggle = BattleConst.TOGGLE.RESIDENT_ACT,
					activityID = self.recommendActID
				})

				return
			end
		end

		local var_2_2 = var_2_0 or ActivityCfg.get_id_list_by_sub_activity_list[self.recommendActID][1]

		if not ActivityData:GetActivityIsOpen(var_2_0 or ActivityCfg.get_id_list_by_sub_activity_list[self.recommendActID][1]) then
			ShowTips("SOLO_NOT_OPEN")

			return
		end

		local var_2_3, var_2_4 = ActivityTools.GetActivityMainRouteByTheme(ActivityEntraceCfg[var_2_2].theme, self.recommendActID)

		OpenPageUntilLoaded(var_2_3, var_2_4)
	end)
end

function RegressionCurrentActContent:GetSelectParams()
	if not self.isGoToActivity then
		return nil, nil
	end

	self.isGoToActivity = false

	return 1, 2
end

function RegressionCurrentActContent:RefreshUI()
	if not ActivityToggleCfg.get_id_list_by_activity_id[self.recommendActID][1] then
		return
	end

	local var_4_0 = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.recommendActID][1]]

	self.nameTxt_.text = GetI18NText(ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.recommendActID][1]].name)

	local var_4_1 = RegressionDataNew:GetReturnRecommendCfgData()

	self.descTxt_.text = var_4_1.recommend_tip ~= "" and GetTips(var_4_1.recommend_tip) or GetTips("NEW_REGRESSION_DEFAULT_RECOMMEND_TIPS")

	if self.recommendActID == 3740601 then
		SetActive(self.actImg_.gameObject, true)

		self.actImg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_OsirisHorus/Activity_OsirisHorus_Main/OsirisHorus_Main_bg_002")
	else
		SetActive(self.actImg_.gameObject, false)

		if not self.activityViewGo_ then
			local var_4_2 = Asset.Load((var_4_0.class_name:GetUIName()))

			if var_4_2 then
				local var_4_3 = var_4_2.transform:Find("Bg")

				if var_4_3 == nil then
					var_4_3 = var_4_2.transform:Find("bg")
				end

				if var_4_3 == nil then
					var_4_3 = var_4_2.transform:Find("BG")
				end

				self.activityViewGo_ = Object.Instantiate(var_4_3, self.maskNode_).gameObject

				if self.recommendActID == 3539101 or self.recommendActID == 3740601 then
					local var_4_4 = self.activityViewGo_:GetComponent("Image")

					if var_4_4 then
						if self.recommendActID == 3539101 then
							var_4_4.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/MainPub/SP92601")
						elseif self.recommendActID == 3740601 then
							var_4_4.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_OsirisHorus/Activity_OsirisHorus_Main/OsirisHorus_Main_bg_002")
						end

						SetActive(var_4_4.gameObject, true)
					end
				end

				local var_4_5 = self.activityViewGo_.transform

				var_4_5.localScale = Vector3.one * 0.3
				var_4_5.localPosition = Vector3.zero
			end
		end
	end

	if ChapterResidentTools.GetResidentActMainID(self.recommendActID) then
		SetActive(self.timeObj_, false)
	else
		SetActive(self.timeObj_, true)
	end

	self:RefreshTime()
end

function RegressionCurrentActContent:RefreshTime()
	self.countDownTxt_.text = string.format(GetTips("LEFT_TIME"), ActivityTools.GetActivityLostTimeStrWith2Unit(self.recommendActID))
	self.timeTxt_.text = string.format(GetTips("LEFT_TIME"), ActivityTools.GetActivityLostTimeStrWith2Unit(self.recommendActID))
end

function RegressionCurrentActContent:Dispose()
	if not isNil(self.activityViewGo_) then
		Object.Destroy(self.activityViewGo_)

		self.activityViewGo_ = nil
	end

	RegressionCurrentActContent.super.Dispose(self)
end

return RegressionCurrentActContent
