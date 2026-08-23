local var_0_0 = {}
local var_0_1 = cc.Director:getInstance()
local var_0_2 = var_0_1:getOpenGLView()

if not var_0_2 then
	local var_0_3 = 960
	local var_0_4 = 640

	if CC_DESIGN_RESOLUTION then
		if CC_DESIGN_RESOLUTION.width then
			var_0_3 = CC_DESIGN_RESOLUTION.width
		end

		if CC_DESIGN_RESOLUTION.height then
			var_0_4 = CC_DESIGN_RESOLUTION.height
		end
	end

	var_0_2 = cc.GLViewImpl:createWithRect("Cocos2d-Lua", cc.rect(0, 0, var_0_3, var_0_4))

	var_0_1:setOpenGLView(var_0_2)
end

local var_0_5 = var_0_1:getTextureCache()
local var_0_6 = cc.SpriteFrameCache:getInstance()
local var_0_7 = cc.AnimationCache:getInstance()

local function var_0_8(arg_1_0)
	arg_1_0.width = checknumber(arg_1_0.width)
	arg_1_0.height = checknumber(arg_1_0.height)
	arg_1_0.autoscale = string.upper(arg_1_0.autoscale)

	assert(arg_1_0.width > 0 and arg_1_0.height > 0, string.format("display - invalid design resolution size %d, %d", arg_1_0.width, arg_1_0.height))
end

local function var_0_9(arg_2_0, arg_2_1)
	if arg_2_0.autoscale == "FILL_ALL" then
		var_0_2:setDesignResolutionSize(arg_2_1.width, arg_2_1.height, cc.ResolutionPolicy.FILL_ALL)
	else
		local var_2_0 = arg_2_1.width / arg_2_0.width

		if arg_2_0.autoscale == "FIXED_WIDTH" then
			var_0_2:setDesignResolutionSize(arg_2_1.width / var_2_0, arg_2_1.height / var_2_0, cc.ResolutionPolicy.NO_BORDER)
		elseif arg_2_0.autoscale == "FIXED_HEIGHT" then
			var_0_2:setDesignResolutionSize(arg_2_1.width / (arg_2_1.height / arg_2_0.height), arg_2_1.height / (arg_2_1.height / arg_2_0.height), cc.ResolutionPolicy.NO_BORDER)
		elseif arg_2_0.autoscale == "EXACT_FIT" then
			var_0_2:setDesignResolutionSize(arg_2_0.width, arg_2_0.height, cc.ResolutionPolicy.EXACT_FIT)
		elseif arg_2_0.autoscale == "NO_BORDER" then
			var_0_2:setDesignResolutionSize(arg_2_0.width, arg_2_0.height, cc.ResolutionPolicy.NO_BORDER)
		elseif arg_2_0.autoscale == "SHOW_ALL" then
			var_0_2:setDesignResolutionSize(arg_2_0.width, arg_2_0.height, cc.ResolutionPolicy.SHOW_ALL)
		else
			printError(string.format("display - invalid r.autoscale \"%s\"", arg_2_0.autoscale))
		end
	end
end

