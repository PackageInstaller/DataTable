CompoundLabLayer = class("CompoundLabLayer", function()
	return cc.Layer:create()
end)

require("view.Layer.PopLayer")
require("view.Sprite.ItemsPanel")

local lab_manager = require("controller.lab_manager")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local lab_levelup_data = require("data.lab_levelup_data")
local lab_compound_data = require("data.lab_compound_data")
local item_data = require("data.item_data")
local var_0_6
local var_0_7 = 1
local var_0_8 = 2

function CompoundLabLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = CompoundLabLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function CompoundLabLayer.getInstance()
	return var_0_6
end

function CompoundLabLayer:init(arg_4_1)
	var_0_6 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Produce_xinpian.json" or "Produce_xinpian.ExportJson")

	self:addChild(self.rootLayer)
	ccui.Helper:seekWidgetByName(self.rootLayer, "bg"):loadTexture("mainScenebg/xinpianbg.jpg")

	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "title_bg")
	self.level = ccui.Helper:seekWidgetByName(self.title, "num")

	self.level:setVisible(false)

	self.levelupButton = ccui.Helper:seekWidgetByName(self.rootLayer, "button_upgrade")
	self.timebg = ccui.Helper:seekWidgetByName(self.rootLayer, "timeleft_bg")
	self.timelabel = ccui.Helper:seekWidgetByName(self.timebg, "label")

	self.timelabel:setVisible(false)

	self.gainButton = ccui.Helper:seekWidgetByName(self.rootLayer, "button_gainawards")
	self.chipbutton = {}

	for iter_4_0 = 1, 3 do
		self.chipbutton[iter_4_0] = ccui.Helper:seekWidgetByName(self.rootLayer, "button_" .. iter_4_0)
	end

	self:initReturnButton()
	self:initLayer()
	self:initLabLevelup(arg_4_1)
	TopcostLayer.getInstance():registeReturnEvent(CompoundLabLayer)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			if LabLayer.getInstance() then
				TopcostLayer.getInstance():registeReturnEvent(LabLayer)
			end

			var_0_6 = nil

			if self.compoundSchedule then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.compoundSchedule)

				self.compoundSchedule = nil
			end

			if self.levelupSchedule then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.levelupSchedule)

				self.levelupSchedule = nil
			end

			LabLayer.getInstance():updateAlert({
				[LAB_TYPE_ENERGY] = {
					status = 1
				},
				[LAB_TYPE_COMPOUND] = {
					status = 1
				},
				[LAB_TYPE_CENTER] = {
					status = 1
				}
			})
		end
	end)
end

function CompoundLabLayer.exit()
	performWithDelay(var_0_6, function()
		var_0_6:runAction(cc.RemoveSelf:create())
	end, 0.5)
end

function CompoundLabLayer.topupdate()
	return {
		"public/return1.png",
		"public/return1_on.png"
	}
end

function CompoundLabLayer:initReturnButton()
	self.returnBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "button_return")

	self.returnBnt:setVisible(false)
	self.returnBnt:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		performWithDelay(self, function()
			self:runAction(cc.RemoveSelf:create())
		end, 0.5)
	end)
end

