ActivityHexagonDispelLayer = class("ActivityHexagonDispelLayer", function()
	return ccui.Layout:create()
end)

local ObjectPool = require("view.Layer.ObjectPool")
local RoleDefault = require("controller.RoleDefault")
local var_0_2 = config._DEBUG and 0 or 1
local activity_hexagon_dispel_manager = require("controller.activity_hexagon_dispel_manager")
local playermodel = require("model.playermodel")
local var_0_5 = 72
local var_0_6 = 65
local var_0_7 = 5
local var_0_8 = 1.732
local var_0_9 = 0
local var_0_10 = 1
local var_0_11 = 2
local var_0_12 = 3
local var_0_13 = 4
local var_0_14 = 5
local var_0_15 = 6
local var_0_16 = 7
local var_0_17 = {
	[0] = "box_null.png",
	"box_purple.png",
	"box_orange.png",
	"box_pink.png",
	"box_yellow.png",
	"box_blue.png",
	"box_green.png",
	"box_white.png"
}
local var_0_21 = 100
local var_0_22 = 20
local var_0_23 = 40
local var_0_24 = 5
local var_0_25 = 5
local var_0_26 = {
	30,
	60,
	100,
	150,
	200
}

function ActivityHexagonDispelLayer:initBoxsPool()
	local var_2_0 = ObjectPool:new()

	for iter_2_0 = 1, var_0_21 do
		local var_2_1 = ccui.ImageView:create(self.resPath .. "box_null.png", var_0_2)

		var_2_1:setAnchorPoint(0.5, 0.5)
		var_2_1:setName("b_" .. iter_2_0)
		self.panelBg:addChild(var_2_1)
		var_2_0:createObject(var_2_1)
	end

	function var_2_0.getObjectByColor(arg_3_0)
		local var_3_0 = self.boxsPool:getObject()

		var_3_0:loadTexture(self.resPath .. var_0_17[arg_3_0], var_0_2)

		return var_3_0
	end

	self.boxsPool = var_2_0
end

function ActivityHexagonDispelLayer:createSelectBoxs(arg_4_1, arg_4_2)
	local var_4_0 = ccui.ImageView:create(self.resPath .. var_0_17[arg_4_1], var_0_2)

	var_4_0:setAnchorPoint(0.5, 0.5)
	arg_4_2:addChild(var_4_0)

	return var_4_0
end

function ActivityHexagonDispelLayer.create(arg_5_0, arg_5_1)
	local var_5_0 = ActivityHexagonDispelLayer.new()

	var_5_0:init(arg_5_1)

	return var_5_0
end

function ActivityHexagonDispelLayer:init(arg_6_1)
	self.activityId = arg_6_1.activityId
	self.layerName = "ActivityHexagonDispelLayer_" .. self.activityId
	self.resPath = string.format("ActivityHexagonDispelLayer_%s/", self.activityId)

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootlayer = cc.Layer:create()

	self:addChild(self.rootlayer)
	self.rootlayer:setPosition(0, -GameDisplay.fix_y)

	local var_6_0 = ccui.ImageView:create(self.resPath .. "bg.png", var_0_2)

	self.rootlayer:addChild(var_6_0)
	var_6_0:setAnchorPoint(0, 0)
	var_6_0:setPosition(0, 0)

	self.hexagonsArray = {}
	self.restoreArray = {}
	self.changeArray = {}
	self.selectChange = 0
	self.maxScore = 0
	self.curScore = 0
	self.select_panel_info = {}

	self:initTitle()
	self:initBottom()
	self:initScore()
	self:initHexagonPanel()
	self:initSelectBg()
	self:initBoxsPool()
	activity_hexagon_dispel_manager:getPlayerData(self.activityId, function(arg_7_0)
		self:loadHexagonPanel(arg_7_0.color_data)
		self:updateSelectPaenlByServer(arg_7_0.select_panel_info)
		self:updateSelectPaenl()
		self:addListenerSelect()
		self.maxScoreLabel:setString(arg_7_0.max_score)
		self.curScoreLabel:setString(arg_7_0.score)

		self.can_buy_count = arg_7_0.can_buy_count
		self.selectChange = arg_7_0.cur_replace_count

		self.selectChangeLabel:setString(L_HEXA_CHANGE_REAMIN .. self.selectChange .. "/" .. var_0_24)

		self.curScore = arg_7_0.score
	end)
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			TextureManager:removeLayerTextures({
				self.layerName
			})
		end
	end)
end

function ActivityHexagonDispelLayer:initTitle()
	local var_9_0 = ccui.Button:create(self.resPath .. "title.png", nil, self.resPath .. "title.png", var_0_2)

	self.rootlayer:addChild(var_9_0)
	var_9_0:setAnchorPoint(0.5, 1)
	var_9_0:setPosition(GameDisplay.width / 2, GameDisplay.height + 36 - GameDisplay.fix_y * 0.5)
	var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityHexagonDispelLayer"
		})
	end)
end

