pg = pg or {}
pg.DynamicBgMgr = singletonClass("DynamicBgMgr")

function pg.DynamicBgMgr.Ctor(arg_1_0)
	arg_1_0.cache = {}

	return
end

function pg.DynamicBgMgr.LoadBg(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	local var_2_0 = "bg/star_level_bg_" .. arg_2_2
	local var_2_1 = "ui/star_level_bg_" .. arg_2_2

	arg_2_0:ClearBg((arg_2_1:getUIName()))

	if checkABExist("ui/star_level_bg_" .. arg_2_2) then
		PoolMgr.GetInstance():GetPrefab("ui/star_level_bg_" .. arg_2_2, "", true, function(arg_3_0)
			if arg_2_1.exited then
				PoolMgr.GetInstance():ReturnPrefab(var_2_1, "", arg_3_0, true)

				return
			end

			setActive(arg_2_4, false)
			setParent(arg_3_0, arg_2_3, false)
			setActive(arg_3_0, false)
			setActive(arg_3_0, true)

			local var_3_0 = arg_3_0:GetComponent(typeof(CriManaEffectUI))

			if var_3_0 then
				var_3_0.renderMode = CriWare.CriManaMovieMaterialBase.RenderMode.Always

				var_3_0:Pause(false)
			else
				tf(arg_3_0).anchorMin = Vector2(0, 0)
				tf(arg_3_0).anchorMax = Vector2(1, 1)
				tf(arg_3_0).offsetMin = Vector2(0, 0)
				tf(arg_3_0).offsetMax = Vector2(0, 0)
			end

			arg_2_0.cache[var_0] = {
				path = var_2_1,
				dyBg = arg_3_0
			}

			existCall(arg_2_5, arg_3_0)

			return
		end, 1)
	else
		PoolMgr.GetInstance():GetSprite("bg/star_level_bg_" .. arg_2_2, "", true, function(arg_4_0)
			if arg_2_1.exited then
				PoolMgr.GetInstance():DecreasSprite(var_2_0, "")

				return
			end

			setActive(arg_2_4, true)
			setImageSprite(arg_2_4, arg_4_0)

			arg_2_0.cache[var_0] = {
				path = var_2_0,
				staticBgTf = arg_2_4,
				sp = arg_4_0
			}

			existCall(arg_2_6, arg_4_0)

			return
		end)
	end

	return
end

function pg.DynamicBgMgr.ClearBg(arg_5_0, arg_5_1)
	if not arg_5_0.cache[arg_5_1] then
		return
	end

	local var_5_0 = arg_5_0.cache[arg_5_1]

	if arg_5_0.cache[arg_5_1].dyBg then
		local var_5_1 = var_5_0.dyBg:GetComponent(typeof(CriManaEffectUI))

		if var_5_1 then
			var_5_1:Pause(true)
		end

		PoolMgr.GetInstance():ReturnPrefab(var_5_0.path, "", var_5_0.dyBg, true)
	elseif var_5_0.staticBgTf then
		PoolMgr.GetInstance():DecreasSprite(var_5_0.path, "")
	else
		assert(false)
	end

	arg_5_0.cache[arg_5_1] = nil

	return
end

return
