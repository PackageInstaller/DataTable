PopActivityReturnDetailLayer = class("PopActivityReturnDetailLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_return_manager = require("controller.activity_return_manager")
local level_manager = require("controller.level_manager")
local time_check_manager = require("controller.time_check_manager")
local ShowGirlImage = require("view.Sprite.ShowGirlImage")
local playermodel = require("model.playermodel")
local city_data = require("data.city_data")
local chapter_data = require("data.chapter_data")
local drop_data = require("data.drop_data")
local item_data = require("data.item_data")
local lua = require("data.return_pop_girl_data.lua")
local model_data = require("data.model_data")

function PopActivityReturnDetailLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActivityReturnDetailLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopActivityReturnDetailLayer:init(arg_3_1)
	self.rootpanel = ccui.Layout:create()

	self.rootpanel:setContentSize(cc.size(640, 1600))
	self.rootpanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootpanel:setCascadeOpacityEnabled(false)
	self.rootpanel:setBackGroundColorOpacity(128)
	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootpanel:setPosition(GameDisplay.cx, GameDisplay.cy)
	self.rootpanel:setTouchEnabled(true)
	self:addChild(self.rootpanel)

	self.respath = "PopActivityReturnDetailLayer/"
	self.offlineDay = activity_return_manager:getOfflineDay()

	self:initData(function()
		return
	end)
	self:initUI()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" and arg_3_1.callback then
			arg_3_1.callback()
		end
	end)
end

