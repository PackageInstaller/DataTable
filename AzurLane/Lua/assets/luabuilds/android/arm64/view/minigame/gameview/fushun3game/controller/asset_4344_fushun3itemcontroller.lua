class = var_0_10000

local var_0_0 = var_0_10000("Fushun3ItemController")
local var_0_1 = 3
local var_0_2 = 100

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._sceneTf = arg_1_1
	arg_1_0._charTf = arg_1_2
	arg_1_0._itemTpls = arg_1_3
	arg_1_0._event = arg_1_4
	GetComponent = var_1_10005
	findTF = var_1_10007

	local var_1_0 = var_1_10007(arg_1_0._charTf, "collider")

	typeof = var_1_10008
	BoxCollider2D = var_10
	arg_1_0._charCollider = var_1_10005(var_1_0, var_1_10008(var_10))
	findTF = var_5
	arg_1_0._itemPos = var_5(arg_1_0._sceneTf, "item")
	arg_1_0.weightTotal = 0
	arg_1_0.weightItems = {}
	arg_1_0.items = {}
	arg_1_0.itemPools = {}

	local var_1_1 = 1

	Fushun3GameConst = var_1_10006

	for iter_1_0 = var_1_1, #var_1_10006.item_instance_data do
		Fushun3GameConst = var_1_2

		local var_1_2 = var_1_2.item_instance_data[iter_1_0]

		arg_1_0.weightTotal = arg_1_0.weightTotal + var_1_2.weight

		local var_1_3 = arg_1_0.weightTotal
		local var_1_4 = var_1_2.id
		local var_1_5 = var_1_2.map
		local var_1_6 = {
			id = var_1_4,
			weight = var_1_3,
			map = var_1_5
		}

		table = var_1_10014

		var_1_10014.insert(arg_1_0.weightItems, var_1_6)
	end

	return
end

function var_0_0.setCallback(arg_2_0, arg_2_1)
	arg_2_0._callback = arg_2_1

	return
end

function var_0_0.start(arg_3_0)
	for iter_3_0 = #arg_3_0.items, 1, -1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.remove(arg_3_0.items, iter_3_0)

		arg_3_0:returnItemToPool(var_1_10005)
	end

	math = var_1

	local var_3_0 = var_1.random

	Fushun3GameConst = var_3

	local var_3_1 = var_3.create_time[1]

	Fushun3GameConst = iter_3_0
	arg_3_0.createTime = var_3_0(var_3_1, iter_3_0.create_time[2])
	Vector2 = var_1
	arg_3_0.createPos = var_1.zero
	arg_3_0.itemTime = var_0_1

	return
end