function CompoundLabLayer:initLayer()
	self.timebg:setVisible(false)
	self.timelabel:setVisible(false)

	for iter_12_0 = 1, 3 do
		self.chipbutton[iter_12_0]:addTouchEventListener(function()
			return
		end)

		if self.chipbutton[iter_12_0].itemid then
			self.chipbutton[iter_12_0].itemid = nil
		end

		if self.chipbutton[iter_12_0].sp then
			self.chipbutton[iter_12_0].sp:removeFromParent()

			self.chipbutton[iter_12_0].sp = nil
		end
	end

	lab_manager:getCompoundLabInfo(function(arg_14_0, arg_14_1)
		if not var_0_6 then
			return
		end

		if arg_14_0.result == 1 then
			self.levelNum = arg_14_1

			self.level:setVisible(true)
			self.level:setString(arg_14_1)

			self.info = arg_14_0.info

			if self.info.status == 1 then
				self.gainButton:getChildByName("label"):setString(L_COMPOUNDLAB_INFO[1])
				self.gainButton:addTouchEventListener(function(arg_15_0, arg_15_1)
					if arg_15_1 ~= ccui.TouchEventType.ended then
						return
					end

					local function var_15_0()
						lab_manager:startCrystalCompound(self.chipbutton[1].itemid, self.chipbutton[2].itemid, function(arg_17_0)
							if arg_17_0 == 1 then
								global_ShowBlockWords(L_COMPOUNDLAB_INFO[1] .. "~~~")
								self:initLayer()
							elseif arg_17_0 == 2 then
								global_ShowBlockWords(L_COMPOUNDLAB_INFO[2])
							elseif arg_17_0 == 3 then
								global_ShowBlockWords(L_COMPOUNDLAB_INFO[3])
							elseif arg_17_0 == 4 then
								global_ShowBlockWords(L_COMPOUNDLAB_INFO[4])
							end
						end)
					end

					if self.chipbutton[1].itemid and self.chipbutton[2].itemid then
						global_basic_scene:addChild(PopLayer:Compound_remind({
							costtype = "gold",
							surecallback = var_15_0,
							cost = item_data[self.chipbutton[1].itemid].compound_price,
							own = playermodel.gold,
							level = self.levelNum,
							costtime = item_data[self.chipbutton[1].itemid].compound_time,
							speed = lab_compound_data[self.levelNum].speed_up
						}), 999)
					else
						global_ShowBlockWords(L_COMPOUNDLAB_INFO[2])
					end
				end)

				local function var_14_0(arg_18_0, arg_18_1)
					local var_18_0 = item_manager:filterItem(kITEM_GIFT_BAG)
					local var_18_1 = {}
					local var_18_2 = {}

					table.sort(var_18_0, function(arg_19_0, arg_19_1)
						if not arg_18_1.itemid then
							if item_data[arg_19_0].equip_quality == item_data[arg_19_1].equip_quality then
								return arg_19_0 < arg_19_1
							else
								return item_data[arg_19_0].equip_quality < item_data[arg_19_1].equip_quality
							end
						elseif arg_19_0 ~= arg_18_1.itemid and arg_19_1 ~= arg_18_1.itemid then
							if item_data[arg_19_0].equip_quality == item_data[arg_19_1].equip_quality then
								return arg_19_0 < arg_19_1
							else
								return item_data[arg_19_0].equip_quality < item_data[arg_19_1].equip_quality
							end
						else
							return arg_19_0 == arg_18_1.itemid and arg_19_1 ~= arg_18_1.itemid
						end
					end)

					for iter_18_0, iter_18_1 in ipairs(var_18_0) do
						if iter_18_1 % 10 ~= 0 then
							if math.floor(iter_18_1 / 10000) == 120 and iter_18_1 > 1200100 then
								table.insert(var_18_1, iter_18_1)
							elseif math.floor(iter_18_1 / 10000) == 121 then
								table.insert(var_18_2, iter_18_1)
							end
						end
					end

					local var_18_4

					if arg_18_0 == var_0_7 then
						var_18_4 = ItemsPanel:create(kITEM_GEM, var_18_1, arg_18_1.itemid, {
							used = function()
								var_18_4:exit()

								for iter_20_0 = 1, 3 do
									if self.chipbutton[iter_20_0].sp then
										self.chipbutton[iter_20_0].sp:removeFromParent()

										self.chipbutton[iter_20_0].sp = nil
									end

									self.chipbutton[iter_20_0].itemid = nil
								end

								self.chipbutton[1]:addTouchEventListener(function(arg_21_0, arg_21_1)
									if arg_21_1 ~= ccui.TouchEventType.ended then
										return
									end

									var_14_0(var_0_7, arg_21_0)
								end)
							end,
							unused = function(arg_22_0)
								var_18_4:exit()

								if arg_22_0 % 10 == 5 then
									global_ShowBlockWords(L_COMPOUNDLAB_INFO[5])

									return
								end

								if arg_18_1.sp then
									arg_18_1.sp:removeFromParent()

									arg_18_1.sp = nil
								end

								local var_22_0 = ItemSprite:create(arg_22_0, 1)

								var_22_0:setPosition(cc.p(arg_18_1:getContentSize().width / 2, arg_18_1:getContentSize().height / 2))
								arg_18_1:addChild(var_22_0, 1)

								arg_18_1.sp = var_22_0
								arg_18_1.itemid = arg_22_0

								self.chipbutton[1]:addTouchEventListener(function(arg_23_0, arg_23_1)
									if arg_23_1 ~= ccui.TouchEventType.ended then
										return
									end

									var_14_0(var_0_7, arg_23_0)
								end)

								if math.floor(arg_22_0 / 10000) == 120 then
									for iter_22_0 = 1, 3 do
										if self.chipbutton[iter_22_0].sp and iter_22_0 ~= 1 then
											self.chipbutton[iter_22_0].sp:removeFromParent()

											self.chipbutton[iter_22_0].sp = nil
										end
									end

									local var_22_1 = item_data[arg_22_0].compound_crystal
									local var_22_2 = ItemSprite:createWithItemId(item_data[arg_22_0].compound_crystal, 1)

									var_22_2:setPosition(cc.p(self.chipbutton[2]:getContentSize().width / 2, self.chipbutton[2]:getContentSize().height / 2))
									self.chipbutton[2]:addChild(var_22_2, 1)

									self.chipbutton[2].sp = var_22_2
									self.chipbutton[2].itemid = item_data[arg_22_0].compound_crystal

									if item_manager:getItemNumber(item_data[arg_22_0].compound_crystal) == 0 then
										self.chipbutton[2].sp:setColor(cc.c3b(112, 128, 144))
										self.chipbutton[2].sp:setOpacity(60)
										self.chipbutton[2]:addTouchEventListener(function(arg_24_0, arg_24_1)
											if arg_24_1 ~= ccui.TouchEventType.ended then
												return
											end

											var_14_0(var_0_8, arg_24_0)
											global_ShowBlockWords(L_COMPOUNDLAB_INFO[6])

											local var_24_0 = PopLayer:Go_Gain_Layer({
												item = var_22_1
											})

											if var_24_0 then
												cc.Director:getInstance():getRunningScene():addChild(var_24_0, 999)
											end
										end)
									end

									local var_22_3 = arg_22_0 + 1
									local var_22_4 = ItemSprite:createWithItemId(arg_22_0 + 1, 1)

									var_22_4:setPosition(cc.p(self.chipbutton[3]:getContentSize().width / 2, self.chipbutton[3]:getContentSize().height / 2))
									self.chipbutton[3]:addChild(var_22_4, 1)

									self.chipbutton[3].sp = var_22_4
									self.chipbutton[3].itemid = var_22_3
								end
							end
						}, 4)

						self:addChild(var_18_4, 10)
					end
				end

				self.chipbutton[1]:addTouchEventListener(function(arg_25_0, arg_25_1)
					if arg_25_1 ~= ccui.TouchEventType.ended then
						return
					end

					var_14_0(var_0_7, arg_25_0)
				end)
			elseif self.info.status == 2 then
				local var_14_1 = {
					self.info.consume_crystal,
					self.info.consume_scroll,
					self.info.compound_crystal
				}

				for iter_14_0 = 1, 3 do
					local var_14_2 = ItemSprite:createWithItemId(var_14_1[iter_14_0], 1)

					var_14_2:setPosition(cc.p(self.chipbutton[iter_14_0]:getContentSize().width / 2, self.chipbutton[iter_14_0]:getContentSize().height / 2))
					self.chipbutton[iter_14_0]:addChild(var_14_2, 1)

					self.chipbutton[iter_14_0].sp = var_14_2
				end

				self.gainButton:getChildByName("label"):setString(L_QUICK_GAIN_MSG.Quick_gain)
				self.gainButton:addTouchEventListener(function(arg_26_0, arg_26_1)
					local var_26_0

					if arg_26_1 ~= ccui.TouchEventType.ended then
						do return end

						var_26_0 = {
							costtype = "diamond"
						}
					end

					function var_26_0.surecallback()
						lab_manager:quickharvestCrystalCompound(function(arg_28_0)
							if arg_28_0 == 0 then
								global_ShowBlockWords(L_QUICK_GAIN_MSG.Quick_gain_Failure)
							elseif arg_28_0 == 1 then
								LayerManager:pushInLayer("PopPurchaseResultLayer", {
									items = {
										{
											dropNum = 1,
											dropid = self.info.compound_crystal,
											entityid = self.info.compound_crystal
										}
									},
									labels = L_QUICK_GAIN_MSG.Popmsg_Label
								})
								global_ShowBlockWords(L_QUICK_GAIN_MSG.Quick_gain_Success, RISE_WORDS_SUCCESS)
								self:initLayer()
							elseif arg_28_0 == 2 then
								LayerManager:pushInLayer("PopGoBuyDiamond", {
									is_need_pop_layer = 0
								})
							end
						end)
					end

					var_26_0.cost = math.ceil(self.info.remain_time / 240 * LAB_QUICK_HARVEST_COST_PER_SIXMIN)
					var_26_0.own = playermodel.diamond
					var_26_0.remaintime = self.info.remain_time

					global_basic_scene:addChild(PopLayer:Quick_Finish_Compound(var_26_0), 999)
				end)

				self.compoundSchedule = self.compoundSchedule or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
					self.info.remain_time = self.info.remain_time - 1

					self.timelabel:setVisible(true)
					self.timelabel:setString(string.format("%02d:%02d:%02d", math.floor(self.info.remain_time / 3600), math.floor(self.info.remain_time % 3600 / 60), math.floor(self.info.remain_time % 3600 % 60)))

					if self.info.remain_time <= 0 then
						if self.compoundSchedule then
							cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.compoundSchedule)

							self.compoundSchedule = nil
						end

						self:initLayer()
					end
				end, 1, false)

				self.timebg:setVisible(true)
			elseif self.info.status == 3 then
				local var_14_3 = {
					self.info.consume_crystal,
					self.info.consume_scroll,
					self.info.compound_crystal
				}

				for iter_14_1 = 1, 3 do
					local var_14_4 = ItemSprite:createWithItemId(var_14_3[iter_14_1], 1)

					var_14_4:setPosition(cc.p(self.chipbutton[iter_14_1]:getContentSize().width / 2, self.chipbutton[iter_14_1]:getContentSize().height / 2))
					self.chipbutton[iter_14_1]:addChild(var_14_4, 1)

					self.chipbutton[iter_14_1].sp = var_14_4

					if iter_14_1 ~= 3 then
						self.chipbutton[iter_14_1].sp:setOpacity(20)
					end
				end

				self.gainButton:getChildByName("label"):setString(L_QUICK_GAIN_MSG.Gain_Jingti)
				self.gainButton:addTouchEventListener(function(arg_30_0, arg_30_1)
					lab_manager:harvestCrystalCompound(function(arg_31_0)
						if arg_31_0 == 1 then
							LayerManager:pushInLayer("PopPurchaseResultLayer", {
								items = {
									{
										dropNum = 1,
										dropid = self.info.compound_crystal,
										entityid = self.info.compound_crystal
									}
								},
								labels = L_QUICK_GAIN_MSG.Popmsg_Label
							})
							self:initLayer()
						end
					end)
				end)
			end
		end
	end)
