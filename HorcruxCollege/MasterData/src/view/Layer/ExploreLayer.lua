ExploreLayer = class("ExploreLayer", function()
	return cc.Layer:create()
end)

require("view.Layer.DropPreviewLayer")
require("view.Layer.ChooseRoleLayer")
require("view.Layer.PopLayer")

local playermodel = require("model.playermodel")
local explore_manager = require("controller.explore_manager")
local audio_manager = require("controller.audio_manager")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local var_0_6 = config._DEBUG and 0 or 1
local var_0_7 = 1
local var_0_9 = {
	[LATTICE_LOCK] = {
		"explore/0.png",
		"explore/0_on.png"
	},
	[LATTICE_SAFE] = {
		"explore/1.png",
		"explore/1_on.png"
	},
	[LATTICE_UNEXPLORE] = {
		"explore/2.png",
		"explore/2_on.png"
	},
	[LATTICE_UNKNOWN] = {
		"explore/3.png",
		"explore/3_on.png"
	},
	[LATTICE_DANGEROUS] = {
		"explore/4.png",
		"explore/4_on.png"
	}
}
local var_0_10 = {
	"explore/4.png",
	"explore/4_on.png"
}
local var_0_11 = "areabg/"
local var_0_12 = "explore/item_tag.png"
local var_0_13 = "explore/event_tag.png"
local var_0_14 = {
	"explore/explore_button.png",
	"explore/explore_button_on.png"
}
local var_0_15 = {
	"explore/challenge_button1.png",
	"explore/challenge_button1_on.png"
}
local var_0_16

function ExploreLayer.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = ExploreLayer.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function ExploreLayer.getInstance()
	return var_0_16
end

function ExploreLayer:init(arg_4_1, arg_4_2)
	var_0_16 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ExploreLattice.json" or "ExploreLattice.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:setBackGroundImage(UIBG)

	self.area = arg_4_1
	self.curIndex = nil
	self.curStatus = nil

	self:initLatticeInfoPanel()
	self:initAreaInfo()
	self:initExploreCoinInfo()
	explore_manager:getExploreLatticeInfos(arg_4_1, function(arg_5_0)
		if not var_0_16 then
			return
		end

		if arg_5_0 == 1 then
			self:initLatticeNet()
			self:updateAreaInfo()
		end
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_return"):setPosition(cc.p(604, 812))
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_return"):addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:runAction(cc.RemoveSelf:create())
	end)
	GuideListener:checkCondition("ExploreLayer", self.rootLayer)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			var_0_16 = nil
		end
	end)
end

function ExploreLayer:initLatticeNet()
	self.latticePanel = ccui.Helper:seekWidgetByName(self.rootLayer, "lattice_panel")

	local var_8_0 = explore_manager:getAreaLayoutInfo(self.area)

	self.lattice_tbl = {}
	self._staggeraxis = var_8_0.staggeraxis
	self._netsize = cc.p(var_8_0.size_x, var_8_0.size_y)

	if self._staggeraxis == var_0_7 then
		self:filterLatticesAxisX(var_8_0.data)
	else
		self:filterLatticesAxisY(var_8_0.data)
	end
end

local var_0_17 = 61

