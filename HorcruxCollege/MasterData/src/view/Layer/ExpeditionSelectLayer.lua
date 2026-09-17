ExpeditionSelectLayer = class("ExpeditionSelectLayer", function()
	return cc.Layer:create()
end)

local level_manager = require("controller.level_manager")
local expedition_manager = require("controller.expedition_manager")
local core_manager = require("controller.core_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local playermodel = require("model.playermodel")
local BarSprite = require("view.Sprite.BarSprite")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local chapter_data = require("data.chapter_data")
local bigWar_base_data = require("data.bigWar_base_data")
local spinecache_manager = require("controller.spinecache_manager")
local TowerBaseBarSprite = require("view.Sprite.TowerBaseBarSprite")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_13 = 185
local var_0_14 = GameDisplay.height * (ORIGIN_FIGHT_HEIGHT + 185) / GameDisplay.origin_design_y - GameDisplay.fix_y
local var_0_15 = 640
local var_0_16 = 800
local var_0_17 = -420
local var_0_18 = -(GameDisplay.height * (ORIGIN_FIGHT_HEIGHT + 185) / GameDisplay.origin_design_y - GameDisplay.fix_y) - GameDisplay.fix_y
local var_0_19 = 110
local var_0_21 = 600
local var_0_22 = 230
local var_0_23 = 0.24
local var_0_24 = 5
local var_0_25 = {
	{
		x = 4,
		y = 4
	},
	{
		x = 28,
		y = 100
	},
	{
		x = 124,
		y = 100
	},
	{
		x = 100,
		y = 4
	}
}
local var_0_27 = config._DEBUG and 0 or 1

function ExpeditionSelectLayer:createLoadIngAni(arg_2_1)
	local var_2_0 = ccui.Layout:create()

	var_2_0:setContentSize(cc.size(640, GameDisplay.height))
	var_2_0:setTouchEnabled(true)
	var_2_0:setPositionY(var_0_18)
	self:addChild(var_2_0, 999)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("effect/fight_loading.ExportJson")

	local var_2_1 = ccs.Armature:create("fight_loading")

	var_2_1:setPosition(320, GameDisplay.height / 2)
	var_2_0:addChild(var_2_1)
	var_2_1:getAnimation():play("Animation1")
	var_2_1:getAnimation():setFrameEventCallFunc(function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		if arg_3_1 == "end" then
			if arg_2_1 then
				arg_2_1()
			end

			var_2_0:runAction(cc.RemoveSelf:create())
		end
	end)
end

function ExpeditionSelectLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = ExpeditionSelectLayer.new()

	var_4_0:setPosition(cc.p(0, var_0_14))
	var_4_0:initBg(arg_4_1)
	TextureManager:removeUnusedSpineTextures()
	var_4_0:init(arg_4_1)

	return var_4_0
end

function ExpeditionSelectLayer:init(arg_5_1)
	self.mode = arg_5_1.mode
	self.chapter = arg_5_1.chapter
	self.level = arg_5_1.level
	self.sureCallback = arg_5_1.sureCallback
	self.roomType = arg_5_1.roomType
	self.seasontype = arg_5_1.seasontype

	if self.seasontype == EXPEDITION.SEASONTYPE.Monopoly then
		expedition_manager:switchExpeditionToLimiteTimeMode(self.roomType)
	else
		expedition_manager:switchExpeditionTower(self.roomType)
	end

	self:initData()
	self:initUI()
	self:batchCreatePlayer()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" and self.skeletonDataList then
			for iter_6_0, iter_6_1 in pairs(self.skeletonDataList) do
				iter_6_1:release()
			end
		end
	end)
end

function ExpeditionSelectLayer:initData()
	(function()
		var_0_24 = (self.roomType == ExpeditionRoomType.TowerDefenceNormal or self.roomType == ExpeditionRoomType.TowerDefenceElite or self.roomType == ExpeditionRoomType.TowerDefenceBoss) and (chapter_data[self.mode .. "-" .. self.chapter].select_max_role or 5) or math.min(chapter_data[self.mode .. "-" .. self.chapter].select_max_role or 5, 5)
		self.selectedList = {}
		self.skeletonList = {}
		self.skeletonDataList = {}
		self.spinePosIdx = {}

		for iter_8_0 in RoleDefault:getInstance():getStringForKey("Expedition" .. expedition_manager.expeditionInfo.inittype, ""):gmatch("([^,]+)") do
			local var_8_1 = tonumber(iter_8_0)

			if expedition_manager:isServantCanSelect(var_8_1) then
				self.selectedList[var_8_1] = true
				self.isNeedBatchCreatePlayer = true
			end
		end
	end)()
	;(function()
		local var_9_0 = cloneconf(expedition_manager:getCurLevelInfo().baseConfig)

		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			local var_9_1 = iter_9_1[1]
			local var_9_2 = model_data[iter_9_1[1].majorlist.modelid]
			local var_9_3 = global_get_model_attr(iter_9_1[1].majorlist.modelid)

			if var_9_3 then
				var_9_1.careericon = model_data[iter_9_1[1].majorlist.modelid].career .. "_" .. var_9_3 or "class_" .. model_data[iter_9_1[1].majorlist.modelid].career .. "_black"
			end

			var_9_1.headimg = var_9_2.head_image
			var_9_1.lv = var_9_1.majorlist.level
			var_9_1.name = var_9_2.name
			var_9_1.charactertype = var_9_1.charactertype
			var_9_1.hpcount = var_9_1.majorlist.hpcount or 1
			var_9_1.singlehp = var_9_1.majorlist.hp
		end

		self.headConf = var_9_0
	end)()
	;(function()
		self.allRoleDatas = {}

		for iter_10_0, iter_10_1 in pairs((expedition_manager:getExpeditionTeamListInfo())) do
			table.insert(self.allRoleDatas, iter_10_1.servantid)
		end
	end)()
	;(function()
		self.attrList = {}
		self.special_attrs = {}

		local var_11_0 = {
			wind = 8,
			water = 6,
			fire = 7,
			devil = 2,
			light = 5,
			dark = 4,
			imaginary = 3
		}

		for iter_11_0, iter_11_1 in pairs(ATTR_ID) do
			if var_11_0[iter_11_1] then
				table.insert(self.attrList, iter_11_1)
			else
				self.special_attrs[iter_11_1] = true
			end
		end

		table.sort(self.attrList, function(arg_12_0, arg_12_1)
			return (var_11_0[arg_12_1] or 0) < (var_11_0[arg_12_0] or 0)
		end)
		table.insert(self.attrList, 1, "all")
		table.insert(self.attrList, "special")

		self.curSelectType = "all"
	end)()
	;(function()
		self.enemyList, self.enemyBossList = expedition_manager:getAllLevelEnemys(self.mode, self.level)

		table.sort(self.enemyList, function(arg_14_0, arg_14_1)
			return model_data[arg_14_0].modelweight < model_data[arg_14_1].modelweight
		end)
	end)()
	self:updateRoleListData()
