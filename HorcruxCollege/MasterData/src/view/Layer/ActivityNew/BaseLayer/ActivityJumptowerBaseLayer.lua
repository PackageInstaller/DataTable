ActivityJumptowerBaseLayer = class("ActivityJumptowerBaseLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local network = require("network.network")
local var_0_3 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local total_skill_data = require("data.total_skill_data")

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Layer.BattleArrayLayerNew")

local TempWidget = require("view.Sprite.TempWidget")
local activity_manager = require("controller.activity_manager")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local monster_manager = require("controller.monster_manager")
local component_manager = require("controller.component_manager")
local horcrux_manager = require("controller.horcrux_manager")
local var_0_14 = require("controller.formation.formation_manager"):getInstance()
local levelmode_data = require("data.levelmode_data")
local var_0_16 = require("data.item_data")
local model_data = require("data.model_data")
local BonusPreview_data = require("data/BonusPreview_data")
local chapter_data = require("data.chapter_data")
local drop_data = require("data.drop_data")
local var_0_21 = {
	"adventurenewtowerlayer/changdi_1.png",
	"adventurenewtowerlayer/changdi_2.png",
	"adventurenewtowerlayer/changdi_3.png",
	"adventurenewtowerlayer/bai.png",
	"adventurenewtowerlayer/changdi_4.png"
}
local var_0_22 = {
	"adventurenewtowerlayer/namedi_1.png",
	"adventurenewtowerlayer/namedi_2.png",
	"adventurenewtowerlayer/bigboss_namedi.png"
}
local var_0_23 = {
	"adventurenewtowerlayer/bossinfo_1.png",
	"adventurenewtowerlayer/bossinfo_2.png",
	"adventurenewtowerlayer/bossinfo_3.png"
}
local var_0_24 = "adventurenewtowerlayer/getawrad.png"
local var_0_25 = {
	"adventurenewtowerlayer/bigboss_di.png",
	"adventurenewtowerlayer/bigboss_di1.png",
	"adventurenewtowerlayer/bigboss_tou3.png",
	"adventurenewtowerlayer/bigboss_tou4.png"
}
local var_0_26 = {
	"adventurenewtowerlayer/frame1.png",
	"adventurenewtowerlayer/frame2.png",
	"adventurenewtowerlayer/frame3.png"
}
local var_0_27 = 630
local var_0_28 = 192

function ActivityJumptowerBaseLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityJumptowerBaseLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityJumptowerBaseLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AdventureNewTowerLayer.json" or "AdventureNewTowerLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.activityId = arg_3_1.activityId

	self:initUI()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityJumptowerBaseLayer")
		end
	end)
	activity_manager:get_activity_jumptower_info(self.activityId)
end

function ActivityJumptowerBaseLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("ActivityJumptowerBaseLayer", activity_manager.activityEventId.JUMPTOWER_LIST_UPDATE, function(arg_6_0)
		arg_5_0.modetype = ACTIVITY_ID_TO_MODETYPE_FUNC.jump_tower(arg_5_0.activityId)
		arg_5_0.mode = arg_5_0.modetype * 10 + 1

		arg_5_0:getListData(arg_5_0.modetype)
	end)
end

function ActivityJumptowerBaseLayer:initUI()
	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.bg:loadTexture("mainScenebg/roledatabg.jpg")
	self.bg:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2))

	self.backdi = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bottom")

	self.backdi:setPosition(cc.p(320, 31))
	self.backdi:setZOrder(10000)

	self.back = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_23")

	self.back:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	local var_7_0 = ccui.ImageView:create("adventurenewtowerlayer/top.png", var_0_3)

	var_7_0:setAnchorPoint(cc.p(0.5, 1))
	var_7_0:setPosition(320, GameDisplay.height)
	self.rootLayer:addChild(var_7_0)

	local var_7_1 = ccui.ImageView:create("adventurenewtowerlayer/title.png", var_0_3)

	var_7_1:setAnchorPoint(cc.p(0, 0.5))
	var_7_1:setPosition(10, var_7_0:getContentSize().height / 2)
	var_7_0:addChild(var_7_1)

	local var_7_2 = ccui.ImageView:create("adventurenewtowerlayer/detail.png", var_0_3)

	var_7_2:setAnchorPoint(cc.p(0, 0.5))
	var_7_2:setPosition(145, var_7_0:getContentSize().height / 2)
	var_7_0:addChild(var_7_2)
	var_7_1:setTouchEnabled(true)
	var_7_1:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityJumptowerBase_" .. self.activityId
		})
	end)
	var_7_2:setTouchEnabled(true)
	var_7_2:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityJumptowerBase_" .. self.activityId
		})
	end)

	local var_7_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "auto_fight_bg")

	var_7_3:setVisible(false)

	local var_7_4 = TempWidget:CreateTempBtn("public/button/setting_btn_blue.png", var_7_3:getParent())

	var_7_4:align(cc.p(1, 0.5), var_7_3:getPositionX(), var_7_3:getPositionY())
	var_7_4:setScale(1)
	var_7_4:_addEvent(function()
		activity_manager:reset_jumptower(self.activityId)
	end)

	local var_7_5 = cc.Label:createWithTTF(L_SUBSTITUTION_RESET_TIP.title, FONT_DES, 22)

	var_7_5:setColor(cc.c3b(0, 0, 0))
	var_7_5:setPosition(cc.p(var_7_4:getContentSize().width / 2, var_7_4:getContentSize().height / 2))
	var_7_4:addChild(var_7_5)
	self.rootLayer:setContentSize((GameDisplay.getScreenSize()))
	self.rootLayer:setPositionY(self.rootLayer:getPositionY() - GameDisplay.fix_y)