function ExploreLayer:filterLatticesAxisX(arg_9_1)
	local var_9_0 = 122
	local var_9_1 = 108
	local var_9_2 = 0
	local var_9_3 = 0
	local var_9_4 = 0 / 2
	local var_9_5 = 108 * self._netsize.y + 108 / 2 + 0 * (self._netsize.y - 1)
	local var_9_7 = self._netsize.x == 5 and 74 or 25
	local var_9_8 = self._netsize.y == 6 and -30 or 80

	local function var_9_9(arg_10_0, arg_10_1)
		local var_10_0

		if arg_10_1.custom.status == LATTICE_SAFE and arg_10_1.invade and arg_10_1.invade.status == LATTICE_INVADE_UNCOMPLETE then
			var_10_0 = ccui.Button:create(var_0_10[1], var_0_10[2], var_0_10[1], var_0_6)
			var_10_0.textures = {
				var_0_10[1],
				var_0_10[2]
			}
			var_10_0.status = LATTICE_INVADE
		else
			var_10_0 = ccui.Button:create(var_0_9[arg_10_1.custom.status][1], var_0_9[arg_10_1.custom.status][2], var_0_9[arg_10_1.custom.status][1], var_0_6)
			var_10_0.textures = {
				var_0_9[arg_10_1.custom.status][1],
				var_0_9[arg_10_1.custom.status][2]
			}
			var_10_0.status = arg_10_1.custom.status

			if arg_10_1.custom.status == LATTICE_SAFE then
				local var_10_1 = explore_manager:getShowMonsterCount(arg_10_0)

				if var_10_1 > 0 then
					local var_10_2 = cc.Label:createWithTTF(var_10_1, "fonts/new.ttf", 40)

					var_10_2:setAnchorPoint(cc.p(0.5, 0.5))
					var_10_2:setName("num")
					var_10_2:setPosition(cc.p(var_10_0:getContentSize().width / 2, var_10_0:getContentSize().height / 2))
					var_10_0:addChild(var_10_2)
				elseif arg_10_1.config.droptype == LATTICE_DROP_ITEM then
					local var_10_3

					if config._DEBUG then
						var_10_3 = cc.Sprite:create(var_0_12) or cc.Sprite:createWithSpriteFrameName(var_0_12)
					end

					var_10_3:setPosition(cc.p(var_10_0:getContentSize().width / 2, var_10_0:getContentSize().height / 2))
					var_10_3:setName("tag")
					var_10_0:addChild(var_10_3)
				elseif arg_10_1.config.droptype == LATTICE_DROP_EVENT then
					local var_10_4

					if config._DEBUG then
						var_10_4 = cc.Sprite:create(var_0_13) or cc.Sprite:createWithSpriteFrameName(var_0_13)
					end

					var_10_4:setPosition(cc.p(var_10_0:getContentSize().width / 2, var_10_0:getContentSize().height / 2))
					var_10_4:setName("tag")
					var_10_0:addChild(var_10_4)
				end
			end
		end

		var_10_0:setAnchorPoint(cc.p(0.5, 0.5))

		local var_10_5 = self:getLatticePos(arg_10_0)

		var_10_0:setPosition(cc.p(var_9_7 + (var_9_0 / 2 * (var_10_5.x + 1) + var_0_17 / 2 * var_10_5.x + var_9_2 * var_10_5.x), var_9_8 + (var_9_5 - ((var_10_5.x % 2 ~= 0 or nil) and (var_9_1 / 2 + var_9_4 or 0)) - (2 * var_10_5.y + 1) * var_9_1 / 2 - var_9_3 * var_10_5.y)))

		var_10_0.index = arg_10_0

		function var_10_0:updateLattice(arg_11_1)
			local var_11_0 = explore_manager:getSingleLatticeInfo(arg_10_0)

			local function var_11_1()
				if var_11_0.custom.status == LATTICE_SAFE and var_11_0.invade and var_11_0.invade.status == LATTICE_INVADE_UNCOMPLETE then
					self:loadTextures(var_0_10[1], var_0_10[2], var_0_10[1], var_0_6)

					self.textures = {
						var_0_10[1],
						var_0_10[2]
					}
					self.status = LATTICE_INVADE
				else
					self:loadTextures(var_0_9[var_11_0.custom.status][1], var_0_9[var_11_0.custom.status][2], var_0_9[var_11_0.custom.status][1], var_0_6)

					self.textures = {
						var_0_9[var_11_0.custom.status][1],
						var_0_9[var_11_0.custom.status][2]
					}
					self.status = var_11_0.custom.status

					if var_11_0.custom.status == LATTICE_SAFE then
						local var_12_0 = explore_manager:getShowMonsterCount(arg_10_0)

						if var_12_0 > 0 then
							if self:getChildByName("num") then
								self:getChildByName("num"):setString(var_12_0)
							else
								local var_12_1 = cc.Label:createWithTTF(var_12_0, "fonts/new.ttf", 40)

								var_12_1:setAnchorPoint(cc.p(0.5, 0.5))
								var_12_1:setName("num")
								var_12_1:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
								self:addChild(var_12_1)
							end
						else
							if self:getChildByName("num") then
								self:getChildByName("num"):removeFromParent()
							end

							if var_11_0.config.droptype == LATTICE_DROP_ITEM then
								if not self:getChildByName("tag") then
									local var_12_2

									if config._DEBUG then
										var_12_2 = cc.Sprite:create(var_0_12) or cc.Sprite:createWithSpriteFrameName(var_0_12)
									end

									var_12_2:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
									var_12_2:setName("tag")
									self:addChild(var_12_2)
								end
							elseif var_11_0.config.droptype == LATTICE_DROP_EVENT and not self:getChildByName("tag") then
								local var_12_3

								if config._DEBUG then
									var_12_3 = cc.Sprite:create(var_0_13) or cc.Sprite:createWithSpriteFrameName(var_0_13)
								end

								var_12_3:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
								var_12_3:setName("tag")
								self:addChild(var_12_3)
							end
						end
					end
				end
			end

			if arg_11_1 then
				self:runAction(cc.Sequence:create(cc.FadeTo:create(0.1, 100), cc.CallFunc:create(var_11_1), cc.FadeTo:create(0.1, 255)))
			else
				var_11_1()
			end
		end

		return var_10_0
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		if iter_9_1 > 0 then
			local var_9_10 = explore_manager:getSingleLatticeInfo(iter_9_0)

			if var_9_10 then
				local var_9_11 = var_9_9(iter_9_0, var_9_10)

				self.latticePanel:addChild(var_9_11)

				self.lattice_tbl[iter_9_0] = var_9_11

				self.lattice_tbl[iter_9_0]:addTouchEventListener(function(arg_13_0, arg_13_1)
					if arg_13_1 ~= ccui.TouchEventType.ended then
						return
					end

					if arg_13_0.index == self.curIndex and arg_13_0.status == self.curStatus then
						return
					end

					if self.curIndex then
						self.lattice_tbl[self.curIndex]:loadTextures(self.lattice_tbl[self.curIndex].textures[1], self.lattice_tbl[self.curIndex].textures[2], self.lattice_tbl[self.curIndex].textures[1], var_0_6)
					end

					self.curIndex = arg_13_0.index
					self.curStatus = arg_13_0.status

					arg_13_0:loadTextures(arg_13_0.textures[2], arg_13_0.textures[2], arg_13_0.textures[1], var_0_6)
					self.latticeInfoPanel:updateInfo(arg_13_0.index)
				end)
			end
		end
	end
