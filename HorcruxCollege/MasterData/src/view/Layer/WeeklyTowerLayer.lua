local WeeklyTowerLayer = class("WeeklyTowerLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")

local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local array_manager = require("controller.array_manager")
local audio_manager = require("controller.audio_manager")
local model_data = require("data.model_data")
local chapter_data = require("data.chapter_data")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local var_0_9 = require("controller.weekly_tower_manager").getInstance()
local var_0_10 = config._DEBUG and 0 or 1
local var_0_11 = 640
local var_0_13 = 640
local var_0_14 = 185
local var_0_15 = {
	NORMAL = {
		"adventurenewtowerlayer/tou_1.png",
		"adventurenewtowerlayer/tou_2.png"
	},
	BOSS = {
		"adventurenewtowerlayer/bigboss_tou3.png",
		"adventurenewtowerlayer/bigboss_tou4.png"
	}
}
local var_0_16
local var_0_17
local var_0_18 = "weeklytower/"
local var_0_19 = {
	{
		off = "btn_easy_off.png",
		on = "btn_easy_on.png"
	},
	{
		off = "btn_hard_off.png",
		on = "btn_hard_on.png"
	},
	{
		off = "btn_hell_off.png",
		on = "btn_hell_on.png"
	}
}

function WeeklyTowerLayer:create(...)
	local var_2_0 = WeeklyTowerLayer.new(...)

	var_2_0:init(...)

	return var_2_0
end

function WeeklyTowerLayer:init(...)
	self:initData(...)
	self:initUI()
	self:registerEvents()
end

function WeeklyTowerLayer:initData(arg_4_1)
	if arg_4_1 then
		self.returnLayer = arg_4_1.returnLayer or "WeeklyTowerEntranceLayer"
	end

	self.btnSwitchs = {}

	if arg_4_1 then
		self.originMode = arg_4_1.originMode or var_0_16
	end

	self.location = 0
	var_0_16 = self.originMode

	if arg_4_1 then
		self.index = arg_4_1.index or var_0_17 or 1
	end

	self.curMode = self.originMode

	if arg_4_1 then
		self.curModeType = arg_4_1.modeType or 21
	end

	self.levels = Utility:reverse(var_0_9:queryLevelsByMode(self.curMode))
	self.curPanelInfo = nil
end

function WeeklyTowerLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "WeeklyTowerLayer.json" or "WeeklyTowerLayer.ExportJson")

	self:addChild(self.rootNode)

	self.rootPanel = self.rootNode:getChildByName("panelRoot")
	self.panelMain = self.rootPanel:getChildByName("panelMain")
	self.listView = self.panelMain:getChildByName("listView")

	self.listView:setTouchEnabled(false)

	self.imgTitle = self.panelMain:getChildByName("imgTitle")

	self.imgTitle:setTouchEnabled(true)
	self.imgTitle:setLocalZOrder(2)

	self.listViewBtns = self.imgTitle:getChildByName("listViewBtns")
	self.panelInfo = self.panelMain:getChildByName("panelInfo")

	self.panelInfo:retain()
	self.panelInfo:removeFromParent()

	self.panelItem = self.panelMain:getChildByName("panelItem")

	self.panelItem:retain()
	self.panelItem:removeFromParent()
	self:initBottomBtn()
	self:initListViewBtns()
	self:fullScreen()
	self:onBtnSwitch(self.btnSwitchs[self.index])
end

