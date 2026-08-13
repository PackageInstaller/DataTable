class = var_0_10000

local var_0_0 = "CommanderTreePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderTreeUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0.treePanel = arg_2_0._tf
	UIItemList = var_1

	local var_2_0 = var_1.New
	local var_2_1 = arg_2_0.treePanel
	local var_2_2 = var_3.Find(var_2_1, "bg/frame/bg/talents")
	local var_2_3 = arg_2_0.treePanel

	arg_2_0.treeList = var_2_0(var_2_2, var_4.Find(var_2_3, "bg/frame/bg/talents/telent"))

	local var_2_4 = arg_2_0.treePanel
	local var_2_5 = var_1.Find(var_2_4, "bg/frame/bg/desc/Text")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	Text = var_2_3
	arg_2_0.treeTalentDesTxt = var_2_6(var_2_5, var_4(var_2_3))

	local var_2_7 = arg_2_0.treePanel

	arg_2_0.treePanelCloseBtn = var_1.Find(var_2_7, "bg/frame/close_btn")
	setActive = var_1

	var_1(arg_2_0.treePanel, false)

	onButton = var_1

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.treePanel

	local function var_2_10()
		local var_3_0 = arg_2_0

		var_0.closeTreePanel(var_3_0)

		return
	end

	SFX_PANEL = var_2_3

	var_1(var_2_8, var_2_9, var_2_10, var_2_3)

	onButton = var_1

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.treePanelCloseBtn

	local function var_2_13()
		local var_4_0 = arg_2_0

		var_0.closeTreePanel(var_4_0)

		return
	end

	SFX_PANEL = var_2_3

	var_1(var_2_11, var_2_12, var_2_13, var_2_3)

	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_3.Find(var_2_14, "Text")

	i18n = var_2_12

	var_1(var_2_15, var_2_12("commander_choice_talent_4"))

	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	setActive = var_1_10002

	var_1_10002(arg_5_0.treePanel, true)

	local var_5_0 = arg_5_0.treePanel

	var_2.SetAsLastSibling(var_5_0)

	local function var_5_1(arg_6_0)
		arg_5_0.treeTalentDesTxt.text = arg_6_0:getConfig("desc")

		return
	end

	local var_5_2 = arg_5_1:getTalentList()
	local var_5_3 = arg_5_0.treeList

	var_4.make(var_5_3, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			CommanderTalent = var_3

			local var_7_0 = var_3.New({
				origin = false,
				id = var_5_2[arg_7_1 + 1]
			})

			onToggle = var_2_10004

			local var_7_1 = arg_5_0
			local var_7_2 = arg_7_2

			local function var_7_3(arg_8_0)
				if arg_8_0 then
					var_5_1(var_7_0)
				end

				return
			end

			SFX_PANEL = var_2_10009

			var_2_10004(var_7_1, var_7_2, var_7_3, var_2_10009)

			setText = var_2_10004

			var_2_10004(arg_7_2:Find("name"), var_7_0:getConfig("name"))

			triggerToggle = var_2_10004

			var_2_10004(arg_7_2, arg_5_1.id == var_7_0.id)

			setActive = var_2_10004

			var_2_10004(arg_7_2:Find("curr"), arg_5_1.id == var_7_0.id)

			setActive = var_2_10004

			var_2_10004(arg_7_2:Find("arr"), arg_7_1 ~= #var_5_2 - 1)

			GetImageSpriteFromAtlasAsync = var_2_10004

			var_2_10004("CommanderTalentIcon/" .. var_7_0:getConfig("icon"), "", arg_7_2)
		end

		return
	end)

	local var_5_4 = arg_5_0.treeList

	var_4.align(var_5_4, #var_5_2)

	pg = var_4

	local var_5_5 = var_4.UIMgr.GetInstance()

	var_4.BlurPanel(var_5_5, arg_5_0._tf)

	return
end

function var_0_1.Hide(arg_9_0)
	arg_9_0:closeTreePanel()

	return
end

function var_0_1.closeTreePanel(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.treePanel, false)

	pg = var_1_10001

	local var_10_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0._tf, arg_10_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

return var_0_1