end

function ExploreLayer:filterLatticesAxisY(arg_14_1)
	local var_14_0 = 108
	local var_14_1 = 122
	local var_14_2 = 0
	local var_14_3 = 0
	local var_14_4 = 0 / 2
	local var_14_6 = (122 + var_0_17) * self._netsize.y / 2
	local var_14_7 = 0
	local var_14_8 = 0

	local function var_14_9(arg_15_0, arg_15_1)
		local var_15_0 = ccui.Button:create("explore/0.png", "explore/0_on.png", "explore/0.png", var_0_6)

		var_15_0:setAnchorPoint(cc.p(0.5, 0.5))

		local var_15_1

		if arg_15_0 % self._netsize.x ~= 0 then
			var_15_1 = arg_15_0 % self._netsize.x or self._netsize.x
		end

		local var_15_2 = math.ceil(arg_15_0 / self._netsize.x)

		var_15_0:setPosition(cc.p(cc.p(var_14_7 + ((2 * var_15_1 - 1) * var_14_0 / 2 + ((var_15_2 % 2 == 0 or nil) and (var_14_0 / 2 + var_14_4 or 0)) + var_14_2 * (var_15_1 - 1)), var_14_8 + (var_14_6 - var_14_1 / 2 * var_15_2 - var_0_17 / 2 * (var_15_2 - 1) - var_14_3 * (var_15_2 - 1)))))

		return var_15_0
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_1) do
		if iter_14_1 > 0 then
			local var_14_10 = var_14_9(iter_14_0)

			self.latticePanel:addChild(var_14_10)

			self.lattice_tbl[iter_14_0] = var_14_10
		end
	end
end

