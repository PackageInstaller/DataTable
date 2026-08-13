class = var_0_10000

local var_0_0 = "GuildOfficeSelectTaskPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.GuildBasePage"))

function var_0_1.getTargetUI(arg_1_0)
	return "GuildTaskSelectBluePage", "GuildTaskSelectRedPage"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "frame/bg/scrollrect/content")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uilist = var_2_0(var_2_2, var_4.Find(var_2_3, "frame/bg/scrollrect/content/tpl"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_4, "frame/title/close")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Close(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Close(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.guild = arg_6_1
	arg_6_0.isAdmin = arg_6_2
	setActive = var_1_10003

	var_1_10003(arg_6_0._tf, true)

	pg = var_1_10003

	local var_6_0 = var_1_10003.UIMgr.GetInstance()

	var_3.BlurPanel(var_6_0, arg_6_0._tf)

	local var_6_1 = arg_6_0._tf

	var_3.SetAsLastSibling(var_6_1)
	arg_6_0:Update()

	return
end

function var_0_1.Update(arg_7_0)
	local var_7_0 = arg_7_0.guild
	local var_7_1 = var_1.getSelectableWeeklyTasks(var_7_0)
	local var_7_2 = arg_7_0.uilist

	var_3.make(var_7_2, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			GuildTaskCard = var_3

			local var_8_0 = var_3.New(arg_8_2)
			local var_8_1 = var_7_1[arg_8_1 + 1]

			onButton = var_5

			local var_8_2 = arg_7_0
			local var_8_3 = var_8_0.acceptBtn

			local function var_8_4()
				pg = var_3_10000

				local var_9_0 = var_3_10000.MsgboxMgr.GetInstance()
				local var_9_1 = var_0.ShowMsgBox
				local var_9_2 = {}

				i18n = var_3_10004

				local var_9_3 = "guild_task_selecte_tip"
				local var_9_4 = var_8_1

				var_9_2.content = var_3_10004(var_9_3, var_7.getConfig(var_9_4, "name"))

				function var_9_2.onYes()
					local var_10_0 = arg_7_0
					local var_10_1 = var_0.emit

					GuildOfficeMediator = var_4_10003

					var_10_1(var_10_0, var_4_10003.ON_SELECT_TASK, var_8_0.task.id)

					local var_10_2 = arg_7_0

					var_0.Close(var_10_2)

					return
				end

				var_9_1(var_9_0, var_9_2)

				return
			end

			SFX_PANEL = var_2_10010

			var_5(var_8_2, var_8_3, var_8_4, var_2_10010)
			var_8_0:Update(var_8_1)
		end

		return
	end)

	local var_7_3 = arg_7_0.uilist

	var_3.align(var_7_3, #var_7_1)

	return
end

function var_0_1.Close(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_11_0, arg_11_0._tf, arg_11_0._parentTf)

	setActive = var_1

	var_1(arg_11_0._tf, false)

	return
end

function var_0_1.OnDestroy(arg_12_0)
	arg_12_0:Close()

	return
end

return var_0_1