end

function ActivityJumptowerBaseLayer:getListData(arg_12_1)
	self.res_element = levelmode_data[self.mode].ele_type_show or levelmode_data[self.mode].ele_type
	self.curlevel = activity_manager:getJumpTowerCurLevel(self.activityId)
	self.maxLevel = activity_manager:getJumpTowerMaxLevel(self.activityId)
	self.numchapter = levelmode_data[self.mode].totalchapter
	self.data = self:getData()

	self:initTableView()
end

function ActivityJumptowerBaseLayer:getData()
	local var_13_0 = {}

	for iter_13_0 = 1, level_manager:getModeTotalChapter(self.mode) do
		local var_13_1 = monster_manager.getLevelBoss(self.mode, iter_13_0 .. "-1")
		local var_13_2 = {
			bossmode = var_13_1.majorlist.modelid,
			layer = iter_13_0,
			item = self:getDropData((level_manager:getLevelDropID(self.mode, iter_13_0 .. "-1"))),
			isbigboss = var_13_1.isFinal
		}
		local var_13_3 = horcrux_manager:getMonsterHorcruxAssistConfig(var_13_1.majorlist)

		var_13_2.horcruxAffix = {}

		if var_13_3 then
			for iter_13_1, iter_13_2 in ipairs(var_13_3.skills) do
				var_13_2.horcruxAffix[iter_13_1] = {
					id = iter_13_2,
					name = total_skill_data[iter_13_2].name,
					des = string.format("%s。", total_skill_data[iter_13_2].description),
					icon = total_skill_data[iter_13_2].icon
				}
			end
		end

		var_13_2.status = iter_13_0 == self.curlevel and 2 or iter_13_0 > self.curlevel and 1 or 3

		if iter_13_0 < self.maxLevel then
			var_13_2.gotReward = true
		end

		var_13_2.array = activity_manager:getJumpTowerArrayByIndex(self.activityId, iter_13_0)
		var_13_0[iter_13_0] = var_13_2
	end

	return var_13_0
end

function ActivityJumptowerBaseLayer:createNode()
	local var_14_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "items"):clone()

	var_14_0:setTouchEnabled(false)

	local var_14_1 = ccui.ImageView:create("public/career_icon/restrain_tip_1.png", var_0_3)

	var_14_1:setName("restrainTip")
	var_14_1:setPosition(cc.p(118, 158))
	var_14_0:addChild(var_14_1)

	local var_14_2 = ccui.Layout:create()

	var_14_2:setContentSize(var_14_0:getContentSize())
	var_14_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_14_2:setAnchorPoint(0, 0)
	var_14_2:setPosition(cc.p(0, 0))
	var_14_2:setBackGroundColor(cc.c3b(0, 0, 0))
	var_14_2:setCascadeOpacityEnabled(false)
	var_14_2:setBackGroundColorOpacity(190)
	var_14_2:setName("usedServant")
	var_14_2:setVisible(false)
	var_14_0:addChild(var_14_2, 100)

	for iter_14_0 = 1, 5 do
		local var_14_3 = ccui.ImageView:create("public/box/material_red.png", var_0_3)

		var_14_3:setPosition(cc.p(-50 + 120 * iter_14_0, 75))
		var_14_3:setName("servantBg" .. iter_14_0)
		var_14_2:addChild(var_14_3)

		local var_14_4 = ccui.ImageView:create("public/box/material_red.png", var_0_3)

		var_14_4:setPosition(cc.p(var_14_3:getContentSize().width / 2, var_14_3:getContentSize().height / 2))
		var_14_4:setName("servantIcon" .. iter_14_0)
		var_14_4:setScale(0.5)
		var_14_3:addChild(var_14_4)
	end

	return var_14_0
end

