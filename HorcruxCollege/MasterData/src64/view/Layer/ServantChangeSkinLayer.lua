ServantChangeSkinLayer = class("ServantChangeSkinLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local shop_manager = require("controller.shop_manager")
local activity_manager = require("controller.activity_manager")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local drop_manager = require("controller.drop_manager")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")
local L2Actor = require("view.Sprite.L2Actor")
local discount_manager = require("controller.discount_manager")

require("view.Layer.BackGroundLayer")

local var_0_14

function ServantChangeSkinLayer.getInstance()
	return var_0_14
end

function ServantChangeSkinLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ServantChangeSkinLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ServantChangeSkinLayer:init(arg_4_1)
	var_0_14 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ServantChangeSkinLayer.json" or "ServantChangeSkinLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.initParam = arg_4_1

	self:initData()
	self:updateData()
	self:registerRechargeEventListener()
	self:initUI()
	self:initDisplayValue(self.rootLayer)
	self:runInAni()
	self:updateUI()
	self:runOutAni()
	self:getShopSkinData(function()
		self.tableView:reloadData()
	end)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_14 = nil

			activity_manager:releaseEventListenerByName("ServantChangeSkinLayer")
			self.showgirlLayer:resetCurTalkConfig(self.modelid)
		end
	end)
	AnalyticManager.click_servant_change_skin_layer({
		servantid = self.servantid
	})
end

function ServantChangeSkinLayer:registerRechargeEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_8_0)
		self:updateData()
		self:updateUI()
	end), self)
	activity_manager:registerEventListener("ServantChangeSkinLayer", activity_manager.activityEventId.ACTIVITY_DRESS_ONE_KEY, function(arg_9_0)
		GlobalPlayRoleSound(global_get_servant_skin(self.servantid), ROLE_CONVERSATION_TYPE.changeDress)
		self:updateData()
		self:updateUI()
		self:exit()
	end)
end

function ServantChangeSkinLayer:initData()
	self.servantid = self.initParam.servantid
	self.useModelid = global_get_servant_skin(self.servantid)
	self.selectModelid = self.useModelid
	self.soulid = servant_data[self.servantid].major
	self.skinList = {}
	self.shopList = {}
	self.initUseModelid = self.useModelid
	self.goto_back_system_id = self.initParam.goto_back_system_id
	self.returnCallback = self.initParam.returnCallback
	self.changeShowGirlCallBack = self.initParam.changeShowGirlCallBack

	self:saveShopData()
end

function ServantChangeSkinLayer:updateData()
	self.useModelid = global_get_servant_skin(self.servantid)
	self.selectModelid = self.useModelid
	self.skinList = {}

	table.insert(self.skinList, {
		order = -1,
		itemid = -1,
		ownNum = 1,
		modelid = servant_data[self.servantid].modelid
	})

	while major_factor_data[self.soulid]["item" .. 1] and servant_data[self.servantid]["modelid" .. 1] do
		if not major_factor_data[self.soulid]["item" .. 1 .. "_hide"] then
			table.insert(self.skinList, {
				modelid = servant_data[self.servantid]["modelid" .. 1],
				itemid = major_factor_data[self.soulid]["item" .. 1],
				ownNum = item_manager:getItemNumber(major_factor_data[self.soulid]["item" .. 1]),
				order = 1
			})
		end
	end

	if major_factor_data[self.soulid].item_oc and not playermodel:isServantOverclockLockByTime(self.servantid) then
		local var_11_1 = {
			modelid = servant_data[self.servantid].model_oc,
			itemid = major_factor_data[self.soulid].item_oc,
			ownNum = item_manager:getItemNumber(major_factor_data[self.soulid].item_oc)
		}

		var_11_1.iconPath = "ServantChangeSkinLayer/oc_icon.png"
		var_11_1.order = 9999

		if var_11_1.modelid and global_get_model_attr(servant_data[self.servantid].modelid) ~= "umaru" then
			table.insert(self.skinList, var_11_1)
		end
	end

	self.selectItem = self.skinList[1].itemid
	self.useItem = self.skinList[1].itemid

	for iter_11_0, iter_11_1 in pairs(self.skinList) do
		if iter_11_1.modelid == self.selectModelid then
			self.selectItem = iter_11_1.itemid
		end

		if iter_11_1.modelid == self.useModelid then
			self.useItem = iter_11_1.itemid
		end
	end

	table.sort(self.skinList, function(arg_12_0, arg_12_1)
		if arg_12_0.ownNum == arg_12_1.ownNum then
			return arg_12_0.order < arg_12_1.order
		else
			return arg_12_0.ownNum > arg_12_1.ownNum
		end
	end)

	local var_11_2
	local var_11_3

	for iter_11_2, iter_11_3 in pairs(self.skinList) do
		if iter_11_3.modelid == self.useModelid then
			var_11_2 = iter_11_2
			var_11_3 = iter_11_3
		end
	end

	if var_11_2 then
		table.remove(self.skinList, var_11_2)
		table.insert(self.skinList, 1, var_11_3)
	end

	local var_11_4 = 1

	while self.skinList[var_11_4] do
		if global_is_hide_skin_by_itemid(self.skinList[var_11_4].itemid) then
			table.remove(self.skinList, var_11_4)
		else
			var_11_4 = var_11_4 + 1
		end
	end

	print("!!!!!!!!!", dump(self.skinList))
