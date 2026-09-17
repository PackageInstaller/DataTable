AutoChessSelectLayer = class("AutoChessSelectLayer", function()
	return cc.Layer:create()
end)

local level_manager = require("controller.level_manager")
local tower_defence_manager = require("controller.tower_defence_manager")
local core_manager = require("controller.core_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local playermodel = require("model.playermodel")
local total_skill_data = require("data.total_skill_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local chapter_data = require("data.chapter_data")
local team_skill_manager = require("controller.team_skill_manager")
local activity_manager = require("controller.activity_manager")
local spinecache_manager = require("controller.spinecache_manager")
local TowerBaseBarSprite = require("view.Sprite.TowerBaseBarSprite")
local TempWidget = require("view.Sprite.TempWidget")
local item_manager = require("controller.item_manager")
local var_0_15 = GameDisplay.height * (ORIGIN_FIGHT_HEIGHT + 185) / GameDisplay.origin_design_y - GameDisplay.fix_y
local var_0_16 = 640
local var_0_17 = 800
local var_0_18 = -420
local var_0_19 = -(GameDisplay.height * (ORIGIN_FIGHT_HEIGHT + 185) / GameDisplay.origin_design_y - GameDisplay.fix_y) - GameDisplay.fix_y
local var_0_20 = 110
local var_0_22 = 600
local var_0_23 = 230
local var_0_24 = 0.24
local var_0_25 = 6
local var_0_26 = {
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
local var_0_28 = config._DEBUG and 0 or 1
local var_0_29

local function var_0_30(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_0:getChildByName("bg")

	var_2_0:stopAllActions()

	arg_2_1 = arg_2_1 or 0
	arg_2_2 = arg_2_2 or 999

	local var_2_1 = var_2_0:getChildren()

	for iter_2_0 = 1, #var_2_1 do
		var_2_1[iter_2_0]:setVisible(true)
	end

	var_2_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_2_1), cc.MoveTo:create(0.1, cc.p(0, var_2_0:getPositionY())), cc.DelayTime:create(arg_2_2), cc.MoveTo:create(0.1, cc.p(-var_2_0:getContentSize().width + 40, 0)), cc.CallFunc:create(function()
		arg_2_3:setRotation(180)

		local var_3_0 = var_2_0:getChildren()

		for iter_3_0 = 1, #var_3_0 do
			if var_3_0[iter_3_0]:getName() ~= "bntShowInfo" then
				var_3_0[iter_3_0]:setVisible(false)
			end
		end
	end)))
end

local function var_0_31(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getChildByName("bg")

	var_4_0:stopAllActions()

	arg_4_1 = arg_4_1 or 0

	var_4_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_4_1), cc.MoveTo:create(0.1, cc.p(-var_4_0:getContentSize().width + 40, var_4_0:getPositionY())), cc.CallFunc:create(function()
		local var_5_0 = var_4_0:getChildren()

		for iter_5_0 = 1, #var_5_0 do
			if var_5_0[iter_5_0]:getName() ~= "bntShowInfo" then
				var_5_0[iter_5_0]:setVisible(false)
			end
		end
	end)))
end

function AutoChessSelectLayer.create(arg_6_0, arg_6_1)
	local var_6_0 = AutoChessSelectLayer.new()

	var_6_0:setPosition(cc.p(0, var_0_15))
	var_6_0:initBg(arg_6_1)
	TextureManager:removeUnusedSpineTextures()
	var_6_0:init(arg_6_1)

	return var_6_0
end

function AutoChessSelectLayer:init(arg_7_1)
	self.mode = arg_7_1.mode
	self.chapter = arg_7_1.chapter
	self.sureCallback = arg_7_1.sureCallback
	self.activityId = arg_7_1.activityId
	self.layerName = "AutoChessLayer_" .. self.activityId

	TextureManager:loadLayerTextures({
		self.layerName
	})
	self:initData()
	self:initUI()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			TextureManager:removeLayerTextures({
				self.layerName
			})
			activity_manager:releaseEventListenerByName("AutoChessSelectLayer")

			var_0_29 = nil
		elseif arg_8_0 == "enter" then
			var_0_29 = self
		end
	end)
end

function AutoChessSelectLayer:initData()
	(function()
		var_0_25 = chapter_data[self.mode .. "-" .. self.chapter].select_max_role or 6
		self.selectedList = {}
		self.skeletonList = {}
	end)()
	;(function()
		self.allRoleDatas = {}

		for iter_11_0, iter_11_1 in pairs((activity_manager:getAutoChessServantList(self.activityId))) do
			table.insert(self.allRoleDatas, {
				servantid = iter_11_1.servantid,
				index = iter_11_0,
				star = iter_11_1.star
			})
		end
	end)()
	;(function()
		self.attrList = {}
		self.special_attrs = {}

		local var_12_0 = {
			wind = 8,
			water = 6,
			fire = 7,
			devil = 2,
			light = 5,
			dark = 4,
			imaginary = 3
		}

		for iter_12_0, iter_12_1 in pairs(ATTR_ID) do
			if var_12_0[iter_12_1] then
				table.insert(self.attrList, iter_12_1)
			else
				self.special_attrs[iter_12_1] = true
			end
		end

		table.sort(self.attrList, function(arg_13_0, arg_13_1)
			return (var_12_0[arg_13_1] or 0) < (var_12_0[arg_13_0] or 0)
		end)
		table.insert(self.attrList, 1, "all")
		table.insert(self.attrList, "special")

		self.curSelectType = "all"
	end)()
	;(function()
		self.enemyList = level_manager.getAllMonsterList(self.mode, self.chapter)

		table.sort(self.enemyList, function(arg_15_0, arg_15_1)
			return model_data[arg_15_0].modelweight < model_data[arg_15_1].modelweight
		end)
	end)()
	self:updateRoleListData()
