pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.DynamicBgMgr = var_0_10001("DynamicBgMgr")
pg = var_0

local var_0_1 = var_0.DynamicBgMgr

function var_0_1.Ctor(arg_1_0)
	arg_1_0.cache = {}

	return
end

function var_0_1.LoadBg(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	local var_2_0 = "bg/star_level_bg_" .. arg_2_2
	local var_2_1 = "ui/star_level_bg_" .. arg_2_2
	local var_2_2 = arg_2_1:getUIName()

	arg_2_0:ClearBg(var_2_2)

	checkABExist = var_10

	if var_10(var_2_1) then
		PoolMgr = var_10

		local var_2_3 = var_10.GetInstance()

		var_10.GetPrefab(var_2_3, var_2_1, "", true, function(arg_3_0)
			if arg_2_1.exited then
				PoolMgr = var_1

				local var_3_0 = var_1.GetInstance()

				var_1.ReturnPrefab(var_3_0, var_2_1, "", arg_3_0, true)

				return
			end

			setActive = var_1

			var_1(arg_2_4, false)

			setParent = var_1

			var_1(arg_3_0, arg_2_3, false)

			setActive = var_1

			var_1(arg_3_0, false)

			setActive = var_1

			var_1(arg_3_0, true)

			local var_3_1 = arg_3_0
			local var_3_2 = arg_3_0.GetComponent

			typeof = var_4
			CriManaEffectUI = var_2_10006

			if var_3_2(var_3_1, var_4(var_2_10006)) then
				CriWare = var_2_10002
				var_1.renderMode = var_2_10002.CriManaMovieMaterialBase.RenderMode.Always

				var_1:Pause(false)
			else
				tf = var_2_10002

				local var_3_3 = var_2_10002(arg_3_0)

				Vector2 = var_3_1
				var_3_3.anchorMin = var_3_1(0, 0)
				tf = var_3_3

				local var_3_4 = var_3_3(arg_3_0)

				Vector2 = var_3
				var_3_4.anchorMax = var_3(1, 1)
				tf = var_3_4

				local var_3_5 = var_3_4(arg_3_0)

				Vector2 = var_3
				var_3_5.offsetMin = var_3(0, 0)
				tf = var_3_5

				local var_3_6 = var_3_5(arg_3_0)

				Vector2 = var_3
				var_3_6.offsetMax = var_3(0, 0)
			end

			local var_3_7 = arg_2_0.cache

			var_3_7[var_2_2] = {
				path = var_2_1,
				dyBg = arg_3_0
			}
			existCall = var_3_7

			var_3_7(arg_2_5, arg_3_0)

			return
		end, 1)
	else
		PoolMgr = var_10

		local var_2_4 = var_10.GetInstance()

		var_10.GetSprite(var_2_4, var_2_0, "", true, function(arg_4_0)
			if arg_2_1.exited then
				PoolMgr = var_1

				local var_4_0 = var_1.GetInstance()

				var_1.DecreasSprite(var_4_0, var_2_0, "")

				return
			end

			setActive = var_1

			var_1(arg_2_4, true)

			setImageSprite = var_1

			var_1(arg_2_4, arg_4_0)

			local var_4_1 = arg_2_0.cache

			var_4_1[var_2_2] = {
				path = var_2_0,
				staticBgTf = arg_2_4,
				sp = arg_4_0
			}
			existCall = var_4_1

			var_4_1(arg_2_6, arg_4_0)

			return
		end)
	end

	return
end

function var_0_1.ClearBg(arg_5_0, arg_5_1)
	if not arg_5_0.cache[arg_5_1] then
		return
	end

	if arg_5_0.cache[arg_5_1].dyBg then
		local var_5_0 = var_2.dyBg
		local var_5_1 = var_3.GetComponent

		typeof = var_1_10006
		CriManaEffectUI = var_1_10008

		if var_5_1(var_5_0, var_1_10006(var_1_10008)) then
			var_3:Pause(true)
		end

		PoolMgr = var_1_10004

		local var_5_2 = var_1_10004.GetInstance()

		var_4.ReturnPrefab(var_5_2, var_2.path, "", var_2.dyBg, true)
	elseif var_2.staticBgTf then
		PoolMgr = var_3

		local var_5_3 = var_3.GetInstance()

		var_3.DecreasSprite(var_5_3, var_2.path, "")
	else
		assert = var_3

		var_3(false)
	end

	arg_5_0.cache[arg_5_1] = nil

	return
end

return
