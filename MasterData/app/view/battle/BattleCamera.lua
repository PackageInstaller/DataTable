local BattleCamera = class("BattleCamera", function()
	return cc.Node:create()
end)
local BattleConst = require("app.view.battle.const.BattleConst")
local BattleUtils = require("app.view.battle.BattleUtils")
local Entry = require("app.view.battle.entry.Entry")
local Action = require("app.core.common.action.Action")
local ResourceLoader = require("app.core.resource.ResourceLoader")
local CriSprite = require("app.view.common.CriSprite")
local SpineBase = require("app.view.common.SpineBase")
local var_0_8 = g.core.config.battle_field_scene_info
local var_0_9 = g.core.config.battle_stage_info

BattleCamera.SHADOW_Z = 50

function BattleCamera:ctor(arg_2_1)
	self._battleLayer = arg_2_1.battleLayer
	self._size = cc.size(arg_2_1.w, arg_2_1.h)
	self._defaultZ = 0
	self._type = arg_2_1.type
	self._params = arg_2_1
	self._ownUINode = self._battleLayer:getOwnUINode()

	self:enableNodeEvents()
	self:setCascadeOpacityEnabled(true)
	self:setCascadeColorEnabled(true)

	self._base = {}
	self._sceneBgMovieList = {}
	self._nodeRoot = cc.Node:create()

	self._nodeRoot:setPosition(0, 0)
	self._nodeRoot:setScale(1)
	self._nodeRoot:setCascadeOpacityEnabled(true)
	self._nodeRoot:setCascadeColorEnabled(true)
	self:addChild(self._nodeRoot)

	self._nodeBgMask = self:_createNode()

	self:addToRoot(self._nodeBgMask)

	self._nodeBackBg = self:_createNode()

	self:addToRoot(self._nodeBackBg, nil, cc.p(0, 0))

	self._nodeScreenDown = self:_createNode()

	self:addToRoot(self._nodeScreenDown)

	self._nodeBase = self:_createNode()

	self:addToRoot(self._nodeBase)

	self._nodeHeroDown = self:_createNode()

	self:addToRoot(self._nodeHeroDown)

	self._nodeHeroRotate = self:_createNode()

	self:addToRoot(self._nodeHeroRotate, nil, cc.p(0, 0))

	self._nodeHero = self:_createNode()

	self:addToRotate(self._nodeHero)

	self._nodeHeroUp = self:_createNode()

	self:addToRoot(self._nodeHeroUp)

	self._nodeFontBg = self:_createNode()

	self:addToRoot(self._nodeFontBg, nil, cc.p(0, 0))

	self._nodeScreenUp = self:_createNode()

	self:addToOwnUINode(self._nodeScreenUp)

	self._nodeEffect = self:_createNode()

	self:addToOwnUINode(self._nodeEffect)

	self._nodeText = self:_createNode()

	self:addToOwnUINode(self._nodeText)

	self._nodeTop = self:_createNode()

	self:addToOwnUINode(self._nodeTop)

	local var_2_0 = arg_2_1.bgId

	if not self._ownUINode then
		if not var_2_0 or var_2_0 == "0" or var_2_0 == 0 then
			local var_2_1 = var_0_9.fetch(self._type)

			if var_2_1 then
				if var_2_1.type == 1 then
					var_2_0 = var_2_1.stage1
				elseif var_2_1.type == 2 then
					var_2_0 = var_2_1["stage" .. math.random(1, 4)]
				end
			end
		end

		if not var_2_0 then
			if self._type == BattleConst.TYPE_DUNGEON and arg_2_1.mapId then
				local var_2_2 = arg_2_1.offsetX or 0
				local var_2_3 = arg_2_1.offsetY or 0
				local var_2_4 = "parallax/dungeon_stage/" .. arg_2_1.mapId .. "/dungeon_stage.pcfg"
				local var_2_5 = self:_createBgNew("parallax/dungeon_stage/" .. arg_2_1.mapId .. "/dungeon_stage.pcfg", var_2_2, var_2_3, "background")

				var_2_5:setPosition(134, 27)
				var_2_5:setScale(1.2)
				self._nodeBackBg:addChild(var_2_5, 0)

				local var_2_6 = self:_createBgNew(var_2_4, var_2_2, var_2_3, "font")

				var_2_6:setPosition(134, 27)
				var_2_6:setScale(1.2)
				self._nodeFontBg:addChild(var_2_6, 0)
			else
				local var_2_7 = var_0_8.get(101)
				local var_2_8 = var_2_7.stage_bg

				if g.core.utils.Quality.needUseStaticMap() then
					var_2_8 = var_2_8 .. "0001"
				end

				local var_2_9 = "parallax/dungeon_stage/" .. var_2_8 .. "/dungeon_stage.pcfg"
				local var_2_10 = self:_createBgNew(var_2_9, var_2_7.pos_x or 0, var_2_7.pos_y or 0, "background")

				var_2_10:setScale(var_2_7.scale / 1000)
				self._nodeBackBg:addChild(var_2_10, 0)
				self._nodeFontBg:addChild(self:_createBgNew(var_2_9, 0, 0, "font"), 0)
			end
		else
			local var_2_11 = var_0_8.get(var_2_0)

			if var_2_11.bg_type == 1 then
				self:_addSceneBg(var_2_0)
			elseif var_2_11.bg_type == 2 then
				local var_2_12 = var_2_11.pos_x or 0
				local var_2_13 = var_2_11.pos_y or 0
				local var_2_14 = "battle/parallax_bg/" .. var_2_11.stage_bg .. "/battle.pcfg"
				local var_2_15 = self:_createBgNew("battle/parallax_bg/" .. var_2_11.stage_bg .. "/battle.pcfg", var_2_12, var_2_13, "background", var_2_11.algorithm_type)

				var_2_15:setScale(var_2_11.scale / 1000)
				self._nodeBackBg:addChild(var_2_15, 0)

				local var_2_16 = self:_createBgNew(var_2_14, var_2_12, var_2_13, "font", var_2_11.algorithm_type)

				var_2_16:setScale(var_2_11.scale / 1000)
				self._nodeFontBg:addChild(var_2_16, 0)
			elseif var_2_11.bg_type == 3 then
				local var_2_17 = var_2_11.stage_bg or 2

				if g.core.utils.Quality.needUseStaticMap() then
					var_2_17 = var_2_17 .. "0001"
				end

				local var_2_18 = var_2_11.pos_x or 0
				local var_2_19 = var_2_11.pos_y or 0
				local var_2_20 = "parallax/dungeon_stage/" .. var_2_17 .. "/dungeon_stage.pcfg"
				local var_2_21 = self:_createBgNew("parallax/dungeon_stage/" .. var_2_17 .. "/dungeon_stage.pcfg", var_2_18, var_2_19, "background")

				var_2_21:setScale(var_2_11.scale / 1000)
				var_2_21:setPosition(134, 27)
				self._nodeBackBg:addChild(var_2_21, 0)

				local var_2_22 = self:_createBgNew(var_2_20, var_2_18, var_2_19, "font")

				var_2_22:setScale(var_2_11.scale / 1000)
				var_2_22:setPosition(134, 27)
				self._nodeFontBg:addChild(var_2_22, 0)
			elseif var_2_11.bg_type == 4 then
				self:_addSceneBg(var_2_0)

				local var_2_23 = self:_createBgNew("battle/parallax_bg/" .. var_2_11.stage_bg .. "/battle.pcfg", var_2_11.pos_x or 0, var_2_11.pos_y or 0)

				var_2_23:setScale(var_2_11.scale / 1000)
				self._nodeFontBg:addChild(var_2_23, 0)
			elseif var_2_11.bg_type == 5 then
				local var_2_24 = display.newSprite("battle/image_bg/" .. var_2_11.stage_bg .. ".jpg")
				local var_2_25 = var_2_24:getContentSize()
				local var_2_26 = math.max(display.width / 1334, display.height / 750) * 1.05

				if var_2_26 > 1 then
					var_2_24:setContentSize(var_2_25.width * var_2_26, var_2_25.height * var_2_26)
				end

				var_2_24:setScale(var_2_11.scale / 1000)
				self._nodeBackBg:addChild(var_2_24, 0)
			end
		end
	end

	self._nodeLight = self:_createNode()

	self:addChild(self._nodeLight)
	self:createBlackBg()
