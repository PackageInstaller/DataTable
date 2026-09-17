PopNovicePasslevelAwardLayer = class("PopNovicePasslevelAwardLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local drop_manager = require("controller.drop_manager")
local level_manager = require("controller.level_manager")
local item_data = require("data.item_data")
local novice_pass_level_data = require("data.novice_pass_level_data")

require("view.Sprite.BottomBtnList")

function PopNovicePasslevelAwardLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopNovicePasslevelAwardLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopNovicePasslevelAwardLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.ImageView:create("mainScenebg/popnovicepasslevelawardlayer.png")

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 - GameDisplay.fix_y)
	self.rootpanel:setTouchEnabled(true)
	self.rootLayer:addChild(self.rootpanel)
	self:initData()
	self:initUI()
	self:updateUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and arg_3_1 and arg_3_1.callback then
			arg_3_1.callback()
		end
	end)
end

function PopNovicePasslevelAwardLayer:initData()
	self.data = {}

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(playermodel.novice_pass_level_award) do
		var_5_0[iter_5_1] = true
	end

	for iter_5_2, iter_5_3 in pairs(novice_pass_level_data) do
		table.insert(self.data, {
			id = iter_5_3.id,
			dropid = iter_5_3.dropid,
			state = var_5_0[iter_5_3.id]
		})
	end

	table.sort(self.data, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0.state and 1 or 0
		local var_6_1 = arg_6_1.state and 1 or 0

		if (arg_6_0.state and 1 or 0) == (arg_6_1.state and 1 or 0) then
			return arg_6_0.id < arg_6_1.id
		else
			return var_6_0 < var_6_1
		end
	end)
end

function PopNovicePasslevelAwardLayer:initUI()
	self.itemsPanel = ccui.Layout:create()

	self.itemsPanel:setTouchEnabled(true)
	self.itemsPanel:setContentSize(cc.size(300, 315))
	self.itemsPanel:setAnchorPoint(cc.p(0, 0))
	self.itemsPanel:setPosition(cc.p(330, 60))
	self.itemsPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.itemsPanel:setBackGroundColor(cc.c3b(255, 0, 0))
	self.rootpanel:addChild(self.itemsPanel)
	self:createTitleSprite()
	self:initTableView()
	self:scrollTableView()
end

function PopNovicePasslevelAwardLayer.getAwardHanel(arg_8_0)
	return function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_9_0:isBright() then
			return
		end

		arg_9_0:setBright(false)

		local var_9_0 = arg_9_0:getParent().index

		if arg_8_0.data[var_9_0].state then
			global_ShowBlockWords("已领取")
			arg_9_0:setBright(true)

			return
		end

		local var_9_1 = novice_pass_level_data[arg_8_0.data[var_9_0].id].limit_level

		if novice_pass_level_data[arg_8_0.data[var_9_0].id].limit_level and not level_manager:isPlayerPassLevel(var_9_1) then
			global_ShowBlockWords(L_CLEAR_CHAPTER .. level_manager:formatSystemUnlockLevel(var_9_1))
			arg_9_0:setBright(true)

			return
		end

		playermodel:get_novice_pass_level_award(arg_8_0.data[var_9_0].id, function(arg_10_0)
			if arg_10_0.result == 1 then
				local var_10_0 = {}

				for iter_10_0, iter_10_1 in pairs(playermodel.novice_pass_level_award) do
					var_10_0[iter_10_1] = true
				end

				for iter_10_2, iter_10_3 in pairs(arg_8_0.data) do
					if var_10_0[iter_10_3.id] then
						iter_10_3.state = true
					end
				end

				table.sort(arg_8_0.data, function(arg_11_0, arg_11_1)
					local var_11_0 = arg_11_0.state and 1 or 0
					local var_11_1 = arg_11_1.state and 1 or 0

					if (arg_11_0.state and 1 or 0) == (arg_11_1.state and 1 or 0) then
						return arg_11_0.id < arg_11_1.id
					else
						return var_11_0 < var_11_1
					end
				end)
				arg_8_0:updateUI()
			elseif arg_10_0.result == 4 then
				print("没通过指定关卡")
			elseif arg_10_0.result == 3 then
				print("奖励已领完")
			end

			arg_9_0:setBright(true)
		end)
	end
end

function PopNovicePasslevelAwardLayer:updateUI()
	self:updateShowingCells()
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("NOVICE_SUMMARY_UPDATE")))
	end)))
end

