MonopolyLayer = class("MonopolyLayer", function()
	return cc.Layer:create()
end)

local level_manager = require("controller.level_manager")
local expedition_manager = require("controller.expedition_manager")

require("view.Sprite.GirlSprite")

local l2utils = require("controller.l2utils")
local expedition_total_skill_data = require("data.expedition_total_skill_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local audio_manager = require("controller.audio_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local spinecache_manager = require("controller.spinecache_manager")
local Utility = require("common.Utility")
local var_0_10 = 0.2
local var_0_11 = config._DEBUG and 0 or 1
local var_0_12 = {
	cc.p(0, 20),
	cc.p(300, 130),
	cc.p(500, 130)
}
local var_0_13 = {
	Free = 1,
	NeedEvent = 3,
	NeedResult = 4,
	NeedBattle = 2
}
local var_0_14 = {
	Reborn = 2,
	Recruit = 3,
	Skill = 4,
	Blood = 1
}
local var_0_15 = {}

function MonopolyLayer.create(arg_2_0, ...)
	local var_2_0 = MonopolyLayer.new()

	var_2_0:init(...)

	return var_2_0
end

function MonopolyLayer:onLoad(arg_3_1)
	local var_3_0 = ccui.Layout:create()

	var_3_0:setTouchEnabled(true)
	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setAnchorPoint(cc.p(0, 0))
	var_3_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_3_0:setOpacity(0)
	var_3_0:setCascadeOpacityEnabled(false)
	self:addChild(var_3_0, -1)

	local var_3_1 = ccui.ImageView:create("mainScenebg/monopoly_bg.png")

	var_3_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_1:setPositionX(var_3_0:getContentSize().width / 2)
	var_3_1:setPositionY(var_3_0:getContentSize().height / 2)
	var_3_0:addChild(var_3_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_4_0)
		self:addChild(arg_4_0, -2)
		arg_4_0:setPositionY(arg_4_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_3_1)
		var_3_0:setOpacity(102)
		var_3_0:setTouchEnabled(false)
	end)
end

function MonopolyLayer:init(arg_5_1)
	self.scheduler = cc.Director:getInstance():getScheduler()
	expedition_manager.updateMainCoinNumCallback = self.updateCoinNum
	self.initconfig = arg_5_1 or {
		inittype = 118
	}

	expedition_manager:setExpeditionParam(self.initconfig)

	self.resPath = string.format("MonopolyLayer/seasontype_%d/", self.initconfig.inittype)
	self.RoomBgPath = {
		self.resPath .. "bg1.png",
		self.resPath .. "bg1.png",
		self.resPath .. "bg_boss.png",
		self.resPath .. "bg1.png",
		self.resPath .. "bg1.png",
		self.resPath .. "bg1.png",
		self.resPath .. "bg_boss.png",
		self.resPath .. "bg1.png"
	}
	self.root = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (("MonopolyLayer" .. self.initconfig.inittype) .. ".json" or ("MonopolyLayer" .. self.initconfig.inittype) .. ".ExportJson"))

	self:addChild(self.root)

	self.mainNode = self.root:getChildByName("main")
	self.diNode = self.mainNode:getChildByName("di")

	self.diNode:setPositionY(51.5)

	function self.onBtnBackCallback(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end

	self.btn_back = BottomBtnList:create(self.onBtnBackCallback, nil, "", {
		img = "public/button/bottom_return_btn_archives.png",
		pos = cc.p(56, 35)
	})

	self.btn_back:setName("btn_back")
	self.mainNode:addChild(self.btn_back, 0)

	self.btn_getdice = self.mainNode:getChildByName("btn_getdice")

	self.btn_getdice:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("获取骰子")

		local var_7_0 = expedition_manager:getCoinList(true)

		if var_7_0.id ~= nil then
			LayerManager:pushInLayer("PopBasicGoGainLayer", {
				itemid = var_7_0.id,
				updateCallback = function()
					if type(self.updateCoinNum) == "function" then
						self:updateCoinNum()
					end
				end
			})
		else
			global_ShowBlockWords("货币id为空，注意检查")
		end
	end)

	self.diceNode = self.mainNode:getChildByName("dice_bg"):getChildByName("dice")

	self.diceNode:setTouchEnabled(true)
	self.mainNode:getChildByName("dice_bg"):setLocalZOrder(99)
	self.diceNode:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isCanPlayDice ~= true then
			return
		end

		self.isCanPlayDice = false

		local var_9_0 = expedition_manager:getCoinList(true)

		if var_9_0.num <= 0 then
			if var_9_0.id ~= nil then
				self.isCanPlayDice = true

				LayerManager:pushInLayer("PopBasicGoGainLayer", {
					itemid = var_9_0.id,
					updateCallback = function()
						if type(self.updateCoinNum) == "function" then
							self:updateCoinNum()
						end
					end
				})
			else
				global_ShowBlockWords("货币id为空，注意检查")
			end
		else
			self:doOperate()
		end
	end)

	self.diceNumNode = self.mainNode:getChildByName("dice_num_bg"):getChildByName("num")

	self.mainNode:setVisible(true)

	self.timeNode = self.mainNode:getChildByName("time")

	self.timeNode:setPosition(cc.p(320, 1040))
	self.timeNode:setVisible(false)

	local var_5_0 = self.mainNode:getChildByName("level")

	var_5_0:setVisible(false)

	self.levelNode = ccui.TextBMFont:create("", "fonts/checkpoint_number.fnt")

	local var_5_1, var_5_2 = var_5_0:getPosition()

	self.levelNode:setName("levelTitle")
	self.levelNode:setPosition(cc.p(var_5_1, var_5_2 + 5))
	self.mainNode:addChild(self.levelNode, 99)

	self.btn_getflip = self.mainNode:getChildByName("btn_getflip")

	self.btn_getflip:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("ActivityFlopLayer_" .. self.initconfig.activityid, {
			activityid = self.initconfig.activityid
		})
	end)

	self.coinNumNode = self.mainNode:getChildByName("coin_num")
	self.mapNumNode = self.mainNode:getChildByName("mapnum")
	self.stepNode = self.mainNode:getChildByName("step")

	self.stepNode:setLocalZOrder(99)
	self.stepNode:setOpacity(0)
	self.stepNode:setVisible(true)

	if self.stepNode:getChildByName("tips") then
		self.stepNode:getChildByName("tips"):removeFromParent()
	end

	local var_5_3 = ccui.TextBMFont:create("", "fonts/dice.fnt")

	var_5_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_5_3:setPosition(cc.p(320, 45.5))
	var_5_3:setName("tips")
	self.stepNode:addChild(var_5_3)

	local var_5_4 = self.mainNode:getChildByName("head")

	var_5_4:setVisible(false)

	self.headNode = ccui.Layout:create()

	local var_5_5, var_5_6 = var_5_4:getPosition()

	self.headNode:setPosition(cc.p(var_5_5, var_5_6))
	self.mainNode:addChild(self.headNode)
	self.headNode:setLocalZOrder(98)

	self.headStartPosX, self.headStartPosY = self.headNode:getPosition()
	self.headStartPosY = (GameDisplay.height + GameDisplay.fix_y - 1136) / 2 + self.headStartPosY
	self.selectStudentNode = self.root:getChildByName("select_student")
	self.selectSkillNode = self.root:getChildByName("select_skill")
	self.btn_confirm1 = self.selectStudentNode:getChildByName("btn_confirm")
	self.btn_confirm2 = self.selectSkillNode:getChildByName("btn_confirm")

	self.selectStudentNode:setVisible(false)
	self.selectSkillNode:setVisible(false)
	self.selectStudentNode:getChildByName("bg"):setBackGroundImage("mainScenebg/expedition_mask.png")
	self.selectSkillNode:getChildByName("bg"):setBackGroundImage("mainScenebg/expedition_mask.png")

	self.getDiceNode = self.root:getChildByName("get_dice")

	self.getDiceNode:setVisible(false)
	self.getDiceNode:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.getDiceNode:setVisible(false)
	end)

	self.showSkillNode = self.root:getChildByName("show_skill")

	local var_5_7 = self.mainNode:getChildByName("btn_reset")

	var_5_7:setLocalZOrder(99)
	var_5_7:setPosition(cc.p(300, 1050))
	var_5_7:setVisible(true)
	var_5_7:setTouchEnabled(true)
	var_5_7:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_13_0 = ConfirmDialogSprite:create(L_RESET[2], L_RESET[4], {
			surecallback = function()
				expedition_manager:reset_expedition(function()
					self.lastLevel = nil

					self:initPanel()
				end)
			end
		})

		global_basic_scene:addChild(var_13_0, 10)
		var_13_0:setName("dialog")
	end)

	self.btn_team = self.mainNode:getChildByName("btn_team")

	self.btn_team:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showHaveStudentPanel()
	end)

	self.btn_phb = self.mainNode:getChildByName("btn_phb")

	self.btn_phb:setTouchEnabled(true)
	self.btn_phb:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("MonopolyRankListLayer", {
			mode = self.initconfig.inittype
		})
	end)

	local var_5_8 = self.mainNode:getChildByName("banner")

	var_5_8:setTouchEnabled(true)
	var_5_8:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "monopoly_layer"
		})
	end)
	self:initItemNode()
	self:initPanel()
	self:fullscreen()
	self:registerScriptHandler(function(arg_19_0)
		if arg_19_0 == "exit" then
			if self.cinemaScheduler ~= nil then
				self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

				self.cinemaScheduler = nil
			end

			if self.timeScheduler ~= nil then
				self.scheduler:unscheduleScriptEntry(self.timeScheduler)

				self.timeScheduler = nil
			end

			if self.usualScheduler ~= nil then
				self.scheduler:unscheduleScriptEntry(self.usualScheduler)

				self.usualScheduler = nil
			end

			if self.updateSchedule then
				self.scheduler:unscheduleScriptEntry(self.updateSchedule)
			end

			expedition_manager.updateMainCoinNumCallback = nil
		end
	end)
	self:openUpdate()
end

function MonopolyLayer:openUpdate()
	if self.updateSchedule then
		self.scheduler:unscheduleScriptEntry(self.updateSchedule)
	end

	self.updateSchedule = self.scheduler:scheduleScriptFunc(function(arg_21_0)
		self:update(arg_21_0)
	end, 0, false)
end

