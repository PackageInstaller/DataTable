local var_0_0 = class("NewEducateTopRes")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.event = arg_1_2
	arg_1_0.bgImage = arg_1_0._tf:GetComponent(typeof(Image))
	arg_1_0.resUIList = UIItemList.New(arg_1_0._tf, arg_1_0._tf:Find("tpl"))

	arg_1_0.resUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventInit then
			arg_1_0:OnInitItem(arg_2_1, arg_2_2)
		elseif arg_2_0 == UIItemList.EventUpdate then
			arg_1_0:OnUpdateItem(arg_2_1, arg_2_2)
		end

		return
	end)

	return
end

function var_0_0.SetBgEnable(arg_3_0, arg_3_1)
	arg_3_0.bgImage.enabled = arg_3_1

	return
end

function var_0_0.OnInitItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.resIds[arg_4_1 + 1]

	setActive(arg_4_2:Find("line"), arg_4_1 + 1 ~= #arg_4_0.resIds)
	LoadImageSpriteAsync("neweducateicon/" .. pg.child2_resource[var_4_0].icon, arg_4_2:Find("icon"))
	onButton(arg_4_0.event, arg_4_2, function()
		arg_4_0.event:emit(NewEducateBaseUI.ON_ITEM, {
			drop = {
				number = 1,
				type = NewEducateConst.DROP_TYPE.RES,
				id = var_4_0
			}
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = pg.child2_resource[arg_6_0.resIds[arg_6_1 + 1]]

	if pg.child2_resource[arg_6_0.resIds[arg_6_1 + 1]].type == NewEducateChar.RES_TYPE.MOOD then
		local var_6_1 = "/" .. var_6_0.max_value or ""
		local var_6_2 = arg_6_0.char:GetRes(var_6_0.id)

		if var_6_0.type == NewEducateChar.RES_TYPE.MOOD then
			setText(arg_6_2:Find("value"), setColorStr(var_6_2, arg_6_0:GetMoodColor(var_6_2)) .. var_6_1)
		elseif var_6_0.type == NewEducateChar.RES_TYPE.ACTION then
			local var_6_3 = var_6_2 == 0 and setColorStr(var_6_2, "#ee4a4a") or var_6_2

			setText(arg_6_2:Find("value"), var_6_3)
		else
			setText(arg_6_2:Find("value"), var_6_2 .. var_6_1)
		end

		return
	end
end

function var_0_0.Update(arg_7_0, arg_7_1)
	arg_7_0.char = arg_7_1
	arg_7_0.resIds = arg_7_0.resIds or {
		arg_7_0.char:GetResIdByType(NewEducateChar.RES_TYPE.MONEY),
		arg_7_0.char:GetResIdByType(NewEducateChar.RES_TYPE.MOOD),
		arg_7_0.char:GetResIdByType(NewEducateChar.RES_TYPE.ACTION)
	}

	arg_7_0.resUIList:align(#arg_7_0.resIds)

	return
end

function var_0_0.GetMoodColor(arg_8_0, arg_8_1)
	if arg_8_1 < 20 then
		return "#ee4a4a"
	elseif arg_8_1 < 40 then
		return "#ab4734"
	elseif arg_8_1 < 60 then
		return "#393A3C"
	else
		return "#00c79b"
	end

	return
end

function var_0_0.Dispose(arg_9_0)
	return
end

return var_0_0
