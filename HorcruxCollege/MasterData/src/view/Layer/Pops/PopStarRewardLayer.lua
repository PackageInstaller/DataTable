PopStarRewardLayer = class("PopStarRewardLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")

local levelmode_star_reward_data = require("data.levelmode_star_reward_data")
local level_manager = require("controller.level_manager")
local drop_manager = require("controller.drop_manager")
local playermodel = require("model.playermodel")
local var_0_4 = config._DEBUG and 0 or 1
local var_0_5

function PopStarRewardLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopStarRewardLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopStarRewardLayer:init(arg_3_1)
	var_0_5 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_star_reward.json" or "Pop_star_reward.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootpanel:setTouchEnabled(true)
	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)

	self.msg = arg_3_1
	self.mode = self.msg.mode
	self.cityType = self.msg.cityType

	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		if self.msg.cancelCallback then
			self.msg.cancelCallback()
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.rootpanel:setScaleY(0.1)
	self.rootpanel:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1.15, 1.2)))
	self:initUI()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_5 = false

			if arg_3_1.updateCallback then
				arg_3_1.updateCallback()
			end
		end
	end)
end

function PopStarRewardLayer:initUI()
	self.rootpanel:getChildByName("total_star_num"):setString(level_manager:getModeTotalStars(self.mode) .. "/" .. level_manager:getModeTotalChapter(self.mode) * 3)
	self.rootpanel:getChildByName("Label_4"):setString(ACTIVITY_LEVEL_MAP.STAR_NUM_TOTAL)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_5"):loadTexture("public/currency/star_icon.png", var_0_4)

	for iter_7_0 = 1, 3 do
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel" .. iter_7_0):setVisible(false)
	end

	self:createTableView()
end

