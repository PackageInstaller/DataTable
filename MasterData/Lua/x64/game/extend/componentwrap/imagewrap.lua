local ImageWrap = class("ImageWrap")

function ImageWrap:Ctor(arg_1_1, arg_1_2)
	self:BuildContext()
	self:InjectImageWrap(arg_1_1, arg_1_2)
end

function ImageWrap:BuildContext()
	self.context = {
		destroyed = false,
		isImmediateUnload = false,
		cacheLimit = -1,
		lastAsyncKey = ""
	}
	self.lru = nil
	self.recycleHandler = handler(self, self.OnSpriteRecycle)
end

function ImageWrap:RebuildCacheContainer()
	self.lru = self.lru or LRUContainer.New(self.context.cacheLimit, self.recycleHandler)
end

function ImageWrap:GetLru()
	if not self.lru then
		self:RebuildCacheContainer()
	end

	return self.lru
end

function ImageWrap:OnSpriteRecycle(arg_5_1)
	SpriteManager.GetInstance():UnloadSprite(arg_5_1)
end

function ImageWrap:InjectImageWrap(arg_6_1, arg_6_2)
	local var_6_0 = {}

	tolua.setpeer(arg_6_1, var_6_0)

	var_6_0.__index = var_6_0

	local var_6_1 = tolua.initset(var_6_0)
	local var_6_2 = self

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

		var_6_2.context.isImmediateUnload = not not arg_9_1
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
		arg_6_2:CacheImageWrap(self)
	end

	self.context.destroyed = false
	self.context.imageComps = arg_6_1
	self.context.parent = arg_6_2
end

function ImageWrap:LoadSprite(arg_13_1)
	self.context.imageComps.sprite = self:IsImmediateUnload() and self:ImmediateMode(arg_13_1) or self:CacheMode(arg_13_1)
end

function ImageWrap:LoadSpriteAsync(arg_14_1)
	if arg_14_1 == nil then
		self.context.lastAsyncKey = nil

		return
	end

	if self:IsImmediateUnload() then
		if self.context.curSprite == arg_14_1 then
			return
		end
	elseif self:GetLru():Get(arg_14_1) then
		self.context.imageComps.sprite = self:CacheMode(arg_14_1)

		return
	end

	if arg_14_1 == self.context.lastAsyncKey then
		return
	end

	self.context.lastAsyncKey = arg_14_1

	SpriteManager.GetInstance():LoadSpriteAsync(arg_14_1, function(arg_15_0)
		if arg_14_1 ~= self.context.lastAsyncKey then
			SpriteManager.GetInstance():UnloadSprite(arg_14_1)

			return
		end

		if not isNil(self.context.imageComps) and not self.context.destroyed then
			self.context.imageComps.sprite = self:IsImmediateUnload() and self:ImmediateMode(arg_14_1, arg_15_0) or self:CacheMode(arg_14_1, arg_15_0)
		else
			SpriteManager.GetInstance():UnloadSprite(arg_14_1)
		end
	end)
end

function ImageWrap:ImmediateMode(arg_16_1, arg_16_2)
	if self.context.curSprite ~= nil then
		if self.context.curSprite == arg_16_1 then
			if not isNil(arg_16_2) then
				SpriteManager.GetInstance():UnloadSprite(arg_16_1)
			end

			return SpriteManager.GetInstance():GetSprite(arg_16_1)
		end

		SpriteManager.GetInstance():UnloadSprite(self.context.curSprite)
	end

	if arg_16_1 ~= nil and arg_16_1 ~= "" then
		self.context.curSprite = arg_16_1

		return arg_16_2 or SpriteManager.GetInstance():LoadSprite(arg_16_1)
	else
		self.context.curSprite = nil

		return nil
	end
end

function ImageWrap:CacheMode(arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2

	if arg_17_1 == nil or arg_17_1 == "" then
		return nil
	end

	if not self:GetLru():Use(arg_17_1, arg_17_1) then
		var_17_0 = var_17_0 or SpriteManager.GetInstance():LoadSprite(arg_17_1)
	else
		if not isNil(arg_17_2) then
			SpriteManager.GetInstance():UnloadSprite(arg_17_1)
		end

		var_17_0 = var_17_0 or SpriteManager.GetInstance():GetSprite(arg_17_1)
	end

	return var_17_0
end

function ImageWrap:DownloadSprite(arg_18_1, arg_18_2)
	if AssetDownloadManager.CheckResourcesNeedDownload({
		arg_18_1
	}) then
		manager.assetPend:StartDownloadAsset(arg_18_1, function()
			arg_18_2()
		end, function()
			return
		end)
	else
		arg_18_2()
	end
end

function ImageWrap:IsImmediateUnload()
	return self.context.isImmediateUnload
end

function ImageWrap:GetWrapper()
	return self.context.imageComps
end

function ImageWrap:Dispose()
	self.context.destroyed = true

	if self:IsImmediateUnload() then
		if self.context.curSprite ~= nil then
			SpriteManager.GetInstance():UnloadSprite(self.context.curSprite)
		end

		self.context.imageComps = nil
		self.context.parent = nil
	else
		if self.lru then
			self.lru:Dispose()

			self.lru = nil
		end

		self.context.imageComps = nil
		self.context.parent = nil
	end
end

return ImageWrap