end

function AutoChessSelectLayer:updateRoleListData()
	self.curRoleList = {}

	for iter_16_0, iter_16_1 in pairs(self.allRoleDatas) do
		local var_16_0 = global_get_model_attr(servant_data[iter_16_1.servantid].modelid)

		if self.curSelectType == "all" or self.curSelectType == var_16_0 or self.curSelectType == "special" and self.special_attrs[var_16_0] then
			table.insert(self.curRoleList, iter_16_1)
		end
	end
end

function AutoChessSelectLayer:initBg(arg_17_1)
	self.bgPanel = ccui.Layout:create()

	self.bgPanel:setAnchorPoint(cc.p(0, 0))
	self.bgPanel:setPosition(cc.p(0, 5))
	self.bgPanel:setContentSize(cc.size(var_0_16, var_0_17))
	self:addChild(self.bgPanel)

	self.map = ccui.Layout:create()

	self.map:setContentSize(cc.size(var_0_16, var_0_17))
	self.map:setAnchorPoint(cc.p(0.5, 0))
	self.map:setPosition(cc.p(var_0_16 / 2, 0))
	self.bgPanel:addChild(self.map)

	local var_17_0 = ccui.ImageView:create("TowerDefenceListPanel/select_mark_bg.png", var_0_28)

	var_17_0:setAnchorPoint(cc.p(0.5, 0))
	var_17_0:setPosition(320, var_0_19)
	self:addChild(var_17_0)

	self.background = {}

	local var_17_1 = level_manager.getCurLevelData(arg_17_1.mode, arg_17_1.chapter .. "-1")

	for iter_17_0 = 1, 3 do
		self.background[iter_17_0] = cc.Sprite:create(FIGHT_BG_PATH .. var_17_1["sceneConfigure" .. iter_17_0] .. ".png")

		self.background[iter_17_0]:setAnchorPoint(cc.p(0, 0))
		self.background[iter_17_0]:setPosition(cc.p(-100, var_0_18))
		self.map:addChild(self.background[iter_17_0], -iter_17_0)
	end
end

function AutoChessSelectLayer:initUI()
	self:initBaseUI()
	self:initBattleFieldStatusInfoPanel()
	self:initTeamSkillInfoPanel()
	self:initList()
	self:initBottom()
	self:initAutoChessChoose()
	self:initEnemySpine()
	self:initselectByArray()
end

function AutoChessSelectLayer.registerActivityEventListener(arg_19_0)
	activity_manager:registerEventListener("AutoChessSelectLayer", activity_manager.activityEventId.AUTOCHESS_LIST_UPDATE, function(arg_20_0)
		arg_19_0.autoChessChooseSprite:update()

		local var_20_0 = activity_manager:getAutoChessServantList(arg_19_0.activityId)

		if not var_20_0 or not next(var_20_0) then
			arg_19_0.autoChessChooseSprite:show()
		end
	end)
	activity_manager:registerEventListener("AutoChessSelectLayer", activity_manager.activityEventId.AUTOCHESS_SELECT_SUCCESS, function(arg_21_0)
		arg_19_0.autoChessChooseSprite:update()

		if item_manager:getItemNumber((activity_manager:getAutoChessSelectNeedItem(arg_19_0.activityId))) <= 0 then
			arg_19_0.autoChessChooseSprite:hide()
		end

		arg_19_0:clearAll()
		arg_19_0:initData()
		arg_19_0:updateList()
	end)
end

function AutoChessSelectLayer:clearAll()
	for iter_22_0, iter_22_1 in pairs(self.selectedList) do
		self:roleSpEventFunc(iter_22_0)
	end
end

function AutoChessSelectLayer:initBaseUI()
	self.listBg = ccui.ImageView:create("TowerDefenceListPanel/panelbg.png", var_0_28)

	self.listBg:setAnchorPoint(cc.p(0.5, 0))
	self.listBg:setPosition(320, var_0_19 + 10 - 450 - 30)
	self.listBg:setName("listBg")
	self:addChild(self.listBg)
	self.listBg:runAction(cc.EaseExponentialIn:create(cc.MoveTo:create(0.4, cc.p(320, var_0_19 + 10))))

	local var_23_0 = ccui.ImageView:create("TowerDefenceListPanel/arrow.png", var_0_28)

	var_23_0:setScaleX(-1)
	var_23_0:setAnchorPoint(cc.p(1, 0.5))
	var_23_0:setPosition(-4, 166)
	self.listBg:addChild(var_23_0)

	local var_23_1 = ccui.ImageView:create("TowerDefenceListPanel/arrow.png", var_0_28)

	var_23_1:setAnchorPoint(cc.p(1, 0.5))
	var_23_1:setPosition(644, 166)
	self.listBg:addChild(var_23_1)

	self.limitLabel = cc.Label:createWithTTF("可上阵:10/10", FONT_NAME, 24)

	self.limitLabel:setPosition(555, 310)
	self.limitLabel:setRotation(-2)
	self.listBg:addChild(self.limitLabel)
	self:updatelimitLabel()

	local var_23_2 = cc.Label:createWithTTF(L_TOWER_DEFENCE_SELECT_DES, FONT_W5, 24)

	var_23_2:setAnchorPoint(0.5, 0.5)
	var_23_2:setPosition(320, 310 - 10)
	self.listBg:addChild(var_23_2)

	local var_23_3 = cc.Label:createWithTTF("00:00", FONT_NAME, 24)

	var_23_3:setPosition(60, 310)
	var_23_3:setRotation(2)
	self.listBg:addChild(var_23_3)

	self.debutEffect = L2Skeleton:create("spine/tower_defence/chuchang.json", "spine/tower_defence/chuchang.atlas", nil, true)

	self.debutEffect:refreshSkeleton()
	self.debutEffect:setVisible(false)
	self.map:addChild(self.debutEffect, 99)

	self.sureBtn = ccui.Button:create("TowerDefenceListPanel/select_sure_btn.png", nil, "TowerDefenceListPanel/select_sure_btn.png", var_0_28)

	self.sureBtn:setAnchorPoint(cc.p(1, 0))
	self.sureBtn:setPosition(640, 350)
	self.sureBtn:setName("sureSelectBtn")
	self.listBg:addChild(self.sureBtn)

	local var_23_4 = TempWidget:CreateTempBtn("TowerDefenceListPanel/back_btn.png")

	var_23_4:align(cc.p(1, 0), self.sureBtn:getPositionX(), self.sureBtn:getPositionY() + self.sureBtn:getContentSize().height + 93)
	var_23_4:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.listBg:addChild(var_23_4)

	local var_23_5 = TempWidget:CreateTempBtn(self.layerName .. "/btn_restart.png")

	var_23_5:align(cc.p(1, 0), self.sureBtn:getPositionX() + 5, self.sureBtn:getPositionY() + self.sureBtn:getContentSize().height + 20)
	var_23_5:_addEvent(function()
		self.autoChessChooseSprite:update()
		self.autoChessChooseSprite:show()
	end)
	self.listBg:addChild(var_23_5)
	self.sureBtn:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:sureEventFunc()
	end)