local function var_0_10()
	local var_3_0 = var_0_2:getFrameSize()

	var_0_0.sizeInPixels = {
		width = var_3_0.width,
		height = var_3_0.height
	}

	local var_3_1 = var_0_1:getWinSize()

	var_0_0.contentScaleFactor = var_0_1:getContentScaleFactor()
	var_0_0.size = {
		width = var_3_1.width,
		height = var_3_1.height
	}
	var_0_0.width = var_0_0.size.width
	var_0_0.height = var_0_0.size.height
	var_0_0.cx = var_0_0.width / 2
	var_0_0.cy = var_0_0.height / 2
	var_0_0.c_left = -var_0_0.width / 2
	var_0_0.c_right = var_0_0.width / 2
	var_0_0.c_top = var_0_0.height / 2
	var_0_0.c_bottom = -var_0_0.height / 2
	var_0_0.left = 0
	var_0_0.right = var_0_0.width
	var_0_0.top = var_0_0.height
	var_0_0.bottom = 0
	var_0_0.center = cc.p(var_0_0.cx, var_0_0.cy)
	var_0_0.left_top = cc.p(var_0_0.left, var_0_0.top)
	var_0_0.left_bottom = cc.p(var_0_0.left, var_0_0.bottom)
	var_0_0.left_center = cc.p(var_0_0.left, var_0_0.cy)
	var_0_0.right_top = cc.p(var_0_0.right, var_0_0.top)
	var_0_0.right_bottom = cc.p(var_0_0.right, var_0_0.bottom)
	var_0_0.right_center = cc.p(var_0_0.right, var_0_0.cy)
	var_0_0.top_center = cc.p(var_0_0.cx, var_0_0.top)
	var_0_0.top_bottom = cc.p(var_0_0.cx, var_0_0.bottom)

	printInfo(string.format("# display.sizeInPixels         = {width = %0.2f, height = %0.2f}", var_0_0.sizeInPixels.width, var_0_0.sizeInPixels.height))
	printInfo(string.format("# display.size                 = {width = %0.2f, height = %0.2f}", var_0_0.size.width, var_0_0.size.height))
	printInfo(string.format("# display.contentScaleFactor   = %0.2f", var_0_0.contentScaleFactor))
	printInfo(string.format("# display.width                = %0.2f", var_0_0.width))
	printInfo(string.format("# display.height               = %0.2f", var_0_0.height))
	printInfo(string.format("# display.cx                   = %0.2f", var_0_0.cx))
	printInfo(string.format("# display.cy                   = %0.2f", var_0_0.cy))
	printInfo(string.format("# display.left                 = %0.2f", var_0_0.left))
	printInfo(string.format("# display.right                = %0.2f", var_0_0.right))
	printInfo(string.format("# display.top                  = %0.2f", var_0_0.top))
	printInfo(string.format("# display.bottom               = %0.2f", var_0_0.bottom))
	printInfo(string.format("# display.c_left               = %0.2f", var_0_0.c_left))
	printInfo(string.format("# display.c_right              = %0.2f", var_0_0.c_right))
	printInfo(string.format("# display.c_top                = %0.2f", var_0_0.c_top))
	printInfo(string.format("# display.c_bottom             = %0.2f", var_0_0.c_bottom))
	printInfo(string.format("# display.center               = {x = %0.2f, y = %0.2f}", var_0_0.center.x, var_0_0.center.y))
	printInfo(string.format("# display.left_top             = {x = %0.2f, y = %0.2f}", var_0_0.left_top.x, var_0_0.left_top.y))
	printInfo(string.format("# display.left_bottom          = {x = %0.2f, y = %0.2f}", var_0_0.left_bottom.x, var_0_0.left_bottom.y))
	printInfo(string.format("# display.left_center          = {x = %0.2f, y = %0.2f}", var_0_0.left_center.x, var_0_0.left_center.y))
	printInfo(string.format("# display.right_top            = {x = %0.2f, y = %0.2f}", var_0_0.right_top.x, var_0_0.right_top.y))
	printInfo(string.format("# display.right_bottom         = {x = %0.2f, y = %0.2f}", var_0_0.right_bottom.x, var_0_0.right_bottom.y))
	printInfo(string.format("# display.right_center         = {x = %0.2f, y = %0.2f}", var_0_0.right_center.x, var_0_0.right_center.y))
	printInfo(string.format("# display.top_center           = {x = %0.2f, y = %0.2f}", var_0_0.top_center.x, var_0_0.top_center.y))
	printInfo(string.format("# display.top_bottom           = {x = %0.2f, y = %0.2f}", var_0_0.top_bottom.x, var_0_0.top_bottom.y))
	printInfo("#")
end