end

function ServantChangeSkinLayer:exit()
	LayerManager:removePopLayer()

	if self.initUseModelid ~= self.useModelid then
		self.changeShowGirlCallBack()
	end

	if self.returnCallback then
		self.returnCallback()
	end
end

function ServantChangeSkinLayer:initUI()
	self.showgirlLayer = ShowGirlLayer:create(self.selectModelid, 4)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_showGirlLayer"):addChild(self.showgirlLayer, 2)
	self.showgirlLayer:resetCurTalkConfig(self.selectModelid)
	self.showgirlLayer:setTalkEnabled(false)
	self:initTableView()

	local function var_14_0()
		self:exit()
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return"):addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:runOutAni(var_14_0)
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_use"):addTouchEventListener(self:getUseHandel())
	self:initCuteRole()
	self:addCuteRole()

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_skinIcon").stat = "show"

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_skinIcon"):addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_17_0:isBright() then
			return
		end

		arg_17_0:setBright(false)

		if arg_17_0.stat == "show" then
			self.panelSkinList:hide(function()
				arg_17_0:setBright(true)

				arg_17_0.stat = "hide"
			end)
		else
			self.panelSkinList:show(function()
				arg_17_0:setBright(true)

				arg_17_0.stat = "show"
			end)
		end
	end)
	;(function()
		self.panelSkinList = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_SkinList")
		self.panelSkinList.time = 0.2

		function self.panelSkinList:show(arg_21_1)
			self:runAction(cc.Sequence:create(cc.MoveTo:create(self.time, cc.p(0, self:getPositionY())), cc.CallFunc:create(function()
				if arg_21_1 then
					arg_21_1()
				end
			end)))
		end

		function self.panelSkinList:hide(arg_23_1)
			self:runAction(cc.Sequence:create(cc.MoveTo:create(self.time, cc.p(550, self:getPositionY())), cc.CallFunc:create(function()
				if arg_23_1 then
					arg_23_1()
				end
			end)))
		end

		self.cuteRolePanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cuteRole")
		self.cuteRolePanel.time = 0.2

		function self.cuteRolePanel:show(arg_25_1)
			self:runAction(cc.Sequence:create(cc.MoveTo:create(self.time, cc.p(self:getPositionX(), 983 + GameDisplay.fix_y - GameDisplay.statusbar_height)), cc.CallFunc:create(function()
				if arg_25_1 then
					arg_25_1()
				end
			end)))
		end

		function self.cuteRolePanel:hide(arg_27_1)
			self:runAction(cc.Sequence:create(cc.MoveTo:create(self.time, cc.p(self:getPositionX(), 1143 + GameDisplay.fix_y - GameDisplay.statusbar_height)), cc.CallFunc:create(function()
				if arg_27_1 then
					arg_27_1()
				end
			end)))
		end

		self.skinIcon = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_skinIcon")
		self.skinIcon.time = 0.1

		function self.skinIcon:show(arg_29_1)
			self:runAction(cc.Sequence:create(cc.MoveTo:create(self.time, cc.p(598, self:getPositionY())), cc.CallFunc:create(function()
				if arg_29_1 then
					arg_29_1()
				end
			end)))
		end

		function self.skinIcon:hide(arg_31_1)
			self:runAction(cc.Sequence:create(cc.MoveTo:create(self.time, cc.p(682, self:getPositionY())), cc.CallFunc:create(function()
				if arg_31_1 then
					arg_31_1()
				end
			end)))
		end
	end)()
end

function ServantChangeSkinLayer:initCuteRole()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cuteRole"):addTouchEventListener(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_34_0 = math.random(2, 5)

		local function var_34_1()
			self.cuteRoleSpine:playAni(nil, "idle", true)
		end

		if var_34_0 == 2 then
			self.cuteRoleSpine:playAni(var_34_1, "run", false)
		elseif var_34_0 == 3 then
			self.cuteRoleSpine:playAni(var_34_1, "attack", false)
		elseif var_34_0 == 4 then
			self.cuteRoleSpine:playAni(var_34_1, "win", false)
		else
			self.cuteRoleSpine:playAni(var_34_1, "die", false)
		end
	end)
