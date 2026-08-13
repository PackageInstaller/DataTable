class = var_0_10000

local var_0_0 = var_0_10000("IslandUnitVO")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.modelId = arg_1_1.modelId
	arg_1_0.type = arg_1_1.type
	arg_1_0.name = arg_1_1.name
	arg_1_0.index = arg_1_1.index
	defaultValue = var_2

	local var_1_0 = arg_1_1.genType

	IslandConst = var_1_10005
	arg_1_0.genType = var_2(var_1_0, var_1_10005.UNIT_GEN_TYPE_STATIC)

	local var_1_1 = arg_1_0.genType

	IslandConst = var_1_10003
	arg_1_0.isDynamic = var_1_1 == var_1_10003.UNIT_GEN_TYPE_DYNAMIC
	defaultValue = var_2
	arg_1_0.showCondition = var_2(arg_1_1.showCondition, {})
	defaultValue = var_2
	arg_1_0.hideCondition = var_2(arg_1_1.hideCondition, {})
	BuildVector3 = var_2
	arg_1_0.position = var_2(arg_1_1.position)
	BuildVector3 = var_2
	arg_1_0.rotation = var_2(arg_1_1.rotation)
	BuildVector3 = var_2
	arg_1_0.scale = var_2(arg_1_1.scale)
	arg_1_0.behaviourTree = arg_1_1.behaviourTree
	arg_1_0.delayTime = arg_1_1.delayTime

	return
end

function var_0_0.GetType(arg_2_0)
	return arg_2_0.type
end

function var_0_0.IsPlayer(arg_3_0)
	local var_3_0 = arg_3_0.type

	IslandConst = var_1_10002

	return var_3_0 == var_1_10002.UNIT_TYPE_PLAYER
end

function var_0_0.IsFirstTakePhoto(arg_4_0)
	local var_4_0 = arg_4_0.type

	IslandConst = var_1_10002

	return var_4_0 == var_1_10002.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM and arg_4_0.id == 2
end

function var_0_0.IsThirdTakePhoto(arg_5_0)
	local var_5_0 = arg_5_0.type

	IslandConst = var_1_10002

	return var_5_0 == var_1_10002.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM and arg_5_0.id == 3
end

function var_0_0.IsGift(arg_6_0)
	local var_6_0 = arg_6_0.genType

	IslandConst = var_1_10002

	return var_6_0 == var_1_10002.UNIT_GEN_TYPE_GIFT
end

function var_0_0.Interactable(arg_7_0)
	local var_7_0 = arg_7_0.type

	IslandConst = var_1_10002

	return var_7_0 == var_1_10002.UNIT_TYPE_ITEM_INTERACT
end

function var_0_0.IsNpcType(arg_8_0)
	local var_8_0 = arg_8_0.type

	IslandConst = var_1_10002

	local var_8_12

	if var_8_0 ~= var_1_10002.UNIT_TYPE_CHAR then
		local var_8_1 = arg_8_0.type

		IslandConst = var_2

		if var_8_1 ~= var_2.UNIT_TYPE_PLAYER then
			local var_8_2 = arg_8_0.type

			IslandConst = var_2

			if var_8_2 ~= var_2.UNIT_TYPE_VISITOR then
				local var_8_3 = arg_8_0.type

				IslandConst = var_2

				if var_8_3 ~= var_2.UNIT_TYPE_SYSTEM then
					local var_8_4 = arg_8_0.type

					IslandConst = var_2

					if var_8_4 ~= var_2.UNIT_TYPE_STROLL then
						local var_8_5 = arg_8_0.type

						IslandConst = var_2

						if var_8_5 ~= var_2.UNIT_TYPE_MANAGE_CHARA then
							local var_8_6 = arg_8_0.type

							IslandConst = var_2

							if var_8_6 ~= var_2.UNIT_TYPE_MANAGE_CUSTOMER then
								local var_8_7 = arg_8_0.type

								IslandConst = var_2

								if var_8_7 ~= var_2.UNIT_TYPE_SYSTEM_DELEAGTION then
									local var_8_8 = arg_8_0.type

									IslandConst = var_2

									if var_8_8 ~= var_2.UNIT_TYPE_SYSTEM_DELEAGTION_ANIMATION then
										local var_8_9 = arg_8_0.type

										IslandConst = var_2

										if var_8_9 ~= var_2.UNIT_TYPE_FOLLOWER then
											local var_8_10 = arg_8_0.type

											IslandConst = var_2

											if var_8_10 ~= var_2.UNIT_TYPE_DELEGATE_FISH then
												local var_8_11 = arg_8_0.type

												IslandConst = var_2

												if var_8_11 ~= var_2.UNIT_TYPE_CHEATERTAVERN_PLAYER then
													var_8_12 = false

													goto label_8_0
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	var_8_12 = true

	::label_8_0::

	return var_8_12
end

