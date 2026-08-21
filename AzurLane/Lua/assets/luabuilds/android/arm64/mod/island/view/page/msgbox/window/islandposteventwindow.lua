local var_0_0 = class("IslandPostEventWindow", import(".IslandBaseMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandPostEventboxUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.titleTxt = arg_2_0._tf:Find("title/Text"):GetComponent(typeof(Text))
	arg_2_0.descTxt = arg_2_0._tf:Find("title/desc"):GetComponent(typeof(Text))
	arg_2_0.icon = arg_2_0._tf:Find("title/icon_bg/icon"):GetComponent(typeof(Image))
	arg_2_0.bigIcon = arg_2_0._tf:Find("frame/ico"):GetComponent(typeof(Image))
	arg_2_0.itemsList = UIItemList.New(arg_2_0._tf:Find("frame/items"), arg_2_0._tf:Find("frame/items/tpl"))
	arg_2_0.additionList = UIItemList.New(arg_2_0._tf:Find("frame/addition"), arg_2_0._tf:Find("frame/addition/tpl"))
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/btns/close")
	arg_2_0.openBtn = arg_2_0._tf:Find("frame/btns/open")

	setText(arg_2_0._tf:Find("title/event/Text"), i18n("island_post_event_label"))
	setText(arg_2_0._tf:Find("frame/btns/close/Text"), i18n("island_post_event_close_label"))
	setText(arg_2_0._tf:Find("frame/btns/open/Text"), i18n("island_post_event_open_label"))
	setText(arg_2_0._tf:Find("frame/title/Text"), i18n("island_post_event_addition_label"))

	arg_2_0.animation = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.dftAniEvent = arg_2_0._tf:GetComponent(typeof(DftAniEvent))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		if not arg_3_0.isSwitch then
			arg_3_0:Switch()

			return
		end

		triggerButton(arg_3_0.closeBtn)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.openBtn, function()
		arg_3_0:Hide()

		if arg_3_0.settings.onYes then
			arg_3_0.settings.onYes()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Switch(arg_7_0)
	if arg_7_0.isAnimating then
		return
	end

	arg_7_0.isAnimating = true

	arg_7_0.animation:Play("switch")

	return
end

function var_0_0.OnShow(arg_8_0)
	arg_8_0.dftAniEvent:SetEndEvent(function()
		arg_8_0.isSwitch = true
		arg_8_0.isAnimating = false

		return
	end)

	arg_8_0.isSwitch = false
	arg_8_0.isAnimating = false
	arg_8_0.config = pg.island_manage_event[arg_8_0.settings.rest:GetEventInfo()]

	arg_8_0:UpdateTitle(arg_8_0.settings.rest)
	arg_8_0:UpdateMainView(arg_8_0.settings.rest)

	if not arg_8_0.settings.isNew then
		triggerButton(arg_8_0._tf)
	end

	if arg_8_0.settings.blur then
		arg_8_0:BlurPanel()
	end

	if arg_8_0.settings.isNew then
		getProxy(SettingsProxy):RecordIslandRestEvet()
	end

	return
end

function var_0_0.BlurPanel(arg_10_0)
	arg_10_0.view.viewComponent:BlurPanel(arg_10_0.view._tf)

	return
end

function var_0_0.UnBlurPanel(arg_11_0)
	arg_11_0.view.viewComponent:UnOverlayPanel(arg_11_0.view._tf, pg.UIMgr.GetInstance().OverlayMain)

	return
end

function var_0_0.UpdateTitle(arg_12_0, arg_12_1)
	arg_12_0.titleTxt.text = arg_12_0.config.name
	arg_12_0.descTxt.text = string.gsub(arg_12_0.config.desc, "$1", arg_12_1:getConfig("name"))
	arg_12_0.icon.sprite = GetSpriteFromAtlas("ui/islandpostmsgboxui_atlas", "icon" .. arg_12_0.config.id)

	return
end

function var_0_0.UpdateMainView(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:WarpItemInfo(arg_13_1)

	arg_13_0.itemsList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_14_2, (Drop.New({
				count = 0,
				type = DROP_TYPE_ISLAND_ITEM,
				id = var_13_0[arg_14_1 + 1].id
			})))
		end

		return
	end)
	arg_13_0.itemsList:align(#arg_13_0:WarpItemInfo(arg_13_1))

	local var_13_1 = arg_13_0:WarpAdditionInfo()

	arg_13_0.additionList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			setText(arg_15_2:Find("Text"), var_13_1[arg_15_1 + 1][1])
			setText(arg_15_2:Find("value"), "+" .. var_13_1[arg_15_1 + 1][2] .. "%")
		end

		return
	end)
	arg_13_0.additionList:align(#arg_13_0:WarpAdditionInfo())

	local var_13_2 = arg_13_1:getConfig("aera_group") or 1

	LoadSpriteAsync("island/islandrestevent/" .. var_13_2 .. arg_13_0.config.id, function(arg_16_0)
		if IsNil(arg_13_0.bigIcon) then
			return
		end

		arg_13_0.bigIcon.sprite = arg_16_0

		return
	end)

	return
end

function var_0_0.WarpItemInfo(arg_17_0, arg_17_1)
	local var_17_0, var_17_1 = arg_17_1:GetEventInfo()
	local var_17_2 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	for iter_17_0, iter_17_1 in ipairs(arg_17_1:getConfig("item_id")) do
		local var_17_3 = var_17_2:GetItemById(iter_17_1[1]) or IslandItem.New({
			id = iter_17_1[1]
		})

		if var_17_3 and var_17_1[var_17_3.id] then
			table.insert({}, var_17_3)
		end
	end

	return {}
end

function var_0_0.WarpAdditionInfo(arg_18_0)
	table.insert({}, {
		i18n("island_addition_influence"),
		arg_18_0.config.influence_bonus
	})
	table.insert({}, {
		i18n("island_addition_sale"),
		arg_18_0.config.event_effect[1][1]
	})

	return {}
end

function var_0_0.OnHide(arg_19_0)
	if arg_19_0.settings.onHide then
		arg_19_0.settings.onHide()

		arg_19_0.settings.onHide = nil
	end

	if arg_19_0.dftAniEvent then
		arg_19_0.dftAniEvent:SetEndEvent(nil)
	end

	if arg_19_0.settings.blur then
		arg_19_0:UnBlurPanel()
	end

	return
end

return var_0_0