end

function ServantChangeSkinLayer:addCuteRole()
	local var_36_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cuteRole")

	self.cuteRoleSpine = L2Actor:create(ROLE_SPINE_PATH .. model_data[self.selectModelid].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[self.selectModelid].spine_model .. ".atlas", (model_data[self.selectModelid].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[self.selectModelid].clothes_model .. ".atlas" or nil))

	self.cuteRoleSpine:setScale(0.3, 0.3)
	self.cuteRoleSpine:setContentSize(cc.size(100, 200))
	self.cuteRoleSpine:setPosition(cc.p(var_36_0:getContentSize().width / 2, var_36_0:getContentSize().height / 2 - 60))
	self.cuteRoleSpine:playAni(nil, "idle", true)
	var_36_0:addChild(self.cuteRoleSpine)
	var_36_0:setVisible(false)
end

local var_0_15 = 500
local var_0_16 = 240
local var_0_17 = 15
local var_0_18 = 82
local var_0_19 = 7
local var_0_20 = 20
local var_0_21 = 140
local var_0_22 = 240

function ServantChangeSkinLayer:initTableView()
	self.tableView = cc.TableView:create(cc.size(var_0_15, var_0_16))

	self.tableView:setPosition(cc.p(var_0_17, var_0_18))
	self.tableView:setDelegate()
	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_SkinList"):addChild(self.tableView)

	local function var_37_0()
		local var_38_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cloneSkin"):clone()

		local function var_38_1(arg_39_0, arg_39_1, arg_39_2)
			local var_39_0

			if not self.skinshops then
				var_39_0 = true
			end

			if self.skinshops and next(self.skinshops) == nil then
				var_39_0 = true
			end

			if arg_39_2 >= 1 then
				var_39_0 = true
			end

			if var_39_0 then
				if arg_39_0:getChildByName("tips") then
					arg_39_0:getChildByName("tips"):setVisible(false)
				end

				return
			end

			local var_39_1 = model_data[arg_39_1].major
			local var_39_2 = arg_39_1:match("(%d+)_")
			local var_39_3

			if self.skinshops.skin[model_data[arg_39_1].major] and self.skinshops.skin[var_39_1][var_39_2] then
				var_39_3 = self.skinshops.skin[var_39_1][var_39_2]
			elseif self.skinshops.skin_package[var_39_1] and self.skinshops.skin_package[var_39_1][var_39_2] then
				var_39_3 = self.skinshops.skin_package[var_39_1][var_39_2]
			end

			if var_39_3 and not var_39_0 and (var_39_3.shopinfo.discount and var_39_3.shopinfo.discount < var_39_3.shopinfo.price or var_39_3.shopinfo.discount2 and var_39_3.shopinfo.discount2 < var_39_3.shopinfo.price2) then
				if not arg_39_0:getChildByName("tips") then
					local var_39_4 = ccui.ImageView:create("ServantChangeSkinLayer/discount_logo.png", var_0_0)

					var_39_4:setName("tips")
					var_39_4:setAnchorPoint(cc.p(0, 1))
					var_39_4:setScale(arg_39_0:getContentSize().height / 170)
					var_39_4:setPosition(0, arg_39_0:getContentSize().height - 20)
					arg_39_0:addChild(var_39_4, 99)
				else
					arg_39_0:getChildByName("tips"):setVisible(true)
				end
			elseif arg_39_0:getChildByName("tips") then
				arg_39_0:getChildByName("tips"):setVisible(false)
			end
		end

		function var_38_0:update(arg_40_1, arg_40_2, arg_40_3, arg_40_4)
			ccui.Helper:seekWidgetByName(self, "Image_shopimage"):loadTexture(PANEL_ROLE_IMAGE_PATH .. model_data[arg_40_1].role_image .. ".png")

			self.modelid = arg_40_1
			self.itemid = arg_40_2
			self.iconPath = arg_40_4

			ccui.Helper:seekWidgetByName(self, "Image_selectIcon"):setVisible(self.modelid == self.selectModelid)
			ccui.Helper:seekWidgetByName(self, "Image_useIcon"):setVisible(self.modelid == self.useModelid)
			ccui.Helper:seekWidgetByName(self, "Panel_mask"):setVisible(arg_40_3 < 1)
			ccui.Helper:seekWidgetByName(self, "Label_name"):setString(model_data[arg_40_1].main_name)

			if arg_40_4 then
				if not self:getChildByName("ocicon") and arg_40_4 then
					local var_40_0 = ccui.ImageView:create(arg_40_4, var_0_0)

					var_40_0:setName("ocicon")
					var_40_0:setAnchorPoint(cc.p(1, 1))
					var_40_0:setPosition(self:getContentSize().width - 5, self:getContentSize().height - 30)
					self:addChild(var_40_0, 99)
				else
					self:getChildByName("ocicon"):setVisible(true)
				end
			elseif self:getChildByName("ocicon") then
				self:getChildByName("ocicon"):removeFromParent()
			end

			var_38_1(self, arg_40_1, arg_40_3)
		end

		var_38_0:getChildByName("Button_skin"):setSwallowTouches(false)
		var_38_0:getChildByName("Button_skin"):addTouchEventListener(function(arg_41_0, arg_41_1)
			if arg_41_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectModelid = arg_41_0:getParent().modelid
			self.selectItem = arg_41_0:getParent().itemid
			self.iconPath = arg_41_0:getParent().iconPath

			self:updateUI()
		end)

		return var_38_0
	end

	self.tableView:registerScriptHandler(function(arg_43_0, arg_43_1)
		return var_0_21, var_0_22
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_42_0, arg_42_1)
		local var_42_0 = arg_42_0:dequeueCell() or cc.TableViewCell:create()
		local var_42_1 = var_42_0:getChildByName("node")

		if not var_42_1 then
			var_42_1 = var_37_0()

			var_42_1:update(self.skinList[arg_42_1 + 1].modelid, self.skinList[arg_42_1 + 1].itemid, self.skinList[arg_42_1 + 1].ownNum, self.skinList[arg_42_1 + 1].iconPath)
			var_42_1:setName("node")
			var_42_1:setPosition(cc.p(var_0_19, var_0_20))
			var_42_0:addChild(var_42_1)
		else
			var_42_1:update(self.skinList[arg_42_1 + 1].modelid, self.skinList[arg_42_1 + 1].itemid, self.skinList[arg_42_1 + 1].ownNum, self.skinList[arg_42_1 + 1].iconPath)
		end

		return var_42_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_44_0, arg_44_1)
		return #self.skinList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function ServantChangeSkinLayer:updateShowingCells()
	local var_45_0, var_45_1 = GetTableViewShowCellIdx(self.tableView, {
		cellsize = cc.size(var_0_21, var_0_22),
		maxcount = #self.skinList
	})

	for iter_45_0 = var_45_0, var_45_1 do
		self.tableView:updateCellAtIndex(iter_45_0)
	end
