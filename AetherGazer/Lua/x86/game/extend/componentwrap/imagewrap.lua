local var_0_0 = class("ImageWrap")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:BuildContext()
	arg_1_0:InjectImageWrap(arg_1_1, arg_1_2)
end

function var_0_0.BuildContext(arg_2_0)
	arg_2_0.context = {
		destroyed = false,
		isImmediateUnload = false,
		cacheLimit = -1,
		lastAsyncKey = ""
	}
	arg_2_0.lru = nil
	arg_2_0.recycleHandler = handler(arg_2_0, arg_2_0.OnSpriteRecycle)
end

function var_0_0.RebuildCacheContainer(arg_3_0)
	if not arg_3_0.lru then
		arg_3_0.lru = LRUContainer.New(arg_3_0.context.cacheLimit, arg_3_0.recycleHandler)
	end
end

function var_0_0.GetLru(arg_4_0)
	if not arg_4_0.lru then
		arg_4_0:RebuildCacheContainer()
	end

	return arg_4_0.lru
end

function var_0_0.OnSpriteRecycle(arg_5_0, arg_5_1)
	SpriteManager.GetInstance():UnloadSprite(arg_5_1)
end

function var_0_0.InjectImageWrap(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}

	tolua.setpeer(arg_6_1, var_6_0)

	var_6_0.__index = var_6_0

	local var_6_1 = tolua.initset(var_6_0)
	local var_6_2 = arg_6_0

	function var_6_1.spriteSync(arg_7_0, arg_7_1)
		if not arg_7_1 then
			var_6_2:LoadSprite(nil)

			return
		end

		if type(arg_7_1) == "string" then
			var_6_2:LoadSprite(arg_7_1)
		else
			Debug.LogError("spriteSync只接受图片路径")
		end
	end

	function var_6_1.spriteAsync(arg_8_0, arg_8_1)
		if not arg_8_1 then
			var_6_2:LoadSpriteAsync(nil)

			return
		end

		if type(arg_8_1) == "string" then
			var_6_2:LoadSpriteAsync(arg_8_1)
		else
			Debug.LogError("spriteAsync只接受图片路径")
		end
	end

	function var_6_1.immediate(arg_9_0, arg_9_1)
		if var_6_2.context.curSprite ~= nil or var_6_2.lru ~= nil then
			return
		end

		if arg_9_1 then
			var_6_2.context.isImmediateUnload = true
		else
			var_6_2.context.isImmediateUnload = false
		end
	end

	function var_6_1.cacheLimit(arg_10_0, arg_10_1)
		if var_6_2.context.curSprite ~= nil or var_6_2.lru ~= nil then
			return
		end

		var_6_2.context.cacheLimit = arg_10_1
	end

	function var_6_1.spriteDownload(arg_11_0, arg_11_1)
		if not arg_11_1 then
			var_6_2:LoadSprite(nil)

			return
		end

		if type(arg_11_1) == "string" then
			var_6_2:DownloadSprite(arg_11_1, function()
				if isNil(arg_6_1) then
					return
				end

				var_6_2:LoadSprite(arg_11_1)
			end)
		else
			Debug.LogError("spriteNeedDownload只接受图片路径")
		end
	end

	if arg_6_2.CacheImageWrap then
		arg_6_2:CacheImageWrap(arg_6_0)
	end

	arg_6_0.context.destroyed = false
	arg_6_0.context.imageComps = arg_6_1
	arg_6_0.context.parent = arg_6_2
end

function var_0_0.LoadSprite(arg_13_0, arg_13_1)
	local var_13_0

	if arg_13_0:IsImmediateUnload() then
		var_13_0 = arg_13_0:ImmediateMode(arg_13_1)
	else
		var_13_0 = arg_13_0:CacheMode(arg_13_1)
	end

	arg_13_0.context.imageComps.sprite = var_13_0
end