function PopNovicePasslevelAwardLayer:scrollTableView()
	local var_14_0 = 1

	for iter_14_0, iter_14_1 in pairs(self.data) do
		if not iter_14_1.state then
			var_14_0 = iter_14_0

			break
		end
	end

	self.listPanel:scrollToPercent(var_14_0 / #self.data * 100, nil, false)
end

function PopNovicePasslevelAwardLayer:createTitleSprite()
	local var_15_0 = ccui.ImageView:create("PopNovicePasslevelAwardLayer/top_activity.png", var_0_0)

	var_15_0:setPositionX(320)
	var_15_0:setTouchEnabled(true)
	var_15_0:setPositionY(984 - var_15_0:getContentSize().height / 2 + GameDisplay.fix_y * 2)
	self:addChild(var_15_0, 999999)
end

local var_0_7 = 624
local var_0_8 = 660
local var_0_9 = 8
local var_0_10 = 0
local var_0_11 = 624
local var_0_12 = 200

function PopNovicePasslevelAwardLayer:initTableView()
	local var_16_0 = var_0_8 + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.listPanel = cc.TableView:create(cc.size(var_0_7, var_16_0))
	self.listPanel.displayheight = var_16_0

	self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.listPanel:setPosition(cc.p(var_0_9, var_0_10))
	self.listPanel:setDelegate()

	self.listPanel.anchorPoint = cc.p(0, 0)

	self.listPanel:setName("listPanel")
	self.rootLayer:addChild(self.listPanel)
	self.listPanel:registerScriptHandler(function(arg_17_0, arg_17_1)
		if arg_17_1 + 1 == #self.data then
			return var_0_11, var_0_12 + 40
		else
			return var_0_11, var_0_12
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.listPanel:registerScriptHandler(function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_0:dequeueCell() or cc.TableViewCell:create()
		local var_18_1 = var_18_0:getChildByName("sp")

		if not var_18_1 then
			var_18_1 = self:createCellSp()

			var_18_1:setName("sp")
			var_18_0:addChild(var_18_1)
			var_18_1:setAnchorPoint(cc.p(0, 0))
			var_18_1:setPosition(cc.p(0, 10))
		end

		if arg_18_1 + 1 == #self.data then
			var_18_1:setPositionY(50)
		else
			var_18_1:setPositionY(10)
		end

		var_18_1:update(arg_18_1 + 1)

		return var_18_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.listPanel:registerScriptHandler(function(arg_19_0, arg_19_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.listPanel:reloadData()
end

function PopNovicePasslevelAwardLayer:createCellSp(...)
	local var_20_0 = "PopNovicePasslevelAwardLayer/"
	local var_20_1 = ccui.Button:create("PopNovicePasslevelAwardLayer/" .. "cell_bg.png", "PopNovicePasslevelAwardLayer/" .. "cell_bg.png", "PopNovicePasslevelAwardLayer/" .. "cell_bg.png", var_0_0)

	var_20_1:setTouchEnabled(false)

	local var_20_2 = ccui.ImageView:create("PopNovicePasslevelAwardLayer/" .. "cell_mask.png", var_0_0)

	var_20_2:setAnchorPoint(cc.p(0, 0))
	var_20_2:setPosition(cc.p(0, 0))
	var_20_2:setName("maskimg")
	var_20_1:addChild(var_20_2, 100000)

	local var_20_3 = ccui.Button:create("PopNovicePasslevelAwardLayer/" .. "btn_get.png", "PopNovicePasslevelAwardLayer/" .. "btn_get.png", "PopNovicePasslevelAwardLayer/" .. "btn_get.png", var_0_0)

	var_20_3:setPositionX(var_20_1:getContentSize().width - var_20_3:getContentSize().width / 2)
	var_20_3:setPositionY(var_20_1:getContentSize().height / 2)
	var_20_3:setName("btn")
	var_20_3:addTouchEventListener(self:getAwardHanel())
	var_20_1:addChild(var_20_3)

	local var_20_4 = cc.Label:createWithTTF("", FONT_NAME, 26)

	var_20_4:setAnchorPoint(cc.p(0, 0))
	var_20_4:setPosition(cc.p(74, 148))
	var_20_4:setName("levelLabel")
	var_20_1:addChild(var_20_4)

	function var_20_1.update(arg_21_0, arg_21_1)
		arg_21_0.index = arg_21_1

		;(function(...)
			while arg_21_0:getChildByName("itemSp_" .. 1) do
				arg_21_0:removeChild((arg_21_0:getChildByName("itemSp_" .. 1)))
			end
		end)()
		;(function()
			local var_23_0 = drop_manager:getDropMsg(self.data[arg_21_1].dropid)
			local var_23_1 = {}

			if var_23_0.diamond > 0 then
				table.insert(var_23_1, {
					itemid = "diamond",
					num = var_23_0.diamond,
					name = L_DIAMOND
				})
			end

			if var_23_0.gold > 0 then
				table.insert(var_23_1, {
					itemid = "gold",
					num = var_23_0.gold,
					name = L_GOLD
				})
			end

			local var_23_2 = {}

			for iter_23_0, iter_23_1 in pairs(var_23_0.equips) do
				table.insert(var_23_2, {
					itemid = iter_23_1.dropid,
					num = iter_23_1.dropNum,
					name = item_data[iter_23_1.dropid].name,
					order = iter_23_0
				})
			end

			table.sort(var_23_2, function(arg_24_0, arg_24_1)
				return arg_24_0.order < arg_24_1.order
			end)

			for iter_23_2, iter_23_3 in pairs(var_23_2) do
				table.insert(var_23_1, iter_23_3)
			end

			local var_23_3 = {
				cc.p(50, 68),
				cc.p(140, 68),
				cc.p(230, 68),
				cc.p(320, 68),
				cc.p(410, 68),
				(cc.p(500, 68))
			}

			for iter_23_4, iter_23_5 in pairs(var_23_1) do
				local var_23_4 = ccui.Button:create("public/box/new_item_bg1.png", "public/box/new_item_bg1.png", "public/box/new_item_bg1.png", var_0_0)

				var_23_4:setScale(0.5)
				var_23_4:setSwallowTouches(false)
				var_23_4:setName("itemSp_" .. iter_23_4)
				var_23_4:setPosition(var_23_3[iter_23_4])

				var_23_4.itemid = iter_23_5.itemid

				arg_21_0:addChild(var_23_4)

				if type(iter_23_5.itemid) == "number" then
					var_23_4:addTouchEventListener(function(arg_25_0, arg_25_1)
						if math.abs(arg_25_0:getTouchBeganPosition().y - arg_25_0:getTouchEndPosition().y) > 50 then
							return
						end

						if arg_25_1 ~= ccui.TouchEventType.ended then
							return
						end

						PopLayer:Item({
							hideGainButton = true,
							itemid = arg_25_0.itemid
						})
					end)
				end

				local var_23_5 = ItemSprite:createNewWithItemId(iter_23_5.itemid, iter_23_5.num)

				var_23_5:setName("itemSp")
				var_23_5:setAnchorPoint(cc.p(0, 0))
				var_23_4:addChild(var_23_5)
			end
		end)()
		;(function(...)
			local var_26_0 = arg_21_0:getChildByName("btn")
			local var_26_1 = arg_21_0:getChildByName("maskimg")

			var_26_1:setVisible(false)

			if self.data[arg_21_1].state then
				var_26_1:setVisible(true)
				var_26_0:loadTextures(var_20_0 .. "btn_got.png", var_20_0 .. "btn_got.png", var_20_0 .. "btn_get.png", var_0_0)
			elseif novice_pass_level_data[self.data[arg_21_1].id].limit_level and not level_manager:isPlayerPassLevel(novice_pass_level_data[self.data[arg_21_1].id].limit_level) then
				var_26_0:loadTextures(var_20_0 .. "btn_late.png", var_20_0 .. "btn_late.png", var_20_0 .. "btn_late.png", var_0_0)
			else
				var_26_0:loadTextures(var_20_0 .. "btn_get.png", var_20_0 .. "btn_get.png", var_20_0 .. "btn_get.png", var_0_0)
			end
		end)()
		;(function(...)
			arg_21_0:getChildByName("levelLabel"):setString(level_manager:formatSystemUnlockLevel(novice_pass_level_data[self.data[arg_21_1].id].limit_level))
		end)()
	end

	return var_20_1
end

function PopNovicePasslevelAwardLayer:updateShowingCells(arg_28_1)
	local var_28_0, var_28_1 = GetTableViewShowCellIdx(self.listPanel, {
		cellsize = cc.size(var_0_11, var_0_12),
		maxcount = #self.data
	})

	for iter_28_0 = var_28_0, var_28_1 do
		self.listPanel:updateCellAtIndex(iter_28_0)
	end
end

function PopNovicePasslevelAwardLayer:getUIOnGuide()
	self.listPanel:scrollToIndex(0, false)

	local var_29_0 = self.listPanel:cellAtIndex(0):getChildByName("sp")

	if not var_29_0 then
		return
	end

	return var_29_0:getChildByName("btn")
end
