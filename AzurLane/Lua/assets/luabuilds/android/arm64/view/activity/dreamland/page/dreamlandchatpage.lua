local var_0_0 = class("DreamlandChatPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "DreamlandChatUI"
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	arg_2_0.uiList = {
		arg_2_1:Find("adapt/time"),
		arg_2_1:Find("adapt/handbook"),
		arg_2_1:Find("adapt/hotspring")
	}
	arg_2_0.toHideUI = {}

	return
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0.icon = arg_3_0._tf:Find("icon"):GetComponent(typeof(Image))
	arg_3_0.content = arg_3_0._tf:Find("Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.OnInit(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf, function()
		if arg_4_0.clickCnt < arg_4_0.totlalCnt then
			arg_4_0:ShowContent()
		else
			arg_4_0:Hide()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	var_0_0.super.Show(arg_6_0)

	arg_6_0.clickCnt = 0
	arg_6_0.textList = _.flatten(arg_6_1.desc)
	arg_6_0.totlalCnt = #arg_6_0.textList

	arg_6_0:ShowContent()

	arg_6_0.icon.sprite = LoadSprite("exploreObj/icon_" .. arg_6_0:GetPic(arg_6_1))

	arg_6_0.icon:SetNativeSize()
	arg_6_0:HideUI()

	return
end

function var_0_0.ShowContent(arg_7_0)
	arg_7_0.clickCnt = arg_7_0.clickCnt + 1

	local var_7_0 = arg_7_0.textList[arg_7_0.clickCnt] or ""

	arg_7_0.content.text = HXSet.hxLan(var_7_0)

	return
end

function var_0_0.HideUI(arg_8_0)
	arg_8_0.toHideUI = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.uiList) do
		if isActive(iter_8_1) then
			setActive(iter_8_1, false)
			table.insert(arg_8_0.toHideUI, iter_8_1)
		end
	end

	return
end

function var_0_0.ShowUI(arg_9_0)
	local var_9_0 = arg_9_0.toHideUI or {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if not isActive(iter_9_1) then
			setActive(iter_9_1, true)
		end
	end

	arg_9_0.toHideUI = {}

	return
end

function var_0_0.Hide(arg_10_0)
	var_0_0.super.Hide(arg_10_0)

	arg_10_0.textList = {}
	arg_10_0.clickCnt = 0
	arg_10_0.totlalCnt = 0

	arg_10_0:ShowUI()

	return
end

function var_0_0.GetPic(arg_11_0, arg_11_1)
	local var_11_0 = pg.activity_dreamland_explore.get_id_list_by_group[arg_11_1.group] or {}
	local var_11_1 = var_11_0[1] or arg_11_1.id

	return pg.activity_dreamland_explore[var_11_1].pic
end

function var_0_0.OnDestroy(arg_12_0)
	return
end

return var_0_0