function ActivityJumptowerBaseLayer:updateNode(arg_15_1, arg_15_2)
	local var_15_0 = ccui.Helper:seekWidgetByName(arg_15_1, "ani_1")
	local var_15_1 = ccui.Helper:seekWidgetByName(arg_15_1, "ani_2")
	local var_15_2 = ccui.Helper:seekWidgetByName(arg_15_1, "bossface")
	local var_15_3 = ccui.Helper:seekWidgetByName(arg_15_1, "name_di")
	local var_15_4 = ccui.Helper:seekWidgetByName(arg_15_1, "detail_btn")
	local var_15_5 = ccui.Helper:seekWidgetByName(arg_15_1, "ceshu")
	local var_15_6 = ccui.Helper:seekWidgetByName(arg_15_1, "change_btn")
	local var_15_7 = ccui.Helper:seekWidgetByName(arg_15_1, "usedServant")

	if arg_15_2.array and next(arg_15_2.array) then
		var_15_7:setVisible(true)

		for iter_15_0 = 1, 5 do
			local var_15_8 = ccui.Helper:seekWidgetByName(arg_15_1, "servantBg" .. iter_15_0)

			if arg_15_2.array[iter_15_0] then
				var_15_8:setVisible(true)
				ccui.Helper:seekWidgetByName(arg_15_1, "servantIcon" .. iter_15_0):loadTexture(ROLE_HEAD_IMAGE_PATH .. model_data[global_get_servant_skin(arg_15_2.array[iter_15_0])].head_image .. ".png")
			else
				var_15_8:setVisible(false)
			end
		end
	else
		var_15_7:setVisible(false)
	end

	var_15_5:setString("")
	var_15_4:setPositionY(115)
	var_15_4:setPositionX(307)

	if not arg_15_2.isbigboss then
		var_15_0:loadTexture("adventurenewtowerlayer/tou_1.png", var_0_3)
		var_15_1:loadTexture("adventurenewtowerlayer/tou_2.png", var_0_3)
	else
		var_15_0:loadTexture("adventurenewtowerlayer/bigboss_tou3.png", var_0_3)
		var_15_1:loadTexture("adventurenewtowerlayer/bigboss_tou4.png", var_0_3)
	end

	self:updataImage(arg_15_1, arg_15_2)
	var_15_4:setSwallowTouches(false)

	local var_15_9

	if arg_15_2.status == 1 then
		if arg_15_1:getChildByName("sucess") then
			arg_15_1:getChildByName("sucess"):removeFromParent()
		end

		if arg_15_1:getChildByName("bosssucess") then
			arg_15_1:getChildByName("bosssucess"):removeFromParent()
		end

		if not arg_15_2.isbigboss then
			arg_15_1:setBackGroundImage(var_0_21[2], var_0_3)
			var_15_4:loadTextures(var_0_23[2], nil, var_0_23[2], var_0_3)
			var_15_3:loadTexture(var_0_22[2], var_0_3)

			var_15_9 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_NOT_BOSS, arg_15_2.layer)
		else
			arg_15_1:setBackGroundImage(var_0_25[2], var_0_3)
			var_15_4:loadTextures(var_0_23[3], nil, var_0_23[3], var_0_3)
			var_15_3:loadTexture(var_0_22[3], var_0_3)

			var_15_9 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_15_2.layer)
		end

		var_15_3:setVisible(true)
		var_15_0:setVisible(false)
		var_15_1:setVisible(false)
		var_15_6:setVisible(false)
	elseif arg_15_2.status == 2 then
		if arg_15_1:getChildByName("bosssucess") then
			arg_15_1:getChildByName("bosssucess"):removeFromParent()
		end

		if not arg_15_2.isbigboss then
			arg_15_1:setBackGroundImage(var_0_21[1], var_0_3)
			var_15_4:loadTextures(var_0_23[1], nil, var_0_23[1], var_0_3)
			var_15_3:loadTexture(var_0_22[1], var_0_3)

			var_15_9 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_NOW, arg_15_2.layer)
		else
			arg_15_1:setBackGroundImage(var_0_25[1], var_0_3)
			var_15_4:loadTextures(var_0_23[3], nil, var_0_23[3], var_0_3)
			var_15_3:loadTexture(var_0_22[3], var_0_3)

			var_15_9 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_15_2.layer)
		end

		var_15_3:setVisible(true)
		var_15_0:setVisible(true)
		var_15_1:setVisible(true)
		var_15_6:setVisible(true)
		self:playain(arg_15_1)

		if var_15_5:getChildByName("richTextWord") then
			var_15_5:getChildByName("richTextWord"):removeFromParent()
		end

		local var_15_10 = require("view.Sprite.RichTextPro"):create()

		var_15_10:setMaxWidth(550)
		var_15_10:setSize(27)
		var_15_10:setLineSpace(0)
		var_15_10:setText(var_15_9, nil, true)
		var_15_10:setName("richTextWord")
		var_15_10:setPosition(cc.p((arg_15_2.layer >= 100 or nil) and -15, 40))
		var_15_5:addChild(var_15_10)
	elseif arg_15_2.status == 3 then
		if arg_15_1:getChildByName("sucess") then
			arg_15_1:getChildByName("sucess"):removeFromParent()
		end

		if arg_15_1:getChildByName("bosssucess") then
			arg_15_1:getChildByName("bosssucess"):removeFromParent()
		end

		local var_15_12 = ccui.ImageView:create("adventurenewtowerlayer/yitiaozhan.png", var_0_3)

		var_15_12:setScale(1)
		var_15_12:setAnchorPoint(cc.p(0.5, 0.5))
		var_15_12:setName("bosssucess")
		var_15_12:setPosition(cc.p(arg_15_1:getContentSize().width / 2 + 240, arg_15_1:getContentSize().height / 2 - 13))
		arg_15_1:addChild(var_15_12, 10000)

		if not arg_15_2.isbigboss then
			arg_15_1:setBackGroundImage(var_0_21[3], var_0_3)

			if arg_15_1:getChildByName("bosssucess") then
				arg_15_1:getChildByName("bosssucess"):removeFromParent()
			end

			var_15_3:loadTexture(var_0_22[2], var_0_3)

			var_15_9 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS_SUCCESS, arg_15_2.layer)
		else
			arg_15_1:setBackGroundImage(var_0_25[1], var_0_3)
			var_15_3:loadTexture(var_0_22[3], var_0_3)

			var_15_9 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_15_2.layer)
		end

		var_15_4:loadTextures(var_0_23[2], nil, var_0_23[2], var_0_3)
		var_15_0:setVisible(false)
		var_15_1:setVisible(false)
		var_15_6:setVisible(false)

		if var_15_5:getChildByName("richTextWord") then
			var_15_5:getChildByName("richTextWord"):removeFromParent()
		end

		local var_15_13 = require("view.Sprite.RichTextPro"):create()

		var_15_13:setMaxWidth(550)
		var_15_13:setSize(25)
		var_15_13:setLineSpace(0)
		var_15_13:setText(var_15_9, nil, true)
		var_15_13:setName("richTextWord")
		var_15_13:setPosition(cc.p((arg_15_2.layer >= 100 or nil) and -15, 40))
		var_15_5:addChild(var_15_13)
	end

	if var_15_9 then
		if var_15_5:getChildByName("richTextWord") then
			var_15_5:getChildByName("richTextWord"):removeFromParent()
		end

		local var_15_15 = require("view.Sprite.RichTextPro"):create()

		var_15_15:setMaxWidth(550)
		var_15_15:setSize(27)
		var_15_15:setLineSpace(0)
		var_15_15:setText(var_15_9, nil, true)
		var_15_15:setName("richTextWord")
		var_15_15:setPosition(cc.p((arg_15_2.layer >= 100 or nil) and -15, 40))
		var_15_5:addChild(var_15_15)
	end

	var_15_2:loadTextures("role1/" .. model_data[arg_15_2.bossmode].cute_role .. ".png", nil, "role1/" .. model_data[arg_15_2.bossmode].cute_role .. ".png")
	var_15_2:setScale(0.35)
	var_15_2:setTouchEnabled(true)
	var_15_2:setSwallowTouches(false)
	var_15_3:getChildByName("bossname"):setFontSize(20)
	var_15_3:getChildByName("bossname"):setString(model_data[arg_15_2.bossmode].name)
	var_15_2:setPositionY(110)
	var_15_6:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_15_2.status == 3 then
			return
		end

		self:dealChangeBtn(self.mode, arg_15_2.layer, callback)
	end)
	var_15_2:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_15_2.status == 3 then
			return
		end

		self:showBossInfo(self.mode, arg_15_2.layer, callback)
	end)

	local var_15_17 = arg_15_1:getChildByName("restrainTip")

	if self.res_element then
		var_15_17:setVisible(true)
		var_15_17:loadTexture("public/career_icon/restrain_tip_" .. ATTR_INDEX[self.res_element] .. ".png", var_0_3)
	else
		var_15_17:setVisible(false)
	end
