BarrageGiftRankListLayer = class("BarrageGiftRankListLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local network = require("network.network")
local var_0_2 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")

require("view.Sprite.BottomBtnList")

local level_manager = require("controller.level_manager")
local barrage_manager = require("controller.barrage_manager")
local var_0_7
local var_0_8 = 630
local var_0_9 = 124

function BarrageGiftRankListLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = BarrageGiftRankListLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function BarrageGiftRankListLayer:init(arg_3_1)
	TopcostLayer.getInstance():hideTopcostLayer()

	var_0_7 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "BarrageGiftRankListLayer.json" or "BarrageGiftRankListLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.chapter = playermodel.curMode .. "-" .. level_manager:getCurChapter(playermodel.curMode)
	self.score11 = 0
	self.rank11 = "99+"
	self.Panel_top = ccui.Helper:seekWidgetByName(self.rootLayer, "bg_top")

	ccui.Helper:seekWidgetByName(self.rootLayer, "bg"):loadTexture("mainScenebg/rankbg.jpg")

	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.bg:setAnchorPoint(cc.p(0.5, 0.5))
	self.bg:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))

	self.myrank = ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_my")

	self.myrank:setLocalZOrder(100)
	self.myrank:setVisible(false)
	self.myrank:setPositionY(self.myrank:getPositionY() + 18)

	self.RLScroll = ccui.Helper:seekWidgetByName(self.rootLayer, "scrollview")

	self.RLScroll:setVisible(false)
	self:DisplayRankList()
	self:initBottomList()

	local var_3_1 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.roleTableView = cc.TableView:create(cc.size(640, 900 + var_3_1))

	self.roleTableView:setPosition(cc.p(0, 168))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rootLayer:setName("self.roleTableView")

	self.tableviewhight = 900 + var_3_1

	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_7 = nil
		end
	end)
end

function BarrageGiftRankListLayer:initBottomList()
	local var_5_0 = BottomBtnList:create(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("FightLayer")
	end)

	var_5_0:setName("bottomlist")
	self:addChild(var_5_0, 10)

	self.bottomList = var_5_0

	self:refreshTime()
end

function BarrageGiftRankListLayer:refreshTime()
	if require("controller.time_check_manager"):getCurTime() > os.time({
		hour = 23,
		month = 3,
		year = 2020,
		min = 59,
		sec = 59,
		day = 8
	}) then
		local var_7_0 = self:getChildByName("bottomlist")
		local var_7_1 = cc.Label:createWithTTF(L_REFRESH_RNAKLIST, FONT_DES, 22)

		var_7_1:setAnchorPoint(cc.p(0, 0.5))
		var_7_1:setPosition(cc.p(var_7_0:getContentSize().width / 3, var_7_0:getContentSize().height / 2))
		var_7_0:addChild(var_7_1, 99)
	end
end

local var_0_11 = {
	"arenascenenew/rank_1.png",
	"arenascenenew/rank_2.png",
	"arenascenenew/rank_3.png",
	"arenascenenew/rank_4.png"
}
local var_0_13 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_14 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}

function BarrageGiftRankListLayer:createNode()
	local var_8_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):clone()

	var_8_0:setTouchEnabled(false)

	local var_8_1 = var_8_0:getChildByName("image_icon")

	var_8_1:setScale(0.65)
	var_8_1:setPositionX(var_8_1:getPositionX() - 30)

	local var_8_2 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_8_2:setName("title_label")
	var_8_2:setAnchorPoint(cc.p(0, 0))

	local var_8_3 = var_8_0:getChildByName("label_name")

	var_8_2:setPosition(var_8_3:getPositionX(), var_8_0:getChildByName("label_No_0").getPositionY(var_8_3))
	var_8_0:addChild(var_8_2)

	local var_8_4 = AvatarSprite:create(9200101)

	var_8_4:setPosition(cc.p(var_8_1:getPositionX() - 40, 0))
	var_8_4:setName("avatar_new")
	var_8_4:setScale(0.65)
	var_8_0:addChild(var_8_4)

	return var_8_0
end

