local var_0_0 = class("CommanderTreePage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CommanderTreeUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.treePanel = arg_2_0._tf
	arg_2_0.treeList = UIItemList.New(arg_2_0.treePanel:Find("bg/frame/bg/talents"), arg_2_0.treePanel:Find("bg/frame/bg/talents/telent"))
	arg_2_0.treeTalentDesTxt = arg_2_0.treePanel:Find("bg/frame/bg/desc/Text"):GetComponent(typeof(Text))
	arg_2_0.treePanelCloseBtn = arg_2_0.treePanel:Find("bg/frame/close_btn")

	setActive(arg_2_0.treePanel, false)
	onButton(arg_2_0, arg_2_0.treePanel, function()
		arg_2_0:closeTreePanel()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.treePanelCloseBtn, function()
		arg_2_0:closeTreePanel()

		return
	end, SFX_PANEL)
	setText(arg_2_0._tf:Find("Text"), i18n("commander_choice_talent_4"))

	return
end

function var_0_0.Show(arg_5_0, arg_5_1)
	setActive(arg_5_0.treePanel, true)
	arg_5_0.treePanel:SetAsLastSibling()

	local function var_5_0(arg_6_0)
		arg_5_0.treeTalentDesTxt.text = arg_6_0:getConfig("desc")

		return
	end

	local var_5_1 = arg_5_1:getTalentList()

	arg_5_0.treeList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = CommanderTalent.New({
				origin = false,
				id = var_5_1[arg_7_1 + 1]
			})

			onToggle(arg_5_0, arg_7_2, function(arg_8_0)
				if arg_8_0 then
					var_5_0(var_7_0)
				end

				return
			end, SFX_PANEL)
			setText(arg_7_2:Find("name"), var_7_0:getConfig("name"))
			triggerToggle(arg_7_2, arg_5_1.id == var_7_0.id)
			setActive(arg_7_2:Find("curr"), arg_5_1.id == var_7_0.id)
			setActive(arg_7_2:Find("arr"), arg_7_1 ~= #var_5_1 - 1)
			GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. var_7_0:getConfig("icon"), "", arg_7_2)
		end

		return
	end)
	arg_5_0.treeList:align(#arg_5_1:getTalentList())
	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf)

	return
end

function var_0_0.Hide(arg_9_0)
	arg_9_0:closeTreePanel()

	return
end

function var_0_0.closeTreePanel(arg_10_0)
	setActive(arg_10_0.treePanel, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

return var_0_0
