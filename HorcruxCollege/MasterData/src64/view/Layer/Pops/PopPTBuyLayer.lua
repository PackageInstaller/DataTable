PopPTBuyLayer = class("PopPTBuyLayer", function()
	return PopBaseLayer:create()
end)

function PopPTBuyLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopPTBuyLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local var_0_3 = 200
local var_0_4 = 3
local var_0_5 = config._DEBUG and 0 or 1

function PopPTBuyLayer:init(arg_3_1)
	print("open poplayer : PopPTBuyLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopBpFastUpgradeLayer.json" or "PopBpFastUpgradeLayer.ExportJson")

	self:addChild(self.rootLayer)

	arg_3_1 = arg_3_1 or {}
	self.activityId = arg_3_1.activityId
	self.imagePath = arg_3_1.imagePath
	self.layerName = arg_3_1.layerName
	self.exitCallback = arg_3_1.exitCallback

	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function PopPTBuyLayer:initUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "left"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "right"):setVisible(false)

	local var_5_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "title")

	var_5_0:setVisible(false)

	local var_5_1 = cc.Label:createWithTTF(L_ACTIVITY_MARRY_LEVEL_2, FONT_TITLE, 22)

	var_5_1:setPosition(var_5_0:getPositionX() + 5, var_5_0:getPositionY())
	var_5_1:setColor(cc.c3b(73, 180, 255))
	var_5_0:getParent():addChild(var_5_1)

	self.titleLv = cc.Label:createWithTTF("", FONT_TITLE, 22)

	self.titleLv:setColor(cc.c3b(181, 92, 75))
	self.titleLv:setAnchorPoint(cc.p(1, 0.5))
	self.titleLv:setPosition(var_5_1:getPositionX() - var_5_1:getContentSize().width / 2, var_5_1:getPositionY())
	var_5_0:getParent():addChild(self.titleLv)

	local var_5_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "lbl")

	var_5_2:setPositionX(var_5_2:getPositionX() - 10)

	self.finishLv = cc.Label:createWithTTF("", FONT_TITLE, 20)

	self.finishLv:setColor(cc.c3b(253, 253, 83))
	self.finishLv:setAnchorPoint(cc.p(0, 0.5))
	self.finishLv:setPosition(var_5_2:getPositionX() + var_5_2:getContentSize().width / 2, var_5_2:getPositionY())
	var_5_2:getParent():addChild(self.finishLv)
	self:initExitTouchEvent()
	self:updateGotoBtn()
	self:initSliber()
	self:initBtns()
end

function PopPTBuyLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_7_0:isBright() then
			return
		end

		arg_7_0:setBright(false)
		self:exit()
	end)
end

function PopPTBuyLayer:updateGotoBtn()
	self.panelBg = self.rootLayer:getChildByName("panel_bg")

	self.panelBg:setTouchEnabled(true)

	self.btngoto = self.panelBg:getChildByName("btn_level_up")

	self.btngoto:setVisible(false)
end

function PopPTBuyLayer:initSliber()
	self.slider = self.panelBg:getChildByName("slider")

	self.slider:setPercent(0)

	self.upLevel = 1
	self.maxupLevel = activity_manager:getPTProceedMaxLevel(self.activityId) - activity_manager:getPTProceedLevel(self.activityId)

	self.slider:loadSlidBallTextures("public/button/blue_slider_node.png", "public/button/blue_slider_node.png", "public/button/blue_slider_node.png", var_0_5)
	self.slider:addEventListener(function(arg_10_0, arg_10_1)
		local var_10_0 = (function()
			for iter_11_0 = self.maxupLevel, 1, -1 do
				if self.slider:getPercent() >= (iter_11_0 - 1) * (100 / (self.maxupLevel - 1)) then
					return iter_11_0
				elseif iter_11_0 == 1 then
					return 1
				end
			end
		end)()

		if self.upLevel == var_10_0 then
			return
		end

		self.upLevel = var_10_0

		self:updateGiftView()
	end)
	self:updateGiftView()
end

function PopPTBuyLayer:initBtns()
	self.panelBg:getChildByName("btn_buy"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not activity_manager:canPTLevelUp(self.activityId, self.upLevel) then
			global_ShowBlockWords(L_BUY_BATTLEPASS_LEVEL[3])

			return
		end

		if playermodel.diamond < activity_manager:getPTLevelUpCost(self.activityId, self.upLevel) then
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})

			return
		end

		if self.upLevel == 0 then
			global_ShowBlockWords(L_LEVEL_UP_ZERO)

			return
		end

		activity_manager:buyPTProceedLevel(self.activityId, self.upLevel, 0, activity_manager:getPTLevelUpCost(self.activityId, self.upLevel), self.exitCallback)
		self:exit()
	end)
	self.panelBg:getChildByName("btn_add"):addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.upLevel >= self.maxupLevel then
			return
		end

		if not activity_manager:canPTLevelUp(self.activityId, self.upLevel + 1) then
			return
		end

		self.upLevel = self.upLevel + 1

		self.slider:setPercent((self.upLevel - 1) / (self.maxupLevel - 1) * 100)
		self:updateGiftView()
	end)
	self.panelBg:getChildByName("btn_jian"):addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.upLevel <= 1 then
			return
		end

		if not activity_manager:canPTLevelUp(self.activityId, self.upLevel - 1) then
			return
		end

		self.upLevel = self.upLevel - 1

		self.slider:setPercent((self.upLevel - 1) / (self.maxupLevel - 1) * 100)
		self:updateGiftView()
	end)