end

function ActivityJumptowerBaseLayer.playain(arg_18_0, arg_18_1)
	arg_18_1:getChildByName("ani_1"):runAction(cc.RepeatForever:create(cc.RotateBy:create(6, -360)))
	arg_18_1:getChildByName("ani_2"):runAction(cc.RepeatForever:create(cc.RotateBy:create(6, 360)))
end

function ActivityJumptowerBaseLayer.updataImage(arg_19_0, arg_19_1, arg_19_2)
	local var_19_1 = {}

	if arg_19_2.item.items and #arg_19_2.item.items > 0 then
		for iter_19_0, iter_19_1 in ipairs(arg_19_2.item.items) do
			if iter_19_1.num and iter_19_1.num > 0 then
				table.insert(var_19_1, iter_19_1)
			end
		end
	end

	if arg_19_2.item.gold and arg_19_2.item.gold > 0 then
		table.insert(var_19_1, {
			itemid = "gold",
			num = arg_19_2.item.gold
		})
	end

	if arg_19_2.item.diamond and arg_19_2.item.diamond > 0 then
		table.insert(var_19_1, {
			itemid = "diamond",
			num = arg_19_2.item.diamond
		})
	end

	local var_19_2 = #var_19_1

	if #var_19_1 <= 0 then
		return
	end

	local var_19_4 = var_19_2 == 1 and 1 or var_19_2 == 2 and 2 or 3
	local var_19_5 = 1

	while arg_19_1:getChildByName("award" .. var_19_5) do
		arg_19_1:getChildByName("award" .. var_19_5):removeFromParent()

		if arg_19_1:getChildByName("zhezhao" .. var_19_5) then
			arg_19_1:getChildByName("zhezhao" .. var_19_5):removeFromParent()
		end

		var_19_5 = var_19_5 + 1
	end

	for iter_19_2 = 1, var_19_4 do
		local var_19_7 = type(var_19_1[iter_19_2].itemid) == "string" and ccui.Button:create("public/box/" .. "1" .. ".png", "public/box/" .. "1" .. ".png", nil, var_0_3) or ccui.Button:create("public/box/" .. var_0_16[var_19_1[iter_19_2].itemid].equip_quality .. ".png", "public/box/" .. var_0_16[var_19_1[iter_19_2].itemid].equip_quality .. ".png", nil, var_0_3)

		var_19_7:setAnchorPoint(cc.p(0.5, 0.5))
		var_19_7:setPosition(cc.p(0, 0))
		var_19_7:setTouchEnabled(true)
		var_19_7:setSwallowTouches(false)
		var_19_7:setPosition(cc.p(266 + (iter_19_2 - 1) * 90, 60))
		var_19_7:setName("award" .. iter_19_2)
		arg_19_1:addChild(var_19_7, 1)

		local var_19_8
		local var_19_9

		if var_19_1[iter_19_2].itemid == "gold" and var_19_1[iter_19_2].num > 0 then
			var_19_8 = "equipment/1000001.png"
		elseif var_19_1[iter_19_2].itemid == "diamond" and var_19_1[iter_19_2].num > 0 then
			var_19_8 = "equipment/1000000.png"
		elseif var_0_16[var_19_1[iter_19_2].itemid].image_id then
			var_19_8 = "equipment/" .. var_0_16[var_19_1[iter_19_2].itemid].image_id .. ".png"
		else
			var_19_9 = var_0_16[var_19_1[iter_19_2].itemid].bag_item_type == kITEM_MEDAL and ItemSprite:create_medal_icon(var_19_1[iter_19_2].itemid) or component_manager:create_component_icon(var_19_1[iter_19_2].itemid, nil, nil)
		end

		var_19_9 = var_19_9 or ccui.ImageView:create(var_19_8)

		var_19_9:setPosition(cc.p(var_19_7:getContentSize().width / 2, var_19_7:getContentSize().height / 2))
		var_19_7:addChild(var_19_9)
		var_19_9:setScale(66 / math.min(var_19_9:getContentSize().width, var_19_9:getContentSize().height))

		if arg_19_2.gotReward then
			local var_19_10 = ccui.ImageView:create(var_0_24, var_0_3)

			var_19_10:setPosition(cc.p(var_19_7:getContentSize().width / 2, var_19_7:getContentSize().height / 2 + 15))
			var_19_10:setTouchEnabled(false)
			var_19_10:setScale9Enabled(true)
			var_19_10:setCapInsets(cc.rect(0, 0, 40, 40))
			var_19_10:setContentSize(cc.size(85, 90))
			var_19_10:setName("zhezhao" .. iter_19_2)
			arg_19_1:addChild(var_19_10, 2)
		end

		local var_19_11 = cc.Label:createWithTTF("", FONT_DES, 16)

		var_19_11:setMaxLineWidth(190)
		var_19_11:setAnchorPoint(cc.p(0.5, 0.5))
		var_19_11:setString("x" .. var_19_1[iter_19_2].num)
		var_19_11:setPosition(cc.p(var_19_7:getContentSize().width / 2, var_19_7:getContentSize().height / 2 - 36))
		var_19_7:addChild(var_19_11)

		var_19_7.itemtype = "gold"

		if var_19_1[iter_19_2].itemid ~= "gold" and var_19_1[iter_19_2].itemid ~= "diamond" then
			var_19_7.itemtype = "item"
		end

		var_19_7:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_19_2.status == 3 then
				return
			end

			arg_19_0:showDetailsofItems(var_19_1[iter_19_2].itemid, var_19_7.itemtype)
		end)
	end

	if var_19_4 == 1 and arg_19_1:getChildByName("award" .. 1) then
		arg_19_1:getChildByName("award" .. 1):setPositionX(316)

		if arg_19_1:getChildByName("zhezhao" .. 1) then
			arg_19_1:getChildByName("zhezhao" .. 1):setPositionX(316)
		end
	end

	local var_19_12 = {
		266,
		356,
		445
	}

	if var_19_4 == 3 then
		for iter_19_3 = 1, 3 do
			if arg_19_1:getChildByName("award" .. iter_19_3) then
				arg_19_1:getChildByName("award" .. iter_19_3):setPositionX(var_19_12[iter_19_3] - 40)
			end

			if arg_19_1:getChildByName("zhezhao" .. iter_19_3) then
				arg_19_1:getChildByName("zhezhao" .. iter_19_3):setPositionX(var_19_12[iter_19_3] - 40)
			end
		end
	end

	local var_19_13 = {
		266,
		356
	}

	if var_19_4 == 2 then
		for iter_19_4 = 1, 2 do
			if arg_19_1:getChildByName("zhezhao" .. iter_19_4) then
				arg_19_1:getChildByName("zhezhao" .. iter_19_4):setPositionX(var_19_13[iter_19_4])
			end
		end
	end

	local var_19_14 = arg_19_2.horcruxAffix
	local var_19_16 = 1

	while arg_19_1:getChildByName("btnpanel_" .. var_19_16) do
		arg_19_1:getChildByName("btnpanel_" .. var_19_16):removeFromParent()

		var_19_16 = var_19_16 + 1
	end

	local var_19_17

	if arg_19_2.isbigboss then
		var_19_17 = var_0_26[3]
	elseif arg_19_2.status == 1 or arg_19_2.status == 3 then
		var_19_17 = var_0_26[2]
	elseif arg_19_2.status == 2 then
		var_19_17 = var_0_26[1]
	end

	for iter_19_5 = 1, 2 do
		local var_19_18 = ccui.Layout:create()

		var_19_18:setContentSize(cc.size(140, 36))
		var_19_18:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		var_19_18:setAnchorPoint(0.5, 0.5)
		var_19_18:setBackGroundColor(cc.c3b(0, 0, 0))
		var_19_18:setTouchEnabled(false)
		var_19_18:setName("btnpanel_" .. iter_19_5)
		var_19_18:setPosition(cc.p(arg_19_1:getContentSize().width / 2 - 50 + (iter_19_5 - 1) * 130, arg_19_1:getContentSize().height / 2 + 60))
		arg_19_1:addChild(var_19_18, 10)

		local var_19_19 = ccui.ImageView:create(var_19_17, var_0_3)

		var_19_19:setPosition(cc.p(var_19_18:getContentSize().width / 2 - 50, var_19_18:getContentSize().height / 2 - 3))
		var_19_18:addChild(var_19_19)
		var_19_19:setTouchEnabled(false)

		local var_19_20 = ccui.Button:create("skill_new/skill/" .. var_19_14[iter_19_5].icon .. ".png", "skill_new/skill/" .. var_19_14[iter_19_5].icon .. ".png", nil, var_0_3)

		var_19_20:setName("btnSkill_" .. iter_19_5)
		var_19_20:setPosition(cc.p(var_19_19:getContentSize().width / 2, var_19_19:getContentSize().height / 2))
		var_19_20:setScale((math.min(37 / var_19_20:getContentSize().width, 37 / var_19_20:getContentSize().height)))
		var_19_19:addChild(var_19_20)
		var_19_20:setTouchEnabled(true)
		var_19_20:setSwallowTouches(false)

		local var_19_21 = cc.Label:createWithTTF("1", FONT_DES, 20)

		var_19_21:setMaxLineWidth(190)
		var_19_21:setAnchorPoint(cc.p(0, 0.5))
		var_19_21:setString(var_19_14[iter_19_5].name)
		var_19_21:setPosition(cc.p(var_19_19:getPositionX() + 27, var_19_19:getPositionY()))
		var_19_18:addChild(var_19_21)
		var_19_20:addTouchEventListener(function(arg_21_0, arg_21_1)
			if arg_21_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_19_2.status == 3 then
				return
			end

			arg_19_0:showAwardInfo(arg_19_1, var_19_14[iter_19_5].name, var_19_14[iter_19_5].des, iter_19_5)
		end)
	end
