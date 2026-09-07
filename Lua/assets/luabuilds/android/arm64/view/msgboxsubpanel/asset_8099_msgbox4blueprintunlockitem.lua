local Msgbox4BlueprintUnlockItem = class("Msgbox4BlueprintUnlockItem", import(".MsgboxSubPanel"))

function Msgbox4BlueprintUnlockItem:getUIName()
	return "Msgbox4BlueprintUnlockItem"
end

function Msgbox4BlueprintUnlockItem:OnRefresh(arg_2_1)
	rtf(self.viewParent._window).sizeDelta = Vector2(1010, 685)

	local var_2_0 = arg_2_1.blueprints

	updateDrop(self._tf:Find("IconTpl"), {
		type = DROP_TYPE_ITEM,
		id = arg_2_1.item.id
	})
	setText(self._tf:Find("content_unlock/title/bg/Text"), i18n("tech_select_tip1"))
	setText(self._tf:Find("content_unlock/title/Text"), i18n("tech_select_tip2"))

	local var_2_1 = self._tf:Find("content_unlock/mask/list")
	local var_2_2 = UIItemList.New(var_2_1, var_2_1:GetChild(0))

	var_2_2:make(function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1

		if arg_3_0 == UIItemList.EventUpdate then
			updateDrop(arg_3_2:Find("IconTpl"), {
				type = DROP_TYPE_SHIP,
				id = ShipGroup.getDefaultShipConfig(var_2_0[arg_3_1].id).id
			})
			setActive(arg_3_2:Find("IconTpl/mask"), var_2_0[arg_3_1]:isUnlock())
			setText(arg_3_2:Find("IconTpl/mask/Text"), i18n("tech_select_tip3"))
		end

		return
	end)
	var_2_2:align(#arg_2_1.blueprints)

	local var_2_3 = arg_2_1.item:getConfig("display_icon")

	setText(self._tf:Find("content_after/title/bg/Text"), i18n("tech_select_tip4"))
	setText(self._tf:Find("content_after/title/Text"), i18n("tech_select_tip5"))

	local var_2_4 = self._tf:Find("content_after/list")
	local var_2_5 = UIItemList.New(var_2_4, var_2_4:GetChild(0))

	var_2_5:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0, var_4_1, var_4_2 = unpack(var_2_3[arg_4_1])

			updateDrop(arg_4_2:Find("IconTpl"), {
				type = var_4_0,
				id = var_4_1,
				count = var_4_2
			})
		end

		return
	end)
	var_2_5:align(#var_2_3)

	return
end

return Msgbox4BlueprintUnlockItem
