local var_0_0 = singletonClass("SpriteManager")

function var_0_0.BuildSpritePool(arg_1_0)
	arg_1_0.spritePool = {}
	arg_1_0.asyncTask = {}
end

function var_0_0.Ctor(arg_2_0)
	arg_2_0:BuildSpritePool()
	RegistChangeSceneClearHandler(function()
		arg_2_0:UnloadAllSprite()
	end)
end

function var_0_0.LoadSprite(arg_4_0, arg_4_1)
	if arg_4_1 == nil then
		return nil
	end

	local var_4_0 = arg_4_0.spritePool[arg_4_1]

	if not var_4_0 then
		var_4_0 = {
			counter = 0
		}
		arg_4_0.spritePool[arg_4_1] = var_4_0
	end

	if isNil(var_4_0.sprite) then
		var_4_0.sprite = AssetEx.LoadSprite(arg_4_1)
	end

	var_4_0.counter = var_4_0.counter + 1

	return var_4_0.sprite
end

function var_0_0.UnloadSprite(arg_5_0, arg_5_1)
	if arg_5_1 == nil then
		return
	end

	if (arg_5_0.asyncTask[arg_5_1] or 0) > 0 then
		return
	end

	local var_5_0 = arg_5_0.spritePool[arg_5_1]

	if var_5_0 then
		var_5_0.counter = var_5_0.counter - 1

		if var_5_0.counter <= 0 then
			if not isNil(var_5_0.sprite) then
				AssetEx.UnloadSprite(arg_5_1)

				var_5_0.sprite = nil
				var_5_0.counter = 0
			else
				var_5_0.counter = 0
			end
		end
	end
end

function var_0_0.LoadSpriteAsync(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.spritePool[arg_6_1]

	if not var_6_0 then
		var_6_0 = {
			counter = 0
		}
		arg_6_0.spritePool[arg_6_1] = var_6_0
	end

	if arg_6_0.spritePool[arg_6_1].counter > 0 then
		arg_6_2(arg_6_0:LoadSprite(arg_6_1))

		return
	end

	arg_6_0.asyncTask[arg_6_1] = (arg_6_0.asyncTask[arg_6_1] or 0) + 1

	AssetEx.LoadSpriteAsync(arg_6_1, function(arg_7_0)
		arg_6_0.asyncTask[arg_6_1] = arg_6_0.asyncTask[arg_6_1] - 1
		var_6_0.counter = var_6_0.counter + 1
		var_6_0.sprite = arg_7_0

		arg_6_2(arg_7_0)
	end)
end

function var_0_0.UnloadAllSprite(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.spritePool) do
		if not isNil(iter_8_1.sprite) then
			AssetEx.UnloadSprite(iter_8_0)

			iter_8_1.sprite = nil
		end
	end

	arg_8_0.spritePool = {}
end

function var_0_0.GetSprite(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.spritePool[arg_9_1]

	if not var_9_0 then
		return nil
	end

	return var_9_0.sprite
end

return var_0_0