end

function ActivityJumptowerBaseLayer:showAwardInfo(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	for iter_22_0 = 1, 2 do
		if iter_22_0 ~= arg_22_4 and arg_22_1:getChildByName("btnpanel_" .. iter_22_0) then
			arg_22_1:getChildByName("btnpanel_" .. iter_22_0):setZOrder(20)

			if arg_22_1:getChildByName("btnpanel_" .. iter_22_0):getChildByName("showskill") then
				arg_22_1:getChildByName("btnpanel_" .. iter_22_0):getChildByName("showskill"):removeFromParent()
			end
		end
	end

	local var_22_0 = arg_22_1:getChildByName("btnpanel_" .. arg_22_4)

	var_22_0:setZOrder(21)

	if var_22_0:getChildByName("showskill") then
		var_22_0:getChildByName("showskill"):removeFromParent()

		return
	end

	local var_22_1 = ccui.Layout:create()

	var_22_1:setContentSize(cc.size(260, 120))
	var_22_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_22_1:setAnchorPoint(0, 1)
	var_22_1:setPosition(cc.p(var_22_0:getPositionX() / 2 - arg_22_4 * 70, var_22_0:getPositionY() / 2 - 36))
	var_22_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_22_1:setCascadeOpacityEnabled(false)
	var_22_1:setBackGroundColorOpacity(190)
	var_22_1:setName("showskill")
	var_22_1:setTouchEnabled(true)
	var_22_1:setScale(0)
	var_22_0:addChild(var_22_1, 100)

	local var_22_2 = cc.Label:createWithTTF("1", FONT_DES, 22)

	var_22_2:setMaxLineWidth(190)
	var_22_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_22_2:setColor(cc.c3b(253, 211, 81))
	var_22_2:setPosition(cc.p(var_22_1:getContentSize().width / 2, var_22_1:getContentSize().height - 12))
	var_22_2:setName("Label1")
	var_22_2:setString(arg_22_2)
	var_22_1:addChild(var_22_2)

	local var_22_3 = cc.Label:createWithTTF("1", FONT_DES, 20)

	var_22_3:setMaxLineWidth(250)
	var_22_3:setAnchorPoint(cc.p(0, 1))
	var_22_3:setColor(cc.c3b(234, 232, 226))
	var_22_3:setPosition(cc.p(0, var_22_2:getPositionY() - var_22_2:getContentSize().height))
	var_22_3:setName("Label2")
	var_22_3:setString(arg_22_3)
	var_22_1:addChild(var_22_3)

	local var_22_4 = cc.EventListenerTouchOneByOne:create()

	var_22_4:setSwallowTouches(false)
	var_22_4:registerScriptHandler(function(arg_23_0, arg_23_1)
		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_22_4:registerScriptHandler(function(arg_24_0, arg_24_1)
		if var_22_0:getChildByName("showskill") then
			var_22_0:getChildByName("showskill"):removeFromParent()
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_22_4, var_22_1)
	var_22_1:runAction((cc.ScaleTo:create(0.2, 1)))
end

function ActivityJumptowerBaseLayer:initTableView()
	if self.roleTableView then
		self.roleTableView:reloadData()

		return
	end

	local var_25_0 = GameDisplay.getUiScreenSize().height - 63

	self.roleTableView = cc.TableView:create(cc.size(640, var_25_0))

	self.roleTableView:setPosition(cc.p(0, self.backdi:getPositionY() + self.backdi:getContentSize().height / 2 - 60))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

	self.roleTableViewhight = var_25_0

	self.roleTableView:registerScriptHandler(function(arg_27_0, arg_27_1)
		return var_0_27, var_0_28
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_26_0, arg_26_1)
		local var_26_0 = arg_26_0:dequeueCell()

		if not var_26_0 then
			var_26_0 = cc.TableViewCell:create()

			local var_26_1 = self:createNode()

			var_26_1:setName("node")
			var_26_1:setPosition(cc.p(5, 5))
			self:updateNode(var_26_1, self.data[arg_26_1 + 1])
			var_26_0:addChild(var_26_1)
		else
			self:updateNode(var_26_0:getChildByName("node"), self.data[arg_26_1 + 1])
		end

		return var_26_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_28_0, arg_28_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function ActivityJumptowerBaseLayer.showBossInfo(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = {
		fight_type = "ADVENTURE",
		level = 1,
		mode = arg_29_1,
		chapter = arg_29_2,
		callback = arg_29_3
	}

	var_29_0.initindex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)

	LayerManager:pushInLayer("LevelDetailLayer", var_29_0)
end

function ActivityJumptowerBaseLayer.showDetailsofItems(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_2 == "item" then
		if var_0_16[arg_30_1].bag_item_type == kITEM_HORCRUX then
			local var_30_1 = -1
			local horcrux_data = require("data.horcrux_data")

			for iter_30_0, iter_30_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if iter_30_1.model_id == horcrux_data[arg_30_1].model then
					var_30_1 = iter_30_0

					break
				end
			end

			if var_30_1 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_30_1,
				itemid = arg_30_1
			})
		elseif var_0_16[arg_30_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = var_0_16[arg_30_1].servant
			})
		else
			showItemDetails(arg_30_1)
		end
	end
