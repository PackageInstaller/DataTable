local var_0_0 = class("ServantTrackController")

function var_0_0.Init(arg_1_0, arg_1_1)
	arg_1_0.animation = {
		Fade = "WeaponServant_end_02",
		Back = "WeaponServant_end_01",
		Light = "WeaponServant_star_02",
		Gray = "WeaponServant_star_01"
	}
	arg_1_0.context = {
		isFirstHide = true,
		servantID = -1,
		animFadeTime = 0.1,
		curAnimName = "",
		obj = arg_1_1
	}

	SetActive(arg_1_1, false)

	if not isNil(arg_1_1) then
		arg_1_0.context.animator = arg_1_1:GetComponent("Animator")
		arg_1_0.context.adaptiveSpriteComps = arg_1_1:GetComponent(typeof(AdaptiveServantSprite))

		arg_1_0:InitServantTrans()
	end
end

function var_0_0.InitServantTrans(arg_2_0)
	if isNil(arg_2_0.context.obj) then
		return
	end
end

function var_0_0.SetServantID(arg_3_0, arg_3_1)
	if isNil(arg_3_0.context.adaptiveSpriteComps) then
		return
	end

	local var_3_0 = false
	local var_3_1 = arg_3_0.context.obj.activeInHierarchy

	if arg_3_1 ~= arg_3_0.context.servantID then
		arg_3_0.context.servantID = arg_3_1 or -1

		if arg_3_1 then
			local var_3_2
			local var_3_3
			local var_3_4
			local var_3_5 = WeaponServantCfg[arg_3_1]

			if var_3_5 then
				pcall(function()
					if var_3_5.show_offset_x and var_3_5.show_offset_x ~= "" and tonumber(var_3_5.show_offset_x) then
						var_3_2 = tonumber(var_3_5.show_offset_x)
					end

					if var_3_5.show_offset_y and var_3_5.show_offset_y ~= "" and tonumber(var_3_5.show_offset_y) then
						var_3_3 = tonumber(var_3_5.show_offset_y)
					end

					if var_3_5.show_tiling_scale and var_3_5.show_tiling_scale ~= "" and tonumber(var_3_5.show_tiling_scale) then
						var_3_4 = tonumber(var_3_5.show_tiling_scale)
					end
				end)
			end

			local var_3_6 = false

			if var_3_4 then
				var_3_6 = true
			end

			if arg_3_0.context.oldAtlas ~= nil and arg_3_0.context.oldAtlas ~= "" then
				unloadSpriteWithoutAtlas(arg_3_0.context.oldAtlas)
			end

			arg_3_0.context.oldAtlas = "TextureConfig/WeaponServant/Portrait/" .. arg_3_1

			arg_3_0.context.adaptiveSpriteComps:SetSprite(AtlasManager.GetSpriteWithoutAtlas(arg_3_0.context.oldAtlas), var_3_2 ~= nil, var_3_3 ~= nil, var_3_2 or 0, var_3_3 or 0, var_3_6, var_3_4 or 1)
			SetActive(arg_3_0.context.obj, true)

			var_3_0 = true
		else
			SetActive(arg_3_0.context.obj, false)
		end
	else
		SetActive(arg_3_0.context.obj, arg_3_1 ~= nil)

		var_3_0 = arg_3_1 ~= nil
	end

	if var_3_0 and not var_3_1 then
		arg_3_0:PlayCurrentAnim()
	end
end

function var_0_0.PlayCurrentAnim(arg_5_0)
	local var_5_0 = arg_5_0.context.curAnimName

	if not arg_5_0.animation[var_5_0] then
		return
	end

	if isNil(arg_5_0.context.animator) then
		return
	end

	arg_5_0.context.animator:CrossFade(arg_5_0.animation[var_5_0], arg_5_0.context.animFadeTime)
end

function var_0_0.PlayAnim(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == "Gray" and arg_6_0.context.curAnimName == "Light" then
		arg_6_1 = "Back"
	end

	if arg_6_1 == "Fade" and arg_6_0.context.isFirstHide then
		return
	elseif arg_6_0.context.isFirstHide then
		SetActive(arg_6_0.context.obj, true)

		arg_6_0.context.isFirstHide = false
	end

	if not arg_6_0.animation[arg_6_1] then
		return
	end

	if isNil(arg_6_0.context.animator) then
		return
	end

	if arg_6_0.context.curAnimName ~= arg_6_1 or arg_6_2 or false then
		arg_6_0.context.animator:CrossFade(arg_6_0.animation[arg_6_1], arg_6_0.context.animFadeTime)

		if arg_6_1 == "Back" then
			arg_6_1 = "Gray"
		end

		arg_6_0.context.curAnimName = arg_6_1
	end
end

function var_0_0.CheckValid(arg_7_0)
	if isNil(arg_7_0.context.obj) then
		arg_7_0.context.oldAtlas = nil

		return false
	end

	return true
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.context.oldAtlas = nil
	arg_8_0.context.animator = nil
	arg_8_0.context.adaptiveSpriteComps = nil

	if not isNil(arg_8_0.context.obj) then
		Object.Destroy(arg_8_0.context.obj)

		arg_8_0.context.obj = nil
	end
end

return var_0_0