function ActivityHexagonDispelLayer:initBottom()
	local var_11_0 = ccui.Button:create(self.resPath .. "btn_return.png", nil, self.resPath .. "btn_return.png", var_0_2)

	self.rootlayer:addChild(var_11_0)
	var_11_0:setAnchorPoint(0.5, 0)
	var_11_0:setPosition(100, 30)
	var_11_0:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	local var_11_1 = ccui.Button:create(self.resPath .. "btn_replacement.png", nil, self.resPath .. "btn_replacement.png", var_0_2)

	self.rootlayer:addChild(var_11_1)
	var_11_1:setAnchorPoint(0.5, 0)
	var_11_1:setPosition(GameDisplay.width / 2, 135)
	var_11_1:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.selectChange > 0 then
			self.selectChange = self.selectChange - 1
			self.selectBg1.hasBoxs = false
			self.selectBg2.hasBoxs = false
			self.selectBg3.hasBoxs = false

			self:updateSelectPaenl()
			self.selectChangeLabel:setString(L_HEXA_CHANGE_REAMIN .. self.selectChange .. "/" .. var_0_24)

			if self:checkGamesEnd() then
				self:gameFailed()
			end
		else
			local var_13_1
			local var_13_0

			if self.can_buy_count <= 0 then
				global_ShowBlockWords("购买次数已耗尽！")

				do return end

				var_13_0 = {
					costtype = "diamond",
					surecallback = function()
						self:buySelectChance()
					end,
					cost = var_0_26[var_0_25 - self.can_buy_count + 1],
					own = playermodel.diamond
				}
				var_13_1 = {
					titleImage = "title_warorder.png",
					button = L_BUY_TIMES_MSG_MODETYPE_2.button
				}
			end

			var_13_1.des = string.format("消耗%d魂晶购买一次", var_0_26[var_0_25 - self.can_buy_count + 1])
			var_13_0.labels = var_13_1

			LayerManager:pushInLayer("PopDoLayer", var_13_0)
		end
	end)

	local var_11_2 = ccui.Button:create(self.resPath .. "btn_rank.png", nil, self.resPath .. "btn_rank.png", var_0_2)

	self.rootlayer:addChild(var_11_2)
	var_11_2:setAnchorPoint(0.5, 1)
	var_11_2:setPosition(GameDisplay.width - 80, GameDisplay.height - 240 + 63 - GameDisplay.fix_y * 0.9)
	var_11_2:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("HexagonRankListLayer", {
			activityId = self.activityId
		})
	end)

	local var_11_3 = cc.Label:createWithTTF(L_HEXA_CHANGE_REAMIN .. var_0_24 .. "/" .. var_0_24, FONT_NAME, 20)

	self.rootlayer:addChild(var_11_3)
	var_11_3:setColor(cc.c3b(253, 234, 194))
	var_11_3:setAnchorPoint(0.5, 0)
	var_11_3:setPosition(GameDisplay.width / 2, 105)

	self.selectChangeLabel = var_11_3

	local var_11_4 = ccui.Button:create(self.resPath .. "shop_btn.png", nil, self.resPath .. "shop_btn.png", var_0_2)

	var_11_4:setAnchorPoint(0, 0)
	var_11_4:setPosition(GameDisplay.width / 2, 30)
	self.rootlayer:addChild(var_11_4)
	var_11_4:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_16_0 = {
			"1-" .. self.activityId .. "01"
		}

		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = var_16_0,
			showType = var_16_0[1]
		})
	end)

	local var_11_5 = ccui.Button:create(self.resPath .. "task_btn.png", nil, self.resPath .. "task_btn.png", var_0_2)

	var_11_5:setAnchorPoint(0, 0)
	var_11_5:setPosition(GameDisplay.width / 2 + 160, 30)
	self.rootlayer:addChild(var_11_5)
	var_11_5:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityGameTaskLayer", {
			uiconfmodule = "hexagon",
			activityId = self.activityId
		})
	end)
end

function ActivityHexagonDispelLayer:initScore()
	local var_18_0 = ccui.ImageView:create(self.resPath .. "curScore.png", var_0_2)

	self.rootlayer:addChild(var_18_0)
	var_18_0:setAnchorPoint(0, 1)
	var_18_0:setPosition(230, GameDisplay.height - 240 + 63 - GameDisplay.fix_y * 0.9)

	local var_18_1 = cc.Label:createWithTTF(0, FONT_NAME, 24)

	var_18_1:setColor(cc.c3b(253, 234, 194))
	var_18_0:addChild(var_18_1)
	var_18_1:setPosition(2 * var_18_0:getContentSize().width / 3, var_18_0:getContentSize().height / 2)

	self.curScoreLabel = var_18_1

	local var_18_2 = ccui.ImageView:create(self.resPath .. "maxScore.png", var_0_2)

	self.rootlayer:addChild(var_18_2)
	var_18_2:setAnchorPoint(0, 1)
	var_18_2:setPosition(20, GameDisplay.height - 240 + 63 - GameDisplay.fix_y * 0.9)

	local var_18_3 = cc.Label:createWithTTF(self.maxScore, FONT_NAME, 24)

	var_18_3:setColor(cc.c3b(253, 234, 194))
	var_18_2:addChild(var_18_3)
	var_18_3:setPosition(2 * var_18_2:getContentSize().width / 3, var_18_2:getContentSize().height / 2)

	self.maxScoreLabel = var_18_3

	local var_18_4 = ccui.Button:create(self.resPath .. "save_btn.png", nil, self.resPath .. "save_btn.png", var_0_2)

	var_18_4:setPosition(50, 830 + GameDisplay.fix_y)
	self.rootlayer:addChild(var_18_4)
	var_18_4:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:savePlayerData(function(arg_20_0)
			self.maxScoreLabel:setString(arg_20_0.max_score)
			global_ShowBlockWords("保存成功！")
		end)
	end)
