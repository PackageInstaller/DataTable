ActivityFallingRankLayer = class("ActivityFallingRankLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local network = require("network.network")
local var_0_2 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")

require("view.Sprite.BottomBtnList")

local var_0_5 = 630
local var_0_6 = 124

function ActivityFallingRankLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityFallingRankLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityFallingRankLayer:init(arg_3_1)
	self.activityid = arg_3_1.activityid
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "StarRankListLayer.json" or "StarRankListLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.score11 = arg_3_1.maxScore
	self.type = arg_3_1.type
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

	local var_3_0 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.roleTableView = cc.TableView:create(cc.size(640, 900 + var_3_0))

	self.roleTableView:setPosition(cc.p(0, 168))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

	self.tableviewhight = 900 + var_3_0

	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function ActivityFallingRankLayer:initBottomList()
	local var_5_0 = BottomBtnList:create(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	var_5_0:setName("bottomlist")
	self:addChild(var_5_0, 10)

	self.bottomList = var_5_0
end

local var_0_7 = {
	"arenascenenew/rank_1.png",
	"arenascenenew/rank_2.png",
	"arenascenenew/rank_3.png",
	"arenascenenew/rank_4.png"
}
local var_0_9 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_10 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}

function ActivityFallingRankLayer:DisplayRankList()
	network:rpc("activity_jumpgame_rank", {
		start = 1,
		count = 100,
		activityid = self.activityid,
		type = self.type
	}, function(arg_8_0)
		self.data = arg_8_0.list

		for iter_8_0, iter_8_1 in pairs(self.data) do
			if playermodel.playerid == iter_8_1.playerid then
				self.rank11 = iter_8_0
			end
		end

		for iter_8_2, iter_8_3 in pairs(self.data) do
			iter_8_3.rank = iter_8_2
		end

		self:initTableView()
		self:MyRankNoShow()
	end)
end

function ActivityFallingRankLayer:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_11_0, arg_11_1)
		return var_0_5, var_0_6
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0:dequeueCell()

		if not var_10_0 then
			var_10_0 = cc.TableViewCell:create()

			local var_10_1 = self:createNode(self.data[arg_10_1 + 1])

			var_10_1:setName("node")
			var_10_1:setAnchorPoint(cc.p(0, 0))
			var_10_1:setPosition(cc.p(5, 0))
			self:updateNode(var_10_1, self.data[arg_10_1 + 1])

			if arg_10_1 <= math.floor(self.tableviewhight / var_0_6) then
				var_10_1:setOpacity(0)
				var_10_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_10_1), cc.FadeIn:create(0.1)))
			else
				var_10_1:setOpacity(255)
			end

			var_10_0:addChild(var_10_1)
		else
			local var_10_2 = var_10_0:getChildByName("node")

			var_10_2:setOpacity(255)
			self:updateNode(var_10_2, self.data[arg_10_1 + 1])
		end

		return var_10_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_12_0, arg_12_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function ActivityFallingRankLayer:createNode(arg_13_1)
	local var_13_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):clone()

	var_13_0:setTouchEnabled(true)
	var_13_0:setSwallowTouches(false)
	var_13_0:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_14_0

		if math.abs(arg_14_0:getTouchBeganPosition().y - arg_14_0:getTouchEndPosition().y) > 50 then
			do return end

			var_14_0 = {
				playeruid = arg_13_1.playerid
			}
		end

		function var_14_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_14_0)
	end)

	local var_13_1 = var_13_0:getChildByName("image_icon")

	var_13_1:setScale(0.65)
	var_13_1:setPositionX(var_13_1:getPositionX() - 30)

	local var_13_2 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_13_2:setName("title_label")
	var_13_2:setAnchorPoint(cc.p(0, 0))

	local var_13_3 = var_13_0:getChildByName("label_name")

	var_13_2:setPosition(var_13_3:getPositionX(), var_13_0:getChildByName("label_No_0").getPositionY(var_13_3))
	var_13_0:addChild(var_13_2)

	local var_13_4 = AvatarSprite:create(9200101)

	var_13_4:setPosition(cc.p(var_13_1:getPositionX() - 40, 0))
	var_13_4:setName("avatar_new")
	var_13_4:setScale(0.65)
	var_13_0:addChild(var_13_4)

	return var_13_0
end

