PlotLayer = class("PlotLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = 2
local var_0_1 = 1
local var_0_2 = 9
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = "roleimage/role1/"
local var_0_5 = {
	LEVELMODE = 4,
	ITEM = 3,
	EXPLORE = 2,
	TALK = 1
}
local var_0_6 = 1
local var_0_7 = 2
local plot_data = require("data.plot_data")
local plot_class_data = require("data.plot_class_data")
local model_data = require("data.model_data")

local function var_0_14(arg_2_0, arg_2_1)
	local function var_2_0(arg_3_0)
		if type(arg_3_0) == "table" then
			for iter_3_0, iter_3_1 in pairs(arg_3_0) do
				local var_3_0 = var_2_0(iter_3_1)

				if var_3_0 then
					return var_3_0
				end
			end

			return nil
		elseif arg_3_0:getName() == arg_2_1 then
			return arg_3_0
		else
			return var_2_0(arg_3_0:getChildren())
		end
	end

	return var_2_0(arg_2_0)
end

function PlotLayer.create(arg_4_0)
	local var_4_0 = PlotLayer.new()

	var_4_0:init()

	return var_4_0
end

function PlotLayer:init()
	self.npcLayer = ccui.Layout:create()

	self:addChild(self.npcLayer, var_0_0)

	self.uiLayer = ccui.Layout:create()

	self:addChild(self.uiLayer, var_0_1)

	self.touchLayer = ccui.Layout:create()

	self.touchLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.touchLayer:setTouchEnabled(false)
	self:addChild(self.touchLayer, var_0_2)
end

function PlotLayer:updatePlotShow(arg_6_1)
	self:updatePlotNpc(arg_6_1)
	self:updatePlotUI(arg_6_1)
	self:updatePlotRemind(arg_6_1)
end

function PlotLayer:exploreUpdatePlotShow(arg_7_1)
	self:clean_all()
	self:updatePlotNpc(arg_7_1)
	self:updatePlotUI(arg_7_1)
end

function PlotLayer:levelmapUpdataPlotShow(arg_8_1)
	self:updatePlotUI(arg_8_1)
end

function PlotLayer.fightlayerUpdatePlotRemind(arg_9_0)
	if PlotManager.plot_layer_config.LevelMapLayer then
		local var_9_0 = LayerManager:getUIElement("FightLayer")

		if var_9_0 then
			PlotManager:addRemind(var_0_14(var_9_0, PlotManager.PLOT_REMIND_CONFIG.LevelMapLayer.showconfig.FightLayer[1]), PlotManager.PLOT_REMIND_CONFIG.LevelMapLayer.showconfig.FightLayer[2])
		end
	else
		local var_9_1 = LayerManager:getUIElement("FightLayer")

		if var_9_1 then
			local var_9_2 = var_0_14(var_9_1, PlotManager.PLOT_REMIND_CONFIG.LevelMapLayer.showconfig.FightLayer[1])

			if var_9_2 then
				PlotManager:removeRemind(var_9_2)
			end
		end
	end
end

function PlotLayer:updatePlotNpc(arg_10_1)
	if PlotManager.plot_layer_config[arg_10_1] then
		local var_10_0

		if arg_10_1 == "LevelMapLayer" then
			self.npcLayer:setPositionY(-GameDisplay.fix_y + 220)

			var_10_0 = math.floor((GameDisplay.height - 220 - 100) / 180)
		elseif arg_10_1 == "SchoolAreaLayer" then
			self.npcLayer:setPositionY(-GameDisplay.fix_y + 100)

			var_10_0 = 4
		else
			self.npcLayer:setPositionY(-GameDisplay.fix_y + 100)

			var_10_0 = math.floor((GameDisplay.height - 100 - 100) / 180)
		end

		for iter_10_0, iter_10_1 in pairs(PlotManager.plot_layer_config[arg_10_1]) do
			if iter_10_1.npc and 1 <= var_10_0 then
				self:createNpc(iter_10_1, 1)
			end
		end
	end
end

function PlotLayer.updatePlotUI(arg_11_0, arg_11_1)
	if PlotManager.plot_layer_config[arg_11_1] then
		for iter_11_0, iter_11_1 in pairs(PlotManager.plot_layer_config[arg_11_1]) do
			if iter_11_1.ui then
				PlotManager:createUI(iter_11_1)
			end
		end
	end
end

function PlotLayer.updatePlotRemind(arg_12_0, arg_12_1)
	if not PlotManager.LAYER_PLOT_REMIND_CONFIG[arg_12_1] then
		return
	end

	for iter_12_0, iter_12_1 in pairs(PlotManager.LAYER_PLOT_REMIND_CONFIG[arg_12_1]) do
		if PlotManager.plot_layer_config[iter_12_1] then
			PlotManager:addRemind(var_0_14(LayerManager:getActiveLayerObj(), PlotManager.PLOT_REMIND_CONFIG[iter_12_1].showconfig[arg_12_1][1]), PlotManager.PLOT_REMIND_CONFIG[iter_12_1].showconfig[arg_12_1][2])
		end
	end
end

function PlotLayer:createNpc(arg_13_1, arg_13_2)
	local var_13_0 = ccui.Button:create(var_0_4 .. model_data[arg_13_1.npc].cute_role .. ".png", nil, var_0_4 .. model_data[arg_13_1.npc].cute_role .. ".png")

	var_13_0:setName("npc" .. arg_13_1.plotClassId)
	var_13_0:setAnchorPoint(0, 0)
	var_13_0:setPosition(-25, (arg_13_2 - 1) * 180)
	var_13_0:setScale(0.38)
	self.npcLayer:addChild(var_13_0)

	local var_13_1 = ccui.ImageView:create("public/rolebg/npc_bg.png", var_0_3)

	var_13_1:setAnchorPoint(cc.p(0.5, 1))
	var_13_1:setPosition(-22 + var_13_0:getBoundingBox().width / 2, var_13_0:getPositionY() + 31.5)
	self.npcLayer:addChild(var_13_1)

	local var_13_2 = cc.Label:createWithTTF(model_data[arg_13_1.npc].name_Q, FONT_NAME, 21)

	var_13_2:setColor(cc.c3b(228, 245, 245))
	var_13_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_13_2:setPosition(var_13_1:getContentSize().width / 2 - 8, var_13_1:getContentSize().height / 2 - 4)
	var_13_1:addChild(var_13_2)
	PlotManager:addRemind(var_13_0, cc.p(320, 300), 1.6666666666666667)

	local var_13_3 = {
		[var_0_5.TALK] = function(arg_14_0)
			if arg_14_0.isLock then
				return
			end

			arg_14_0.isLock = true

			GuideListener.swallowEvent(false)
			GuideListener.lockGuideTrigger(true)
			GuideListener.cleanCurGuides()

			local var_14_0
			local var_14_1

			local function var_14_2()
				local var_15_0 = plot_class_data[arg_13_1.plotClassId]

				if var_14_0 then
					local function var_15_1()
						GuideListener.swallowEvent(false)
						GuideListener.lockGuideTrigger(false)
						GuideListener.updateGuides(LayerManager:getCurrentLayerObj())

						if var_14_1 then
							global_ShowBlockWords(var_15_0.plot_name .. L_PLOT_EVENT_FINISH, cc.c3b(132, 239, 55))
						end
					end

					var_14_0.surecallback = var_15_1
					var_14_0.cancelcallback = var_15_1

					LayerManager:pushInLayer("PopPurchaseResultLayer", var_14_0)
				else
					GuideListener.swallowEvent(false)
					GuideListener.lockGuideTrigger(false)
					GuideListener.updateGuides(LayerManager:getCurrentLayerObj())

					if var_14_1 then
						global_ShowBlockWords(plot_class_data[arg_13_1.plotClassId].plot_name .. L_PLOT_EVENT_FINISH, cc.c3b(132, 239, 55))
					end
				end
			end

			local function var_14_3(arg_17_0)
				if arg_13_1.plotType == var_0_6 then
					PlotManager:receivePlot(arg_13_1.plotClassId, function(arg_18_0)
						arg_14_0.isLock = false

						if arg_18_0.result == 1 then
							-- block empty
						end
					end)
				elseif arg_13_1.plotType == var_0_7 then
					PlotManager:pushPlot(arg_13_1.plotClassId, function(arg_19_0)
						print(dump(arg_19_0))

						arg_14_0.isLock = false
						var_14_1 = arg_19_0.isFinish

						if arg_19_0.result == 1 then
							self:updateTotalRemindShowBySelf(arg_13_1)

							if arg_19_0.gold or arg_19_0.diamond or arg_19_0.items then
								local var_19_0, var_19_1, var_19_2, var_19_3, var_19_4, var_19_5, var_19_6, var_19_7 = global_get(arg_19_0)

								var_14_0 = {
									gold = var_19_0,
									diamond = var_19_1,
									honor = var_19_2,
									sp = var_19_3,
									energy = var_19_5,
									items = var_19_4,
									surecallback = var_19_6,
									cancelcallback = var_19_7
								}
							end

							if arg_17_0 then
								arg_17_0()
							end
						end
					end)
				end
			end

			if plot_data[arg_13_1.plotId].trigger_talk then
				global_basic_scene:addChild(TalkLayer:create(plot_data[arg_13_1.plotId].trigger_talk, nil, TALK_TYPE_NORMAL, "", function(arg_20_0)
					if arg_20_0 == arg_13_1.finishParam1 then
						self:setTouchEnabled(false)
						var_14_3(function()
							self:setTouchEnabled(true)
							var_14_2()
						end)
					else
						arg_14_0.isLock = false
					end
				end), ZORDER_TALKLAYER)
			else
				var_14_3()
				global_basic_scene:addChild(TalkLayer:create(arg_13_1.finishParam1, nil, TALK_TYPE_NORMAL, "", function()
					var_14_2()
				end), ZORDER_TALKLAYER)
			end
		end,
		[var_0_5.EXPLORE] = function(arg_23_0)
			if arg_23_0.isLock then
				return
			end

			arg_23_0.isLock = true

			local function var_23_0()
				require("controller.explore_manager"):begin_explore({
					type = "plot",
					plotClassId = arg_13_1.plotClassId,
					returnLayer = arg_13_1.triggerLayer
				})

				arg_23_0.isLock = false
			end

			if plot_data[arg_13_1.plotId].trigger_talk then
				global_basic_scene:addChild(TalkLayer:create(plot_data[arg_13_1.plotId].trigger_talk, nil, TALK_TYPE_NORMAL, "", function(arg_25_0)
					if arg_25_0 == arg_13_1.finishParam2 then
						var_23_0()
					else
						arg_23_0.isLock = false
					end
				end), ZORDER_TALKLAYER)
			else
				var_23_0()
			end

			AnalyticManager.click_explore_plotnpc()
		end,
		[var_0_5.ITEM] = function(arg_26_0)
			PlotManager:pushPlot(arg_13_1.plotClassId, function(arg_27_0)
				local var_27_0
				local var_27_1
				local var_27_2 = arg_27_0.isFinish

				if arg_27_0.result == 1 then
					var_27_0 = arg_13_1.finishParam3

					self:updateTotalRemindShowBySelf(arg_13_1)

					if arg_27_0.gold or arg_27_0.diamond or arg_27_0.items then
						local var_27_3, var_27_4, var_27_5, var_27_6, var_27_7, var_27_8, var_27_9, var_27_10 = global_get(arg_27_0)

						var_27_1 = {
							gold = var_27_3,
							diamond = var_27_4,
							honor = var_27_5,
							sp = var_27_6,
							energy = var_27_8,
							items = var_27_7,
							surecallback = var_27_9,
							cancelcallback = var_27_10
						}
					end
				elseif arg_27_0.result == 4 then
					var_27_0 = arg_13_1.finishParam4
				end

				global_basic_scene:addChild(TalkLayer:create(var_27_0, nil, TALK_TYPE_NORMAL, "", function()
					if var_27_1 then
						LayerManager:pushInLayer("PopPurchaseResultLayer", var_27_1)
					end

					if var_27_2 then
						global_ShowBlockWords(plot_class_data[arg_13_1.plotClassId].plot_name .. L_PLOT_EVENT_FINISH, cc.c3b(132, 239, 55))
					end
				end), ZORDER_TALKLAYER)
			end)
		end,
		[var_0_5.LEVELMODE] = function(arg_29_0)
			return
		end
	}

	var_13_0:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_13_3[arg_13_1.conditionType](arg_30_0)
	end)