end

function CompoundLabLayer:initLabLevelup(arg_32_1)
	if arg_32_1 then
		self.levelupButton:getChildByName("label"):setString(L_COMPOUNDLAB_LEVEL_UP.Level_Uping)
		self.levelupButton:getChildByName("time_left"):setVisible(true)
		self.levelupButton:addTouchEventListener(function(arg_33_0, arg_33_1)
			if arg_33_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(L_COMPOUNDLAB_LEVEL_UP.Lab_Level_Uping)

			local var_33_0, var_33_1, var_33_2 = lab_manager:getLabLevelupInfo()

			global_basic_scene:addChild(PopLayer:Quick_Finish_Gem({
				costtype = "diamond",
				surecallback = function()
					lab_manager:quickcompleteLabLevelup(LAB_TYPE_COMPOUND, function(arg_35_0)
						if arg_35_0 == 0 then
							global_ShowBlockWords(L_QUICK_GAIN_MSG.Quick_gain_Failure)
						elseif arg_35_0 == 1 then
							global_ShowBlockWords(Quick_gain_Success.Quick_gain_Success, RISE_WORDS_SUCCESS)

							self.levelNum = lab_manager.lab_info[LAB_TYPE_COMPOUND].level

							self.title:getChildByName("lv"):getChildByName("num"):setString(lab_manager.lab_info[LAB_TYPE_COMPOUND].level)
							self:initLabLevelup(false)
						elseif arg_35_0 == 3 then
							LayerManager:pushInLayer("PopGoBuyDiamond", {
								is_need_pop_layer = 0
							})
						elseif arg_35_0 == 2 then
							global_ShowBlockWords(L_COMPOUNDLAB_LEVEL_UP.Throw_Error)
						elseif arg_35_0 == 4 then
							global_ShowBlockWords(L_COMPOUNDLAB_LEVEL_UP.Complete_Level_Up)
						end
					end)
				end,
				cost = math.ceil(var_33_2 / 360 * LAB_QUICK_HARVEST_COST_PER_SIXMIN),
				own = playermodel.diamond,
				remaintime = var_33_2
			}), 999)
		end)

		local var_32_0, var_32_1, var_32_2 = lab_manager:getLabLevelupInfo()

		self.levelupButton:getChildByName("time_left"):getChildByName("label"):setString(string.format("%02d:%02d:%02d", math.floor(var_32_2 / 3600), math.floor(var_32_2 % 3600 / 60), math.floor(var_32_2 % 3600 % 60)))

		self.levelupSchedule = self.levelupSchedule or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
			self:updateLabLevelup(lab_manager:getLabLevelupInfo())
		end, 1, false)
	else
		if self.levelupSchedule then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.levelupSchedule)

			self.levelupSchedule = nil
		end

		self.levelupButton:getChildByName("label"):setString(L_COMPOUNDLAB_LEVEL_UP.Lab_Level_Up)
		self.levelupButton:getChildByName("time_left"):setVisible(false)
		self.levelupButton:addTouchEventListener(function(arg_37_0, arg_37_1)
			if arg_37_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_37_0

			if not arg_37_0:isBright() then
				do return end

				var_37_0 = {
					gold_cost = lab_levelup_data[LAB_TYPE_COMPOUND * 1000 + self.levelNum].gold,
					labels = {
						[2] = {
							name = L_COMPOUNDLAB_LEVEL_UP.Attr[2],
							value = tostring(lab_compound_data[self.levelNum].speed_up * 100 + 100) .. "%",
							newvalue = tostring(lab_compound_data[self.levelNum + 1].speed_up * 100 + 100) .. "%"
						},
						{
							name = L_COMPOUNDLAB_LEVEL_UP.Attr[1],
							value = self.levelNum,
							newvalue = self.levelNum + 1
						}
					},
					title = L_LAB_UPGRADE.title,
					bntstr = L_LAB_UPGRADE.bntstr,
					materials = consume_items
				}
			end

			function var_37_0.surecallback(arg_38_0)
				lab_manager:startLabLevelup(LAB_TYPE_COMPOUND, function(arg_39_0, arg_39_1)
					arg_37_0:setBright(true)

					if arg_39_0 == 1 then
						arg_38_0()
						self:initLabLevelup(true)
						LabLayer.getInstance():updateLabInfos(arg_39_1)
					elseif arg_39_0 == 2 then
						global_ShowBlockWords(L_COMPOUNDLAB_LEVEL_UP.Warning[2])
					elseif arg_39_0 == 3 then
						global_ShowBlockWords(L_COMPOUNDLAB_LEVEL_UP.Warning[3])
					elseif arg_39_0 == 4 then
						LayerManager:pushInLayer("PopGoLayer", {
							targetlayer = "HandOfMidasLayer",
							labels = L_GO_BUY_GOLD
						})
					elseif arg_39_0 == 5 then
						global_ShowBlockWords(L_COMPOUNDLAB_LEVEL_UP.Warning[5])
					elseif arg_39_0 == 6 then
						global_ShowBlockWords(L_COMPOUNDLAB_LEVEL_UP.Warning[6])
					elseif arg_39_0 == 7 then
						global_ShowBlockWords(L_COMPOUNDLAB_LEVEL_UP.Warning[7])
					end
				end)
			end

			function var_37_0.cancelcallback()
				arg_37_0:setBright(true)
			end

			arg_37_0:setBright(false)
			LayerManager:pushInLayer("PopUpgradeCostlayer", var_37_0)
		end)
	end
end

function CompoundLabLayer:updateLabLevelup(arg_41_1, arg_41_2, arg_41_3)
	if arg_41_1 == LAB_STATUS_FREE then
		if self.levelupSchedule then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.levelupSchedule)

			self.levelupSchedule = nil
		end

		self.title:getChildByName("lv"):getChildByName("num"):setString(lab_manager.lab_info[LAB_TYPE_COMPOUND].level)
		self:initLabLevelup(false)
	elseif arg_41_2 ~= LAB_TYPE_COMPOUND then
		if self.levelupSchedule then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.levelupSchedule)

			self.levelupSchedule = nil
		end

		self.title:getChildByName("lv"):getChildByName("num"):setString(lab_manager.lab_info[LAB_TYPE_COMPOUND].level)
		self:initLabLevelup(false)
	else
		self.levelupButton:getChildByName("time_left"):getChildByName("label"):setString(string.format("%02d:%02d:%02d", math.floor(arg_41_3 / 3600), math.floor(arg_41_3 % 3600 / 60), math.floor(arg_41_3 % 3600 % 60)))
	end
end