function ExploreLayer:getLatticeIndexAt(arg_16_1)
	if self._staggeraxis == var_0_7 then
		return arg_16_1.x + arg_16_1.y * self._netsize.x + 1
	else
		return arg_16_1.x + arg_16_1.y * self._netsize.x + 1
	end
end

function ExploreLayer:getLatticeAt(arg_17_1)
	return self.lattice_tbl[self:getLatticeIndexAt(arg_17_1)]
end

function ExploreLayer:getLatticePos(arg_18_1)
	if self._staggeraxis == var_0_7 then
		return cc.p((arg_18_1 - 1) % self._netsize.x, (math.floor((arg_18_1 - 1) / self._netsize.x)))
	else
		return cc.p((arg_18_1 - 1) % self._netsize.x, (math.floor((arg_18_1 - 1) / self._netsize.x)))
	end
end

function ExploreLayer:initAreaInfo()
	self.areaPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "area_bg_panel")

	local var_19_0, var_19_1 = explore_manager:getAreaBg(self.area)

	self.areaPanel:getChildByName("bg"):loadTexture(var_0_11 .. var_19_0 .. ".png")
	self.areaPanel:getChildByName("bg"):setPosition(cc.p(-var_19_1 * 1.06, 142))

	self.infoPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "area_infobg")

	self.infoPanel:getChildByName("area_name"):setString(explore_manager:getAreaName(self.area))
end

function ExploreLayer:updateAreaInfo()
	explore_manager:getExploreAreaCompletePercent(self.area, function(arg_21_0, arg_21_1)
		self.infoPanel:getChildByName("area_info"):setString(L_EXPLORE_PROGRESS .. string.format("%02d/%02d", arg_21_0, arg_21_1))
	end)
end

function ExploreLayer:addExploreAnimation(arg_22_1)
	local var_22_0 = ccui.Layout:create()

	var_22_0:setContentSize(cc.size(640, 1136))
	var_22_0:setTouchEnabled(true)
	self:addChild(var_22_0)
	require("view.Armature.L2Skeleton")

	local var_22_1 = L2Skeleton:create("spine/ui/radar.json", "spine/ui/radar.atlas")

	var_22_1:refreshSkeleton()
	var_22_1:setPosition(cc.p(320, 500))
	var_22_0:addChild(var_22_1, 20)
	var_22_1:registerListener(SP_ANIMATION_COMPLETE, function(arg_23_0)
		if arg_23_0.animation == "animation" then
			var_22_0:runAction(cc.RemoveSelf:create())

			if arg_22_1 then
				arg_22_1()
			end
		end
	end)
	var_22_1:play("animation", false)
	audio_manager:playeffectMusic(EXPLORE_EFFECT)
end

local var_0_18 = cc.p(46, 633)
local var_0_19 = cc.p(171, 237)