function var_0_0:setAutoScale()
	if type(self) ~= "table" then
		return
	end

	var_0_8(self)

	local var_4_0 = var_0_2:getFrameSize()

	if type(self.callback) == "function" then
		for iter_4_0, iter_4_1 in pairs(self.callback(var_4_0) or {}) do
			self[iter_4_0] = iter_4_1
		end

		var_0_8(self)
	end

	var_0_9(self, var_4_0)
	printInfo(string.format("# frame size       = {width = %0.2f, height = %0.2f}", var_4_0.width, var_4_0.height))
	printInfo(string.format("# design resolution size       = {width = %0.2f, height = %0.2f}", self.width, self.height))
	printInfo(string.format("# design resolution autoscale  = %s", self.autoscale))
	var_0_10()
end

if type(CC_DESIGN_RESOLUTION) == "table" then
	var_0_0.setAutoScale(CC_DESIGN_RESOLUTION)
end

var_0_0.COLOR_WHITE = cc.c3b(255, 255, 255)
var_0_0.COLOR_BLACK = cc.c3b(0, 0, 0)
var_0_0.COLOR_RED = cc.c3b(255, 0, 0)
var_0_0.COLOR_GREEN = cc.c3b(0, 255, 0)
var_0_0.COLOR_BLUE = cc.c3b(0, 0, 255)
var_0_0.AUTO_SIZE = 0
var_0_0.FIXED_SIZE = 1
var_0_0.LEFT_TO_RIGHT = 0
var_0_0.RIGHT_TO_LEFT = 1
var_0_0.TOP_TO_BOTTOM = 2
var_0_0.BOTTOM_TO_TOP = 3
var_0_0.CENTER = cc.p(0.5, 0.5)
var_0_0.LEFT_TOP = cc.p(0, 1)
var_0_0.LEFT_BOTTOM = cc.p(0, 0)
var_0_0.LEFT_CENTER = cc.p(0, 0.5)
var_0_0.RIGHT_TOP = cc.p(1, 1)
var_0_0.RIGHT_BOTTOM = cc.p(1, 0)
var_0_0.RIGHT_CENTER = cc.p(1, 0.5)
var_0_0.CENTER_TOP = cc.p(0.5, 1)
var_0_0.CENTER_BOTTOM = cc.p(0.5, 0)
var_0_0.SCENE_TRANSITIONS = {
	CROSSFADE = {
		cc.TransitionCrossFade
	},
	FADE = {
		cc.TransitionFade,
		cc.c3b(0, 0, 0)
	},
	FADEBL = {
		cc.TransitionFadeBL
	},
	FADEDOWN = {
		cc.TransitionFadeDown
	},
	FADETR = {
		cc.TransitionFadeTR
	},
	FADEUP = {
		cc.TransitionFadeUp
	},
	FLIPANGULAR = {
		cc.TransitionFlipAngular,
		cc.TRANSITION_ORIENTATION_LEFT_OVER
	},
	FLIPX = {
		cc.TransitionFlipX,
		cc.TRANSITION_ORIENTATION_LEFT_OVER
	},
	FLIPY = {
		cc.TransitionFlipY,
		cc.TRANSITION_ORIENTATION_UP_OVER
	},
	JUMPZOOM = {
		cc.TransitionJumpZoom
	},
	MOVEINB = {
		cc.TransitionMoveInB
	},
	MOVEINL = {
		cc.TransitionMoveInL
	},
	MOVEINR = {
		cc.TransitionMoveInR
	},
	MOVEINT = {
		cc.TransitionMoveInT
	},
	PAGETURN = {
		cc.TransitionPageTurn,
		false
	},
	ROTOZOOM = {
		cc.TransitionRotoZoom
	},
	SHRINKGROW = {
		cc.TransitionShrinkGrow
	},
	SLIDEINB = {
		cc.TransitionSlideInB
	},
	SLIDEINL = {
		cc.TransitionSlideInL
	},
	SLIDEINR = {
		cc.TransitionSlideInR
	},
	SLIDEINT = {
		cc.TransitionSlideInT
	},
	SPLITCOLS = {
		cc.TransitionSplitCols
	},
	SPLITROWS = {
		cc.TransitionSplitRows
	},
	TURNOFFTILES = {
		cc.TransitionTurnOffTiles
	},
	ZOOMFLIPANGULAR = {
		cc.TransitionZoomFlipAngular
	},
	ZOOMFLIPX = {
		cc.TransitionZoomFlipX,
		cc.TRANSITION_ORIENTATION_LEFT_OVER
	},
	ZOOMFLIPY = {
		cc.TransitionZoomFlipY,
		cc.TRANSITION_ORIENTATION_UP_OVER
	}
}
var_0_0.TEXTURES_PIXEL_FORMAT = {}
var_0_0.DEFAULT_TTF_FONT = "Arial"
var_0_0.DEFAULT_TTF_FONT_SIZE = 32

