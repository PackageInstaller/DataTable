local var_0_0 = class("NewEducateDropHandler")
local var_0_1 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.dropsTF = arg_1_0._tf:Find("drops")
	arg_1_0.dropUIList = UIItemList.New(arg_1_0.dropsTF, arg_1_0.dropsTF:Find("tpl"))

	arg_1_0.dropUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			local var_2_0 = NewEducateHelper.GetDropConfig(arg_1_0.drops[arg_2_1 + 1])
			local var_2_1 = var_2_0.icon or var_2_0.item_icon

			LoadImageSpriteAsync("neweducateicon/" .. var_2_1, arg_2_2:Find("icon"))
			setText(arg_2_2:Find("name"), var_2_0.name)

			if arg_1_0.drops[arg_2_1 + 1].number > 0 then
				setActive(arg_2_2:Find("reduce"), false)
				setActive(arg_2_2:Find("increase"), true)
				setText(arg_2_2:Find("increase/value"), "+" .. arg_1_0.drops[arg_2_1 + 1].number)
			else
				setActive(arg_2_2:Find("reduce"), true)
				setActive(arg_2_2:Find("increase"), false)
				setText(arg_2_2:Find("reduce/value"), arg_1_0.drops[arg_2_1 + 1].number)
			end

			setActive(arg_2_2:Find("benefit"), false)
		end

		return
	end)

	arg_1_0.polaroidTF = arg_1_0._tf:Find("polaroid")

	return
end

function var_0_0.Play(arg_3_0, arg_3_1, arg_3_2)
	setActive(arg_3_0._go, true)
	setActive(arg_3_0.dropsTF, true)
	setActive(arg_3_0.polaroidTF, false)

	arg_3_0.drops = arg_3_0:FilterPersonality(arg_3_1)

	arg_3_0.dropUIList:align(#arg_3_0.drops)

	arg_3_0.timer = Timer.New(function()
		existCall(arg_3_2)

		return
	end, var_0_1)

	arg_3_0.timer:Start()

	return
end

function var_0_0.FilterPersonality(arg_5_0, arg_5_1)
	return underscore.select(arg_5_1, function(arg_6_0)
		return arg_6_0.type ~= NewEducateConst.DROP_TYPE.ATTR or arg_6_0.type == NewEducateConst.DROP_TYPE.ATTR and pg.child2_attr[arg_6_0.id].type ~= NewEducateChar.ATTR_TYPE.PERSONALITY
	end)
end

function var_0_0.PlayPolaroid(arg_7_0, arg_7_1, arg_7_2)
	setActive(arg_7_0._go, true)
	setActive(arg_7_0.dropsTF, false)
	setActive(arg_7_0.polaroidTF, true)
	seriesAsync({
		function(arg_8_0)
			LoadImageSpriteAsync("neweducateicon/" .. pg.child2_polaroid[arg_7_1.id].pic, arg_7_0.polaroidTF:Find("content/mask/icon"), true)
			setText(arg_7_0.polaroidTF:Find("content/desc"), pg.child2_polaroid[arg_7_1.id].title)
			onDelayTick(function()
				arg_8_0()

				return
			end, var_0_1)

			return
		end
	}, function()
		existCall(arg_7_2)

		return
	end)

	return
end

function var_0_0.Reset(arg_11_0)
	setActive(arg_11_0._go, false)
	setActive(arg_11_0.polaroidTF, false)
	setActive(arg_11_0.dropsTF, false)

	arg_11_0.drops = {}

	if arg_11_0.timer ~= nil then
		arg_11_0.timer:Stop()

		arg_11_0.timer = nil
	end

	return
end

function var_0_0.Destroy(arg_12_0)
	return
end

return var_0_0
