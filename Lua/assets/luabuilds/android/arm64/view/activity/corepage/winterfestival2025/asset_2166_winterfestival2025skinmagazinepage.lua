local WinterFestival2025SkinMagazinePage = class("WinterFestival2025SkinMagazinePage", import("view.activity.CorePage.CorSkinMagazineTemplatePage"))

WinterFestival2025SkinMagazinePage.EXPAND_WIDTH = 761
WinterFestival2025SkinMagazinePage.CLOSE_WIDTH = 164
WinterFestival2025SkinMagazinePage.DURATION_PARAMETER = 2500

function WinterFestival2025SkinMagazinePage:OnFirstFlush()
	WinterFestival2025SkinMagazinePage.super.OnFirstFlush(self)

	for iter_1_0, iter_1_1 in ipairs(self.taskList) do
		local var_1_0 = self.items:GetChild(iter_1_0 - 1)
		local var_1_1 = self.items:GetChild(iter_1_0 - 1):Find("got_short")

		setActive(var_1_0:Find("got"), false)
		setActive(var_1_1, false)
	end

	local var_1_2 = self.activity:getConfig("config_client").story

	for iter_1_2, iter_1_3 in ipairs(self.taskList) do
		local var_1_3 = self.taskProxy:getFinishTaskById(iter_1_3)

		if var_1_3 and var_1_3:getTaskStatus() == 2 and checkExist(var_1_2, {
			iter_1_2
		}, {
			1
		}) then
			local var_1_4, var_1_5 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(var_1_2[iter_1_2][1])

			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = var_1_2[iter_1_2][1]
			})
		end
	end

	return
end

function WinterFestival2025SkinMagazinePage:OnUpdateFlush()
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

return WinterFestival2025SkinMagazinePage