end

function BattleCamera:createBlackBg()
	local var_3_0 = cc.LayerColor:create(cc.c4b(0, 0, 0, 160), display.width * 2, display.height * 2)

	var_3_0:setPosition(-display.width / 2, -display.height / 2)
	var_3_0:setVisible(false)
	self._nodeHero:addChild(var_3_0, BattleCamera.SHADOW_Z)

	self._blackNode = var_3_0
end

function BattleCamera:getRoot()
	return self._nodeRoot
end

function BattleCamera:addToRoot(arg_5_1, arg_5_2, arg_5_3)
	self:_addToNode(self._nodeRoot, arg_5_1, arg_5_2, arg_5_3)
end

function BattleCamera:addToRotate(arg_6_1, arg_6_2, arg_6_3)
	self:_addToNode(self._nodeHeroRotate, arg_6_1, arg_6_2, arg_6_3)
end

function BattleCamera:addToOwnUINode(arg_7_1, arg_7_2, arg_7_3)
	if self._ownUINode then
		arg_7_3 = cc.p(0, 0)
	end

	self:_addToNode(self._ownUINode or self._nodeRoot, arg_7_1, arg_7_2, arg_7_3)
end

function BattleCamera:addToTop(arg_8_1, arg_8_2, arg_8_3)
	self:_addToNode(self._nodeTop, arg_8_1, arg_8_2, arg_8_3)