end

function ServantChangeSkinLayer:updateUI()
	self:updateShowingCells()

	local var_46_0 = {
		"public/button/equipped_btn.png",
		"public/button/change_dress_btn.png",
		"public/button/buy_btn.png",
		"public/button/buy_btn.png",
		"public/button/buy_btn.png",
		"public/button/skin_overclock_btn.png"
	}
	local var_46_1 = 1

	if self.selectItem == self.useItem then
		var_46_1 = 1
	elseif self.selectItem == -1 or item_manager:getItemNumber(self.selectItem) > 0 then
		var_46_1 = 2
	elseif self.iconPath then
		var_46_1 = 6
	elseif item_manager:getItemNumber(self.selectItem) <= 0 then
		print("itemManager:getItemNumber(self.selectItem)2==", item_manager:getItemNumber(self.selectItem))

		var_46_1 = 4
	else
		var_46_1 = 5
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_use"):loadTextures(var_46_0[var_46_1], nil, var_46_0[var_46_1], var_0_0)

	if self.showgirlLayer:getChildByName("roleimage") then
		self.showgirlLayer:getChildByName("roleimage")._talksp = nil
	end

	self.showgirlLayer:update(self.selectModelid)

	if self.showgirlLayer:getChildByName("roleimage") then
		self.showgirlLayer:getChildByName("roleimage")._talksp = nil
	end

	self.showgirlLayer:setLive2DPlayStayEnabled(var_46_1 > 2)
	self.cuteRoleSpine:removeFromParent()
	self:addCuteRole()

	local var_46_2 = 1

	if model_data[self.selectModelid].is_own_full_screen_background == 1 then
		var_46_2 = 2
	end

	local var_46_3 = model_data[self.selectModelid].backgroundid or 6300001

	if self.backGroundLayer ~= nil then
		self.backGroundLayer:update(var_46_3, var_46_2)
	else
		self.backGroundLayer = BackGroundLayer:create(var_46_3, var_46_2)

		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_backGround"):getParent():addChild(self.backGroundLayer)
	end

	self:updateBackGround()
end

function ServantChangeSkinLayer:runInAni()
	self.panelSkinList:setPosition(cc.p(550, self.panelSkinList:getPositionY()))
	self.cuteRolePanel:setPositionY(1143 + GameDisplay.fix_y - GameDisplay.statusbar_height)
	self.skinIcon:setPositionX(682)
	self.skinIcon:show(function()
		self.panelSkinList:show()
	end)
	self.cuteRolePanel:show()
end