function PopStarRewardLayer:createTableView(...)
	local function var_8_0(arg_9_0, arg_9_1)
		if levelmode_star_reward_data[self.mode]["reward_drop" .. arg_9_1] then
			arg_9_0:setVisible(true)

			local var_9_0 = levelmode_star_reward_data[self.mode]["reward_drop" .. arg_9_1] or "P1-3"
			local var_9_1 = levelmode_star_reward_data[self.mode]["need_num" .. arg_9_1] or 10

			arg_9_0:getChildByName("Label1"):setString(arg_9_1 .. ACTIVITY_LEVEL_MAP.STAR_NUM_TOTAL)
			arg_9_0:getChildByName("Label_num"):setString(var_9_1 .. ACTIVITY_LEVEL_MAP.STAR)
			arg_9_0:getChildByName("Label_num"):getChildByName("Label_9"):setCascadeColorEnabled(false)
			arg_9_0:getChildByName("Label_num"):getChildByName("Label_9"):setCascadeOpacityEnabled(false)
			arg_9_0:getChildByName("Label_num"):getChildByName("Label_9"):setString(ACTIVITY_LEVEL_MAP.STAR_NUM_HAVE_GOT)

			local var_9_2 = {}
			local var_9_3 = drop_manager:getDropMsg(var_9_0)

			if var_9_3.diamond and var_9_3.diamond > 0 then
				table.insert(var_9_2, {
					itemid = "diamond",
					num = var_9_3.diamond
				})
			end

			if var_9_3.gold and var_9_3.gold > 0 then
				table.insert(var_9_2, {
					itemid = "gold",
					num = var_9_3.gold
				})
			end

			if var_9_3.sp and var_9_3.sp > 0 then
				table.insert(var_9_2, {
					itemid = "strengthpoint",
					num = var_9_3.sp
				})
			end

			for iter_9_0, iter_9_1 in pairs(var_9_3.equips) do
				table.insert(var_9_2, {
					itemid = iter_9_1.dropid,
					num = iter_9_1.dropNum
				})
			end

			while arg_9_0:getChildByName("layout_" .. 1) do
				arg_9_0:getChildByName("layout_" .. 1):setVisible(false)
			end

			for iter_9_2, iter_9_3 in pairs(var_9_2) do
				if not arg_9_0:getChildByName("layout_" .. iter_9_2) then
					local var_9_5 = ccui.Layout:create()

					var_9_5:setContentSize(cc.size(86, 20))
					var_9_5:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
					var_9_5:setBackGroundColor(cc.c3b(0, 0, 0))
					var_9_5:setBackGroundColorOpacity(120)
					var_9_5:setPosition(60 + (iter_9_2 - 1) * 110 - var_9_5:getContentSize().width / 2, 5)
					var_9_5:setName("layout_" .. iter_9_2)
					arg_9_0:addChild(var_9_5, 2)

					local var_9_6 = ItemPurchaseSprite:createPurchaseItem(iter_9_3.itemid, nil, nil, true)

					if var_9_6.bagType == kITEM_HORCRUX then
						var_9_6:getChildByName("icon"):setPositionY(var_9_6:getChildByName("icon"):getPositionY() - 15)
					end

					var_9_6:setScale(0.45)
					var_9_6:setPosition(60 + (iter_9_2 - 1) * 110, 50)
					var_9_6:setName("sp" .. iter_9_2)
					arg_9_0:addChild(var_9_6)

					local var_9_8 = cc.Label:createWithTTF("×" .. iter_9_3.num, FONT_NAME, 18)

					var_9_8:setPosition(var_9_5:getContentSize().width / 2, var_9_5:getContentSize().height / 2)
					var_9_8:setName("num")
					var_9_5:addChild(var_9_8)
				end

				local var_9_9 = arg_9_0:getChildByName("layout_" .. iter_9_2)

				var_9_9:setVisible(true)
				arg_9_0:getChildByName("sp" .. iter_9_2):updatePurchaseItemByItemid(iter_9_3.itemid)

				local var_9_10 = arg_9_0:getChildByName("sp" .. iter_9_2)

				if var_9_10.bagType == kITEM_HORCRUX then
					var_9_10:getChildByName("icon"):setPositionY(var_9_10:getChildByName("icon"):getPositionY() - 15)
				end

				var_9_9:getChildByName("num"):setString("x" .. iter_9_3.num)
			end

			if not arg_9_0:getChildByName("sureBnt") then
				local var_9_12 = ccui.Button:create("PopStarRewardLayer/done.png", nil, "PopStarRewardLayer/done.png", var_0_4)

				var_9_12:setName("sureBnt")
				arg_9_0:addChild(var_9_12)
				var_9_12:addTouchEventListener(function(arg_10_0, arg_10_1)
					if arg_10_1 ~= ccui.TouchEventType.ended then
						return
					end

					if arg_10_0.isLock then
						return
					end

					if self.global_bnt_lock then
						return
					end

					arg_10_0.isLock = true
					self.global_bnt_lock = true

					level_manager:getModeStarReward(self.mode, arg_10_0.i, function(arg_11_0)
						if not var_0_5 then
							return
						end

						if arg_11_0 == 1 then
							self:updateUI()
						end

						arg_10_0.isLock = false
						self.global_bnt_lock = false
					end)
				end)
			end

			local var_9_13 = arg_9_0:getChildByName("sureBnt")

			var_9_13.i = arg_9_1

			if playermodel.levelmodeReward[self.mode][arg_9_1] then
				var_9_13:loadTextures("PopStarRewardLayer/done.png", nil, "PopStarRewardLayer/done.png", var_0_4)
				var_9_13:setScale(0.65)
				var_9_13:setName("sureBnt")
				var_9_13:setTitleText("")
				var_9_13:setPosition(368, 50)
				var_9_13:setTouchEnabled(false)
			else
				var_9_13:setPosition(368, 58)
				var_9_13:setScale(0.6)
				var_9_13:setTitleText(ACTIVITY_LEVEL_MAP.GET_REWARD)
				var_9_13:setTitleColor(cc.c3b(0, 0, 0))
				var_9_13:setTitleFontSize(30)
				var_9_13:setTitleFontName(FONT_NAME)

				if var_9_1 <= level_manager:getModeTotalStars(self.mode) then
					var_9_13:loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_4)
					var_9_13:setTouchEnabled(true)
				else
					var_9_13:loadTextures("public/button/public_button_off.png", nil, "public/button/public_button_off.png", var_0_4)
					var_9_13:setTouchEnabled(false)
				end
			end
		else
			arg_9_0:setVisible(false)
		end
	end

	self.listPanel = cc.TableView:create(cc.size(455, 410))

	self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.listPanel:setPosition(cc.p(30, 10))
	self.listPanel:setDelegate()
	ccui.Helper:seekWidgetByName(self.rootLayer, "bg"):addChild(self.listPanel)
	self.listPanel:registerScriptHandler(function(arg_13_0, arg_13_1)
		return 455, 124
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.listPanel:registerScriptHandler(function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_12_0:dequeueCell()

		if not var_12_0 then
			var_12_0 = cc.TableViewCell:create()

			local var_12_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel1"):clone()

			var_12_2:setName("starpanel")
			var_12_0:addChild(var_12_2)
		end

		local var_12_3 = var_12_0:getChildByName("starpanel")

		var_12_3:setTouchEnabled(false)
		var_12_3:setAnchorPoint(cc.p(0, 0))
		var_12_3:setPosition(cc.p(0, 0))
		var_8_0(var_12_3, arg_12_1 + 1)

		return var_12_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.listPanel:registerScriptHandler(function(arg_14_0, arg_14_1)
		return self:getLen()
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.listPanel:reloadData()
end

function PopStarRewardLayer:getLen()
	local var_15_0 = 0

	while levelmode_star_reward_data[self.mode]["reward_drop" .. var_15_0 + 1] do
		var_15_0 = var_15_0 + 1
	end

	return var_15_0
end

function PopStarRewardLayer:updateUI()
	self:updateShowingCells()
end

function PopStarRewardLayer:updateShowingCells()
	local var_17_0, var_17_1 = GetTableViewShowCellIdx(self.listPanel, {
		maxcount = self:getLen(),
		cellsize = cc.size(455, 124)
	})

	for iter_17_0 = var_17_0, var_17_1 do
		self.listPanel:updateCellAtIndex(iter_17_0)
	end
end