function MonopolyLayer:initDicePanelNode()
	local var_22_0 = expedition_manager:getCoinList()

	if var_22_0 == nil then
		return
	end

	self.dicePanelNode = self.mainNode:getChildByName("dice")

	local var_22_1 = 1

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		if iter_22_1.isSelected == true then
			var_22_1 = iter_22_0

			break
		end
	end

	Utility:setTglContainerCallback(self.dicePanelNode, function(arg_23_0)
		for iter_23_0, iter_23_1 in pairs(var_22_0) do
			if iter_23_0 == arg_23_0 then
				expedition_manager:setCurSelectDiceIndex(iter_23_0)

				var_22_0[iter_23_0].isSelected = true
			else
				var_22_0[iter_23_0].isSelected = false
			end
		end
	end, var_22_1)

	if #var_22_0 > 1 then
		self.dicePanelNode:setVisible(true)

		for iter_22_2 = 1, 4 do
			local var_22_2 = self.dicePanelNode:getChildByName("toggle" .. iter_22_2)

			if iter_22_2 <= #var_22_0 then
				var_22_2:setVisible(true)
				var_22_2:getChildByName("num"):setString(var_22_0[iter_22_2].num)
			else
				var_22_2:setVisible(false)
			end
		end
	else
		self.dicePanelNode:setVisible(false)
	end
end

function MonopolyLayer:showGetDicePanel()
	self.getDiceNode:setVisible(true)

	if self.getDiceNode:getChildByName("bg1") then
		self.getDiceNode:getChildByName("bg1"):removeFromParent()
	end

	local var_24_0 = ccui.ImageView:create("mainScenebg/monopoly_dice_bg.png")

	var_24_0:setPosition(cc.p(GameDisplay.width / 2, (GameDisplay.height + GameDisplay.fix_y) / 2))
	self.getDiceNode:addChild(var_24_0)
end

function MonopolyLayer:updateTimeCountDown()
	local var_25_0 = expedition_manager:getLeftTimeStr()

	if var_25_0 ~= nil then
		self.timeNode:setString("剩余时间：" .. var_25_0)

		if self.timeScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.timeScheduler)

			self.timeScheduler = nil
		end

		self.timeScheduler = self.scheduler:scheduleScriptFunc(function()
			if self.updateTimeCountDown then
				self:updateTimeCountDown()
			else
				self.scheduler:unscheduleScriptEntry(self.timeScheduler)

				self.timeScheduler = nil
			end
		end, 60, false)
	end
end

function MonopolyLayer:initInfo(arg_27_1)
	if (not arg_27_1 or arg_27_1.levelstatus == var_0_13.Free) and (not self.initconfig or self.initconfig.isNeedCheckEvent ~= true) then
		self.isCanPlayDice = true
	end
end

function MonopolyLayer:initPanel(arg_28_1)
	print("刷新界面")
	self:initInfo(arg_28_1)
	expedition_manager:initInfo(self.initconfig.inittype, function()
		self:initShowInfoPanel()
		self:initLevelViewPanel(arg_28_1)
	end)
end

function MonopolyLayer:initItemNum()
	local var_30_0 = expedition_manager:getExpeditionInfo()

	if var_30_0 == nil then
		return
	end

	local var_30_1 = expedition_manager:getCoinList(true)

	self.coinNumNode:setString(var_30_0.flipnum)
	self.diceNumNode:setString(var_30_1.num)
end

function MonopolyLayer:initShowInfoPanel()
	local var_31_0 = expedition_manager:getExpeditionInfo()

	if var_31_0 == nil then
		return
	end

	self.levelNode:setString(var_31_0.levelTitle)
	self.mapNumNode:setString("")
	self.btn_phb:setVisible(expedition_manager:isEndlessMode() == true)
	self:updateTimeCountDown()
	self:initItemNum()
	self:showHaveSkillPanel()
	self:initDicePanelNode()
end

function MonopolyLayer:updateCoinNum()
	expedition_manager:updateCoinNum()
	self:initItemNum()
end

function MonopolyLayer:openSelectStudentPanel(arg_33_1)
	if arg_33_1 == nil then
		return
	end

	local var_33_0 = expedition_manager:getExpeditionTeamListInfo(arg_33_1.num)
	local var_33_1

	for iter_33_0 = 1, #var_33_0 do
		if var_33_0[iter_33_0].isNeedSelect == true then
			var_33_1 = iter_33_0

			break
		end
	end

	local var_33_2 = var_33_1
	local var_33_3 = #var_33_0

	if var_33_1 == nil or var_33_1 > #var_33_0 + 1 then
		print("起始学员posindex 不正确")
		expedition_manager:clearTeamListSelectStatus()

		if type(arg_33_1.callback) == "function" then
			arg_33_1.callback()
		end

		return
	end

	self.selectStudentNode:setVisible(true)
	self.selectStudentNode:getChildByName("listView"):setVisible(false)
	self.btn_confirm1:setVisible(false)

	local var_33_4 = {
		200,
		110,
		20
	}

	local function var_33_5()
		local var_34_0 = self.selectStudentNode:getChildByName("listView")

		var_34_0:setPositionX(var_33_4[var_33_3 - var_33_2 + 1])
		var_34_0:removeAllItems()
		var_34_0:setVisible(true)

		self.lastSelectStudentIndex = nil

		local var_34_1 = 25

		for iter_34_0 = var_33_2, var_33_3 do
			local var_34_2 = var_33_0[iter_34_0]
			local var_34_3 = self.studentItemNode:clone()

			var_34_3:setVisible(true)
			var_34_3:setName("studentItem" .. iter_34_0)

			local var_34_4

			if var_34_2.servantid then
				var_34_3.servantid = var_34_2.servantid

				var_34_3:removeAllChildren()

				var_34_4 = GirlSprite:create({
					initType = "arrayStyle"
				})

				var_34_4:setScale(1.2)
				var_34_4:update(var_34_2.servantid)
				var_34_4:setAnchorPoint(cc.p(0, 0))
				var_34_4:setPosition(cc.p(30, 0))

				if role_false_level_manager:isRoleFalseLevelMember(var_34_2.servantid, FIGHTTYPE_EXPEDITION_MONOPOLY) then
					local var_34_5, var_34_6, var_34_7 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(var_34_2.servantid, FIGHTTYPE_EXPEDITION_MONOPOLY)

					var_34_4:updateByFalseLevel(var_34_2.servantid, var_34_5, var_34_6)
				else
					var_34_4:stopFalseLevelAni()
				end

				var_34_4:getChildByName("rarityIcon"):setScale(1.08)
				var_34_4:imgScaleTo(1, 0)

				local var_34_8 = ccui.ImageView:create(self.resPath .. "rarity1.png", var_0_11)

				var_34_8:setName("rarity")
				var_34_8:setPosition(cc.p(25, 32 + var_34_1))
				var_34_4:addChild(var_34_8, 10)

				local var_34_9 = ccui.ImageView:create(self.resPath .. "rarity_bg.png", var_0_11)

				var_34_9:setName("type")
				var_34_9:setPosition(cc.p(65, 32 + var_34_1))
				var_34_4:addChild(var_34_9, 10)

				local var_34_10 = ccui.Text:create("重装", FONT_NAME, 16)

				var_34_10:setName("typeName")
				var_34_10:setPosition(cc.p(25, 10))
				var_34_9:addChild(var_34_10)

				if var_34_2.career ~= nil then
					var_34_9:setVisible(true)
					var_34_9:getChildByName("typeName"):setString(L_CAREER[SERVANT_CAREE_TBL[var_34_2.career]])
				else
					var_34_9:setVisible(false)
				end

				if var_34_2.rare ~= nil then
					var_34_8:setVisible(true)
					var_34_8:loadTexture(self.resPath .. "rarity" .. var_34_2.rare .. ".png", var_0_11)
				else
					var_34_8:setVisible(false)
				end

				var_34_3:addChild(var_34_4)
				var_34_4:setPositionY(-70)
			else
				var_34_4 = var_34_3:getChildByName("bg")

				var_34_4:setScale(1.2)

				local var_34_11 = var_34_3:getChildByName("type")
				local var_34_12 = var_34_3:getChildByName("rarity")

				if var_34_2.career ~= nil then
					var_34_11:setVisible(true)
					var_34_11:getChildByName("typeName"):setString(L_CAREER[SERVANT_CAREE_TBL[var_34_2.career]])
				else
					var_34_11:setVisible(false)
				end

				if var_34_2.rare ~= nil then
					var_34_12:setVisible(true)
					var_34_12:loadTexture(self.resPath .. "rarity" .. var_34_2.rare .. ".png", var_0_11)
				else
					var_34_12:setVisible(false)
				end

				var_34_4:setPositionY(70)
				var_34_3:getChildByName("select"):setPositionY(70)
			end

			local var_34_13 = var_34_3:getChildByName("select")

			var_34_4:setSwallowTouches(false)
			var_34_4:setTouchEnabled(true)

			var_34_4.index = iter_34_0

			var_34_4:addTouchEventListener(function(arg_35_0, arg_35_1)
				if arg_35_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self.lastSelectStudentIndex ~= nil then
					local var_35_0 = var_34_0:getItem(self.lastSelectStudentIndex - 1)

					if var_35_0 and var_35_0:getChildByName("select") then
						var_35_0:getChildByName("select"):setVisible(false)
					end
				end

				if var_34_13 then
					-- block empty
				end

				self.lastSelectStudentIndex = arg_35_0.index

				local var_35_1

				if var_34_2.career ~= nil then
					var_35_1 = {}

					table.insert(var_35_1, SERVANT_CAREE_TBL[var_34_2.career])
				end

				local var_35_2

				if var_34_2.rare ~= nil then
					var_35_2 = {}

					table.insert(var_35_2, tonumber(var_34_2.rare))
				end

				LayerManager:pushInLayer("GirlSelectLayer", {
					cursoul = var_34_2.servantid,
					arrayinfo = {
						index = 1,
						pos = arg_35_0.index
					},
					selectType = SELECT_GIRL_EXPEDITION,
					sureCallBack = function(arg_36_0)
						if type(arg_33_1.updateCallback) == "function" then
							arg_33_1.updateCallback()
						end
					end,
					filterTbl = {
						sortType = 1,
						bag_type = 12,
						filterConfig = {
							rarity = var_35_2,
							career = var_35_1
						}
					}
				})
			end)
			var_34_0:pushBackCustomItem(var_34_3)
		end

		var_34_0:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
		var_34_0:refreshView()
		var_34_0:jumpToLeft()

		if not expedition_manager:isServantSelectReady() then
			l2utils:shaderGrayDark(self.btn_confirm1:getVirtualRenderer())
		else
			l2utils:recoverShader(self.btn_confirm1:getVirtualRenderer())
		end

		self.btn_confirm1:setVisible(true)

		self.btn_confirm1.isCanBeClick = true

		self.btn_confirm1:addTouchEventListener(function(arg_37_0, arg_37_1)
			if arg_37_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_37_0.isCanBeClick == false then
				return
			end

			if not expedition_manager:isServantSelectReady() then
				global_ShowBlockWords("招募学员数不足")

				return
			end

			arg_37_0.isCanBeClick = false

			expedition_manager:set_expedition_servant(function()
				expedition_manager:clearTeamListSelectStatus()

				if type(arg_33_1.callback) == "function" then
					arg_33_1.callback()
				end
			end)
		end)
		self.selectStudentNode:addTouchEventListener(function(arg_39_0, arg_39_1)
			if arg_39_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectStudentNode:setVisible(false)

			self.isCanPlayDice = true
		end)

		if arg_33_1.isAni and arg_33_1.isAni == true then
			-- block empty
		end
	end

	if self.selectStudentNode:getChildByName("bgLayer") then
		self.selectStudentNode:getChildByName("bgLayer"):removeFromParent()
	end

	if self.selectStudentNode:getChildByName("sp") then
		self.selectStudentNode:getChildByName("sp"):removeFromParent()
	end

	local var_33_6 = ccui.Layout:create()

	var_33_6:setTouchEnabled(true)
	var_33_6:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_33_6:setAnchorPoint(cc.p(0, 0))
	var_33_6:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_33_6:setBackGroundColor(cc.c3b(2, 5, 24))
	var_33_6:setOpacity(0)
	var_33_6:setCascadeOpacityEnabled(false)
	var_33_6:setName("bgLayer")
	self.selectStudentNode:addChild(var_33_6, -1)

	local var_33_7 = ccui.ImageView:create("mainScenebg/expedition_mask.png")

	var_33_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_33_7:setPositionX(var_33_6:getContentSize().width / 2)
	var_33_7:setPositionY(var_33_6:getContentSize().height / 2)
	var_33_6:addChild(var_33_7)
	l2utils:captureScreenGaussBlur(function(arg_40_0)
		arg_40_0:setName("sp")
		self.selectStudentNode:addChild(arg_40_0, -2)
		var_33_5()
		var_33_6:setOpacity(102)
		var_33_6:setTouchEnabled(false)
	end)
