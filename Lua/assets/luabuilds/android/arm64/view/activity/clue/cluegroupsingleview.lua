local var_0_0 = class("ClueGroupSingleView", import("view.base.BaseUI"))
local var_0_1 = pg.activity_clue
local var_0_2 = pg.activity_clue_group
local var_0_3 = 0.6
local var_0_4 = 1

function var_0_0.getUIName(arg_1_0)
	return "ClueGroupSingleUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.clueGroupTf = arg_2_0._tf:Find("clueGroup")

	setText(arg_2_0.clueGroupTf:Find("goBtn/Text"), i18n("clue_task_goto"))
	setText(arg_2_0._tf:Find("closeTip"), i18n("clue_close_tip"))

	arg_2_0.timerList = {}

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.activityId = ActivityConst.Valleyhospital_ACT_ID
	arg_3_0.playerId = getProxy(PlayerProxy):getRawData().id
	arg_3_0.investigatingGroupId = PlayerPrefs.GetInt("investigatingGroupId_" .. arg_3_0.activityId .. "_" .. arg_3_0.playerId)
	arg_3_0.taskProxy = getProxy(TaskProxy)

	onButton(arg_3_0, arg_3_0._tf:Find("mask"), function()
		arg_3_0:closeView()

		return
	end, SFX_PANEL)
	arg_3_0:SetClueGroup()
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	return
end