end

function PopPTBuyLayer:updateGiftView()
	self.dataList = activity_manager:getPTLevelupCanGetDrop(self.activityId, self.upLevel)

	local var_16_0 = activity_manager:getPTProceedLevel(self.activityId)

	self.panelBg:getChildByName("lbl"):setString("等级" .. var_16_0 .. " --→")
	self.finishLv:setString("等级" .. var_16_0 + self.upLevel)
	self.titleLv:setString(self.upLevel)

	if not self.costNum then
		local var_16_1 = ccui.ImageView:create("equipment/1000000.png")

		var_16_1:setPosition(270, 190)
		var_16_1:setScale(0.4)
		self.rootLayer:addChild(var_16_1)

		self.costNum = cc.Label:createWithTTF(activity_manager:getPTLevelUpCost(self.activityId, self.upLevel), FONT_NAME, 28)

		self.costNum:setPosition(340, 190)
		self.costNum:setColor(cc.c3b(252, 237, 242))
		self.rootLayer:addChild(self.costNum)
	else
		self.costNum:setString(activity_manager:getPTLevelUpCost(self.activityId, self.upLevel))
	end

	if self.tableView then
		self.tableView:removeFromParent()
	end

	self.tableView = cc.TableView:create(cc.size(600, 530))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setAnchorPoint(cc.p(0, 0))
	self.tableView:setPosition(0, 310)
	self.tableView:setDelegate()
	self.rootLayer:addChild(self.tableView)
	self.tableView:registerScriptHandler(function(arg_18_0, arg_18_1)
		return 600, var_0_3
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_0:dequeueCell()

		if not var_17_0 then
			var_17_0 = cc.TableViewCell:create()

			for iter_17_0 = 1, var_0_4 do
				if self.dataList[arg_17_1 + 1][iter_17_0] then
					local var_17_2 = self:createSprite(self.dataList[arg_17_1 + 1][iter_17_0])

					var_17_2:setName("sprite" .. iter_17_0)
					var_17_2:setAnchorPoint(cc.p(0.5, 0.5))
					var_17_2:setPosition(cc.p(110 + 210 * (iter_17_0 - 1), var_0_3 / 2))
					var_17_0:addChild(var_17_2)
				end
			end

			local var_17_3 = cc.Label:createWithTTF("---LV" .. var_16_0 + arg_17_1 + 1 .. "---", FONT_NAME, 24)

			var_17_3:setPosition(320, var_0_3 - 20)
			var_17_3:setName("lv_label")
			var_17_0:addChild(var_17_3)
		else
			for iter_17_1 = 1, var_0_4 do
				local var_17_4 = var_17_0:getChildByName("sprite" .. iter_17_1)

				if var_17_4 then
					var_17_4:removeFromParent()
				end

				local var_17_5

				if self.dataList[arg_17_1 + 1][iter_17_1] then
					if not var_17_5 then
						var_17_5 = self:createSprite(self.dataList[arg_17_1 + 1][iter_17_1])

						var_17_5:setName("sprite" .. iter_17_1)
						var_17_5:setAnchorPoint(cc.p(0.5, 0.5))
						var_17_5:setPosition(cc.p(110 + 210 * (iter_17_1 - 1), var_0_3 / 2))
						var_17_0:addChild(var_17_5)
					else
						var_17_5:setVisible(true)
						var_17_5:setPosition(cc.p(110 + 210 * (iter_17_1 - 1), var_0_3 / 2))
						self:updateSprite(var_17_5, self.dataList[arg_17_1 + 1][iter_17_1])
					end
				elseif var_17_5 then
					var_17_5:setVisible(false)
				end
			end

			var_17_0:getChildByName("lv_label"):setString("---LV" .. var_16_0 + arg_17_1 + 1 .. "---")
		end

		return var_17_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_19_0, arg_19_1)
		return #self.dataList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function PopPTBuyLayer.createSprite(arg_20_0, arg_20_1)
	local var_20_0 = ItemPurchaseSprite:createPurchaseItem(arg_20_1.dropid, arg_20_1.dropNum)

	var_20_0:setScale(0.8)
	var_20_0:getChildByName("wordBg"):loadTexture("public/box/word_pink_bg.png", var_0_5)
	var_20_0:getChildByName("numLabel"):setString("等级" .. arg_20_1.level)

	return var_20_0
end

function PopPTBuyLayer.updateSprite(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1:updatePurchaseItemByItemid(arg_21_2.dropid, arg_21_2.dropNum)
	arg_21_1:getChildByName("numLabel"):setString("等级" .. arg_21_2.level)
end

function PopPTBuyLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopPTBuyLayer:initBg(arg_24_1)
	local var_24_0 = ccui.Layout:create()

	var_24_0:setTouchEnabled(true)
	var_24_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_24_0:setAnchorPoint(cc.p(0, 0))
	var_24_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_24_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_24_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_24_0:setOpacity(0)
	self:addChild(var_24_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_25_0)
		self:addChild(arg_25_0, -2)
		arg_25_0:setPositionY(arg_25_0:getPositionY() - GameDisplay.fix_y)

		local var_25_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_25_0:setAnchorPoint(cc.p(0, 0))
		var_25_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_25_0, -1)
		self:init(arg_24_1)
		var_24_0:setOpacity(102)
		var_24_0:setTouchEnabled(false)
	end)
end