end

function MonopolyLayer:openSelectSkillPanel(arg_41_1)
	if arg_41_1 == nil then
		return
	end

	local var_41_0 = expedition_manager:getExpeditionSkillListInfo()
	local var_41_1 = false

	for iter_41_0 = 1, #var_41_0 do
		if var_41_0[iter_41_0].isNeedSelect == true then
			var_41_1 = true

			break
		end
	end

	local var_41_2 = expedition_manager:initSelectSkillInfo(arg_41_1.skillpoolid)
	local var_41_3 = 1
	local var_41_4 = #var_41_2

	if var_41_1 == false or #var_41_2 <= 0 then
		print("起始技能posindex 不正确")
		expedition_manager:clearSkillListSelectStatus()

		if type(arg_41_1.callback) == "function" then
			arg_41_1.callback()
		end

		return
	end

	self.selectSkillNode:setVisible(true)
	self.selectSkillNode:getChildByName("listView"):setVisible(false)
	self.btn_confirm2:setVisible(false)

	local function var_41_5()
		local var_42_0 = self.selectSkillNode:getChildByName("listView")

		var_42_0:removeAllItems()
		var_42_0:setTouchEnabled(true)
		var_42_0:setVisible(true)

		self.lastSelectSkillIndex = 1

		local var_42_1 = 100

		for iter_42_0 = var_41_3, var_41_4 do
			local var_42_2 = var_41_2[iter_42_0]
			local var_42_3 = self.skillItemNode:clone()

			var_42_3:setVisible(true)
			var_42_3:setName("skillItem" .. iter_42_0)

			local var_42_4 = var_42_3:getChildByName("bg")
			local var_42_5 = var_42_3:getChildByName("select")

			var_42_4:setSwallowTouches(false)
			var_42_4:setTouchEnabled(true)

			var_42_4.index = iter_42_0

			var_42_4:loadTextures(self.resPath .. "skill_bg" .. var_42_2.rare .. ".png", self.resPath .. "skill_bg" .. var_42_2.rare .. ".png", self.resPath .. "skill_bg" .. var_42_2.rare .. ".png", var_0_11)
			var_42_4:addTouchEventListener(function(arg_43_0, arg_43_1)
				if arg_43_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self.lastSelectSkillIndex ~= nil then
					local var_43_0 = var_42_0:getItem(self.lastSelectSkillIndex - 1)

					if var_43_0 then
						var_43_0:getChildByName("select"):setVisible(false)
						var_43_0:setScale(1)
						var_43_0:getChildByName("bg"):setPositionY(var_42_1)
						var_43_0:getChildByName("select"):setPositionY(var_42_1)

						var_43_0.isSelected = nil
					end
				end

				var_42_5:setVisible(true)

				self.lastSelectSkillIndex = arg_43_0.index

				var_42_3:setScale(1.1)

				var_42_3.isSelected = true

				var_42_4:setPositionY(var_42_1)
				var_42_5:setPositionY(var_42_1)
				l2utils:recoverShader(self.btn_confirm2:getVirtualRenderer())
			end)

			if self.lastSelectSkillIndex == iter_42_0 then
				var_42_5:setVisible(true)
				var_42_3:setScale(1.1)

				var_42_3.isSelected = true

				var_42_4:setPositionY(100)
				var_42_5:setPositionY(100)
			else
				var_42_5:setVisible(false)
				var_42_3:setScale(1)
				var_42_4:setPositionY(100)
				var_42_5:setPositionY(100)
			end

			local var_42_6 = var_42_4:getContentSize().width
			local var_42_7 = var_42_4:getContentSize().height
			local var_42_8 = var_42_4:getChildByName("icon")
			local var_42_9 = var_42_4:getChildByName("name")

			var_42_9:setString(var_42_2.name)
			var_42_9:setAnchorPoint(cc.p(0.5, 0.5))
			var_42_9:setPosition(cc.p(var_42_6 / 2, var_42_7 / 2 - 15))
			var_42_8:loadTexture(var_42_2.iconPath, var_0_11)
			var_42_8:setAnchorPoint(cc.p(0.5, 0.5))
			var_42_8:setPosition(cc.p(var_42_6 / 2 + 0.5, var_42_7 / 2 + 61))
			var_42_8:setScale(0.98)
			var_42_4:getChildByName("des"):setString(var_42_2.des)
			var_42_0:pushBackCustomItem(var_42_3)
		end

		var_42_0:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
		var_42_0:refreshView()
		var_42_0:jumpToLeft()

		if self.lastSelectSkillIndex == nil then
			l2utils:shaderGrayDark(self.btn_confirm2:getVirtualRenderer())
		else
			l2utils:recoverShader(self.btn_confirm2:getVirtualRenderer())
		end

		self.btn_confirm2:setVisible(true)

		self.btn_confirm2.isCanBeClick = true

		self.btn_confirm2:addTouchEventListener(function(arg_44_0, arg_44_1)
			if arg_44_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_44_0.isCanBeClick == false then
				return
			end

			if not expedition_manager:isHaveSkillSelected() and self.lastSelectSkillIndex == nil then
				global_ShowBlockWords("请选择一个技能")

				return
			end

			arg_44_0.isCanBeClick = false

			expedition_manager:set_expedition_skill(var_41_2[self.lastSelectSkillIndex].skillid, function()
				if type(arg_41_1.callback) == "function" then
					arg_41_1.callback()
				end
			end)
		end)
		self.selectSkillNode:addTouchEventListener(function(arg_46_0, arg_46_1)
			if arg_46_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectSkillNode:setVisible(false)

			self.isCanPlayDice = true
		end)

		if arg_41_1.isAni and arg_41_1.isAni == true then
			-- block empty
		end
	end

	if self.selectSkillNode:getChildByName("bgLayer") then
		self.selectSkillNode:getChildByName("bgLayer"):removeFromParent()
	end

	if self.selectSkillNode:getChildByName("sp") then
		self.selectSkillNode:getChildByName("sp"):removeFromParent()
	end

	local var_41_6 = ccui.Layout:create()

	var_41_6:setTouchEnabled(true)
	var_41_6:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_41_6:setAnchorPoint(cc.p(0, 0))
	var_41_6:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_41_6:setBackGroundColor(cc.c3b(2, 5, 24))
	var_41_6:setOpacity(0)
	var_41_6:setCascadeOpacityEnabled(false)
	var_41_6:setName("bgLayer")
	self.selectSkillNode:addChild(var_41_6, -1)

	local var_41_7 = ccui.ImageView:create("mainScenebg/expedition_mask.png")

	var_41_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_41_7:setPositionX(var_41_6:getContentSize().width / 2)
	var_41_7:setPositionY(var_41_6:getContentSize().height / 2)
	var_41_6:addChild(var_41_7)
	l2utils:captureScreenGaussBlur(function(arg_47_0)
		arg_47_0:setName("sp")
		self.selectSkillNode:addChild(arg_47_0, -2)
		var_41_5()
		var_41_6:setOpacity(102)
		var_41_6:setTouchEnabled(false)
	end)
end

function MonopolyLayer:fullscreen()
	self.root:setPosition(cc.p(0, -GameDisplay.fix_y))

	for iter_48_0, iter_48_1 in pairs({
		"di"
	}) do
		local var_48_0 = self.mainNode:getChildByName(iter_48_1)

		var_48_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_48_0:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_48_0:setPositionY(var_48_0.full_posY)
	end

	for iter_48_2, iter_48_3 in pairs({
		"banner",
		"title",
		"time_bg",
		"time",
		"btn_getflip",
		"coin_bg",
		"coin",
		"coin_num",
		"process_bg",
		"level",
		"levelTitle",
		"mapnum",
		"btn_reset",
		"btn_team",
		"btn_phb",
		"btn_getdice"
	}) do
		local var_48_1 = self.mainNode:getChildByName(iter_48_3)

		var_48_1:setLocalZOrder(iter_48_2)

		var_48_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_48_1:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_48_1:setPositionY(var_48_1.full_posY)
	end

	self.selectStudentNode:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	self.selectSkillNode:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	self.selectStudentNode:getChildByName("bg"):setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	self.selectSkillNode:getChildByName("bg"):setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))

	for iter_48_4, iter_48_5 in pairs((self.selectStudentNode:getChildren())) do
		if iter_48_5:getName() ~= "bg" then
			iter_48_5:setLocalZOrder(1)

			iter_48_5.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - iter_48_5:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

			iter_48_5:setPositionY(iter_48_5.full_posY)
		end
	end

	for iter_48_6, iter_48_7 in pairs((self.selectSkillNode:getChildren())) do
		if iter_48_7:getName() ~= "bg" then
			iter_48_7:setLocalZOrder(1)

			iter_48_7.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - iter_48_7:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

			iter_48_7:setPositionY(iter_48_7.full_posY)
		end
	end

	self.getDiceNode:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))

	self.showSkillNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.showSkillNode:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.showSkillNode:setPositionY(self.showSkillNode.full_posY)
	self.headNode:setPositionY((GameDisplay.height + GameDisplay.fix_y - 1136) / 2 + self.headNode:getPositionY())
end

