class = var_0_10000

local var_0_0 = "CommanderReplaceTalentPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderCatReplaceTalentUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "bg/frame/bg/talents/content")
	local var_2_3 = arg_2_0._tf

	arg_2_0.replaceList = var_2_0(var_2_2, var_4.Find(var_2_3, "bg/frame/bg/talents/content/talent"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.replaceTargetTF = var_1.Find(var_2_4, "bg/frame/bg/talent")

	local var_2_5 = arg_2_0._tf

	arg_2_0.replaceTalent = var_1.Find(var_2_5, "bg/frame/bg/replace")

	local var_2_6 = arg_2_0._tf

	arg_2_0.replaceCloseBtn = var_1.Find(var_2_6, "bg/frame/close_btn")

	local var_2_7 = arg_2_0._tf

	arg_2_0.replaceCancelBtn = var_1.Find(var_2_7, "bg/frame/cancel_btn")

	local var_2_8 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_8, "bg/frame/confirm_btn")
	setActive = var_1

	local var_2_9 = arg_2_0._tf

	var_1(var_3.Find(var_2_9, "bg/frame/consume"), false)

	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "bg/frame/bg/title/Text")

	i18n = var_4

	var_1(var_2_11, var_4("commander_choice_talent_3"))

	setText = var_1

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_3.Find(var_2_12, "bg/frame/bg/talents/title/Text")

	i18n = var_4

	var_1(var_2_13, var_4("commander_choice_talent_2"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.replaceCloseBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.replaceCancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1, arg_7_2)
	var_0_1.super.Show(arg_7_0)

	local var_7_0 = arg_7_0._tf

	var_3.SetAsLastSibling(var_7_0)

	arg_7_0.commander = arg_7_1

	arg_7_0:UpdateTalents(arg_7_2, nil)
	arg_7_0:UpdateList(arg_7_2)

	return
end

function var_0_1.UpdateList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.commander
	local var_8_1 = var_2.getTalents(var_8_0)
	local var_8_2 = arg_8_0.replaceList

	var_4.make(var_8_2, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = var_8_1[arg_9_1 + 1]

			onButton = var_4

			local var_9_1 = arg_8_0
			local var_9_2 = arg_9_2

			local function var_9_3()
				if arg_8_0.prevToggle ~= arg_9_2 then
					local var_10_0 = arg_8_0

					var_0.UpdateTalents(var_10_0, arg_8_1, var_9_0)

					if arg_8_0.prevToggle then
						setActive = var_0

						local var_10_1 = arg_8_0.prevToggle

						var_0(var_2.Find(var_10_1, "mark"), false)
					end

					local var_10_2 = arg_8_0

					var_10_2.prevToggle = arg_9_2
					setActive = var_10_2

					local var_10_3 = arg_9_2

					var_10_2(var_2.Find(var_10_3, "mark"), true)
				end

				return
			end

			SFX_PANEL = var_2_10009

			var_4(var_9_1, var_9_2, var_9_3, var_2_10009)

			GetImageSpriteFromAtlasAsync = var_4

			var_4("CommanderTalentIcon/" .. var_9_0:getConfig("icon"), "", arg_9_2)
		end

		return
	end)

	local var_8_3 = arg_8_0.replaceList

	var_4.align(var_8_3, #var_8_1)

	return
end

function var_0_1.UpdateTalents(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.commander

	arg_11_0:UpdateTalentCard(arg_11_0.replaceTargetTF, arg_11_1)
	arg_11_0:UpdateTalentCard(arg_11_0.replaceTalent, arg_11_2)

	onButton = var_4

	local var_11_1 = arg_11_0
	local var_11_2 = arg_11_0.confirmBtn

	local function var_11_3()
		if arg_11_2 and arg_11_1 and var_11_0 then
			local var_12_0 = arg_11_2
			local var_12_3

			if var_0.getConfig(var_12_0, "worth") > 1 then
				pg = var_0

				local var_12_1 = var_0.MsgboxMgr.GetInstance()
				local var_12_2 = var_0.ShowMsgBox

				var_12_3 = {}
				i18n = var_2_10004
				var_12_3.content = var_2_10004("commander_ability_replace_warning")

				function var_12_3.onYes()
					local var_13_0 = arg_11_0
					local var_13_1 = var_0.emit

					CommanderCatMediator = var_3_10003

					var_13_1(var_13_0, var_3_10003.LEARN_TALENT, var_11_0.id, arg_11_1.id, arg_11_2.id)

					local var_13_2 = arg_11_0

					var_0.Hide(var_13_2)

					return
				end

				var_12_2(var_12_1, var_12_3)
			else
				local var_12_4 = arg_11_0
				local var_12_5 = var_0.emit

				CommanderCatMediator = var_12_3

				var_12_5(var_12_4, var_12_3.LEARN_TALENT, var_11_0.id, arg_11_1.id, arg_11_2.id)

				local var_12_6 = arg_11_0

				var_0.Hide(var_12_6)
			end
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_11_1, var_11_2, var_11_3, var_1_10009)

	return
end

function var_0_1.UpdateTalentCard(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1
	local var_14_1 = arg_14_1.Find(var_14_0, "unlock")
	local var_14_2 = arg_14_1
	local var_14_3 = arg_14_1.Find(var_14_2, "lock")

	if arg_14_2 then
		GetImageSpriteFromAtlasAsync = var_14_0

		local var_14_4 = "CommanderTalentIcon/" .. arg_14_2:getConfig("icon")
		local var_14_5 = ""
		local var_14_6 = var_14_1

		var_14_0(var_14_4, var_14_5, var_14_1.Find(var_14_6, "icon"))

		if var_14_1:Find("tree_btn") then
			onButton = var_14_2

			local var_14_7 = arg_14_0
			local var_14_8 = var_14_0

			local function var_14_9()
				local var_15_0 = arg_14_0.contextData.treePanel

				var_0.ExecuteAction(var_15_0, "Show", arg_14_2)

				return
			end

			SFX_PANEL = var_14_6

			var_14_2(var_14_7, var_14_8, var_14_9, var_14_6)
		end

		setText = var_14_2

		var_14_2(var_14_1:Find("name_bg/Text"), arg_14_2:getConfig("name"))

		setScrollText = var_14_2

		var_14_2(var_14_1:Find("desc/Text"), arg_14_2:getConfig("desc"))
	end

	setActive = var_14_0

	var_14_0(var_14_1, arg_14_2)

	if var_14_3 then
		setActive = var_14_0

		var_14_0(var_14_3, not arg_14_2)
	end

	return
end

function var_0_1.Hide(arg_16_0)
	var_0_1.super.Hide(arg_16_0)

	if arg_16_0.prevToggle then
		setActive = var_1

		local var_16_0 = arg_16_0.prevToggle

		var_1(var_3.Find(var_16_0, "mark"), false)

		arg_16_0.prevToggle = nil
	end

	return
end

function var_0_1.OnDestroy(arg_17_0)
	return
end

return var_0_1
