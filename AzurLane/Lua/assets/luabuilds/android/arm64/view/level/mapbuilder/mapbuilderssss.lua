local var_0_0 = class("MapBuilderSSSS", import(".MapBuilderNormal"))
local var_0_1 = "ssss_buttons"

function var_0_0.GetType(arg_1_0)
	return MapBuilder.TYPESSSS
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	PoolMgr.GetInstance():GetUI(var_0_1, false, function(arg_3_0)
		arg_2_0.buttons = arg_3_0

		return
	end)

	arg_2_0.mainLayer = arg_2_0._parentTf:Find("main")
	arg_2_0.rightChapter = arg_2_0._parentTf:Find("main/right_chapter/event_btns/BottomList")
	arg_2_0.leftChapter = arg_2_0._parentTf:Find("main/left_chapter/buttons")
	arg_2_0.challengeBtn = tf(arg_2_0.buttons):Find("btn_challenge")
	arg_2_0.missionBtn = tf(arg_2_0.buttons):Find("btn_mission")

	onButton(arg_2_0, arg_2_0.challengeBtn, function()
		if arg_2_0:isfrozen() then
			return
		end

		arg_2_0:emit(LevelUIConst.SWITCH_ACT_MAP, Map.ACTIVITY_HARD)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.missionBtn, function()
		if arg_2_0:isfrozen() then
			return
		end

		arg_2_0:emit(LevelMediator2.ON_GO_TO_TASK_SCENE, {
			page = TaskScene.PAGE_TYPE_ACT
		})

		return
	end, SFX_PANEL)
	setParent(arg_2_0.buttons, arg_2_0.mainLayer)

	return
end

function var_0_0.OnHide(arg_6_0)
	setParent(arg_6_0.challengeBtn, arg_6_0.buttons)
	setParent(arg_6_0.missionBtn, arg_6_0.buttons)
	setActive(arg_6_0.buttons, false)
	var_0_0.super.OnHide(arg_6_0)

	return
end

function var_0_0.OnShow(arg_7_0)
	var_0_0.super.OnShow(arg_7_0)
	setActive(arg_7_0.buttons, true)
	setParent(arg_7_0.challengeBtn, arg_7_0.leftChapter)
	arg_7_0.challengeBtn:SetSiblingIndex(5)
	setParent(arg_7_0.missionBtn, arg_7_0.rightChapter)
	arg_7_0.missionBtn:SetSiblingIndex(0)

	return
end

local var_0_2 = {
	18993,
	18994,
	18995,
	18996,
	18997
}

function var_0_0.UpdateButtons(arg_8_0)
	var_0_0.super.UpdateButtons(arg_8_0)

	local var_8_0 = arg_8_0.data:getConfig("type")

	setActive(arg_8_0.sceneParent.actEliteBtn, false)
	setActive(arg_8_0.challengeBtn, var_8_0 ~= Map.ACTIVITY_HARD)
	setActive(arg_8_0.missionBtn, var_8_0 == Map.ACTIVITY_HARD)

	if var_8_0 == Map.ACTIVITY_HARD then
		local var_8_1 = _.any(var_0_2, function(arg_9_0)
			return tobool((getProxy(TaskProxy):getTaskById(arg_9_0)))
		end)

		setActive(arg_8_0.missionBtn, var_8_1)

		if var_8_1 then
			setActive(arg_8_0.missionBtn:Find("Tip"), _.any(var_0_2, function(arg_10_0)
				local var_10_0 = getProxy(TaskProxy):getTaskById(arg_10_0)

				return var_10_0 and var_10_0:isFinish()
			end))
		end
	end

	return
end

function var_0_0.OnDestroy(arg_11_0)
	PoolMgr.GetInstance():ReturnUI(var_0_1, arg_11_0.buttons)
	var_0_0.super.OnDestroy(arg_11_0)

	return
end

return var_0_0