function MonopolyLayer:initItemNode()
	self.mainItemNode = ccui.Layout:create()

	self.mainItemNode:setPosition(cc.p(300, 300))
	self.mainItemNode:setAnchorPoint(cc.p(0.5, 0.5))
	self.mainItemNode:setTouchEnabled(false)
	self.root:addChild(self.mainItemNode)

	local var_49_0 = ccui.ImageView:create(self.resPath .. "select_level_kuang.png", var_0_11)

	var_49_0:setName("select")
	self.mainItemNode:addChild(var_49_0, 1)

	local var_49_1 = ccui.Button:create(self.resPath .. "bg1.png", self.resPath .. "bg1.png", self.resPath .. "bg1.png", var_0_11)

	var_49_1:setName("bg")
	self.mainItemNode:addChild(var_49_1, 1)

	local var_49_2 = var_49_1:getContentSize().width
	local var_49_3 = var_49_1:getContentSize().height
	local var_49_4 = ccui.ImageView:create(self.resPath .. "stop.png", var_0_11)

	var_49_4:setName("stop")
	self.mainItemNode:addChild(var_49_4, 1)

	local var_49_5 = ccui.ImageView:create(self.resPath .. "icon_box.png", var_0_11)

	var_49_5:setName("icon")
	var_49_5:setPositionY(20)
	self.mainItemNode:addChild(var_49_5, 1)

	local var_49_6 = ccui.ImageView:create("", var_0_11)

	var_49_6:setName("mask")
	self.mainItemNode:addChild(var_49_6, 1)

	local var_49_7 = ccui.Text:create("休息", FONT_NAME, 22)

	var_49_7:setPosition(cc.p(0, -var_49_3 / 2 + 22))
	var_49_7:setName("name")
	self.mainItemNode:addChild(var_49_7, 1)

	local var_49_8 = ccui.ImageView:create(self.resPath .. "footprint.png", var_0_11)

	var_49_8:setAnchorPoint(cc.p(1, 0))
	var_49_8:setPosition(cc.p(17, var_49_3 / 2 - 30))
	var_49_8:setScaleX(1)
	var_49_8:setName("line1")
	self.mainItemNode:addChild(var_49_8, 0)

	local var_49_9 = ccui.ImageView:create(self.resPath .. "footprint1.png", var_0_11)

	var_49_9:setAnchorPoint(cc.p(1, 0))
	var_49_9:setPosition(cc.p(-17, var_49_3 / 2 - 12))
	var_49_9:setName("line2")
	self.mainItemNode:addChild(var_49_9, 0)
	self.mainItemNode:setVisible(false)

	local var_49_10 = cc.p(0.5, 0.5)
	local var_49_11 = cc.p(110, 90 + 25)

	self.studentItemNode = ccui.Layout:create()

	self.studentItemNode:setAnchorPoint(var_49_10)
	self.studentItemNode:setContentSize(cc.size(170, 236))
	self.studentItemNode:setTouchEnabled(false)
	self.root:addChild(self.studentItemNode)

	local var_49_12 = ccui.ImageView:create(self.resPath .. "select_kuang.png", var_0_11)

	var_49_12:setVisible(false)
	var_49_12:setAnchorPoint(var_49_10)
	var_49_12:setPosition(var_49_11)
	var_49_12:setName("select")
	self.studentItemNode:addChild(var_49_12)

	local var_49_13 = ccui.Button:create(self.resPath .. "bg_select1.png", self.resPath .. "bg_select1.png", self.resPath .. "bg_select1.png", var_0_11)

	var_49_13:setAnchorPoint(var_49_10)
	var_49_13:setPosition(var_49_11)
	var_49_13:setName("bg")
	self.studentItemNode:addChild(var_49_13)

	local var_49_14 = var_49_13:getContentSize().width
	local var_49_15 = var_49_13:getContentSize().height
	local var_49_16 = ccui.ImageView:create("", var_0_11)

	var_49_16:setName("icon")
	var_49_16:setAnchorPoint(var_49_10)
	var_49_16:setPosition(var_49_11)
	self.studentItemNode:addChild(var_49_16)

	local var_49_17 = ccui.ImageView:create(self.resPath .. "rarity1.png", var_0_11)

	var_49_17:setName("rarity")
	var_49_17:setPosition(cc.p(65, -75))
	self.studentItemNode:addChild(var_49_17)

	local var_49_18 = ccui.ImageView:create(self.resPath .. "rarity_bg.png", var_0_11)

	var_49_18:setName("type")
	var_49_18:setPosition(cc.p(115, -75))
	self.studentItemNode:addChild(var_49_18)

	local var_49_19 = ccui.Text:create("重装", FONT_NAME, 16)

	var_49_19:setName("typeName")
	var_49_19:setPosition(cc.p(25, 10))
	var_49_18:addChild(var_49_19)
	self.studentItemNode:setVisible(false)

	local var_49_20 = cc.p(0.5, 0.5)
	local var_49_21 = cc.p(110, 90 + 55)

	self.skillItemNode = ccui.Layout:create()

	self.skillItemNode:setAnchorPoint(var_49_20)
	self.skillItemNode:setContentSize(cc.size(170, 300))
	self.skillItemNode:setTouchEnabled(false)
	self.root:addChild(self.skillItemNode)

	local var_49_22 = ccui.ImageView:create(self.resPath .. "select_kuang.png", var_0_11)

	var_49_22:setVisible(false)
	var_49_22:setAnchorPoint(var_49_20)
	var_49_22:setPosition(var_49_21)
	var_49_22:setName("select")
	self.skillItemNode:addChild(var_49_22)

	local var_49_23 = ccui.Button:create(self.resPath .. "bg_select2.png", self.resPath .. "bg_select2.png", self.resPath .. "bg_select2.png", var_0_11)

	var_49_23:setAnchorPoint(var_49_20)
	var_49_23:setPosition(var_49_21)
	var_49_23:setName("bg")
	self.skillItemNode:addChild(var_49_23)

	local var_49_24 = ccui.ImageView:create("", var_0_11)

	var_49_24:setName("icon")
	var_49_23:addChild(var_49_24)

	local var_49_25 = ccui.Text:create("技能名字", FONT_NAME, 22)

	var_49_25:setName("name")
	var_49_23:addChild(var_49_25)

	local var_49_26 = ccui.Text:create("技能描述", FONT_NAME, 18)

	var_49_26:setContentSize(cc.size(150, 200))
	var_49_26:ignoreContentAdaptWithSize(false)
	var_49_26:setName("des")
	var_49_26:setPosition(cc.p(15, 80))
	var_49_26:setAnchorPoint(cc.p(0, 1))
	var_49_23:addChild(var_49_26)
	self.skillItemNode:setVisible(false)

	self.buffItemNode = ccui.Layout:create()

	self.buffItemNode:setAnchorPoint(var_49_20)
	self.buffItemNode:setContentSize(cc.size(300, 30))
	self.buffItemNode:setTouchEnabled(false)
	self.buffItemNode:setAnchorPoint(cc.p(0, 0.5))
	self.root:addChild(self.buffItemNode)

	local var_49_27 = ccui.ImageView:create(self.resPath .. "buff_bg.png", var_0_11)

	var_49_27:setName("bg")
	var_49_27:setAnchorPoint(cc.p(0, 0))
	var_49_27:setPosition(cc.p(55, 0))
	var_49_27:setScale9Enabled(true)
	self.buffItemNode:addChild(var_49_27)

	local var_49_28 = ccui.ImageView:create(self.resPath .. "buff.png", var_0_11)

	var_49_28:setName("icon")
	var_49_28:setAnchorPoint(cc.p(0, 0))
	var_49_28:setPosition(cc.p(0, -2))
	self.buffItemNode:addChild(var_49_28)

	local var_49_29 = ccui.Text:create("测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述测试描述", FONT_NAME, 16)

	var_49_29:setName("des")
	var_49_29:setPosition(cc.p(55, 5))
	var_49_29:setAnchorPoint(cc.p(0, 0))
	self.buffItemNode:addChild(var_49_29)
	self.buffItemNode:setVisible(false)
end

function MonopolyLayer:getMainItemNode(arg_50_1, arg_50_2)
	local var_50_0 = expedition_manager:getExpeditionInfo()

	if var_50_0 == nil or var_50_0.stepList == nil then
		return
	end

	local var_50_2 = 1
	local var_50_3 = ccui.Layout:create()

	var_50_3:setTouchEnabled(false)
	var_50_3:setName("item")

	local var_50_4 = arg_50_1 % 5
	local var_50_5 = math.floor(arg_50_1 / 5)
	local var_50_6 = var_50_5 % 2 ~= 0
	local var_50_7 = 0

	var_50_7 = var_50_5 % 2 ~= 0 == true and (4 - var_50_4) * 130 + 60 or var_50_4 * 130 + 60

	local var_50_8 = var_50_5 * 220 + 400

	for iter_50_0 = 1, var_50_2 do
		local var_50_9 = self.mainItemNode:clone()

		var_50_9:setVisible(true)
		var_50_9:setName("item" .. 1)
		var_50_3:addChild(var_50_9)
		var_50_9:setPosition(cc.p(var_50_7, var_50_8))

		local var_50_12 = var_50_9:getChildByName("bg")
		local var_50_13 = var_50_12:getContentSize().width
		local var_50_14 = var_50_12:getContentSize().height
		local var_50_15 = var_50_9:getChildByName("stop")
		local var_50_16 = var_50_9:getChildByName("mask")
		local var_50_17 = var_50_9:getChildByName("name")
		local var_50_18 = var_50_9:getChildByName("line1")
		local var_50_19 = var_50_9:getChildByName("line2")
		local var_50_20 = var_50_9:getChildByName("select")

		var_50_15:setPositionY(-40)
		var_50_16:setVisible(fasle)
		var_50_17:setVisible(fasle)
		var_50_20:setVisible(fasle)
		var_50_18:setVisible((arg_50_1 + 1) % 5 == 0)
		var_50_19:setVisible((arg_50_1 + 1) % 5 ~= 0)

		if var_50_6 == true then
			var_50_19:setScaleX(-1)
			var_50_19:setPosition(cc.p(-90, -20))
		else
			var_50_19:setScaleX(1)
			var_50_19:setPosition(cc.p(90, -20))
		end
	end

	return var_50_3
end