end

function ActivityHexagonDispelLayer:initHexagonPanel()
	local var_21_0 = ccui.ImageView:create(self.resPath .. "panelBg.png", var_0_2)

	self.rootlayer:addChild(var_21_0)
	var_21_0:setAnchorPoint(0.5, 0.5)
	var_21_0:setPosition(GameDisplay.cx, 618 + GameDisplay.fix_y * 0.5)
	var_21_0:setLocalZOrder(0)

	self.panelBg = var_21_0

	for iter_21_0 = 1, 2 * var_0_7 - 1 do
		local var_21_1 = {}

		for iter_21_1 = 1, var_0_7 + iter_21_0 - 1 do
			local var_21_2 = false

			if iter_21_0 <= 5 then
				var_21_2 = true
			elseif iter_21_1 > iter_21_0 - 5 and iter_21_1 <= 9 then
				var_21_2 = true
			end

			local var_21_3
			local var_21_4

			if var_21_2 then
				var_21_4 = ccui.ImageView:create(self.resPath .. "box_null.png", var_0_2)

				var_21_0:addChild(var_21_4)
				var_21_4:setAnchorPoint(0.5, 0.5)

				local var_21_5 = var_21_0:getContentSize().width / 2 + (iter_21_1 - 5) * var_0_6 + 0.5 * (5 - iter_21_0) * var_0_6
				local var_21_6 = var_21_0:getContentSize().height / 2 + (5 - iter_21_0) * var_0_6 * var_0_8 / 2

				var_21_4:setPosition(var_21_5, var_21_6)

				var_21_3 = var_21_0:convertToWorldSpace(cc.p(var_21_5, var_21_6))
			end

			var_21_1[iter_21_1] = {
				flag = var_21_2,
				color = var_0_9,
				ImageView = var_21_4,
				BoxWorldPosition = var_21_3
			}
		end

		self.hexagonsArray[iter_21_0] = var_21_1
	end
end

function ActivityHexagonDispelLayer:initSelectBg()
	local var_22_0 = ccui.Button:create(self.resPath .. "selectBg.png", nil, self.resPath .. "selectBg.png", var_0_2)

	self.rootlayer:addChild(var_22_0)
	var_22_0:setAnchorPoint(0, 0)
	var_22_0:setPosition(20, 200)
	var_22_0:setLocalZOrder(1)

	self.selectBg1 = {
		hasBoxs = false,
		bg = var_22_0
	}

	local var_22_1 = ccui.Button:create(self.resPath .. "selectBg.png", nil, self.resPath .. "selectBg.png", var_0_2)

	self.rootlayer:addChild(var_22_1)
	var_22_1:setAnchorPoint(0.5, 0)
	var_22_1:setPosition(GameDisplay.width / 2, 200)
	var_22_1:setLocalZOrder(1)

	self.selectBg2 = {
		hasBoxs = false,
		bg = var_22_1
	}

	local var_22_2 = ccui.Button:create(self.resPath .. "selectBg.png", nil, self.resPath .. "selectBg.png", var_0_2)

	self.rootlayer:addChild(var_22_2)
	var_22_2:setAnchorPoint(1, 0)
	var_22_2:setPosition(GameDisplay.width - 20, 200)
	var_22_2:setLocalZOrder(1)

	self.selectBg3 = {
		hasBoxs = false,
		bg = var_22_2
	}
end

function ActivityHexagonDispelLayer:addListenerSelect()
	for iter_23_0 = 1, 3 do
		self["selectBg" .. iter_23_0].bg:addTouchEventListener(function(arg_24_0, arg_24_1)
			if not self["selectBg" .. iter_23_0].hasBoxs then
				return
			end

			if self.ismoving_index and self.ismoving_index ~= iter_23_0 then
				return
			end

			self.ismoving_index = iter_23_0

			local var_24_0 = self["selectBg" .. iter_23_0].bg
			local var_24_1 = self["selectBg" .. iter_23_0].bg:getChildByName("selectBoxsNode")
			local var_24_2 = false

			if arg_24_1 == ccui.TouchEventType.began then
				return
			elseif arg_24_1 == ccui.TouchEventType.moved then
				var_24_1:setScale(1)

				local var_24_3 = arg_24_0:getTouchMovePosition().x
				local var_24_4 = arg_24_0:getTouchMovePosition().y

				var_24_1:setPosition(var_24_0:convertToNodeSpace(cc.p(var_24_3, var_24_4)).x, var_24_0:convertToNodeSpace(cc.p(var_24_3, var_24_4)).y)

				var_24_2 = true

				self:checkIsPutIn(var_24_1)
			elseif arg_24_1 == ccui.TouchEventType.ended then
				-- block empty
			end

			if not var_24_2 then
				self.ismoving_index = nil

				var_24_1:setPosition(var_24_0:getContentSize().width / 2, var_24_0:getContentSize().height / 2)
				var_24_1:setScale(0.6)

				if #self.changeArray ~= 0 then
					for iter_24_0, iter_24_1 in ipairs(self.changeArray) do
						self.changeArray[iter_24_0].color = self["selectBg" .. iter_23_0].color
					end

					self.curScore = self.curScore + #self.changeArray * var_0_22

					self.curScoreLabel:setString(self.curScore)
					self:updateHexagonPanel()

					self.changeArray = {}
					self.restoreArray = self:checkIsScore()

					if #self.restoreArray > 0 then
						self.curScore = self.curScore + #self.restoreArray * var_0_23

						self.curScoreLabel:setString(self.curScore)
						print("检测到一排，清除")
						self:updateHexagonPanel(true)
					end

					self.restoreArray = {}
					self["selectBg" .. iter_23_0].hasBoxs = false

					self:updateSelectPaenl()

					if self:checkGamesEnd() then
						self:gameFailed()
					end
				end
			end
		end)
	end