end

function ActivityJumptowerBaseLayer.dealChangeBtn(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_1
	local var_31_1 = arg_31_2
	local var_31_2, var_31_3 = level_manager:isModeValid(arg_31_1)

	if not var_31_2 then
		audio_manager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(level_manager:getModeUnlockMsg(arg_31_1, var_31_3))

		return
	end

	local function var_31_4(arg_32_0)
		if arg_32_0 == 1 then
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			FightManager.refreshFightToType(FIGHTTYPE_ADVENTURE_TOWER)
		else
			if arg_32_0 == 2 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[2])
			elseif arg_32_0 == 3 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[3])
			elseif arg_32_0 == 4 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[4])
			elseif arg_32_0 == 5 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[5])
			elseif arg_32_0 == 6 then
				audio_manager:playeffectMusicTest("sound/invalid")

				if chapter_data["" .. var_31_0 .. "-" .. var_31_1] and chapter_data["" .. var_31_0 .. "-" .. var_31_1].boss_combat then
					global_ShowBlockWords(L_ADVENTURE_WARNING[6] .. chapter_data["" .. var_31_0 .. "-" .. var_31_1].boss_combat .. L_ADVENTURE_WARNING[7])
				end
			end

			GuideListener.showAllGuidesWithFullScreen(true)
		end
	end

	local function var_31_5(arg_33_0)
		GuideListener.showAllGuidesWithFullScreen(false)
		RoleDefault:getInstance():setIntegerForKey("adventurearray", arg_33_0)
		RoleDefault:getInstance():setIntegerForKey("lastadventurearray", arg_33_0)
		RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", arg_31_0.modetype)
		activity_manager:startJumpTower(var_31_0, var_31_1, var_31_4, arg_33_0)
	end

	LayerManager:pushInLayer("LevelDetailLayer", {
		fight_type = "ADVENTURE",
		level = 1,
		mode = arg_31_1,
		chapter = arg_31_2,
		callback = arg_31_3,
		adventuresurecallback = function()
			local var_34_0 = {
				mode = var_31_0
			}

			var_34_0.defaultIndex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
			var_34_0.configcallback = var_31_5
			var_34_0.exitcallback = arg_31_3

			var_0_14:pushFormationLayer("FormationJumptowerLayer", var_34_0)
		end,
		initindex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
	})
