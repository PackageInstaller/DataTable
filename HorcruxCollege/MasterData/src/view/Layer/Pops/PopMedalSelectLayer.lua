PopMedalSelectLayer = class("PopMedalSelectLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.BottomBtnList")
require("view.Sprite.ItemSprite")
require("view.Sprite.TitleSprite")

local Utility = require("common.Utility")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local item_data = require("data.item_data")
local var_0_4 = 4
local var_0_5 = 174
local var_0_6 = 174 * 4 * 0.85
local var_0_7 = 228 * 0.85
local var_0_8 = 174 * 4 * 0.85
local var_0_9 = 228 * 0.85 * 6
local var_0_10 = {
	TOP = 2,
	TABEL_VIEW = 0,
	BTN_LIST = 1,
	BOTTOM = 2
}
local var_0_11 = {
	BLUE = 3,
	DREAM = 99,
	WHITE = 1,
	ORANGE = 5,
	GREEN = 2,
	ALL = 0,
	PURPLE = 4,
	ACTIVITY = 100
}
local var_0_12 = {
	var_0_11.ALL,
	var_0_11.WHITE,
	var_0_11.GREEN,
	var_0_11.BLUE,
	var_0_11.PURPLE,
	var_0_11.ORANGE,
	var_0_11.DREAM,
	var_0_11.ACTIVITY
}
local var_0_13 = {
	[var_0_11.ALL] = {
		on = "medalSelect/all_on.png",
		off = "medalSelect/all_off.png"
	},
	[var_0_11.WHITE] = {
		on = "medalSelect/white_on.png",
		off = "medalSelect/white_off.png"
	},
	[var_0_11.GREEN] = {
		on = "medalSelect/green_on.png",
		off = "medalSelect/green_off.png"
	},
	[var_0_11.BLUE] = {
		on = "medalSelect/blue_on.png",
		off = "medalSelect/blue_off.png"
	},
	[var_0_11.PURPLE] = {
		on = "medalSelect/purple_on.png",
		off = "medalSelect/purple_off.png"
	},
	[var_0_11.ORANGE] = {
		on = "medalSelect/orange_on.png",
		off = "medalSelect/orange_off.png"
	},
	[var_0_11.DREAM] = {
		on = "medalSelect/dream_on.png",
		off = "medalSelect/dream_off.png"
	},
	[var_0_11.ACTIVITY] = {
		on = "medalSelect/activity_on.png",
		off = "medalSelect/activity_off.png"
	}
}

function PopMedalSelectLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopMedalSelectLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopMedalSelectLayer:init(...)
	self:initData(...)
	self:initUI()
	self:registerEvents()
end

function PopMedalSelectLayer.initData(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_0.usedMedal = arg_4_1.usedItem or nil
	end

	if arg_4_1 then
		arg_4_0.medalPos = arg_4_1.pos or 1
	end

	arg_4_0.originMedals = item_manager:getAllHavedMedals()
	arg_4_0.medals = {}

	if arg_4_1 then
		arg_4_0.callbackList = arg_4_1.callbacklist or {}
	end

	arg_4_0.curSelectedItemId = nil
	arg_4_0.classType = nil
	arg_4_0.classBnts = {}
end

function PopMedalSelectLayer:initUI()
	self.rootpanel = ccui.Layout:create()

	self.rootpanel:setContentSize(self:getContentSize())
	self.rootpanel:setTouchEnabled(true)
	self.rootpanel:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootpanel)

	local var_5_0 = ccui.ImageView:create("mainScenebg/task_bg.jpg")

	var_5_0:setAnchorPoint(0, 0)
	self.rootpanel:addChild(var_5_0, -1)

	self.panelMain = ccui.Layout:create()

	self.panelMain:setContentSize(var_0_8, var_0_9)
	self.panelMain:setTouchEnabled(true)
	self.rootpanel:addChild(self.panelMain)
	Utility:alignPanelByParent(self.panelMain, self.rootpanel)
	self:initTop()
	self:initBottom()
	self:initBtnList()
	self:initTabelView()
	self:updateBottomBtn()
	self:switchMedalClass(var_0_11.ALL)
