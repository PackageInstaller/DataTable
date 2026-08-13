class = var_0_10000

local var_0_0 = "PublicGuildMainScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "PublicGuildMainUI"
end

function var_0_1.OnUpdateDonateList(arg_2_0)
	if arg_2_0.page then
		isa = var_1

		local var_2_0 = arg_2_0.page

		PublicGuildOfficePage = var_1_10003

		if var_1(var_2_0, var_1_10003) then
			local var_2_1 = arg_2_0.page

			if var_1.GetLoaded(var_2_1) then
				local var_2_2 = arg_2_0.page

				var_1.Flush(var_2_2)
			end
		end
	end

	return
end

function var_0_1.OnPlayerUpdate(arg_3_0, arg_3_1)
	arg_3_0:SetPlayer(arg_3_1)

	if arg_3_0.resPage then
		local var_3_0 = arg_3_0.resPage

		if var_2.GetLoaded(var_3_0) then
			local var_3_1 = arg_3_0.resPage

			var_2.Update(var_3_1, arg_3_1)
		end
	end

	return
end

function var_0_1.OnTechGroupUpdate(arg_4_0, arg_4_1)
	if arg_4_0.page then
		isa = var_2

		local var_4_0 = arg_4_0.page

		PublicGuildTechnologyPage = var_1_10004

		if var_2(var_4_0, var_1_10004) then
			local var_4_1 = arg_4_0.page

			if var_2.GetLoaded(var_4_1) then
				local var_4_2 = arg_4_0.page

				var_2.OnTechGroupUpdate(var_4_2, arg_4_1)
			end
		end
	end

	return
end

function var_0_1.RefreshAll(arg_5_0)
	if arg_5_0.page then
		local var_5_0 = arg_5_0.page

		if var_1.GetLoaded(var_5_0) then
			local var_5_1 = arg_5_0.page

			var_1.Show(var_5_1, arg_5_0.publicGuild)
		end
	end

	return
end

function var_0_1.SetPublicGuild(arg_6_0, arg_6_1)
	arg_6_0.publicGuild = arg_6_1

	return
end

function var_0_1.SetPlayer(arg_7_0, arg_7_1)
	arg_7_0.player = arg_7_1

	return
end

function var_0_1.init(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0._playerResOb = var_1.Find(var_8_0, "blur_panel/adapt/top/res")
	PublicGuildResPage = var_1
	arg_8_0.resPage = var_1.New(arg_8_0._playerResOb, arg_8_0.event)

	local var_8_1 = arg_8_0._tf

	arg_8_0.backBtn = var_1.Find(var_8_1, "blur_panel/adapt/top/back")

	local var_8_2 = arg_8_0._tf

	arg_8_0.helpBtn = var_1.Find(var_8_2, "blur_panel/adapt/left_length/frame/help")

	local var_8_3 = {}
	local var_8_4 = arg_8_0._tf

	var_8_3[1] = var_2.Find(var_8_4, "blur_panel/adapt/left_length/frame/scroll_rect/tagRoot/office")

	local var_8_5 = arg_8_0._tf

	var_8_3[2] = var_2.Find(var_8_5, "blur_panel/adapt/left_length/frame/scroll_rect/tagRoot/technology")
	arg_8_0.toggles = var_8_3

	local var_8_6 = arg_8_0._tf
	local var_8_7 = var_1.Find(var_8_6, "pages")
	local var_8_8 = {}

	PublicGuildOfficePage = var_3
	var_8_8[1] = var_3.New(var_8_7, arg_8_0.event)
	PublicGuildTechnologyPage = var_3
	var_8_8[2] = var_3.New(var_8_7, arg_8_0.event)
	arg_8_0.pages = var_8_8

	return
end

function var_0_1.didEnter(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.GuildPaintingMgr.GetInstance()
	local var_9_1 = var_1.Enter
	local var_9_2 = arg_9_0._tf

	var_9_1(var_9_0, var_3.Find(var_9_2, "bg/painting"))

	local var_9_3 = arg_9_0.resPage

	var_1.ExecuteAction(var_9_3, "Update", arg_9_0.player)

	onButton = var_1

	local var_9_4 = arg_9_0
	local var_9_5 = arg_9_0.backBtn

	local function var_9_6()
		local var_10_0 = arg_9_0

		var_0.emit(var_10_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_5

	var_1(var_9_4, var_9_5, var_9_6, var_5)

	onButton = var_1

	local var_9_7 = arg_9_0
	local var_9_8 = arg_9_0.helpBtn

	local function var_9_9()
		isa = var_2_10000

		local var_11_0 = arg_9_0.page

		PublicGuildOfficePage = var_2_10002

		local var_11_2

		if var_2_10000(var_11_0, var_2_10002) then
			pg = var_11_2

			local var_11_1 = var_11_2.MsgboxMgr.GetInstance()

			var_11_2 = var_11_2.ShowMsgBox
			var_2_10002 = {}
			MSGBOX_TYPE_HELP = var_2_10003
			var_2_10002.type = var_2_10003
			i18n = var_2_10003
			var_2_10002.helps = var_2_10003("guild_public_office_tip")

			var_11_2(var_11_1, var_2_10002)
		else
			isa = var_11_2

			local var_11_3 = arg_9_0.page

			PublicGuildTechnologyPage = var_2_10002

			if var_11_2(var_11_3, var_2_10002) then
				pg = var_0

				local var_11_4 = var_0.MsgboxMgr.GetInstance()
				local var_11_5 = var_0.ShowMsgBox
				local var_11_6 = {}

				MSGBOX_TYPE_HELP = var_2_10003
				var_11_6.type = var_2_10003
				i18n = var_2_10003
				var_11_6.helps = var_2_10003("guild_public_tech_tip")

				var_11_5(var_11_4, var_11_6)
			end
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_9_7, var_9_8, var_9_9, var_5)

	ipairs = var_1

	for iter_9_0, iter_9_1 in var_1(arg_9_0.toggles) do
		onToggle = var_1_10006

		local var_9_10 = arg_9_0
		local var_9_11 = iter_9_1

		local function var_9_12(arg_12_0)
			if arg_12_0 then
				local var_12_0 = arg_9_0

				var_1.SwitchPage(var_12_0, iter_9_0)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_9_10, var_9_11, var_9_12, var_1_10010)

		if iter_9_0 == 1 then
			triggerToggle = var_1_10006

			var_1_10006(iter_9_1, true)
		end
	end

	return
end

function var_0_1.SwitchPage(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.pages[arg_13_1]

	if arg_13_0.page then
		local var_13_1 = arg_13_0.page

		var_3.Hide(var_13_1)
	end

	var_13_0:ExecuteAction("Show", arg_13_0.publicGuild)

	arg_13_0.page = var_13_0

	return
end

function var_0_1.willExit(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.GuildPaintingMgr.GetInstance()

	var_1.Exit(var_14_0)

	local var_14_1 = arg_14_0.resPage

	var_1.Destroy(var_14_1)

	pairs = var_1

	for iter_14_0, iter_14_1 in var_1(arg_14_0.pages) do
		iter_14_1:Destroy()
	end

	return
end

return var_0_1