end

function AutoChessSelectLayer:updatelimitLabel()
	self.limitLabel:setString(TOWER_ROLE_LIMIT .. table.nums(self.selectedList) .. "/" .. var_0_25)
	self.limitLabel:setColor(table.nums(self.selectedList) >= var_0_25 and cc.c3b(255, 85, 85) or cc.c3b(255, 255, 255))
end

function AutoChessSelectLayer:initBattleFieldStatusInfoPanel()
	local var_28_0 = "FightLayer/battlefield_status_bg.png"

	self.battlefieldStatusInfo = cc.Node:create()

	self.battlefieldStatusInfo:setPosition(cc.p(0, 360))

	self.battlefieldStatusInfo.curchapter = self.mode .. "-" .. self.chapter

	self.listBg:addChild(self.battlefieldStatusInfo, 99)

	local var_28_1 = {}

	for iter_28_0, iter_28_1 in ipairs((level_manager:getChapterBattleFieldInfo(self.mode .. "-" .. self.chapter))) do
		table.insert(var_28_1, {
			icon = "FightLayer/map_icon.png",
			des = iter_28_1
		})
	end

	if #var_28_1 == 0 then
		return
	end

	local var_28_3 = 0
	local var_28_4 = 0.5
	local var_28_5 = 3
	local var_28_6 = ccui.Button:create("FightLayer/btn_show_info.png", nil, "FightLayer/btn_show_info.png", var_0_28)

	var_28_6:setName("bntShowInfo")
	var_28_6:setSwallowTouches(false)

	local var_28_8 = (function(arg_29_0)
		local var_29_0 = cc.Node:create()
		local var_29_1 = ccui.ImageView:create(var_28_0, var_0_28)

		var_29_1:setScale9Enabled(true)
		var_29_1:setScaleX(-1)
		var_29_1:setAnchorPoint(cc.p(1, 0.5))
		var_29_1:setName("bg")
		var_29_1:setPosition(cc.p(-var_29_1:getContentSize().width, 0))
		var_29_1:setTouchEnabled(true)

		local var_29_2 = 0
		local var_29_3 = {}
		local var_29_4 = {}
		local var_29_5 = 0.3

		for iter_29_0 = 1, #arg_29_0 do
			local var_29_6 = cc.Label:createWithTTF(arg_29_0[iter_29_0].des, FONT_DES, 20)

			var_29_6:setScaleX(-1)
			var_29_6:setAnchorPoint(cc.p(0, 0.5))
			var_29_6:setColor(cc.c3b(212, 226, 242))
			var_29_6:setName("label")
			var_29_6:setAnchorPoint(cc.p(0, 0.5))

			var_29_3[#var_29_3 + 1] = var_29_6

			var_29_1:addChild(var_29_6, 99)

			local var_29_7 = ccui.ImageView:create(arg_29_0[iter_29_0].icon, var_0_28)

			var_29_7:setScale(var_29_5)
			var_29_7:setAnchorPoint(cc.p(1, 0.5))
			var_29_7:setName("icon")

			var_29_4[#var_29_4 + 1] = var_29_7

			var_29_1:addChild(var_29_7, 99)

			if var_29_2 < var_29_6:getContentSize().width + var_29_7:getContentSize().width * var_29_5 then
				var_29_2 = var_29_6:getContentSize().width + var_29_7:getContentSize().width * var_29_5
			end
		end

		local var_29_8 = var_29_3[1]:getContentSize().height
		local var_29_9 = var_29_2

		if var_29_9 > 320 then
			var_29_1:setContentSize(cc.size(var_29_9 + 50, #arg_29_0 < 3 and 67 or 104 + (#arg_29_0 - 2) * 20))
		else
			var_29_1:setContentSize(cc.size(340, #arg_29_0 < 3 and 67 or 104 + (#arg_29_0 - 2) * 20))
		end

		if #var_29_3 == 1 then
			var_29_4[1]:setPosition(cc.p(var_29_1:getContentSize().width - 5, var_29_1:getContentSize().height / 2))
			var_29_3[1]:setPosition(cc.p(var_29_1:getContentSize().width - 10 - var_29_4[1]:getContentSize().width * var_29_5, var_29_1:getContentSize().height / 2))
		elseif #var_29_3 % 2 == 1 then
			for iter_29_1 = 1, #var_29_3 do
				var_29_4[iter_29_1]:setPosition(cc.p(var_29_1:getContentSize().width - 5, var_29_1:getContentSize().height / 2 + var_29_8 - (iter_29_1 - math.floor(#var_29_3 / 2)) * (var_29_8 + 3)))
				var_29_3[iter_29_1]:setPosition(cc.p(var_29_1:getContentSize().width - 10 - var_29_4[iter_29_1]:getContentSize().width * var_29_5, var_29_1:getContentSize().height / 2 + var_29_8 - (iter_29_1 - math.floor(#var_29_3 / 2)) * (var_29_8 + 3)))
			end
		elseif #var_29_3 % 2 == 0 then
			for iter_29_2 = 1, #var_29_3 do
				var_29_4[iter_29_2]:setPosition(cc.p(var_29_1:getContentSize().width - 5, var_29_1:getContentSize().height / 2 + var_29_8 / 2 - (iter_29_2 - #var_29_3 / 2) * (var_29_8 + 3)))
				var_29_3[iter_29_2]:setPosition(cc.p(var_29_1:getContentSize().width - 10 - var_29_4[iter_29_2]:getContentSize().width * var_29_5, var_29_1:getContentSize().height / 2 + var_29_8 / 2 - (iter_29_2 - #var_29_3 / 2) * (var_29_8 + 3)))
			end
		end

		var_29_0.show = var_0_30
		var_29_0.hide = var_0_31

		var_29_0:addChild(var_29_1)

		return var_29_0
	end)(var_28_1)
	local var_28_9 = var_28_8:getChildByName("bg")

	var_28_8:setPosition(cc.p(0, var_28_3 + (var_28_9:getContentSize().height > 90 and var_28_9:getContentSize().height - 90 or 0)))
	self.battlefieldStatusInfo:addChild(var_28_8)
	var_28_6:setPosition(18, var_28_9:getContentSize().height / 2)
	var_28_8:show(var_28_4, var_28_5, var_28_6)
	var_28_9:addChild(var_28_6, 99)
	var_28_8:show(0, nil, var_28_6)
	var_28_6:setRotation(0)
	var_28_9:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_28_6:getRotation() == 180 then
			var_28_8:show(0, nil, var_28_6)
			var_28_6:setRotation(0)
		else
			var_28_8:hide(0)
			var_28_6:setRotation(180)
		end
	end)
end

function AutoChessSelectLayer:initTeamSkillInfoPanel()
	local var_31_0 = "FightLayer/battlefield_status_bg.png"

	self.teamSkillInfo = cc.Node:create()

	self.teamSkillInfo:setPosition(cc.p(0, 420))
	self.listBg:addChild(self.teamSkillInfo, 99)

	function self.teamSkillInfo:updateTeamSkillStatusInfo()
		if #self == 0 then
			self.teamSkillInfo:setVisible(false)

			return
		else
			self.teamSkillInfo:setVisible(true)
		end

		self.teamSkillInfo:setPosition(cc.p(0, 420 + 30 * math.max(#self - 2, 0)))

		local var_33_0 = self.teamSkillInfo:getChildByName("teamSkillNode"):getChildByName("bg")
		local var_33_1 = 0
		local var_33_2 = {}
		local var_33_3 = {}
		local var_33_4 = 0.3

		for iter_33_0 = 1, 10 do
			local var_33_5 = var_33_0:getChildByName("label" .. iter_33_0)

			if var_33_5 then
				var_33_5:removeFromParent()
				var_33_0:getChildByName("icon" .. iter_33_0):removeFromParent()
			else
				break
			end
		end

		for iter_33_1 = 1, math.max(#self) do
			local var_33_6 = cc.Label:createWithTTF(self[iter_33_1].des, FONT_DES, 20)

			var_33_6:setScaleX(-1)
			var_33_6:setAnchorPoint(cc.p(0, 0.5))
			var_33_6:setColor(cc.c3b(212, 226, 242))
			var_33_6:setName("label" .. iter_33_1)
			var_33_6:setAnchorPoint(cc.p(0, 0.5))

			var_33_2[#var_33_2 + 1] = var_33_6

			var_33_0:addChild(var_33_6, 99)

			local var_33_7 = ccui.ImageView:create(self[iter_33_1].icon, var_0_28)

			var_33_7:setScale(var_33_4)
			var_33_7:setAnchorPoint(cc.p(1, 0.5))
			var_33_7:setName("icon" .. iter_33_1)

			var_33_3[#var_33_3 + 1] = var_33_7

			var_33_0:addChild(var_33_7, 99)

			if var_33_1 < var_33_6:getContentSize().width + var_33_7:getContentSize().width * var_33_4 then
				var_33_1 = var_33_6:getContentSize().width + var_33_7:getContentSize().width * var_33_4
			end
		end

		local var_33_8 = var_33_2[1]:getContentSize().height
		local var_33_9 = var_33_1

		if var_33_9 > 320 then
			var_33_0:setContentSize(cc.size(var_33_9 + 50, #self < 3 and 67 or 104 + (#self - 2) * 20))
		else
			var_33_0:setContentSize(cc.size(340, #self < 3 and 67 or 104 + (#self - 2) * 20))
		end

		if #var_33_2 == 1 then
			var_33_3[1]:setPosition(cc.p(var_33_0:getContentSize().width - 5, var_33_0:getContentSize().height / 2))
			var_33_2[1]:setPosition(cc.p(var_33_0:getContentSize().width - 10 - var_33_3[1]:getContentSize().width * var_33_4, var_33_0:getContentSize().height / 2))
		elseif #var_33_2 % 2 == 1 then
			for iter_33_2 = 1, #var_33_2 do
				var_33_3[iter_33_2]:setPosition(cc.p(var_33_0:getContentSize().width - 5, var_33_0:getContentSize().height / 2 + var_33_8 - (iter_33_2 - math.floor(#var_33_2 / 2)) * (var_33_8 + 3)))
				var_33_2[iter_33_2]:setPosition(cc.p(var_33_0:getContentSize().width - 10 - var_33_3[iter_33_2]:getContentSize().width * var_33_4, var_33_0:getContentSize().height / 2 + var_33_8 - (iter_33_2 - math.floor(#var_33_2 / 2)) * (var_33_8 + 3)))
			end
		elseif #var_33_2 % 2 == 0 then
			for iter_33_3 = 1, #var_33_2 do
				var_33_3[iter_33_3]:setPosition(cc.p(var_33_0:getContentSize().width - 5, var_33_0:getContentSize().height / 2 + var_33_8 / 2 - (iter_33_3 - #var_33_2 / 2) * (var_33_8 + 3)))
				var_33_2[iter_33_3]:setPosition(cc.p(var_33_0:getContentSize().width - 10 - var_33_3[iter_33_3]:getContentSize().width * var_33_4, var_33_0:getContentSize().height / 2 + var_33_8 / 2 - (iter_33_3 - #var_33_2 / 2) * (var_33_8 + 3)))
			end
		end
	end

	local var_31_1 = {}

	for iter_31_0, iter_31_1 in ipairs((self:getTeamskillInfo())) do
		table.insert(var_31_1, {
			icon = "FightLayer/map_icon.png",
			des = iter_31_1
		})
	end

	local var_31_3 = 0
	local var_31_4 = 0.5
	local var_31_5 = 3
	local var_31_6 = ccui.Button:create("FightLayer/btn_show_info.png", nil, "FightLayer/btn_show_info.png", var_0_28)

	var_31_6:setName("bntShowInfo")
	var_31_6:setSwallowTouches(false)

	local var_31_8 = (function(arg_32_0)
		local var_32_0 = cc.Node:create()
		local var_32_1 = ccui.ImageView:create(var_31_0, var_0_28)

		var_32_1:setScale9Enabled(true)
		var_32_1:setScaleX(-1)
		var_32_1:setAnchorPoint(cc.p(1, 0.5))
		var_32_1:setName("bg")
		var_32_1:setPosition(cc.p(-var_32_1:getContentSize().width, 0))
		var_32_1:setTouchEnabled(true)

		var_32_0.show = var_0_30
		var_32_0.hide = var_0_31

		var_32_0:addChild(var_32_1)
		var_32_0:setName("teamSkillNode")

		return var_32_0
	end)(var_31_1)
	local var_31_9 = var_31_8:getChildByName("bg")

	var_31_8:setPosition(cc.p(0, var_31_3 + (var_31_9:getContentSize().height > 90 and var_31_9:getContentSize().height - 90 or 0)))
	self.teamSkillInfo:addChild(var_31_8)
	var_31_6:setPosition(18, var_31_9:getContentSize().height / 2)
	var_31_8:show(var_31_4, var_31_5, var_31_6)
	var_31_9:addChild(var_31_6, 99)
	var_31_8:show(0, nil, var_31_6)
	var_31_6:setRotation(0)
	var_31_9:addTouchEventListener(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_31_6:getRotation() == 180 then
			var_31_8:show(0, nil, var_31_6)
			var_31_6:setRotation(0)
		else
			var_31_8:hide(0)
			var_31_6:setRotation(180)
		end
	end)
end

function AutoChessSelectLayer:initList()
	self.scrollView = ccui.ScrollView:create()

	self.scrollView:setContentSize(cc.size(var_0_22, var_0_23))
	self.scrollView:setBounceEnabled(true)
	self.scrollView:setDirection(ccui.ScrollViewDir.horizontal)
	self.scrollView:setPosition(20, 50)
	self.listBg:addChild(self.scrollView)
	self:updateList()
end

function AutoChessSelectLayer:updateList()
	self.scrollView:removeAllChildren()
	self.scrollView:setInnerContainerSize(cc.size(math.ceil(#self.curRoleList / 2) * var_0_20 + 20, var_0_23))

	for iter_36_0, iter_36_1 in ipairs(self.curRoleList) do
		local var_36_0 = self:createSp(iter_36_0)

		self:updateSp(var_36_0)
		var_36_0:setPosition((math.ceil(iter_36_0 / 2) - 1) * var_0_20, iter_36_0 % 2 == 0 and 10 or var_36_0:getContentSize().height + 20)
		var_36_0:setName("sp" .. iter_36_0)
		var_36_0:setTag(var_36_0.index)
		self.scrollView:addChild(var_36_0)
	end
end

function AutoChessSelectLayer:initBottom()
	local var_37_0 = ccui.ImageView:create("TowerDefenceListPanel/tips.png", var_0_28)

	var_37_0:setAnchorPoint(cc.p(0, 0))
	var_37_0:setPosition(0, -10)
	self.listBg:addChild(var_37_0)

	self.attrView = ccui.ScrollView:create()

	self.attrView:setContentSize(cc.size(640, 60))
	self.attrView:setInnerContainerSize(cc.size(75 * #self.attrList, 60))
	self.attrView:setDirection(ccui.ScrollViewDir.horizontal)
	self.attrView:setPosition(var_37_0:getContentSize().width, -10)
	self.listBg:addChild(self.attrView)

	for iter_37_0, iter_37_1 in ipairs(self.attrList) do
		local var_37_1

		if iter_37_1 == self.curSelectType then
			var_37_1 = "TowerDefenceListPanel/" .. iter_37_1 .. "_on.png" or "TowerDefenceListPanel/" .. iter_37_1 .. "_off.png"
		end

		local var_37_2 = ccui.Button:create(var_37_1, nil, var_37_1, var_0_28)

		var_37_2:setAnchorPoint(cc.p(0, 0))
		var_37_2:setPosition((iter_37_0 - 1) * var_37_2:getContentSize().width, 0)
		var_37_2:setName(iter_37_1)
		self.attrView:addChild(var_37_2)
		var_37_2:addTouchEventListener(function(arg_38_0, arg_38_1)
			if arg_38_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:switchSelect(iter_37_1)
		end)
	end
end

function AutoChessSelectLayer:createSp(arg_39_1)
	local var_39_0 = self.curRoleList[arg_39_1].index
	local var_39_1 = self.curRoleList[arg_39_1].servantid
	local var_39_2 = TempWidget:CreateTempBtn("TowerDefenceListPanel/role_bg2.png", nil, var_0_28)

	var_39_2:loadTexturePressed("TowerDefenceListPanel/role_bg2.png", var_0_28)
	var_39_2:loadTextureDisabled("TowerDefenceListPanel/role_bg2.png", var_0_28)
	var_39_2:setAnchorPoint(0, 0)
	var_39_2:setSwallowTouches(false)

	local var_39_3 = ccui.ImageView:create(ROLE_PORTRAIT_PATH .. model_data[servant_data[self.curRoleList[arg_39_1].servantid].modelid].portrait_image .. ".png")

	var_39_3:setScale(0.9)
	var_39_3:setPosition(var_39_2:getContentSize().width / 2, var_39_2:getContentSize().height / 2)
	var_39_2:addChild(var_39_3, 1)

	local var_39_4 = ccui.ImageView:create("TowerDefenceListPanel/cost_bg.png", var_0_28)

	var_39_4:setAnchorPoint(cc.p(0, 0))
	var_39_4:setPosition(5, 0)
	var_39_2:addChild(var_39_4, 3)

	local var_39_5 = cc.Label:createWithTTF("", FONT_W5, 26)

	var_39_5:setAnchorPoint(cc.p(1, 0))
	var_39_5:setColor(cc.c3b(250, 255, 170))
	var_39_5:setPosition(var_39_4:getContentSize().width - 5, -2)
	var_39_4:addChild(var_39_5)

	local var_39_6 = cc.Label:createWithTTF("", FONT_NAME, 16)

	var_39_6:setAnchorPoint(cc.p(0, 0))
	var_39_6:setPosition(0, 0)
	var_39_4:addChild(var_39_6)

	local var_39_7 = ccui.ImageView:create("TowerDefenceListPanel/selected_frame.png", var_0_28)

	var_39_7:setPosition(var_39_2:getContentSize().width / 2, var_39_2:getContentSize().height / 2)
	var_39_2:addChild(var_39_7, 5)
	var_39_2:_addSuperEvent(function(arg_40_0, arg_40_1, arg_40_2)
		if arg_40_0 == TempWidget.Click then
			local var_40_0 = arg_40_1:getTouchBeganPosition()

			if not isContainPosOfConvexPolygon(var_0_26, (arg_40_1:convertToNodeSpace((arg_40_1:getTouchEndPosition())))) then
				return
			end

			self:roleSpEventFunc(var_39_0)
		elseif arg_40_0 == TempWidget.Press then
			LayerManager:pushInLayer("EquipLayer", {
				showtype = SHOW_TYPE_DROP_PREVIEW,
				cursoul = var_39_1,
				exitCallback = function(...)
					if var_0_29 then
						self:updateList()
					end
				end
			})
		end
	end)

	for iter_39_0 = 1, 6 do
		local var_39_8 = ccui.ImageView:create("public/rolebg/star1.png", var_0_28)

		var_39_8:setPositionX(92 + 3 * iter_39_0)
		var_39_8:setPositionY(-3 + 12 * iter_39_0)
		var_39_8:setName("starImg" .. iter_39_0)
		var_39_8:setVisible(false)
		var_39_2:addChild(var_39_8, 200)
	end

	var_39_2.index = self.curRoleList[arg_39_1].index
	var_39_2.servantid = self.curRoleList[arg_39_1].servantid
	var_39_2.costBg = var_39_4
	var_39_2.costNum = var_39_5
	var_39_2.roleLv = var_39_6
	var_39_2.selectedLogo = var_39_7
	var_39_2.star = self.curRoleList[arg_39_1].star

	return var_39_2
end

function AutoChessSelectLayer:updateSp(arg_42_1)
	local var_42_1 = not not self.selectedList[arg_42_1.index]

	arg_42_1:loadTextures("TowerDefenceListPanel/" .. ((self.selectedList[arg_42_1.index] and true or false) and "role_bg2.png" or "role_bg1.png"), "TowerDefenceListPanel/" .. ((self.selectedList[arg_42_1.index] and true or false) and "role_bg2.png" or "role_bg1.png"), "TowerDefenceListPanel/" .. ((self.selectedList[arg_42_1.index] and true or false) and "role_bg2.png" or "role_bg1.png"), var_0_28)
	arg_42_1.selectedLogo:setVisible(var_42_1)

	for iter_42_0 = 1, arg_42_1.star do
		arg_42_1:getChildByName("starImg" .. iter_42_0):setVisible(true)
	end
end

function AutoChessSelectLayer:roleSpEventFunc(arg_43_1)
	if self.roleSpTouchLock then
		return
	end

	if self.selectedList[arg_43_1] then
		self.selectedList[arg_43_1] = nil

		self:removeRoleSpine(arg_43_1)
	elseif table.nums(self.selectedList) < var_0_25 then
		self.selectedList[arg_43_1] = true

		self:addRoleSpine(arg_43_1)
	else
		global_ShowBlockWords("可上阵已满")
	end

	self:updatelimitLabel()
	self.teamSkillInfo.updateTeamSkillStatusInfo(self:getTeamskillInfo())

	local var_43_1 = self.scrollView:getChildByTag(arg_43_1)

	if var_43_1 then
		self:updateSp(var_43_1)
	end
end

function AutoChessSelectLayer:switchSelect(arg_44_1)
	if self.roleSpTouchLock then
		return
	end

	if self.curSelectType == arg_44_1 then
		return
	end

	self.curSelectType = arg_44_1

	for iter_44_0, iter_44_1 in pairs(self.attrView:getChildren()) do
		local var_44_0 = iter_44_1:getName()

		if var_44_0 == self.curSelectType then
			iter_44_1:loadTextures("TowerDefenceListPanel/" .. var_44_0 .. "_on.png", nil, "TowerDefenceListPanel/" .. var_44_0 .. "_on.png", var_0_28)
		else
			iter_44_1:loadTextures("TowerDefenceListPanel/" .. var_44_0 .. "_off.png", nil, "TowerDefenceListPanel/" .. var_44_0 .. "_off.png", var_0_28)
		end
	end

	self:updateRoleListData()
	self:updateList()
end

function AutoChessSelectLayer:sureEventFunc()
	if self.roleSpTouchLock then
		return
	end

	if next(self.selectedList) == nil then
		return global_ShowBlockWords(L_TOWER_DEFENCE_SELECT_ERROR)
	end

	if table.nums(self.selectedList) > var_0_25 then
		global_ShowBlockWords(L_TOWER_DEFENCE_SELECT_ERROR2)

		return
	end

	local var_45_0 = {}

	for iter_45_0, iter_45_1 in pairs(self.selectedList) do
		table.insert(var_45_0, {
			servantid = self.allRoleDatas[iter_45_0].servantid,
			star = self.allRoleDatas[iter_45_0].star
		})
	end

	activity_manager:activity_autochess_set_array(self.activityId, var_45_0)

	if self.sureCallback then
		self.sureCallback(var_45_0)
	end
end

function AutoChessSelectLayer:initEnemySpine()
	local var_46_0 = {
		[4] = cc.p(560, -50 + 80 * 3),
		[8] = cc.p(560 - 100, -50 + 80 * 3),
		[3] = cc.p(560, -50 + 80 * 2),
		[6] = cc.p(560 - 100, -50 + 80 * 2),
		[2] = cc.p(560, -50 + 80),
		[5] = cc.p(560 - 100, -50 + 80),
		cc.p(560, -50),
		[7] = cc.p(560 - 100, -50)
	}
	local var_46_1 = {
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

	local var_46_2 = {}

	local function var_46_3(arg_47_0)
		for iter_47_0 = 1, 10 do
			if not var_46_2[iter_47_0] then
				return iter_47_0
			end
		end
	end

	for iter_46_0, iter_46_1 in ipairs(self.enemyList) do
		if iter_46_0 <= #var_46_0 then
			self:runAction(cc.Sequence:create(cc.DelayTime:create((iter_46_0 - 1) * 0.01), cc.CallFunc:create(function()
				local var_48_0 = var_46_3(iter_46_1)
				local var_48_2 = L2Skeleton:create(ROLE_SPINE_PATH .. model_data[iter_46_1].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[iter_46_1].spine_model .. ".atlas", (model_data[iter_46_1].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[iter_46_1].clothes_model .. ".atlas" or nil))

				var_48_2._modelid = iter_46_1

				self:addSkeletonDownloadInterface(var_48_2)
				var_48_2:showLoadingAni(true)
				var_48_2:refreshSkeleton()

				local var_48_3 = model_data[iter_46_1].modelscale or 1

				var_48_2:setScale(var_0_24 * -1 * var_48_3 * (model_data[iter_46_1].modelflip or 1) * 0.8, var_0_24 * var_48_3 * 0.8)
				var_48_2:play("idle")
				var_48_2:setRotation(math.random(-120, 120))
				var_48_2:setPosition(var_46_0[var_48_0].x + math.random(-10, 10), 1000)
				self.map:addChild(var_48_2, var_46_1[var_48_0])

				var_46_2[var_48_0] = true
				self.enemySkeletons[var_48_0] = var_48_2

				var_48_2:runAction(cc.Sequence:create(cc.DelayTime:create(iter_46_0 * math.random(1, 5) * 0.04), cc.EaseExponentialIn:create(cc.MoveTo:create(0.8, cc.p(var_48_2:getPositionX(), var_46_0[var_48_0].y))), cc.Spawn:create(cc.JumpTo:create(0.5, var_46_0[var_48_0], math.random(2, 4) * 10, 2), cc.RotateTo:create(0.5, 0))))
			end)))
		end
	end
end

function AutoChessSelectLayer:getAddRolePosIndex(arg_49_1)
	if model_data[arg_49_1].career == "tank" or model_data[arg_49_1].career == "fighter" then
		-- block empty
	elseif model_data[arg_49_1].career == "shotter" or model_data[arg_49_1].career == "assassin" then
		for iter_49_0 = 7, 1, -1 do
			if not self.skeletonList[iter_49_0] then
				return iter_49_0
			end
		end
	elseif model_data[arg_49_1].career == "support" or model_data[arg_49_1].career == "witcher" then
		for iter_49_1 = 1, 10 do
			if not self.skeletonList[iter_49_1] then
				return iter_49_1
			end
		end
	end

	for iter_49_2 = 10, 1, -1 do
		if not self.skeletonList[iter_49_2] then
			return iter_49_2
		end
	end
end

function AutoChessSelectLayer:getPlayerFirstNullPos()
	local var_50_0 = {}

	for iter_50_0 = 1, 10 do
		for iter_50_1, iter_50_2 in pairs(self.skeletonList) do
			if iter_50_2.pos_idx == iter_50_0 then
				var_50_0[iter_50_0] = true
			end
		end

		if not var_50_0[iter_50_0] then
			return iter_50_0
		end
	end

	return 1
end

function AutoChessSelectLayer:addRoleSpine(arg_51_1)
	local var_51_0 = {
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
	local var_51_1 = {
		6,
		4,
		2,
		7,
		5,
		3,
		1,
		6,
		4,
		2
	}
	local var_51_2 = global_get_servant_skin((self:get_servant_by_index(arg_51_1)))
	local var_51_3 = self:getPlayerFirstNullPos()
	local var_51_5 = model_data[var_51_2].modelweight
	local var_51_6 = model_data[var_51_2].modelheight
	local var_51_7 = L2Skeleton:create(ROLE_SPINE_PATH .. model_data[var_51_2].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_51_2].spine_model .. ".atlas", (model_data[var_51_2].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_51_2].clothes_model .. ".atlas" or nil))

	var_51_7._modelid = var_51_2

	self:addSkeletonDownloadInterface(var_51_7)
	var_51_7:showLoadingAni(true)
	var_51_7:refreshSkeleton()

	local var_51_8 = model_data[var_51_2].modelscale or 1

	var_51_7:setScale(var_0_24 * var_51_8 * (model_data[var_51_2].modelflip or 1), var_0_24 * var_51_8)

	var_51_7.pos_idx = var_51_3

	var_51_7:play("win", false)
	var_51_7:addAnimation("idle")
	var_51_7:setPosition(var_51_0[var_51_3])
	self.map:addChild(var_51_7, var_51_1[var_51_3])
	self.debutEffect:setVisible(true)
	self.debutEffect:setPosition(var_51_0[var_51_3].x, var_51_0[var_51_3].y + 40)
	self.debutEffect:play("chuchang", false)
	self.debutEffect:setLocalZOrder(var_51_1[var_51_3])
	GlobalPlayRoleSound(var_51_2, ROLE_SOUND_TYPE.fight)

	local var_51_9 = ccui.Layout:create()

	var_51_9:setTouchEnabled(true)
	var_51_9:setAnchorPoint(cc.p(0.5, 0))
	var_51_9:setPosition(0, 0)
	var_51_9:setContentSize(cc.size(var_51_5, var_51_6))
	var_51_7:addChild(var_51_9)
	var_51_9:addTouchEventListener(function(arg_52_0, arg_52_1)
		if arg_52_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.roleSpTouchLock then
			return
		end

		if arg_52_0.isLock then
			return
		end

		arg_52_0.isLock = true

		self:runAction(cc.CallFunc:create(function()
			self:roleSpEventFunc(arg_51_1)
		end))
	end)

	self.skeletonList[arg_51_1] = var_51_7
end

function AutoChessSelectLayer:removeRoleSpine(arg_54_1)
	self.skeletonList[arg_54_1]:removeFromParent()

	self.skeletonList[arg_54_1] = nil
end

local var_0_32 = "default/default.json"
local var_0_33 = "default/default.atlas"

function AutoChessSelectLayer.addSkeletonDownloadInterface(arg_55_0, arg_55_1)
	local file_check_manager = require("controller.filedownloader.file_check_manager")

	function arg_55_1:checkResource(arg_56_1)
		self._downloadinglist = {}
		self._downloadimg = arg_56_1

		if not arg_56_1 then
			self:onDownloadComplete(arg_56_1)

			return
		end

		local var_56_0 = file_check_manager:checkBattleSpineByModel(self._modelid)

		if #var_56_0 > 0 then
			self:onDownloadComplete({
				json = var_0_32,
				atlas = var_0_33
			})
			self:onDownloadProcessing()
			self:startDownload(var_56_0)
		else
			self:onDownloadComplete(arg_56_1)
		end
	end
end

function AutoChessSelectLayer:get_servant_by_index(arg_57_1)
	for iter_57_0, iter_57_1 in pairs(self.allRoleDatas) do
		if arg_57_1 == iter_57_1.index then
			return iter_57_1.servantid
		end
	end

	assert(false, "All Role Datas Error")
end

function AutoChessSelectLayer:initAutoChessChoose()
	self.autoChessChooseSprite = AutoChessChooseSprite:create(self.activityId)

	self.autoChessChooseSprite:setPosition(320, 300)
	self:addChild(self.autoChessChooseSprite)
	self.autoChessChooseSprite.confirmPanel:setPositionY(self.autoChessChooseSprite.confirmPanel:getPositionY() - 200)
end

function AutoChessSelectLayer:initselectByArray()
	local var_59_0 = {}

	for iter_59_0, iter_59_1 in pairs((activity_manager:getAutoChessArray(self.activityId))) do
		for iter_59_2, iter_59_3 in pairs(self.allRoleDatas) do
			if not var_59_0[iter_59_2] and iter_59_1.id == iter_59_3.servantid and iter_59_1.star == iter_59_3.star then
				var_59_0[iter_59_2] = true

				self:roleSpEventFunc(iter_59_2)
			end
		end
	end

	local var_59_1 = activity_manager:getAutoChessServantList(self.activityId)

	if not var_59_1 or not next(var_59_1) then
		self.autoChessChooseSprite:update()
		self.autoChessChooseSprite:show()
	end
end

function AutoChessSelectLayer:getTeamskillInfo()
	local var_60_0 = {}

	for iter_60_0, iter_60_1 in pairs(self.selectedList) do
		table.insert(var_60_0, {
			servantid = self.allRoleDatas[iter_60_0].servantid,
			star = self.allRoleDatas[iter_60_0].star
		})
	end

	local var_60_1 = {}

	for iter_60_2, iter_60_3 in ipairs(var_60_0) do
		table.insert(var_60_1, activity_manager:createAutoChessServant(iter_60_3))
	end

	local var_60_2 = {}

	for iter_60_4, iter_60_5 in ipairs((team_skill_manager:getTeamskillByConf(var_60_1))) do
		var_60_2[iter_60_4] = {
			icon = "FightLayer/map_icon.png",
			des = total_skill_data[iter_60_5.skillid].name
		}
	end

	return var_60_2
end
