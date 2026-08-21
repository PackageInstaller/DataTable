local var_0_0 = class("IslandTechCentreCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.lvTF = arg_1_0._tf:Find("level/lv")
	arg_1_0.lineTF = arg_1_0._tf:Find("line")
	arg_1_0.lockTF = arg_1_0._tf:Find("lock")

	setText(arg_1_0.lockTF:Find("Image/tip/Text"), i18n("island_tech_lock"))

	local var_1_0 = arg_1_0._tf:Find("items_view/content")

	arg_1_0.uiList = UIItemList.New(var_1_0, var_1_0:Find("tpl"))

	arg_1_0.uiList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			arg_1_0:UpdateItem(arg_2_1, arg_2_2)
		end

		return
	end)

	return
end

function var_0_0.UpdateItem(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = getProxy(IslandProxy):GetIsland():GetTechnologyAgency():GetTechnology(arg_3_0.ids[arg_3_1 + 1])

	setText(arg_3_2:Find("corner/Text"), var_3_0:getConfig("tech_level"))
	LoadImageSpriteAsync("island/IslandTechnology/" .. var_3_0:getConfig("tech_icon"), arg_3_2:Find("icon"), true)
	setActive(arg_3_2:Find("line"), arg_3_1 + 1 ~= #arg_3_0.ids)

	local var_3_1 = var_3_0:GetStatus()

	setActive(arg_3_2:Find("receive"), var_3_1 == IslandTechnology.STATUS.RECEIVE)
	setActive(arg_3_2:Find("studying"), var_3_1 == IslandTechnology.STATUS.STUDYING)
	setImageAlpha(arg_3_2:Find("icon"), (var_3_1 == IslandTechnology.STATUS.STUDYING or var_3_1 == IslandTechnology.STATUS.LOCK or var_3_1 == IslandTechnology.STATUS.NORMAL and var_3_0:GetFinishedCnt() == 0) and 0.5 or 1)

	local var_3_2 = arg_3_2:GetComponent(typeof(Animation))

	if var_3_1 == IslandTechnology.STATUS.NORMAL and var_3_0:GetFinishedCnt() == 0 then
		var_3_2:Play("anim_Island_technology_tplicon_in")
	elseif var_3_1 == IslandTechnology.STATUS.STUDYING then
		var_3_2:Play("anim_Island_technology_tplstudy_in")
	elseif var_3_1 == IslandTechnology.STATUS.RECEIVE then
		var_3_2:Play("anim_Island_technology_tplreceive_in")
	else
		var_3_2:Stop()
	end

	onButton(arg_3_0, arg_3_2, function()
		existCall(arg_3_0.onItemClick, var_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Update(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	arg_5_0.ids = arg_5_2
	arg_5_0.onItemClick = arg_5_5

	setText(arg_5_0.lvTF, "LV." .. arg_5_1)
	setActive(arg_5_0.lineTF, not arg_5_3)
	setActive(arg_5_0.lockTF, arg_5_4)
	arg_5_0.uiList:align(#arg_5_0.ids)

	return
end

function var_0_0.Dispose(arg_6_0)
	pg.DelegateInfo.Dispose(arg_6_0)

	return
end

return var_0_0
