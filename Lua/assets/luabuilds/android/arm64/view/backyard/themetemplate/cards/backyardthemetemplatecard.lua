local var_0_0 = class("BackYardThemeTemplateCard", import("...Shop.cards.BackYardThemeCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.content = arg_1_0._tf:Find("content")
	arg_1_0.mask = arg_1_0.content:Find("mask")
	arg_1_0.iconRaw = arg_1_0.content:Find("icon_mask/icon_raw"):GetComponent(typeof(RawImage))
	arg_1_0.nameTxt = arg_1_0.content:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.pos = arg_1_0.content:Find("pos")
	arg_1_0.posTxt = arg_1_0.pos:Find("Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.FlushData(arg_2_0, arg_2_1)
	arg_2_0.template = arg_2_1
	arg_2_0.themeVO = arg_2_1
	arg_2_0.nameTxt.text = arg_2_1:GetName()

	return
end

function var_0_0.Update(arg_3_0, arg_3_1)
	if arg_3_0.template and arg_3_1.id == arg_3_0.template.id then
		arg_3_0:FlushData(arg_3_1)

		return
	else
		arg_3_0:FlushData(arg_3_1)
		setActive(arg_3_0.iconRaw.gameObject, false)
		BackYardThemeTempalteUtil.GetTexture(arg_3_1:GetTextureIconName(), arg_3_1:GetIconMd5(), function(arg_4_0)
			if not IsNil(arg_3_0.iconRaw) and arg_4_0 then
				setActive(arg_3_0.iconRaw.gameObject, true)

				arg_3_0.iconRaw.texture = arg_4_0
			end

			return
		end)

		local var_3_0 = arg_3_1:IsSelfUsage()
		local var_3_1 = arg_3_1:IsPushed() and var_3_0

		setActive(arg_3_0.mask, var_3_1)
		setActive(arg_3_0.pos, var_3_0)

		if var_3_0 then
			local var_3_2 = arg_3_1.pos

			if arg_3_1.pos <= 9 then
				var_3_2 = "0" .. arg_3_1.pos
			end

			arg_3_0.posTxt.text = var_3_2
		end
	end

	return
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)

	if not IsNil(arg_5_0.iconRaw.texture) then
		Object.Destroy(arg_5_0.iconRaw.texture)

		arg_5_0.iconRaw.texture = nil
	end

	return
end

return var_0_0