end

function PlotLayer:updateTotalRemindShowBySelf(arg_31_1)
	if arg_31_1.targetLayer:find("ExploreMapLayer") then
		if LayerManager:getActiveLayerName() == "ExploreMapLayer" then
			PlotManager:removeInvalidPlotRemind(arg_31_1)

			if arg_31_1.ui then
				PlotManager:removeUI(arg_31_1)
			end

			if LayerManager:getUIElement("ExploreMapLayer").isPopExploreDifficult then
				self:exploreUpdatePlotShow(arg_31_1.targetLayer)
			else
				self:curLayerUpdatePlotShow()
			end
		end
	else
		PlotManager:removeInvalidPlotRemind(arg_31_1)
		self:curLayerUpdatePlotShow()
	end
end

function PlotLayer:curLayerUpdatePlotShow()
	local var_32_0 = LayerManager:getCurrentLayerName()

	self:clean_all()
	self:updatePlotNpc(var_32_0)
	self:updatePlotUI(var_32_0)
	self:updatePlotRemind(var_32_0)
	LayerManager:getUIElement("ListButton"):updatePlotRemind()
end

function PlotLayer:clean_all()
	self.npcLayer:removeAllChildren()
	self.uiLayer:removeAllChildren()
end

function PlotLayer:setTouchEnabled(arg_34_1)
	self.touchLayer:setTouchEnabled(arg_34_1)
end