function BarrageGiftRankListLayer.updateNode(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = ccui.Helper:seekWidgetByName(arg_9_1, "label_No")

	arg_9_1:getChildByName("title_label"):setString(L_POPULARITY)
	ccui.Helper:seekWidgetByName(arg_9_1, "label_No_0"):setString(global_trans_number(arg_9_2.popularity))
	var_9_0:setVisible(true)

	local var_9_1 = var_0_11[4]

	for iter_9_0 = 1, 3 do
		if arg_9_2.rank == iter_9_0 then
			var_9_1 = var_0_11[iter_9_0]

			var_9_0:setVisible(false)

			break
		end
	end

	arg_9_1:setBackGroundImage(var_9_1, var_0_2)
	arg_9_1:getChildByName("avatar_new"):switchShowAvatar(tonumber(arg_9_2.head_sculpture))
	arg_9_1:getChildByName("image_icon"):setVisible(false)
	ccui.Helper:seekWidgetByName(arg_9_1, "label_name"):setString(arg_9_2.name)
	var_9_0:setString(arg_9_2.rank)

	local var_9_2 = {}

	var_9_2[1] = arg_9_2.medal_1 or 0
	var_9_2[2] = arg_9_2.medal_2 or 0
	var_9_2[3] = arg_9_2.medal_3 or 0

	for iter_9_1 = 1, 3 do
		if var_9_2[iter_9_1] == 0 then
			arg_9_1:getChildByName("medal_" .. iter_9_1):setVisible(false)
		else
			local var_9_3 = arg_9_1:getChildByName("medal_" .. iter_9_1)

			var_9_3:setVisible(true)

			if not var_9_3:getChildByName("medalname") then
				local var_9_4 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_9_4:setAnchorPoint(cc.p(0.5, 0.5))
				var_9_4:setPosition(cc.p(var_9_3:getContentSize().width / 2 + 10, var_9_3:getContentSize().height / 2))
				var_9_4:setName("medalname")
				var_9_3:addChild(var_9_4)
			end

			local var_9_5 = item_data[var_9_2[iter_9_1]] or item_data[9100011]

			var_9_3:loadTexture((var_9_5.bg or nil) and ("equipment/" .. var_9_5.bg .. ".png" or var_0_13[var_9_5.equip_quality]))
			var_9_3:getChildByName("medalname"):setString(var_9_5.name)
			var_9_3:getChildByName("medalname"):enableOutline(var_0_14[var_9_5.equip_quality], 1)
			var_9_3:getChildByName("medalname"):enableShadow(var_0_14[var_9_5.equip_quality], cc.size(0, 0))
			var_9_3:getChildByName("medalname"):setVisible(var_9_5.only_bg ~= 1)
		end
	end
end

function BarrageGiftRankListLayer:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_12_0, arg_12_1)
		return var_0_8, var_0_9
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0:dequeueCell()

		if not var_11_0 then
			var_11_0 = cc.TableViewCell:create()

			local var_11_1 = self:createNode()

			var_11_1:setName("node")
			var_11_1:setPosition(cc.p(5, 0))
			self:updateNode(var_11_1, self.data[arg_11_1 + 1])

			if arg_11_1 <= math.floor(self.tableviewhight / var_0_9) then
				var_11_1:setOpacity(0)
				var_11_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_11_1), cc.FadeIn:create(0.1)))
			else
				var_11_1:setOpacity(255)
			end

			var_11_0:addChild(var_11_1)
		else
			local var_11_2 = var_11_0:getChildByName("node")

			var_11_2:setOpacity(255)
			self:updateNode(var_11_2, self.data[arg_11_1 + 1])
		end

		return var_11_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_13_0, arg_13_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function BarrageGiftRankListLayer:DisplayRankList()
	barrage_manager:get_popularity_ranklist(self.chapter, function(arg_15_0)
		if not var_0_7 then
			return
		end

		self.data = arg_15_0.data

		for iter_15_0, iter_15_1 in pairs(self.data) do
			iter_15_1.rank = iter_15_0
		end

		self:initTableView()
		barrage_manager:get_player_popularity(self.chapter, function(arg_16_0)
			self.score11 = arg_16_0.popularity or self.score11

			for iter_16_0, iter_16_1 in pairs(self.data) do
				if playermodel.playerid == iter_16_1.playerid then
					self.rank11 = iter_16_0
				end
			end

			self:MyRankNoShow()
		end)
	end)