function MonopolyLayer:initLevelViewPanel(arg_51_1)
	arg_51_1 = arg_51_1 or {}

	local var_51_0 = arg_51_1.callback
	local var_51_1 = expedition_manager:getExpeditionInfo()

	if var_51_1 == nil then
		return
	end

	if self.listViewNode ~= nil then
		self.listViewNode:removeFromParent()
	end

	local var_51_2 = "MonopolyLevelMapLayer" .. self.initconfig.inittype

	self.listViewNode = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (var_51_2 .. ".json" or var_51_2 .. ".ExportJson"))

	self.listViewNode:setTouchEnabled(false)
	self.listViewNode:setName("levelView")
	self.listViewNode:setPosition(cc.p(0, 0))
	self.listViewNode:setPositionY((GameDisplay.height + GameDisplay.fix_y - 1136) / 2 + self.listViewNode:getPositionY())
	self.mainNode:addChild(self.listViewNode)

	local var_51_3 = ccui.ImageView:create("mainScenebg/chessboard_bg.png", var_0_11)

	var_51_3:setAnchorPoint(cc.p(0, 0))
	var_51_3:setPosition(cc.p(0, 218))
	self.listViewNode:addChild(var_51_3, -1)

	local var_51_4 = var_51_1.stepList
	local var_51_5 = cc.size(640, GameDisplay.height + GameDisplay.fix_y - 60)

	self.lastSelectLevelIndex = nil
	self.lastSelectRoomIndex = nil

	local function var_51_6(arg_52_0)
		local var_52_0 = arg_52_0 + 1
		local var_52_1 = self.listViewNode:getChildByName("item" .. arg_52_0 + 1)
		local var_52_2 = var_52_1:getChildByName("bg")
		local var_52_3 = 1
		local var_52_4 = var_52_2:getContentSize()
		local var_52_5, var_52_6 = var_52_1:getPosition()
		local var_52_7, var_52_8 = var_52_2:getPosition()

		if var_0_15[math.floor(arg_52_0 / 5) + 1] == nil then
			var_0_15[math.floor(arg_52_0 / 5) + 1] = {}
		end

		var_0_15[math.floor(arg_52_0 / 5) + 1][arg_52_0 % 5 + 1] = cc.p(var_52_5 + var_52_7 + var_52_4.width / 2, var_52_6 + var_52_8 + var_52_4.height / 2 + 30)

		local var_52_9 = var_52_1:getChildByName("bg")
		local var_52_10 = var_52_1:getChildByName("fog")

		if var_52_10 then
			var_52_10:setVisible(var_51_4[arg_52_0 + 1].roomList[1].isHaveFog)
		end

		if var_51_4[arg_52_0 + 1].roomList[1].isHaveFog == false then
			if var_51_4[arg_52_0 + 1].roomList[1].roomType ~= ExpeditionRoomType.Random and var_51_4[arg_52_0 + 1].roomList[1].roomType ~= ExpeditionRoomType.Rest and var_51_4[arg_52_0 + 1].roomList[1].roomType ~= ExpeditionRoomType.Transmit then
				if var_51_4[arg_52_0 + 1].roomList[1].roomType == ExpeditionRoomType.Recruit then
					var_52_1:getChildByName("icon"):loadTexture(var_51_4[arg_52_0 + 1].roomList[1].roomIcon and self.resPath .. "icon_" .. var_51_4[arg_52_0 + 1].roomList[1].roomIcon .. ".png", var_0_11)
				end
			end
		end

		var_52_9:setSwallowTouches(false)
		var_52_9:addTouchEventListener(function(arg_53_0, arg_53_1)
			if arg_53_1 ~= ccui.TouchEventType.ended then
				return
			end

			print("click")

			if math.abs(arg_53_0:getTouchBeganPosition().y - arg_53_0:getTouchEndPosition().y) > 50 then
				return
			end

			self.lastSelectLevelIndex = var_52_0
			self.lastSelectRoomIndex = var_52_3

			self:onBtnLevelCallback(var_52_0, var_52_3, nil, true)

			function expedition_manager.updateCurLevelViewPanel()
				return
			end
		end)
	end

	for iter_51_0 = 1, #var_51_1.stepList do
		var_51_6(iter_51_0 - 1)
	end

	self:initMonsterBossPanel()
	self:lateUpdate(function()
		self.listViewNode:setVisible(true)
		self.selectStudentNode:setVisible(false)
		self.selectSkillNode:setVisible(false)
		self:showHead(arg_51_1.isNeedShowHeadAni, function()
			self:checkTriggerEventByLastLevel()

			if type(var_51_0) == "function" then
				var_51_0()
			end
		end)
	end)
end

function MonopolyLayer:initMonsterBossPanel()
	local var_57_0 = expedition_manager:getExpeditionInfo()
	local var_57_1

	if var_57_0.enemyList == nil or next(var_57_0.enemyList) == nil then
		do return end

		var_57_1 = level_manager.getCurMonsterData(expedition_manager:getCurMode(), var_57_0.enemyList[1].monsterid)
	end

	assert(var_57_1, string.format("CurMonsterData is nil,the monsterid is %d", var_57_0.enemyList[1].monsterid))
	assert(model_data[var_57_1.modelid], string.format("curModelData is nil,the modelid is %d", var_57_1.modelid))

	if self.mainNode:getChildByName("monsterBoss") then
		self.mainNode:getChildByName("monsterBoss"):removeFromParent()
	end

	local var_57_3 = ccui.Layout:create()

	var_57_3:setName("monsterBoss")
	self.mainNode:addChild(var_57_3, 98)
	var_57_3:setPosition(cc.p(320, 635))
	var_57_3:setPositionY((GameDisplay.height + GameDisplay.fix_y - 1136) / 2 + var_57_3:getPositionY())
	var_57_3:setVisible(true)

	local var_57_4 = ccui.ImageView:create(self.resPath .. "blood_bg.png", var_0_11)

	var_57_4:setPosition(cc.p(0, -15))

	self.curBloodNode = ccui.ImageView:create(self.resPath .. "blood.png", var_0_11)

	self.curBloodNode:setAnchorPoint(cc.p(0, 0.5))
	self.curBloodNode:setPosition(cc.p(0 - self.curBloodNode:getContentSize().width / 2, -15))
	var_57_3:addChild(var_57_4)
	var_57_3:addChild(self.curBloodNode)
	self.curBloodNode:setScaleX(var_57_0.enemyList[1].bloodpercent / 100)

	local var_57_5 = ccui.Text:create(math.floor(var_57_0.enemyList[1].bloodpercent * 100) / 100 .. "%", FONT_NAME, 22)

	var_57_5:setPosition(cc.p(0, -15))
	var_57_3:addChild(var_57_5)

	local var_57_6 = ccui.Layout:create()

	var_57_6:setContentSize(cc.size(300, 100))
	var_57_6:setPosition(cc.p(-160, -120))
	var_57_6:setName("drop")
	var_57_3:addChild(var_57_6)

	local var_57_7 = ccui.ImageView:create(self.resPath .. "drop_tips.png", var_0_11)

	var_57_7:setAnchorPoint(cc.p(0, 0))
	var_57_7:setPosition(cc.p(0, 10))
	var_57_6:addChild(var_57_7)

	if var_57_6:getChildByName("ListView") == nil then
		self.ListView_buttom = ccui.ListView:create()

		self.ListView_buttom:setContentSize(cc.size(300, 280))
		self.ListView_buttom:setInnerContainerSize(cc.size(300, 280))
		self.ListView_buttom:setDirection(ccui.ListViewDirection.horizontal)
		self.ListView_buttom:setPosition(cc.p(30, -95))
		self.ListView_buttom:setName("ListView")
		var_57_6:addChild(self.ListView_buttom)
	end

	self:initPanelList_H2((Utility:getDropData(var_57_0.chapterDropId)))

	local var_57_8 = ccui.Layout:create()

	var_57_8:setContentSize(cc.size(330, 140))
	var_57_8:setPosition(cc.p(-160, -280))
	var_57_8:setName("tips")
	var_57_3:addChild(var_57_8)

	local var_57_9 = ccui.ImageView:create(self.resPath .. "tips_title.png", var_0_11)

	var_57_9:setAnchorPoint(cc.p(0, 0))
	var_57_9:setPosition(cc.p(120, 120))
	var_57_8:addChild(var_57_9)

	local var_57_10 = ccui.Text:create(var_57_0.chapterTipsStr, FONT_NAME, 14)

	var_57_10:setAnchorPoint(cc.p(0, 1))
	var_57_10:setPosition(cc.p(5, 110))
	var_57_10:setColor(cc.c3b(136, 142, 225))
	var_57_10:setContentSize(cc.size(310, 140))
	var_57_10:ignoreContentAdaptWithSize(false)
	var_57_8:addChild(var_57_10)
end

function MonopolyLayer:initPanelList_H2(arg_58_1, arg_58_2)
	self.ListView_buttom:removeAllChildren()
	self.ListView_buttom:setItemsMargin(10)

	for iter_58_0, iter_58_1 in ipairs(arg_58_1) do
		local var_58_0 = ccui.Layout:create()
		local var_58_1 = ItemSprite:createItemIconWithItemid(iter_58_1.itemid, iter_58_1.num, true, "monopolybg")
		local var_58_2 = var_58_1:getChildByName("cut_panel")

		var_58_2:getChildByName("itemSp"):setScale(0.4)

		local var_58_3 = var_58_2:getChildByName("label_num")

		var_58_3:setFontSize(16)
		var_58_3:setFontName(FONT_NAME)
		var_58_3:setString("X" .. iter_58_1.num)

		local var_58_4 = var_58_1:getContentSize()

		var_58_1:setPosition(cc.p(var_58_4.width / 2, var_58_4.height / 2))
		var_58_0:setContentSize(cc.size(var_58_4.width, var_58_4.height))
		var_58_0:addChild(var_58_1)
		self.ListView_buttom:pushBackCustomItem(var_58_0)
	end
end

function MonopolyLayer.onBtnLevelBattleCallback(arg_59_0, arg_59_1)
	local var_59_0 = expedition_manager:getExpeditionInfo()

	LayerManager:pushInLayer("ExpeditionDetailLayer", {
		mode = var_59_0.initmode,
		chapter = var_59_0.curChapter,
		level = expedition_manager:getRoomIndex(arg_59_1.levelindex, arg_59_1.roomindex),
		surecallback = function()
			if type(arg_59_1.callback) == "function" then
				arg_59_1.callback()
			end
		end,
		roomStatus = arg_59_1.roomStatus
	})
end

function MonopolyLayer:getSpineByModelId(arg_61_1)
	local var_61_2 = spinecache_manager:addSpineData(ROLE_SPINE_PATH .. model_data[arg_61_1].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[arg_61_1].spine_model .. ".atlas", (model_data[arg_61_1].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[arg_61_1].clothes_model .. ".atlas" or nil), model_data[arg_61_1].changeslot)

	var_61_2:retain()

	local var_61_3 = sp.SkeletonAnimation:create(var_61_2:getData())
	local var_61_4 = model_data[arg_61_1].modelscale or 1

	var_61_3:setScale(var_0_10 * var_61_4 * (model_data[arg_61_1].modelflip or 1), var_0_10 * var_61_4)
	var_61_3:addAnimation(0, "idle", true)
	var_61_3:setMix("win", "idle", 2)

	local var_61_5 = ccui.ImageView:create(self.resPath .. "player_shadow.png", var_0_11)

	var_61_5:setScale(5)
	var_61_3:addChild(var_61_5, -1)

	return var_61_3