function var_0_0.IsItemType(arg_9_0)
	local var_9_0 = arg_9_0.type

	IslandConst = var_1_10002

	local var_9_12

	if var_9_0 ~= var_1_10002.UNIT_TYPE_ITEM then
		local var_9_1 = arg_9_0.type

		IslandConst = var_2

		if var_9_1 ~= var_2.UNIT_TYPE_ITEM_HANDLE_COLLECT then
			local var_9_2 = arg_9_0.type

			IslandConst = var_2

			if var_9_2 ~= var_2.UNIT_TYPE_ITEM_HANDLE_PLANTING then
				local var_9_3 = arg_9_0.type

				IslandConst = var_2

				if var_9_3 ~= var_2.UNIT_TYPE_ITEM_PRODUCT_ITEM then
					local var_9_4 = arg_9_0.type

					IslandConst = var_2

					if var_9_4 ~= var_2.UNIT_TYPE_ITEM_GATHER_ITEM then
						local var_9_5 = arg_9_0.type

						IslandConst = var_2

						if var_9_5 ~= var_2.UNIT_TYPE_ITEM_WILD_COLLECT_ITEM then
							local var_9_6 = arg_9_0.type

							IslandConst = var_2

							if var_9_6 ~= var_2.UNIT_TYPE_MANAGE_ITEM then
								local var_9_7 = arg_9_0.type

								IslandConst = var_2

								if var_9_7 ~= var_2.UNIT_TYPE_ITEM_DELAY_RECYCLE then
									local var_9_8 = arg_9_0.type

									IslandConst = var_2

									if var_9_8 ~= var_2.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM then
										local var_9_9 = arg_9_0.type

										IslandConst = var_2

										if var_9_9 ~= var_2.UNIT_TYPE_CHEATERTAVERN_TABLE then
											local var_9_10 = arg_9_0.type

											IslandConst = var_2

											if var_9_10 ~= var_2.UNIT_TYPE_CHEATERTAVERN_CHAIR then
												local var_9_11 = arg_9_0.type

												IslandConst = var_2

												if var_9_11 ~= var_2.UNIT_TYPE_FISH_POINT then
													var_9_12 = false

													goto label_9_0
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	var_9_12 = true

	::label_9_0::

	return var_9_12
end

function var_0_0.GetPersonality(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = 0

	if arg_10_0:IsNpcType() then
		pg = var_3

		local var_10_2

		if not var_3.island_unit_character[arg_10_0.modelId].personality then
			var_10_2 = 0
		end

		var_10_1 = var_3.is_active or 0
		var_10_0 = var_10_2
	end

	return var_10_0, var_10_1
end

function var_0_0.GetAssetPath(arg_11_0)
	local var_11_0

	if arg_11_0:IsNpcType() then
		warning = var_2

		var_2(arg_11_0.type)

		assert = var_2
		pg = var_4

		var_2(var_4.island_unit_character[arg_11_0.modelId], arg_11_0.modelId)

		pg = var_2
		var_11_0 = var_2.island_unit_character[arg_11_0.modelId].model
	elseif arg_11_0:IsItemType() then
		pg = var_2
		var_11_0 = var_2.island_unit_item[arg_11_0.modelId].model
	elseif arg_11_0:Interactable() then
		pg = var_2
		var_11_0 = var_2.island_unit_interactive_item[arg_11_0.modelId].model
	end

	assert = var_2

	var_2(var_11_0)

	string = var_2

	return var_2.lower(var_11_0)
end

function var_0_0.GetBehaviourTree(arg_12_0)
	return arg_12_0.behaviourTree
end

function var_0_0.GetAnimator(arg_13_0)
	local var_13_0 = arg_13_0.type

	IslandConst = var_1_10002

	if var_13_0 ~= var_1_10002.UNIT_TYPE_PLAYER then
		var_13_0 = arg_13_0.type
		IslandConst = var_2

		if var_13_0 ~= var_2.UNIT_TYPE_VISITOR then
			var_13_0 = arg_13_0.type
			IslandConst = var_2

			if var_13_0 ~= var_2.UNIT_TYPE_CHAR then
				var_13_0 = arg_13_0.type
				IslandConst = var_2

				if var_13_0 ~= var_2.UNIT_TYPE_STROLL then
					var_13_0 = arg_13_0.type
					IslandConst = var_2

					if var_13_0 ~= var_2.UNIT_TYPE_MANAGE_CHARA then
						var_13_0 = arg_13_0.type
						IslandConst = var_2

						if var_13_0 ~= var_2.UNIT_TYPE_MANAGE_CUSTOMER then
							var_13_0 = arg_13_0.type
							IslandConst = var_2

							if var_13_0 ~= var_2.UNIT_TYPE_SYSTEM_DELEAGTION then
								var_13_0 = arg_13_0.type
								IslandConst = var_2

								if var_13_0 ~= var_2.UNIT_TYPE_SYSTEM_DELEAGTION_ANIMATION then
									var_13_0 = arg_13_0.type
									IslandConst = var_2

									if var_13_0 ~= var_2.UNIT_TYPE_FOLLOWER then
										var_13_0 = arg_13_0.type
										IslandConst = var_2

										if var_13_0 == var_2.UNIT_TYPE_DELEGATE_FISH then
											pg = var_13_0

											return var_13_0.island_unit_character[arg_13_0.modelId].animator
										else
											var_13_0 = arg_13_0.type
											IslandConst = var_2

											if var_13_0 == var_2.UNIT_TYPE_SYSTEM then
												pg = var_13_0

												return var_13_0.island_unit_character[arg_13_0.modelId].animator
											else
												var_13_0 = arg_13_0.type
												IslandConst = var_2

												if var_13_0 == var_2.UNIT_TYPE_CHEATERTAVERN_PLAYER then
													return "island/animator/ani_role_all_cheatertavern_01"
												end
											end
										end

										warning = var_13_0

										var_13_0("目前只有角色需要动态获取动画状态机")

										return
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function var_0_0.GetShowCondition(arg_14_0)
	local var_14_0 = {}

	ipairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(arg_14_0.showCondition) do
		table = var_1_10007

		var_1_10007.insert(var_14_0, iter_14_1)
	end

	return var_14_0
end

function var_0_0.GetHideCondition(arg_15_0)
	local var_15_0 = {}

	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_0.hideCondition) do
		table = var_1_10007

		var_1_10007.insert(var_15_0, iter_15_1)
	end

	return var_15_0
end

return var_0_0