local var_0_11 = {}
local var_0_12 = cc.rect(0, 0, 0, 0)
local var_0_13 = 0

function var_0_0.newScene(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or var_0_11
	var_0_13 = var_0_13 + 1

	local var_5_0 = not arg_5_1.physics and cc.Scene:create() or cc.Scene:createWithPhysics()

	var_5_0.name_ = string.format("%s:%d", arg_5_0 or "<unknown-scene>", var_0_13)

	if arg_5_1.transition then
		var_5_0 = var_0_0.wrapSceneWithTransition(var_5_0, arg_5_1.transition, arg_5_1.time, arg_5_1.more)
	end

	return var_5_0
end

function var_0_0.wrapScene(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = string.upper(tostring(arg_6_1))

	if var_6_0 == "RANDOM" then
		local var_6_1 = table.keys(var_0_0.SCENE_TRANSITIONS)

		var_6_0 = var_6_1[math.random(1, #var_6_1)]
	end

	if var_0_0.SCENE_TRANSITIONS[var_6_0] then
		arg_6_2 = arg_6_2 or 0.2
		arg_6_3 = arg_6_3 or var_0_0.SCENE_TRANSITIONS[var_6_0][2]
		arg_6_0 = arg_6_3 ~= nil and var_0_0.SCENE_TRANSITIONS[var_6_0][1]:create(arg_6_2, arg_6_0, arg_6_3) or var_0_0.SCENE_TRANSITIONS[var_6_0][1]:create(arg_6_2, arg_6_0)
	else
		error(string.format("display.wrapScene() - invalid transition %s", tostring(arg_6_1)))
	end

	return arg_6_0
end

function var_0_0.runScene(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if var_0_1:getRunningScene() then
		if arg_7_1 then
			arg_7_0 = var_0_0.wrapScene(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		end

		var_0_1:replaceScene(arg_7_0)
	else
		var_0_1:runWithScene(arg_7_0)
	end
end

function var_0_0.getRunningScene()
	return var_0_1:getRunningScene()
end

function var_0_0.newNode()
	return cc.Node:create()
end

function var_0_0.newLayer()
	local var_10_0 = {
		...
	}
	local var_10_1

	if #var_10_0 == 0 then
		var_10_1 = cc.Layer:create()
	elseif #var_10_0 == 1 then
		var_10_1 = cc.LayerColor:create(cc.convertColor(var_10_0[1], "4b"))
	elseif #var_10_0 == 2 then
		local var_10_2 = cc.convertColor(var_10_0[1], "4b")
		local var_10_3 = var_10_0[2]
		local var_10_4 = assert
		local var_10_5 = type(var_10_0[2]) == "table" and (var_10_3.width or var_10_3.r) or false

		var_10_4((false or nil) and true, "display.newLayer() - invalid paramerter 2")

		var_10_1 = var_10_3.r and cc.LayerGradient:create(var_10_2, cc.convertColor(var_10_3, "4b")) or cc.LayerColor:create(var_10_2, var_10_3.width, var_10_3.height)
	elseif #var_10_0 == 3 then
		local var_10_6 = cc.convertColor(var_10_0[1], "4b")

		var_10_1 = type(var_10_0[2]) == "table" and cc.LayerGradient:create(var_10_6, cc.convertColor(var_10_0[2], "4b"), var_10_0[3]) or cc.LayerColor:create(var_10_6, var_10_0[2], var_10_0[3])
	end

	return var_10_1
end

function var_0_0.newSprite(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = cc.Sprite
	local var_11_1 = false

	if type(arg_11_1) == "table" and not arg_11_1.x then
		arg_11_3 = arg_11_1
		arg_11_1 = nil
		arg_11_2 = nil
	end

	local var_11_2 = arg_11_3 or var_0_11

	if (arg_11_3 or var_0_11).scale9 or var_11_2.capInsets then
		var_11_0 = ccui.Scale9Sprite
		var_11_1 = true
		var_11_2.capInsets = var_11_2.capInsets or var_0_12
		var_11_2.rect = var_11_2.rect or var_0_12
	end

	local var_11_3

	repeat
		if not arg_11_0 then
			var_11_3 = var_11_0:create()

			break
		end

		local var_11_4 = type(arg_11_0)

		if var_11_4 == "string" then
			if string.byte(arg_11_0) == 35 then
				if not var_11_1 then
					var_11_3 = var_11_0:createWithSpriteFrameName(string.sub(arg_11_0, 2))

					break
				end

				var_11_3 = var_11_0:createWithSpriteFrameName(string.sub(arg_11_0, 2), var_11_2.capInsets)

				break
			end

			if var_0_0.TEXTURES_PIXEL_FORMAT[arg_11_0] then
				cc.Texture2D:setDefaultAlphaPixelFormat(var_0_0.TEXTURES_PIXEL_FORMAT[arg_11_0])
			end

			var_11_3 = not var_11_1 and var_11_0:create(arg_11_0) or var_11_0:create(arg_11_0, var_11_2.rect, var_11_2.capInsets)

			if var_0_0.TEXTURES_PIXEL_FORMAT[arg_11_0] then
				cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2_D_PIXEL_FORMAT_BGR_A8888)
			end

			do break end
			break
		end

		if var_11_4 ~= "userdata" then
			error(string.format("display.newSprite() - invalid source type \"%s\"", var_11_4), 0)

			break
		end

		local var_11_5 = tolua.type(arg_11_0)

		if var_11_5 == "cc.SpriteFrame" then
			if not var_11_1 then
				var_11_3 = var_11_0:createWithSpriteFrame(arg_11_0)

				break
			end

			var_11_3 = var_11_0:createWithSpriteFrame(arg_11_0, var_11_2.capInsets)

			break
		end

		if var_11_5 == "cc.Texture2D" then
			var_11_3 = var_11_0:createWithTexture(arg_11_0)

			break
		end

		error(string.format("display.newSprite() - invalid source type \"%s\"", var_11_5), 0)
	until true

	if var_11_3 then
		if arg_11_1 and arg_11_2 then
			var_11_3:setPosition(arg_11_1, arg_11_2)
		end

		if var_11_2.size then
			var_11_3:setContentSize(var_11_2.size)
		end
	else
		error(string.format("display.newSprite() - create sprite failure, source \"%s\"", tostring(arg_11_0)), 0)
	end

	return var_11_3
end

function var_0_0.newSpriteFrame(arg_12_0)
	local var_12_0

	if type(arg_12_0) == "string" then
		if string.byte(arg_12_0) == 35 then
			arg_12_0 = string.sub(arg_12_0, 2)
		end

		var_12_0 = var_0_6:getSpriteFrame(arg_12_0)

		if not var_12_0 then
			error(string.format("display.newSpriteFrame() - invalid frame name \"%s\"", tostring(arg_12_0)), 0)
		end
	elseif tolua.type(arg_12_0) == "cc.Texture2D" then
		var_12_0 = cc.SpriteFrame:createWithTexture(arg_12_0, ...)
	else
		error("display.newSpriteFrame() - invalid parameters", 0)
	end

	return var_12_0
end

function var_0_0.newFrames(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {}
	local var_13_1 = 1
	local var_13_2 = arg_13_1 + arg_13_2 - 1

	if arg_13_3 then
		arg_13_1 = var_13_2
		var_13_2 = arg_13_1
		var_13_1 = -1
	end

	for iter_13_0 = arg_13_1, var_13_2, var_13_1 do
		local var_13_3 = string.format(arg_13_0, iter_13_0)
		local var_13_4 = var_0_6:getSpriteFrame(var_13_3)

		if not var_13_4 then
			error(string.format("display.newFrames() - invalid frame name %s", tostring(var_13_3)), 0)
		end

		var_13_0[#var_13_0 + 1] = var_13_4
	end

	return var_13_0
end

local function var_0_14(arg_14_0, arg_14_1)
	assert(#arg_14_0 > 0, "display.newAnimation() - invalid frames")

	arg_14_1 = arg_14_1 or 1 / #arg_14_0

	return cc.Animation:createWithSpriteFrames(arg_14_0, arg_14_1), cc.Sprite:createWithSpriteFrame(arg_14_0[1])
end

function var_0_0.newAnimation()
	local var_15_0 = {
		...
	}

	if #var_15_0 == 2 then
		return var_0_14(var_15_0[1], var_15_0[2])
	elseif #var_15_0 == 4 then
		return var_0_14(var_0_0.newFrames(var_15_0[1], var_15_0[2], var_15_0[3]), var_15_0[4])
	elseif #var_15_0 == 5 then
		return var_0_14(var_0_0.newFrames(var_15_0[1], var_15_0[2], var_15_0[3], var_15_0[4]), var_15_0[5])
	else
		error("display.newAnimation() - invalid parameters")
	end
end

function var_0_0.loadImage(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return var_0_5:addImage(arg_16_0)
	else
		var_0_5:addImageAsync(arg_16_0, arg_16_1)
	end
end

local var_0_15 = cc.FileUtils:getInstance()

function var_0_0.getImage(arg_17_0)
	return var_0_5:getTextureForKey((var_0_15:fullPathForFilename(arg_17_0)))
end

function var_0_0.removeImage(arg_18_0)
	var_0_5:removeTextureForKey(arg_18_0)
end

function var_0_0.loadSpriteFrames(arg_19_0, arg_19_1, arg_19_2)
	if var_0_0.TEXTURES_PIXEL_FORMAT[arg_19_1] then
		cc.Texture2D:setDefaultAlphaPixelFormat(var_0_0.TEXTURES_PIXEL_FORMAT[arg_19_1])
	end

	if not arg_19_2 then
		var_0_6:addSpriteFrames(arg_19_0, arg_19_1)
	else
		var_0_6:addSpriteFramesAsync(arg_19_0, arg_19_1, arg_19_2)
	end

	if var_0_0.TEXTURES_PIXEL_FORMAT[arg_19_1] then
		cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2_D_PIXEL_FORMAT_BGR_A8888)
	end
end

function var_0_0.removeSpriteFrames(arg_20_0, arg_20_1)
	var_0_6:removeSpriteFramesFromFile(arg_20_0)

	if arg_20_1 then
		var_0_0.removeImage(arg_20_1)
	end
end

function var_0_0.removeSpriteFrame(arg_21_0)
	var_0_6:removeSpriteFrameByName(arg_21_0)
end

function var_0_0.setTexturePixelFormat(arg_22_0, arg_22_1)
	var_0_0.TEXTURES_PIXEL_FORMAT[arg_22_0] = arg_22_1
end

function var_0_0.setAnimationCache(arg_23_0, arg_23_1)
	var_0_7:addAnimation(arg_23_1, arg_23_0)
end

function var_0_0.getAnimationCache(arg_24_0)
	return var_0_7:getAnimation(arg_24_0)
end

function var_0_0.removeAnimationCache(arg_25_0)
	var_0_7:removeAnimation(arg_25_0)
end

function var_0_0.removeUnusedSpriteFrames()
	var_0_6:removeUnusedSpriteFrames()
	var_0_5:removeUnusedTextures()
end

return var_0_0