end

function MonopolyLayer:showEventEffect(arg_62_1)
	if arg_62_1 == nil then
		return
	end

	for iter_62_0, iter_62_1 in pairs(arg_62_1) do
		if iter_62_1.eventtype == var_0_14.Blood then
			local var_62_0 = tonumber(iter_62_1.eventvalue)

			if var_62_0 < 0 then
				audio_manager:playeffectMusic("5200_ci", false, 5)

				local var_62_1 = self.headNode:getChildByName("clip")
				local var_62_2 = self.headNode:getChildByName("spine")

				if var_62_2 ~= nil then
					var_62_2:removeFromParent()
				end

				local var_62_4 = L2Skeleton:create("spine/test/21020_effect.json", "spine/test/21020_effect.atlas")

				var_62_4:refreshSkeleton()
				var_62_4:play("attack", false)
				var_62_4:setName("spine")
				var_62_4:setVisible(true)
				var_62_4:setPosition(cc.p(var_62_1:getPositionX(), var_62_1:getPositionY()))
				var_62_4:registerListener(SP_ANIMATION_COMPLETE, function(arg_63_0)
					return
				end)
				self:usualSchedulerWithCallback(function()
					var_62_4:setVisible(false)
				end, 1)
				self.headNode:addChild(var_62_4, 99)
			elseif var_62_0 > 0 then
				audio_manager:playeffectMusic("zhiliao", false, 5)

				local var_62_5 = self.headNode:getChildByName("clip")
				local var_62_6 = self.headNode:getChildByName("spine")

				if var_62_6 ~= nil then
					var_62_6:removeFromParent()
				end

				local var_62_8 = L2Skeleton:create("spine/test/21100_effect.json", "spine/test/21100_effect.atlas")

				var_62_8:refreshSkeleton()
				var_62_8:play("skill", false)
				var_62_8:setName("spine")
				var_62_8:setVisible(true)
				var_62_8:setScale(0.3)
				var_62_8:setPosition(cc.p(var_62_5:getPositionX(), var_62_5:getPositionY()))
				var_62_8:registerListener(SP_ANIMATION_COMPLETE, function(arg_65_0)
					return
				end)
				self:usualSchedulerWithCallback(function()
					var_62_8:setVisible(false)
				end, 1)
				self.headNode:addChild(var_62_8, 99)
			end
		elseif iter_62_1.eventtype == var_0_14.Reborn then
			audio_manager:playeffectMusic("zhiliao", false, 5)

			local var_62_9 = self.headNode:getChildByName("clip")
			local var_62_10 = self.headNode:getChildByName("spine")

			if var_62_10 ~= nil then
				var_62_10:removeFromParent()
			end

			local var_62_12 = L2Skeleton:create("spine/test/21100_effect.json", "spine/test/21100_effect.atlas")

			var_62_12:refreshSkeleton()
			var_62_12:play("skill", false)
			var_62_12:setName("spine")
			var_62_12:setVisible(true)
			var_62_12:setScale(0.3)
			var_62_12:setPosition(cc.p(var_62_9:getPositionX(), var_62_9:getPositionY()))
			var_62_12:registerListener(SP_ANIMATION_COMPLETE, function(arg_67_0)
				return
			end)
			self:usualSchedulerWithCallback(function()
				var_62_12:setVisible(false)
			end, 1)
			self.headNode:addChild(var_62_12, 99)
		elseif iter_62_1.eventtype == var_0_14.Recruit then
			local var_62_13, var_62_14 = self.btn_team:getPosition()

			for iter_62_2, iter_62_3 in pairs((self.selectStudentNode:getChildByName("listView"):getItems())) do
				local var_62_15 = iter_62_3:getParent():convertToWorldSpace(cc.p(iter_62_3:getPositionX(), iter_62_3:getPositionY()))

				assert(servant_data[iter_62_3.servantid], string.format("servantid is not in ServantData ,please check it out:%d", iter_62_3.servantid))

				local var_62_16 = self:getSpineByModelId(servant_data[iter_62_3.servantid].modelid)

				var_62_16:setPosition(cc.p(var_62_15.x, var_62_15.y - 90))
				var_62_16:runAction((cc.Sequence:create(cc.CallFunc:create(function()
					var_62_16:setAnimation(0, "idle_happy", true)
				end), cc.MoveTo:create(0.5, cc.p(var_62_13, var_62_14 - 30)), cc.RemoveSelf:create())))
				self:addChild(var_62_16, 999)
			end
		elseif iter_62_1.eventtype == var_0_14.Skill then
			local var_62_17, var_62_18 = self.showSkillNode:getPosition()

			for iter_62_4, iter_62_5 in pairs((self.selectSkillNode:getChildByName("listView"):getItems())) do
				if iter_62_5.isSelected == true then
					local var_62_19 = iter_62_5:getParent():convertToWorldSpace(cc.p(iter_62_5:getPositionX(), iter_62_5:getPositionY()))
					local var_62_20 = iter_62_5:getChildByName("bg"):getChildByName("icon"):clone()

					var_62_20:setPosition(cc.p(var_62_19.x, var_62_19.y))
					var_62_20:runAction((cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_62_17 + 50, var_62_18)), cc.RemoveSelf:create())))
					self:addChild(var_62_20, 999)
				end
			end
		elseif iter_62_1.eventtype == EXPEDITION.EVENT_TYPE.Clear then
			local function var_62_21()
				local var_70_0 = expedition_manager:getClearLevelIndex()

				if var_70_0 == nil then
					return
				end

				local var_70_1 = self.listViewNode:getChildByName("item" .. var_70_0)

				if var_70_1 == nil then
					return
				end

				local var_70_2 = var_70_1:getChildByName("spineAni")

				if var_70_2 ~= nil then
					var_70_2:removeFromParent()
				end

				local var_70_4 = L2Skeleton:create("spine/test/21100_effect.json", "spine/test/21100_effect.atlas")

				var_70_4:refreshSkeleton()
				var_70_4:play("skill", false)
				var_70_4:setName("spine")
				var_70_4:setVisible(true)
				var_70_4:setScale(0.3)
				var_70_4:registerListener(SP_ANIMATION_COMPLETE, function(arg_71_0)
					return
				end)
				self:usualSchedulerWithCallback(function()
					var_70_4:setVisible(false)
					expedition_manager:setClearLevelIndex(nil)
				end, 1)
				var_70_1:addChild(var_70_4, 99)
			end

			audio_manager:playeffectMusic("warning", false, 5)

			local var_62_22 = self.headNode:getChildByName("clip")
			local var_62_23 = self.headNode:getChildByName("spine")

			if var_62_23 ~= nil then
				var_62_23:removeFromParent()
			end

			local var_62_25 = L2Skeleton:create("spine/test/21100_effect.json", "spine/test/21100_effect.atlas")

			var_62_25:refreshSkeleton()
			var_62_25:play("skill", false)
			var_62_25:setName("spine")
			var_62_25:setVisible(true)
			var_62_25:setScale(0.3)
			var_62_25:setPosition(cc.p(var_62_22:getPositionX(), var_62_22:getPositionY()))
			var_62_25:registerListener(SP_ANIMATION_COMPLETE, function(arg_73_0)
				return
			end)
			self:usualSchedulerWithCallback(function()
				var_62_25:setVisible(false)
				var_62_21()
			end, 1)
			self.headNode:addChild(var_62_25, 99)
		end
	end
end

function MonopolyLayer.setHeadDirection(arg_75_0, arg_75_1, arg_75_2, arg_75_3)
	local var_75_0 = 1
	local var_75_1, var_75_2 = arg_75_1:getPosition()
	local var_75_3 = math.abs(var_75_1 - arg_75_3.x)
	local var_75_4 = math.abs(var_75_2 - arg_75_3.y)
	local var_75_5 = math.floor(var_75_1)
	local var_75_6 = math.floor(var_75_2)

	arg_75_3.x = math.floor(arg_75_3.x)
	arg_75_3.y = math.floor(arg_75_3.y)

	if var_75_4 < var_75_3 then
		arg_75_3.y = var_75_6
	else
		arg_75_3.x = var_75_5
	end

	if var_75_5 < arg_75_3.x and arg_75_3.y == var_75_6 and var_75_3 >= 100 then
		var_75_0 = 1
	elseif var_75_5 > arg_75_3.x and arg_75_3.y == var_75_6 and var_75_3 >= 100 then
		var_75_0 = -1
	elseif arg_75_3.x == var_75_5 and var_75_6 > arg_75_3.y and var_75_4 >= 100 then
		var_75_0 = -1
	elseif arg_75_3.x == var_75_5 and var_75_6 < arg_75_3.y and var_75_4 >= 100 then
		var_75_0 = 1
	end

	if var_75_3 == 0 and var_75_4 == 0 then
		if arg_75_2 >= 1 and arg_75_2 < 10 then
			var_75_0 = 1
		elseif arg_75_2 >= 10 and arg_75_2 <= 18 then
			var_75_0 = -1
		end
	end

	arg_75_1:setScaleX(var_75_0)
end

