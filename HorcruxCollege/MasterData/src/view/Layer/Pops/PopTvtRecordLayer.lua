PopTvtRecordLayer = class("PopTvtRecordLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.AvatarSprite")
require("view.Sprite.TvTRankSprite")

local var_0_0 = config._DEBUG and 0 or 1
local arenatft_manager = require("controller.arenatft_manager")
local arenatft_rank_data = require("data.arenatft.arenatft_rank_data")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local var_0_5 = {
	[0] = "fail",
	"win"
}
local var_0_6 = 108

function PopTvtRecordLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopTvtRecordLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopTvtRecordLayer.getArenatftData(arg_3_0)
	arenatft_manager:get_player_arenatft_records(function(arg_4_0)
		arg_3_0.records = arg_4_0.records

		arg_3_0:updateTableView()
	end)
end

local function var_0_7(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if arg_5_0 then
		for iter_5_0 = 1, #arg_5_0 do
			var_5_0[#var_5_0 + 1] = json.decode(arg_5_0[iter_5_0])
		end

		return var_5_0
	end
end

local function var_0_8(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0) do
		if type(iter_6_1) == "table" and iter_6_1.servantid then
			var_6_0[#var_6_0 + 1] = {}
			var_6_0[#var_6_0].model = global_get_servant_skin(iter_6_1.servantid)
		end
	end

	return var_6_0
end

local function var_0_9(arg_7_0)
	local var_7_0 = {}

	for iter_7_0 = 1, #arg_7_0 do
		var_7_0[#var_7_0 + 1] = {}
		var_7_0[#var_7_0].time = arg_7_0[iter_7_0].time
		var_7_0[#var_7_0].fightresult = arg_7_0[iter_7_0].fightresult
		var_7_0[#var_7_0].fightData = {}
		var_7_0[#var_7_0].fightData.players = arg_7_0[iter_7_0].playerdata
		var_7_0[#var_7_0].fightData.enemies = arg_7_0[iter_7_0].enemydata
		var_7_0[#var_7_0].playerarray = var_0_8(arg_7_0[iter_7_0].playerarray)
		var_7_0[#var_7_0].enemyarray = var_0_8(arg_7_0[iter_7_0].enemyarray)
	end

	return var_7_0
end

function PopTvtRecordLayer:init(arg_8_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopTvtRecordLayer.json" or "PopTvtRecordLayer.ExportJson")

	self:addChild(self.rootlayer)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")

	self:getArenatftData()
	self.showActions.extendVertical(self)
	self:initBg()
end

function PopTvtRecordLayer:updateTableView()
	self.tableView = cc.TableView:create(cc.size(640, 580))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setAnchorPoint(cc.p(0, 0))
	self.tableView:setPosition(-37, 70)
	self.tableView:setDelegate()
	self.rootpanel:addChild(self.tableView, 90)
	self.tableView:registerScriptHandler(function(arg_11_0, arg_11_1)
		return 640, var_0_6
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0:dequeueCell()

		if not var_10_0 then
			var_10_0 = cc.TableViewCell:create()

			local var_10_3 = self:createSprite(arg_10_1 + 1)

			var_10_3:setAnchorPoint(cc.p(0.5, 0.5))
			var_10_3:setPosition(cc.p(320, var_0_6 / 2))
			var_10_0:addChild(var_10_3)

			if arg_10_1 < 6 then
				var_10_3:setOpacity(0)
				var_10_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_10_1), cc.FadeIn:create(0.1)))
			end
		else
			local var_10_4 = var_10_0:getChildByTag(100)

			self:updateSprite(var_10_4, arg_10_1 + 1)

			if self.showEffect and arg_10_1 < 6 then
				var_10_4:setOpacity(0)
				var_10_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_10_1), cc.FadeIn:create(0.1)))
			elseif var_10_4:getOpacity() < 255 then
				var_10_4:setOpacity(255)
			end
		end

		return var_10_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_12_0, arg_12_1)
		return #self.records
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.showEffect = false
	end)))
	self.tableView:reloadData()
	ccui.Helper:seekWidgetByName(self.rootlayer, "nil"):setVisible(#self.records == 0)
end

function PopTvtRecordLayer:createSprite(arg_14_1)
	local var_14_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_record"):clone()
	local var_14_1 = var_14_0:getChildByName("Image_record_bottom")
	local var_14_2 = var_14_1:getChildByName("Image_status")
	local var_14_3 = var_14_1:getChildByName("Label_add_integral")
	local var_14_4 = var_14_1:getChildByName("Button_detail")

	var_14_0:setTag(100)
	var_14_0:setTouchEnabled(false)
	var_14_1:getChildByName("Label_name"):setString(self.records[arg_14_1].name)
	var_14_1:getChildByName("lbl_level"):setString(self.records[arg_14_1].level or 0)
	var_14_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_14_3:setPositionX(55)

	if self.records[arg_14_1].delta <= 0 then
		var_14_2:loadTexture("PopTvtRecordLayer/lose_label.png", var_0_0)
		var_14_3:setString(self.records[arg_14_1].delta)
		var_14_3:setColor(cc.c3b(182, 203, 214))
	else
		var_14_2:loadTexture("PopTvtRecordLayer/win_label.png", var_0_0)
		var_14_3:setString("+" .. self.records[arg_14_1].delta)
		var_14_3:setColor(cc.c3b(255, 231, 169))
	end

	local var_14_5 = AvatarSprite:create(self.records[arg_14_1].head_sculpture)

	var_14_5:setScale(0.5)
	var_14_5:setName("avatar_sprite")
	var_14_5:setPosition(cc.p(143, 23))
	var_14_0:addChild(var_14_5)

	local var_14_6 = TvTRankSprite:create(self.records[arg_14_1].succscore)

	var_14_6:setScale(0.5)
	var_14_6:setName("tvt_rank_sprite")
	var_14_6:setPosition(cc.p(260, 85))
	var_14_0:addChild(var_14_6)
	var_14_4:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		arenatft_manager:get_player_arenatft_record_fightdata(arg_14_1, function(arg_16_0)
			LayerManager:pushInLayer("PopTvtResultLayer", {
				layerType = "PopTvtRecordLayer",
				fightResult = var_0_5[self.records[arg_14_1].fightresult],
				playerData = {
					failscore = self.records[arg_14_1].failscore,
					rank = self.records[arg_14_1].playerrank,
					fightPower = self.records[arg_14_1].playerfightpower,
					succscore = self.records[arg_14_1].succscore,
					delta = self.records[arg_14_1].delta
				},
				enemyData = {
					name = self.records[arg_14_1].name,
					rank = self.records[arg_14_1].enemyrank,
					score = arenatft_rank_data[self.records[arg_14_1].enemyrank].score + 1,
					fightPower = self.records[arg_14_1].enemyfightpower,
					head_sculpture = self.records[arg_14_1].head_sculpture
				},
				fightData = var_0_9((var_0_7(arg_16_0.fightdata))),
				failsheild = self.records[arg_14_1].failsheild,
				isfirstwin = self.records[arg_14_1].isfirstwin
			})
		end)
	end)

	return var_14_0
end

function PopTvtRecordLayer:updateSprite(arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1:getChildByName("Image_record_bottom")
	local var_17_1 = var_17_0:getChildByName("Image_status")
	local var_17_2 = var_17_0:getChildByName("Label_add_integral")
	local var_17_3 = var_17_0:getChildByName("Button_detail")

	arg_17_1:setTag(100)
	var_17_0:getChildByName("Label_name"):setString(self.records[arg_17_2].name)
	var_17_0:getChildByName("lbl_level"):setString(self.records[arg_17_2].level or 0)

	if self.records[arg_17_2].delta <= 0 then
		var_17_1:loadTexture("PopTvtRecordLayer/lose_label.png", var_0_0)
		var_17_2:setString(self.records[arg_17_2].delta)
		var_17_2:setColor(cc.c3b(182, 203, 214))
	else
		var_17_1:loadTexture("PopTvtRecordLayer/win_label.png", var_0_0)
		var_17_2:setString("+" .. self.records[arg_17_2].delta)
		var_17_2:setColor(cc.c3b(255, 231, 169))
	end

	arg_17_1:getChildByName("avatar_sprite"):switchShowAvatar(self.records[arg_17_2].head_sculpture)
	arg_17_1:getChildByName("tvt_rank_sprite"):update(self.records[arg_17_2].succscore)
	var_17_3:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		arenatft_manager:get_player_arenatft_record_fightdata(arg_17_2, function(arg_19_0)
			LayerManager:pushInLayer("PopTvtResultLayer", {
				layerType = "PopTvtRecordLayer",
				fightResult = var_0_5[self.records[arg_17_2].fightresult],
				playerData = {
					failscore = self.records[arg_17_2].failscore,
					rank = self.records[arg_17_2].playerrank,
					fightPower = self.records[arg_17_2].playerfightpower,
					succscore = self.records[arg_17_2].succscore,
					delta = self.records[arg_17_2].delta
				},
				enemyData = {
					name = self.records[arg_17_2].name,
					rank = self.records[arg_17_2].enemyrank,
					score = arenatft_rank_data[self.records[arg_17_2].enemyrank].score + 1,
					fightPower = self.records[arg_17_2].enemyfightpower,
					head_sculpture = self.records[arg_17_2].head_sculpture
				},
				fightData = var_0_9((var_0_7(arg_19_0.fightdata))),
				failsheild = self.records[arg_17_2].failsheild,
				isfirstwin = self.records[arg_17_2].isfirstwin
			})
		end)
	end)
end

function PopTvtRecordLayer:initBg()
	local var_20_0 = ccui.Layout:create()

	var_20_0:setTouchEnabled(true)
	var_20_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_20_0:setAnchorPoint(cc.p(0, 0))
	var_20_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_20_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_20_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_20_0:setOpacity(0)
	self:addChild(var_20_0, -1)
	var_20_0:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.finishCallback then
			self.finishCallback()
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_23_0)
		self:addChild(arg_23_0, -2)
		arg_23_0:setPositionY(arg_23_0:getPositionY() - GameDisplay.fix_y)

		self.mask = ccui.ImageView:create("mainScenebg/blur_mask.png")

		self.mask:setAnchorPoint(cc.p(0, 0))
		self.mask:setPositionY(-GameDisplay.fix_y)
		self.mask:setOpacity(0)
		self.mask:runAction(cc.FadeIn:create(1))
		self:addChild(self.mask, -1)
		var_20_0:setOpacity(102)
		var_20_0:setTouchEnabled(true)
	end)
end

function PopTvtRecordLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.finishCallback then
			self.finishCallback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