end

function ExpeditionSelectLayer:updateRoleListData()
	self.curRoleList = {}

	for iter_15_0, iter_15_1 in pairs(self.allRoleDatas) do
		local var_15_0 = global_get_model_attr((global_get_servant_skin(iter_15_1, -1)))

		if self.curSelectType == "all" or self.curSelectType == var_15_0 or self.curSelectType == "special" and self.special_attrs[var_15_0] then
			table.insert(self.curRoleList, iter_15_1)
		end
	end

	if next(self.curRoleList) ~= nil then
		self.curRoleList = expedition_manager:sortRoleListTbl(self.curRoleList)
	end

	if not next(self.selectedList) then
		for iter_15_2, iter_15_3 in pairs(self.curRoleList) do
			if table.nums(self.selectedList) < var_0_24 then
				if expedition_manager:isServantCanSelect(iter_15_3) then
					self.selectedList[iter_15_3] = true
					self.isNeedBatchCreatePlayer = true
				end
			else
				break
			end
		end
	end
end

function ExpeditionSelectLayer:initBg(arg_16_1)
	self.bgPanel = ccui.Layout:create()

	self.bgPanel:setAnchorPoint(cc.p(0, 0))
	self.bgPanel:setPosition(cc.p(0, 5))
	self.bgPanel:setContentSize(cc.size(var_0_15, var_0_16))
	self:addChild(self.bgPanel)

	self.map = ccui.Layout:create()

	self.map:setContentSize(cc.size(var_0_15, var_0_16))
	self.map:setAnchorPoint(cc.p(0.5, 0))
	self.map:setPosition(cc.p(var_0_15 / 2, 0))
	self.bgPanel:addChild(self.map)

	local var_16_0 = ccui.ImageView:create("TowerDefenceListPanel/select_mark_bg.png", var_0_27)

	var_16_0:setAnchorPoint(cc.p(0.5, 0))
	var_16_0:setPosition(320, var_0_18)
	self:addChild(var_16_0)

	self.background = {}

	local var_16_1 = level_manager.getCurLevelData(arg_16_1.mode, arg_16_1.chapter .. "-1")

	for iter_16_0 = 1, 3 do
		self.background[iter_16_0] = cc.Sprite:create(FIGHT_BG_PATH .. var_16_1["sceneConfigure" .. iter_16_0] .. ".png")

		self.background[iter_16_0]:setAnchorPoint(cc.p(0, 0))
		self.background[iter_16_0]:setPosition(cc.p(-100, var_0_17))
		self.map:addChild(self.background[iter_16_0], -iter_16_0)
	end
end

function ExpeditionSelectLayer:initUI()
	if self.roomType == ExpeditionRoomType.TowerDefenceNormal or self.roomType == ExpeditionRoomType.TowerDefenceElite or self.roomType == ExpeditionRoomType.TowerDefenceBoss then
		self:initHead()
	end

	self:initBaseUI()
	self:initBattleFieldStatusInfoPanel()
	self:initList()
	self:initBottom()
	self:initEnemySpine()
end

function ExpeditionSelectLayer:initHead()
	local var_18_0 = cc.Node:create()
	local var_18_1 = GameDisplay.height - (GameDisplay.height * (ORIGIN_FIGHT_HEIGHT + var_0_13) / GameDisplay.origin_design_y - GameDisplay.fix_y) - GameDisplay.fix_y - 80

	var_18_0:setPosition(cc.p(0, GameDisplay.height - (GameDisplay.height * (ORIGIN_FIGHT_HEIGHT + var_0_13) / GameDisplay.origin_design_y - GameDisplay.fix_y) - GameDisplay.fix_y - 80 + 300))
	self.bgPanel:addChild(var_18_0)

	local var_18_2

	if config._DEBUG then
		var_18_2 = cc.Sprite:create("FightLayer/boss_blood_frame.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/boss_blood_frame.png")
	end

	var_18_2:setAnchorPoint(cc.p(0.5, 1))
	var_18_2:setPosition(320, 80)
	var_18_0:addChild(var_18_2, -1)

	for iter_18_0, iter_18_1 in pairs(self.headConf) do
		local var_18_3 = iter_18_1[1]
		local var_18_4 = TowerBaseBarSprite:createHpBar(iter_18_1[1].singlehp, iter_18_1[1].singlehp, iter_18_1[1].hpcount, 1, iter_18_1[1])

		var_18_4:setName("hpbar")
		var_18_4:setPositionX(var_18_3.charactertype == "player" and 0 or 640)
		var_18_0:addChild(var_18_4, 1)
	end

	var_18_0:runAction(cc.EaseExponentialIn:create(cc.MoveTo:create(0.4, cc.p(0, var_18_1))))
end

