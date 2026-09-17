PopGetBattlepassVIPLayer = class("PopGetBattlepassVIPLayer", function()
	return PopBaseLayer:create()
end)

function PopGetBattlepassVIPLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopGetBattlepassVIPLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

require("view.Sprite.ItemSprite")

local var_0_0 = 140
local var_0_1 = 4
local var_0_2 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")

function PopGetBattlepassVIPLayer:init(arg_3_1)
	print("open poplayer : PopGetBattlepassVIPLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopGetBianhuaBpVIPLayer.json" or "PopGetBianhuaBpVIPLayer.ExportJson")

	self:addChild(self.rootLayer)

	arg_3_1 = arg_3_1 or {}
	self.activityId = arg_3_1.activityId or 9
	self.imagePath = arg_3_1.imagePath or "ActivityBianhuaBP"

	self:initUI()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopGetBattlepassVIPLayer")
		end
	end)
end

function PopGetBattlepassVIPLayer:registerActivityEventListener()
	activity_manager:registerEventListener("PopGetBattlepassVIPLayer", activity_manager.activityEventId.BATTLE_PASS_VIP_UPDATE, function(arg_6_0)
		self:updateVIPButtons()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_7_0)
		self:updateVIPButtons()
	end), self)
end

function PopGetBattlepassVIPLayer:initUI()
	self:updateVIPButtons()
	self:initExitTouchEvent()
	self:initImageInJson()
	self:initDropView()
	self:initDorps()
end

function PopGetBattlepassVIPLayer:updateVIPButtons()
	self.panelBg = self.rootLayer:getChildByName("panel_bg")
	self.btnGetVIP = self.panelBg:getChildByName("btn_get_vip")
	self.btnVipNeed = self.btnGetVIP:getChildByName("btn_vip_need")
	self.VIPGetted = self.btnGetVIP:getChildByName("btn_getted")

	self.btnVipNeed:setVisible(not activity_manager:isBattlePassVIP(self.activityId))
	self.VIPGetted:setVisible(activity_manager:isBattlePassVIP(self.activityId))

	local function var_9_0(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:isVIPBtnLock(self.activityId) then
			return
		end

		if activity_manager:isBattlePassVIP(self.activityId) then
			return
		end

		activity_manager:buyVipById(self.activityId, "vip_" .. self.activityId)
		AnalyticManager.touch_bianhua_vipbuy({
			id = "vip_" .. self.activityId
		})
	end

	self.btnGetVIP:addTouchEventListener(var_9_0)
	self.btnVipNeed:addTouchEventListener(var_9_0)

	local var_9_1 = self.btnVipNeed:getChildByName("lbl_vip_need")

	var_9_1:setString("x" .. activity_manager:getVipPriceById(self.activityId, "vip_" .. self.activityId))
	self.btnVipNeed:getChildByName("money"):loadTexture("public/currency/6800601.png", var_0_2)
	var_9_1:setColor(cc.c3b(71, 31, 129))

	self.btnGetSVIP = self.panelBg:getChildByName("btn_get_svip")
	self.btnSVipNeed = self.btnGetSVIP:getChildByName("btn_svip_need")
	self.SVIPGetted = self.btnGetSVIP:getChildByName("btn_getted")

	self.btnSVipNeed:setVisible(not activity_manager:isBattlePassSVIP(self.activityId))
	self.SVIPGetted:setVisible(activity_manager:isBattlePassSVIP(self.activityId))

	local function var_9_2(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:isVIPBtnLock(self.activityId) then
			return
		end

		if activity_manager:isBattlePassSVIP(self.activityId) then
			return
		end

		if activity_manager:isBattlePassVIP(self.activityId) then
			activity_manager:buyVipById(self.activityId, "svip_" .. self.activityId)
			AnalyticManager.touch_bianhua_vipbuy({
				id = "svip_" .. self.activityId
			})
		else
			activity_manager:buyVipById(self.activityId, "allvip_" .. self.activityId)
			AnalyticManager.touch_bianhua_vipbuy({
				id = "allvip_" .. self.activityId
			})
		end
	end

	self.btnGetSVIP:addTouchEventListener(var_9_2)
	self.btnGetSVIP:setVisible(false)
	self.btnSVipNeed:addTouchEventListener(var_9_2)
end

function PopGetBattlepassVIPLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_13_0:isBright() then
			return
		end

		arg_13_0:setBright(false)
		self:exit()
	end)
end

function PopGetBattlepassVIPLayer:initDorps()
	for iter_14_0, iter_14_1 in pairs((activity_manager:getBuySVIPDrop(self.activityId))) do
		local var_14_0 = ItemPurchaseSprite:createPurchaseItem(iter_14_1.dropid, iter_14_1.dropNum)

		var_14_0:setScale(0.55)
		var_14_0:setPosition(cc.p(470 - 100 * (iter_14_0 % 2), 111))
		self.btnGetSVIP:addChild(var_14_0)

		local var_14_1 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_2)

		var_14_1:setContentSize(cc.size(var_14_0:getContentSize().width, var_14_0:getContentSize().height))
		var_14_1:setPosition(cc.p(var_14_0:getContentSize().width / 2, var_14_0:getContentSize().height / 2))
		var_14_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_14_1:setName("layout")
		var_14_1:setSwallowTouches(false)
		var_14_0:addChild(var_14_1)
		var_14_1:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(iter_14_1.dropid)
		end)
	end
end

function PopGetBattlepassVIPLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopGetBattlepassVIPLayer:initDropView()
	self.dataList = activity_manager:getAllVIPLevelGift(self.activityId)
	self.tableView = cc.TableView:create(cc.size(530, 530))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setAnchorPoint(cc.p(0, 0))
	self.tableView:setPosition(20, 2)
	self.tableView:setDelegate()
	self.panelBg:getChildByName("drop_panel"):setContentSize(cc.size(550, 530))
	self.panelBg:getChildByName("drop_panel"):setTouchEnabled(true)
	self.panelBg:getChildByName("drop_panel"):addChild(self.tableView)
	self.tableView:registerScriptHandler(function(arg_20_0, arg_20_1)
		return 640, var_0_0
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_0:dequeueCell()

		if not var_19_0 then
			var_19_0 = cc.TableViewCell:create()

			for iter_19_0 = 1, var_0_1 do
				if self.dataList[arg_19_1 * var_0_1 + iter_19_0] then
					local var_19_2 = self:createSprite(self.dataList[arg_19_1 * var_0_1 + iter_19_0])

					var_19_2:setName("sprite" .. iter_19_0)
					var_19_2:setAnchorPoint(cc.p(0.5, 0.5))
					var_19_2:setPosition(cc.p(55 + 132 * (iter_19_0 - 1), var_0_0 / 2))
					var_19_0:addChild(var_19_2)
				end
			end
		else
			for iter_19_1 = 1, var_0_1 do
				local var_19_3 = var_19_0:getChildByName("sprite" .. iter_19_1)

				if var_19_3 then
					var_19_3:removeFromParent()

					var_19_3 = nil
				end

				if self.dataList[arg_19_1 * var_0_1 + iter_19_1] then
					if not var_19_3 then
						var_19_3 = self:createSprite(self.dataList[arg_19_1 * var_0_1 + iter_19_1])

						var_19_3:setName("sprite" .. iter_19_1)
						var_19_3:setAnchorPoint(cc.p(0.5, 0.5))
						var_19_3:setPosition(cc.p(55 + 132 * (iter_19_1 - 1), var_0_0 / 2))
						var_19_0:addChild(var_19_3)
					else
						var_19_3:setVisible(true)
						var_19_3:setPosition(cc.p(55 + 132 * (iter_19_1 - 1), var_0_0 / 2))
						self:updateSprite(var_19_3, self.dataList[arg_19_1 * var_0_1 + iter_19_1])
					end
				elseif var_19_3 then
					var_19_3:setVisible(false)
				end
			end
		end

		return var_19_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_21_0, arg_21_1)
		return math.floor(#self.dataList / 4) + 1
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function PopGetBattlepassVIPLayer.createSprite(arg_22_0, arg_22_1)
	local var_22_0 = ItemPurchaseSprite:createPurchaseItem(arg_22_1.dropid, arg_22_1.dropNum)

	var_22_0:setScale(0.7)

	local var_22_1 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_2)

	var_22_1:setContentSize(cc.size(var_22_0:getContentSize().width, var_22_0:getContentSize().height))
	var_22_1:setPosition(cc.p(var_22_0:getContentSize().width / 2, var_22_0:getContentSize().height / 2))
	var_22_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_22_1:setName("layout")
	var_22_1:setSwallowTouches(false)
	var_22_0:addChild(var_22_1)
	var_22_1:addTouchEventListener(function(arg_23_0, arg_23_1)
		if math.abs(arg_23_0:getTouchBeganPosition().y - arg_23_0:getTouchEndPosition().y) > 25 then
			return
		end

		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		showItemDetails(arg_22_1.dropid)
	end)

	return var_22_0
end

function PopGetBattlepassVIPLayer.updateSprite(arg_24_0, arg_24_1, arg_24_2)
	arg_24_1:updatePurchaseItemByItemid(arg_24_2.dropid, arg_24_2.dropNum)
	arg_24_1:setSwallowTouches(false)
	arg_24_1:getChildByName("layout"):addTouchEventListener(function(arg_25_0, arg_25_1)
		if math.abs(arg_25_0:getTouchBeganPosition().y - arg_25_0:getTouchEndPosition().y) > 25 then
			return
		end

		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		showItemDetails(arg_24_2.dropid)
	end)
end

function PopGetBattlepassVIPLayer:initBg(arg_26_1)
	local var_26_0 = ccui.Layout:create()

	var_26_0:setTouchEnabled(true)
	var_26_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_26_0:setAnchorPoint(cc.p(0, 0))
	var_26_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_26_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_26_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_26_0:setOpacity(0)
	self:addChild(var_26_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_27_0)
		self:addChild(arg_27_0, -2)
		arg_27_0:setPositionY(arg_27_0:getPositionY() - GameDisplay.fix_y)

		local var_27_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_27_0:setAnchorPoint(cc.p(0, 0))
		var_27_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_27_0, -1)
		self:init(arg_26_1)
		var_26_0:setOpacity(102)
		var_26_0:setTouchEnabled(false)
	end)
end

function PopGetBattlepassVIPLayer:initImageInJson()
	self.btnGetVIP:loadTextures(self.imagePath .. "/btn_get_vip.png", nil, self.imagePath .. "/btn_get_vip.png", var_0_2)
	self.btnGetSVIP:loadTextures(self.imagePath .. "/btn_get_svip.png", nil, self.imagePath .. "/btn_get_svip.png", var_0_2)

	local var_28_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "right ")

	var_28_0:setPositionY(var_28_0:getPositionY() + 275)

	local var_28_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "left")

	var_28_1:setPositionY(var_28_1:getPositionY() + 275)

	local var_28_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "tltle_gift")

	var_28_2:setPositionY(var_28_2:getPositionY() + 275)
	var_28_2:loadTexture(self.imagePath .. "/title_gift.png", var_0_2)
	self.btnVipNeed:loadTextures(self.imagePath .. "/btn_vip_need.png", nil, self.imagePath .. "/btn_vip_need.png", var_0_2)
end