function MonopolyLayer:showHead(arg_76_1, arg_76_2)
	arg_76_1 = arg_76_1 or false

	local var_76_0 = expedition_manager:getExpeditionInfo()
	local var_76_1 = var_76_0.teamList
	local var_76_2 = 0

	var_76_2 = var_76_0.curPassInfo[#var_76_0.curPassInfo] == 0 and var_76_0.curLevel or var_76_0.curLevel + 1

	if arg_76_1 == true and var_76_2 <= 1 and var_76_0.isBackToOrigin ~= true then
		arg_76_1 = false
	end

	if arg_76_1 == false then
		local var_76_3

		if var_76_2 > 0 and #var_76_1 > 0 then
			local var_76_4 = var_0_15[math.floor((var_76_2 - 1) / 5) + 1][(var_76_2 - 1) % 5 + 1]

			self.headNode:setPosition(cc.p(var_76_4.x, var_76_4.y + (GameDisplay.height + GameDisplay.fix_y - 1136) / 2))
			self.headNode:setVisible(true)

			if self.headNode:getChildByName("clip") == nil then
				local var_76_5 = self:getSpineByModelId(servant_data[var_76_1[1].servantid].modelid)

				var_76_5:setPosition(cc.p(0, -50))
				var_76_5:setName("clip")
				self.headNode:addChild(var_76_5)
			end

			var_76_3 = cc.p(var_76_4.x, var_76_4.y + (GameDisplay.height + GameDisplay.fix_y - 1136) / 2)
		else
			self.headNode:setPosition(cc.p(self.headStartPosX, self.headStartPosY))

			var_76_3 = cc.p(self.headStartPosX, self.headStartPosY)
		end

		self:setHeadDirection(self.headNode, var_76_2, var_76_3)

		self.lastLevel = var_76_2

		if type(arg_76_2) == "function" then
			arg_76_2()
		end
	else
		if var_76_2 > 0 and #var_76_1 > 0 then
			self.headNode:setVisible(true)

			if self.headNode:getChildByName("clip") == nil then
				local var_76_6 = self:getSpineByModelId(servant_data[var_76_1[1].servantid].modelid)

				var_76_6:setPosition(cc.p(0, -50))
				var_76_6:setName("clip")
				self.headNode:addChild(var_76_6)
			end

			local var_76_7 = {}

			if var_76_2 > self.lastLevel then
				for iter_76_0 = self.lastLevel + 1, var_76_2 do
					local var_76_8 = var_0_15[math.floor((iter_76_0 - 1) / 5) + 1][(iter_76_0 - 1) % 5 + 1]

					table.insert(var_76_7, {
						pos = cc.p(var_76_8.x, var_76_8.y + (GameDisplay.height + GameDisplay.fix_y - 1136) / 2),
						levelIndex = iter_76_0
					})
				end
			elseif var_76_2 < self.lastLevel then
				for iter_76_1 = self.lastLevel - 1, var_76_2, -1 do
					local var_76_9 = var_0_15[math.floor((iter_76_1 - 1) / 5) + 1][(iter_76_1 - 1) % 5 + 1]

					table.insert(var_76_7, {
						pos = cc.p(var_76_9.x, var_76_9.y + (GameDisplay.height + GameDisplay.fix_y - 1136) / 2),
						levelIndex = iter_76_1
					})
				end
			end

			local var_76_10 = math.random(2) == 1 and "run" or "run2"

			local function var_76_11()
				if #var_76_7 > 0 then
					table.remove(var_76_7, 1)
					audio_manager:playeffectMusic(EXPLORE_WALK, true)
					self.headNode:runAction((cc.Sequence:create(cc.CallFunc:create(function()
						self.headNode:getChildByName("clip"):setAnimation(0, "run", true)
					end), cc.MoveTo:create(0.5, cc.p(var_76_7[1].pos.x, var_76_7[1].pos.y)), cc.CallFunc:create(function()
						audio_manager:stopAllEffects()
						self.headNode:getChildByName("clip"):setAnimation(0, "idle", true)
						var_76_11()
					end))))
					self:setHeadDirection(self.headNode, var_76_7[1].levelIndex, var_76_7[1].pos)
				elseif type(arg_76_2) == "function" then
					arg_76_2()
				end
			end

			var_76_11()
		elseif var_76_2 == 0 and var_76_0.isBackToOrigin == true and #var_76_1 > 0 then
			self.headNode:setVisible(true)

			if self.headNode:getChildByName("clip") == nil then
				local var_76_12 = self:getSpineByModelId(servant_data[var_76_1[1].servantid].modelid)

				var_76_12:setPosition(cc.p(0, -50))
				var_76_12:setName("clip")
				self.headNode:addChild(var_76_12)
			end

			local var_76_13 = {}

			for iter_76_2 = self.lastLevel + 1, 18 do
				local var_76_14 = var_0_15[math.floor((iter_76_2 - 1) / 5) + 1][(iter_76_2 - 1) % 5 + 1]

				table.insert(var_76_13, {
					pos = cc.p(var_76_14.x, var_76_14.y + (GameDisplay.height + GameDisplay.fix_y - 1136) / 2),
					levelIndex = iter_76_2
				})
			end

			table.insert(var_76_13, {
				levelIndex = 1,
				pos = cc.p(var_0_15[1][1].x, var_0_15[1][1].y + (GameDisplay.height + GameDisplay.fix_y - 1136) / 2)
			})

			local var_76_15 = math.random(2) == 1 and "run" or "run2"

			local function var_76_16()
				if #var_76_13 > 0 then
					table.remove(var_76_13, 1)
					audio_manager:playeffectMusic(EXPLORE_WALK, true)
					self.headNode:runAction((cc.Sequence:create(cc.CallFunc:create(function()
						self.headNode:getChildByName("clip"):setAnimation(0, "run", true)
					end), cc.MoveTo:create(0.5, cc.p(var_76_13[1].pos.x, var_76_13[1].pos.y)), cc.CallFunc:create(function()
						audio_manager:stopAllEffects()
						self.headNode:getChildByName("clip"):setAnimation(0, "idle", true)
						var_76_16()
					end))))
					self:setHeadDirection(self.headNode, var_76_13[1].levelIndex, var_76_13[1].pos)
				elseif type(arg_76_2) == "function" then
					arg_76_2()
				end
			end

			var_76_16()
		else
			self.headNode:setPosition(cc.p(self.headStartPosX, self.headStartPosY))

			if type(arg_76_2) == "function" then
				arg_76_2()
			end

			self:setHeadDirection(self.headNode, var_76_2, cc.p(self.headStartPosX, self.headStartPosY))
		end

		self.lastLevel = var_76_2
	end
end

function MonopolyLayer:showStepNumTips(arg_83_1, arg_83_2)
	self.stepNode:stopAllActions()
	self.stepNode:setOpacity(0)
	self.stepNode:getChildByName("tips"):setString(arg_83_1 > 0 and "前进" .. arg_83_1 .. "步" or "后退" .. arg_83_1 .. "步")

	local var_83_1 = self.mainNode:getChildByName("shaizispine")

	if var_83_1 == nil then
		var_83_1 = ccui.ImageView:create(self.resPath .. "dice" .. arg_83_1 .. ".png", var_0_11)

		var_83_1:setPosition(cc.p(320, 635))
		self.mainNode:addChild(var_83_1, 99)
	else
		var_83_1:loadTexture(self.resPath .. "dice" .. arg_83_1 .. ".png", var_0_11)
	end

	self:usualSchedulerWithCallback(function()
		self.stepNode:setOpacity(255)
		self.stepNode:runAction((cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
			self.stepNode:setOpacity(0)
			var_83_1:setVisible(false)
		end))))

		if type(arg_83_2) == "function" then
			arg_83_2()
		end
	end, 0)
end

function MonopolyLayer.doOperate(arg_86_0)
	local var_86_0 = expedition_manager:getCurLevelIndex() + 1
	local var_86_1 = expedition_manager:getCurLevelInfo()

	if expedition_manager:getCurLevelStatus() == var_0_13.Free then
		expedition_manager:setCurEventInfo("")
		expedition_manager:select_level_expedition({
			roomindex = 1
		}, function(arg_87_0)
			if type(arg_87_0) == "table" and arg_87_0.result == 5 then
				arg_86_0.isCanPlayDice = true

				return
			elseif type(arg_87_0) == "table" and arg_87_0.result == 6 then
				local var_87_0 = var_0_13.Free

				arg_86_0:initPanel({
					isNeedShowHeadAni = true,
					callback = function()
						if var_87_0 ~= var_0_13.Free then
							arg_86_0:doOperate()
						else
							arg_86_0.isCanPlayDice = true
						end
					end,
					levelstatus = var_0_13.Free
				})

				return
			end

			arg_86_0:initItemNum()

			if expedition_manager:isNeedAutoPlay() then
				arg_86_0:showHead(true, function()
					arg_86_0:doOperate()
				end)
			else
				arg_86_0:showStepNumTips(arg_87_0, function()
					arg_86_0:showHead(true, function()
						arg_86_0:doOperate()
					end)
				end)
			end
		end)
	elseif expedition_manager:getCurLevelStatus() == var_0_13.NeedBattle then
		expedition_manager:selectBattleCallback({
			levelindex = var_86_0,
			roomindex = 1,
			eventClassificationList = var_86_1.eventClassificationList
		})
	elseif expedition_manager:getCurLevelStatus() == var_0_13.NeedEvent then
		expedition_manager:selectEventCallback({
			levelindex = var_86_0,
			roomindex = 1,
			eventClassificationList = var_86_1.eventClassificationList,
			callback = function(arg_92_0)
				if arg_86_0:getChildByName("levelDetailPanel") then
					arg_86_0:getChildByName("levelDetailPanel"):setVisible(false)
				end

				arg_86_0:dealWithDialogEventList(arg_92_0, function()
					arg_86_0:showEventEffect(arg_92_0)
					arg_86_0:doOperate()
				end)
			end
		})
	elseif expedition_manager:getCurLevelStatus() == var_0_13.NeedResult then
		expedition_manager:do_level_result_expedition(function(arg_94_0)
			arg_86_0:initPanel({
				isNeedShowHeadAni = true,
				callback = function()
					if arg_94_0 ~= var_0_13.Free then
						arg_86_0:doOperate()
					else
						arg_86_0.isCanPlayDice = true
					end
				end,
				levelstatus = arg_94_0
			})
		end)
	end
end

function MonopolyLayer:onBtnLevelCallback(arg_96_1, arg_96_2, arg_96_3, arg_96_4)
	local var_96_0 = expedition_manager:getExpeditionInfo().stepList[arg_96_1].roomList[arg_96_2]

	arg_96_3 = arg_96_3 or false

	local function var_96_1()
		self:onBtnLevelBattleCallback({
			levelindex = arg_96_1,
			roomindex = arg_96_2,
			roomStatus = var_96_0.roomStatus,
			callback = function()
				self:doOperate()
			end
		})
	end

	if arg_96_3 == true then
		self:doOperate()
	elseif var_96_0.roomType == ExpeditionRoomType.Normal or var_96_0.roomType == ExpeditionRoomType.Elite or var_96_0.roomType == ExpeditionRoomType.Boss or var_96_0.roomType == ExpeditionRoomType.TowerDefenceElite or var_96_0.roomType == ExpeditionRoomType.TowerDefenceBoss then
		var_96_1()
	else
		(function()
			if var_96_0.detailPath == "" then
				print("event_icon 没填,eventid是" .. var_96_0.eventClassificationList[1].eventid)
			end

			self:onBtnLevelEventCallback({
				name = var_96_0.name,
				itemPath = var_96_0.detailPath,
				des = var_96_0.des,
				levelindex = arg_96_1,
				isHaveFog = var_96_0.isHaveFog,
				callback = function()
					self:doOperate()
				end,
				roomStatus = var_96_0.roomStatus
			})
		end)()
	end
end

function MonopolyLayer:lateUpdate(arg_101_1)
	if self.cinemaScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

		self.cinemaScheduler = nil
	end

	self.cinemaScheduler = self.scheduler:scheduleScriptFunc(function()
		if self.cinemaScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

			self.cinemaScheduler = nil
		end

		if type(arg_101_1) == "function" then
			arg_101_1()
		end
	end, 0, false)
end

function MonopolyLayer.showHaveStudentPanel(arg_103_0)
	if #expedition_manager:getExpeditionTeamListInfo() <= 0 then
		global_ShowBlockWords("暂未招募任何学员")

		return
	end

	LayerManager:pushInLayer("GirlSelectLayer", {
		arrayinfo = {
			index = 1,
			pos = 1
		},
		selectType = SELECT_GIRL_EXPEDITION_LIST
	})