end

function PopMedalSelectLayer.registerEvents(arg_6_0)
	Utility:registerNodeEvent(arg_6_0)
end

function PopMedalSelectLayer:onEnter()
	print("onEnter")
	self:printAllCellInfo()
end

function PopMedalSelectLayer:printAllCellInfo()
	local var_8_0 = self.tableView:getContainer()

	if var_8_0 then
		for iter_8_0, iter_8_1 in ipairs((var_8_0:getChildren())) do
			print(string.format("cell info: viewIdx:%d,cellIdx:%d,posX:%d,posY:%d", iter_8_0, iter_8_1:getIdx(), iter_8_1:getPositionX(), iter_8_1:getPositionY()))
		end
	end
end

function PopMedalSelectLayer.onExit(arg_9_0)
	print("onExit")
end

function PopMedalSelectLayer:initBtnList()
	self.btnList = ccui.ListView:create()

	self.btnList:setName("btnList")
	self.btnList:setContentSize(cc.size(66, GameDisplay.height - self.bottomList:getContentSize().height - self.titleSprite:getContentSize().height))
	self.btnList:setClippingEnabled(true)
	self.btnList:setPosition(0, self.bottomList:getContentSize().height)
	self.btnList:setDirection(ccui.ListViewDirection.vertical)
	self.btnList:setItemsMargin(20)
	self.rootpanel:addChild(self.btnList, var_0_10.BTN_LIST)
	self.btnList:setBounceEnabled(true)

	for iter_10_0, iter_10_1 in pairs(var_0_12) do
		local var_10_0 = ccui.Button:create(var_0_13[iter_10_1].off, var_0_13[iter_10_1].on, var_0_13[iter_10_1].on, config._DEBUG and 0 or 1)

		var_10_0:setAnchorPoint(cc.p(0, 0))
		var_10_0:setName("classBtn" .. iter_10_1)
		self.btnList:pushBackCustomItem(var_10_0)

		self.classBnts[iter_10_1] = var_10_0

		Utility:addClickEventListener(var_10_0, handler(self, self.onBtnSwitch), iter_10_1)
	end
end

function PopMedalSelectLayer:onBtnSwitch(arg_11_1, arg_11_2)
	self:switchMedalClass(arg_11_2)
end

function PopMedalSelectLayer:switchMedalClass(arg_12_1)
	if self.classType == arg_12_1 then
		return
	end

	self.classType = arg_12_1
	self.curSelectedItemId = nil

	for iter_12_0, iter_12_1 in pairs(self.classBnts) do
		if iter_12_0 == arg_12_1 then
			iter_12_1:setBright(false)
		else
			iter_12_1:setBright(true)
		end
	end

	self:updateData()
	self:updateBottomBtn()
	self.tableView:reloadData()
end

function PopMedalSelectLayer:updateData()
	if self.classType == var_0_11.ALL then
		self.medals = self.originMedals

		return
	end

	local var_13_0 = {}

	local function var_13_1(arg_14_0)
		local var_14_0 = item_data[arg_14_0]

		if not item_data[arg_14_0] then
			return false
		end

		if self.classType == var_0_11.DREAM or self.classType == var_0_11.ACTIVITY then
			return self.classType == var_14_0.medal_type
		else
			return self.classType == var_14_0.equip_quality
		end
	end

	for iter_13_0, iter_13_1 in ipairs(self.originMedals) do
		if var_13_1(iter_13_1) then
			table.insert(var_13_0, iter_13_1)
		end
	end

	table.sort(var_13_0, function(arg_15_0, arg_15_1)
		if item_data[arg_15_0].equip_quality == item_data[arg_15_1].equip_quality then
			return item_data[arg_15_0].id > item_data[arg_15_1].id
		else
			return item_data[arg_15_0].equip_quality > item_data[arg_15_1].equip_quality
		end
	end)

	self.medals = var_13_0