function ExploreLayer:initLatticeInfoPanel()
	self.latticeInfoPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "lattice_infopanel")

	self.latticeInfoPanel:setPosition(var_0_18)
	self:initLatticeInfo()
	self:initExploreSoulButton()
	self.latticeInfoPanel:getChildByName("btn_explore"):setVisible(false)

	local var_24_0 = {
		[LATTICE_SAFE] = function(arg_25_0, arg_25_1, arg_25_2)
			self.dropInfo:updateInfo(arg_25_1)
			self.consumeInfo:setVisible(true)
			arg_25_0:getChildByName("btn_explore"):loadTextures(var_0_14[1], var_0_14[2], var_0_14[1], var_0_6)
			arg_25_0:getChildByName("btn_explore"):addTouchEventListener(function(arg_26_0, arg_26_1)
				if arg_26_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_26_0:isBright() then
					return
				end

				arg_26_0:setBright(false)
				explore_manager:beginExplore(self.area, arg_25_1, self.curSoul, function(arg_27_0, arg_27_1, arg_27_2)
					if arg_27_0 == 1 then
						self:addExploreAnimation(function()
							for iter_28_0, iter_28_1 in pairs(arg_27_1) do
								self.lattice_tbl[iter_28_1]:updateLattice()
							end

							self:updateAreaInfo()
							self:updateExploreCoin()
							self.dropInfo:updateInfo(arg_25_1)
							LayerManager:pushInLayer("PopPurchaseResultLayer", arg_27_2)
						end)
					elseif arg_27_0 == 2 then
						global_ShowBlockWords(L_EXPLORE_BEGIN_MSG[2])
					elseif arg_27_0 == 3 then
						global_ShowBlockWords(L_EXPLORE_BEGIN_MSG[3])
					elseif arg_27_0 == 6 then
						global_ShowBlockWords(L_EXPLORE_BEGIN_MSG[6])
					elseif arg_27_0 == 7 then
						global_ShowBlockWords(L_EXPLORE_BEGIN_MSG[7])
					end

					arg_26_0:setBright(true)
				end)
			end)
		end,
		[LATTICE_UNEXPLORE] = function(arg_29_0, arg_29_1, arg_29_2)
			self.dropInfo:updateInfo(arg_29_1)
			self.consumeInfo:setVisible(true)
			arg_29_0:getChildByName("btn_explore"):loadTextures(var_0_14[1], var_0_14[2], var_0_14[1], var_0_6)
			arg_29_0:getChildByName("btn_explore"):addTouchEventListener(function(arg_30_0, arg_30_1)
				if arg_30_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_30_0:isBright() then
					return
				end

				arg_30_0:setBright(false)
				explore_manager:beginExplore(self.area, arg_29_1, self.curSoul, function(arg_31_0, arg_31_1, arg_31_2)
					if arg_31_0 == 1 then
						self:addExploreAnimation(function()
							for iter_32_0, iter_32_1 in pairs(arg_31_1) do
								self.lattice_tbl[iter_32_1]:updateLattice()
							end

							self:updateAreaInfo()
							self:updateExploreCoin()
							self.dropInfo:updateInfo(arg_29_1)
							LayerManager:pushInLayer("PopPurchaseResultLayer", arg_31_2)
						end)
					elseif arg_31_0 == 2 then
						global_ShowBlockWords(L_EXPLORE_BEGIN_MSG[2])
					elseif arg_31_0 == 3 then
						global_ShowBlockWords(L_EXPLORE_BEGIN_MSG[3])
					elseif arg_31_0 == 6 then
						global_ShowBlockWords(L_EXPLORE_BEGIN_MSG[6])
					elseif arg_31_0 == 7 then
						global_ShowBlockWords(L_EXPLORE_BEGIN_MSG[7])
					end

					arg_30_0:setBright(true)
				end)
			end)
		end,
		[LATTICE_UNKNOWN] = function(arg_33_0, arg_33_1, arg_33_2)
			self.dropInfo:updateInfo(arg_33_1)
			self.consumeInfo:setVisible(true)
			arg_33_0:getChildByName("btn_explore"):loadTextures(var_0_14[1], var_0_14[2], var_0_14[1], var_0_6)
			arg_33_0:getChildByName("btn_explore"):addTouchEventListener(function(arg_34_0, arg_34_1)
				if arg_34_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_34_0:isBright() then
					return
				end

				arg_34_0:setBright(false)
				explore_manager:beginExplore(self.area, arg_33_1, self.curSoul, function(arg_35_0, arg_35_1, arg_35_2)
					if arg_35_0 == 1 then
						self:addExploreAnimation(function()
							for iter_36_0, iter_36_1 in pairs(arg_35_1) do
								self.lattice_tbl[iter_36_1]:updateLattice()
							end

							self:updateAreaInfo()
							self:updateExploreCoin()
							self.dropInfo:updateInfo(arg_33_1)
							LayerManager:pushInLayer("PopPurchaseResultLayer", arg_35_2)
						end)
					elseif arg_35_0 == 2 then
						global_ShowBlockWords(L_EXPLORE_BEGIN_MSG[2])
					elseif arg_35_0 == 3 then
						global_ShowBlockWords(L_EXPLORE_BEGIN_MSG[3])
					elseif arg_35_0 == 6 then
						global_ShowBlockWords(L_EXPLORE_BEGIN_MSG[6])
					elseif arg_35_0 == 7 then
						global_ShowBlockWords(L_EXPLORE_BEGIN_MSG[7])
					end

					arg_34_0:setBright(true)
				end)
			end)
		end,
		[LATTICE_DANGEROUS] = function(arg_37_0, arg_37_1, arg_37_2)
			self.dropInfo:updateInfo(arg_37_1)
			self.consumeInfo:setVisible(false)
			arg_37_0:getChildByName("btn_explore"):loadTextures(var_0_15[1], var_0_15[2], var_0_15[1], var_0_6)
			arg_37_0:getChildByName("btn_explore"):addTouchEventListener(function(arg_38_0, arg_38_1)
				if arg_38_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_38_0:isBright() then
					return
				end

				local var_38_0, var_38_1 = explore_manager:getExploreFightInfo(self.area, arg_37_1)

				if var_38_0 == 1 then
					self:addChild(DropPreviewLayer:create(FIGHTTYPE_EXPLORE, var_38_1, true, false, function()
						local var_39_0 = explore_manager:beginExploreFight(self.area, arg_37_1)

						if var_39_0 == 0 then
							-- block empty
						elseif var_39_0 == 2 then
							-- block empty
						elseif var_39_0 == 3 then
							-- block empty
						elseif var_39_0 == 4 then
							-- block empty
						end
					end), 10)
				elseif var_38_0 == 2 then
					-- block empty
				elseif var_38_0 == 3 then
					-- block empty
				elseif var_38_0 == 4 then
					-- block empty
				end
			end)
		end,
		[LATTICE_INVADE] = function(arg_40_0, arg_40_1, arg_40_2)
			self.dropInfo:updateInfo(arg_40_1)
			self.consumeInfo:setVisible(false)
			arg_40_0:getChildByName("btn_explore"):loadTextures(var_0_15[1], var_0_15[2], var_0_15[1], var_0_6)
			arg_40_0:getChildByName("btn_explore"):addTouchEventListener(function(arg_41_0, arg_41_1)
				if arg_41_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_41_0:isBright() then
					return
				end

				local var_41_0, var_41_1 = explore_manager:getExploreFightInfo(self.area, arg_40_1)

				if var_41_0 == 1 then
					self:addChild(DropPreviewLayer:create(FIGHTTYPE_EXPLORE, var_41_1, true, false, function()
						local var_42_0 = explore_manager:beginExploreFight(self.area, arg_40_1)

						if var_42_0 == 0 then
							-- block empty
						elseif var_42_0 == 2 then
							-- block empty
						elseif var_42_0 == 3 then
							-- block empty
						elseif var_42_0 == 4 then
							-- block empty
						end
					end), 10)
				elseif var_41_0 == 2 then
					-- block empty
				elseif var_41_0 == 3 then
					-- block empty
				elseif var_41_0 == 4 then
					-- block empty
				end
			end)
		end
	}

	function self.latticeInfoPanel:updateInfo(arg_43_1)
		local var_43_0 = explore_manager:getSingleLatticeInfo(arg_43_1)
		local var_43_1, var_43_2 = self.lattice_tbl[arg_43_1]:getPosition()

		if var_43_2 >= 458 then
			self:setPosition(var_0_19)
		else
			self:setPosition(var_0_18)
		end

		if var_43_0.custom.status == LATTICE_LOCK then
			self.latticeInfoDetails:hide()
		else
			self.latticeInfoDetails:show()

			if var_43_0.custom.status == LATTICE_SAFE and var_43_0.invade and var_43_0.invade.status == LATTICE_INVADE_UNCOMPLETE then
				var_24_0[LATTICE_INVADE](self, arg_43_1, var_43_0)
			else
				var_24_0[var_43_0.custom.status](self, arg_43_1, var_43_0)
			end
		end
	end
