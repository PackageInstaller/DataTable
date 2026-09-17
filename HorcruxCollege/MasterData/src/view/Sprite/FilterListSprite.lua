FilterListSprite = class("FilterListSprite", function()
	return cc.Node:create()
end)

local filter_config_manager = require("controller.filter_config_manager")
local lab_recipe_conf_data = require("data.lab_recipe_conf_data")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = filter_config_manager.ConfigTable
local var_0_5 = filter_config_manager.BagConfig
local var_0_6 = cc.c4b(11, 79, 247, 150)
local var_0_7 = cc.c4b(200, 59, 239, 150)

function FilterListSprite.create(arg_2_0, arg_2_1)
	local var_2_0 = FilterListSprite.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function FilterListSprite:init(arg_3_1)
	self.initParam = arg_3_1
	self.defaultSelected = arg_3_1.defaultSelected or 1
	self.bagLayerType = arg_3_1.bagLayerType
	self.style = arg_3_1.style
	self.tab = arg_3_1.tab
	self.filterCallback = arg_3_1.filterCallback or function()
		print("没有传入对应的按钮点击事件")
	end
	self.defaultFilter = arg_3_1.defaultFilter

	self:initData()

	self.btnState[self.defaultSelected] = 1

	self:initUI()
	self:setDefaultFilter()
end

function FilterListSprite:setPercent()
	percent = self.defaultSelected < #self.btnState / 2 and (self.defaultSelected - 1) / #self.btnState * 100 or self.defaultSelected / #self.btnState * 100

	if self.defaultSelected == 1 and #self.btnState > 5 then
		percent = 20
	end

	local var_5_0 = {}

	if var_5_0[self.style] then
		var_5_0[self.style]()
	else
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
			self.listView:jumpToPercentVertical(percent)
		end)))
	end
end

