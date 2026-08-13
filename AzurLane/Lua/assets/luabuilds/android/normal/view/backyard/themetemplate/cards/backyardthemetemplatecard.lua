class = var_0_10000

local var_0_0 = "BackYardThemeTemplateCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...Shop.cards.BackYardThemeCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.content = var_2.Find(var_1_0, "content")

	local var_1_1 = arg_1_0.content

	arg_1_0.mask = var_2.Find(var_1_1, "mask")

	local var_1_2 = arg_1_0.content
	local var_1_3 = var_2.Find(var_1_2, "icon_mask/icon_raw")
	local var_1_4 = var_2.GetComponent

	typeof = var_4
	RawImage = var_1_10005
	arg_1_0.iconRaw = var_1_4(var_1_3, var_4(var_1_10005))

	local var_1_5 = arg_1_0.content
	local var_1_6 = var_2.Find(var_1_5, "Text")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_7(var_1_6, var_4(var_1_10005))

	local var_1_8 = arg_1_0.content

	arg_1_0.pos = var_2.Find(var_1_8, "pos")

	local var_1_9 = arg_1_0.pos
	local var_1_10 = var_2.Find(var_1_9, "Text")
	local var_1_11 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.posTxt = var_1_11(var_1_10, var_4(var_1_10005))

	return
end

function var_0_1.FlushData(arg_2_0, arg_2_1)
	arg_2_0.template = arg_2_1
	arg_2_0.themeVO = arg_2_1
	arg_2_0.nameTxt.text = arg_2_1:GetName()

	return
end

function var_0_1.Update(arg_3_0, arg_3_1)
	if arg_3_0.template and arg_3_1.id == arg_3_0.template.id then
		arg_3_0:FlushData(arg_3_1)

		return
	else
		arg_3_0:FlushData(arg_3_1)

		setActive = var_2

		var_2(arg_3_0.iconRaw.gameObject, false)

		local var_3_0 = arg_3_1
		local var_3_1 = arg_3_1.GetIconMd5(var_3_0)

		BackYardThemeTempalteUtil = var_3_0

		var_3_0.GetTexture(arg_3_1:GetTextureIconName(), var_3_1, function(arg_4_0)
			IsNil = var_2_10001

			if not var_2_10001(arg_3_0.iconRaw) and arg_4_0 then
				setActive = var_1

				var_1(arg_3_0.iconRaw.gameObject, true)

				arg_3_0.iconRaw.texture = arg_4_0
			end

			return
		end)

		local var_3_2 = arg_3_1
		local var_3_3 = arg_3_1.IsSelfUsage(var_3_2)

		setActive = var_3_2

		local var_3_4 = arg_3_0.mask
		local var_3_5

		if arg_3_1:IsPushed() then
			var_3_5 = var_3_3
		end

		var_3_2(var_3_4, var_3_5)

		setActive = var_3_2

		var_3_2(arg_3_0.pos, var_3_3)

		if var_3_3 then
			local var_3_6 = arg_3_1.pos

			if arg_3_1.pos <= 9 then
				var_3_6 = "0" .. arg_3_1.pos
			end

			arg_3_0.posTxt.text = var_3_6
		end
	end

	return
end

function var_0_1.Dispose(arg_5_0)
	var_0_1.super.Dispose(arg_5_0)

	IsNil = var_1

	if not var_1(arg_5_0.iconRaw.texture) then
		Object = var_1

		var_1.Destroy(arg_5_0.iconRaw.texture)

		arg_5_0.iconRaw.texture = nil
	end

	return
end

return var_0_1