end

function PopMedalSelectLayer:initTop()
	self.titleSprite = TitleSprite:create(L_ITEM_CONFIG_NAME.ITEMPANEL_TYPE_MEDAL, 1)

	self.titleSprite:setPosition(0, 1080 + GameDisplay.fix_y * 2)
	self.titleSprite:setName("titleSprite")
	self.rootpanel:addChild(self.titleSprite, var_0_10.TOP)

	local var_16_0 = ccui.ImageView:create("medalSelect/medal_title.png", config._DEBUG and 0 or 1)

	var_16_0:setAnchorPoint(cc.p(0, 0))
	var_16_0:setPosition(cc.p(0, 0))
	self.titleSprite:addChild(var_16_0)
end

function PopMedalSelectLayer:initBottom()
	self.bottomList = BottomBtnList:create(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end, {
		{
			name = "select",
			word = L_BUTTON_TEXT.Item_Panel_Btn.Choose,
			handler = function(self, arg_19_1)
				if arg_19_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self.isLock then
					return
				end

				self.isLock = true

				if self.curSelectedItemId then
					local var_19_0
					local var_19_1, var_19_2 = self:queryMedalEquiped(self.curSelectedItemId)

					if not var_19_1 then
						var_19_0 = self.curSelectedItemId
					end

					item_manager:setShowMedal({
						pos = var_19_2 or self.medalPos,
						medal = var_19_0
					}, function(arg_20_0)
						if var_19_0 and self.callbackList.used then
							self.callbackList.used(arg_20_0)
						elseif not var_19_0 and self.callbackList.unused then
							self.callbackList.unused(arg_20_0)
						end

						self.isLock = false
					end)
				end
			end
		},
		{
			name = "infoBtn",
			word = L_CHECK_MORE,
			handler = function(arg_21_0, arg_21_1)
				if arg_21_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not self.curSelectedItemId then
					return
				end

				LayerManager:pushInLayer("PopItemLayer", {
					hideGainButton = true,
					itemid = self.curSelectedItemId
				})
			end
		}
	})

	self.bottomList:setPosition(0, 0)
	self.rootpanel:addChild(self.bottomList, var_0_10.BOTTOM)
	self.bottomList:getChildByName("infoBtn"):loadTextures("public/button/public_button_big_blue_y.png", nil, "public/button/public_button_big_blue_y.png", config._DEBUG and 0 or 1)
	self.bottomList:getChildByName("infoBtn"):setPositionX(300)
	self.bottomList:getChildByName("infoBtn"):setVisible(false)
end

function PopMedalSelectLayer:updateBottomBtn()
	local var_22_0 = self.bottomList:getChildByName("select")

	var_22_0:setVisible(self.curSelectedItemId and true or false)

	local var_22_1 = self:queryMedalEquiped(self.curSelectedItemId)
	local var_22_2

	if var_22_1 then
		var_22_2 = L_BUTTON_TEXT.Item_Panel_Btn.Unload or L_BUTTON_TEXT.Item_Panel_Btn.Choose
	end

	local var_22_3 = var_22_1 and "public/button/public_button_blue.png" or "public/button/public_button_normal_y.png"

	var_22_0:getChildByName("word"):setString(var_22_2)
	var_22_0:loadTextures(var_22_3, nil, var_22_3, config._DEBUG and 0 or 1)
	self.bottomList:getChildByName("infoBtn"):setVisible(false)
end