function var_0_0.LoadSpriteAsync(arg_14_0, arg_14_1)
	if arg_14_1 == nil then
		arg_14_0.context.lastAsyncKey = nil

		return
	end

	if arg_14_0:IsImmediateUnload() then
		if arg_14_0.context.curSprite == arg_14_1 then
			return
		end
	elseif arg_14_0:GetLru():Get(arg_14_1) then
		arg_14_0.context.imageComps.sprite = arg_14_0:CacheMode(arg_14_1)

		return
	end

	if arg_14_1 == arg_14_0.context.lastAsyncKey then
		return
	end

	arg_14_0.context.lastAsyncKey = arg_14_1

	SpriteManager.GetInstance():LoadSpriteAsync(arg_14_1, function(arg_15_0)
		local var_15_0 = arg_14_0.context.imageComps

		if arg_14_1 ~= arg_14_0.context.lastAsyncKey then
			SpriteManager.GetInstance():UnloadSprite(arg_14_1)

			return
		end

		if not isNil(var_15_0) and not arg_14_0.context.destroyed then
			if arg_14_0:IsImmediateUnload() then
				var_15_0.sprite = arg_14_0:ImmediateMode(arg_14_1, arg_15_0)
			else
				var_15_0.sprite = arg_14_0:CacheMode(arg_14_1, arg_15_0)
			end
		else
			SpriteManager.GetInstance():UnloadSprite(arg_14_1)
		end
	end)
end

function var_0_0.ImmediateMode(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.context.curSprite ~= nil then
		if arg_16_0.context.curSprite == arg_16_1 then
			if not isNil(arg_16_2) then
				SpriteManager.GetInstance():UnloadSprite(arg_16_1)
			end

			return SpriteManager.GetInstance():GetSprite(arg_16_1)
		end

		SpriteManager.GetInstance():UnloadSprite(arg_16_0.context.curSprite)
	end

	if arg_16_1 ~= nil and arg_16_1 ~= "" then
		local var_16_0 = arg_16_2 or SpriteManager.GetInstance():LoadSprite(arg_16_1)

		arg_16_0.context.curSprite = arg_16_1

		return var_16_0
	else
		arg_16_0.context.curSprite = nil

		return nil
	end
end

function var_0_0.CacheMode(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2

	if arg_17_1 == nil or arg_17_1 == "" then
		return nil
	end

	if not arg_17_0:GetLru():Use(arg_17_1, arg_17_1) then
		var_17_0 = var_17_0 or SpriteManager.GetInstance():LoadSprite(arg_17_1)
	else
		if not isNil(arg_17_2) then
			SpriteManager.GetInstance():UnloadSprite(arg_17_1)
		end

		var_17_0 = var_17_0 or SpriteManager.GetInstance():GetSprite(arg_17_1)
	end

	return var_17_0
end

function var_0_0.DownloadSprite(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {
		arg_18_1
	}

	if AssetDownloadManager.CheckResourcesNeedDownload(var_18_0) then
		manager.assetPend:StartDownloadAsset(arg_18_1, function()
			arg_18_2()
		end, function()
			return
		end)
	else
		arg_18_2()
	end
end

function var_0_0.IsImmediateUnload(arg_21_0)
	return arg_21_0.context.isImmediateUnload
end

function var_0_0.GetWrapper(arg_22_0)
	return arg_22_0.context.imageComps
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0.context.destroyed = true

	if arg_23_0:IsImmediateUnload() then
		if arg_23_0.context.curSprite ~= nil then
			SpriteManager.GetInstance():UnloadSprite(arg_23_0.context.curSprite)
		end

		arg_23_0.context.imageComps = nil
		arg_23_0.context.parent = nil
	else
		if arg_23_0.lru then
			arg_23_0.lru:Dispose()

			arg_23_0.lru = nil
		end

		arg_23_0.context.imageComps = nil
		arg_23_0.context.parent = nil
	end
end

return var_0_0
