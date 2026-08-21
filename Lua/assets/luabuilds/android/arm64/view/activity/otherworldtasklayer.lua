local var_0_0 = class("OtherWorldTaskLayer", import("..base.BaseUI"))

var_0_0.sub_item_warning = "sub_item_warning"

local var_0_1 = "other_world_task_title"

function var_0_0.getUIName(arg_1_0)
	return "OtherWorldTaskUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.activityId = ActivityConst.OTHER_WORLD_TASK_ID

	local var_2_0 = findTF(arg_2_0._tf, "ad")

	arg_2_0.btnBack = findTF(var_2_0, "btnBack")
	arg_2_0.taskPage = OtherWorldTaskPage.New(findTF(var_2_0, "pages/taskPage"), arg_2_0.contextData, findTF(var_2_0, "tpl"), arg_2_0)

	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)
	arg_2_0.taskPage:setActive(true)

	return
end

function var_0_0.didEnter(arg_3_0)
	setText(findTF(arg_3_0._tf, "ad/title/text"), i18n(var_0_1))
	onButton(arg_3_0, arg_3_0.btnBack, function()
		arg_3_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_3_0, findTF(arg_3_0._tf, "ad/pages/taskPage/clickClose"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.updateTask(arg_6_0, arg_6_1)
	arg_6_0.taskPage:updateTask(arg_6_1)

	return
end

function var_0_0.willExit(arg_7_0)
	arg_7_0.taskPage:dispose()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0._tf)

	return
end

return var_0_0