function ExpeditionSelectLayer:initBaseUI()
	self.listBg = ccui.ImageView:create("TowerDefenceListPanel/panelbg.png", var_0_27)

	self.listBg:setAnchorPoint(cc.p(0.5, 0))
	self.listBg:setPosition(320, var_0_18 + 10 - 450)
	self.listBg:setName("listBg")
	self:addChild(self.listBg)
	self.listBg:runAction(cc.EaseExponentialIn:create(cc.MoveTo:create(0.4, cc.p(320, var_0_18 + 10))))

	local var_19_0 = ccui.ImageView:create("TowerDefenceListPanel/arrow.png", var_0_27)

	var_19_0:setScaleX(-1)
	var_19_0:setAnchorPoint(cc.p(1, 0.5))
	var_19_0:setPosition(-4, 166)
	self.listBg:addChild(var_19_0)

	local var_19_1 = ccui.ImageView:create("TowerDefenceListPanel/arrow.png", var_0_27)

	var_19_1:setAnchorPoint(cc.p(1, 0.5))
	var_19_1:setPosition(644, 166)
	self.listBg:addChild(var_19_1)

	self.limitLabel = cc.Label:createWithTTF("可上阵:5/5", FONT_NAME, 24)

	self.limitLabel:setPosition(555, 310)
	self.limitLabel:setRotation(-2)
	self.listBg:addChild(self.limitLabel)
	self:updatelimitLabel()

	local var_19_2 = cc.Label:createWithTTF(L_TOWER_DEFENCE_SELECT_DES, FONT_W5, 24)

	var_19_2:setAnchorPoint(0.5, 0.5)
	var_19_2:setPosition(320, 310 - 10)
	self.listBg:addChild(var_19_2)

	local var_19_3 = cc.Label:createWithTTF("00:00", FONT_NAME, 24)

	var_19_3:setPosition(60, 310)
	var_19_3:setRotation(2)
	self.listBg:addChild(var_19_3)

	self.debutEffect = L2Skeleton:create("spine/tower_defence/chuchang.json", "spine/tower_defence/chuchang.atlas", nil, true)

	self.debutEffect:refreshSkeleton()
	self.debutEffect:setVisible(false)
	self.map:addChild(self.debutEffect, 99)

	self.sureBtn = ccui.Button:create("TowerDefenceListPanel/select_sure_btn.png", nil, "TowerDefenceListPanel/select_sure_btn.png", var_0_27)

	self.sureBtn:setAnchorPoint(cc.p(1, 0))
	self.sureBtn:setPosition(640, 350)
	self.sureBtn:setName("sureSelectBtn")
	self.listBg:addChild(self.sureBtn)

	local var_19_4 = TempWidget:CreateTempBtn("TowerDefenceListPanel/back_btn.png")

	var_19_4:align(cc.p(1, 0), self.sureBtn:getPositionX(), self.sureBtn:getPositionY() + self.sureBtn:getContentSize().height + 20)
	var_19_4:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.listBg:addChild(var_19_4)
	self.sureBtn:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:sureEventFunc()
	end)
end

function ExpeditionSelectLayer:updatelimitLabel()
	local var_22_0 = table.nums(self.selectedList)

	self.limitLabel:setString(TOWER_ROLE_LIMIT .. var_22_0 .. "/" .. var_0_24)
	self.limitLabel:setColor(var_22_0 < var_0_24 and cc.c3b(255, 85, 85) or cc.c3b(255, 255, 255))
end