function PopActivityReturnDetailLayer.initData(arg_6_0, arg_6_1)
	local var_6_0 = level_manager:getCityByMode(playermodel.curMode)

	if not var_6_0 or not city_data[var_6_0] then
		return {}
	end

	local var_6_1 = {
		gold = 0,
		diamond = 0,
		items = {}
	}

	if city_data[var_6_0]["difficulty" .. 1] then
		local var_6_2 = 1

		while chapter_data[city_data[var_6_0]["difficulty" .. 1] .. "-" .. var_6_2] do
			local var_6_3 = drop_data[chapter_data[city_data[var_6_0]["difficulty" .. 1] .. "-" .. var_6_2].bigbossdrop] or drop_data[chapter_data[city_data[var_6_0]["difficulty" .. 1] .. "-" .. var_6_2].equip_drop] or {}

			if var_6_3.gold then
				var_6_1.gold = var_6_1.gold + var_6_3.gold
			end

			if var_6_3.diamond then
				var_6_1.diamond = var_6_1.diamond + var_6_3.diamond
			end

			local var_6_4 = 1

			while var_6_3["drop_id" .. var_6_4] do
				var_6_1.items["" .. var_6_3["drop_id" .. var_6_4]] = var_6_1.items["" .. var_6_3["drop_id" .. var_6_4]] or true
				var_6_4 = var_6_4 + 1
			end

			local var_6_5 = 1

			while var_6_3["dropmodel_id" .. var_6_5] do
				if drop_data[var_6_3["dropmodel_id" .. var_6_5]].gold then
					var_6_1.gold = var_6_1.gold + drop_data[var_6_3["dropmodel_id" .. var_6_5]].gold
				end

				if drop_data[var_6_3["dropmodel_id" .. var_6_5]].diamond then
					var_6_1.diamond = var_6_1.diamond + drop_data[var_6_3["dropmodel_id" .. var_6_5]].diamond
				end

				local var_6_6 = 1

				while drop_data[var_6_3["dropmodel_id" .. var_6_5]]["drop_id" .. var_6_6] do
					var_6_1.items["" .. drop_data[var_6_3["dropmodel_id" .. var_6_5]]["drop_id" .. var_6_6]] = var_6_1.items["" .. drop_data[var_6_3["dropmodel_id" .. var_6_5]]["drop_id" .. var_6_6]] or true
					var_6_6 = var_6_6 + 1
				end

				local var_6_7 = 1

				while drop_data[var_6_3["dropmodel_id" .. var_6_5]]["rd_drop_id" .. var_6_7] do
					var_6_1.items["" .. drop_data[var_6_3["dropmodel_id" .. var_6_5]]["rd_drop_id" .. var_6_7]] = var_6_1.items["" .. drop_data[var_6_3["dropmodel_id" .. var_6_5]]["rd_drop_id" .. var_6_7]] or true
					var_6_7 = var_6_7 + 1
				end

				var_6_5 = var_6_5 + 1
			end

			local var_6_8 = 1

			while var_6_3["rd_drop_id" .. var_6_8] do
				var_6_1.items["" .. var_6_3["rd_drop_id" .. var_6_8]] = var_6_1.items["" .. var_6_3["rd_drop_id" .. var_6_8]] or true
				var_6_8 = var_6_8 + 1
			end

			local var_6_9 = 1

			while var_6_3["rd_dropmodel_id" .. var_6_9] do
				if drop_data[var_6_3["rd_dropmodel_id" .. var_6_9]].gold then
					var_6_1.gold = var_6_1.gold + drop_data[var_6_3["rd_dropmodel_id" .. var_6_9]].gold
				end

				if drop_data[var_6_3["rd_dropmodel_id" .. var_6_9]].diamond then
					var_6_1.diamond = var_6_1.diamond + drop_data[var_6_3["rd_dropmodel_id" .. var_6_9]].diamond
				end

				local var_6_10 = 1

				while drop_data[var_6_3["rd_dropmodel_id" .. var_6_9]]["drop_id" .. var_6_10] do
					var_6_1.items["" .. drop_data[var_6_3["rd_dropmodel_id" .. var_6_9]]["drop_id" .. var_6_10]] = var_6_1.items["" .. drop_data[var_6_3["rd_dropmodel_id" .. var_6_9]]["drop_id" .. var_6_10]] or true
					var_6_10 = var_6_10 + 1
				end

				local var_6_11 = 1

				while drop_data[var_6_3["rd_dropmodel_id" .. var_6_9]]["rd_drop_id" .. var_6_11] do
					var_6_1.items["" .. drop_data[var_6_3["rd_dropmodel_id" .. var_6_9]]["rd_drop_id" .. var_6_11]] = var_6_1.items["" .. drop_data[var_6_3["rd_dropmodel_id" .. var_6_9]]["rd_drop_id" .. var_6_11]] or true
					var_6_11 = var_6_11 + 1
				end

				var_6_9 = var_6_9 + 1
			end

			var_6_2 = var_6_2 + 1
		end
	end

	local var_6_12 = {}

	if next(var_6_1.items) then
		for iter_6_0, iter_6_1 in pairs(var_6_1.items) do
			if tonumber(iter_6_0) and item_data[tonumber(iter_6_0)].equip_quality and item_data[tonumber(iter_6_0)].equip_quality >= 3 then
				table.insert(var_6_12, {
					itemid = tonumber(iter_6_0)
				})
			end
		end
	end

	table.sort(var_6_12, function(arg_7_0, arg_7_1)
		if type(arg_7_0.itemid) == "number" and type(arg_7_1.itemid) == "number" and item_data[arg_7_0.itemid].equip_quality and item_data[arg_7_1.itemid].equip_quality then
			return item_data[arg_7_0.itemid].equip_quality > item_data[arg_7_1.itemid].equip_quality
		end
	end)

	arg_6_0.dropdata = var_6_12

	if not lua then
		return
	end

	local var_6_13 = {}

	for iter_6_2, iter_6_3 in pairs(lua) do
		if global_get_time_by_date(iter_6_3.starttime) <= time_check_manager:getCurTime() and global_get_time_by_date(iter_6_3.finishtime) >= time_check_manager:getCurTime() then
			table.insert(var_6_13, iter_6_3)
		end
	end

	table.sort(var_6_13, function(arg_8_0, arg_8_1)
		return global_get_time_by_date(arg_8_0.starttime) > global_get_time_by_date(arg_8_1.starttime)
	end)

	arg_6_0.girlData = var_6_13