function ActivityFallingRankLayer.updateNode(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:setTouchEnabled(true)
	arg_16_1:setSwallowTouches(false)
	arg_16_1:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_17_0

		if math.abs(arg_17_0:getTouchBeganPosition().y - arg_17_0:getTouchEndPosition().y) > 50 then
			do return end

			var_17_0 = {
				playeruid = arg_16_2.playerid
			}
		end

		function var_17_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_17_0)
	end)

	local var_16_0 = ccui.Helper:seekWidgetByName(arg_16_1, "label_No")

	arg_16_1:getChildByName("title_label"):setString(L_FALLINGLAYER[1])
	ccui.Helper:seekWidgetByName(arg_16_1, "label_No_0"):setString(global_trans_number(arg_16_2.score))
	var_16_0:setVisible(true)

	local var_16_1 = var_0_7[4]

	for iter_16_0 = 1, 3 do
		if arg_16_2.rank == iter_16_0 then
			var_16_1 = var_0_7[iter_16_0]

			var_16_0:setVisible(false)

			break
		end
	end

	arg_16_1:loadTextures(var_16_1, var_16_1, var_16_1, var_0_2)
	arg_16_1:getChildByName("avatar_new"):switchShowAvatar(tonumber(arg_16_2.head_sculpture))
	arg_16_1:getChildByName("image_icon"):setVisible(false)
	ccui.Helper:seekWidgetByName(arg_16_1, "label_name"):setString(arg_16_2.name)
	var_16_0:setString(arg_16_2.rank)

	local var_16_2 = {}

	var_16_2[1] = arg_16_2.medal_1 or 0
	var_16_2[2] = arg_16_2.medal_2 or 0
	var_16_2[3] = arg_16_2.medal_3 or 0

	for iter_16_1 = 1, 3 do
		if var_16_2[iter_16_1] == 0 then
			arg_16_1:getChildByName("medal_" .. iter_16_1):setVisible(false)
		else
			local var_16_3 = arg_16_1:getChildByName("medal_" .. iter_16_1)

			var_16_3:setVisible(true)

			if not var_16_3:getChildByName("medalname") then
				local var_16_4 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_16_4:setAnchorPoint(cc.p(0.5, 0.5))
				var_16_4:setPosition(cc.p(var_16_3:getContentSize().width / 2 + 10, var_16_3:getContentSize().height / 2))
				var_16_4:setName("medalname")
				var_16_3:addChild(var_16_4)
			end

			local var_16_5 = item_data[var_16_2[iter_16_1]] or item_data[9100011]

			var_16_3:loadTexture((var_16_5.bg or nil) and ("equipment/" .. var_16_5.bg .. ".png" or var_0_9[var_16_5.equip_quality]))
			var_16_3:getChildByName("medalname"):setString(var_16_5.name)
			var_16_3:getChildByName("medalname"):enableOutline(var_0_10[var_16_5.equip_quality], 1)
			var_16_3:getChildByName("medalname"):enableShadow(var_0_10[var_16_5.equip_quality], cc.size(0, 0))
			var_16_3:getChildByName("medalname"):setVisible(var_16_5.only_bg ~= 1)
		end
	end
end

function ActivityFallingRankLayer:MyRankNoShow(arg_19_1)
	self.myrank:setVisible(true)

	local var_19_0 = self.myrank:getChildByName("label_No")
	local var_19_1 = self.myrank:getChildByName("no_ranking")
	local var_19_2 = self.myrank:getChildByName("image_icon")
	local var_19_3 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	self.myrank:getChildByName("label_rankjifen"):setString(L_FALLINGLAYER[1])
	var_19_3:setString(global_trans_number(self.score11))
	var_19_3:setPositionY(var_19_3:getPositionY() + 5)

	if not item_data[playermodel.head_sculpture].spine then
		var_19_2:loadTexture("roleimage/role/wuji/" .. item_data[playermodel.head_sculpture].image_id .. ".png")
	end

	var_19_2:setScale(0.5)
	var_19_2:setVisible(false)

	local var_19_4 = AvatarSprite:create(tonumber(playermodel.head_sculpture))

	var_19_4:setPosition(cc.p(var_19_2:getPositionX() - 40, 0))
	var_19_4:setName("icon_bg_new")
	var_19_4:setScale(0.5)
	self.myrank:addChild(var_19_4)

	local var_19_5 = {}

	var_19_5[1] = playermodel.cur_medal[1] or 0
	var_19_5[2] = playermodel.cur_medal[2] or 0
	var_19_5[3] = playermodel.cur_medal[3] or 0

	for iter_19_0 = 1, 3 do
		if var_19_5[iter_19_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_19_0):setVisible(false)
		else
			local var_19_6 = self.myrank:getChildByName("medal_" .. iter_19_0)

			var_19_6:setVisible(true)

			if not var_19_6:getChildByName("medalname") then
				local var_19_7 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_19_7:setAnchorPoint(cc.p(0.5, 0.5))
				var_19_7:setPosition(cc.p(var_19_6:getContentSize().width / 2 + 10, var_19_6:getContentSize().height / 2))
				var_19_7:setName("medalname")
				var_19_6:addChild(var_19_7)
			end

			local var_19_8 = item_data[var_19_5[iter_19_0]] or item_data[9100011]

			var_19_6:loadTexture((var_19_8.bg or nil) and ("equipment/" .. var_19_8.bg .. ".png" or var_0_9[var_19_8.equip_quality]))
			var_19_6:getChildByName("medalname"):setString(var_19_8.name)
			var_19_6:getChildByName("medalname"):enableOutline(var_0_10[var_19_8.equip_quality], 1)
			var_19_6:getChildByName("medalname"):enableShadow(var_0_10[var_19_8.equip_quality], cc.size(0, 0))
			var_19_6:getChildByName("medalname"):setVisible(var_19_8.only_bg ~= 1)
		end
	end

	self.myrank:getChildByName("label_name"):setString(playermodel.nickname)

	if arg_19_1 then
		self.rank11 = arg_19_1.rank
	end

	if not self.rank11 or self.rank11 == 0 then
		self.rank11 = L_SCORE_AREAN_NO_RANK
	end

	if self.rank11 and type(self.rank11) == "number" then
		if tonumber(self.rank11) <= 100 and tonumber(self.rank11) > 0 then
			var_19_0:setVisible(true)
			var_19_1:setVisible(false)
			var_19_0:setString(self.rank11)
		else
			var_19_0:setVisible(false)
			var_19_1:setVisible(true)
		end
	else
		var_19_0:setVisible(false)
		var_19_1:setVisible(true)
	end
end

function ActivityFallingRankLayer:fullScreen(arg_20_1)
	arg_20_1:setContentSize((GameDisplay.getScreenSize()))
	arg_20_1:setPositionY(arg_20_1:getPositionY() - GameDisplay.fix_y)
	self.Panel_top:setPosition(cc.p(GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height))
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end
