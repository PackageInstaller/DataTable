local var_0_0 = {
	globalpool = {},
	layerpool = {},
	createSprite = function(self, arg_1_1, arg_1_2)
		self:registerTexture(arg_1_1, arg_1_2)

		return (cc.Sprite:create(arg_1_2))
	end,
	createButton = function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
		arg_2_5 = arg_2_5 or 0

		return ccui.Button:create(arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	end,
	createImageView = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		arg_3_3 = arg_3_3 or 0

		return ccui.ImageView:create(arg_3_2, arg_3_3)
	end,
	setSpriteTexture = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		arg_4_2:setTexture(arg_4_3)
	end,
	loadButtonTextures = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
		arg_5_6 = arg_5_6 or 0

		arg_5_2:loadTextures(arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	end,
	loadImageViewTexture = function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		arg_6_4 = arg_6_4 or 0

		arg_6_2:loadTexture(arg_6_3, arg_6_4)
	end,
	setLayoutBackgroundImage = function(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
		arg_7_4 = arg_7_4 or 0

		arg_7_2:setBackGroundImage(arg_7_3, arg_7_4)
	end,
	registerTexture = function(arg_8_0, arg_8_1, ...)
		return
	end,
	unregisterTexture = function(arg_9_0, arg_9_1)
		return
	end,
	registerGlobalTexture = function(arg_10_0, arg_10_1)
		return
	end,
	unregisterGlobalTexture = function(arg_11_0, arg_11_1)
		return
	end
}
local var_0_1 = {}

function var_0_0.loadLayerTextures(arg_12_0, arg_12_1)
	if config._DEBUG then
		return
	end

	if not arg_12_1 then
		return
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		var_0_1[iter_12_1] = (var_0_1[iter_12_1] or 0) + 1

		if iter_12_1:find(".png") then
			cc.Director:getInstance():getTextureCache():addImage(iter_12_1)
		else
			cc.SpriteFrameCache:getInstance():addSpriteFrames(iter_12_1 .. ".plist")
		end
	end
end

function var_0_0.removeLayerTextures(arg_13_0, arg_13_1)
	if config._DEBUG then
		return
	end

	if not arg_13_1 then
		return
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		var_0_1[iter_13_1] = (var_0_1[iter_13_1] or 0) - 1

		if var_0_1[iter_13_1] <= 0 then
			var_0_1[iter_13_1] = nil

			if iter_13_1:find(".png") then
				cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_13_1)
			else
				cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile(iter_13_1 .. ".plist")
				cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_13_1 .. ".png")
			end
		end
	end
end

local var_0_2 = {}

function var_0_0.loadPopLayerTextures(arg_14_0, arg_14_1)
	if config._DEBUG then
		return
	end

	if not arg_14_1 then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if not var_0_2[iter_14_1] then
			var_0_1[iter_14_1] = (var_0_1[iter_14_1] or 0) + 1

			if iter_14_1:find(".png") then
				cc.Director:getInstance():getTextureCache():addImage(iter_14_1)
			else
				cc.SpriteFrameCache:getInstance():addSpriteFrames(iter_14_1 .. ".plist")
			end

			var_0_2[iter_14_1] = true
		end
	end
end

function var_0_0.unloadPopLayerTextures(arg_15_0)
	if config._DEBUG then
		return
	end

	for iter_15_0, iter_15_1 in pairs(var_0_2) do
		var_0_1[iter_15_0] = (var_0_1[iter_15_0] or 0) - 1

		if var_0_1[iter_15_0] <= 0 then
			if iter_15_0:find(".png") then
				cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_15_0)
			else
				cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile(iter_15_0 .. ".plist")
				cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_15_0 .. ".png")
			end
		end
	end

	var_0_2 = {}
end

function var_0_0.collectTextures(arg_16_0)
	cc.Director:getInstance():getTextureCache():removeAllUnusedBigTextures()
	require("controller.l2d_manager"):releaseAllModel()
	collectgarbage("step", 512)
end

function var_0_0.removeUnusedSpineTextures(arg_17_0)
	SpineCacheManager:collectUnusedSpineCache()
	cc.Director:getInstance():getTextureCache():removeAllUnusedSpineTextures()
end

function var_0_0.removeSpineTexturesWithOutCollect(arg_18_0)
	cc.Director:getInstance():getTextureCache():removeAllUnusedSpineTextures()
end

return var_0_0
