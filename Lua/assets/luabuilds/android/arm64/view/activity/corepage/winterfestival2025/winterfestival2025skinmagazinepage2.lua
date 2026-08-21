local var_0_0 = class("WinterFestival2025SkinMagazinePage2", import("view.activity.CorePage.CorSkinMagazineTemplatePage"))

var_0_0.EXPAND_WIDTH = 689
var_0_0.CLOSE_WIDTH = 146
var_0_0.DURATION_PARAMETER = 2500

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.taskList) do
		local var_1_0 = arg_1_0.items:GetChild(iter_1_0 - 1)
		local var_1_1 = arg_1_0.items:GetChild(iter_1_0 - 1):Find("got_short")
		local var_1_2 = var_1_0:Find("got")

		setActive(var_1_2, false)
		setActive(var_1_1, false)

		local var_1_3 = arg_1_0.items:GetChild(iter_1_0 - 1)
		local var_1_4 = arg_1_0.items:GetChild(iter_1_0 - 1):Find("expand_hx")
		local var_1_5 = var_1_3:Find("expand")

		setActive(var_1_5, not HXSet.isHx())
		setActive(var_1_4, HXSet.isHx())

		local var_1_6 = arg_1_0.items:GetChild(iter_1_0 - 1):Find("close")
		local var_1_7 = arg_1_0.items:GetChild(iter_1_0 - 1):Find("close_hx")

		setActive(var_1_6, not HXSet.isHx())
		setActive(var_1_7, HXSet.isHx())
		setImageAlpha(HXSet.isHx() and var_1_7 or var_1_6, iter_1_0 == arg_1_0.index and 0 or 1)
	end

	local var_1_8 = arg_1_0.activity:getConfig("config_client").story

	for iter_1_2, iter_1_3 in ipairs(arg_1_0.taskList) do
		local var_1_9 = arg_1_0.taskProxy:getFinishTaskById(iter_1_3)

		if var_1_9 and var_1_9:getTaskStatus() == 2 and checkExist(var_1_8, {
			iter_1_2
		}, {
			1
		}) then
			local var_1_10, var_1_11 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(var_1_8[iter_1_2][1])

			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = var_1_8[iter_1_2][1]
			})
		end
	end

	return
end

function var_0_0.OnUpdateFlush(arg_2_0)
	local var_2_9000
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.taskList) do
		({})[iter_2_1] = tobool(arg_2_0.taskProxy:getFinishTaskById(iter_2_1))

		if ({})[iter_2_1] then
			var_2_0 = var_2_0 + 1
		end

		local var_2_1 = arg_2_0.items:GetChild(iter_2_0 - 1)
		local var_2_2 = var_2_1.Find(var_2_9000, "got")
		local var_2_3 = arg_2_0.items:GetChild(iter_2_0 - 1):Find("got_short")
		local var_2_4 = var_2_3:GetComponent(typeof(DftAniEvent))

		var_2_2:GetComponent(typeof(DftAniEvent)).SetEndEvent(var_2_1, function()
			local var_3_0 = arg_2_0.activity:getConfig("config_client").story

			for iter_3_0, iter_3_1 in ipairs(arg_2_0.taskList) do
				if arg_2_0.taskProxy:getFinishTaskById(iter_3_1) and checkExist(var_3_0, {
					iter_3_0
				}, {
					1
				}) then
					playStory(var_3_0[iter_3_0][1])
				end
			end

			return
		end)
		var_2_4:SetEndEvent(function()
			local var_3_0 = arg_2_0.activity:getConfig("config_client").story

			for iter_3_0, iter_3_1 in ipairs(arg_2_0.taskList) do
				if arg_2_0.taskProxy:getFinishTaskById(iter_3_1) and checkExist(var_3_0, {
					iter_3_0
				}, {
					1
				}) then
					playStory(var_3_0[iter_3_0][1])
				end
			end

			return
		end)

		if arg_2_0.index == iter_2_0 then
			setActive(var_2_2, ({})[iter_2_1])
			setActive(var_2_3, false)
		else
			setActive(var_2_2, false)
			setActive(var_2_3, ({})[iter_2_1])
		end
	end

	if arg_2_0.usedCnt ~= var_2_0 then
		arg_2_0.usedCnt = var_2_0
		arg_2_0.activity.data1 = arg_2_0.usedCnt

		getProxy(ActivityProxy):updateActivity(arg_2_0.activity)
	end

	arg_2_0:RefreshData()
	setText(arg_2_0.countTf, arg_2_0.remainCnt)

	local var_2_5 = ({})[arg_2_0.taskList[arg_2_0.index]]

	setActive(arg_2_0.awardTf:Find("got"), ({})[arg_2_0.taskList[arg_2_0.index]])
	setActive(arg_2_0.awardTf:Find("get"), arg_2_0.remainCnt > 0 and not var_2_5)

	return
end

function var_0_0.SelectItem(arg_4_0, arg_4_1)
	if arg_4_0.index == arg_4_1 then
		return
	end

	arg_4_0.index = arg_4_1

	local var_4_0 = arg_4_0.LTList or {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		LeanTween.cancel(iter_4_1)
	end

	arg_4_0.LTList = {}

	for iter_4_2 = 1, arg_4_0.items.childCount do
		local var_4_1 = arg_4_0.items:GetChild(iter_4_2 - 1)
		local var_4_2 = var_4_1:GetComponent(typeof(LayoutElement)).preferredWidth

		if iter_4_2 == arg_4_1 then
			local var_4_3 = arg_4_0.EXPAND_WIDTH or arg_4_0.CLOSE_WIDTH

			if var_4_2 ~= var_4_3 then
				local var_4_4 = math.abs(var_4_3 - var_4_2) / arg_4_0.DURATION_PARAMETER
				local var_4_5 = HXSet.isHx() and var_4_1:Find("close_hx") or var_4_1:Find("close") or var_4_1:Find("close")
				local var_4_6 = LeanTween.value(go(var_4_1), var_4_2, var_4_3, var_4_4):setEase(LeanTweenType.easeOutSine)

				table.insert(arg_4_0.LTList, var_4_6:setOnUpdate(System.Action_float(function(arg_5_0)
					var_0.preferredWidth = arg_5_0

					return
				end)).uniqueId)

				local var_4_7 = LeanTween.alpha(var_4_5, iter_4_2 == arg_4_1 and 0 or 1, var_4_4)

				table.insert(arg_4_0.LTList, var_4_7:setEase(LeanTweenType.easeOutSine).uniqueId)
			end
		end
	end

	arg_4_0:UpdateDrop()

	return
end

return var_0_0