end

function PopActivityReturnDetailLayer:initUI()
	local var_9_0 = ccui.PageView:create()

	var_9_0:setContentSize(cc.size(640, 1280))
	var_9_0:setAnchorPoint(0.5, 0.5)
	var_9_0:setPosition(320, GameDisplay.cy)
	var_9_0:setTouchEnabled(true)
	self.rootpanel:addChild(var_9_0)

	self.pageView = var_9_0

	for iter_9_0 = 1, 4 do
		local var_9_1 = ccui.Layout:create()

		var_9_1:setContentSize(cc.size(640, GameDisplay.height))
		var_9_1:setAnchorPoint(0, 0)
		var_9_1:setPosition(320, GameDisplay.cy)
		var_9_1:setTouchEnabled(true)
		var_9_1:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_10_0:getTouchBeganPosition().y - arg_10_0:getTouchEndPosition().y) > 50 then
				return
			end

			if var_9_0:getCurPageIndex() + 1 == 4 then
				-- block empty
			else
				var_9_0:scrollToPage(var_9_0:getCurPageIndex() + 1)
			end
		end)

		local var_9_2 = ccui.ImageView:create(self.respath .. "bg" .. iter_9_0 .. ".png", var_0_0)

		var_9_1:addChild(var_9_2)
		var_9_2:setPosition(320, 800 - GameDisplay.fix_y)

		local var_9_3 = ccui.Button:create(self.respath .. "btn_left.png", nil, self.respath .. "btn_left.png", var_0_0)

		var_9_1:addChild(var_9_3)
		var_9_3:setPosition(20, 800 - GameDisplay.fix_y)
		var_9_3:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_9_0:scrollToPage(var_9_0:getCurPageIndex() - 1)
		end)

		local var_9_4 = ccui.Button:create(self.respath .. "btn_right.png", nil, self.respath .. "btn_right.png", var_0_0)

		var_9_1:addChild(var_9_4)
		var_9_4:setPosition(GameDisplay.width - 20, 800 - GameDisplay.fix_y)
		var_9_4:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_9_0:scrollToPage(var_9_0:getCurPageIndex() + 1)
		end)

		if iter_9_0 == 1 then
			var_9_3:setVisible(false)

			local var_9_5 = cc.Label:createWithTTF(playermodel.nickname, FONT_NAME, 20)

			var_9_2:addChild(var_9_5)
			var_9_5:setPosition(245, 568)
			var_9_5:setAnchorPoint(0, 0)
			var_9_5:setColor(cc.c3b(210, 199, 255))

			local var_9_6 = cc.Label:createWithTTF(self.offlineDay, FONT_NAME, 36)

			var_9_2:addChild(var_9_6)
			var_9_6:setPosition(280, 285)
			var_9_6:setColor(cc.c3b(178, 246, 246))
		elseif iter_9_0 == 2 then
			self:initGirlList(var_9_1)
		elseif iter_9_0 == 3 then
			self:initDropTableView(var_9_1)
		elseif iter_9_0 == 4 then
			local var_9_7 = ccui.Button:create(self.respath .. "btn_go.png", nil, self.respath .. "btn_go.png", var_0_0)

			var_9_1:addChild(var_9_7)
			var_9_7:setPosition(320, 540 - GameDisplay.fix_y)
			var_9_7:addTouchEventListener(function(arg_13_0, arg_13_1)
				if arg_13_1 ~= ccui.TouchEventType.ended then
					return
				end

				KeyCodeManager:onKeyReleasedCallFunc()

				if LayerManager:getCurrentLayerName() == "ActivityGameBackGuideLayer" then
					LayerManager:getCurrentLayerObj():autoSwitchPanel()
				else
					goto_complete_system({
						jump_to_system = 3036
					})
				end

				AnalyticManager.clickReturnDetail({
					btn_return = "returnTask"
				})
			end)

			local var_9_8 = ccui.Button:create(self.respath .. "btn_close.png", nil, self.respath .. "btn_close.png", var_0_0)

			var_9_1:addChild(var_9_8)
			var_9_8:setPosition(600, 1200 - GameDisplay.fix_y)
			var_9_8:addTouchEventListener(function(arg_14_0, arg_14_1)
				if arg_14_1 ~= ccui.TouchEventType.ended then
					return
				end

				KeyCodeManager:onKeyReleasedCallFunc()
			end)
		end

		if iter_9_0 == 4 then
			var_9_4:setVisible(false)
		end

		var_9_0:addPage(var_9_1)
	end

	var_9_0:addEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 == ccui.PageViewEventType.turning then
			-- block empty
		end
	end)
