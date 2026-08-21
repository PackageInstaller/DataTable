local var_0_0 = class("IslandShipDressUpSortPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandDressUpSortUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.sortUIItemList = UIItemList.New(arg_2_0._tf:Find("frame"), arg_2_0._tf:Find("frame/tpl"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_5_0, arg_5_1, arg_5_2)
	var_0_0.super.Show(arg_5_0)

	arg_5_0.indexData = arg_5_1
	arg_5_0.callback = arg_5_2

	arg_5_0:InitList()

	return
end

function var_0_0.InitList(arg_6_0)
	arg_6_0.sortUIItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			setText(arg_7_2:Find("Text"), setColorStr(IslandShipDressUpPageNew.Sort2CN(IslandShipDressUpPageNew.SORT_LIST[arg_7_1 + 1]), arg_6_0.indexData.sortKey == IslandShipDressUpPageNew.SORT_LIST[arg_7_1 + 1] and "#393a3c" or "#7c7e81"))
			onButton(arg_6_0, arg_7_2, function()
				if arg_6_0.callback then
					arg_6_0.callback(var_0)
				end

				arg_6_0:Hide()

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_6_0.sortUIItemList:align(#IslandShipDressUpPageNew.SORT_LIST)

	return
end

function var_0_0.Hide(arg_9_0)
	var_0_0.super.Hide(arg_9_0)

	arg_9_0.callback = nil

	return
end

function var_0_0.OnDestroy(arg_10_0)
	if arg_10_0:isShowing() then
		arg_10_0:Hide()
	end

	return
end

return var_0_0