function FilterListSprite:initUI()
	local var_7_0 = {
		style_horcrux_bag = function()
			self.rootLayer = cc.Layer:create()

			self.rootLayer:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
			self:addChild(self.rootLayer)
			self:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
			;(function()
				self.listView = ccui.ListView:create()

				self.listView:setName("listView")
				self.listView:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height - 100))
				self.listView:setPositionY(self.listView:getPositionY() + 100)
				self.listView:setDirection(ccui.ListViewDirection.vertical)
				self.rootLayer:addChild(self.listView)
				self.listView:setBounceEnabled(true)
			end)()
			;(function()
				local var_10_0 = {}

				table.insert(var_10_0, "public/filter/filter_horcrux_bag_all_normal.png")

				for iter_10_0, iter_10_1 in pairs(ATTR_HORCRUX_LIST) do
					local var_10_1 = type(iter_10_1) == "number" and ATTR_ID[iter_10_1] or iter_10_1

					table.insert(var_10_0, (self:getFilterPicPath(var_10_1 .. "_normal")))
				end

				for iter_10_2 = 1, #self.btnKey do
					local var_10_3 = ccui.Button:create(var_10_0[iter_10_2], var_10_0[iter_10_2], var_10_0[iter_10_2], var_0_3)

					var_10_3:setName("filter_list_bnt" .. iter_10_2)

					var_10_3.index = iter_10_2

					var_10_3:setTouchEnabled(true)

					self.btnObjList[iter_10_2] = var_10_3

					var_10_3:addTouchEventListener(function(arg_11_0, arg_11_1)
						if arg_11_1 ~= ccui.TouchEventType.ended then
							return
						end

						self:btnTouchEvent(arg_11_0)
					end)
					self.listView:pushBackCustomItem(var_10_3)

					if iter_10_2 == #self.btnKey then
						local var_10_4 = var_10_3:clone()

						var_10_4:setVisible(false)
						self.listView:pushBackCustomItem(var_10_4)
					end
				end
			end)()
			self:updateAllBtn()
		end,
		style_horcrux_bag_new = function()
			local var_12_0 = 65

			self.rootLayer = cc.Layer:create()

			self.rootLayer:setContentSize(cc.size(GameDisplay.width, 65))
			self:addChild(self.rootLayer)
			self:setContentSize(cc.size(GameDisplay.width, 65))
			;(function()
				self.listView = ccui.ListView:create()

				self.listView:setName("listView")
				self.listView:setContentSize(cc.size(GameDisplay.width, var_12_0))
				self.listView:setBackGroundImage("public/filter/filter_horcrux_bag_quick_bg.png", var_0_3)
				self.listView:setDirection(ccui.ListViewDirection.horizontal)
				self.rootLayer:addChild(self.listView)

				local var_13_0 = TempWidget:CreateTempLayout()

				var_13_0:setContentSize(cc.size(10, self.listView:getContentSize().height))
				self.listView:pushBackCustomItem(var_13_0)
			end)()
			;(function()
				local var_14_0 = {}

				table.insert(var_14_0, "public/filter/filter_horcrux_bag_new_all_normal.png")

				for iter_14_0, iter_14_1 in pairs(ATTR_HORCRUX_LIST) do
					local var_14_1 = type(iter_14_1) == "number" and ATTR_ID[iter_14_1] or iter_14_1

					table.insert(var_14_0, (self:getFilterPicPath("new_" .. var_14_1 .. "_normal")))
				end

				for iter_14_2 = 1, #self.btnKey do
					local var_14_3 = TempWidget:CreateTempLayout()

					var_14_3:setContentSize(cc.size(62, var_12_0))

					local var_14_4 = TempWidget:CreateTempImg("public/filter/filter_horcrux_bag_new_selecting.png", var_14_3)

					var_14_4:setOpacity(0)
					var_14_4:setName("selecting")
					var_14_4:align(cc.p(0.5, 0), var_14_3:property().top_bottom)

					local var_14_5 = ccui.Button:create(var_14_0[iter_14_2], var_14_0[iter_14_2], var_14_0[iter_14_2], var_0_3)

					var_14_5.selecting = var_14_4

					var_14_5:setName("filter_list_bnt" .. iter_14_2)

					var_14_5.index = iter_14_2

					var_14_5:setTouchEnabled(true)

					self.btnObjList[iter_14_2] = var_14_5

					var_14_5:addTouchEventListener(function(arg_15_0, arg_15_1)
						if arg_15_1 ~= ccui.TouchEventType.ended then
							return
						end

						self:btnTouchEvent(arg_15_0)
					end)
					var_14_5:setAnchorPoint(0.5, 0.5)
					var_14_5:setPosition(cc.p(var_14_3:getContentSize().width / 2, var_14_3:getContentSize().height / 2))
					var_14_3:addChild(var_14_5)

					local var_14_6 = ccui.ImageView:create("public/filter/filter_horcrux_bag_stall.png", var_0_3)

					var_14_3:addChild(var_14_6)
					var_14_6:setAnchorPoint(cc.p(0.5, 0.5))
					var_14_6:setPosition(cc.p(0, var_14_3:getContentSize().height / 2))

					if iter_14_2 == #self.btnKey then
						local var_14_7 = ccui.ImageView:create("public/filter/filter_horcrux_bag_stall.png", var_0_3)

						var_14_3:addChild(var_14_7)
						var_14_7:setAnchorPoint(cc.p(0.5, 0.5))
						var_14_7:setPosition(cc.p(var_14_3:getContentSize().width, var_14_3:getContentSize().height / 2))
					end

					self.listView:pushBackCustomItem(var_14_3)
				end
			end)()
			self:updateAllBtn()
		end,
		style_furniture = function()
			local function var_16_0(arg_18_0)
				local var_18_1 = cc.Label:createWithTTF(self.btnText[arg_18_0], FONT_NAME, 30)
				local var_18_2
				local var_18_3 = string.format("DormitoryFixturesLayer/filter_dormitory_on%d.png", arg_18_0)
				local var_18_4 = string.format("DormitoryFixturesLayer/filter_dormitory_off%d.png", arg_18_0)

				if self.btnState[arg_18_0] == 1 then
					var_18_2 = ccui.Button:create(var_18_3, var_18_3, var_18_3, var_0_3)

					var_18_1:enableOutline(var_0_7, 1)
					var_18_1:enableShadow(var_0_7, cc.size(0, 0))
				elseif self.btnState[arg_18_0] == 0 then
					var_18_2 = ccui.Button:create(var_18_4, var_18_4, var_18_4, var_0_3)

					var_18_1:enableOutline(var_0_6, 1)
					var_18_1:enableShadow(var_0_6, cc.size(0, 0))
				else
					var_18_2 = ccui.Button:create("public/filter/selected_tab_mid.png", "public/filter/selected_tab_mid.png", "public/filter/selected_tab_mid.png", var_0_3)

					var_18_1:enableOutline(var_0_6, 1)
					var_18_1:enableShadow(var_0_6, cc.size(0, 0))
				end

				var_18_2:setName("filter_list_bnt" .. arg_18_0)

				var_18_2.index = arg_18_0

				var_18_2:setTouchEnabled(true)

				self.btnObjList[arg_18_0] = var_18_2

				var_18_2:addTouchEventListener(function(arg_19_0, arg_19_1)
					if arg_19_1 ~= ccui.TouchEventType.ended then
						return
					end

					self:btnTouchEvent(arg_19_0)
				end)
				var_18_1:setPositionX(var_18_2:getContentSize().width / 2)
				var_18_1:setPositionY(var_18_2:getContentSize().height / 2)
				var_18_1:setMaxLineWidth(32)
				var_18_1:setName("label")
				var_18_1:setVisible(false)
				TempWidget:CreateTempLayout():setContentSize(cc.size(113, 36))
				var_18_2:addChild(var_18_1)
				self.listView:pushBackCustomItem(var_18_2)
			end

			local function var_16_1(arg_20_0)
				self.btnState[#self.btnText + 1] = 0

				local var_20_0 = cc.Label:createWithTTF(L_SUIT, FONT_NAME, 30)
				local var_20_1 = string.format("DormitoryFixturesLayer/filter_dormitory_off%d.png", arg_20_0)
				local var_20_2 = ccui.Button:create(var_20_1, var_20_1, var_20_1, var_0_3)

				var_20_0:enableOutline(var_0_6, 1)
				var_20_0:enableShadow(var_0_6, cc.size(0, 0))
				var_20_2:setName("filter_list_bnt" .. #self.btnText + 1)

				var_20_2.index = #self.btnText + 1

				var_20_2:setTouchEnabled(true)

				self.btnObjList[#self.btnText + 1] = var_20_2

				var_20_2:addTouchEventListener(function(arg_21_0, arg_21_1)
					if arg_21_1 ~= ccui.TouchEventType.ended then
						return
					end

					self:setTouchFlag(true)

					for iter_21_0, iter_21_1 in pairs(self.btnState) do
						if iter_21_1 == 1 then
							self.btnState[iter_21_0] = 0
						end
					end

					self.btnState[arg_21_0.index] = 1

					self:updateAllBtn()

					if self.filterCallback then
						self.filterCallback({
							furniture_suit = true
						})
					end
				end)
				var_20_0:setPositionX(var_20_2:getContentSize().width / 2)
				var_20_0:setPositionY(var_20_2:getContentSize().height / 2)
				var_20_0:setMaxLineWidth(32)
				var_20_0:setName("label")
				var_20_0:setVisible(false)
				TempWidget:CreateTempLayout():setContentSize(cc.size(50, 174))
				var_20_2:addChild(var_20_0)
				self.listView:pushBackCustomItem(var_20_2)
			end

			self.rootLayer = cc.Layer:create()

			self.rootLayer:setContentSize(cc.size(640, 36))
			self:addChild(self.rootLayer)
			self:setContentSize(cc.size(640, 36))
			;(function()
				self.listView = ccui.ListView:create()

				self.listView:setName("listView")
				self.listView:setContentSize(cc.size(640, 36))
				self.listView:setDirection(ccui.ListViewDirection.horizontal)
				self.rootLayer:addChild(self.listView)
				self.listView:setBounceEnabled(true)
			end)()

			for iter_16_0 = 1, #self.btnText + 1 do
				if iter_16_0 == 1 then
					var_16_0(iter_16_0)
				elseif iter_16_0 == 2 then
					var_16_1(iter_16_0 + 5)
				else
					var_16_0(iter_16_0 - 1)
				end
			end
		end,
		style_lab_recipe = function()
			self.rootLayer = cc.Layer:create()

			self.rootLayer:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
			self:addChild(self.rootLayer)
			self:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
			;(function()
				self.listView = ccui.ListView:create()

				self.listView:setName("listView")
				self.listView:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
				self.listView:setDirection(ccui.ListViewDirection.vertical)
				self.rootLayer:addChild(self.listView)
				self.listView:setBounceEnabled(true)
			end)()
			;(function()
				local var_24_0 = {}

				while lab_recipe_conf_data.recipe[1] do
					table.insert(var_24_0, lab_recipe_conf_data.recipe[1].path)
				end

				local var_24_2 = #self.btnKey

				for iter_24_0 = 1, #self.btnKey do
					local var_24_3 = ccui.Button:create(var_24_0[self.btnKey[iter_24_0]], var_24_0[self.btnKey[iter_24_0]], var_24_0[self.btnKey[iter_24_0]], var_0_3)

					var_24_3:setName("filter_list_bnt" .. iter_24_0)

					var_24_3.index = iter_24_0

					var_24_3:setTouchEnabled(true)

					self.btnObjList[iter_24_0] = var_24_3

					var_24_3:addTouchEventListener(function(arg_25_0, arg_25_1)
						if arg_25_1 ~= ccui.TouchEventType.ended then
							return
						end

						self:btnTouchEvent(arg_25_0)
					end)
					self.listView:pushBackCustomItem(var_24_3)

					if iter_24_0 == var_24_2 then
						local var_24_4 = var_24_3:clone()

						var_24_4:setVisible(false)
						self.listView:pushBackCustomItem(var_24_4)
					end
				end
			end)()
			self:updateAllBtn()
		end,
		style_lab_research = function(arg_26_0)
			self.rootLayer = cc.Layer:create()

			self.rootLayer:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
			self:addChild(self.rootLayer)
			self:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
			;(function()
				self.listView = ccui.ListView:create()

				self.listView:setName("listView")
				self.listView:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
				self.listView:setDirection(ccui.ListViewDirection.vertical)
				self.rootLayer:addChild(self.listView)
				self.listView:setBounceEnabled(true)
			end)()
			;(function()
				local var_28_0 = {}

				while lab_recipe_conf_data.research[arg_26_0][1] do
					table.insert(var_28_0, lab_recipe_conf_data.research[arg_26_0][1].path)
				end

				local var_28_2 = #var_28_0

				for iter_28_0 = 1, #var_28_0 do
					local var_28_3 = ccui.Button:create(var_28_0[self.btnKey[iter_28_0]], var_28_0[self.btnKey[iter_28_0]], var_28_0[self.btnKey[iter_28_0]], var_0_3)

					var_28_3:setName("filter_list_bnt" .. iter_28_0)

					var_28_3.index = lab_recipe_conf_data.research[arg_26_0][iter_28_0].id

					var_28_3:setTouchEnabled(true)

					self.btnObjList[iter_28_0] = var_28_3

					var_28_3:addTouchEventListener(function(arg_29_0, arg_29_1)
						if arg_29_1 ~= ccui.TouchEventType.ended then
							return
						end

						self:btnTouchEvent(arg_29_0)
					end)
					self.listView:pushBackCustomItem(var_28_3)

					if iter_28_0 == var_28_2 then
						local var_28_4 = var_28_3:clone()

						var_28_4:setVisible(false)
						self.listView:pushBackCustomItem(var_28_4)
					end
				end
			end)()
			self:updateAllBtn()
		end,
		style_major_filter = function()
			self.rootLayer = cc.Layer:create()

			self.rootLayer:setContentSize(cc.size(640, 36))
			self:addChild(self.rootLayer)
			self:setContentSize(cc.size(640, 36))
			;(function()
				self.listView = ccui.ListView:create()

				self.listView:setName("listView")
				self.listView:setContentSize(cc.size(640, 36))
				self.listView:setDirection(ccui.ListViewDirection.horizontal)
				self.rootLayer:addChild(self.listView)
				self.listView:setBounceEnabled(true)
			end)()
			;(function()
				local var_32_0 = {
					"public/filter/filter_servant_bag_all_normal.png",
					"public/filter/filter_major_normal.png",
					"public/filter/filter_npc_normal.png"
				}

				for iter_32_0 = 1, #self.btnKey do
					local var_32_1 = ccui.Button:create(var_32_0[self.btnKey[iter_32_0]], var_32_0[self.btnKey[iter_32_0]], var_32_0[self.btnKey[iter_32_0]], var_0_3)

					var_32_1:setName("filter_list_bnt" .. iter_32_0)

					var_32_1.index = iter_32_0

					var_32_1:setTouchEnabled(true)

					self.btnObjList[iter_32_0] = var_32_1

					var_32_1:addTouchEventListener(function(arg_33_0, arg_33_1)
						if arg_33_1 ~= ccui.TouchEventType.ended then
							return
						end

						self:btnTouchEvent(arg_33_0)
					end)
					self.listView:pushBackCustomItem(var_32_1)

					if iter_32_0 == #self.btnKey then
						local var_32_2 = var_32_1:clone()

						var_32_2:setVisible(false)
						self.listView:pushBackCustomItem(var_32_2)
					end
				end
			end)()
			self:updateAllBtn()
		end,
		style_spring_task = function()
			self.rootLayer = cc.Layer:create()

			self.rootLayer:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
			self:addChild(self.rootLayer)
			self:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
			;(function()
				self.listView = ccui.ListView:create()

				self.listView:setName("listView")
				self.listView:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
				self.listView:setDirection(ccui.ListViewDirection.vertical)
				self.rootLayer:addChild(self.listView)
				self.listView:setBounceEnabled(true)
			end)()
			;(function()
				local var_36_0 = {
					"public/filter/spring_task.png",
					"public/filter/spring_quickfight.png",
					"public/filter/spring_midas.png",
					"public/filter/spring_pifu.png",
					"public/filter/spring_egg.png"
				}

				for iter_36_0 = 1, #self.btnKey do
					local var_36_1 = ccui.Button:create(var_36_0[self.btnKey[iter_36_0]], var_36_0[self.btnKey[iter_36_0]], var_36_0[self.btnKey[iter_36_0]], var_0_3)

					var_36_1:setName("filter_list_bnt" .. iter_36_0)

					var_36_1.index = iter_36_0

					var_36_1:setTouchEnabled(true)

					self.btnObjList[iter_36_0] = var_36_1

					var_36_1:addTouchEventListener(function(arg_37_0, arg_37_1)
						if arg_37_1 ~= ccui.TouchEventType.ended then
							return
						end

						self:btnTouchEvent(arg_37_0)
					end)
					self.listView:pushBackCustomItem(var_36_1)

					if iter_36_0 == #self.btnKey then
						local var_36_2 = var_36_1:clone()

						var_36_2:setVisible(false)
						self.listView:pushBackCustomItem(var_36_2)
					end
				end
			end)()
			self:updateAllBtn()
		end,
		style_lantern_task = function()
			self.rootLayer = cc.Layer:create()

			self.rootLayer:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
			self:addChild(self.rootLayer)
			self:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
			;(function()
				self.listView = ccui.ListView:create()

				self.listView:setName("listView")
				self.listView:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
				self.listView:setDirection(ccui.ListViewDirection.vertical)
				self.rootLayer:addChild(self.listView)
				self.listView:setBounceEnabled(true)
			end)()
			;(function()
				local var_40_0 = {
					[1] = "Activity_LanternFestivalLayer/select_1_black.png",
					[2] = "Activity_LanternFestivalLayer/select_2_black.png"
				}

				for iter_40_0 = 1, #self.btnKey do
					local var_40_1 = ccui.Button:create(var_40_0[self.btnKey[iter_40_0]], var_40_0[self.btnKey[iter_40_0]], var_40_0[self.btnKey[iter_40_0]], var_0_3)

					var_40_1:setName("filter_list_bnt" .. iter_40_0)

					var_40_1.index = iter_40_0

					var_40_1:setTouchEnabled(true)

					self.btnObjList[iter_40_0] = var_40_1

					var_40_1:addTouchEventListener(function(arg_41_0, arg_41_1)
						if arg_41_1 ~= ccui.TouchEventType.ended then
							return
						end

						self:btnTouchEvent(arg_41_0)
					end)
					self.listView:pushBackCustomItem(var_40_1)

					if iter_40_0 == #self.btnKey then
						local var_40_2 = var_40_1:clone()

						var_40_2:setVisible(false)
						self.listView:pushBackCustomItem(var_40_2)
					end
				end
			end)()
			self:updateAllBtn()
		end,
		style_lamia_task = function()
			self.rootLayer = cc.Layer:create()

			self.rootLayer:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
			self:addChild(self.rootLayer)
			self:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
			;(function()
				self.listView = ccui.ListView:create()

				self.listView:setName("listView")
				self.listView:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
				self.listView:setDirection(ccui.ListViewDirection.vertical)
				self.rootLayer:addChild(self.listView)
				self.listView:setBounceEnabled(true)
			end)()
			;(function()
				local var_44_0 = {
					[1] = "Activity_lamia/select_2_black.png",
					[2] = "Activity_lamia/select_1_black.png"
				}

				for iter_44_0 = 1, #self.btnKey do
					local var_44_1 = ccui.Button:create(var_44_0[self.btnKey[iter_44_0]], var_44_0[self.btnKey[iter_44_0]], var_44_0[self.btnKey[iter_44_0]], var_0_3)

					var_44_1:setName("filter_list_bnt" .. iter_44_0)

					var_44_1.index = iter_44_0

					var_44_1:setTouchEnabled(true)

					self.btnObjList[iter_44_0] = var_44_1

					var_44_1:addTouchEventListener(function(arg_45_0, arg_45_1)
						if arg_45_1 ~= ccui.TouchEventType.ended then
							return
						end

						self:btnTouchEvent(arg_45_0)
					end)
					self.listView:pushBackCustomItem(var_44_1)

					if iter_44_0 == #self.btnKey then
						local var_44_2 = var_44_1:clone()

						var_44_2:setVisible(false)
						self.listView:pushBackCustomItem(var_44_2)
					end
				end
			end)()
			self:updateAllBtn()
		end,
		style_servant_attr = function()
			self.rootLayer = cc.Layer:create()

			self.rootLayer:setContentSize(cc.size(640, 36))
			self:addChild(self.rootLayer)
			self:setContentSize(cc.size(640, 36))
			;(function()
				self.listView = ccui.ListView:create()

				self.listView:setName("listView")
				self.listView:setContentSize(cc.size(640, 36))
				self.listView:setDirection(ccui.ListViewDirection.horizontal)
				self.rootLayer:addChild(self.listView)
				self.listView:setBounceEnabled(true)
			end)()
			;(function()
				local var_48_0 = {}

				table.insert(var_48_0, "public/filter/filter_servant_bag_all_normal.png")

				for iter_48_0, iter_48_1 in pairs((filter_config_manager:getServantFilterOrder())) do
					table.insert(var_48_0, (self:getServantPicPath(iter_48_1 .. "_normal")))
				end

				for iter_48_2 = 1, #self.btnKey do
					local var_48_1 = ccui.Button:create(var_48_0[iter_48_2], var_48_0[iter_48_2], var_48_0[iter_48_2], var_0_3)

					var_48_1:setName("filter_list_bnt" .. iter_48_2)

					var_48_1.index = iter_48_2

					var_48_1:setTouchEnabled(true)

					self.btnObjList[iter_48_2] = var_48_1

					var_48_1:addTouchEventListener(function(arg_49_0, arg_49_1)
						if arg_49_1 ~= ccui.TouchEventType.ended then
							return
						end

						self:btnTouchEvent(arg_49_0)
					end)
					self.listView:pushBackCustomItem(var_48_1)

					if iter_48_2 == #self.btnKey then
						local var_48_2 = var_48_1:clone()

						var_48_2:setVisible(false)
						self.listView:pushBackCustomItem(var_48_2)
					end
				end
			end)()
			self:updateAllBtn()
		end,
		style_servant_attr_new = function()
			self.rootLayer = cc.Layer:create()

			self.rootLayer:setContentSize(cc.size(640, 36))
			self:addChild(self.rootLayer)
			self:setContentSize(cc.size(640, 36))
			;(function()
				self.listView = ccui.ListView:create()

				self.listView:setName("listView")
				self.listView:setContentSize(cc.size(640, 36))
				self.listView:setDirection(ccui.ListViewDirection.horizontal)
				self.rootLayer:addChild(self.listView)
				self.listView:setBounceEnabled(true)
			end)()
			;(function()
				local var_52_0 = {}
				local var_52_1 = {}

				table.insert(var_52_0, L_QUICKFORMATIONLAYER.ALL)
				table.insert(var_52_1, string.format("public/filter/quick_formation_off_img_%s.png", "all"))

				for iter_52_0 = 1, #filter_config_manager:getServantFilterOrder() do
					table.insert(var_52_0, L_QUICKFORMATIONLAYER.MAPTEXT[self.btnKey[iter_52_0 + 1]])
					table.insert(var_52_1, string.format("public/filter/quick_formation_off_img_%s.png", self.btnKey[iter_52_0 + 1]))
				end

				local var_52_2 = #self.btnText

				for iter_52_1 = 1, #self.btnText do
					local var_52_3 = TempWidget:CreateTempBtn("public/filter/quick_formation_filter_off.png")

					var_52_3:setName("filter_list_bnt" .. iter_52_1)

					var_52_3.index = iter_52_1

					var_52_3:setTouchEnabled(true)

					self.btnObjList[iter_52_1] = var_52_3

					var_52_3:addTouchEventListener(function(arg_53_0, arg_53_1)
						if arg_53_1 ~= ccui.TouchEventType.ended then
							return
						end

						self:btnTouchEvent(arg_53_0)
					end)

					var_52_3._key = iter_52_1 == 1 and "all" or self.btnKey[iter_52_1]

					TempWidget:CreateTempLabel(self.btnText[iter_52_1], FONT_NAME, 20, var_52_3):align(cc.p(0.5, 0.5), var_52_3:size().w / 2 + 20, var_52_3:size().h / 2)

					local var_52_4 = TempWidget:CreateTempImg(var_52_1[iter_52_1], var_52_3)

					var_52_4:align(cc.p(0, 0.5), 0, var_52_3:size().h / 2)

					var_52_3._img = var_52_4

					self.listView:pushBackCustomItem(var_52_3)

					if iter_52_1 == var_52_2 then
						local var_52_5 = var_52_3:clone()

						var_52_5:setVisible(false)
						self.listView:pushBackCustomItem(var_52_5)
					end
				end
			end)()
			self:updateAllBtn()
		end
	}

	if var_7_0[self.style] then
		var_7_0[self.style](self.tab)
	else
		self.rootLayer = cc.Layer:create()

		self.rootLayer:setContentSize(cc.size(52, GameDisplay.getUiScreenSize().height))
		self.rootLayer:setName("rootLayer")
		self:addChild(self.rootLayer)

		if self.style == "style_parts" then
			self:setContentSize(cc.size(GameDisplay.width, 65))
			self:createPartsListView()
			self:createPartsBtn()
		else
			self:setContentSize(cc.size(52, GameDisplay.getUiScreenSize().height))
			self:createListView()
			self:createBtn()
		end
	end
end

function FilterListSprite:initData()
	self.btnKey = {}
	self.btnState = {}
	self.btnText = {}
	self.btnObjList = {}

	if not self.initParam.hideAll then
		self.btnKey[#self.btnKey + 1] = "all"
		self.btnState[#self.btnState + 1] = 0
		self.btnText[#self.btnText + 1] = L_ALL
	end

	self.filterKey = var_0_4[self.bagLayerType].filter_key[var_0_5[self.bagLayerType].index]

	for iter_54_0, iter_54_1 in pairs((self.initParam.lock_ele_type or nil) and self.initParam.lock_ele_type) do
		self.btnKey[#self.btnKey + 1] = iter_54_1
		self.btnState[#self.btnState + 1] = 0
		self.btnText[#self.btnText + 1] = var_0_4[self.bagLayerType].filter_str[var_0_5[self.bagLayerType].index][iter_54_1]
	end
end

function FilterListSprite:createListView()
	self.listView = ccui.ListView:create()

	self.listView:setName("listView")
	self.listView:setContentSize(cc.size(66, GameDisplay.getUiScreenSize().height))
	self.listView:setDirection(ccui.ListViewDirection.vertical)
	self.listView:setBounceEnabled(true)
	self.rootLayer:addChild(self.listView)
end

function FilterListSprite:createPartsListView()
	self.listView = ccui.ListView:create()

	self.listView:setName("listView")
	self.listView:setContentSize(cc.size(GameDisplay.width, 65))
	self.listView:setBackGroundImage("public/filter/filter_horcrux_bag_quick_bg.png", var_0_3)
	self.listView:setPositionY(self.listView:getPositionY() + 70)
	self.listView:setDirection(ccui.ListViewDirection.horizontal)
	self.rootLayer:addChild(self.listView, 10)

	local var_56_0 = TempWidget:CreateTempLayout()

	var_56_0:setContentSize(cc.size(10, self.listView:getContentSize().height))
	self.listView:pushBackCustomItem(var_56_0)
end

function FilterListSprite:createBtn()
	local var_57_0 = #self.btnText

	for iter_57_0 = 1, #self.btnText do
		local var_57_1 = cc.Label:createWithTTF(self.btnText[iter_57_0], FONT_NAME, 30)
		local var_57_2

		if self.btnState[iter_57_0] == 1 then
			var_57_2 = ccui.Button:create("public/filter/selected_tab_top_on.png", "public/filter/selected_tab_top_on.png", "public/filter/selected_tab_top_on.png", var_0_3)

			var_57_1:enableOutline(var_0_7, 1)
			var_57_1:enableShadow(var_0_7, cc.size(0, 0))
		elseif self.btnState[iter_57_0] == 0 then
			var_57_2 = ccui.Button:create("public/filter/selected_tab_mid.png", "public/filter/selected_tab_mid.png", "public/filter/selected_tab_mid.png", var_0_3)

			var_57_1:enableOutline(var_0_6, 1)
			var_57_1:enableShadow(var_0_6, cc.size(0, 0))
		else
			var_57_2 = ccui.Button:create("public/filter/selected_tab_mid.png", "public/filter/selected_tab_mid.png", "public/filter/selected_tab_mid.png", var_0_3)

			var_57_1:enableOutline(var_0_6, 1)
			var_57_1:enableShadow(var_0_6, cc.size(0, 0))
		end

		var_57_2:setName("filter_list_bnt" .. iter_57_0)

		var_57_2.index = iter_57_0

		var_57_2:setTouchEnabled(true)

		self.btnObjList[iter_57_0] = var_57_2

		var_57_2:setPositionX(self.rootLayer:getContentSize().width * (iter_57_0 * 2 - 1) / var_57_0 / 2)
		var_57_2:setPositionY(self.rootLayer:getContentSize().height / 2)
		var_57_2:addTouchEventListener(function(arg_58_0, arg_58_1)
			if arg_58_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:btnTouchEvent(arg_58_0)
		end)
		var_57_1:setVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_57_1:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_57_1:setPositionX(var_57_2:getContentSize().width / 2)
		var_57_1:setPositionY(var_57_2:getContentSize().height / 2)
		var_57_1:setMaxLineWidth(32)
		var_57_1:setName("label")
		var_57_2:addChild(var_57_1)
		self.listView:pushBackCustomItem(var_57_2)

		if iter_57_0 == var_57_0 then
			local var_57_3 = var_57_2:clone()

			var_57_3:setVisible(false)
			self.listView:pushBackCustomItem(var_57_3)
		end
	end
end

function FilterListSprite:createPartsBtn()
	local var_59_0 = #self.btnText

	for iter_59_0 = 1, #self.btnText do
		local var_59_1 = cc.Label:createWithTTF(self.btnText[iter_59_0], FONT_NAME, 30)

		var_59_1:setVisible(false)

		local var_59_2

		if self.btnState[iter_59_0] == 1 then
			var_59_2 = ccui.Button:create("public/filter/filter_parts_on_" .. iter_59_0 .. ".png", "public/filter/filter_parts_on_" .. iter_59_0 .. ".png", "public/filter/filter_parts_on_" .. iter_59_0 .. ".png", var_0_3)

			var_59_1:enableOutline(var_0_7, 1)
			var_59_1:enableShadow(var_0_7, cc.size(0, 0))
		elseif self.btnState[iter_59_0] == 0 then
			var_59_2 = ccui.Button:create("public/filter/filter_parts_off_" .. iter_59_0 .. ".png", "public/filter/filter_parts_off_" .. iter_59_0 .. ".png", "public/filter/filter_parts_off_" .. iter_59_0 .. ".png", var_0_3)

			var_59_1:enableOutline(var_0_6, 1)
			var_59_1:enableShadow(var_0_6, cc.size(0, 0))
		else
			var_59_2 = ccui.Button:create("public/filter/filter_parts_off_" .. iter_59_0 .. ".png", "public/filter/filter_parts_off_" .. iter_59_0 .. ".png", "public/filter/filter_parts_off_" .. iter_59_0 .. ".png", var_0_3)

			var_59_1:enableOutline(var_0_6, 1)
			var_59_1:enableShadow(var_0_6, cc.size(0, 0))
		end

		var_59_2:setName("filter_list_bnt" .. iter_59_0)

		var_59_2.index = iter_59_0

		var_59_2:setTouchEnabled(true)

		self.btnObjList[iter_59_0] = var_59_2

		var_59_2:addTouchEventListener(function(arg_60_0, arg_60_1)
			if arg_60_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:btnTouchEvent(arg_60_0)
		end)
		var_59_1:setVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_59_1:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_59_1:setPositionX(var_59_2:getContentSize().width / 2)
		var_59_1:setPositionY(var_59_2:getContentSize().height / 2)
		var_59_1:setMaxLineWidth(32)
		var_59_1:setName("label")
		var_59_2:addChild(var_59_1)

		local var_59_3 = TempWidget:CreateTempLayout()

		var_59_3:setContentSize(cc.size(62, self.listView:getContentSize().height))

		local var_59_4 = TempWidget:CreateTempImg("public/filter/filter_horcrux_bag_new_selecting.png", var_59_3)

		var_59_4:setOpacity(0)
		var_59_4:setName("selecting")
		var_59_4:align(cc.p(0.5, 0), var_59_3:property().top_bottom)

		var_59_2.selecting = var_59_4

		var_59_3:addChild(var_59_2)
		var_59_2:setPosition(var_59_3:property().center.x, var_59_3:property().center.y)

		local var_59_5 = ccui.ImageView:create("public/filter/filter_horcrux_bag_stall.png", var_0_3)

		var_59_3:addChild(var_59_5)
		var_59_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_59_5:setPosition(cc.p(0, var_59_3:getContentSize().height / 2))

		if iter_59_0 == var_59_0 then
			local var_59_6 = ccui.ImageView:create("public/filter/filter_horcrux_bag_stall.png", var_0_3)

			var_59_3:addChild(var_59_6)
			var_59_6:setAnchorPoint(cc.p(0.5, 0.5))
			var_59_6:setPosition(cc.p(var_59_3:getContentSize().width, var_59_3:getContentSize().height / 2))
		end

		self.listView:pushBackCustomItem(var_59_3)
	end
end

function FilterListSprite:btnTouchEvent(arg_61_1)
	for iter_61_0, iter_61_1 in pairs(self.btnState) do
		if iter_61_1 == 1 and iter_61_0 == arg_61_1.index then
			return
		end
	end

	self:setTouchFlag(true)

	for iter_61_2, iter_61_3 in pairs(self.btnState) do
		if iter_61_3 == 1 then
			self.btnState[iter_61_2] = 0
		end
	end

	self.btnState[arg_61_1.index] = 1

	self:updateAllBtn()

	if self.filterCallback then
		self.filterCallback((self:getFilterData()))
	end
end

function FilterListSprite:setFilterData(arg_62_1)
	for iter_62_0, iter_62_1 in pairs(self.btnState) do
		if iter_62_1 == 1 and iter_62_0 == arg_62_1 then
			return
		end
	end

	self:setTouchFlag(true)

	for iter_62_2, iter_62_3 in pairs(self.btnState) do
		if iter_62_3 == 1 then
			self.btnState[iter_62_2] = 0
		end
	end

	self.btnState[arg_62_1] = 1

	self:setTouchFlag(false)
	self:updateAllBtn()
end

function FilterListSprite:setDefaultFilter(...)
	if self.defaultFilter then
		local function var_63_0(arg_64_0, arg_64_1)
			for iter_64_0, iter_64_1 in pairs(arg_64_0) do
				if iter_64_1 == arg_64_1 then
					return true
				end
			end

			return false
		end

		if self.style == "style_servant_attr" then
			local var_63_1 = false

			for iter_63_0, iter_63_1 in pairs(filter_config_manager.ConfigTable[filter_config_manager.SERVANT].filter_table[1]) do
				if var_63_0(self.defaultFilter.filterConfig.attr, iter_63_1) then
					self.btnState[iter_63_0 + 1] = 1
					var_63_1 = true
				else
					self.btnState[iter_63_0 + 1] = 0
				end
			end

			self.btnState[1] = not var_63_1 and 1 or 0

			self:updateAllBtn()
		elseif self.style == "style_servant_attr_new" then
			local var_63_2 = false

			for iter_63_2, iter_63_3 in pairs(filter_config_manager.ConfigTable[filter_config_manager.SERVANT].filter_table[1]) do
				if var_63_0(self.defaultFilter.filterConfig.attr, iter_63_3) then
					self.btnState[iter_63_2 + 1] = 1
					var_63_2 = true
				else
					self.btnState[iter_63_2 + 1] = 0
				end
			end

			self.btnState[1] = not var_63_2 and 1 or 0

			self:updateAllBtn()
		end
	end
end

function FilterListSprite:updateAllBtn()
	local var_65_0 = {
		style_horcrux_bag = function()
			local var_66_0 = {}
			local var_66_1 = {}

			table.insert(var_66_0, "public/filter/filter_horcrux_bag_all_normal.png")
			table.insert(var_66_1, "public/filter/filter_horcrux_bag_all_on.png")

			for iter_66_0, iter_66_1 in pairs(ATTR_HORCRUX_LIST) do
				local var_66_2

				if type(iter_66_1) == "number" then
					var_66_2 = ATTR_ID[iter_66_1]
				end

				local var_66_3

				do
					var_66_2 = iter_66_1
					var_66_3 = self:getFilterPicPath(var_66_2 .. "_on")
				end

				table.insert(var_66_0, (self:getFilterPicPath(var_66_2 .. "_normal")))
				table.insert(var_66_1, var_66_3)
			end

			for iter_66_2, iter_66_3 in pairs(self.btnState) do
				if iter_66_3 == 1 then
					self.btnObjList[iter_66_2]:loadTextures(var_66_1[iter_66_2], var_66_1[iter_66_2], var_66_1[iter_66_2], var_0_3)
				else
					self.btnObjList[iter_66_2]:loadTextures(var_66_0[iter_66_2], var_66_0[iter_66_2], var_66_0[iter_66_2], var_0_3)
				end
			end
		end,
		style_horcrux_bag_new = function()
			local var_67_0 = {}
			local var_67_1 = {}

			table.insert(var_67_0, "public/filter/filter_horcrux_bag_new_all_normal.png")
			table.insert(var_67_1, "public/filter/filter_horcrux_bag_new_all_on.png")

			for iter_67_0, iter_67_1 in pairs(ATTR_HORCRUX_LIST) do
				local var_67_2

				if type(iter_67_1) == "number" then
					var_67_2 = ATTR_ID[iter_67_1]
				end

				local var_67_3

				do
					var_67_2 = iter_67_1
					var_67_3 = self:getFilterPicPath("new_" .. var_67_2 .. "_on")
				end

				table.insert(var_67_0, (self:getFilterPicPath("new_" .. var_67_2 .. "_normal")))
				table.insert(var_67_1, var_67_3)
			end

			for iter_67_2, iter_67_3 in pairs(self.btnState) do
				local var_67_5 = self.btnObjList[iter_67_2]:getParent()

				if iter_67_3 == 1 then
					self.btnObjList[iter_67_2]:loadTextures(var_67_1[iter_67_2], var_67_1[iter_67_2], var_67_1[iter_67_2], var_0_3)
					self.btnObjList[iter_67_2].selecting:runAction(cc.Spawn:create(cc.FadeIn:create(0.2), cc.CallFunc:create(function()
						self.btnObjList[iter_67_2]:runAction(cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 3)), cc.ScaleTo:create(1.1)))
					end)))
				else
					self.btnObjList[iter_67_2]:loadTextures(var_67_0[iter_67_2], var_67_0[iter_67_2], var_67_0[iter_67_2], var_0_3)
					self.btnObjList[iter_67_2].selecting:setOpacity(0)
					self.btnObjList[iter_67_2]:setScale(1)
					self.btnObjList[iter_67_2]:setPosition(cc.p(var_67_5:size().w / 2, var_67_5:size().h / 2))
				end
			end
		end,
		style_lab_recipe = function()
			local var_69_0 = {}
			local var_69_1 = {}

			while lab_recipe_conf_data.recipe[1] do
				table.insert(var_69_0, lab_recipe_conf_data.recipe[1].path)
				table.insert(var_69_1, lab_recipe_conf_data.recipe[1].pathon)
			end

			for iter_69_0, iter_69_1 in pairs(self.btnState) do
				if iter_69_1 == 1 then
					self.btnObjList[iter_69_0]:loadTextures(var_69_1[iter_69_0], var_69_1[iter_69_0], var_69_1[iter_69_0], var_0_3)
				else
					self.btnObjList[iter_69_0]:loadTextures(var_69_0[iter_69_0], var_69_0[iter_69_0], var_69_0[iter_69_0], var_0_3)
				end
			end
		end,
		style_lab_research = function(arg_70_0)
			local var_70_0 = {}
			local var_70_1 = {}

			while lab_recipe_conf_data.research[arg_70_0][1] do
				table.insert(var_70_0, lab_recipe_conf_data.research[arg_70_0][1].path)
				table.insert(var_70_1, lab_recipe_conf_data.research[arg_70_0][1].pathon)
			end

			for iter_70_0, iter_70_1 in pairs(self.btnObjList) do
				if self.btnState[iter_70_1.index] == 1 then
					self.btnObjList[iter_70_0]:loadTextures(var_70_1[iter_70_0], var_70_1[iter_70_0], var_70_1[iter_70_0], var_0_3)
				else
					self.btnObjList[iter_70_0]:loadTextures(var_70_0[iter_70_0], var_70_0[iter_70_0], var_70_0[iter_70_0], var_0_3)
				end
			end
		end,
		style_major_filter = function()
			local var_71_0 = {
				"public/filter/filter_servant_bag_all_normal.png",
				"public/filter/filter_major_normal.png",
				"public/filter/filter_npc_normal.png"
			}
			local var_71_1 = {
				"public/filter/filter_servant_bag_all_on.png",
				"public/filter/filter_major_on.png",
				"public/filter/filter_npc_on.png"
			}

			for iter_71_0, iter_71_1 in pairs(self.btnState) do
				if iter_71_1 == 1 then
					self.btnObjList[iter_71_0]:loadTextures(var_71_1[iter_71_0], var_71_1[iter_71_0], var_71_1[iter_71_0], var_0_3)
				else
					self.btnObjList[iter_71_0]:loadTextures(var_71_0[iter_71_0], var_71_0[iter_71_0], var_71_0[iter_71_0], var_0_3)
				end
			end
		end,
		style_spring_task = function()
			local var_72_0 = {
				"public/filter/spring_task.png",
				"public/filter/spring_quickfight.png",
				"public/filter/spring_midas.png",
				"public/filter/spring_pifu.png",
				"public/filter/spring_egg.png"
			}
			local var_72_1 = {
				"public/filter/spring_task_on.png",
				"public/filter/spring_quickfight_on.png",
				"public/filter/spring_midas_on.png",
				"public/filter/spring_pifu_on.png",
				"public/filter/spring_egg_on.png"
			}

			for iter_72_0, iter_72_1 in pairs(self.btnState) do
				if iter_72_1 == 1 then
					self.btnObjList[iter_72_0]:loadTextures(var_72_1[iter_72_0], var_72_1[iter_72_0], var_72_1[iter_72_0], var_0_3)
				else
					self.btnObjList[iter_72_0]:loadTextures(var_72_0[iter_72_0], var_72_0[iter_72_0], var_72_0[iter_72_0], var_0_3)
				end
			end
		end,
		style_lantern_task = function()
			local var_73_0 = {
				[1] = "Activity_LanternFestivalLayer/select_1_black.png",
				[2] = "Activity_LanternFestivalLayer/select_2_black.png"
			}
			local var_73_1 = {
				[1] = "Activity_LanternFestivalLayer/select_1_light.png",
				[2] = "Activity_LanternFestivalLayer/select_2_light.png"
			}

			for iter_73_0, iter_73_1 in pairs(self.btnState) do
				if iter_73_1 == 1 then
					self.btnObjList[iter_73_0]:loadTextures(var_73_1[iter_73_0], var_73_1[iter_73_0], var_73_1[iter_73_0], var_0_3)
				else
					self.btnObjList[iter_73_0]:loadTextures(var_73_0[iter_73_0], var_73_0[iter_73_0], var_73_0[iter_73_0], var_0_3)
				end
			end
		end,
		style_lamia_task = function()
			local var_74_0 = {
				[1] = "Activity_lamia/select_2_black.png",
				[2] = "Activity_lamia/select_1_black.png"
			}
			local var_74_1 = {
				[1] = "Activity_lamia/select_2_light.png",
				[2] = "Activity_lamia/select_1_light.png"
			}

			for iter_74_0, iter_74_1 in pairs(self.btnState) do
				if iter_74_1 == 1 then
					self.btnObjList[iter_74_0]:loadTextures(var_74_1[iter_74_0], var_74_1[iter_74_0], var_74_1[iter_74_0], var_0_3)
				else
					self.btnObjList[iter_74_0]:loadTextures(var_74_0[iter_74_0], var_74_0[iter_74_0], var_74_0[iter_74_0], var_0_3)
				end
			end
		end,
		style_servant_attr = function(...)
			local var_75_0 = {}
			local var_75_1 = {}

			table.insert(var_75_0, "public/filter/filter_servant_bag_all_normal.png")
			table.insert(var_75_1, "public/filter/filter_servant_bag_all_on.png")

			for iter_75_0, iter_75_1 in pairs((filter_config_manager:getServantFilterOrder())) do
				local var_75_2 = self:getServantPicPath(iter_75_1 .. "_on")

				table.insert(var_75_0, (self:getServantPicPath(iter_75_1 .. "_normal")))
				table.insert(var_75_1, var_75_2)
			end

			for iter_75_2, iter_75_3 in pairs(self.btnState) do
				if iter_75_3 == 1 then
					self.btnObjList[iter_75_2]:loadTextures(var_75_1[iter_75_2], var_75_1[iter_75_2], var_75_1[iter_75_2], var_0_3)
				else
					self.btnObjList[iter_75_2]:loadTextures(var_75_0[iter_75_2], var_75_0[iter_75_2], var_75_0[iter_75_2], var_0_3)
				end
			end
		end,
		style_servant_attr_new = function(...)
			for iter_76_0, iter_76_1 in pairs(self.btnState) do
				if iter_76_1 == 1 then
					self.btnObjList[iter_76_0]:loadTextures("public/filter/quick_formation_filter_on.png", "public/filter/quick_formation_filter_on.png", "public/filter/quick_formation_filter_on.png", var_0_3)
					self.btnObjList[iter_76_0]._img:loadTexture(string.format("public/filter/quick_formation_on_img_%s.png", self.btnObjList[iter_76_0]._key), var_0_3)
				else
					self.btnObjList[iter_76_0]:loadTextures("public/filter/quick_formation_filter_off.png", "public/filter/quick_formation_filter_off.png", "public/filter/quick_formation_filter_off.png", var_0_3)
					self.btnObjList[iter_76_0]._img:loadTexture(string.format("public/filter/quick_formation_off_img_%s.png", self.btnObjList[iter_76_0]._key), var_0_3)
				end
			end
		end
	}

	if var_65_0[self.style] then
		var_65_0[self.style](self.tab)
	else
		for iter_65_0, iter_65_1 in pairs(self.btnState) do
			local var_65_1 = self.btnObjList[iter_65_0]:getParent()

			if iter_65_1 == 1 then
				self.btnObjList[iter_65_0]:loadTextures("public/filter/selected_tab_top_on.png", "public/filter/selected_tab_top_on.png", "public/filter/selected_tab_top_on.png", var_0_3)
				self.btnObjList[iter_65_0]:getChildByName("label"):enableOutline(var_0_7, 1)
				self.btnObjList[iter_65_0]:getChildByName("label"):enableShadow(var_0_7, cc.size(0, 0))

				if self.style == "style_furniture" then
					local var_65_2 = string.format("DormitoryFixturesLayer/filter_dormitory_on%d.png", iter_65_0)

					self.btnObjList[iter_65_0]:loadTextures(var_65_2, var_65_2, var_65_2, var_0_3)
					self.btnObjList[iter_65_0]:getChildByName("label"):setVisible(false)
				elseif self.style == "style_parts" then
					local var_65_3 = string.format("public/filter/filter_parts_on_%d.png", iter_65_0)

					self.btnObjList[iter_65_0]:loadTextures(var_65_3, var_65_3, var_65_3, var_0_3)
					self.btnObjList[iter_65_0]:getChildByName("label"):setVisible(false)
					self.btnObjList[iter_65_0].selecting:runAction(cc.Spawn:create(cc.FadeIn:create(0.2), cc.CallFunc:create(function()
						self.btnObjList[iter_65_0]:runAction(cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 3)), cc.ScaleTo:create(1.1)))
					end)))
				end
			elseif iter_65_1 == 0 then
				self.btnObjList[iter_65_0]:loadTextures("public/filter/selected_tab_mid.png", "public/filter/selected_tab_mid.png", "public/filter/selected_tab_mid.png", var_0_3)
				self.btnObjList[iter_65_0]:getChildByName("label"):enableOutline(var_0_6, 1)
				self.btnObjList[iter_65_0]:getChildByName("label"):enableShadow(var_0_6, cc.size(0, 0))

				if self.style == "style_furniture" then
					local var_65_4 = string.format("DormitoryFixturesLayer/filter_dormitory_off%d.png", iter_65_0)

					self.btnObjList[iter_65_0]:loadTextures(var_65_4, var_65_4, var_65_4, var_0_3)
					self.btnObjList[iter_65_0]:getChildByName("label"):setVisible(false)
				elseif self.style == "style_parts" then
					local var_65_5 = string.format("public/filter/filter_parts_off_%d.png", iter_65_0)

					self.btnObjList[iter_65_0]:loadTextures(var_65_5, var_65_5, var_65_5, var_0_3)
					self.btnObjList[iter_65_0]:getChildByName("label"):setVisible(false)
					self.btnObjList[iter_65_0].selecting:setOpacity(0)
					self.btnObjList[iter_65_0]:setScale(1)
					self.btnObjList[iter_65_0]:setPosition(cc.p(var_65_1:size().w / 2, var_65_1:size().h / 2))
				end
			else
				self.btnObjList[iter_65_0]:loadTextures("public/filter/selected_tab_mid.png", "public/filter/selected_tab_mid.png", "public/filter/selected_tab_mid.png", var_0_3)
				self.btnObjList[iter_65_0]:getChildByName("label"):enableOutline(var_0_6, 1)
				self.btnObjList[iter_65_0]:getChildByName("label"):enableShadow(var_0_6, cc.size(0, 0))

				if self.style == "style_parts" then
					local var_65_6 = string.format("public/filter/filter_parts_off_%d.png", iter_65_0)

					self.btnObjList[iter_65_0]:loadTextures(var_65_6, var_65_6, var_65_6, var_0_3)
					self.btnObjList[iter_65_0]:getChildByName("label"):setVisible(false)
					self.btnObjList[iter_65_0].selecting:setOpacity(0)
					self.btnObjList[iter_65_0]:setScale(1)
					self.btnObjList[iter_65_0]:setPosition(cc.p(var_65_1:size().w / 2, var_65_1:size().h / 2))
				end
			end
		end
	end
end

function FilterListSprite.setTouchFlag(arg_78_0, arg_78_1)
	arg_78_0.flag = arg_78_1
end

function FilterListSprite:getTouchFlag()
	self.flag = self.flag or false

	return self.flag
end

function FilterListSprite:getFilterData()
	local var_80_0 = {}
	local var_80_1 = {}
	local var_80_2 = self.initParam.hideAll and 1 or 2

	while var_80_2 <= #self.btnState do
		var_80_1[#var_80_1 + 1] = self.btnState[var_80_2]
		var_80_2 = var_80_2 + 1
	end

	local var_80_3

	if self.btnState[1] == 1 then
		var_80_3 = nil
	else
		for iter_80_0, iter_80_1 in pairs(self.btnState) do
			if iter_80_1 == 1 then
				var_80_3 = self.btnKey[iter_80_0]
			end
		end
	end

	var_80_0.filterValue = var_80_3
	var_80_0.filterKey = self.filterKey
	var_80_0.btnState = var_80_1
	var_80_0.col = var_0_5[self.bagLayerType].index

	return var_80_0
end

function FilterListSprite.getFilterPicPath(arg_81_0, arg_81_1)
	return "public/filter/filter_horcrux_bag_" .. arg_81_1 .. ".png"
end

function FilterListSprite.getServantPicPath(arg_82_0, arg_82_1)
	return "public/filter/filter_servant_bag_" .. arg_82_1 .. ".png"
end

function FilterListSprite:getButton(arg_83_1)
	return self.listView:getItem(arg_83_1)
end