function PopMedalSelectLayer:initTabelView()
	self.tableView = cc.TableView:create(cc.size(var_0_8, GameDisplay.height - self.bottomList:getContentSize().height - self.titleSprite:getContentSize().height))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setDelegate()
	self.tableView:setPositionX(GameDisplay.width - var_0_6 + 5)
	self.tableView:setPositionY(self.bottomList:getContentSize().height)
	self.rootpanel:addChild(self.tableView, var_0_10.TABEL_VIEW)
	self.tableView:registerScriptHandler(handler(self, self.numberOfCells), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:registerScriptHandler(handler(self, self.cellSizeForIndex), cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(handler(self, self.updateCellAtIndex), cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(handler(self, self.tabelViewDidScroll), cc.SCROLLVIEW_SCRIPT_SCROLL)
	self.tableView:reloadData()
end

function PopMedalSelectLayer:numberOfCells(arg_24_1)
	return math.ceil(#self.medals / var_0_4)
end

function PopMedalSelectLayer.cellSizeForIndex(arg_25_0, arg_25_1, arg_25_2)
	return var_0_6, var_0_7
end

function PopMedalSelectLayer:tabelViewDidScroll(arg_26_1)
	self:printAllCellInfo()
end

function PopMedalSelectLayer:updateCellAtIndex(arg_27_1, arg_27_2)
	print("update cell at index " .. arg_27_2)

	local var_27_0 = arg_27_1:dequeueCell()
	local var_27_1 = true

	if not var_27_0 then
		var_27_0 = cc.TableViewCell:create()
		var_27_1 = false
	end

	for iter_27_0 = 1, var_0_4 do
		if var_27_1 then
			self:updateOneItem(var_27_0, self.medals[var_0_4 * arg_27_2 + iter_27_0], iter_27_0)
		else
			self:createOneItem(var_27_0, self.medals[var_0_4 * arg_27_2 + iter_27_0], iter_27_0)
		end
	end

	return var_27_0
end

function PopMedalSelectLayer:createOneItem(arg_28_1, arg_28_2, arg_28_3)
	if not arg_28_2 then
		return
	end

	local var_28_0 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", config._DEBUG and 0 or 1)

	var_28_0:setScale(0.8)
	var_28_0:setAnchorPoint(0, 0)
	var_28_0:setSwallowTouches(false)
	var_28_0:setName("btnSketch_" .. arg_28_3)

	var_28_0.id = arg_28_2

	Utility:addClickEventListener(var_28_0, handler(self, self.onClickItem))

	local var_28_1 = ItemSprite:createNewWithItemId(arg_28_2)
	local var_28_2 = var_28_0:getContentSize()

	var_28_1:setPosition(var_28_2.width / 2, var_28_2.height / 2)
	var_28_1:setName("itemSprite")
	var_28_0:addChild(var_28_1)
	var_28_0:setPosition(var_0_5 * 0.85 * (arg_28_3 - 1), 0)

	local var_28_3

	if config._DEBUG then
		var_28_3 = cc.Sprite:create("public/box/used_on.png") or cc.Sprite:createWithSpriteFrameName("public/box/used_on.png")
	end

	var_28_3:setName("sprEquip")
	var_28_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_28_3:setPosition(cc.p(var_28_1:getContentSize().width / 2, var_28_1:getContentSize().height * 2 / 5))
	var_28_0:addChild(var_28_3, 2)

	local var_28_4 = cc.Label:createWithTTF(L_COMMON_WARNING.Using, FONT_TITLE, 22)

	var_28_4:setColor(cc.c3b(255, 100, 0))
	var_28_4:setPosition(var_28_3:getContentSize().width / 2, var_28_3:getContentSize().height / 2)
	var_28_3:addChild(var_28_4)
	var_28_3:setVisible((self:queryMedalEquiped(arg_28_2)))
	arg_28_1:addChild(var_28_0)
end

function PopMedalSelectLayer:updateOneItem(arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_1:getChildByName("btnSketch_" .. arg_29_3)

	if not var_29_0 and arg_29_2 then
		self:createOneItem(arg_29_1, arg_29_2, arg_29_3)

		return
	elseif not var_29_0 then
		return
	end

	if not arg_29_2 then
		var_29_0:setVisible(false)

		return
	end

	var_29_0:setVisible(true)
	var_29_0:getChildByName("sprEquip"):setVisible((self:queryMedalEquiped(arg_29_2)))

	local var_29_1 = var_29_0:getChildByName("itemSprite")

	if var_29_0.id ~= arg_29_2 then
		if config._DEBUG then
			var_29_1:setTexture(ITEM_BOX_UI .. "new_item_bg" .. item_data[arg_29_2].equip_quality .. ".png")
		else
			var_29_1:setSpriteFrame(ITEM_BOX_UI .. "new_item_bg" .. item_data[arg_29_2].equip_quality .. ".png")
		end

		var_29_1:update_medal_icon(arg_29_2)
	end

	var_29_0.id = arg_29_2

	self:updateSelectedItem(var_29_0)
end

function PopMedalSelectLayer.queryMedalEquiped(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in pairs(playermodel.cur_medal) do
		if iter_30_1 == arg_30_1 then
			return true, iter_30_0
		end
	end

	return false, nil
end

function PopMedalSelectLayer:onClickItem(arg_31_1)
	self.curSelectedItemId = arg_31_1.id

	self:updateShowingCells()
	self:updateBottomBtn()
end

function PopMedalSelectLayer:updateShowingCells()
	local var_32_0, var_32_1 = GetTableViewShowCellIdx(self.tableView, {
		cellsize = cc.size(var_0_6, var_0_7),
		maxcount = math.ceil(#self.medals / var_0_4)
	})

	for iter_32_0 = var_32_0, var_32_1 do
		self.tableView:updateCellAtIndex(iter_32_0)
	end
end

function PopMedalSelectLayer:updateSelectedItem(arg_33_1)
	if self.curSelectedItemId == arg_33_1.id then
		self:setItemSelected(arg_33_1, true)
	else
		self:setItemSelected(arg_33_1, false)
	end
end

function PopMedalSelectLayer:setItemSelected(arg_34_1, arg_34_2)
	local var_34_0 = arg_34_1:getChildByName("panelSelect")

	if arg_34_2 then
		var_34_0 = var_34_0 or self:createItemHightLight(arg_34_1)
	end

	if var_34_0 and not arg_34_2 then
		var_34_0:removeFromParent()
	end
end

function PopMedalSelectLayer.createItemHightLight(arg_35_0, arg_35_1)
	local var_35_0 = 1
	local var_35_1 = ccui.Layout:create()
	local var_35_2

	if config._DEBUG then
		var_35_2 = cc.Sprite:create("public/box/new_item_bg_on1.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_on1.png")
	end

	var_35_2:setPosition(arg_35_1:getContentSize().width / 2, arg_35_1:getContentSize().height / 2)
	var_35_1:addChild(var_35_2)

	local var_35_3 = cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(var_35_0), cc.ScaleTo:create(var_35_0, 1.1)), cc.Spawn:create(cc.FadeIn:create(var_35_0), cc.ScaleTo:create(var_35_0, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1))))
	local var_35_4 = cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(var_35_0), cc.ScaleTo:create(var_35_0, 1)), cc.Spawn:create(cc.FadeOut:create(var_35_0), cc.ScaleTo:create(var_35_0, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1))))

	for iter_35_0 = 1, 2 do
		local var_35_5

		if config._DEBUG then
			var_35_5 = cc.Sprite:create("public/box/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_on2.png")

			if iter_35_0 == 1 then
				var_35_5:setScale(1.1)
				var_35_5:setOpacity(0)
				var_35_5:runAction(var_35_3)

				goto label_35_0
			end
		end

		var_35_5:runAction(var_35_4)

		::label_35_0::

		var_35_5:setPosition(arg_35_1:getContentSize().width / 2, arg_35_1:getContentSize().height / 2)
		var_35_1:addChild(var_35_5, 0, "imgAct_" .. iter_35_0)
	end

	var_35_1:setName("panelSelect")
	arg_35_1:addChild(var_35_1)

	return var_35_1
end

function PopMedalSelectLayer:show()
	self.showActions.extendVertical(self)
end

function PopMedalSelectLayer:hide()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