end

function ActivityHexagonDispelLayer:initEndPanel()
	local var_25_0 = ccui.Layout:create()

	var_25_0:setContentSize(cc.size(640, 1600))
	var_25_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_25_0:setCascadeOpacityEnabled(false)
	var_25_0:setBackGroundColorOpacity(122)
	var_25_0:setAnchorPoint(0.5, 0.5)
	var_25_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_25_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_25_0:setTouchEnabled(true)
	var_25_0:setLocalZOrder(1000)
	var_25_0:setVisible(true)
	self.rootlayer:addChild(var_25_0)

	self.exitLayer = var_25_0

	local var_25_1 = ccui.ImageView:create(self.resPath .. "endBg.png", var_0_2)

	var_25_0:addChild(var_25_1)
	var_25_1:setPosition(320, 800 + GameDisplay.fix_y)

	local var_25_2 = cc.Label:createWithTTF(L_HEXA_CUR_LABEL, FONT_NAME, 48)

	var_25_2:setColor(cc.c3b(253, 234, 194))
	var_25_1:addChild(var_25_2)
	var_25_2:setPosition(var_25_1:getContentSize().width / 2, 260)
	var_25_2:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)

	local var_25_3 = cc.Label:createWithTTF(self.curScore, FONT_NAME, 72)

	var_25_3:setColor(cc.c3b(255, 255, 255))
	var_25_1:addChild(var_25_3)
	var_25_3:setPosition(var_25_1:getContentSize().width / 2, 180)
	var_25_3:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)

	local var_25_4 = cc.Label:createWithTTF(L_HEXA_MAX_LABEL .. tostring(self.maxScore), FONT_NAME, 24)

	var_25_4:setColor(cc.c3b(253, 234, 194))
	var_25_1:addChild(var_25_4)
	var_25_4:setPosition(var_25_1:getContentSize().width / 2, 100)
	var_25_4:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)

	local var_25_5 = ccui.Button:create(self.resPath .. "btn_end_return.png", nil, self.resPath .. "btn_end_return.png", var_0_2)

	var_25_1:addChild(var_25_5)
	var_25_5:setPosition(130, -80)
	var_25_5:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	local var_25_6 = ccui.Button:create(self.resPath .. "btn_end_again.png", nil, self.resPath .. "btn_end_again.png", var_0_2)

	var_25_6:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.boxsPool:clearAllActiveObject()

		self.selectBg1.hasBoxs = false
		self.selectBg2.hasBoxs = false
		self.selectBg3.hasBoxs = false

		self:updateSelectPaenl()

		self.restoreArray = {}
		self.changeArray = {}

		for iter_27_0, iter_27_1 in ipairs(self.hexagonsArray) do
			for iter_27_2, iter_27_3 in ipairs(iter_27_1) do
				self.hexagonsArray[iter_27_0][iter_27_2].color = var_0_9
			end
		end

		self.curScore = 0

		self.curScoreLabel:setString(0)

		self.selectChange = var_0_24

		self.selectChangeLabel:setString(L_HEXA_CHANGE_REAMIN .. self.selectChange .. "/" .. var_0_24)
		self.exitLayer:setVisible(false)
	end)
	var_25_1:addChild(var_25_6)
	var_25_6:setPosition(420, -80)
end