function WeeklyTowerLayer:initListViewBtns()
	self.btnSwitchs = {}

	self.listViewBtns:removeAllChildren()

	local var_6_0 = var_0_9:getCityDifficulties(self.originMode)

	for iter_6_0, iter_6_1 in ipairs(var_0_19) do
		local var_6_1 = ccui.Button:create(var_0_18 .. iter_6_1.off, var_0_18 .. iter_6_1.off, var_0_18 .. iter_6_1.on, var_0_10)

		Utility:addClickEventListener(var_6_1, handler(self, self.onBtnSwitch))
		self.listViewBtns:pushBackCustomItem(var_6_1)

		self.btnSwitchs[#self.btnSwitchs + 1] = var_6_1

		var_6_1:setVisible(#var_6_0 > 1 and var_6_0[iter_6_0] and true or false)
	end
end

function WeeklyTowerLayer:onBtnSwitch(arg_7_1)
	local var_7_0 = Utility:indexOf(self.btnSwitchs, arg_7_1)

	if var_7_0 < 0 then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(self.btnSwitchs) do
		iter_7_1:setTouchEnabled(iter_7_1 ~= arg_7_1)
		iter_7_1:setBright(iter_7_1 ~= arg_7_1)
	end

	self.index = var_7_0
	var_0_17 = var_7_0
	self.curMode = self.originMode + var_7_0 - 1
	self.levels = Utility:reverse(var_0_9:queryLevelsByMode(self.curMode))

	self:updateTableView()
end

function WeeklyTowerLayer:initBottomBtn()
	require("view.Sprite.BottomBtnList")

	self.bottomBtnList = BottomBtnList:create(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.returnLayer then
			LayerManager:switchReturnLayer(self.returnLayer)
		else
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end)

	self:addChild(self.bottomBtnList, 10)

	self.btnSkill = ccui.Button:create("weeklytower/btn_skill.png", nil, "weeklytower/btn_skill.png", var_0_10)

	self.bottomBtnList:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 0, TRANSFORM_UNIT.PX))
	self.bottomBtnList:addChild(self.btnSkill)
	self.btnSkill:setPosition(586, 48)
	self.btnSkill:setVisible(false)
	Utility:addClickEventListener(self.btnSkill, handler(self, self.onBtnSkill))

	self.autoFight = RoleDefault:getInstance():getBoolForKey("WeeklyAutoFight", false)

	local var_8_0 = ccui.ImageView:create("adventurenewtowerlayer/auto_fight_bg.png", var_0_10)

	var_8_0:setPosition(cc.p(560, 28))
	self.bottomBtnList:addChild(var_8_0)

	local var_8_1 = ccui.ImageView:create("adventurenewtowerlayer/auto_fight_choose.png", var_0_10)

	var_8_1:setPosition(cc.p(103, 16))
	var_8_0:addChild(var_8_1)

	local var_8_2 = ccui.ImageView:create("adventurenewtowerlayer/auto_fight_on.png", var_0_10)

	var_8_2:setPosition(cc.p(15, 15))
	var_8_1:addChild(var_8_2)
	var_8_2:setVisible(self.autoFight)
	var_8_0:setTouchEnabled(true)
	var_8_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.autoFight = not self.autoFight

		var_8_2:setVisible(self.autoFight)
		RoleDefault:getInstance():setBoolForKey("WeeklyAutoFight", self.autoFight)
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("set_weekly_autofight_false", function(arg_11_0)
		self.autoFight = false

		var_8_2:setVisible(self.autoFight)
	end), self)
end

function WeeklyTowerLayer:onBtnSkill(arg_12_1)
	LayerManager:pushInLayer("PopTowerSkillSelectLayer", {
		panelType = 2,
		skills = var_0_9:queryModeSkill(self.curMode)
	})
end

function WeeklyTowerLayer:fullScreen()
	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self.imgTitle:setPositionType(0)
	self.imgTitle:setPositionY(self.imgTitle:getPositionY() - GameDisplay.statusbar_height)
end

function WeeklyTowerLayer:registerEvents()
	Utility:registerNodeEvent(self)
	self.panelMain:addTouchEventListener(handler(self, self.onPanelMain))
end

