local WinterFestival2025SkinMagazinePage2 = class("WinterFestival2025SkinMagazinePage2", import("view.activity.CorePage.CorSkinMagazineTemplatePage"))

WinterFestival2025SkinMagazinePage2.EXPAND_WIDTH = 689
WinterFestival2025SkinMagazinePage2.CLOSE_WIDTH = 146
WinterFestival2025SkinMagazinePage2.DURATION_PARAMETER = 2500

function WinterFestival2025SkinMagazinePage2:OnFirstFlush()
	WinterFestival2025SkinMagazinePage2.super.OnFirstFlush(self)

	for iter_1_0, iter_1_1 in ipairs(self.taskList) do
		local var_1_0 = self.items:GetChild(iter_1_0 - 1)
		local var_1_1 = self.items:GetChild(iter_1_0 - 1):Find("got_short")

		setActive(var_1_0:Find("got"), false)
		setActive(var_1_1, false)

		local var_1_2 = self.items:GetChild(iter_1_0 - 1)
		local var_1_3 = self.items:GetChild(iter_1_0 - 1):Find("expand_hx")

		setActive(var_1_2:Find("expand"), not HXSet.isHx())
		setActive(var_1_3, HXSet.isHx())

		local var_1_4 = self.items:GetChild(iter_1_0 - 1):Find("close")
		local var_1_5 = self.items:GetChild(iter_1_0 - 1):Find("close_hx")

		setActive(var_1_4, not HXSet.isHx())
		setActive(var_1_5, HXSet.isHx())
		setImageAlpha(HXSet.isHx() and var_1_5 or var_1_4, iter_1_0 == self.index and 0 or 1)
	end

	local var_1_6 = self.activity:getConfig("config_client").story

	for iter_1_2, iter_1_3 in ipairs(self.taskList) do
		local var_1_7 = self.taskProxy:getFinishTaskById(iter_1_3)

		if var_1_7 and var_1_7:getTaskStatus() == 2 and checkExist(var_1_6, {
			iter_1_2
		}, {
			1
		}) then
			local var_1_8, var_1_9 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(var_1_6[iter_1_2][1])

			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = var_1_6[iter_1_2][1]
			})
		end
	end

	return
end

function WinterFestival2025SkinMagazinePage2:OnUpdateFlush()
	local var_2_0 = 0
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(self.taskList) do
		var_2_1[iter_2_1] = tobool(self.taskProxy:getFinishTaskById(iter_2_1))

		if var_2_1[iter_2_1] then
			var_2_0 = var_2_0 + 1
		end

		local var_2_2 = self.items:GetChild(iter_2_0 - 1):Find("got")
		local var_2_3 = self.items:GetChild(iter_2_0 - 1):Find("got_short")
		local var_2_4 = var_2_3:GetComponent(typeof(DftAniEvent))

		local function var_2_5()
			local var_3_0 = self.activity:getConfig("config_client").story

			for iter_3_0, iter_3_1 in ipairs(self.taskList) do
				if self.taskProxy:getFinishTaskById(iter_3_1) and checkExist(var_3_0, {
					iter_3_0
				}, {
					1
				}) then
					playStory(var_3_0[iter_3_0][1])
				end
			end

			return
		end

		var_2_2:GetComponent(typeof(DftAniEvent)):SetEndEvent(var_2_5)
		var_2_4:SetEndEvent(var_2_5)

		if self.index == iter_2_0 then
			setActive(var_2_2, var_2_1[iter_2_1])
			setActive(var_2_3, false)
		else
			setActive(var_2_2, false)
			setActive(var_2_3, var_2_1[iter_2_1])
		end
	end

	if self.usedCnt ~= var_2_0 then
		self.usedCnt = var_2_0
		self.activity.data1 = self.usedCnt

		getProxy(ActivityProxy):updateActivity(self.activity)
	end

	self:RefreshData()
	setText(self.countTf, self.remainCnt)

	local var_2_6 = var_2_1[self.taskList[self.index]]

	setActive(self.awardTf:Find("got"), var_2_1[self.taskList[self.index]])
	setActive(self.awardTf:Find("get"), self.remainCnt > 0 and not var_2_6)

	return
end

function WinterFestival2025SkinMagazinePage2:SelectItem(arg_4_1)
	if self.index == arg_4_1 then
		return
	end

	self.index = arg_4_1

	for iter_4_0, iter_4_1 in ipairs(self.LTList or {}) do
		LeanTween.cancel(iter_4_1)
	end

	self.LTList = {}

	for iter_4_2 = 1, self.items.childCount do
		local var_4_0 = self.items:GetChild(iter_4_2 - 1)
		local var_4_1 = var_4_0:GetComponent(typeof(LayoutElement))
		local var_4_2 = var_4_1.preferredWidth

		if iter_4_2 == arg_4_1 then
			local var_4_3 = self.EXPAND_WIDTH or self.CLOSE_WIDTH

			if var_4_2 ~= var_4_3 then
				local var_4_4 = math.abs(var_4_3 - var_4_2) / self.DURATION_PARAMETER
				local var_4_5 = HXSet.isHx() and var_4_0:Find("close_hx") or var_4_0:Find("close") or var_4_0:Find("close")

				table.insert(self.LTList, LeanTween.value(go(var_4_0), var_4_2, var_4_3, var_4_4):setEase(LeanTweenType.easeOutSine):setOnUpdate(System.Action_float(function(arg_5_0)
					var_4_1.preferredWidth = arg_5_0

					return
				end)).uniqueId)
				table.insert(self.LTList, LeanTween.alpha(var_4_5, iter_4_2 == arg_4_1 and 0 or 1, var_4_4):setEase(LeanTweenType.easeOutSine).uniqueId)
			end
		end
	end

	self:UpdateDrop()

	return
end

return WinterFestival2025SkinMagazinePage2