function var_0_0.step(arg_4_0)
	arg_4_0:removeOutItems()

	local var_4_0 = arg_4_0._charCollider.bounds
	local var_4_1 = {}

	for iter_4_0 = #arg_4_0.items, 1, -1 do
		if arg_4_0.items[iter_4_0].collider then
			local var_4_2 = var_7.data.type

			Fushun3GameConst = var_1_10009

			if var_4_2 ~= var_1_10009.item_type_damage then
				local var_4_3 = var_7.collider.bounds

				Fushun3GameConst = var_1_10009

				if var_1_10009.CheckBoxCollider(var_4_0.min, var_4_3.min, var_4_0.size, var_4_3.size) then
					table = var_1_10009

					local var_4_4

					if var_1_10009.remove(arg_4_0.items, iter_4_0).data.effect then
						var_4_4 = arg_4_0._event

						local var_4_5 = var_10.emit

						Fushun3GameEvent = var_13

						var_4_5(var_4_4, var_13.add_effect_call, {
							effectName = var_1_10009.data.effect,
							targetTf = var_1_10009.tf
						})
					end

					if arg_4_0._callback then
						local var_4_6 = arg_4_0._callback

						Fushun3GameEvent = var_4_4

						var_4_6(var_4_4.catch_item_call, {
							data = var_1_10009.data
						})
					end

					arg_4_0:returnItemToPool(var_1_10009)
				end
			end
		end

		if var_7.data.speed then
			var_1_10009 = var_7.tf.anchoredPosition.x

			local var_4_7 = var_7.data.speed

			Time = var_1_10011
			var_8.x = var_1_10009 + var_4_7 * var_1_10011.deltaTime
			var_1_10009 = var_7.tf
			var_1_10009.anchoredPosition = var_8
		end

		local var_4_8 = var_7.data.type

		Fushun3GameConst = var_1_10009

		if var_4_8 == var_1_10009.item_type_damage then
			table = var_4_8

			var_4_8.insert(var_4_1, var_7)
		end
	end

	for iter_4_1 = #var_4_1, 1, -1 do
		local var_4_9 = var_4_1[iter_4_1]
		local var_4_10 = arg_4_0._event
		local var_4_11 = var_8.emit

		Fushun3GameEvent = var_1_10011

		var_4_11(var_4_10, var_1_10011.check_item_damage, {
			collider = var_4_9.collider,
			callback = function(arg_5_0)
				if arg_5_0 then
					pg = var_2_10001

					local var_5_0 = var_2_10001.CriMgr.GetInstance()
					local var_5_1 = var_1.PlaySoundEffect_V3

					SFX_BOOM = var_2_10004

					var_5_1(var_5_0, var_2_10004)

					local var_5_2 = arg_4_0._event
					local var_5_3 = var_1.emit

					Fushun3GameEvent = var_2_10004

					local var_5_4 = var_2_10004.add_effect_call
					local var_5_5 = {
						effectName = "EF_fr_Hit_LA"
					}

					findTF = var_2_10006
					var_5_5.targetTf = var_2_10006(var_4_9.tf, "effectPos")

					var_5_3(var_5_2, var_5_4, var_5_5)

					local var_5_6 = arg_4_0

					var_1.removeItem(var_5_6, var_4_9)
				end

				return
			end
		})
	end

	return
end

function var_0_0.removeItem(arg_6_0, arg_6_1)
	for iter_6_0 = #arg_6_0.items, 1, -1 do
		if arg_6_1 == arg_6_0.items[iter_6_0] then
			table = var_6

			local var_6_0 = var_6.remove(arg_6_0.items, iter_6_0)

			arg_6_0:returnItemToPool(var_6_0)

			return
		end
	end

	return
end

function var_0_0.createPlatformItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0

	if arg_7_0:getWeightItemsMap() then
		Fushun3GameConst = var_1_10005
		var_7_0 = var_1_10005.item_map[var_4]
	end

	if var_7_0 then
		local var_7_1 = var_7_0.list
		local var_7_2 = arg_7_0._itemPos
		local var_7_3 = var_6.InverseTransformPoint(var_7_2, arg_7_1)
		local var_7_4 = 0
		local var_7_5 = 0

		for iter_7_0 = #var_7_1, 1, -1 do
			local var_7_6 = var_7_1[iter_7_0]

			ipairs = var_1_10014

			for iter_7_1, iter_7_2 in var_1_10014(var_7_6) do
				if iter_7_2 and 0 < iter_7_2 then
					local var_7_7 = arg_7_0

					var_1_10019 = arg_7_0.createItemById

					local var_7_8 = iter_7_2

					Vector2 = var_1_10023

					var_1_10019(var_7_7, var_7_8, var_1_10023(var_7_3.x + var_7_5, var_7_3.y + var_7_4))
				end

				Fushun3GameConst = var_1_10019
				var_7_5 = var_7_5 + var_1_10019.item_h
			end

			var_7_5 = 0
			Fushun3GameConst = var_1_10014
			var_7_4 = var_7_4 + var_1_10014.item_v
		end
	end

	return
end

