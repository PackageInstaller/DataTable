class = var_0_10000

local var_0_0 = "BackYardDecorationThemeCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BackYardDecorationCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	findTF = var_2
	arg_1_0.add = var_2(arg_1_0._tf, "bg/Add")
	findTF = var_2

	local var_1_0 = var_2(arg_1_0._tf, "bg/icon_raw")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	RawImage = var_1_10005
	arg_1_0.rawIcon = var_1_1(var_1_0, var_4(var_1_10005))
	setActive = var_2

	var_2(arg_1_0.rawIcon.gameObject, false)

	setActive = var_2

	var_2(arg_1_0.newTF, false)

	findTF = var_2
	arg_1_0.iconTr = var_2(arg_1_0._tf, "bg/icon")
	findTF = var_2
	arg_1_0.pos = var_2(arg_1_0._tf, "bg/pos")

	local var_1_2 = arg_1_0.pos
	local var_1_3 = var_2.Find(var_1_2, "new")
	local var_1_4 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.posTxt = var_1_4(var_1_3, var_4(var_1_10005))

	return
end

function var_0_1.RemoveSizeTag(arg_2_0, arg_2_1)
	string = var_1_10002

	local var_2_0 = var_1_10002.gsub(arg_2_1, "</size>", "")

	string = var_3

	return var_3.gsub(var_2_0, "<size=%d+>", "")
end

function var_0_1.Update(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.themeVO = arg_3_1

	local var_3_0 = arg_3_1.id == ""

	SetActive = var_1_10004

	var_1_10004(arg_3_0.add, var_3_0)

	setActive = var_1_10004

	var_1_10004(arg_3_0.iconTr, not var_3_0)

	if not var_3_0 then
		local var_3_1 = arg_3_1

		var_1_10004 = arg_3_1.IsSystem(var_3_1)
		setActive = var_3_1

		var_3_1(arg_3_0.iconImg.gameObject, var_1_10004)

		setActive = var_3_1

		var_3_1(arg_3_0.rawIcon.gameObject, false)

		if not var_1_10004 then
			BackYardThemeTempalteUtil = var_3_1

			local var_3_3

			if var_3_1.FileExists(arg_3_1:GetTextureIconName()) or arg_3_1:IsPushed() then
				local var_3_2 = arg_3_1

				var_3_3 = arg_3_1.GetIconMd5(var_3_2)
				BackYardThemeTempalteUtil = var_3_2

				var_3_2.GetTexture(arg_3_1:GetTextureIconName(), var_3_3, function(arg_4_0)
					IsNil = var_2_10001

					if not var_2_10001(arg_3_0.rawIcon) and arg_4_0 then
						setActive = var_1

						var_1(arg_3_0.rawIcon.gameObject, true)

						arg_3_0.rawIcon.texture = arg_4_0
					end

					return
				end)
			else
				setActive = var_3_3

				var_3_3(arg_3_0.iconImg.gameObject, true)

				LoadSpriteAtlasAsync = var_3_3

				var_3_3("furnitureicon/" .. arg_3_1:getIcon(), "", function(arg_5_0)
					arg_3_0.iconImg.sprite = arg_5_0

					return
				end)
			end

			local var_3_4 = arg_3_1.pos

			if arg_3_1.pos <= 9 then
				var_3_4 = "0" .. arg_3_1.pos
			end

			arg_3_0.posTxt.text = var_3_4
		else
			LoadSpriteAsync = var_3_1

			var_3_1("furnitureicon/" .. arg_3_1:getIcon(), function(arg_6_0)
				arg_3_0.iconImg.sprite = arg_6_0

				return
			end)
		end

		setActive = var_3_1

		var_3_1(arg_3_0.pos, not var_1_10004)

		local var_3_5 = arg_3_0
		local var_3_6 = arg_3_0.RemoveSizeTag
		local var_3_7 = arg_3_1
		local var_3_8 = var_3_6(var_3_5, arg_3_1.getName(var_3_7))

		setText = var_3_5

		local var_3_9 = arg_3_0.comfortableTF

		shortenString = var_3_7

		var_3_5(var_3_9, var_3_7(var_3_8, 4))

		SetActive = var_3_5

		var_3_5(arg_3_0.newTF, false)
		arg_3_0:UpdateState(arg_3_2)
	else
		setActive = var_1_10004

		var_1_10004(arg_3_0.pos, false)

		setText = var_1_10004

		var_1_10004(arg_3_0.comfortableTF, "")
	end

	return
end

function var_0_1.UpdateState(arg_7_0, arg_7_1)
	if arg_7_0.themeVO.id ~= "" then
		SetActive = var_2

		var_2(arg_7_0.maskTF, arg_7_1)

		arg_7_0.showMask = arg_7_1
	end

	return
end

function var_0_1.Dispose(arg_8_0)
	var_0_1.super.Dispose(arg_8_0)

	IsNil = var_1

	if not var_1(arg_8_0.rawIcon.texture) then
		Object = var_1

		var_1.Destroy(arg_8_0.rawIcon.texture)

		arg_8_0.rawIcon.texture = nil
	end

	return
end

return var_0_1