end

function ActivityJumptowerBaseLayer.getDropData(arg_35_0, arg_35_1)
	local var_35_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_35_1 = drop_data[arg_35_1] or {}

	if var_35_1.gold then
		var_35_0.gold = var_35_0.gold + var_35_1.gold
	end

	if var_35_1.diamond then
		var_35_0.diamond = var_35_0.diamond + var_35_1.diamond
	end

	local var_35_2 = 1

	if var_35_1["drop_id" .. 1] then
		local var_35_3 = 1

		while var_35_1["drop_id" .. var_35_3] do
			var_35_0.items[var_35_2] = {
				itemid = var_35_1["drop_id" .. var_35_3],
				num = var_35_1["drop_num" .. var_35_3]
			}
			var_35_3 = var_35_3 + 1
			var_35_2 = var_35_2 + 1
		end
	end

	if var_35_1["dropmodel_id" .. 1] then
		local var_35_4 = 1

		while var_35_1["dropmodel_id" .. var_35_4] do
			if drop_data[var_35_1["dropmodel_id" .. var_35_4]].gold then
				var_35_0.gold = var_35_0.gold + drop_data[var_35_1["dropmodel_id" .. var_35_4]].gold
			end

			if drop_data[var_35_1["dropmodel_id" .. var_35_4]].diamond then
				var_35_0.diamond = var_35_0.diamond + drop_data[var_35_1["dropmodel_id" .. var_35_4]].diamond
			end

			if drop_data[var_35_1["dropmodel_id" .. var_35_4]]["drop_id" .. 1] then
				local var_35_5 = 1

				while drop_data[var_35_1["dropmodel_id" .. var_35_4]]["drop_id" .. var_35_5] do
					var_35_0.items[var_35_2] = {
						itemid = drop_data[var_35_1["dropmodel_id" .. var_35_4]]["drop_id" .. var_35_5],
						num = drop_data[var_35_1["dropmodel_id" .. var_35_4]]["drop_num" .. var_35_5]
					}
					var_35_5 = var_35_5 + 1
					var_35_2 = var_35_2 + 1
				end
			end

			if drop_data[var_35_1["dropmodel_id" .. var_35_4]]["rd_drop_id" .. 1] then
				local var_35_6 = 1

				while drop_data[var_35_1["dropmodel_id" .. var_35_4]]["rd_drop_id" .. var_35_6] do
					var_35_0.items[var_35_2] = {
						itemid = drop_data[var_35_1["dropmodel_id" .. var_35_4]]["rd_drop_id" .. var_35_6],
						num = drop_data[var_35_1["dropmodel_id" .. var_35_4]]["rd_drop_num" .. var_35_6]
					}
					var_35_6 = var_35_6 + 1
					var_35_2 = var_35_2 + 1
				end
			end

			var_35_4 = var_35_4 + 1
		end
	end

	if var_35_1["rd_drop_id" .. 1] then
		local var_35_7 = 1

		while var_35_1["rd_drop_id" .. var_35_7] do
			var_35_0.items[var_35_2] = {
				itemid = var_35_1["rd_drop_id" .. var_35_7],
				num = var_35_1["rd_drop_num" .. var_35_7]
			}
			var_35_7 = var_35_7 + 1
			var_35_2 = var_35_2 + 1
		end
	end

	if var_35_1["rd_dropmodel_id" .. 1] then
		local var_35_8 = 1

		while var_35_1["rd_dropmodel_id" .. var_35_8] do
			if drop_data[var_35_1["rd_dropmodel_id" .. var_35_8]].gold then
				var_35_0.gold = var_35_0.gold + drop_data[var_35_1["rd_dropmodel_id" .. var_35_8]].gold
			end

			if drop_data[var_35_1["rd_dropmodel_id" .. var_35_8]].diamond then
				var_35_0.diamond = var_35_0.diamond + drop_data[var_35_1["rd_dropmodel_id" .. var_35_8]].diamond
			end

			if drop_data[var_35_1["rd_dropmodel_id" .. var_35_8]]["drop_id" .. 1] then
				local var_35_9 = 1

				while drop_data[var_35_1["rd_dropmodel_id" .. var_35_8]]["drop_id" .. var_35_9] do
					var_35_0.items[var_35_2] = {
						itemid = drop_data[var_35_1["rd_dropmodel_id" .. var_35_8]]["drop_id" .. var_35_9],
						num = drop_data[var_35_1["rd_dropmodel_id" .. var_35_8]]["drop_num" .. var_35_9]
					}
					var_35_9 = var_35_9 + 1
					var_35_2 = var_35_2 + 1
				end
			end

			if drop_data[var_35_1["rd_dropmodel_id" .. var_35_8]]["rd_drop_id" .. 1] then
				local var_35_10 = 1

				while drop_data[var_35_1["rd_dropmodel_id" .. var_35_8]]["rd_drop_id" .. var_35_10] do
					var_35_0.items[var_35_2] = {
						itemid = drop_data[var_35_1["rd_dropmodel_id" .. var_35_8]]["rd_drop_id" .. var_35_10],
						num = drop_data[var_35_1["rd_dropmodel_id" .. var_35_8]]["rd_drop_num" .. var_35_10]
					}
					var_35_10 = var_35_10 + 1
					var_35_2 = var_35_2 + 1
				end
			end

			var_35_8 = var_35_8 + 1
		end
	end

	return var_35_0
end