end

function ExploreLayer:initLatticeInfo()
	self.latticeInfoDetails = self.latticeInfoPanel:getChildByName("info"):getChildByName("lattice_infobg")

	self:initLatticeInfoLabels()
	self.latticeInfoDetails:setPosition(cc.p(-143, 59))

	function self.latticeInfoDetails:show()
		self:stopAllActions()
		self:setPosition(cc.p(-143, 59))
		self.latticeInfoPanel:getChildByName("btn_explore"):setVisible(false)
		self:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(143, 59)), cc.CallFunc:create(function()
			self.latticeInfoPanel:getChildByName("btn_explore"):setVisible(true)
		end)))
	end

	function self.latticeInfoDetails:hide()
		self:stopAllActions()
		self:runAction(cc.MoveTo:create(0.5, cc.p(-143, 59)))
		self.latticeInfoPanel:getChildByName("btn_explore"):setVisible(false)
	end
end

function ExploreLayer:initLatticeInfoLabels()
	self.consumeInfo = self.latticeInfoDetails:getChildByName("consumeinfo")

	self.consumeInfo:setString(L_COMSUME_PHYSICAL_POWER .. explore_manager:getExploreConsume(self.area))

	self.dropInfo = self.latticeInfoDetails:getChildByName("dropinfo")

	function self.dropInfo:updateInfo(arg_49_1)
		self.consumeInfo:setString(L_COMSUME_PHYSICAL_POWER .. explore_manager:getExploreConsume(self.area))
		self:setString((explore_manager:getLatticeDropInfo(self.area, arg_49_1)))
	end