end

function BarrageGiftRankListLayer:MyRankNoShow(arg_17_1)
	self.myrank:setVisible(true)

	local var_17_0 = self.myrank:getChildByName("label_No")
	local var_17_1 = self.myrank:getChildByName("no_ranking")
	local var_17_2 = self.myrank:getChildByName("image_icon")
	local var_17_3 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	self.myrank:getChildByName("label_rankjifen"):setString(L_POPULARITY)
	var_17_3:setString(global_trans_number(self.score11))
	var_17_3:setPositionY(var_17_3:getPositionY() + 5)

	if not item_data[playermodel.head_sculpture].spine then
		var_17_2:loadTexture("roleimage/role/wuji/" .. item_data[playermodel.head_sculpture].image_id .. ".png")
	end

	var_17_2:setScale(0.5)
	var_17_2:setVisible(false)

	local var_17_4 = AvatarSprite:create(tonumber(playermodel.head_sculpture))

	var_17_4:setPosition(cc.p(var_17_2:getPositionX() - 40, 0))
	var_17_4:setName("icon_bg_new")
	var_17_4:setScale(0.5)
	self.myrank:addChild(var_17_4)

	local var_17_5 = {}

	var_17_5[1] = playermodel.cur_medal[1] or 0
	var_17_5[2] = playermodel.cur_medal[2] or 0
	var_17_5[3] = playermodel.cur_medal[3] or 0

	for iter_17_0 = 1, 3 do
		if var_17_5[iter_17_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_17_0):setVisible(false)
		else
			local var_17_6 = self.myrank:getChildByName("medal_" .. iter_17_0)

			var_17_6:setVisible(true)

			if not var_17_6:getChildByName("medalname") then
				local var_17_7 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_17_7:setAnchorPoint(cc.p(0.5, 0.5))
				var_17_7:setPosition(cc.p(var_17_6:getContentSize().width / 2 + 10, var_17_6:getContentSize().height / 2))
				var_17_7:setName("medalname")
				var_17_6:addChild(var_17_7)
			end

			local var_17_8 = item_data[var_17_5[iter_17_0]] or item_data[9100011]

			var_17_6:loadTexture((var_17_8.bg or nil) and ("equipment/" .. var_17_8.bg .. ".png" or var_0_13[var_17_8.equip_quality]))
			var_17_6:getChildByName("medalname"):setString(var_17_8.name)
			var_17_6:getChildByName("medalname"):enableOutline(var_0_14[var_17_8.equip_quality], 1)
			var_17_6:getChildByName("medalname"):enableShadow(var_0_14[var_17_8.equip_quality], cc.size(0, 0))
			var_17_6:getChildByName("medalname"):setVisible(var_17_8.only_bg ~= 1)
		end
	end

	self.myrank:getChildByName("label_name"):setString(playermodel.nickname)

	if arg_17_1 then
		self.rank11 = arg_17_1.rank
	end

	if not self.rank11 or self.rank11 == 0 then
		self.rank11 = L_SCORE_AREAN_NO_RANK
	end

	if self.rank11 and type(self.rank11) == "number" then
		if tonumber(self.rank11) <= 100 and tonumber(self.rank11) > 0 then
			var_17_0:setVisible(true)
			var_17_1:setVisible(false)
			var_17_0:setString(self.rank11)
		else
			var_17_0:setVisible(false)
			var_17_1:setVisible(true)
		end
	else
		var_17_0:setVisible(false)
		var_17_1:setVisible(true)
	end
end

function BarrageGiftRankListLayer:fullScreen(arg_18_1)
	arg_18_1:setContentSize((GameDisplay.getScreenSize()))
	arg_18_1:setPositionY(arg_18_1:getPositionY() - GameDisplay.fix_y)
	self.Panel_top:setPosition(cc.p(GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height))
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end