end

function PopActivityReturnDetailLayer.initDropTableView(arg_16_0, arg_16_1)
	local var_16_0 = cc.TableView:create(cc.size(450, 270))

	var_16_0:setPosition(100, 540 - GameDisplay.fix_y)
	var_16_0:setDelegate()
	var_16_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_16_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_16_0:setName("tabeview_drop")
	var_16_0:setTouchEnabled(true)
	arg_16_1:addChild(var_16_0, 99)

	arg_16_0.tabeview_drop = var_16_0

	local var_16_1 = {
		cc.p(46, 70),
		cc.p(158, 70),
		cc.p(270, 70),
		(cc.p(382, 70))
	}

	local function var_16_2()
		local var_17_0 = ccui.Layout:create()

		var_17_0:setTouchEnabled(false)
		var_17_0:setScale(0.55)

		local var_17_1 = ccui.Button:create("public/box/new_item_bg5.png", nil, "public/box/new_item_bg5.png", var_0_0)

		var_17_1:setContentSize(cc.p(228, 174))
		var_17_1:setPosition(-87, -114)
		var_17_1:setAnchorPoint(0, 0)
		var_17_1:setName("Button_13")
		var_17_1:setTouchEnabled(true)
		var_17_0:addChild(var_17_1)

		return var_17_0
	end

	local function var_16_3()
		local var_18_0 = math.ceil(#arg_16_0.dropdata / 4)

		if var_18_0 < 3 then
			var_18_0 = 3
		end

		return var_18_0
	end

	local function var_16_4(arg_19_0)
		if type(arg_19_0.itemid) == "string" then
			return
		end

		local var_19_0 = item_data[arg_19_0.itemid].bag_item_type

		if item_data[arg_19_0.itemid].bag_item_type == kITEM_HORCRUX then
			local var_19_1 = -1
			local var_19_2 = require("data.item_data")[arg_19_0.itemid].horcruxtype

			for iter_19_0, iter_19_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if arg_19_0.itemid == iter_19_1.item_id then
					var_19_1 = iter_19_0

					break
				end
			end

			if var_19_1 == -1 then
				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_19_1,
				itemid = arg_19_0.itemid
			})
		elseif var_19_0 == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				defaultDisplayType = "preview",
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_19_0.itemid].servant
			})
		elseif not arg_16_0:getChildByName("OTHER_LAYER") then
			local var_19_3 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_19_0.itemid
			})
		end
	end

	local function var_16_5(arg_20_0, arg_20_1, arg_20_2)
		if not arg_20_0 or not arg_20_1 then
			return
		end

		arg_20_0:setName("sp_" .. arg_20_2)
		arg_20_0:setPosition(var_16_1[arg_20_2])

		arg_20_0:getChildByName("Button_13").selectindex = arg_20_1

		arg_20_0:getChildByName("Button_13"):setSwallowTouches(true)

		if arg_20_0:getChildByName("awarditem") then
			arg_20_0:getChildByName("awarditem"):removeFromParent()
		end

		if arg_16_0.dropdata[arg_20_1] then
			local var_20_0 = arg_16_0.dropdata[arg_20_1].itemid or nil

			if var_20_0 then
				local var_20_1 = ItemSprite:createNewWithItemId(var_20_0)

				var_20_1:setName("awarditem")
				var_20_1:setPosition(cc.p(arg_20_0:getContentSize().width / 2, arg_20_0:getContentSize().height / 2))
				var_20_1:setAnchorPoint(cc.p(0.5, 0.5))
				arg_20_0:addChild(var_20_1)
				var_20_1:setTouchEnabled(false)
				arg_20_0:setVisible(true)
				arg_20_0:getChildByName("Button_13"):loadTextures(ITEM_BOX_UI .. "new_item_bg" .. item_data[var_20_0].equip_quality .. ".png", nil, ITEM_BOX_UI .. "new_item_bg" .. item_data[var_20_0].equip_quality .. ".png", var_0_0)

				arg_20_0:getChildByName("Button_13").itemid = var_20_0

				arg_20_0:getChildByName("Button_13"):addTouchEventListener(function(arg_21_0, arg_21_1)
					if arg_21_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_21_0:getTouchBeganPosition().y - arg_21_0:getTouchEndPosition().y) > 50 then
						return
					end

					var_16_4(arg_21_0)
				end)

				goto label_20_0
			end
		end

		arg_20_0:setVisible(false)

		::label_20_0::
	end

	;(function()
		arg_16_0.tabeview_drop:registerScriptHandler(function(arg_24_0, arg_24_1)
			return 450, 140
		end, cc.TABLECELL_SIZE_FOR_INDEX)
		arg_16_0.tabeview_drop:registerScriptHandler(function(arg_23_0, arg_23_1)
			local var_23_0 = arg_23_0:dequeueCell()

			if not var_23_0 then
				var_23_0 = cc.TableViewCell:create()

				for iter_23_0 = 1, 4 do
					local var_23_1 = var_16_2()

					var_16_5(var_23_1, 4 * arg_23_1 + iter_23_0, iter_23_0)
					var_23_0:addChild(var_23_1)
				end
			else
				local var_23_2 = 4

				for iter_23_1 = 1, 4 do
					var_16_5(var_23_0:getChildByName("sp_" .. iter_23_1), var_23_2 * arg_23_1 + iter_23_1, iter_23_1)
				end
			end

			return var_23_0
		end, cc.TABLECELL_SIZE_AT_INDEX)
		arg_16_0.tabeview_drop:registerScriptHandler(function(arg_25_0, arg_25_1)
			return var_16_3()
		end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
		arg_16_0.tabeview_drop:reloadData()
	end)()
end

function PopActivityReturnDetailLayer:initGirlList(arg_26_1)
	if not self.girlData then
		return
	end

	local var_26_0 = #self.girlData

	if #self.girlData <= 0 then
		return
	elseif var_26_0 >= 4 then
		var_26_0 = 4
	end

	for iter_26_0 = 1, var_26_0 do
		local var_26_1 = ccui.Button:create(ROLE_RETRUN_PATH .. model_data[self.girlData[iter_26_0].model].role_image .. ".png", nil, ROLE_RETRUN_PATH .. model_data[self.girlData[iter_26_0].model].role_image .. ".png")

		arg_26_1:addChild(var_26_1)
		var_26_1:setPosition(121 * iter_26_0 + 10, 858 - GameDisplay.fix_y)
		var_26_1:addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 ~= ccui.TouchEventType.ended then
				return
			end

			goto_complete_system({
				jump_to_system = 1800000 + self.girlData[iter_26_0].twist_id
			})
			AnalyticManager.clickReturnDetail({
				btn_return = "twist",
				id = self.girlData[iter_26_0].twist_id
			})
		end)
	end

	local var_26_2 = ccui.Button:create(self.respath .. "btn_twist.png", nil, self.respath .. "btn_twist.png", var_0_0)

	arg_26_1:addChild(var_26_2)
	var_26_2:setPosition(320, 520 - GameDisplay.fix_y)
	var_26_2:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		goto_complete_system({
			jump_to_system = 1800000 + self.girlData[1].twist_id
		})
		AnalyticManager.clickReturnDetail({
			btn_return = "twist",
			id = self.girlData[1].twist_id
		})
	end)
end