function WeeklyTowerLayer:initTableView()
	self.tableView = cc.TableView:create(cc.size(var_0_11, self.listView:getContentSize().height + GameDisplay.height - GameDisplay.origin_design_y - 20))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setDelegate()
	self.tableView:setPositionY(self.listView:getPositionY() + 20)
	self.panelMain:addChild(self.tableView)
	self.tableView:registerScriptHandler(handler(self, self.numberOfCells), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:registerScriptHandler(handler(self, self.cellSizeForIndex), cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(handler(self, self.updateCellAtIndex), cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:setLocalZOrder(0)
	self.tableView:setSwallowsTouches(false)
end

function WeeklyTowerLayer:updateTableView()
	if not self.tableView then
		self:initTableView()
	end

	if self.curPanelInfo then
		self.curPanelInfo:removeFromParent()
	end

	self.tableView:reloadData()

	for iter_16_0, iter_16_1 in ipairs(self.levels) do
		if iter_16_1.index == playermodel.levelmode[self.curMode].status then
			self.location = iter_16_0 - 1

			break
		end
	end

	self.tableView:scrollToIndex(self.location, false)

	self.curPanelInfo = nil
end

function WeeklyTowerLayer:numberOfCells(arg_17_1)
	return #self.levels
end

function WeeklyTowerLayer:cellSizeForIndex(arg_18_1, arg_18_2)
	return var_0_13, var_0_14
end

function WeeklyTowerLayer:updateCellAtIndex(arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1:dequeueCell()
	local var_19_1 = true

	if not var_19_0 then
		var_19_0 = cc.TableViewCell:create()
		var_19_1 = false
	end

	if var_19_1 then
		self:updateOneItem(var_19_0, arg_19_2)
	else
		self:createOneItem(var_19_0, arg_19_2)
	end

	return var_19_0
end

function WeeklyTowerLayer:createOneItem(arg_20_1, arg_20_2)
	local var_20_0 = self.panelItem:clone()

	var_20_0:setName("panelItem")
	var_20_0:setPositionY(10)
	var_20_0:setSwallowsTouches(false)
	arg_20_1:addChild(var_20_0)
	self:updateOneItem(arg_20_1, arg_20_2)

	if arg_20_2 < math.floor(self.tableView:getContentSize().height / var_0_14) then
		var_20_0:setOpacity(0)
		var_20_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_20_2 * 0.05), cc.FadeIn:create(0.1)))
	end
end

function WeeklyTowerLayer:updateOneItem(arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1:getChildByName("panelItem")
	local var_21_1 = var_21_0:getChildByName("imgBorder")
	local var_21_2 = var_21_0:getChildByName("btnChallenge")

	var_21_0:setOpacity(255)

	local var_21_3 = self.levels[arg_21_2 + 1]

	if not self.levels[arg_21_2 + 1] then
		return
	end

	local var_21_4

	if playermodel.levelmode[self.curMode] then
		var_21_4 = playermodel.levelmode[self.curMode].status or 1

		if var_21_4 > var_21_3.index then
			var_21_1:loadTexture("adventurenewtowerlayer/changdi_3.png", var_0_10)
		elseif var_21_3.index == var_21_4 then
			var_21_1:loadTexture("adventurenewtowerlayer/changdi_1.png", var_0_10)

			if var_21_3.isBigBoss then
				var_21_1:loadTexture("adventurenewtowerlayer/bigboss_di.png", var_0_10)
			end
		end
	end

	var_21_1:loadTexture("adventurenewtowerlayer/changdi_2.png", var_0_10)

	if var_21_3.isBigBoss then
		var_21_1:loadTexture("adventurenewtowerlayer/bigboss_di1.png", var_0_10)
	end

	var_21_2:setVisible(var_21_4 == var_21_3.index)
	self:updateBossImg(var_21_0, var_21_3)
	self:updateRewards(var_21_0, var_21_3)
	self:updateBossSkills(var_21_0, var_21_3)

	for iter_21_0 = 1, 2 do
		local var_21_5 = var_21_0:getChildByName("imgAni_" .. iter_21_0)

		var_21_5:loadTexture(((var_21_3.isBigBoss or nil) and (var_0_15.BOSS or var_0_15.NORMAL))[iter_21_0], var_0_10)

		if var_21_3.index == var_21_4 then
			var_21_5:runAction(cc.RepeatForever:create(cc.RotateBy:create(6, iter_21_0 == 1 and -360 or 360)))
		else
			var_21_5:stopAllActions()
			var_21_5:setRotation(0)
		end
	end

	Utility:addClickEventListener(var_21_2, handler(self, self.onBtnChallenge), var_21_3)
end

function WeeklyTowerLayer:updateBossImg(arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1:getChildByName("imgFace")
	local var_22_1 = arg_22_1:getChildByName("labelLevel")

	var_22_0:setSwallowsTouches(false)
	var_22_0:loadTexture("role1/" .. model_data[arg_22_2.bossModel].cute_role .. ".png")
	var_22_0:setScale(0.35)
	var_22_0:setPositionY(120)
	Utility:addClickEventListener(var_22_0, handler(self, self.onImgFace), arg_22_2)
	arg_22_1:getChildByName("imgNameBg"):getChildByName("labelName"):setString(model_data[arg_22_2.bossModel].name)
	var_22_1:setString(string.format("第%d层", arg_22_2.index))
	var_22_1:setPositionY(158)
end

function WeeklyTowerLayer:onImgFace(arg_23_1, arg_23_2)
	local var_23_0 = {
		fight_type = "ADVENTURE",
		level = 1,
		mode = self.curMode,
		chapter = arg_23_2.index,
		callback = callback
	}

	var_23_0.initindex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)

	LayerManager:pushInLayer("LevelDetailLayer", var_23_0)
end

function WeeklyTowerLayer:calculateRewards(arg_24_1)
	if playermodel.levelmode[self.curMode].status > arg_24_1.index then
		return arg_24_1.drops
	end

	local var_24_0 = {}
	local var_24_1 = var_0_9:convertMode(self.curMode)

	for iter_24_0 = 1, self.index do
		if playermodel.levelmode[var_24_1 - 1 + iter_24_0].status <= arg_24_1.index then
			for iter_24_1, iter_24_2 in ipairs(var_0_9:queryLevelDatas(var_24_1 - 1 + iter_24_0, arg_24_1.index).drops) do
				local var_24_2 = Utility:indexOf(var_24_0, function(arg_25_0)
					return arg_25_0.itemid == iter_24_2.itemid
				end)

				if var_24_2 < 0 then
					var_24_0[#var_24_0 + 1] = {
						itemid = iter_24_2.itemid,
						num = iter_24_2.num
					}
				else
					var_24_0[var_24_2].num = var_24_0[var_24_2].num + iter_24_2.num
				end
			end
		end
	end

	return var_24_0
end

function WeeklyTowerLayer:updateRewards(arg_26_1, arg_26_2)
	local var_26_0 = arg_26_1:getChildByName("listRewards")

	var_26_0:removeAllChildren()
	var_26_0:setTouchEnabled(false)

	for iter_26_0, iter_26_1 in ipairs(self:calculateRewards(arg_26_2)) do
		local var_26_1 = ItemSpriteActivityRecharge:createSignItem(iter_26_1.itemid, iter_26_1.num)

		var_26_1:addClickEventListener(function()
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = iter_26_1.itemid
			})
		end)
		var_26_1:setSwallowsTouches(false)
		var_26_0:pushBackCustomItem(var_26_1)

		if playermodel.levelmode[self.curMode].status > arg_26_2.index then
			local var_26_2 = ccui.ImageView:create("adventurenewtowerlayer/getawrad.png", var_0_10)

			var_26_2:setPosition(cc.p(var_26_1:getContentSize().width / 2, var_26_1:getContentSize().height / 2))
			var_26_2:setTouchEnabled(false)
			var_26_2:setScale9Enabled(true)
			var_26_2:setCapInsets(cc.rect(0, 0, 40, 40))
			var_26_2:setContentSize(var_26_1:getContentSize())
			var_26_2:setLocalZOrder(99)
			var_26_1:addChild(var_26_2)
		end
	end