function ServantChangeSkinLayer:runOutAni(arg_49_1)
	self.panelSkinList:hide(function()
		if arg_49_1 then
			arg_49_1()
		end
	end)
	self.cuteRolePanel:hide()
	self.skinIcon:hide()
end

function ServantChangeSkinLayer:findShopInfoWithItemid(arg_51_1)
	local var_51_0 = {}
	local var_51_1 = 0

	for iter_51_0, iter_51_1 in pairs(self.shopList) do
		if arg_51_1 == iter_51_1.itemtype then
			var_51_0 = iter_51_1
			var_51_1 = 4
		end
	end

	return var_51_0, var_51_1
end

function ServantChangeSkinLayer.getShopSkinData(arg_52_0, arg_52_1)
	arg_52_0.skinshops = {}

	require("controller.shop_manager"):get_shop_clothes_data(function(arg_53_0)
		arg_52_0.skinshops = arg_53_0

		if arg_52_1 then
			arg_52_1()
		end
	end)
end

function ServantChangeSkinLayer.saveShopData(arg_54_0)
	return
end

function ServantChangeSkinLayer.getUseHandel(arg_55_0)
	return function(arg_56_0, arg_56_1)
		if arg_56_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_55_0.selectItem ~= -1 and item_manager:getItemNumber(arg_55_0.selectItem) < 1 then
			AnalyticManager.servant_change_skin_layer_buy_skin({
				servantid = arg_55_0.servantid,
				skin_itemid = arg_55_0.selectItem
			})

			local var_56_0, var_56_1 = (function(arg_57_0, arg_57_1)
				if not arg_55_0.skinshops then
					return false
				end

				if not arg_55_0.skinshops.skin then
					return false
				end

				if not arg_55_0.skinshops.skin[arg_57_0] then
					return false
				end

				for iter_57_0, iter_57_1 in pairs(arg_55_0.skinshops.skin[arg_57_0]) do
					if item_data[iter_57_1.shopinfo.itemtype].model == arg_57_1 then
						return iter_57_1.shopinfo, iter_57_1.shoptype
					end
				end

				return false
			end)(model_data[item_data[arg_55_0.selectItem].model].major, item_data[arg_55_0.selectItem].model)
			local var_56_2, var_56_3 = (function(arg_58_0, arg_58_1)
				if not arg_55_0.skinshops then
					return false
				end

				if not arg_55_0.skinshops.skin_package then
					return false
				end

				if not arg_55_0.skinshops.skin_package[arg_58_0] then
					return false
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_0.skinshops.skin_package[arg_58_0]) do
					if item_data[iter_58_1.shopinfo.itemtype].mode_id then
						for iter_58_2, iter_58_3 in pairs((drop_manager:getEquipDrops(item_data[iter_58_1.shopinfo.itemtype].mode_id))) do
							if item_data[iter_58_3.dropid].model and item_data[iter_58_3.dropid].model == arg_58_1 then
								return iter_58_1.shopinfo, iter_58_1.shoptype
							end
						end
					elseif item_data[iter_58_1.shopinfo.itemtype].model == arg_58_1 then
						return iter_58_1.shopinfo, iter_58_1.shoptype
					end
				end

				return false
			end)(model_data[item_data[arg_55_0.selectItem].model].major, item_data[arg_55_0.selectItem].model)

			if item_data[arg_55_0.selectItem].targetlayer1 then
				local var_56_4 = {
					item = arg_55_0.selectItem,
					methods = {}
				}

				if var_56_0 then
					table.insert(var_56_4.methods, {
						des = L_SKIN_GO_GAIN.shop,
						shopPopFunc = function()
							arg_55_0:shopPop(var_56_0, var_56_1, "shopitem")
						end
					})
				elseif var_56_2 then
					table.insert(var_56_4.methods, {
						des = L_SKIN_GO_GAIN.shop,
						shopPopFunc = function()
							arg_55_0:shopPop(var_56_2, var_56_3, "giftitem")
						end
					})
				end

				LayerManager:pushInLayer("PopGoGainLayer", var_56_4)
			elseif var_56_0 then
				arg_55_0:shopPop(var_56_0, var_56_1, "shopitem")
			elseif var_56_2 then
				arg_55_0:shopPop(var_56_2, var_56_3, "giftitem")
			elseif arg_55_0.iconPath then
				global_ShowBlockWords("角色完成超频后即可获得该皮肤")
			end
		else
			playermodel:setServantUsedmodel(arg_55_0.servantid, arg_55_0.selectItem, function(arg_61_0)
				print(arg_55_0.servantid, arg_55_0.selectItem, "aaaaaaaaaaaaa")

				if arg_61_0 == 1 then
					GlobalPlayRoleSound(global_get_servant_skin(arg_55_0.servantid), ROLE_CONVERSATION_TYPE.changeDress)
					arg_55_0:updateData()
					arg_55_0:updateUI()
					arg_55_0:exit()
				end
			end)
		end
	end