end

function ExploreLayer:initExploreSoulButton()
	self.exploreSoul = self.latticeInfoPanel:getChildByName("btn_exploresoul")

	self.exploreSoul:getChildByName("soul"):setLocalZOrder(-3)
	self.exploreSoul:getChildByName("frame"):setLocalZOrder(-2)
	self.exploreSoul:getChildByName("soulpanel"):setLocalZOrder(-1)

	local var_50_0 = explore_manager:getExploreConsume(self.area)

	self.curSoul = explore_manager:generateDefaultExploreSoul(var_50_0)

	local var_50_1 = self.exploreSoul:getChildByName("soulpanel")
	local var_50_2 = self.exploreSoul:getChildByName("frame")
	local var_50_3 = {}

	for iter_50_0 = 1, 2 do
		var_50_3[iter_50_0] = var_50_1:getChildByName("light" .. iter_50_0)
	end

	function self.exploreSoul:updateSoul(arg_52_1)
		self.curSoul = arg_52_1

		if not arg_52_1 then
			self:getChildByName("soul"):setVisible(false)

			return
		end

		local var_52_0 = item_data[playermodel.items[playermodel.weaponId[arg_52_1]].itemid].modelid

		self:getChildByName("soul"):setVisible(true)
		self:getChildByName("soul"):loadTexture(ROLE_RECT_HEAD_IMAGE_PATH .. model_data[var_52_0].head_image .. ".png")
	end

	self.exploreSoul:updateSoul(self.curSoul)
	self.exploreSoul:getChildByName("soulpanel"):scheduleUpdateWithPriorityLua(function(arg_51_0)
		for iter_51_0, iter_51_1 in pairs(var_50_3) do
			if iter_51_1:getPositionY() <= -iter_51_1:getContentSize().height / 2 then
				iter_51_1:setPosition(cc.p(iter_51_1:getPositionX(), iter_51_1:getPositionY() + iter_51_1:getContentSize().height * 2 + 20))
			end

			iter_51_1:setPosition(cc.p(iter_51_1:getPositionX(), iter_51_1:getPositionY() - 3))
		end
	end, 0)
	self.exploreSoul:addTouchEventListener(function(arg_53_0, arg_53_1)
		local var_53_0

		if arg_53_1 ~= ccui.TouchEventType.ended then
			do return end

			var_53_0 = {
				selected = self.curSoul,
				recommend = var_50_0
			}
		end

		function var_53_0.callback(arg_54_0)
			if self.curSoul == arg_54_0 then
				return
			end

			arg_53_0:updateSoul(arg_54_0)
		end

		self:addChild(ChooseRoleLayer:create(var_53_0), 10)
	end)
end

function ExploreLayer:initExploreCoinInfo()
	self.explorecoinPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "explorecoinpanel")

	self.explorecoinPanel:getChildByName("num"):setString(global_trans_number(playermodel.explorecoin))
end

function ExploreLayer:updateExploreCoin()
	self.explorecoinPanel:getChildByName("num"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2), cc.ScaleTo:create(0.2, 1)))
	self.explorecoinPanel:getChildByName("num"):setString(global_trans_number(playermodel.explorecoin))
end
