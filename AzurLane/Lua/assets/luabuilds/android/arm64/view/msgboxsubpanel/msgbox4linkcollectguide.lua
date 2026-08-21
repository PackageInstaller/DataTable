local var_0_0 = class("Msgbox4LinkCollectGuide", import(".MsgboxSubPanel"))

var_0_0.SHOW_TYPE_NORMAL = 1
var_0_0.SHOW_TYPE_LIMIT = 2
var_0_0.SKIP_TYPE_SCENE = 2
var_0_0.SKIP_TYPE_ACTIVITY = 3

function var_0_0.getUIName(arg_1_0)
	return "Msgbox4LinkCollectGuide"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.title = arg_2_0._tf:Find("name_mask/name")
	arg_2_0.owner = arg_2_0._tf:Find("owner")

	setText(arg_2_0.owner:Find("title"), i18n("collect_page_got"))

	arg_2_0.ownerLimit = arg_2_0._tf:Find("owner_limit")

	setText(arg_2_0.ownerLimit:Find("title"), i18n("collect_page_got"))

	arg_2_0.iconTF = arg_2_0._tf:Find("left/IconTpl")
	arg_2_0.ownTF = arg_2_0._tf:Find("left/own")
	arg_2_0.detailTF = arg_2_0._tf:Find("left/detail")
	arg_2_0.desc = arg_2_0._tf:Find("content/desc")
	arg_2_0.list = arg_2_0._tf:Find("content/skipable_list")
	arg_2_0.tpl = arg_2_0.list:Find("tpl")

	return
end

function var_0_0.OnRefresh(arg_3_0, arg_3_1)
	arg_3_0:SetWindowSize(Vector2(930, 540))
	setActive(arg_3_0.viewParent._btnContainer, false)

	local var_3_0 = Drop.New({
		type = arg_3_1.drop_type,
		id = arg_3_1.drop_id
	})

	updateDrop(arg_3_0.iconTF, var_3_0)
	UpdateOwnDisplay(arg_3_0.ownTF, var_3_0)
	RegisterDetailButton(arg_3_0.viewParent, arg_3_0.detailTF, var_3_0)
	changeToScrollText(arg_3_0.title, var_3_0.cfg.name)
	setText(arg_3_0.desc, var_3_0.desc)

	if arg_3_1.show_type == var_0_0.SHOW_TYPE_NORMAL then
		setActive(arg_3_0.owner, true)
		setActive(arg_3_0.ownerLimit, false)
		setText(arg_3_0.owner:Find("Text"), arg_3_1.count)
	elseif arg_3_1.show_type == var_0_0.SHOW_TYPE_LIMIT then
		setActive(arg_3_0.owner, false)
		setActive(arg_3_0.ownerLimit, true)

		local var_3_1 = arg_3_1.count_limit or 0

		setText(arg_3_0.ownerLimit:Find("Text"), arg_3_1.count .. "/" .. var_3_1)
	end

	UIItemList.StaticAlign(arg_3_0.list, arg_3_0.tpl, #arg_3_1.skipable_list, function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = arg_3_1.skipable_list[arg_4_1 + 1][1]
			local var_4_1 = arg_3_1.skipable_list[arg_4_1 + 1][2]

			changeToScrollText(arg_4_2:Find("mask/title"), arg_3_1.skipable_list[arg_4_1 + 1][3])
			onButton(arg_3_0, arg_4_2:Find("skip_btn"), function()
				if var_4_0 == var_0_0.SKIP_TYPE_SCENE then
					local var_5_0 = var_4_1[2] or {}

					pg.m02:sendNotification(GAME.GO_SCENE, var_4_1[1], var_5_0)
				elseif var_4_0 == var_0_0.SKIP_TYPE_ACTIVITY then
					pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
						id = var_4_1
					})
				end

				arg_3_0.viewParent:hide()

				return
			end, SFX_PANEL)
			Canvas.ForceUpdateCanvases()
		end

		return
	end)

	return
end

return var_0_0
