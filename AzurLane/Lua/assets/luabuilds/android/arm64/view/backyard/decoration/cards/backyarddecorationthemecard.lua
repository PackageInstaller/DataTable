local var_0_0 = class("BackYardDecorationThemeCard", import(".BackYardDecorationCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.add = findTF(arg_1_0._tf, "bg/Add")
	arg_1_0.rawIcon = findTF(arg_1_0._tf, "bg/icon_raw"):GetComponent(typeof(RawImage))

	setActive(arg_1_0.rawIcon.gameObject, false)
	setActive(arg_1_0.newTF, false)

	arg_1_0.iconTr = findTF(arg_1_0._tf, "bg/icon")
	arg_1_0.pos = findTF(arg_1_0._tf, "bg/pos")
	arg_1_0.posTxt = arg_1_0.pos:Find("new"):GetComponent(typeof(Text))

	return
end

function var_0_0.RemoveSizeTag(arg_2_0, arg_2_1)
	return string.gsub(string.gsub(arg_2_1, "</size>", ""), "<size=%d+>", "")
end

function var_0_0.Update(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.themeVO = arg_3_1

	local var_3_0 = arg_3_1.id == ""

	SetActive(arg_3_0.add, arg_3_1.id == "")
	setActive(arg_3_0.iconTr, not var_3_0)

	if not var_3_0 then
		local var_3_1 = arg_3_1:IsSystem()

		setActive(arg_3_0.iconImg.gameObject, var_3_1)
		setActive(arg_3_0.rawIcon.gameObject, false)

		if not var_3_1 then
			if not BackYardThemeTempalteUtil.FileExists(arg_3_1:GetTextureIconName()) then
				if arg_3_1:IsPushed() then
					BackYardThemeTempalteUtil.GetTexture(arg_3_1:GetTextureIconName(), arg_3_1:GetIconMd5(), function(arg_4_0)
						if not IsNil(arg_3_0.rawIcon) and arg_4_0 then
							setActive(arg_3_0.rawIcon.gameObject, true)

							arg_3_0.rawIcon.texture = arg_4_0
						end

						return
					end)
				else
					setActive(arg_3_0.iconImg.gameObject, true)
					LoadSpriteAtlasAsync("furnitureicon/" .. arg_3_1:getIcon(), "", function(arg_5_0)
						arg_3_0.iconImg.sprite = arg_5_0

						return
					end)
				end

				local var_3_2 = arg_3_1.pos

				if arg_3_1.pos <= 9 then
					var_3_2 = "0" .. arg_3_1.pos
				end

				arg_3_0.posTxt.text = var_3_2

				if false then
					LoadSpriteAsync("furnitureicon/" .. arg_3_1:getIcon(), function(arg_6_0)
						arg_3_0.iconImg.sprite = arg_6_0

						return
					end)
				end

				setActive(arg_3_0.pos, not var_3_1)
				setText(arg_3_0.comfortableTF, shortenString(arg_3_0:RemoveSizeTag(arg_3_1:getName()), 4))
				SetActive(arg_3_0.newTF, false)
				arg_3_0:UpdateState(arg_3_2)

				goto label_3_0

				setActive(arg_3_0.pos, false)
				setText(arg_3_0.comfortableTF, "")

				::label_3_0::

				return
			end
		end
	end
end

function var_0_0.UpdateState(arg_7_0, arg_7_1)
	if arg_7_0.themeVO.id ~= "" then
		SetActive(arg_7_0.maskTF, arg_7_1)

		arg_7_0.showMask = arg_7_1
	end

	return
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	if not IsNil(arg_8_0.rawIcon.texture) then
		Object.Destroy(arg_8_0.rawIcon.texture)

		arg_8_0.rawIcon.texture = nil
	end

	return
end

return var_0_0