end

function ServantChangeSkinLayer:initDisplayValue(arg_62_1)
	self.displayPos = global_get_node_display_posy(arg_62_1, {
		Panel_Skin = {
			posY = 0,
			focusName = "Panel_Skin",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		},
		Button_skinIcon = {
			posY = 271,
			focusName = "Button_skinIcon",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		}
	})

	for iter_62_0, iter_62_1 in pairs(self.displayPos) do
		local var_62_0 = ccui.Helper:seekWidgetByName(arg_62_1, iter_62_0)

		if var_62_0 then
			var_62_0:setPositionY(iter_62_1)
		end
	end
end

function ServantChangeSkinLayer.shopPop(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	local var_63_1 = {
		function()
			return playermodel.gold
		end,
		[0] = function()
			return playermodel.diamond
		end,
		function()
			return playermodel.honor
		end,
		function()
			return playermodel.explorecoin
		end,
		[100] = function()
			return 0
		end
	}

	setmetatable(var_63_1, {
		__index = function(arg_69_0, arg_69_1)
			return function()
				return item_manager:getItemNumber(arg_69_1)
			end
		end
	})

	local var_63_2 = {
		"public/currency/UI_battleEnd_gold.png",
		[0] = "public/currency/UI_battleEnd_diamond.png",
		"public/currency/arenascene_dot_1.png",
		"public/currency/explorecoin.png",
		[1500001] = "public/currency/1500001_1.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_63_2, {
		__index = function(arg_71_0, arg_71_1)
			return "public/currency/" .. item_data[arg_71_1].image_id .. ".png"
		end
	})

	local var_63_3 = {
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[0] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end,
		[BLACK_CARD] = function()
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = BLACK_CARD
			})
		end,
		[BLACK_SP_CARD] = function()
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = BLACK_SP_CARD
			})
		end,
		[GIFT_TICKET] = function()
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer",
				callback = updateCoinLabel
			})
		end
	}

	setmetatable(var_63_3, {
		__index = function(arg_79_0, arg_79_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_79_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_63_4 = {}

	local function var_63_5(arg_81_0)
		print(dump(arg_81_0))

		local var_81_0 = var_63_4

		if arg_81_0.result == 1 then
			if not arg_81_0.selectCoupon then
				shop_manager:shop_buy(var_63_4.shoptype, var_63_4.shopitem.shopid, function(arg_82_0)
					if arg_82_0 == 1 then
						arg_63_1.have_bought = arg_63_1.have_bought + var_81_0.curbuyTime
						arg_63_1.sell_out = arg_63_1.buy_limit and arg_63_1.buy_limit <= arg_63_1.have_bought

						if item_data[var_81_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_81_0.itemid), 1000)
						end

						if var_81_0.callback then
							var_81_0.callback()
						end

						arg_63_0:updateData()
						arg_63_0:updateUI()
					elseif arg_82_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_82_0 == 3 then
						var_63_3[var_81_0.shopitem.currency]()
					end
				end, var_63_4.curbuyTime, function()
					LayerManager:removePopLayer()
				end)
			else
				shop_manager:shop_buy_with_ticket(var_63_4.shoptype, var_63_4.shopitem.shopid, function(arg_84_0)
					if arg_84_0 == 1 then
						arg_63_1.have_bought = arg_63_1.have_bought + var_81_0.curbuyTime
						arg_63_1.sell_out = arg_63_1.buy_limit and arg_63_1.buy_limit <= arg_63_1.have_bought

						if item_data[var_81_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_81_0.itemid), 1000)
						end

						if var_81_0.callback then
							var_81_0.callback()
						end

						arg_63_0:updateData()
						arg_63_0:updateUI()
					elseif arg_84_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_84_0 == 3 then
						var_63_3[var_81_0.shopitem.currency]()
					end
				end, var_63_4.curbuyTime, function()
					LayerManager:removePopLayer()
				end, arg_81_0.selectCoupon, 1)
			end
		end
	end

	local function var_63_6(arg_86_0)
		if not arg_86_0.currency2 or discount_manager:getLastPriceByItem(arg_86_0.itemid, arg_86_0.currency2, arg_86_0.discount2) < arg_86_0.discount2 then
			return true
		end

		return false
	end

	local function var_63_7(arg_93_0)
		local var_93_0 = {}

		if arg_93_0.currency2 then
			var_93_0.currency2 = arg_93_0.currency2
			var_93_0.costIcon2 = var_63_2[arg_93_0.currency2]
			var_93_0.cost2 = arg_93_0.discount2 or arg_93_0.price2
			var_93_0.cost_old2 = arg_93_0.price2
			var_93_0.discount2 = arg_93_0.discount2
		end

		var_93_0.name = item_data[arg_93_0.itemtype].name
		var_93_0.itemid = arg_93_0.itemtype
		var_93_0.shopid = arg_93_0.shopid
		var_93_0.costIcon = var_63_2[arg_93_0.currency]
		var_93_0.currency = arg_93_0.currency
		var_93_0.isnewitem = arg_93_0.isnewitem
		var_93_0.discountfinish = arg_93_0.discountfinish
		var_93_0.cost = arg_93_0.discount or arg_93_0.price
		var_93_0.quality = item_data[arg_93_0.itemtype].equip_quality or 1
		var_93_0.cost_old = arg_93_0.price
		var_93_0.bag_item_type = item_data[arg_93_0.itemtype].bag_item_type
		var_93_0.item_attr = arg_93_0.item_attr
		var_93_0.finish_time = arg_93_0.finish_time
		var_93_0.discount = arg_93_0.discount
		var_93_0.buy_limit = arg_93_0.buy_limit or 1000000
		var_93_0.have_bought = arg_93_0.have_bought or 0
		var_93_0.sell_out = arg_93_0.buy_limit and arg_93_0.buy_limit <= arg_93_0.have_bought
		var_93_0.tag = arg_93_0.tag or 0
		var_93_0.pos = arg_93_0.pos
		var_93_0.purchaseid = arg_93_0.productid

		return var_93_0
	end

	if arg_63_1.currency == 100 then
		(function(arg_89_0)
			local var_89_0 = {
				itemid = arg_89_0.itemid,
				item_attr = arg_89_0.item_attr
			}
			local var_89_1 = {
				costtype = arg_89_0.costIcon
			}

			var_89_1.costnum = arg_89_0.discount or arg_89_0.cost
			var_89_0.slidecost = var_89_1

			function var_89_0:ShopSliderCallback(arg_90_1, arg_90_2)
				if arg_90_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_89_0.have_bought >= arg_89_0.buy_limit then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				self:setTouchEnabled(false)
				shop_manager:shop_purchase(arg_89_0.shopid, arg_89_0.purchaseid, function(arg_91_0)
					if arg_91_0 == 1 then
						arg_63_1.have_bought = arg_63_1.have_bought + curbuyTime
						arg_63_1.sell_out = arg_63_1.buy_limit and arg_63_1.buy_limit <= arg_63_1.have_bought

						LayerManager:removePopLayer(arg_63_0.__queueindex)

						if item_data[var_89_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_89_0.itemid), 1000)
						end

						if arg_63_2 == 6 then
							for iter_91_0, iter_91_1 in pairs({
								{
									entityid = var_89_0.itemid
								}
							}) do
								net:rpc("use_gift_bag", {
									num = 1,
									entityid = iter_91_1.entityid
								}, function(arg_92_0)
									if arg_92_0.result == 1 then
										global_gain(arg_92_0)
										item_manager:deleteItem(iter_91_1.entityid, 1)
									else
										global_ShowBlockWords(L_MARKET_MSG.Gift_Bag_Lack)
									end
								end)
							end
						else
							LayerManager:pushInLayer("PopPurchaseResultLayer", {
								items = {
									{
										dropNum = 1,
										dropid = var_89_0.itemid,
										entityid = var_89_0.itemid
									}
								}
							})
						end

						arg_63_0:updateData()
						arg_63_0:updateUI()
					elseif arg_91_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Goods_Sended)
						audio_manager:playeffectMusicTest("sound/invalid")
					end

					if arg_90_2 then
						arg_90_2(arg_91_0)
					end
				end)
			end

			if arg_63_2 == 4 or arg_63_2 == 6 then
				arg_63_0:showBuyPop(var_89_0, nil, arg_63_3)
			else
				print("暂时没给非服装商城做人民币支付")
			end

			arg_89_0.isnewitem = false
		end)(var_63_7(arg_63_1))
	else
		(function(arg_87_0)
			local var_87_0 = {
				itemid = arg_87_0.itemid,
				item_attr = arg_87_0.item_attr
			}

			var_87_0.limitNum = arg_87_0.buy_limit and (arg_87_0.buy_limit - arg_87_0.have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or arg_87_0.buy_limit - arg_87_0.have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

			local var_87_1

			if var_63_6(arg_87_0) then
				var_87_1 = math.floor(var_63_1[arg_87_0.currency]() / arg_87_0.cost)
				var_87_0.currency = arg_87_0.currency
			else
				var_87_1 = math.floor(var_63_1[arg_87_0.currency2]() / arg_87_0.cost2)
				var_87_0.currency = arg_87_0.currency2
			end

			if var_87_1 > var_87_0.limitNum then
				var_87_0.limitNum = var_87_0.limitNum or var_87_1
			end

			local var_87_2 = arg_63_0:getResidueTime(arg_87_0.finish_time)

			if var_87_2 ~= "-1" then
				var_87_0.limit_time = L_MARKET_MSG.Rest_Time .. var_87_2
			end

			var_87_0.slidecost = {}

			if var_63_6(arg_87_0) then
				var_87_0.slidecost.costtype = arg_87_0.costIcon
				var_87_0.slidecost.costnum = arg_87_0.discount or arg_87_0.cost
				var_87_0.slidecost.nowHave = var_63_1[arg_87_0.currency]()
				var_87_0.slidecost.cost_old = arg_87_0.cost_old or var_87_0.slidecost.costnum
			else
				var_87_0.slidecost.costtype = arg_87_0.costIcon2
				var_87_0.slidecost.costnum = arg_87_0.discount2 or arg_87_0.cost2
				var_87_0.slidecost.nowHave = var_63_1[arg_87_0.currency2]()
				var_87_0.slidecost.cost_old = arg_87_0.cost_old2 or var_87_0.slidecost.costnum
			end

			function var_87_0:ShopSliderCallback(arg_88_1, arg_88_2, arg_88_3)
				if arg_88_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not self:isBright() then
					return
				end

				local var_88_0 = self.nowNum or 1

				var_63_4 = {
					curbuyTime = var_88_0,
					shoptype = arg_63_2,
					itemid = var_87_0.itemid,
					callback = arg_88_2,
					shopitem = arg_87_0
				}

				if var_63_6(arg_87_0) and arg_87_0.cost > var_63_1[arg_87_0.currency]() then
					LayerManager:removePopLayer()
					var_63_3[arg_87_0.currency]()

					return
				end

				self:setTouchEnabled(false)
				var_63_5({
					result = 1,
					selectCoupon = arg_88_3
				})
			end

			var_87_0.hideGainButton = true

			if arg_87_0.have_bought and arg_87_0.buy_limit then
				var_87_0.limit_buy_num = arg_87_0.buy_limit - arg_87_0.have_bought
				var_87_0.have_bought_num = arg_87_0.have_bought
			end

			arg_63_0:showBuyPop(var_87_0, arg_63_2, arg_63_3)

			arg_87_0.isnewitem = false
		end)(var_63_7(arg_63_1))
	end
end

function ServantChangeSkinLayer.getResidueTime(arg_94_0, arg_94_1)
	if not arg_94_1 then
		return "-1"
	end

	local var_94_5 = global_get_time_by_date(arg_94_1) - playermodel.onlineTime
	local var_94_6 = math.floor(var_94_5 / 24 / 3600)
	local var_94_7 = math.floor((var_94_5 - var_94_6 * 24 * 3600) / 3600)
	local var_94_8 = math.floor((var_94_5 - var_94_6 * 24 * 3600 - var_94_7 * 3600) / 60)

	return var_94_6 ~= 0 and string.format(L_TIME_TEXT[1], var_94_6, var_94_7) or var_94_7 ~= 0 and string.format(L_TIME_TEXT[2], var_94_7, var_94_8) or string.format(L_TIME_TEXT[3], var_94_8)
end

function ServantChangeSkinLayer.showBuyPop(arg_95_0, arg_95_1, arg_95_2, arg_95_3)
	arg_95_1.couponList = discount_manager:getCanUseCoupin(arg_95_1.itemid, arg_95_1.currency, arg_95_1.costnum or arg_95_1.slidecost.costnum, arg_95_2)

	if not arg_95_2 then
		LayerManager:pushInLayer("PopGoodsLayer", arg_95_1)
	elseif arg_95_3 == "shopitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_95_1)
	elseif arg_95_3 == "giftitem" then
		if arg_95_1.couponList and next(arg_95_1.couponList) then
			LayerManager:pushInLayer("PopGoodsLayer", arg_95_1)
		else
			LayerManager:pushInLayer("PopSkinPackage", arg_95_1)
		end
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_95_1)
	end
end

function ServantChangeSkinLayer:updateBackGround()
	local var_96_0 = 1

	if model_data[self.selectModelid].is_own_full_screen_background == 1 then
		var_96_0 = 2
	end

	local var_96_1 = model_data[self.selectModelid].backgroundid_main or 6300000

	if var_96_1 == 6300021 or var_96_1 == 6300022 then
		var_96_0 = 1
	end

	local var_96_2 = model_data[self.selectModelid].backgroundid_main or 6300000

	if self.backGroundLayer then
		self.backGroundLayer:update(var_96_2, var_96_0)
	else
		self.backGroundLayer = BackGroundLayer:create(var_96_2, var_96_0)

		self.rootLayer:addChild(self.backGroundLayer, -1)
	end
end
