class = var_0_10000

local var_0_0 = "IslandDressupNpcUnit"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandNpcUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.SetShipDressHelper(arg_2_0, arg_2_1)
	arg_2_0.shipDressHelper = arg_2_1

	return
end

function var_0_1.OnDetach(arg_3_0)
	if arg_3_0.shipDressHelper then
		local var_3_0 = arg_3_0.shipDressHelper

		var_1.Destroy(var_3_0)
	end

	return
end

function var_0_1.OnCharacterChangeDress(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 then
		var_1_10004 = {}

		local function var_4_0()
			local var_5_0 = arg_4_0
			local var_5_1 = arg_4_0._tf
			local var_5_2 = var_1.GetChild(var_5_1, 0)
			local var_5_3 = var_1.GetComponent

			typeof = var_4
			Animator = var_2_10006
			var_5_0._animator = var_5_3(var_5_2, var_4(var_2_10006))
			ipairs = var_5_0

			for iter_5_0, iter_5_1 in var_5_0(var_1_10004) do
				local var_5_4 = arg_4_0._animator

				var_2_10005.Play(var_5_4, iter_5_1.shortNameHash, iter_5_0 - 1, iter_5_1.normalizedTime)
			end

			local var_5_5 = arg_4_0._tf
			local var_5_6 = var_0.GetComponent

			typeof = iter_5_0
			NodeCanvas = var_2_10005

			local var_5_7 = var_5_6(var_5_5, iter_5_0(var_2_10005.BehaviourTrees.BehaviourTreeOwner))

			var_0.StartBehaviour(var_5_7)

			return
		end

		local var_4_1 = arg_4_0._tf
		local var_4_2 = var_6.GetComponent

		typeof = var_1_10009
		NodeCanvas = var_1_10011
		var_1_10009 = var_4_2(var_4_1, var_1_10009(var_1_10011.BehaviourTrees.BehaviourTreeOwner))

		var_6.PauseBehaviour(var_1_10009)

		local var_4_3 = 0
		local var_4_4 = arg_4_0._animator

		var_1_10009 = var_8.GetCurrentAnimatorStateInfo(var_4_4, var_4_3).normalizedTime % 1
		var_1_10009 = normalizedTime

		for iter_4_0 = 1, arg_4_0._animator.layerCount do
			local var_4_5 = iter_4_0 - 1
			local var_4_6 = arg_4_0._animator
			local var_4_7 = var_14.GetCurrentAnimatorStateInfo(var_4_6, var_4_5)

			table = var_1_10015

			var_1_10015.insert(var_1_10004, {
				shortNameHash = var_4_7.shortNameHash,
				normalizedTime = var_4_7.normalizedTime
			})
		end

		arg_4_0:DestroyInteractiveTools()

		arg_4_0._animator = nil

		if #arg_4_2 == 0 and #arg_4_3 == 0 then
			local var_4_8 = arg_4_0.shipDressHelper

			var_1_10009.ChangeModelTransfromByUnitId(var_4_8, arg_4_1, var_4_0)
		else
			local var_4_9 = arg_4_0.shipDressHelper

			var_1_10009.ChangeModelTransfromByUnitIdAndChangeDress(var_4_9, arg_4_1, arg_4_2, arg_4_3, var_4_0)
		end
	else
		ipairs = var_1_10004

		for iter_4_1, iter_4_2 in var_1_10004(arg_4_2) do
			pg = var_1_10009
			var_1_10009 = var_1_10009.island_dress_template[iter_4_2].type

			local var_4_10 = arg_4_0.shipDressHelper

			var_10.ChangeDressByType(var_4_10, var_1_10009, {
				id = 0,
				colorId = 0
			})
		end

		ipairs = var_4

		for iter_4_3, iter_4_4 in var_4(arg_4_3) do
			pg = var_1_10009
			var_1_10009 = var_1_10009.island_dress_template[iter_4_4].type

			local var_4_11 = arg_4_0.shipDressHelper

			var_10.ChangeDressByType(var_4_11, var_1_10009, {
				colorId = 0,
				id = iter_4_4
			})
		end
	end

	return
end

return var_0_1