end

function WeeklyTowerLayer:updateBossSkills(arg_28_1, arg_28_2)
	local var_28_0 = arg_28_1:getChildByName("imgDetail")
	local var_28_1 = arg_28_1:getChildByName("listViewSkills")

	var_28_1:setTouchEnabled(false)
	var_28_1:setClippingEnabled(false)
	var_28_1:setLocalZOrder(2)

	local var_28_2 = arg_28_2.isBigBoss and 3 or arg_28_2.index == playermodel.levelmode[self.curMode].status and 1 or 2

	var_28_1:removeAllChildren()

	for iter_28_0, iter_28_1 in ipairs(arg_28_2.bossSkills) do
		local var_28_3 = ccui.Layout:create()

		var_28_3:setContentSize(cc.size(54, 54))

		local var_28_4 = ccui.ImageView:create(string.format("adventurenewtowerlayer/frame%d.png", var_28_2), var_0_10)

		var_28_4:setPosition(27, 27)
		var_28_3:addChild(var_28_4)

		local var_28_5 = ccui.ImageView:create(string.format("skill_new/skill/%s.png", iter_28_1.icon), var_0_10)

		var_28_3:addChild(var_28_5)
		var_28_5:setPosition(var_28_4:getContentSize().width / 2, var_28_4:getContentSize().height / 2)

		local var_28_6 = var_28_5:getContentSize()

		var_28_5:setScale(math.min(37 / var_28_6.width, 37 / var_28_6.height))

		local var_28_7 = ccui.Text:create(iter_28_1.name, "fonts/name.ttf", 20)

		var_28_7:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_LEFT)
		var_28_7:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_28_7:setAnchorPoint(0, 0.5)
		var_28_4:addChild(var_28_7)
		var_28_7:setPosition(var_28_4:getContentSize().width + 2, var_28_4:getContentSize().height / 2)
		Utility:addClickEventListener(var_28_3, handler(self, self.onPanelSkill), iter_28_1, arg_28_1)
		var_28_3:setContentSize(cc.size(54 + var_28_7:getContentSize().width, 54))
		var_28_3:setLocalZOrder(#arg_28_2.bossSkills - iter_28_0)
		var_28_1:pushBackCustomItem(var_28_3)
	end
end

function WeeklyTowerLayer:onPanelSkill(arg_29_1, arg_29_2, arg_29_3)
	self.curPanelInfo = self.curPanelInfo or self.panelInfo:clone()

	self.curPanelInfo:retain()
	self.curPanelInfo:removeFromParent()
	self.curPanelInfo:setAnchorPoint(0, 1)
	self.curPanelInfo:getChildByName("labelName"):setString(arg_29_2.name)
	self.curPanelInfo:getChildByName("labelInfo"):setString(arg_29_2.des)
	self.curPanelInfo:setScale(0)
	self.curPanelInfo:stopAllActions()
	arg_29_3:addChild(self.curPanelInfo)
	self.curPanelInfo:setLocalZOrder(99)
	self.curPanelInfo:setVisible(true)
	self.curPanelInfo:setPosition(arg_29_3:convertToNodeSpace(arg_29_1:convertToWorldSpace(cc.p(54, 54))))
	self.curPanelInfo:release()
	self.curPanelInfo:runAction(cc.Spawn:create(cc.ScaleTo:create(0.2, 1), cc.FadeIn:create(0.2)))
end

function WeeklyTowerLayer:onPanelMain(arg_30_1)
	if not self.curPanelInfo then
		return
	end

	self.curPanelInfo:setVisible(false)
end

function WeeklyTowerLayer:onBtnChallenge(arg_31_1, arg_31_2)
	if var_0_9:canSelectSkill(self.curMode, arg_31_2.index) then
		LayerManager:pushInLayer("PopTowerSkillSelectLayer", {
			panelType = 1,
			cancelCallBack = function()
				self:executeChallenge(arg_31_2)
			end,
			skills = var_0_9:qeueryLevelSkill(self.curMode, arg_31_2.index),
			mode = self.curMode,
			chapter = arg_31_2.index
		})
	else
		self:executeChallenge(arg_31_2)
	end
end

function WeeklyTowerLayer:executeChallenge(arg_33_1)
	local var_33_0 = self.curMode
	local var_33_1 = arg_33_1.index
	local var_33_2, var_33_3 = level_manager:isModeValid(self.curMode)

	if not var_33_2 then
		audio_manager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(level_manager:getModeUnlockMsg(self.curMode, var_33_3))

		return
	end

	local function var_33_4(arg_34_0)
		if arg_34_0 == 1 then
			AnalyticManager.click_bosstower()
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			FightManager.refreshFightToType(FIGHTTYPE_ADVENTURE_TOWER)
		else
			if arg_34_0 == 2 then
				global_ShowBlockWords(L_ADVENTURE_WARNING[2])
			elseif arg_34_0 == 3 then
				global_ShowBlockWords(L_ADVENTURE_WARNING[3])
			elseif arg_34_0 == 4 then
				global_ShowBlockWords(L_ADVENTURE_WARNING[4])
			elseif arg_34_0 == 5 then
				global_ShowBlockWords(L_ADVENTURE_WARNING[5])
			elseif arg_34_0 == 6 then
				if chapter_data["" .. var_33_0 .. "-" .. var_33_1] and chapter_data["" .. var_33_0 .. "-" .. var_33_1].boss_combat then
					global_ShowBlockWords(L_ADVENTURE_WARNING[6] .. chapter_data["" .. var_33_0 .. "-" .. var_33_1].boss_combat .. L_ADVENTURE_WARNING[7])
				end
			end

			audio_manager:playeffectMusicTest("sound/invalid")
			GuideListener.showAllGuidesWithFullScreen(true)
		end
	end

	local function var_33_5(arg_35_0)
		GuideListener.showAllGuidesWithFullScreen(false)
		array_manager:resetHangupArray(arg_35_0)
		RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", self.curModeType)
		level_manager:switchToAdventureMode(var_33_0, var_33_1, var_33_4, arg_35_0)
		var_0_9:setFightFlag(true)
		var_0_9:setModeChapter(self.curMode, arg_33_1.index)
	end

	;(function()
		require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationElementsLayer", {
			mode = var_33_0,
			defaultIndex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1),
			configcallback = var_33_5
		})
	end)()
end

function WeeklyTowerLayer:checkAutoFight(arg_37_1)
	local var_37_0 = RoleDefault:getInstance():getBoolForKey("WeeklyAutoFight", false)

	if var_37_0 then
		global_count_down_layer(4, function()
			self:executeChallenge(arg_37_1)
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("set_weekly_autofight_false")))
			RoleDefault:getInstance():setBoolForKey("WeeklyAutoFight", false)
		end)
	end

	return var_37_0
end

function WeeklyTowerLayer:onEnter()
	return
end

function WeeklyTowerLayer:onExit()
	self.panelItem:release()
	self.panelInfo:release()
	EventManager:unsubscribe(self)
end

return WeeklyTowerLayer