function ActivityHexagonDispelLayer:updateHexagonPanel(arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(self.restoreArray) do
		self.boxsPool:recycleObject(self.hexagonsArray[self.restoreArray[iter_28_0].x][self.restoreArray[iter_28_0].y].box, false)

		self.hexagonsArray[self.restoreArray[iter_28_0].x][self.restoreArray[iter_28_0].y].color = var_0_9

		if arg_28_1 then
			local var_28_0 = self.boxsPool.getObjectByColor(var_0_16)

			var_28_0:setPosition(self.hexagonsArray[self.restoreArray[iter_28_0].x][self.restoreArray[iter_28_0].y].ImageView:getPositionX(), self.hexagonsArray[self.restoreArray[iter_28_0].x][self.restoreArray[iter_28_0].y].ImageView:getPositionY())
			var_28_0:runAction((cc.Sequence:create(cc.FadeOut:create(0.75), cc.CallFunc:create(function()
				var_28_0:setOpacity(255)
				self.boxsPool:recycleObject(var_28_0)
			end))))
		end
	end

	for iter_28_2, iter_28_3 in ipairs(self.changeArray) do
		if self.hexagonsArray[self.changeArray[iter_28_2].x][self.changeArray[iter_28_2].y].color ~= self.changeArray[iter_28_2].color then
			local var_28_1 = self.boxsPool.getObjectByColor(self.changeArray[iter_28_2].color)

			var_28_1:setPosition(self.hexagonsArray[self.changeArray[iter_28_2].x][self.changeArray[iter_28_2].y].ImageView:getPositionX(), self.hexagonsArray[self.changeArray[iter_28_2].x][self.changeArray[iter_28_2].y].ImageView:getPositionY())

			self.hexagonsArray[self.changeArray[iter_28_2].x][self.changeArray[iter_28_2].y].box = var_28_1
		end

		self.hexagonsArray[self.changeArray[iter_28_2].x][self.changeArray[iter_28_2].y].color = self.changeArray[iter_28_2].color
	end
end

function ActivityHexagonDispelLayer:updateSelectPaenl()
	for iter_30_0 = 1, 3 do
		if not self["selectBg" .. iter_30_0].hasBoxs then
			local var_30_0 = math.random(6)

			self["selectBg" .. iter_30_0].bg:removeAllChildren(true)

			local var_30_1, var_30_2 = self:produceSelect(var_30_0)

			self.select_panel_info[iter_30_0] = {
				color = var_30_0,
				type = var_30_2
			}

			self["selectBg" .. iter_30_0].bg:addChild(var_30_1)

			self["selectBg" .. iter_30_0].hasBoxs = true
			self["selectBg" .. iter_30_0].color = var_30_0
		end
	end
end

function ActivityHexagonDispelLayer:produceSelect(arg_31_1, arg_31_2)
	local var_31_0 = self.selectBg1.bg:getContentSize()
	local var_31_1 = cc.Node:create()

	var_31_1:setName("selectBoxsNode")
	var_31_1:setAnchorPoint(0.5, 0.5)
	var_31_1:setPosition(var_31_0.width / 2, var_31_0.height / 2)
	var_31_1:setScale(0.6)

	if arg_31_1 == var_0_10 then
		self:createSelectBoxs(var_0_10, var_31_1):setPosition(0, 0)

		return var_31_1, nil
	elseif arg_31_1 == var_0_15 then
		local var_31_2 = self:createSelectBoxs(var_0_15, var_31_1)

		var_31_2:setAnchorPoint(0.5, 0.5)
		var_31_2:setPosition(-var_0_6 * 1.5, 0)

		local var_31_3 = self:createSelectBoxs(var_0_15, var_31_1)

		var_31_3:setAnchorPoint(0.5, 0.5)
		var_31_3:setPosition(-0.5 * var_0_6, 0)

		local var_31_4 = self:createSelectBoxs(var_0_15, var_31_1)

		var_31_4:setAnchorPoint(0.5, 0.5)
		var_31_4:setPosition(0.5 * var_0_6, 0)

		local var_31_5 = self:createSelectBoxs(var_0_15, var_31_1)

		var_31_5:setAnchorPoint(0.5, 0.5)
		var_31_5:setPosition(1.5 * var_0_6, 0)

		local var_31_6 = arg_31_2 or math.random(3)

		if var_31_6 == 1 then
			-- block empty
		elseif var_31_6 == 2 then
			var_31_1:setRotation(60)
		elseif var_31_6 == 3 then
			var_31_1:setRotation(-60)
		end

		return var_31_1, var_31_6
	elseif arg_31_1 == var_0_14 then
		local var_31_7 = self:createSelectBoxs(var_0_14, var_31_1)

		var_31_7:setAnchorPoint(0.5, 0.5)
		var_31_7:setPosition(-var_0_6 * 0.5, 0)

		local var_31_8 = self:createSelectBoxs(var_0_14, var_31_1)

		var_31_8:setAnchorPoint(0.5, 0.5)
		var_31_8:setPosition(0.5 * var_0_6, 0)

		local var_31_9 = self:createSelectBoxs(var_0_14, var_31_1)

		var_31_9:setAnchorPoint(0.5, 0.5)
		var_31_9:setPosition(0, 0.75 * var_0_5)

		local var_31_10 = self:createSelectBoxs(var_0_14, var_31_1)

		var_31_10:setAnchorPoint(0.5, 0.5)
		var_31_10:setPosition(0, -0.75 * var_0_5)

		local var_31_11 = arg_31_2 or math.random(3)

		if var_31_11 == 1 then
			-- block empty
		elseif var_31_11 == 2 then
			var_31_1:setRotation(60)
		elseif var_31_11 == 3 then
			var_31_1:setRotation(-60)
		end

		return var_31_1, var_31_11
	elseif arg_31_1 == var_0_12 then
		local var_31_12 = self:createSelectBoxs(var_0_12, var_31_1)

		var_31_12:setAnchorPoint(0.5, 0.5)
		var_31_12:setPosition(-0, 0)

		local var_31_13 = self:createSelectBoxs(var_0_12, var_31_1)

		var_31_13:setAnchorPoint(0.5, 0.5)
		var_31_13:setPosition(var_0_6, 0)

		local var_31_14 = self:createSelectBoxs(var_0_12, var_31_1)

		var_31_14:setAnchorPoint(0.5, 0.5)
		var_31_14:setPosition(-var_0_6, 0)

		local var_31_15 = self:createSelectBoxs(var_0_12, var_31_1)

		var_31_15:setAnchorPoint(0.5, 0.5)
		var_31_15:setPosition(-0.5 * var_0_6, 0.75 * var_0_5)

		local var_31_16 = arg_31_2 or math.random(6)

		if var_31_16 == 1 then
			-- block empty
		elseif var_31_16 == 2 then
			var_31_1:setRotation(60)
		elseif var_31_16 == 3 then
			var_31_1:setRotation(120)
		elseif var_31_16 == 4 then
			var_31_1:setRotation(180)
		elseif var_31_16 == 5 then
			var_31_1:setRotation(240)
		elseif var_31_16 == 6 then
			var_31_1:setRotation(300)
		end

		return var_31_1, var_31_16
	elseif arg_31_1 == var_0_13 then
		local var_31_17 = self:createSelectBoxs(var_0_13, var_31_1)

		var_31_17:setAnchorPoint(0.5, 0.5)
		var_31_17:setPosition(-0, 0)

		local var_31_18 = self:createSelectBoxs(var_0_13, var_31_1)

		var_31_18:setAnchorPoint(0.5, 0.5)
		var_31_18:setPosition(var_0_6, 0)

		local var_31_19 = self:createSelectBoxs(var_0_13, var_31_1)

		var_31_19:setAnchorPoint(0.5, 0.5)
		var_31_19:setPosition(-var_0_6, 0)

		local var_31_20 = self:createSelectBoxs(var_0_13, var_31_1)

		var_31_20:setAnchorPoint(0.5, 0.5)
		var_31_20:setPosition(0.5 * var_0_6, 0.75 * var_0_5)

		local var_31_21 = arg_31_2 or math.random(6)

		if var_31_21 == 1 then
			-- block empty
		elseif var_31_21 == 2 then
			var_31_1:setRotation(60)
		elseif var_31_21 == 3 then
			var_31_1:setRotation(120)
		elseif var_31_21 == 4 then
			var_31_1:setRotation(180)
		elseif var_31_21 == 5 then
			var_31_1:setRotation(240)
		elseif var_31_21 == 6 then
			var_31_1:setRotation(300)
		end

		return var_31_1, var_31_21
	elseif arg_31_1 == var_0_11 then
		local var_31_22 = self:createSelectBoxs(var_0_11, var_31_1)

		var_31_22:setAnchorPoint(0.5, 0.5)
		var_31_22:setPosition(-var_0_6, 0)

		local var_31_23 = self:createSelectBoxs(var_0_11, var_31_1)

		var_31_23:setAnchorPoint(0.5, 0.5)
		var_31_23:setPosition(var_0_6, 0)

		local var_31_24 = self:createSelectBoxs(var_0_11, var_31_1)

		var_31_24:setAnchorPoint(0.5, 0.5)
		var_31_24:setPosition(-0.5 * var_0_6, 0.75 * var_0_5)

		local var_31_25 = self:createSelectBoxs(var_0_11, var_31_1)

		var_31_25:setAnchorPoint(0.5, 0.5)
		var_31_25:setPosition(0.5 * var_0_6, 0.75 * var_0_5)

		local var_31_26 = arg_31_2 or math.random(6)

		if var_31_26 == 1 then
			-- block empty
		elseif var_31_26 == 2 then
			var_31_1:setRotation(60)
		elseif var_31_26 == 3 then
			var_31_1:setRotation(120)
		elseif var_31_26 == 4 then
			var_31_1:setRotation(180)
		elseif var_31_26 == 5 then
			var_31_1:setRotation(240)
		elseif var_31_26 == 6 then
			var_31_1:setRotation(300)
		end

		return var_31_1, var_31_26
	end
end

function ActivityHexagonDispelLayer:checkIsPutIn(arg_32_1)
	self.restoreArray = {}

	for iter_32_0, iter_32_1 in ipairs(self.changeArray) do
		self.restoreArray[iter_32_0] = {
			x = self.changeArray[iter_32_0].x,
			y = self.changeArray[iter_32_0].y,
			color = var_0_9
		}
	end

	local var_32_0 = var_0_5 / 2 - 5

	for iter_32_2, iter_32_3 in ipairs(arg_32_1:getChildren()) do
		local var_32_1 = arg_32_1:convertToWorldSpace(cc.p(iter_32_3:getPositionX(), iter_32_3:getPositionY())).x
		local var_32_2 = arg_32_1:convertToWorldSpace(cc.p(iter_32_3:getPositionX(), iter_32_3:getPositionY())).y
		local var_32_3 = false

		for iter_32_4, iter_32_5 in ipairs(self.hexagonsArray) do
			for iter_32_6, iter_32_7 in ipairs(self.hexagonsArray[iter_32_4]) do
				if (self.hexagonsArray[iter_32_4][iter_32_6].flag and self.hexagonsArray[iter_32_4][iter_32_6].color == var_0_9 or self.hexagonsArray[iter_32_4][iter_32_6].color == var_0_16) and var_32_0 > math.sqrt(math.pow(self.hexagonsArray[iter_32_4][iter_32_6].BoxWorldPosition.x - var_32_1, 2) + math.pow(self.hexagonsArray[iter_32_4][iter_32_6].BoxWorldPosition.y - var_32_2 + GameDisplay.fix_y, 2)) then
					self.changeArray[iter_32_2] = {
						x = iter_32_4,
						y = iter_32_6,
						color = var_0_16
					}
					var_32_3 = true

					break
				end
			end

			if var_32_3 then
				break
			end
		end

		if not var_32_3 then
			self.changeArray = {}

			self:updateHexagonPanel()

			return false
		end
	end

	if self.changeArray ~= {} then
		self:updateHexagonPanel()

		self.restoreArray = {}

		for iter_32_8, iter_32_9 in ipairs(self.changeArray) do
			self.restoreArray[iter_32_8] = {
				x = self.changeArray[iter_32_8].x,
				y = self.changeArray[iter_32_8].y,
				color = var_0_9
			}
		end

		return true
	end
end

function ActivityHexagonDispelLayer:checkIsScore()
	local var_33_0 = {
		{},
		{},
		{}
	}

	for iter_33_0 = 1, 9 do
		local var_33_1 = true

		for iter_33_1 = 1, #self.hexagonsArray[iter_33_0] do
			if self.hexagonsArray[iter_33_0][iter_33_1].flag and self.hexagonsArray[iter_33_0][iter_33_1].color == var_0_9 or self.hexagonsArray[iter_33_0][iter_33_1].color == var_0_16 then
				var_33_1 = false

				break
			end
		end

		if var_33_1 then
			table.insert(var_33_0[1], iter_33_0)
		end
	end

	for iter_33_2 = 1, 9 do
		local var_33_2 = true
		local var_33_3 = self.hexagonsArray[9][iter_33_2]
		local var_33_4 = 0

		while var_33_3 do
			if var_33_3.flag and var_33_3.color == var_0_9 or var_33_3.color == var_0_16 then
				var_33_2 = false

				break
			end

			var_33_4 = var_33_4 + 1

			if not self.hexagonsArray[9 - var_33_4] then
				break
			end

			var_33_3 = self.hexagonsArray[9 - var_33_4][iter_33_2]
		end

		if var_33_2 then
			table.insert(var_33_0[2], iter_33_2)
		end
	end

	for iter_33_3 = 5, 13 do
		local var_33_5 = true
		local var_33_6 = self.hexagonsArray[9][iter_33_3]
		local var_33_7 = 0

		while var_33_6 do
			if var_33_6.flag and var_33_6.color == var_0_9 or var_33_6.color == var_0_16 then
				var_33_5 = false

				break
			end

			var_33_7 = var_33_7 + 1

			if not self.hexagonsArray[9 - var_33_7] then
				break
			end

			var_33_6 = self.hexagonsArray[9 - var_33_7][iter_33_3 - var_33_7]
		end

		if var_33_5 then
			table.insert(var_33_0[3], iter_33_3)
		end
	end

	local var_33_8 = {}

	for iter_33_4, iter_33_5 in ipairs(var_33_0[1]) do
		for iter_33_6 = 1, #self.hexagonsArray[iter_33_5] do
			if self.hexagonsArray[iter_33_5][iter_33_6].flag then
				table.insert(var_33_8, {
					x = iter_33_5,
					y = iter_33_6,
					color = var_0_9
				})
			end
		end
	end

	for iter_33_7, iter_33_8 in ipairs(var_33_0[2]) do
		for iter_33_9 = 1, 9 do
			if self.hexagonsArray[10 - iter_33_9][iter_33_8] and self.hexagonsArray[10 - iter_33_9][iter_33_8].flag then
				table.insert(var_33_8, {
					x = 10 - iter_33_9,
					y = iter_33_8,
					color = var_0_9
				})
			end
		end
	end

	for iter_33_10, iter_33_11 in ipairs(var_33_0[3]) do
		for iter_33_12 = 1, 9 do
			if self.hexagonsArray[10 - iter_33_12][iter_33_11 + 1 - iter_33_12] and self.hexagonsArray[10 - iter_33_12][iter_33_11 + 1 - iter_33_12].flag then
				table.insert(var_33_8, {
					x = 10 - iter_33_12,
					y = iter_33_11 + 1 - iter_33_12,
					color = var_0_9
				})
			end
		end
	end

	return var_33_8
end

function ActivityHexagonDispelLayer:checkGamesEnd()
	for iter_34_0 = 1, 3 do
		local var_34_1 = {}
		local var_34_2 = self["selectBg" .. iter_34_0].bg:getChildByName("selectBoxsNode")
		local var_34_4 = var_34_2:convertToWorldSpace(cc.p(var_34_2:getChildren()[1]:getPositionX(), var_34_2:getChildren()[1]:getPositionY()))

		for iter_34_1, iter_34_2 in ipairs(var_34_2:getChildren()) do
			var_34_1[iter_34_1] = {
				PX = (var_34_2:convertToWorldSpace(cc.p(iter_34_2:getPositionX(), iter_34_2:getPositionY())).x - var_34_4.x) / 0.6,
				PY = (var_34_2:convertToWorldSpace(cc.p(iter_34_2:getPositionX(), iter_34_2:getPositionY())).y - var_34_4.y) / 0.6
			}
		end

		if #var_34_1 == 1 then
			return false
		end

		for iter_34_3, iter_34_4 in ipairs(self.hexagonsArray) do
			for iter_34_5, iter_34_6 in ipairs(self.hexagonsArray[iter_34_3]) do
				if not self.hexagonsArray[iter_34_3][iter_34_5].flag or self.hexagonsArray[iter_34_3][iter_34_5].color ~= var_0_9 then
					if self.hexagonsArray[iter_34_3][iter_34_5].color == var_0_16 then
						local var_34_5 = self.hexagonsArray[iter_34_3][iter_34_5].ImageView:getPositionX()
						local var_34_6 = self.hexagonsArray[iter_34_3][iter_34_5].ImageView:getPositionY()
						local var_34_7 = true

						for iter_34_7, iter_34_8 in ipairs(var_34_1) do
							if not self:checkCycle(var_34_5 + iter_34_8.PX, var_34_6 + iter_34_8.PY) then
								var_34_7 = false

								break
							end
						end

						if var_34_7 then
							print("可以放在" .. iter_34_3 .. "  " .. iter_34_5)

							return false
						end
					end
				end
			end
		end
	end

	return true
end

function ActivityHexagonDispelLayer:checkCycle(arg_35_1, arg_35_2)
	for iter_35_0, iter_35_1 in ipairs(self.hexagonsArray) do
		for iter_35_2, iter_35_3 in ipairs(self.hexagonsArray[iter_35_0]) do
			if (self.hexagonsArray[iter_35_0][iter_35_2].flag and self.hexagonsArray[iter_35_0][iter_35_2].color == var_0_9 or self.hexagonsArray[iter_35_0][iter_35_2].color == var_0_16) and 5 > math.sqrt(math.pow(self.hexagonsArray[iter_35_0][iter_35_2].ImageView:getPositionX() - arg_35_1, 2) + math.pow(self.hexagonsArray[iter_35_0][iter_35_2].ImageView:getPositionY() - arg_35_2, 2)) then
				return true
			end
		end
	end

	return false
end

function ActivityHexagonDispelLayer:loadHexagonPanel(arg_36_1)
	if not arg_36_1 then
		return
	end

	for iter_36_0 = 1, 9 do
		for iter_36_1 = 1, 9 do
			if self.hexagonsArray[iter_36_0][iter_36_1] and self.hexagonsArray[iter_36_0][iter_36_1].flag then
				self.hexagonsArray[iter_36_0][iter_36_1].color = arg_36_1[iter_36_0].row[iter_36_1] or var_0_9

				if self.hexagonsArray[iter_36_0][iter_36_1].color ~= var_0_9 then
					local var_36_0 = self.boxsPool.getObjectByColor(self.hexagonsArray[iter_36_0][iter_36_1].color)

					var_36_0:setPosition(self.hexagonsArray[iter_36_0][iter_36_1].ImageView:getPositionX(), self.hexagonsArray[iter_36_0][iter_36_1].ImageView:getPositionY())

					self.hexagonsArray[iter_36_0][iter_36_1].box = var_36_0
				end
			end
		end
	end
end

function ActivityHexagonDispelLayer:updateSelectPaenlByServer(arg_37_1)
	if not arg_37_1 then
		return
	end

	for iter_37_0 = 1, 3 do
		if not self["selectBg" .. iter_37_0].hasBoxs then
			self["selectBg" .. iter_37_0].bg:removeAllChildren(true)

			local var_37_0, var_37_1 = self:produceSelect(arg_37_1[iter_37_0].color, arg_37_1[iter_37_0].type)

			self["selectBg" .. iter_37_0].bg:addChild(var_37_0)

			self["selectBg" .. iter_37_0].hasBoxs = true
			self["selectBg" .. iter_37_0].color = arg_37_1[iter_37_0].color
			self.select_panel_info[iter_37_0] = {
				color = arg_37_1[iter_37_0].color,
				type = var_37_1
			}
		end
	end
end

function ActivityHexagonDispelLayer:savePlayerData(arg_38_1)
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in ipairs(self.hexagonsArray) do
		local var_38_1 = {
			row = {}
		}

		for iter_38_2, iter_38_3 in ipairs(iter_38_1) do
			table.insert(var_38_1.row, iter_38_3.color or var_0_9)
		end

		table.insert(var_38_0, var_38_1)
	end

	activity_hexagon_dispel_manager:savePlayerData({
		activityid = self.activityId,
		color_data = var_38_0,
		select_panel_info = self.select_panel_info,
		cur_replace_count = self.selectChange,
		score = self.curScore
	}, arg_38_1)
end

function ActivityHexagonDispelLayer:gameFailed()
	activity_hexagon_dispel_manager:gameFailed({
		activityid = self.activityId,
		score = self.curScore
	}, function(arg_40_0)
		self.maxScore = arg_40_0.max_score

		self:initEndPanel()
		print("游戏结束")
	end)
end

function ActivityHexagonDispelLayer:buySelectChance()
	activity_hexagon_dispel_manager:buySelectChance({
		activityid = self.activityId,
		cur_replace_count = self.selectChange
	}, function(arg_42_0)
		self.can_buy_count = arg_42_0.can_buy_count
		self.selectChange = arg_42_0.cur_replace_count

		self.selectChangeLabel:setString(L_HEXA_CHANGE_REAMIN .. self.selectChange .. "/" .. var_0_24)
		self:savePlayerData(function(arg_43_0)
			global_ShowBlockWords("购买成功，已自动保存！")
			self.maxScoreLabel:setString(arg_43_0.max_score)
		end)
	end)
end