end

function BattleCamera:_addToNode(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_3 = arg_9_3 or self._defaultZ
	arg_9_4 = arg_9_4 or cc.p(-self._size.width / 2, -self._size.height / 2)

	arg_9_2:setPosition(arg_9_4)
	arg_9_1:addChild(arg_9_2, arg_9_3)

	self._defaultZ = self._defaultZ + 1
end

function BattleCamera:getCenter()
	return cc.p(self._size.width / 2, self._size.height / 2)
end

function BattleCamera:changeBackground()
	self:removeBgParallax()

	local var_11_0 = var_0_8.get(1000)
	local var_11_1 = var_11_0.pos_x or 0
	local var_11_2 = var_11_0.pos_y or 0
	local var_11_3 = "battle/parallax_bg/" .. var_11_0.stage_bg .. "/battle.pcfg"

	self._nodeBackBg:addChild(self:_createBgNew("battle/parallax_bg/" .. var_11_0.stage_bg .. "/battle.pcfg", var_11_1, var_11_2, "background"), 0)
	self._nodeFontBg:addChild(self:_createBgNew(var_11_3, var_11_1, var_11_2, "font"), 0)
end

function BattleCamera:_createBgNew(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	local var_12_0 = json.decodeFile(arg_12_1)
	local var_12_1

	if arg_12_4 == "background" then
		var_12_1 = var_12_0.bg
	elseif arg_12_4 == "font" then
		var_12_1 = var_12_0.fg
	else
		var_12_1 = var_12_0.bg

		if var_12_0.fg then
			for iter_12_0 = 1, #var_12_0.fg do
				var_12_1[#var_12_1 + 1] = var_12_0.fg[iter_12_0]
			end
		end
	end

	local function var_12_2(arg_13_0, arg_13_1, arg_13_2)
		arg_13_0:addChild(arg_13_1, arg_13_2.zorder, arg_13_2.radio, arg_13_2.offset)
	end

	local var_12_3 = cc.ParallaxNode:create()

	var_12_3:setAnchorPoint(cc.p(0, 0))

	for iter_12_1 = 1, #var_12_1 do
		local var_12_4 = var_12_1[iter_12_1]
		local var_12_5
		local var_12_6 = arg_12_2 or 0
		local var_12_7 = arg_12_3 or 0

		if var_12_1[iter_12_1].img or var_12_4.img_param then
			local var_12_8 = var_12_4.img or var_12_4.img_param

			if type(var_12_8) == "table" then
				var_12_5 = cc.Node:create()

				local var_12_9 = 0

				for iter_12_2, iter_12_3 in ipairs(var_12_8) do
					local var_12_10 = ccui.ImageView:create(ResourceLoader:getPlatformResource(iter_12_3.unit))

					var_12_5:addChild(var_12_10)
					var_12_10:setAnchorPoint(cc.p(0, 1))
					var_12_10:setPosition(var_12_9, 0)

					var_12_9 = var_12_9 + var_12_10:getContentSize().width
				end
			elseif var_12_4.offset.x + var_12_6 * var_12_4.radio.x + var_12_4.size.width < -display.width or var_12_4.offset.x + var_12_6 * var_12_4.radio.x > display.width then
				-- block empty
			else
				var_12_5 = ccui.ImageView:create(ResourceLoader:getPlatformResource(var_12_8))
			end

			if var_12_5 then
				var_12_5:setAnchorPoint(cc.p(0, 1))
			end

			if var_12_5 and var_12_4.opacity and var_12_5.setOpacity then
				var_12_5:setOpacity(var_12_4.opacity)
			end
		elseif var_12_4.spine or var_12_4.spine_param then
			local var_12_11 = var_12_4.spine or var_12_4.spine_param

			if var_12_4.offset.x + var_12_6 * var_12_4.radio.x + 1334 < -display.width / 2 or var_12_4.offset.x + var_12_6 * var_12_4.radio.x > display.width then
				-- block empty
			else
				var_12_5 = cc.Node:create()
			end

			if var_12_5 then
				local var_12_12 = SpineBase.new({
					anim = "play",
					resId = "",
					isLoop = true,
					path = g.core.common.Path:getEffSpine(var_12_11)
				})

				var_12_5:addChild(var_12_12)
				var_12_5:setContentSize(cc.size(50, 50))
				var_12_5:setAnchorPoint(cc.p(0, 1))

				if var_12_4.opacity and var_12_12.setOpacity then
					var_12_12:setOpacity(var_12_4.opacity)
				end
			end
		end

		if var_12_5 then
			if var_12_4.scale and var_12_4.scale ~= 0 then
				var_12_5:setScale(var_12_4.scale)
			end

			local var_12_13 = {
				zorder = iter_12_1,
				radio = cc.p(var_12_4.radio.x, var_12_4.radio.y)
			}
			local var_12_15 = -var_12_7 * var_12_4.radio.y - var_12_4.offset.y - ((g.core.battle.BattleProxy:getType() == BattleConst.TYPE_DUNGEON or nil) and (display.height - 750) / 2)

			var_12_13.offset = cc.p(var_12_4.offset.x + var_12_6 * var_12_4.radio.x, (arg_12_5 == 1 or nil) and display.height - var_12_4.offset.y + display.cy * (1 - var_12_4.radio.y) + var_12_7 - (display.height - 750))

			var_12_2(var_12_3, var_12_5, var_12_13)

			self._defaultZ = var_12_13.zorder + 1
		end
	end

	return var_12_3
end

function BattleCamera:showBlack(arg_14_1)
	if not tolua.isnull(self._blackNode) then
		self._blackNode:setVisible(arg_14_1)
	end
end

function BattleCamera:updateMotion()
	if self._currMotion then
		if self._currMotion.updateEntry then
			self._currMotion:updateEntry()
		else
			self._currMotion:step()
		end
	end
end

function BattleCamera:updateMovie(arg_16_1)
	if self._movieNode then
		self._movieNode:step(arg_16_1)
	end
end

function BattleCamera:stopMotion()
	self._currMotion = nil
end

function BattleCamera:_createNode()
	local var_18_0 = cc.Node:create()

	var_18_0:setCascadeColorEnabled(true)
	var_18_0:setCascadeOpacityEnabled(true)
	var_18_0:setPosition(-self._size.width * 0.5, -self._size.height * 0.5)

	return var_18_0
end

function BattleCamera:addToNodeBgMask(arg_19_1)
	if self._nodeBgMask then
		self._nodeBgMask:addChild(arg_19_1, ...)
	end
end

function BattleCamera:addToNodeBase(arg_20_1)
	if self._nodeBase then
		self._nodeBase:addChild(arg_20_1, ...)
	end
end

function BattleCamera:addToNodeHero(arg_21_1)
	if self._nodeHero then
		self._nodeHero:addChild(arg_21_1, ...)
	end
end

function BattleCamera:addToNodeHeroDown(arg_22_1)
	if self._nodeHeroDown then
		self._nodeHeroDown:addChild(arg_22_1, ...)
	end
end

function BattleCamera:addToNodeHeroUp(arg_23_1)
	if self._nodeHeroUp then
		self._nodeHeroUp:addChild(arg_23_1, ...)
	end
end

function BattleCamera:addToNodeEffect(arg_24_1)
	if self._nodeEffect then
		self._nodeEffect:addChild(arg_24_1, ...)
	end
end

function BattleCamera:addToNodeImgText(arg_25_1)
	if self._nodeText then
		self._nodeText:addChild(arg_25_1, ...)
	end
end

function BattleCamera:addToNodeLight(arg_26_1)
	if self._nodeLight then
		self._nodeLight:addChild(arg_26_1, ...)
	end
end

function BattleCamera:addToNodeScreenDown(arg_27_1)
	if self._nodeScreenDown then
		self._nodeScreenDown:addChild(arg_27_1, ...)
	end
end

function BattleCamera:addToNodeScreenUp(arg_28_1)
	if self._nodeScreenUp then
		self._nodeScreenUp:addChild(arg_28_1, ...)
	end
end

function BattleCamera:playBgEffect(arg_29_1, arg_29_2)
	arg_29_1 = arg_29_1 or "effect_6008_2group_start_bg"

	local var_29_0 = 3 - arg_29_2

	self._battleLayer:showUI(false)
	self._battleLayer:showHpBar(false, arg_29_2)

	local var_29_1 = require("app.view.battle.entry.EffectEntry"):new(self._battleLayer, function(arg_30_0)
		if arg_30_0 == "finish" then
			self._battleLayer:showUI(true)
			self._battleLayer:showHpBar(true)
		elseif arg_30_0 == "disappear" then
			self._battleLayer:showHpBar(false, var_29_0)
		elseif arg_30_0 == "appear" then
			self._battleLayer:showHpBar(true, var_29_0)
		end
	end)

	self._battleLayer:getMainEntry():addEntryToNewQueue(var_29_1, var_29_1.updateEntry)

	local var_29_2 = var_29_1:getNodeRoot()

	var_29_2:setPosition(display.cx, display.cy)
	self._nodeHero:addChild(var_29_2, BattleCamera.SHADOW_Z + 1)
	var_29_1:getNodeRoot():setScale(BattleUtils.getMaxScale())
end

function BattleCamera:playBgLight(arg_31_1)
	local var_31_0

	if not arg_31_1 then
		arg_31_1 = "effect_6008_2group_shanping"
		var_31_0 = require("app.view.battle.entry.EffectEntry").new
	end

	local var_31_1 = require("app.view.battle.entry.EffectEntry").new(arg_31_1, self._battleLayer)

	self._battleLayer:getMainEntry():addEntryToNewQueue(var_31_1, var_31_1.updateEntry)

	local var_31_2 = var_31_1:getNodeRoot()

	var_31_2:setPosition(display.cx, display.cy)
	self:addToNodeLight(var_31_2)
	var_31_1:getNodeRoot():setScale(BattleUtils.getMaxScale())
end

function BattleCamera:playEffectDown(arg_32_1, arg_32_2)
	local var_32_0 = require("app.view.battle.entry.EffectEntry").new(arg_32_1, self._battleLayer)

	self._battleLayer:getMainEntry():addEntryToNewQueue(var_32_0, var_32_0.updateEntry)

	local var_32_1 = var_32_0:getNodeRoot()

	var_32_1:setPosition(display.cx, display.cy)

	if arg_32_2 then
		var_32_1:setScaleX(-1)
	end

	self:addToNodeScreenDown(var_32_1)
end

function BattleCamera:playEffectUp(arg_33_1, arg_33_2)
	local var_33_0 = require("app.view.battle.entry.EffectEntry").new(arg_33_1, self._battleLayer)

	self._battleLayer:getMainEntry():addEntryToNewQueue(var_33_0, var_33_0.updateEntry)

	local var_33_1 = var_33_0:getNodeRoot()

	var_33_1:setPosition(display.cx, display.cy)

	if arg_33_2 then
		var_33_1:setScaleX(-1)
	end

	self:addToNodeScreenUp(var_33_1)
end

function BattleCamera:moveAndScaleTo(arg_34_1)
	if self._currMotion then
		return
	end

	local var_34_0 = Entry.new()

	self._battleLayer:slowSpeed()

	local var_34_1 = Action.newDelay(15)

	var_34_1:startWithTarget(self._nodeRoot)
	var_34_0:addEntryToQueue(var_34_1, var_34_1.stepNext)
	var_34_0:addEntryToQueue(nil, function()
		self._battleLayer:resetSpeed()

		return true
	end)

	self._currMotion = var_34_0
end

function BattleCamera:getNodeText()
	return self._nodeText
end

function BattleCamera:addBgMovie(arg_37_1)
	if not arg_37_1 or not arg_37_1.movieName then
		return
	end

	local var_37_0 = arg_37_1.movieName

	if self._sceneBgMovieList[arg_37_1.movieName] then
		return
	end

	arg_37_1.x = self._size.width / 2
	arg_37_1.y = self._size.height / 2

	local var_37_1 = CriSprite.new(arg_37_1)

	if arg_37_1.isTop then
		self._nodeScreenUp:addChild(var_37_1)
	else
		self._nodeBgMask:addChild(var_37_1)
	end

	self._sceneBgMovieList[var_37_0] = var_37_1
end

function BattleCamera:_addSceneBg(arg_38_1)
	local var_38_0 = var_0_8.get(arg_38_1)

	for iter_38_0 = 1, 3 do
		if var_38_0["bottom_" .. iter_38_0] ~= 0 then
			self:addBgMovie({
				isLoop = true,
				isTop = false,
				moduleName = "battle_bg/" .. arg_38_1,
				movieName = var_38_0["bottom_" .. iter_38_0]
			})
		end

		if var_38_0["top_" .. iter_38_0] ~= 0 then
			self:addBgMovie({
				isLoop = true,
				isTop = true,
				moduleName = "battle_bg/" .. arg_38_1,
				movieName = var_38_0["top_" .. iter_38_0]
			})
		end
	end
end

function BattleCamera:removeBgMovie()
	for iter_39_0 = 1, #self._sceneBgMovieList do
		if self._sceneBgMovieList[iter_39_0] then
			self._sceneBgMovieList[iter_39_0]:dispose()
		end
	end

	self._sceneBgMovieList = {}
end

function BattleCamera:addTopUniteMovie(arg_40_1)
	if not arg_40_1 or not arg_40_1.movieName then
		return
	end

	local var_40_1 = arg_40_1.isTextZorder or false
	local var_40_2 = arg_40_1.isBottom or false
	local var_40_3 = arg_40_1.zorder or 0
	local var_40_4 = arg_40_1.listener

	function arg_40_1.listener(arg_41_0)
		if var_40_4 then
			var_40_4(arg_41_0)
		end

		if arg_41_0 == "complete" then
			-- block empty
		end
	end

	arg_40_1.moduleName = "battle"

	if arg_40_1.x and arg_40_1.x ~= 0 then
		arg_40_1.x = arg_40_1.x or self._size.width / 2
	end

	if arg_40_1.y and arg_40_1.y ~= 0 then
		arg_40_1.y = arg_40_1.y or self._size.height / 2
	end

	arg_40_1.strict = true

	local var_40_5 = CriSprite.new(arg_40_1)

	if arg_40_1.fullScreenState == 1 then
		if arg_40_1.isReverse then
			var_40_5:setScaleX(-1.3)
			var_40_5:setScaleY(1.3)
		else
			var_40_5:setScale(1.3)
			var_40_5:setScaleY(1.3)
		end
	end

	if var_40_1 then
		self._nodeEffect:addChild(var_40_5, var_40_3)
	elseif var_40_2 then
		self._nodeScreenDown:addChild(var_40_5, var_40_3)
	else
		self._nodeTop:addChild(var_40_5, var_40_3)
	end

	return var_40_5
end

function BattleCamera:removeTopUniteMovieByName(arg_42_1)
	return
end

function BattleCamera:getTopUniteMovieByName(arg_43_1)
	return
end

function BattleCamera:removeBgParallax()
	self._nodeBackBg:removeAllChildren()
	self._nodeFontBg:removeAllChildren()
end

function BattleCamera:onExit()
	if not self._ownUINode then
		self:removeBgMovie()
	end

	self._nodeRoot = nil
	self._nodeBgMask = nil
	self._nodeBase = nil
	self._nodeHeroDown = nil
	self._nodeHero = nil
	self._nodeHeroUp = nil
	self._nodeEffect = nil
	self._nodeText = nil
end

return BattleCamera
