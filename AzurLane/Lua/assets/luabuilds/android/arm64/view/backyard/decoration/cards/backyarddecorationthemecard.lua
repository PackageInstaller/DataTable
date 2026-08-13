class = var_0_10000

local var_0_0 = "BackYardDecorationThemeCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BackYardDecorationCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	findTF = var_2
	arg_1_0.add = var_2(arg_1_0._tf, "bg/Add")
	findTF = var_2

	local var_1_0 = var_2(arg_1_0._tf, "bg/icon_raw")
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	RawImage = var_1_10007
	arg_1_0.rawIcon = var_1_1(var_1_0, var_5(var_1_10007))
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

	typeof = var_5
	Text = var_1_10007
	arg_1_0.posTxt = var_1_4(var_1_3, var_5(var_1_10007))

	return
end

function var_0_1.RemoveSizeTag(arg_2_0, arg_2_1)
	string = var_1_10002

	local var_2_0 = var_1_10002.gsub(arg_2_1, "</size>", "")

	string = var_1_10003

	return var_1_10003.gsub(var_2_0, "<size=%d+>", "")
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
		setActive = var_1_10005

		var_1_10005(arg_3_0.iconImg.gameObject, var_1_10004)

		setActive = var_1_10005

		var_1_10005(arg_3_0.rawIcon.gameObject, false)

		if not var_1_10004 then
			BackYardThemeTempalteUtil = var_1_10005
			var_1_10005 = var_1_10005.FileExists
			var_1_10009 = arg_3_1

			if var_1_10005(arg_3_1.GetTextureIconName(var_1_10009)) or arg_3_1:IsPushed() then
				var_3_1 = arg_3_1:GetIconMd5()
				BackYardThemeTempalteUtil = var_7

				var_7.GetTexture(arg_3_1:GetTextureIconName(), var_3_1, function(arg_4_0)
					IsNil = var_2_10001

					if not var_2_10001(arg_3_0.rawIcon) and arg_4_0 then
						setActive = var_1

						var_1(arg_3_0.rawIcon.gameObject, true)

						arg_3_0.rawIcon.texture = arg_4_0
					end

					return
				end)
			else
				setActive = var_3_1

				var_3_1(arg_3_0.iconImg.gameObject, true)

				LoadSpriteAtlasAsync = var_3_1

				var_3_1("furnitureicon/" .. arg_3_1:getIcon(), "", function(arg_5_0)
					arg_3_0.iconImg.sprite = arg_5_0

					return
				end)
			end

			var_3_1 = arg_3_1.pos

			if arg_3_1.pos <= 9 then
				var_3_1 = "0" .. arg_3_1.pos
			end

			arg_3_0.posTxt.text = var_3_1
		else
			LoadSpriteAsync = var_1_10005

			var_1_10005("furnitureicon/" .. arg_3_1:getIcon(), function(arg_6_0)
				arg_3_0.iconImg.sprite = arg_6_0

				return
			end)
		end

		setActive = var_1_10005

		var_1_10005(arg_3_0.pos, not var_1_10004)

		local var_3_2 = arg_3_0:RemoveSizeTag(arg_3_1:getName())

		setText = var_3_1

		local var_3_3 = arg_3_0.comfortableTF

		shortenString = var_1_10009

		var_3_1(var_3_3, var_1_10009(var_3_2, 4))

		SetActive = var_3_1

		var_3_1(arg_3_0.newTF, false)
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