function var_0_0.SetClueGroup(arg_5_0)
	local var_5_0 = arg_5_0.contextData.clueGroupId
	local var_5_1 = arg_5_0.contextData.submitClueIds
	local var_5_2 = arg_5_0.clueGroupTf
	local var_5_3 = var_0_2[arg_5_0.contextData.clueGroupId]
	local var_5_4 = var_0_1.get_id_list_by_group[arg_5_0.contextData.clueGroupId]
	local var_5_5 = {
		var_0_1[var_0_1.get_id_list_by_group[arg_5_0.contextData.clueGroupId][1]],
		var_0_1[var_0_1.get_id_list_by_group[arg_5_0.contextData.clueGroupId][2]],
		var_0_1[var_0_1.get_id_list_by_group[arg_5_0.contextData.clueGroupId][3]]
	}
	local var_5_6 = arg_5_0.taskProxy:getTaskVO(tonumber(({
		var_0_1[var_0_1.get_id_list_by_group[arg_5_0.contextData.clueGroupId][1]],
		var_0_1[var_0_1.get_id_list_by_group[arg_5_0.contextData.clueGroupId][2]],
		var_0_1[var_0_1.get_id_list_by_group[arg_5_0.contextData.clueGroupId][3]]
	})[3].task_id)):getProgress()
	local var_5_7 = {}

	for iter_5_0 = 1, 3 do
		var_5_7[iter_5_0] = arg_5_0.taskProxy:getFinishTaskById(tonumber(var_5_5[iter_5_0].task_id))
	end

	setText(var_5_2:Find("title/Text"), var_5_3.title)

	local var_5_8 = var_5_7[1] or var_5_7[2] or var_5_7[3]

	setActive(var_5_2:Find("title/Text"), var_5_8)
	setActive(var_5_2:Find("title/lock"), not var_5_7[1] and not var_5_7[2] and not var_5_7[3])
	LoadImageSpriteAsync("cluepictures/" .. var_5_3.pic, var_5_2:Find("picture"), true)

	var_5_2:Find("picture").localScale = var_5_3.type == 1 and Vector3(1, 1, 1) or Vector3(0.6, 0.6, 1)

	setActive(var_5_2:Find("picture/lockSite"), var_5_3.type == 1 and not var_5_7[1] and not var_5_7[2] and not var_5_7[3])
	setActive(var_5_2:Find("picture/lockChara"), var_5_3.type == 2 and not var_5_7[1] and not var_5_7[2] and not var_5_7[3])

	for iter_5_1 = 1, 3 do
		local var_5_9

		if var_5_7[iter_5_1] then
			setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_1), var_5_5[iter_5_1].desc)
		elseif arg_5_0.investigatingGroupId == var_5_0 then
			setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_1), "<color=#858593>" .. var_5_5[iter_5_1].unlock_desc .. var_5_5[iter_5_1].unlock_num .. i18n("clue_task_tip", var_5_6) .. "</color>")
		elseif not false then
			var_5_9 = true

			setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_1), "<color=#858593>" .. var_5_5[iter_5_1].unlock_desc .. var_5_5[iter_5_1].unlock_num .. i18n("clue_task_tip", var_5_6) .. "</color>")
		else
			setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_1), "<color=#858593>？？？</color>")
		end
	end

	setActive(var_5_2:Find("goBtn/selected"), arg_5_0.investigatingGroupId == var_5_0)
	onButton(arg_5_0, var_5_2:Find("goBtn"), function()
		arg_5_0.investigatingGroupId = var_5_0

		PlayerPrefs.SetInt("investigatingGroupId_" .. arg_5_0.activityId .. "_" .. arg_5_0.playerId, var_5_0)
		setActive(var_5_2:Find("goBtn/selected"), true)

		if arg_5_0.pageIndex == 1 then
			arg_5_0:ShowSitePage()
		elseif arg_5_0.pageIndex == 2 then
			arg_5_0:ShowCharaPage()
		end

		arg_5_0:OpenChapter(var_5_0)
		arg_5_0:closeView()

		return
	end, SFX_PANEL)

	if not var_5_7[1] and not var_5_7[2] and not var_5_7[3] then
		setActive(arg_5_0.clueGroupTf:Find("triangle"), false)
	else
		setActive(arg_5_0.clueGroupTf:Find("triangle"), true)

		local var_5_10 = arg_5_0.clueGroupTf:Find("clueScroll")

		setActive(arg_5_0.clueGroupTf:Find("triangle"), var_5_10:GetComponent(typeof(ScrollRect)).normalizedPosition.y > 0.01)
		onScroll(arg_5_0, arg_5_0.clueGroupTf:Find("clueScroll"), function(arg_7_0)
			setActive(arg_5_0.clueGroupTf:Find("triangle"), arg_7_0.y > 0.01)

			return
		end)
	end

	setActive(arg_5_0._tf:Find("top"), var_5_1 and #var_5_1 > 0)

	if var_5_1 and #var_5_1 > 0 then
		if table.contains(var_5_1, var_5_4[1]) then
			setActive(var_5_2:Find("title/Text"), false)
			setActive(var_5_2:Find("title/lock"), true)
			setActive(var_5_2:Find("picture/lockSite"), var_5_3.type == 1)
			setActive(var_5_2:Find("picture/lockChara"), var_5_3.type == 2)

			for iter_5_2 = 1, #var_5_1 do
				if arg_5_0.investigatingGroupId == var_5_0 then
					setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_2), "<color=#858593>" .. var_5_5[iter_5_2].unlock_desc .. var_5_5[iter_5_2].unlock_num .. "</color>")
				else
					setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_2), "<color=#858593>？？？</color>")
				end
			end

			arg_5_0:StartTimer(function()
				setActive(var_5_2:Find("title/Text"), true)

				local var_8_0 = var_5_2:Find("title"):GetComponent(typeof(Animation)):Play("anim_clue_single_unlock1")

				arg_5_0:SetEndAniEvent(var_5_2:Find("title"), function()
					setActive(var_5_2:Find("title/lock"), false)

					return
				end)

				return
			end, var_0_3)
			arg_5_0:StartTimer(function()
				local var_10_0 = var_5_2:Find("picture"):GetComponent(typeof(Animation)):Play("anim_clue_single_unlock")

				arg_5_0:SetEndAniEvent(var_5_2:Find("picture"), function()
					setActive(var_5_2:Find("picture/lockSite"), false)
					setActive(var_5_2:Find("picture/lockChara"), false)

					return
				end)

				return
			end, var_0_3)

			for iter_5_3 = 1, #var_5_1 do
				arg_5_0:StartTimer(function()
					setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_3), var_5_5[iter_5_3].desc)

					return
				end, var_0_4 * iter_5_3 + var_0_3)
			end
		else
			local var_5_11 = table.indexof(var_5_4, var_5_1[1])

			for iter_5_4 = var_5_11, 3 do
				if arg_5_0.investigatingGroupId == var_5_0 then
					setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_4), "<color=#858593>" .. var_5_5[iter_5_4].unlock_desc .. var_5_5[iter_5_4].unlock_num .. "</color>")
				else
					setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_4), "<color=#858593>？？？</color>")
				end
			end

			for iter_5_5 = var_5_11, var_5_11 + #var_5_1 - 1 do
				arg_5_0:StartTimer(function()
					setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_5), var_5_5[iter_5_5].desc)

					return
				end, var_0_4 * 1)
			end
		end

		setActive(var_5_2:Find("goBtn"), false)
	else
		setActive(var_5_2:Find("goBtn"), not var_5_7[1] or not var_5_7[2] or not var_5_7[3])
	end

	return
end

function var_0_0.OpenChapter(arg_14_0, arg_14_1)
	arg_14_0:emit(ClueGroupSingleMediator.OPEN_CLUE_JUMP, arg_14_1)

	return
end

function var_0_0.StartTimer(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = Timer.New(arg_15_1, arg_15_2, 1)

	var_15_0:Start()
	table.insert(arg_15_0.timerList, var_15_0)

	return
end

function var_0_0.RemoveAllTimer(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.timerList) do
		iter_16_1:Stop()
	end

	arg_16_0.timerList = {}

	return
end

function var_0_0.SetEndAniEvent(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1:GetComponent(typeof(DftAniEvent))

	if var_17_0 then
		var_17_0:SetEndEvent(function()
			arg_17_2()
			var_17_0:SetEndEvent(nil)

			return
		end)
	end

	return
end

function var_0_0.willExit(arg_19_0)
	arg_19_0:RemoveAllTimer()

	return
end

function var_0_0.onBackPressed(arg_20_0)
	arg_20_0:closeView()

	return
end

return var_0_0