function var_0_0.createItemById(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0
	local var_8_1 = 1

	Fushun3GameConst = var_1_10005

	for iter_8_0 = var_8_1, #var_1_10005.item_data do
		Fushun3GameConst = var_1_10008

		if var_1_10008.item_data[iter_8_0].id == arg_8_1 then
			Fushun3GameConst = var_1_10008
			var_8_0 = var_1_10008.item_data[iter_8_0].name
		end
	end

	if arg_8_0:getOrCreateItem(var_8_0) then
		setActive = var_5

		var_5(var_4.tf, true)

		local var_8_2 = var_4.tf

		var_8_2.anchoredPosition = arg_8_2
		table = var_8_2

		var_8_2.insert(arg_8_0.items, var_4)
	end

	return
end

function var_0_0.createItem(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0:getOrCreateItem(arg_9_1) then
		local var_9_0 = var_3.tf

		var_9_0.position = arg_9_2
		setActive = var_9_0

		var_9_0(var_3.tf, true)

		table = var_9_0

		var_9_0.insert(arg_9_0.items, var_3)
	end

	return
end

function var_0_0.itemFollow(arg_10_0, arg_10_1)
	for iter_10_0 = 1, #arg_10_0.items do
		local var_10_0 = arg_10_0.items[iter_10_0].data.type

		Fushun3GameConst = var_1_10008

		if var_10_0 ~= var_1_10008.item_type_buff then
			local var_10_1 = var_6.data.type

			Fushun3GameConst = var_1_10008

			if var_10_1 == var_1_10008.item_type_score then
				local var_10_2 = var_6.tf.anchoredPosition

				math = var_1_10008

				if var_1_10008.abs(arg_10_1.x - var_10_2.x) <= 600 then
					math = var_1_10008

					if var_1_10008.abs(arg_10_1.y - var_10_2.y) <= 700 then
						var_1_10008 = false

						local var_10_3

						if not var_6.catchTime then
							var_6.catchTime = 1
						else
							var_10_3 = var_6.catchTime
							Time = var_10
							var_6.catchTime = var_10_3 - var_10.deltaTime

							if var_6.catchTime <= 0 then
								var_6.catchTime = nil
								var_10_3 = var_6.tf
								var_10_3.anchoredPosition = arg_10_1
								var_1_10008 = true
							end
						end

						if not var_1_10008 then
							math = var_10_3

							local var_10_4 = var_10_3.sign(arg_10_1.x - var_10_2.x)

							Time = var_10

							local var_10_5 = 2000 * var_10.deltaTime * var_10_4

							math = var_11

							local var_10_6 = 25 * var_11.sign(arg_10_1.y - var_10_2.y)

							math = var_12

							if var_12.abs(arg_10_1.y - var_10_2.y) < 25 then
								var_10_6 = 0
							end

							var_10_2.x = var_10_2.x + var_10_5
							var_10_2.y = var_10_2.y + var_10_6
							var_6.tf.anchoredPosition = var_10_2
						end
					end
				end
			end
		end
	end

	return
end

function var_0_0.getOrCreateItem(arg_11_0, arg_11_1)
	for iter_11_0 = 1, #arg_11_0.itemPools do
		if arg_11_0.itemPools[iter_11_0].data.name == arg_11_1 then
			table = var_7

			return var_7.remove(arg_11_0.itemPools, iter_11_0)
		end
	end

	local var_11_0 = 1

	Fushun3GameConst = var_3

	for iter_11_1 = var_11_0, #var_3.item_data do
		Clone = var_1_10006
		Fushun3GameConst = var_1_10008

		if var_1_10006(var_1_10008.item_data[iter_11_1]).name == arg_11_1 then
			tf = var_7
			instantiate = var_1_10009
			findTF = var_1_10011

			local var_11_1 = var_7(var_1_10009(var_1_10011(arg_11_0._itemTpls, arg_11_1)))

			Fushun3GameConst = var_1_10008
			var_11_1.localScale = var_1_10008.game_scale_v3
			findTF = var_1_10008
			var_1_10008 = var_1_10008(var_11_1, "collider").gameObject
			LayerMask = var_1_10009
			var_1_10008.layer = var_1_10009.NameToLayer("Collider")
			GetComponent = var_1_10008
			findTF = var_10

			local var_11_2 = var_10(var_11_1, "collider")

			typeof = var_1_10011
			BoxCollider2D = var_13
			var_1_10008 = var_1_10008(var_11_2, var_1_10011(var_13))
			setParent = var_1_10009

			var_1_10009(var_11_1, arg_11_0._itemPos)

			return {
				tf = var_11_1,
				data = var_1_10006,
				collider = var_1_10008
			}
		end
	end

	return
end

function var_0_0.getWeightItemsMap(arg_12_0)
	if arg_12_0.itemTime > 0 then
		math = var_1

		if var_1.random(1, arg_12_0.itemTime) == arg_12_0.itemTime then
			arg_12_0.itemTime = var_0_2

			if not arg_12_0.itemsMap then
				arg_12_0.itemsMap = {}

				for iter_12_0 = 1, #arg_12_0.weightItems do
					local var_12_0 = arg_12_0.weightItems[iter_12_0]

					table = var_1_10007
					var_1_10007 = var_1_10007.contains
					Fushun3GameConst = var_1_10009

					if var_1_10007(var_1_10009.item_map_ids, var_12_0.map) then
						table = var_1_10007

						var_1_10007.insert(arg_12_0.itemsMap, var_12_0.map)
					end
				end
			end

			local var_12_1 = arg_12_0.itemsMap

			math = var_3

			return var_12_1[var_3.random(1, #arg_12_0.itemsMap)]
		else
			arg_12_0.itemTime = arg_12_0.itemTime - 1
		end
	end

	math = var_1

	local var_12_2 = var_1.random(1, arg_12_0.weightTotal)

	for iter_12_1 = 1, #arg_12_0.weightItems do
		if var_12_2 <= arg_12_0.weightItems[iter_12_1].weight then
			return var_6.map
		end
	end

	return nil
end

function var_0_0.removeOutItems(arg_13_0)
	for iter_13_0 = #arg_13_0.items, 1, -1 do
		local var_13_0 = arg_13_0.items[iter_13_0].tf
		local var_13_1 = arg_13_0.items[iter_13_0].data
		local var_13_2 = var_13_0.anchoredPosition.x

		math = var_1_10008

		if var_13_2 < var_1_10008.abs(arg_13_0._sceneTf.anchoredPosition.x) - 1500 then
			table = var_13_2

			local var_13_3 = var_13_2.remove(arg_13_0.items, iter_13_0)

			arg_13_0:returnItemToPool(var_13_3)
		else
			local var_13_4 = var_13_1.type

			Fushun3GameConst = var_1_10008

			if var_13_4 == var_1_10008.item_type_damage then
				local var_13_5 = var_13_0.anchoredPosition.x

				math = var_1_10008

				if var_1_10008.abs(arg_13_0._sceneTf.anchoredPosition.x) + 2000 <= var_13_5 then
					table = var_13_5

					local var_13_6 = var_13_5.remove(arg_13_0.items, iter_13_0)

					arg_13_0:returnItemToPool(var_13_6)

					goto label_13_0
				end
			end

			local var_13_7 = var_13_0.anchoredPosition.x

			math = var_1_10008

			if var_1_10008.abs(arg_13_0._sceneTf.anchoredPosition.x) + 8 <= var_13_7 then
				table = var_13_7

				local var_13_8 = var_13_7.remove(arg_13_0.items, iter_13_0)

				arg_13_0:returnItemToPool(var_13_8)
			end
		end

		::label_13_0::
	end

	return
end

function var_0_0.returnItemToPool(arg_14_0, arg_14_1)
	setActive = var_1_10002

	var_1_10002(arg_14_1.tf, false)

	if arg_14_1.catchTime then
		arg_14_1.catchTime = nil
	end

	table = var_2

	var_2.insert(arg_14_0.itemPools, arg_14_1)

	return
end

return var_0_0