function ExpeditionSelectLayer:initBattleFieldStatusInfoPanel()
	local var_23_0 = "FightLayer/battlefield_status_bg.png"

	self.battlefieldStatusInfo = cc.Node:create()

	self.battlefieldStatusInfo:setPosition(cc.p(0, 360))

	self.battlefieldStatusInfo.curchapter = self.mode .. "-" .. self.chapter

	self.listBg:addChild(self.battlefieldStatusInfo, 99)

	local function var_23_1(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
		local var_24_0 = arg_24_0:getChildByName("bg")

		var_24_0:stopAllActions()

		arg_24_1 = arg_24_1 or 0
		arg_24_2 = arg_24_2 or 999

		local var_24_1 = var_24_0:getChildren()

		for iter_24_0 = 1, #var_24_1 do
			var_24_1[iter_24_0]:setVisible(true)
		end

		var_24_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_24_1), cc.MoveTo:create(0.1, cc.p(0, var_24_0:getPositionY())), cc.DelayTime:create(arg_24_2), cc.MoveTo:create(0.1, cc.p(-var_24_0:getContentSize().width + 40, 0)), cc.CallFunc:create(function()
			arg_24_3:setRotation(180)

			local var_25_0 = var_24_0:getChildren()

			for iter_25_0 = 1, #var_25_0 do
				if var_25_0[iter_25_0]:getName() ~= "bntShowInfo" then
					var_25_0[iter_25_0]:setVisible(false)
				end
			end
		end)))
	end

	local function var_23_2(arg_26_0, arg_26_1)
		local var_26_0 = arg_26_0:getChildByName("bg")

		var_26_0:stopAllActions()

		arg_26_1 = arg_26_1 or 0

		var_26_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_26_1), cc.MoveTo:create(0.1, cc.p(-var_26_0:getContentSize().width + 40, var_26_0:getPositionY())), cc.CallFunc:create(function()
			local var_27_0 = var_26_0:getChildren()

			for iter_27_0 = 1, #var_27_0 do
				if var_27_0[iter_27_0]:getName() ~= "bntShowInfo" then
					var_27_0[iter_27_0]:setVisible(false)
				end
			end
		end)))
	end

	local var_23_3 = {}

	for iter_23_0, iter_23_1 in ipairs((level_manager:getChapterBattleFieldInfo(self.mode .. "-" .. self.chapter))) do
		table.insert(var_23_3, {
			icon = "FightLayer/map_icon.png",
			des = iter_23_1
		})
	end

	for iter_23_2, iter_23_3 in ipairs(expedition_manager:get_expedition_battlefield_status_info() or {}) do
		table.insert(var_23_3, iter_23_3)
	end

	if #var_23_3 == 0 then
		return
	end

	local var_23_5 = 0
	local var_23_6 = 0.5
	local var_23_7 = 3
	local var_23_8 = ccui.Button:create("FightLayer/btn_show_info.png", nil, "FightLayer/btn_show_info.png", var_0_27)

	var_23_8:setName("bntShowInfo")
	var_23_8:setSwallowTouches(false)

	local var_23_10 = (function(arg_28_0)
		local var_28_0 = cc.Node:create()
		local var_28_1 = ccui.ImageView:create(var_23_0, var_0_27)

		var_28_1:setScale9Enabled(true)
		var_28_1:setScaleX(-1)
		var_28_1:setAnchorPoint(cc.p(1, 0.5))
		var_28_1:setName("bg")
		var_28_1:setPosition(cc.p(-var_28_1:getContentSize().width, 0))
		var_28_1:setTouchEnabled(true)

		local var_28_2 = 0
		local var_28_3 = {}
		local var_28_4 = {}
		local var_28_5 = 0.3

		for iter_28_0 = 1, #arg_28_0 do
			local var_28_6 = cc.Label:createWithTTF(arg_28_0[iter_28_0].des, FONT_DES, 20)

			var_28_6:setScaleX(-1)
			var_28_6:setAnchorPoint(cc.p(0, 0.5))
			var_28_6:setColor(cc.c3b(212, 226, 242))
			var_28_6:setName("label")
			var_28_6:setAnchorPoint(cc.p(0, 0.5))

			var_28_3[#var_28_3 + 1] = var_28_6

			var_28_1:addChild(var_28_6, 99)

			local var_28_7 = ccui.ImageView:create(arg_28_0[iter_28_0].icon, var_0_27)

			var_28_7:setScale(var_28_5)
			var_28_7:setAnchorPoint(cc.p(1, 0.5))
			var_28_7:setName("icon")

			var_28_4[#var_28_4 + 1] = var_28_7

			var_28_1:addChild(var_28_7, 99)

			if var_28_2 < var_28_6:getContentSize().width + var_28_7:getContentSize().width * var_28_5 then
				var_28_2 = var_28_6:getContentSize().width + var_28_7:getContentSize().width * var_28_5
			end
		end

		local var_28_8 = var_28_3[1]:getContentSize().height
		local var_28_9 = var_28_2

		if var_28_9 > 320 then
			var_28_1:setContentSize(cc.size(var_28_9 + 50, #arg_28_0 < 3 and 67 or 104 + (#arg_28_0 - 2) * 20))
		else
			var_28_1:setContentSize(cc.size(340, #arg_28_0 < 3 and 67 or 104 + (#arg_28_0 - 2) * 20))
		end

		if #var_28_3 == 1 then
			var_28_4[1]:setPosition(cc.p(var_28_1:getContentSize().width - 5, var_28_1:getContentSize().height / 2))
			var_28_3[1]:setPosition(cc.p(var_28_1:getContentSize().width - 10 - var_28_4[1]:getContentSize().width * var_28_5, var_28_1:getContentSize().height / 2))
		elseif #var_28_3 % 2 == 1 then
			for iter_28_1 = 1, #var_28_3 do
				var_28_4[iter_28_1]:setPosition(cc.p(var_28_1:getContentSize().width - 5, var_28_1:getContentSize().height / 2 + var_28_8 - (iter_28_1 - math.floor(#var_28_3 / 2)) * (var_28_8 + 3)))
				var_28_3[iter_28_1]:setPosition(cc.p(var_28_1:getContentSize().width - 10 - var_28_4[iter_28_1]:getContentSize().width * var_28_5, var_28_1:getContentSize().height / 2 + var_28_8 - (iter_28_1 - math.floor(#var_28_3 / 2)) * (var_28_8 + 3)))
			end
		elseif #var_28_3 % 2 == 0 then
			for iter_28_2 = 1, #var_28_3 do
				var_28_4[iter_28_2]:setPosition(cc.p(var_28_1:getContentSize().width - 5, var_28_1:getContentSize().height / 2 + var_28_8 / 2 - (iter_28_2 - #var_28_3 / 2) * (var_28_8 + 3)))
				var_28_3[iter_28_2]:setPosition(cc.p(var_28_1:getContentSize().width - 10 - var_28_4[iter_28_2]:getContentSize().width * var_28_5, var_28_1:getContentSize().height / 2 + var_28_8 / 2 - (iter_28_2 - #var_28_3 / 2) * (var_28_8 + 3)))
			end
		end

		var_28_0.show = var_23_1
		var_28_0.hide = var_23_2

		var_28_0:addChild(var_28_1)

		return var_28_0
	end)(var_23_3)
	local var_23_11 = var_23_10:getChildByName("bg")

	var_23_10:setPosition(cc.p(0, var_23_5 + (var_23_11:getContentSize().height > 90 and var_23_11:getContentSize().height - 90 or 0)))
	self.battlefieldStatusInfo:addChild(var_23_10)
	var_23_8:setPosition(18, var_23_11:getContentSize().height / 2)
	var_23_10:show(var_23_6, var_23_7, var_23_8)
	var_23_11:addChild(var_23_8, 99)
	var_23_10:show(0, nil, var_23_8)
	var_23_8:setRotation(0)
	var_23_11:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_23_8:getRotation() == 180 then
			var_23_10:show(0, nil, var_23_8)
			var_23_8:setRotation(0)
		else
			var_23_10:hide(0)
			var_23_8:setRotation(180)
		end
	end)
end

function ExpeditionSelectLayer:initList()
	self.scrollView = ccui.ScrollView:create()

	self.scrollView:setContentSize(cc.size(var_0_21, var_0_22))
	self.scrollView:setBounceEnabled(true)
	self.scrollView:setDirection(ccui.ScrollViewDir.horizontal)
	self.scrollView:setPosition(20, 50)
	self.listBg:addChild(self.scrollView)
	self:updateList()
end

function ExpeditionSelectLayer:updateList()
	self.scrollView:removeAllChildren()
	self.scrollView:setInnerContainerSize(cc.size(math.ceil(#self.curRoleList / 2) * var_0_19 + 20, var_0_22))

	for iter_31_0, iter_31_1 in ipairs(self.curRoleList) do
		local var_31_0 = self:createSp(iter_31_0)

		self:updateSp(var_31_0)
		var_31_0:setPosition((math.ceil(iter_31_0 / 2) - 1) * var_0_19, iter_31_0 % 2 == 0 and 10 or var_31_0:getContentSize().height + 20)
		var_31_0:setName("sp" .. iter_31_0)
		var_31_0:setTag(var_31_0.servantid)
		self.scrollView:addChild(var_31_0)
	end
end

function ExpeditionSelectLayer:initBottom()
	local var_32_0 = ccui.ImageView:create("TowerDefenceListPanel/tips.png", var_0_27)

	var_32_0:setAnchorPoint(cc.p(0, 0))
	var_32_0:setPosition(0, -10)
	self.listBg:addChild(var_32_0)

	self.attrView = ccui.ScrollView:create()

	self.attrView:setContentSize(cc.size(640, 60))
	self.attrView:setInnerContainerSize(cc.size(75 * #self.attrList, 60))
	self.attrView:setDirection(ccui.ScrollViewDir.horizontal)
	self.attrView:setPosition(var_32_0:getContentSize().width, -10)
	self.listBg:addChild(self.attrView)

	for iter_32_0, iter_32_1 in ipairs(self.attrList) do
		local var_32_1

		if iter_32_1 == self.curSelectType then
			var_32_1 = "TowerDefenceListPanel/" .. iter_32_1 .. "_on.png" or "TowerDefenceListPanel/" .. iter_32_1 .. "_off.png"
		end

		local var_32_2 = ccui.Button:create(var_32_1, nil, var_32_1, var_0_27)

		var_32_2:setAnchorPoint(cc.p(0, 0))
		var_32_2:setPosition((iter_32_0 - 1) * var_32_2:getContentSize().width, 0)
		var_32_2:setName(iter_32_1)
		self.attrView:addChild(var_32_2)
		var_32_2:addTouchEventListener(function(arg_33_0, arg_33_1)
			if arg_33_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:switchSelect(iter_32_1)
		end)
	end
end

function ExpeditionSelectLayer:createSp(arg_34_1)
	local var_34_0 = self.curRoleList[arg_34_1]
	local var_34_1 = TempWidget:CreateTempBtn("TowerDefenceListPanel/role_bg2.png", nil, var_0_27)

	var_34_1:setAnchorPoint(0, 0)
	var_34_1:setSwallowTouches(false)

	local var_34_2 = ccui.ImageView:create(ROLE_PORTRAIT_PATH .. model_data[servant_data[self.curRoleList[arg_34_1]].modelid].portrait_image .. ".png")

	var_34_2:setScale(0.9)
	var_34_2:setPosition(var_34_1:getContentSize().width / 2, var_34_1:getContentSize().height / 2)
	var_34_1:addChild(var_34_2, 1)

	local var_34_3 = ccui.ImageView:create("TowerDefenceListPanel/cost_bg.png", var_0_27)

	var_34_3:setAnchorPoint(cc.p(0, 0))
	var_34_3:setPosition(5, 0)
	var_34_1:addChild(var_34_3, 3)

	local var_34_4 = cc.Label:createWithTTF("", FONT_W5, 26)

	var_34_4:setAnchorPoint(cc.p(1, 0))
	var_34_4:setColor(cc.c3b(250, 255, 170))
	var_34_4:setPosition(var_34_3:getContentSize().width - 5, -2)
	var_34_4:setVisible(false)
	var_34_3:addChild(var_34_4)

	local var_34_5 = cc.Label:createWithTTF("", FONT_NAME, 16)

	var_34_5:setAnchorPoint(cc.p(0, 0))
	var_34_5:setPosition(0, 0)
	var_34_3:addChild(var_34_5)

	local var_34_6 = ccui.ImageView:create("TowerDefenceListPanel/unused_mask.png", var_0_27)

	var_34_6:setPosition(cc.p(var_34_1:getContentSize().width / 2, var_34_1:getContentSize().height / 2))
	var_34_1:addChild(var_34_6, 10)
	var_34_6:setVisible(not expedition_manager:isServantCanSelect(self.curRoleList[arg_34_1]))

	local var_34_7 = ccui.ImageView:create("TowerDefenceListPanel/selected_frame.png", var_0_27)

	var_34_7:setPosition(var_34_1:getContentSize().width / 2, var_34_1:getContentSize().height / 2)
	var_34_1:addChild(var_34_7, 5)
	var_34_1:_addSuperEvent(function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_0 == TempWidget.Click then
			local var_35_0 = arg_35_1:getTouchBeganPosition()

			if not isContainPosOfConvexPolygon(var_0_25, (arg_35_1:convertToNodeSpace((arg_35_1:getTouchEndPosition())))) then
				return
			end

			self:roleSpEventFunc(var_34_0)
		elseif arg_35_0 == TempWidget.Press then
			LayerManager:pushInLayer("EquipLayer", {
				showtype = SHOW_TYPE_DROP_PREVIEW,
				cursoul = var_34_0,
				exitCallback = function(...)
					if towerDefenceSelectLayerInstance then
						self:updateList()
					end
				end
			})
		end
	end)

	var_34_1.id = arg_34_1
	var_34_1.servantid = self.curRoleList[arg_34_1]
	var_34_1.costBg = var_34_3
	var_34_1.costNum = var_34_4
	var_34_1.roleLv = var_34_5
	var_34_1.selectedLogo = var_34_7

	return var_34_1
end

function ExpeditionSelectLayer:updateSp(arg_37_1)
	local var_37_0 = not not self.selectedList[arg_37_1.servantid]

	arg_37_1:loadTextures("TowerDefenceListPanel/" .. ((self.selectedList[arg_37_1.servantid] and true or false) and "role_bg2.png" or "role_bg1.png"), "TowerDefenceListPanel/" .. ((self.selectedList[arg_37_1.servantid] and true or false) and "role_bg2.png" or "role_bg1.png"), "TowerDefenceListPanel/" .. ((self.selectedList[arg_37_1.servantid] and true or false) and "role_bg2.png" or "role_bg1.png"), var_0_27)
	arg_37_1.selectedLogo:setVisible(var_37_0)
	arg_37_1.roleLv:setString(L_ITEMPANEL_SORT_STR.level2 .. core_manager:getCoreLv(arg_37_1.servantid))
	arg_37_1.roleLv:setOpacity(255)
	arg_37_1.roleLv:stopAllActions()
	arg_37_1.roleLv:setColor(cc.c3b(255, 255, 255))

	if role_false_level_manager:isRoleFalseLevelMember(arg_37_1.servantid, FIGHTTYPE_EXPEDITION_TOWER) then
		local var_37_1, var_37_2, var_37_3, var_37_4 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(arg_37_1.servantid, FIGHTTYPE_EXPEDITION_TOWER)

		if falseRank == core_manager:getServantCoreRank(arg_37_1.servantid) and playermodel.cores[arg_37_1.servantid].level == var_37_2 then
			arg_37_1.roleLv:setOpacity(255)
			arg_37_1.roleLv:stopAllActions()
			arg_37_1.roleLv:setColor(cc.c3b(255, 255, 255))
			arg_37_1.roleLv:stopAllActions()
		else
			arg_37_1.roleLv:setColor(cc.c3b(206, 255, 167))

			local var_37_5 = true

			arg_37_1.roleLv:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
				if var_37_5 then
					arg_37_1.roleLv:setString(L_EXPLORE_OFFER_POP[3])
				else
					arg_37_1.roleLv:setString(L_ITEMPANEL_SORT_STR.level2 .. var_37_2 + var_37_4)
				end

				var_37_5 = not var_37_5
			end), cc.FadeIn:create(2))))
		end
	end
end

function ExpeditionSelectLayer:roleSpEventFunc(arg_39_1)
	if self.roleSpTouchLock then
		return
	end

	if self.selectedList[arg_39_1] then
		self.selectedList[arg_39_1] = nil

		self:removeRoleSpine(arg_39_1)
	elseif not expedition_manager:isServantCanSelect(arg_39_1) then
		global_ShowBlockWords(L_EXP_MGR[14])
	elseif table.nums(self.selectedList) < var_0_24 then
		self.selectedList[arg_39_1] = true

		self:addRoleSpine(arg_39_1)
	else
		global_ShowBlockWords(L_EXPEDITION_SELECT[1])
	end

	self:updatelimitLabel()

	local var_39_0 = self.scrollView:getChildByTag(arg_39_1)

	if var_39_0 then
		self:updateSp(var_39_0)
	end
end

function ExpeditionSelectLayer:switchSelect(arg_40_1)
	if self.roleSpTouchLock then
		return
	end

	if self.curSelectType == arg_40_1 then
		return
	end

	self.curSelectType = arg_40_1

	for iter_40_0, iter_40_1 in pairs(self.attrView:getChildren()) do
		local var_40_0 = iter_40_1:getName()

		if var_40_0 == self.curSelectType then
			iter_40_1:loadTextures("TowerDefenceListPanel/" .. var_40_0 .. "_on.png", nil, "TowerDefenceListPanel/" .. var_40_0 .. "_on.png", var_0_27)
		else
			iter_40_1:loadTextures("TowerDefenceListPanel/" .. var_40_0 .. "_off.png", nil, "TowerDefenceListPanel/" .. var_40_0 .. "_off.png", var_0_27)
		end
	end

	self:updateRoleListData()
	self:updateList()
end

function ExpeditionSelectLayer:sureEventFunc()
	if self.roleSpTouchLock then
		return
	end

	if next(self.selectedList) == nil then
		return global_ShowBlockWords(L_TOWER_DEFENCE_SELECT_ERROR)
	end

	if table.nums(self.selectedList) > var_0_24 then
		global_ShowBlockWords(L_TOWER_DEFENCE_SELECT_ERROR2)

		return
	end

	local var_41_0 = {}

	for iter_41_0, iter_41_1 in pairs(self.selectedList) do
		table.insert(var_41_0, iter_41_0)
	end

	self:saveRoleList(var_41_0)

	if self.sureCallback then
		self.sureCallback(var_41_0)
	end
end

function ExpeditionSelectLayer:initEnemySpine()
	local var_42_0 = {
		[4] = cc.p(560, -50 + 80 * 3),
		[8] = cc.p(560 - 100, -50 + 80 * 3),
		[3] = cc.p(560, -50 + 80 * 2),
		[6] = cc.p(560 - 100, -50 + 80 * 2),
		[2] = cc.p(560, -50 + 80),
		[5] = cc.p(560 - 100, -50 + 80),
		cc.p(560, -50),
		[7] = cc.p(560 - 100, -50)
	}
	local var_42_1 = {
		4,
		3,
		2,
		1,
		3,
		2,
		1,
		2,
		1,
		1
	}

	self.enemySkeletons = {}

	local var_42_2 = {}

	local function var_42_3(arg_43_0)
		if self.enemyBossList[arg_43_0] then
			for iter_43_0, iter_43_1 in ipairs({
				4,
				8,
				3,
				2.1
			}) do
				if not var_42_2[iter_43_0] then
					return iter_43_0
				end
			end
		end

		for iter_43_2 = 1, 10 do
			if not var_42_2[iter_43_2] then
				return iter_43_2
			end
		end
	end

	for iter_42_0, iter_42_1 in ipairs(self.enemyList) do
		if iter_42_0 <= #var_42_0 then
			self:runAction(cc.Sequence:create(cc.DelayTime:create((iter_42_0 - 1) * 0.01), cc.CallFunc:create(function()
				local var_44_0 = var_42_3(iter_42_1)
				local var_44_2 = L2Skeleton:create(ROLE_SPINE_PATH .. model_data[iter_42_1].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[iter_42_1].spine_model .. ".atlas", (model_data[iter_42_1].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[iter_42_1].clothes_model .. ".atlas" or nil))

				var_44_2._modelid = iter_42_1

				self:addSkeletonDownloadInterface(var_44_2)
				var_44_2:showLoadingAni(true)
				var_44_2:refreshSkeleton()

				local var_44_3 = model_data[iter_42_1].modelscale or 1

				var_44_2:setScale(var_0_23 * -1 * var_44_3 * (model_data[iter_42_1].modelflip or 1) * 0.8, var_0_23 * var_44_3 * 0.8)
				var_44_2:setRotation(math.random(-120, 120))
				var_44_2:setPosition(var_42_0[var_44_0].x + math.random(-10, 10), 1000)
				self.map:addChild(var_44_2, var_42_1[var_44_0])

				var_42_2[var_44_0] = true
				self.enemySkeletons[var_44_0] = var_44_2

				var_44_2:runAction(cc.Sequence:create(cc.DelayTime:create(iter_42_0 * math.random(1, 5) * 0.04), cc.EaseExponentialIn:create(cc.MoveTo:create(0.8, cc.p(var_44_2:getPositionX(), var_42_0[var_44_0].y))), cc.Spawn:create(cc.JumpTo:create(0.5, var_42_0[var_44_0], math.random(2, 4) * 10, 2), cc.RotateTo:create(0.5, 0))))
			end)))
		end
	end
end

function ExpeditionSelectLayer:getAddRolePosIndex(arg_45_1)
	if model_data[arg_45_1].career == "tank" or model_data[arg_45_1].career == "fighter" then
		-- block empty
	elseif model_data[arg_45_1].career == "shotter" or model_data[arg_45_1].career == "assassin" then
		for iter_45_0 = 7, 1, -1 do
			if not self.skeletonList[iter_45_0] then
				return iter_45_0
			end
		end
	elseif model_data[arg_45_1].career == "support" or model_data[arg_45_1].career == "witcher" then
		for iter_45_1 = 1, 10 do
			if not self.skeletonList[iter_45_1] then
				return iter_45_1
			end
		end
	end

	for iter_45_2 = 10, 1, -1 do
		if not self.skeletonList[iter_45_2] then
			return iter_45_2
		end
	end
end

function ExpeditionSelectLayer:addRoleSpine(arg_46_1)
	local var_46_0 = {
		[4] = cc.p(80 + 100, 240),
		cc.p(80, 240 - 60),
		[8] = cc.p(80 + 100 * 2, 240 - 60),
		[5] = cc.p(80 + 100, 240 - 60 * 2),
		cc.p(80, 240 - 60 * 3),
		[9] = cc.p(80 + 100 * 2, 240 - 60 * 3),
		[6] = cc.p(80 + 100, 240 - 60 * 4),
		cc.p(80, 240 - 60 * 5),
		[10] = cc.p(80 + 100 * 2, 240 - 60 * 5),
		[7] = cc.p(80 + 100, 240 - 60 * 6)
	}
	local var_46_1 = {
		2,
		4,
		6,
		1,
		3,
		5,
		7,
		2,
		4,
		6
	}
	local var_46_2 = global_get_servant_skin(arg_46_1)
	local var_46_3 = self:getAddRolePosIndex(var_46_2)
	local var_46_5 = model_data[var_46_2].modelweight
	local var_46_6 = model_data[var_46_2].modelheight
	local var_46_7 = L2Skeleton:create(ROLE_SPINE_PATH .. model_data[var_46_2].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_46_2].spine_model .. ".atlas", (model_data[var_46_2].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_46_2].clothes_model .. ".atlas" or nil))

	var_46_7._modelid = var_46_2

	self:addSkeletonDownloadInterface(var_46_7)
	var_46_7:showLoadingAni(true)
	var_46_7:refreshSkeleton()

	local var_46_8 = model_data[var_46_2].modelscale or 1

	var_46_7:setScale(var_0_23 * var_46_8 * (model_data[var_46_2].modelflip or 1), var_0_23 * var_46_8)
	var_46_7:play("win", false)
	var_46_7:addAnimation("idle")
	var_46_7:setPosition(var_46_0[var_46_3])
	self.map:addChild(var_46_7, var_46_1[var_46_3])
	var_46_7:setLocalZOrder(var_46_1[var_46_3])
	self.debutEffect:setVisible(true)
	self.debutEffect:setPosition(var_46_0[var_46_3].x, var_46_0[var_46_3].y + 40)
	self.debutEffect:play("chuchang", false)
	self.debutEffect:setLocalZOrder(var_46_1[var_46_3])
	GlobalPlayRoleSound(var_46_2, ROLE_SOUND_TYPE.fight)

	local var_46_9 = ccui.Layout:create()

	var_46_9:setTouchEnabled(true)
	var_46_9:setAnchorPoint(cc.p(0.5, 0))
	var_46_9:setPosition(0, 0)
	var_46_9:setContentSize(cc.size(var_46_5, var_46_6))
	var_46_7:addChild(var_46_9)
	var_46_9:addTouchEventListener(function(arg_47_0, arg_47_1)
		if arg_47_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.roleSpTouchLock then
			return
		end

		if arg_47_0.isLock then
			return
		end

		arg_47_0.isLock = true

		self:runAction(cc.CallFunc:create(function()
			self:roleSpEventFunc(arg_46_1)
		end))
	end)

	self._direction = 1
	self.charactertype = "player"

	local var_46_10 = cc.Node:create()

	var_46_10:setPosition(cc.p(0, var_46_6 * var_0_23 * var_46_8 + HPBAR_HEIGHT))
	var_46_7:addChild(var_46_10)

	local var_46_11

	if config._DEBUG then
		var_46_11 = cc.Sprite:create(HPBAR_BOX_BG) or cc.Sprite:createWithSpriteFrameName(HPBAR_BOX_BG)
	end

	var_46_11:setScaleX(self._direction)
	var_46_10:addChild(var_46_11)

	local var_46_12

	if self.charactertype == "player" then
		var_46_12 = HPBAR_BAR_PLAYER

		local var_46_13

		if not HPBAR_BAR_PLAYER then
			var_46_12 = HPBAR_BAR_ENEMY
			var_46_13 = self:getPlayerModel(arg_46_1)
		end
	end

	local var_46_14 = BarSprite:createHpBar(var_46_13.curhp, var_46_13.singlehp, var_46_13.hpcount, {
		{
			bar = var_46_12,
			bg = HPBAR_BOX_BG
		},
		{
			bar = "fight/UI_haemalStrandy_4.png",
			bg = HPBAR_BOX_BG
		},
		sub = HPBAR_BAR_SUB
	}, -1 * self._direction)

	var_46_14:setName("hpbar")
	var_46_14:setPosition(cc.p(var_46_11:getPositionX(), var_46_11:getPositionY()))
	var_46_14.hp_percent:setVisible(false)
	var_46_10:addChild(var_46_14, 1)

	self.skeletonList[var_46_3] = var_46_7
	self.skeletonDataList[var_46_3] = skeletondata
	self.spinePosIdx[arg_46_1] = var_46_3
end

function ExpeditionSelectLayer:removeRoleSpine(arg_49_1)
	self.skeletonList[self.spinePosIdx[arg_49_1]]:removeFromParent()

	self.skeletonList[self.spinePosIdx[arg_49_1]] = nil
	self.skeletonDataList[self.spinePosIdx[arg_49_1]] = nil
	self.spinePosIdx[arg_49_1] = nil
end

function ExpeditionSelectLayer.saveRoleList(arg_50_0, arg_50_1)
	local var_50_0 = ""

	for iter_50_0, iter_50_1 in pairs(arg_50_1) do
		var_50_0 = var_50_0 .. iter_50_1 .. ","
	end

	RoleDefault:getInstance():setStringForKey("Expedition" .. expedition_manager.expeditionInfo.inittype, var_50_0)
end

function ExpeditionSelectLayer.getPlayerModel(arg_51_0, arg_51_1)
	local var_51_0 = 0
	local var_51_1 = 0
	local var_51_2 = 0

	for iter_51_0, iter_51_1 in pairs((expedition_manager:getExpeditionTeamListInfo())) do
		if arg_51_1 == iter_51_1.servantid and iter_51_1.bloodpercent > 0 then
			var_51_0 = iter_51_1.bloodpercent
			var_51_1 = 100
			var_51_2 = 1

			break
		end
	end

	return {
		curhp = var_51_0,
		singlehp = var_51_1,
		hpcount = var_51_2
	}
end

function ExpeditionSelectLayer:batchCreatePlayer()
	if not self.isNeedBatchCreatePlayer then
		return
	end

	self.roleSpTouchLock = true

	local var_52_0 = {
		[4] = cc.p(80 + 100, 240),
		cc.p(80, 240 - 60),
		[8] = cc.p(80 + 100 * 2, 240 - 60),
		[5] = cc.p(80 + 100, 240 - 60 * 2),
		cc.p(80, 240 - 60 * 3),
		[9] = cc.p(80 + 100 * 2, 240 - 60 * 3),
		[6] = cc.p(80 + 100, 240 - 60 * 4),
		cc.p(80, 240 - 60 * 5),
		[10] = cc.p(80 + 100 * 2, 240 - 60 * 5),
		[7] = cc.p(80 + 100, 240 - 60 * 6)
	}
	local var_52_1 = {
		2,
		4,
		6,
		1,
		3,
		5,
		7,
		2,
		4,
		6
	}
	local var_52_2 = 1

	for iter_52_0, iter_52_1 in pairs(self.selectedList) do
		self:runAction(cc.Sequence:create(cc.DelayTime:create((1 - 1) * 0.1), cc.CallFunc:create(function()
			local var_53_0 = global_get_servant_skin(iter_52_0)
			local var_53_1 = self:getAddRolePosIndex(var_53_0)
			local var_53_3 = model_data[var_53_0].modelweight
			local var_53_4 = model_data[var_53_0].modelheight
			local var_53_5 = L2Skeleton:create(ROLE_SPINE_PATH .. model_data[var_53_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_53_0].spine_model .. ".atlas", (model_data[var_53_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_53_0].clothes_model .. ".atlas" or nil))

			var_53_5._modelid = var_53_0

			self:addSkeletonDownloadInterface(var_53_5)
			var_53_5:showLoadingAni(true)
			var_53_5:refreshSkeleton()
			var_53_5:play("win", false)
			var_53_5:addAnimation("idle")

			local var_53_6 = model_data[var_53_0].modelscale or 1

			var_53_5:setScale(var_0_23 * var_53_6 * (model_data[var_53_0].modelflip or 1), var_0_23 * var_53_6)
			var_53_5:setRotation(math.random(-120, 120))
			var_53_5:setPosition(var_52_0[var_53_1].x + math.random(-14, 14), 1000)
			self.map:addChild(var_53_5, var_52_1[var_53_1])

			local var_53_7 = ccui.Layout:create()

			var_53_7:setTouchEnabled(true)
			var_53_7:setAnchorPoint(cc.p(0.5, 0))
			var_53_7:setPosition(0, 0)
			var_53_7:setContentSize(cc.size(var_53_3, var_53_4))
			var_53_5:addChild(var_53_7)
			var_53_7:addTouchEventListener(function(arg_54_0, arg_54_1)
				if arg_54_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self.roleSpTouchLock then
					return
				end

				if arg_54_0.isLock then
					return
				end

				arg_54_0.isLock = true

				self:runAction(cc.CallFunc:create(function()
					self:roleSpEventFunc(iter_52_0)
				end))
			end)

			self._direction = 1
			self.charactertype = "player"

			local var_53_8 = cc.Node:create()

			var_53_8:setPosition(cc.p(0, var_53_4 * var_0_23 * var_53_6 + HPBAR_HEIGHT))
			var_53_5:addChild(var_53_8)

			local var_53_9

			if config._DEBUG then
				var_53_9 = cc.Sprite:create(HPBAR_BOX_BG) or cc.Sprite:createWithSpriteFrameName(HPBAR_BOX_BG)
			end

			var_53_9:setScaleX(self._direction)
			var_53_8:addChild(var_53_9)

			local var_53_10

			if self.charactertype == "player" then
				var_53_10 = HPBAR_BAR_PLAYER

				local var_53_11

				if not HPBAR_BAR_PLAYER then
					var_53_10 = HPBAR_BAR_ENEMY
					var_53_11 = self:getPlayerModel(iter_52_0)
				end
			end

			local var_53_12 = BarSprite:createHpBar(var_53_11.curhp, var_53_11.singlehp, var_53_11.hpcount, {
				{
					bar = var_53_10,
					bg = HPBAR_BOX_BG
				},
				{
					bar = "fight/UI_haemalStrandy_4.png",
					bg = HPBAR_BOX_BG
				},
				sub = HPBAR_BAR_SUB
			}, -1 * self._direction)

			var_53_12:setName("hpbar")
			var_53_12:setPosition(cc.p(var_53_9:getPositionX(), var_53_9:getPositionY()))
			var_53_12.hp_percent:setVisible(false)
			var_53_8:addChild(var_53_12, 1)

			self.skeletonList[var_53_1] = var_53_5
			self.spinePosIdx[iter_52_0] = var_53_1

			local var_53_13 = var_52_2 == table.nums(self.selectedList)

			var_53_5:runAction(cc.Sequence:create(cc.DelayTime:create(var_52_2 * math.random(1, 4) * 0.02), cc.EaseExponentialIn:create(cc.MoveTo:create(0.6, cc.p(var_53_5:getPositionX(), var_52_0[var_53_1].y))), cc.Spawn:create(cc.JumpTo:create(0.2, var_52_0[var_53_1], math.random(2, 4) * 8, math.random(1, 2)), cc.RotateTo:create(0.2, 0)), cc.CallFunc:create(function()
				if var_53_13 then
					self.roleSpTouchLock = false
				end
			end)))

			var_52_2 = var_52_2 + 1
		end)))
	end
end

local var_0_28 = "default/default.json"
local var_0_29 = "default/default.atlas"

function ExpeditionSelectLayer.addSkeletonDownloadInterface(arg_57_0, arg_57_1)
	local file_check_manager = require("controller.filedownloader.file_check_manager")

	function arg_57_1:checkResource(arg_58_1)
		self._downloadinglist = {}
		self._downloadimg = arg_58_1

		if not arg_58_1 then
			self:onDownloadComplete(arg_58_1)

			return
		end

		local var_58_0 = file_check_manager:checkBattleSpineByModel(self._modelid)

		if #var_58_0 > 0 then
			self:onDownloadComplete({
				json = var_0_28,
				atlas = var_0_29
			})
			self:onDownloadProcessing()
			self:startDownload(var_58_0)
		else
			self:onDownloadComplete(arg_58_1)
		end
	end
end