end

function MonopolyLayer:getSkillItemNode()
	local var_104_0 = ccui.Layout:create()

	var_104_0:setTouchEnabled(true)
	var_104_0:setName("item")
	var_104_0:setContentSize(cc.size(300, 30))

	for iter_104_0 = 1, 1 do
		local var_104_1 = self.buffItemNode:clone()

		var_104_1:setVisible(true)
		var_104_1:setName("item" .. iter_104_0)
		var_104_0:addChild(var_104_1)
		var_104_1:setPosition(var_0_12[iter_104_0])
	end

	return var_104_0
end

function MonopolyLayer:showHaveSkillPanel()
	do return end

	local var_105_0 = expedition_manager:getExpeditionSkillListInfo()

	if var_105_0 ~= nil and next(var_105_0) == nil then
		-- block empty
	end

	self.showSkillNode:setVisible(true)

	local var_105_1 = self.showSkillNode:getChildByName("listView")

	var_105_1:removeAllItems()

	self.lastSelectSkillIndex = 1

	local var_105_2 = {}

	for iter_105_0, iter_105_1 in pairs(var_105_0) do
		if iter_105_1.skillid ~= nil then
			local var_105_3 = {
				id = #var_105_2 + 1,
				skillid = iter_105_1.skillid,
				rare = expedition_total_skill_data[iter_105_1.skillid].skill_rare,
				name = expedition_total_skill_data[iter_105_1.skillid].name,
				des = expedition_total_skill_data[iter_105_1.skillid].description
			}

			var_105_3.iconPath = "skill_new/skill/" .. (expedition_total_skill_data[iter_105_1.skillid].icon or 22822) .. ".png"

			table.insert(var_105_2, var_105_3)
		end
	end

	for iter_105_2 = 1, #var_105_2 do
		local var_105_4 = self:getSkillItemNode()

		var_105_4:setVisible(true)
		var_105_4:setName("skillItem" .. iter_105_2)

		for iter_105_3 = 1, 1 do
			local var_105_5 = var_105_4:getChildByName("item" .. iter_105_3)

			if var_105_2[(iter_105_2 - 1) * 1 + iter_105_3] then
				var_105_5:setVisible(true)
				var_105_5:getChildByName("des"):setString(var_105_2[(iter_105_2 - 1) * 1 + iter_105_3].des)
				var_105_5:getChildByName("bg"):setContentSize(cc.size(300, 30))
			else
				var_105_5:setVisible(false)
			end
		end

		var_105_1:pushBackCustomItem(var_105_4)
	end

	var_105_1:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_105_1:refreshView()
	var_105_1:jumpToTop()
end

function MonopolyLayer:onBtnLevelEventCallback(arg_106_1)
	if arg_106_1 == nil then
		return
	end

	if self:getChildByName("levelDetailPanel") then
		self:getChildByName("levelDetailPanel"):removeFromParent()
	end

	local var_106_0 = ccui.Layout:create()

	var_106_0:setTouchEnabled(true)
	var_106_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_106_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_106_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_106_0:addTouchEventListener(function(arg_107_0, arg_107_1)
		if var_106_0:getChildByName("bg") then
			var_106_0:getChildByName("bg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 0.1), cc.CallFunc:create(function()
				if callback then
					callback()
				end
			end), cc.RemoveSelf:create(), cc.CallFunc:create(function()
				self:removeChild(var_106_0)
			end)))
		else
			self:removeChild(var_106_0)
		end
	end)
	var_106_0:setName("levelDetailPanel")
	self:addChild(var_106_0)

	local function var_106_1()
		local var_110_0 = cc.Director:getInstance():getVisibleSize().width / 2
		local var_110_1 = cc.p(0.5, 0.5)
		local var_110_2 = ccui.ImageView:create("public/panelbg/bg_skill_details.png", var_0_11)

		var_110_2:setPosition((cc.p(var_110_0, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y)))
		var_110_2:setName("bg")
		var_110_2:setAnchorPoint(var_110_1)
		var_110_2:setScale9Enabled(true)
		var_110_2:setCapInsets(cc.rect(200, 200, 300, 300))
		var_110_2:setContentSize(cc.size(568, 500))
		var_106_0:addChild(var_110_2)

		local var_110_3 = var_110_2:getContentSize().width
		local var_110_4 = var_110_2:getContentSize().height
		local var_110_5 = ccui.Text:create(arg_106_1.isHaveFog and "未探索方块" or arg_106_1.name, FONT_NAME, 24)

		var_110_5:setAnchorPoint(var_110_1)
		var_110_5:setPosition(cc.p(var_110_0 - 20, 450))
		var_110_2:addChild(var_110_5)

		local var_110_6 = ccui.Button:create(arg_106_1.isHaveFog and "mainScenebg/postcard/7000002.png" or arg_106_1.itemPath, arg_106_1.isHaveFog and "mainScenebg/postcard/7000002.png" or arg_106_1.itemPath, arg_106_1.isHaveFog and "mainScenebg/postcard/7000002.png" or arg_106_1.itemPath)

		var_110_6:setPosition(cc.p(var_110_3 / 2, var_110_4 / 2))
		var_110_2:addChild(var_110_6)

		local var_110_7 = ccui.Button:create("public/button/public_button_orange_big.png", "public/button/public_button_orange_big.png", "public/button/public_button_orange_big.png", var_0_11)
		local var_110_8 = ccui.Text:create("前往", FONT_NAME, 28)

		var_110_8:setColor(cc.c3b(0, 0, 0))
		var_110_8:setPosition(cc.p(160, 55))
		var_110_7:addChild(var_110_8)
		var_110_7:setPosition(cc.p(var_110_0 - 20, -50))

		local var_110_9 = arg_106_1.roomStatus == EXPEDITION.ROOMSTATUS.CanOperate and expedition_manager:getCurLevelStatus() ~= var_0_13.Free

		var_110_7:setVisible(var_110_9)
		var_110_7:addTouchEventListener(function(arg_111_0, arg_111_1)
			if arg_111_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_110_9 and type(arg_106_1.callback) == "function" then
				arg_106_1.callback()
				var_106_0:setVisible(false)
			end
		end)
		var_110_2:addChild(var_110_7)

		local var_110_10 = ccui.Text:create(arg_106_1.isHaveFog and "尚未探索的方块，可能会有意想不到的事情。" or arg_106_1.des, FONT_DES, 24)

		var_110_10:setContentSize(cc.size(500, 100))
		var_110_10:ignoreContentAdaptWithSize(false)
		var_110_10:setPosition(cc.p(var_110_3 / 2 - 10, 30))
		var_110_2:addChild(var_110_10)
		var_110_2:setPositionY(var_110_2:getPositionY() + (GameDisplay.height + GameDisplay.fix_y - 1136) / 2)
		global_window_open_action(var_106_0)
	end

	if var_106_0:getChildByName("bgLayer") then
		var_106_0:getChildByName("bgLayer"):removeFromParent()
	end

	if var_106_0:getChildByName("sp") then
		var_106_0:getChildByName("sp"):removeFromParent()
	end

	local var_106_2 = ccui.Layout:create()

	var_106_2:setTouchEnabled(true)
	var_106_2:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_106_2:setAnchorPoint(cc.p(0, 0))
	var_106_2:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_106_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_106_2:setBackGroundColor(cc.c3b(2, 5, 24))
	var_106_2:setOpacity(0)
	var_106_2:setCascadeOpacityEnabled(false)
	var_106_2:setName("bgLayer")
	var_106_0:addChild(var_106_2, -1)

	local var_106_3 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_106_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_106_3:setPositionX(var_106_2:getContentSize().width / 2)
	var_106_3:setPositionY(var_106_2:getContentSize().height / 2)
	var_106_2:addChild(var_106_3)
	l2utils:captureScreenGaussBlur(function(arg_112_0)
		arg_112_0:setName("sp")
		var_106_0:addChild(arg_112_0, -2)
		var_106_1()
		var_106_2:setOpacity(102)
		var_106_2:setTouchEnabled(false)
	end)
end

function MonopolyLayer:scrollToIndex()
	local var_113_0 = expedition_manager:getExpeditionInfo()

	self.listViewNode:scrollToPercent((var_113_0.curLevel >= 3 or nil) and math.min(100, math.floor(100 * (var_113_0.curLevel - 1) / var_113_0.stepLength)), nil, false)
end

function MonopolyLayer.dealWithDialogEventList(arg_114_0, arg_114_1, arg_114_2)
	local var_114_0 = 1

	local function var_114_1()
		var_114_0 = var_114_0 + 1

		doTriggerEvent(arg_114_1[var_114_0])
	end

	local function var_114_2()
		expedition_manager:trigger_event_expedition(info, function()
			if arg_114_2 then
				arg_114_2()
			end
		end)
	end

	local function var_114_3(arg_118_0)
		arg_114_0:openSelectSkillPanel({
			isAni = true,
			callback = function()
				var_114_1()
			end,
			skillpoolid = tonumber(arg_118_0)
		})
	end

	local function var_114_4(arg_120_0)
		arg_114_0:openSelectStudentPanel({
			callback = function()
				var_114_1()
			end,
			updateCallback = function()
				var_114_4()
			end,
			isAni = arg_120_0 or false
		})
	end

	function doTriggerEvent(arg_123_0)
		if arg_123_0 == nil then
			var_114_2()

			return
		end

		if arg_123_0.eventtype == var_0_14.Recruit then
			var_114_4()
		elseif arg_123_0.eventtype == var_0_14.Skill then
			var_114_3(arg_123_0.eventvalue)
		else
			var_114_1()
		end
	end

	doTriggerEvent(arg_114_1[1])
end

function MonopolyLayer:checkTriggerEventByLastLevel(arg_124_1)
	if expedition_manager:isNeedAutoPlay() then
		expedition_manager:setFightEventId(nil)
		self:doOperate()

		return
	end

	if self.initconfig and self.initconfig.isNeedCheckEvent == true then
		local var_124_0 = expedition_manager:getFightEventId()

		if var_124_0 == nil then
			return
		end

		self:onBtnLevelCallback(var_124_0.levelindex, var_124_0.roomindex, true)
	else
		expedition_manager:setFightEventId(nil)
	end
end

function MonopolyLayer:usualSchedulerWithCallback(arg_125_1, arg_125_2)
	arg_125_2 = arg_125_2 or 1

	if self.usualScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.usualScheduler)
	end

	self.usualScheduler = self.scheduler:scheduleScriptFunc(function()
		if type(arg_125_1) == "function" then
			arg_125_1()
		end

		if self.usualScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.usualScheduler)
		end
	end, arg_125_2, false)
end

function MonopolyLayer.update(arg_127_0, arg_127_1)
	return
end
