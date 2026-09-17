AdventureRandomTowerLayer = class("AdventureRandomTowerLayer", function()
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

local level_manager = require("controller.level_manager")
local array_manager = require("controller.array_manager")
local audio_manager = require("controller.audio_manager")
local monster_manager = require("controller.monster_manager")
local component_manager = require("controller.component_manager")
local horcrux_manager = require("controller.horcrux_manager")
local levelmode_data = require("data.levelmode_data")
local var_0_14 = require("data.item_data")
local model_data = require("data.model_data")
local chapter_data = require("data.chapter_data")
local drop_data = require("data.drop_data")
local var_0_20 = {
	"adventurenewtowerlayer/changdi_1.png",
	"adventurenewtowerlayer/changdi_2.png",
	"adventurenewtowerlayer/changdi_3.png",
	"adventurenewtowerlayer/bai.png",
	"adventurenewtowerlayer/changdi_4.png"
}
local var_0_21 = {
	"adventurenewtowerlayer/namedi_1.png",
	"adventurenewtowerlayer/namedi_2.png",
	"adventurenewtowerlayer/bigboss_namedi.png"
}
local var_0_22 = {
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
local var_0_28 = 175

function AdventureRandomTowerLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = AdventureRandomTowerLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function AdventureRandomTowerLayer:init(arg_3_1)
	TopcostLayer.getInstance():hideTopcostLayer()

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AdventureNewTowerLayer.json" or "AdventureNewTowerLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.bg:loadTexture("mainScenebg/randomade_bg.png")
	self.bg:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2))

	self.backdi = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bottom")

	self.backdi:setPosition(cc.p(320, 31))
	self.backdi:setZOrder(10000)

	self.back = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_23")

	local var_3_0 = GameDisplay.getUiScreenSize().height - 63

	self.roleTableView = cc.TableView:create(cc.size(640, var_3_0))

	self.roleTableView:setPosition(cc.p(0, self.backdi:getPositionY() + self.backdi:getContentSize().height / 2))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rootLayer:setName("self.roleTableView")

	self.roleTableViewhight = var_3_0
	self.modetype = nil
	self.sucessflag = nil

	if type(arg_3_1) == "table" then
		self.modetype = arg_3_1.layer
		self.sucessflag = arg_3_1.scessflag
		self.chaptermode = arg_3_1.chaptermode
		self.returnbacklayer = arg_3_1.returnbacklayer
	elseif type(arg_3_1) == "number" then
		self.modetype = arg_3_1
	end

	self:fullScreen(self.rootLayer)
	self:getListData(self.modetype)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
	self.back:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function AdventureRandomTowerLayer:createNode()
	local var_6_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "items"):clone()

	var_6_0:setTouchEnabled(false)

	return var_6_0
end

function AdventureRandomTowerLayer:updateNode(arg_7_1, arg_7_2)
	local var_7_0 = ccui.Helper:seekWidgetByName(arg_7_1, "ani_1")
	local var_7_1 = ccui.Helper:seekWidgetByName(arg_7_1, "ani_2")
	local var_7_2 = ccui.Helper:seekWidgetByName(arg_7_1, "bossface")
	local var_7_3 = ccui.Helper:seekWidgetByName(arg_7_1, "name_di")
	local var_7_4 = ccui.Helper:seekWidgetByName(arg_7_1, "detail_btn")
	local var_7_5 = ccui.Helper:seekWidgetByName(arg_7_1, "ceshu")
	local var_7_6 = ccui.Helper:seekWidgetByName(arg_7_1, "change_btn")

	var_7_5:setString("")
	var_7_4:setPositionY(111)
	var_7_4:setPositionX(307)

	if not arg_7_2.isbigboss then
		var_7_0:loadTexture("adventurenewtowerlayer/tou_1.png", var_0_3)
		var_7_1:loadTexture("adventurenewtowerlayer/tou_2.png", var_0_3)
	else
		var_7_0:loadTexture("adventurenewtowerlayer/bigboss_tou3.png", var_0_3)
		var_7_1:loadTexture("adventurenewtowerlayer/bigboss_tou4.png", var_0_3)
	end

	self:updataImage(arg_7_1, arg_7_2)
	var_7_4:setSwallowTouches(false)

	local var_7_7

	if arg_7_2.status == 1 then
		if arg_7_1:getChildByName("sucess") then
			arg_7_1:getChildByName("sucess"):removeFromParent()
		end

		if arg_7_1:getChildByName("bosssucess") then
			arg_7_1:getChildByName("bosssucess"):removeFromParent()
		end

		if not arg_7_2.isbigboss then
			arg_7_1:setBackGroundImage(var_0_20[2], var_0_3)
			var_7_4:loadTextures(var_0_22[2], nil, var_0_22[2], var_0_3)
			var_7_3:loadTexture(var_0_21[2], var_0_3)

			var_7_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_NOT_BOSS, arg_7_2.layer)
		else
			arg_7_1:setBackGroundImage(var_0_25[2], var_0_3)
			var_7_4:loadTextures(var_0_22[3], nil, var_0_22[3], var_0_3)
			var_7_3:loadTexture(var_0_21[3], var_0_3)

			var_7_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_7_2.layer)
		end

		var_7_3:setVisible(true)
		var_7_0:setVisible(false)
		var_7_1:setVisible(false)
		var_7_6:setVisible(false)
	elseif arg_7_2.status == 2 then
		if arg_7_1:getChildByName("bosssucess") then
			arg_7_1:getChildByName("bosssucess"):removeFromParent()
		end

		local function var_7_8(arg_8_0)
			if not arg_7_2.isbigboss then
				arg_8_0:setBackGroundImage(var_0_20[1], var_0_3)
				var_7_4:loadTextures(var_0_22[1], nil, var_0_22[1], var_0_3)
				var_7_3:loadTexture(var_0_21[1], var_0_3)

				var_7_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_NOW, arg_7_2.layer)
			else
				arg_8_0:setBackGroundImage(var_0_25[1], var_0_3)
				var_7_4:loadTextures(var_0_22[3], nil, var_0_22[3], var_0_3)
				var_7_3:loadTexture(var_0_21[3], var_0_3)

				var_7_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_7_2.layer)
			end

			var_7_3:setVisible(true)
			var_7_0:setVisible(true)
			var_7_1:setVisible(true)
			var_7_6:setVisible(true)
			self:playain(arg_8_0)

			if var_7_5:getChildByName("richTextWord") then
				var_7_5:getChildByName("richTextWord"):removeFromParent()
			end

			local var_8_0 = require("view.Sprite.RichTextPro"):create()

			var_8_0:setMaxWidth(550)
			var_8_0:setSize(27)
			var_8_0:setLineSpace(0)
			var_8_0:setText(var_7_7, nil, true)
			var_8_0:setName("richTextWord")
			var_8_0:setPosition(cc.p((arg_7_2.layer >= 100 or nil) and -15, 23))
			var_7_5:addChild(var_8_0)
		end

		if self.sucessflag and self.sucessflag == 1 then
			if not arg_7_2.isbigboss then
				arg_7_1:setBackGroundImage(var_0_20[2], var_0_3)
				var_7_4:loadTextures(var_0_22[2], nil, var_0_22[2], var_0_3)
				var_7_3:loadTexture(var_0_21[2], var_0_3)

				var_7_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_NOT_BOSS, arg_7_2.layer)
			else
				arg_7_1:setBackGroundImage(var_0_25[2], var_0_3)
				var_7_4:loadTextures(var_0_22[3], nil, var_0_22[3], var_0_3)
				var_7_3:loadTexture(var_0_21[3], var_0_3)

				var_7_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_7_2.layer)
			end

			var_7_3:setVisible(true)
			var_7_0:setVisible(false)
			var_7_1:setVisible(false)
			var_7_6:setVisible(false)
		elseif self.sucessflag and self.sucessflag == 2 then
			self:playani2(arg_7_1, var_7_8)
		elseif var_7_8 then
			var_7_8(arg_7_1)
		end
	elseif arg_7_2.status == 3 then
		if arg_7_1:getChildByName("sucess") then
			arg_7_1:getChildByName("sucess"):removeFromParent()
		end

		local function var_7_9(arg_9_0)
			if arg_9_0:getChildByName("bosssucess") then
				arg_9_0:getChildByName("bosssucess"):removeFromParent()
			end

			local var_9_0 = ccui.ImageView:create("adventurenewtowerlayer/yitiaozhan.png", var_0_3)

			var_9_0:setScale(1)
			var_9_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_9_0:setName("bosssucess")
			var_9_0:setPosition(cc.p(arg_9_0:getContentSize().width / 2 + 240, arg_9_0:getContentSize().height / 2 - 13))
			arg_9_0:addChild(var_9_0, 10000)

			if not arg_7_2.isbigboss then
				arg_9_0:setBackGroundImage(var_0_20[3], var_0_3)

				if arg_9_0:getChildByName("bosssucess") then
					arg_9_0:getChildByName("bosssucess"):removeFromParent()
				end

				var_7_3:loadTexture(var_0_21[2], var_0_3)

				var_7_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS_SUCCESS, arg_7_2.layer)
			else
				arg_9_0:setBackGroundImage(var_0_25[1], var_0_3)
				var_7_3:loadTexture(var_0_21[3], var_0_3)

				var_7_7 = "<p>" .. string.format(L_ADVENTURE_TOWER_FLOOR_BOSS, arg_7_2.layer)
			end

			var_7_4:loadTextures(var_0_22[2], nil, var_0_22[2], var_0_3)
			var_7_0:setVisible(false)
			var_7_1:setVisible(false)
			var_7_6:setVisible(false)

			if var_7_5:getChildByName("richTextWord") then
				var_7_5:getChildByName("richTextWord"):removeFromParent()
			end

			local var_9_1 = require("view.Sprite.RichTextPro"):create()

			var_9_1:setMaxWidth(550)
			var_9_1:setSize(25)
			var_9_1:setLineSpace(0)
			var_9_1:setText(var_7_7, nil, true)
			var_9_1:setName("richTextWord")
			var_9_1:setPosition(cc.p((arg_7_2.layer >= 100 or nil) and -15, 23))
			var_7_5:addChild(var_9_1)
		end

		if self.sucessflag and self.sucessflag == 1 and arg_7_2.layer == self.curlevel - 1 then
			if not arg_7_2.isbigboss then
				arg_7_1:setBackGroundImage(var_0_20[5], var_0_3)
			else
				arg_7_1:setBackGroundImage(var_0_25[1], var_0_3)
			end

			var_7_6:setVisible(false)
			self:playani3(arg_7_1, var_7_9)
		else
			var_7_9(arg_7_1)
		end
	end

	if var_7_7 then
		if var_7_5:getChildByName("richTextWord") then
			var_7_5:getChildByName("richTextWord"):removeFromParent()
		end

		local var_7_10 = require("view.Sprite.RichTextPro"):create()

		var_7_10:setMaxWidth(550)
		var_7_10:setSize(27)
		var_7_10:setLineSpace(0)
		var_7_10:setText(var_7_7, nil, true)
		var_7_10:setName("richTextWord")
		var_7_10:setPosition(cc.p((arg_7_2.layer >= 100 or nil) and -15, 23))
		var_7_5:addChild(var_7_10)
	end

	var_7_2:loadTextures("role1/" .. model_data[arg_7_2.bossmode].cute_role .. ".png", nil, "role1/" .. model_data[arg_7_2.bossmode].cute_role .. ".png")
	var_7_2:setScale(0.35)
	var_7_2:setTouchEnabled(true)
	var_7_2:setSwallowTouches(false)
	var_7_3:getChildByName("bossname"):setFontSize(20)
	var_7_3:getChildByName("bossname"):setString(model_data[arg_7_2.bossmode].name)
	var_7_2:setPositionY(110)
	var_7_6:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_10_0 = "501-" .. arg_7_2.layer

		if chapter_data["501-" .. arg_7_2.layer] and chapter_data[var_10_0].boss_combat and playermodel.grade < chapter_data[var_10_0].boss_combat then
			global_ShowBlockWords(L_ADVENTURE_WARNING[6] .. chapter_data[var_10_0].boss_combat .. L_ADVENTURE_WARNING[7])

			return
		end

		if not arg_10_0:isBright() then
			return
		end

		arg_10_0:setBright(false)
		self:dealChangeBtn(self.mode, arg_7_2.layer, function()
			arg_10_0:setBright(true)
		end)
	end)
	var_7_4:setTouchEnabled(false)
	var_7_4:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_12_0:isBright() then
			return
		end

		arg_12_0:setBright(false)
		self:showBossInfo(self.mode, arg_7_2.layer, function()
			arg_12_0:setBright(true)
		end)
	end)
	var_7_2:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_14_0:isBright() then
			return
		end

		arg_14_0:setBright(false)
		self:showBossInfo(self.mode, arg_7_2.layer, function()
			arg_14_0:setBright(true)
		end)
	end)
end

function AdventureRandomTowerLayer.playani3(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1

	if arg_16_1:getChildByName("sucess") then
		arg_16_1:getChildByName("sucess"):removeFromParent()
	end

	local var_16_1 = ccui.ImageView:create("adventurenewtowerlayer/yitiaozhan.png", var_0_3)

	var_16_1:setScale(3)
	var_16_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_16_1:setName("sucess")
	var_16_1:setPosition(cc.p(arg_16_1:getContentSize().width / 2 + 240, arg_16_1:getContentSize().height / 2 - 13))
	arg_16_1:addChild(var_16_1, 10000)
	var_16_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.5, 1), cc.CallFunc:create(function()
		if arg_16_2 then
			arg_16_2(var_16_0)

			arg_16_0.sucessflag = 2

			print("!!!!!!!!!!")
		end
	end), cc.CallFunc:create(function()
		if arg_16_0.isscoll then
			arg_16_0.data = arg_16_0.newdata

			arg_16_0.roleTableView:reloadData()
			arg_16_0.roleTableView:scrollToPercent(50, nil, false)
			arg_16_0.roleTableView:scrollToPercent(0, 1, true)
		else
			arg_16_0.roleTableView:reloadData()
		end
	end)))
end

function AdventureRandomTowerLayer.playani2(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1

	arg_19_1:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		local var_20_0 = ccui.ImageView:create(var_0_20[4], var_0_3)

		var_20_0:setName("baisezhe")
		var_20_0:setPosition(var_19_0:getContentSize().width / 2 + 2, var_19_0:getContentSize().height / 2)
		var_19_0:addChild(var_20_0, 1000000)
		var_20_0:runAction(cc.Sequence:create(cc.FadeTo:create(0.3, 102), cc.FadeTo:create(0.3, 255), cc.CallFunc:create(function()
			if arg_19_2 then
				arg_19_2(var_19_0)
			end
		end), cc.FadeTo:create(0.3, 0)))
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		if var_19_0:getChildByName("baisezhe") then
			var_19_0:getChildByName("baisezhe"):removeFromParent()
		end

		arg_19_0.sucessflag = nil

		arg_19_0.roleTableView:setTouchEnabled(true)
	end)))
end

function AdventureRandomTowerLayer.playain(arg_23_0, arg_23_1)
	arg_23_1:getChildByName("ani_1"):runAction(cc.RepeatForever:create(cc.RotateBy:create(6, -360)))
	arg_23_1:getChildByName("ani_2"):runAction(cc.RepeatForever:create(cc.RotateBy:create(6, 360)))
end

function AdventureRandomTowerLayer.updataImage(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2.status
	local var_24_1 = {}

	if arg_24_2.item.items and #arg_24_2.item.items > 0 then
		for iter_24_0, iter_24_1 in ipairs(arg_24_2.item.items) do
			if iter_24_1.num and iter_24_1.num > 0 then
				table.insert(var_24_1, iter_24_1)
			end
		end
	end

	if arg_24_2.item.gold and arg_24_2.item.gold > 0 then
		table.insert(var_24_1, {
			itemid = "gold",
			num = arg_24_2.item.gold
		})
	end

	if arg_24_2.item.diamond and arg_24_2.item.diamond > 0 then
		table.insert(var_24_1, {
			itemid = "diamond",
			num = arg_24_2.item.diamond
		})
	end

	local var_24_2 = #var_24_1

	if #var_24_1 <= 0 then
		return
	end

	local var_24_4 = var_24_2 == 1 and 1 or var_24_2 == 2 and 2 or 3
	local var_24_5 = 1

	while arg_24_1:getChildByName("award" .. var_24_5) do
		arg_24_1:getChildByName("award" .. var_24_5):removeFromParent()

		if arg_24_1:getChildByName("zhezhao" .. var_24_5) then
			arg_24_1:getChildByName("zhezhao" .. var_24_5):removeFromParent()
		end

		var_24_5 = var_24_5 + 1
	end

	for iter_24_2 = 1, var_24_4 do
		local var_24_7 = type(var_24_1[iter_24_2].itemid) == "string" and ccui.Button:create("public/box/" .. "1" .. ".png", "public/box/" .. "1" .. ".png", nil, var_0_3) or ccui.Button:create("public/box/" .. var_0_14[var_24_1[iter_24_2].itemid].equip_quality .. ".png", "public/box/" .. var_0_14[var_24_1[iter_24_2].itemid].equip_quality .. ".png", nil, var_0_3)

		var_24_7:setAnchorPoint(cc.p(0.5, 0.5))
		var_24_7:setPosition(cc.p(0, 0))
		var_24_7:setTouchEnabled(true)
		var_24_7:setSwallowTouches(false)
		var_24_7:setPosition(cc.p(266 + (iter_24_2 - 1) * 90, 60))
		var_24_7:setName("award" .. iter_24_2)
		arg_24_1:addChild(var_24_7, 1)

		local var_24_8
		local var_24_9

		if var_24_1[iter_24_2].itemid == "gold" and var_24_1[iter_24_2].num > 0 then
			var_24_8 = "equipment/1000001.png"
		elseif var_24_1[iter_24_2].itemid == "diamond" and var_24_1[iter_24_2].num > 0 then
			var_24_8 = "equipment/1000000.png"
		elseif var_0_14[var_24_1[iter_24_2].itemid].image_id then
			var_24_8 = "equipment/" .. var_0_14[var_24_1[iter_24_2].itemid].image_id .. ".png"
		else
			var_24_9 = var_0_14[var_24_1[iter_24_2].itemid].bag_item_type == kITEM_MEDAL and ItemSprite:create_medal_icon(var_24_1[iter_24_2].itemid) or component_manager:create_component_icon(var_24_1[iter_24_2].itemid, nil, nil)
		end

		var_24_9 = var_24_9 or ccui.ImageView:create(var_24_8)

		var_24_9:setPosition(cc.p(var_24_7:getContentSize().width / 2, var_24_7:getContentSize().height / 2))
		var_24_7:addChild(var_24_9)
		var_24_9:setScale(66 / math.min(var_24_9:getContentSize().width, var_24_9:getContentSize().height))

		if var_24_0 == 3 then
			local var_24_10 = ccui.ImageView:create(var_0_24, var_0_3)

			var_24_10:setPosition(cc.p(var_24_7:getContentSize().width / 2, var_24_7:getContentSize().height / 2 + 15))
			var_24_10:setTouchEnabled(false)
			var_24_10:setScale9Enabled(true)
			var_24_10:setCapInsets(cc.rect(0, 0, 40, 40))
			var_24_10:setContentSize(cc.size(85, 90))
			var_24_10:setName("zhezhao" .. iter_24_2)
			arg_24_1:addChild(var_24_10, 2)
		end

		local var_24_11 = cc.Label:createWithTTF("", FONT_DES, 16)

		var_24_11:setMaxLineWidth(190)
		var_24_11:setAnchorPoint(cc.p(0.5, 0.5))
		var_24_11:setString("x" .. var_24_1[iter_24_2].num)
		var_24_11:setPosition(cc.p(var_24_7:getContentSize().width / 2, var_24_7:getContentSize().height / 2 - 36))
		var_24_7:addChild(var_24_11)

		var_24_7.itemtype = "gold"

		if var_24_1[iter_24_2].itemid ~= "gold" and var_24_1[iter_24_2].itemid ~= "diamond" then
			var_24_7.itemtype = "item"
		end

		var_24_7:addTouchEventListener(function(arg_25_0, arg_25_1)
			if arg_25_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_24_0:showDetailsofItems(var_24_1[iter_24_2].itemid, var_24_7.itemtype)
		end)
	end

	if var_24_4 == 1 and arg_24_1:getChildByName("award" .. 1) then
		arg_24_1:getChildByName("award" .. 1):setPositionX(316)

		if arg_24_1:getChildByName("zhezhao" .. 1) then
			arg_24_1:getChildByName("zhezhao" .. 1):setPositionX(316)
		end
	end

	local var_24_12 = {
		266,
		356,
		445
	}

	if var_24_4 == 3 then
		for iter_24_3 = 1, 3 do
			if arg_24_1:getChildByName("award" .. iter_24_3) then
				arg_24_1:getChildByName("award" .. iter_24_3):setPositionX(var_24_12[iter_24_3] - 40)
			end

			if arg_24_1:getChildByName("zhezhao" .. iter_24_3) then
				arg_24_1:getChildByName("zhezhao" .. iter_24_3):setPositionX(var_24_12[iter_24_3] - 40)
			end
		end
	end

	local var_24_13 = {
		266,
		356
	}

	if var_24_4 == 2 then
		for iter_24_4 = 1, 2 do
			if arg_24_1:getChildByName("zhezhao" .. iter_24_4) then
				arg_24_1:getChildByName("zhezhao" .. iter_24_4):setPositionX(var_24_13[iter_24_4])
			end
		end
	end

	local var_24_14 = arg_24_2.horcruxAffix
	local var_24_15 = #arg_24_2.horcruxAffix
	local var_24_16 = 1

	while arg_24_1:getChildByName("btnpanel_" .. var_24_16) do
		arg_24_1:getChildByName("btnpanel_" .. var_24_16):removeFromParent()

		var_24_16 = var_24_16 + 1
	end

	local var_24_17

	if arg_24_2.isbigboss then
		var_24_17 = var_0_26[3]
	elseif arg_24_2.status == 1 or arg_24_2.status == 3 then
		var_24_17 = var_0_26[2]
	elseif arg_24_2.status == 2 then
		var_24_17 = var_0_26[1]
	end

	for iter_24_5 = 1, var_24_15 do
		local var_24_18 = ccui.Layout:create()

		var_24_18:setContentSize(cc.size(140, 36))
		var_24_18:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		var_24_18:setAnchorPoint(0.5, 0.5)
		var_24_18:setBackGroundColor(cc.c3b(0, 0, 0))
		var_24_18:setTouchEnabled(false)
		var_24_18:setName("btnpanel_" .. iter_24_5)
		var_24_18:setPosition(cc.p(arg_24_1:getContentSize().width / 2 - 80 + (iter_24_5 - 1) * 130, arg_24_1:getContentSize().height / 2 + 50))
		arg_24_1:addChild(var_24_18, 10)

		local var_24_19 = ccui.ImageView:create(var_24_17, var_0_3)

		var_24_19:setPosition(cc.p(var_24_18:getContentSize().width / 2 - 50, var_24_18:getContentSize().height / 2 - 3))
		var_24_18:addChild(var_24_19)
		var_24_19:setTouchEnabled(false)

		local var_24_20 = ccui.Button:create("skill_new/skill/" .. var_24_14[iter_24_5].icon .. ".png", "skill_new/skill/" .. var_24_14[iter_24_5].icon .. ".png", nil, var_0_3)

		var_24_20:setName("btnSkill_" .. iter_24_5)
		var_24_20:setPosition(cc.p(var_24_19:getContentSize().width / 2, var_24_19:getContentSize().height / 2))
		var_24_20:setScale((math.min(37 / var_24_20:getContentSize().width, 37 / var_24_20:getContentSize().height)))
		var_24_19:addChild(var_24_20)
		var_24_20:setTouchEnabled(true)
		var_24_20:setSwallowTouches(false)

		local var_24_21 = cc.Label:createWithTTF("1", FONT_DES, 20)

		var_24_21:setMaxLineWidth(190)
		var_24_21:setAnchorPoint(cc.p(0, 0.5))
		var_24_21:setString(var_24_14[iter_24_5].name)
		var_24_21:setPosition(cc.p(var_24_19:getPositionX() + 27, var_24_19:getPositionY()))
		var_24_18:addChild(var_24_21)
		var_24_20:addTouchEventListener(function(arg_26_0, arg_26_1)
			if arg_26_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_24_0:showAwardInfo(arg_24_1, var_24_14[iter_24_5].name, var_24_14[iter_24_5].des, iter_24_5)
		end)
	end
end

function AdventureRandomTowerLayer:showAwardInfo(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	for iter_27_0 = 1, 2 do
		if iter_27_0 ~= arg_27_4 and arg_27_1:getChildByName("btnpanel_" .. iter_27_0) then
			arg_27_1:getChildByName("btnpanel_" .. iter_27_0):setZOrder(20)

			if arg_27_1:getChildByName("btnpanel_" .. iter_27_0):getChildByName("showskill") then
				arg_27_1:getChildByName("btnpanel_" .. iter_27_0):getChildByName("showskill"):removeFromParent()
			end
		end
	end

	local var_27_0 = arg_27_1:getChildByName("btnpanel_" .. arg_27_4)

	var_27_0:setZOrder(21)

	if var_27_0:getChildByName("showskill") then
		var_27_0:getChildByName("showskill"):removeFromParent()

		return
	end

	local var_27_1 = ccui.Layout:create()

	var_27_1:setContentSize(cc.size(260, 120))
	var_27_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_27_1:setAnchorPoint(0, 1)
	var_27_1:setPosition(cc.p(var_27_0:getPositionX() / 2 - arg_27_4 * 70, var_27_0:getPositionY() / 2 - 36))
	var_27_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_27_1:setCascadeOpacityEnabled(false)
	var_27_1:setBackGroundColorOpacity(190)
	var_27_1:setName("showskill")
	var_27_1:setTouchEnabled(true)
	var_27_1:setScale(0)
	var_27_0:addChild(var_27_1, 100)

	local var_27_2 = cc.Label:createWithTTF("1", FONT_DES, 22)

	var_27_2:setMaxLineWidth(190)
	var_27_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_27_2:setColor(cc.c3b(253, 211, 81))
	var_27_2:setPosition(cc.p(var_27_1:getContentSize().width / 2, var_27_1:getContentSize().height - 12))
	var_27_2:setName("Label1")
	var_27_2:setString(arg_27_2)
	var_27_1:addChild(var_27_2)

	local var_27_3 = cc.Label:createWithTTF("1", FONT_DES, 20)

	var_27_3:setMaxLineWidth(250)
	var_27_3:setAnchorPoint(cc.p(0, 1))
	var_27_3:setColor(cc.c3b(234, 232, 226))
	var_27_3:setPosition(cc.p(0, var_27_2:getPositionY() - var_27_2:getContentSize().height))
	var_27_3:setName("Label2")
	var_27_3:setString(arg_27_3)
	var_27_1:addChild(var_27_3)

	local var_27_4 = cc.EventListenerTouchOneByOne:create()

	var_27_4:setSwallowTouches(false)
	var_27_4:registerScriptHandler(function(arg_28_0, arg_28_1)
		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_27_4:registerScriptHandler(function(arg_29_0, arg_29_1)
		if var_27_0:getChildByName("showskill") then
			var_27_0:getChildByName("showskill"):removeFromParent()
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_27_4, var_27_1)
	var_27_1:runAction((cc.ScaleTo:create(0.2, 1)))
end

function AdventureRandomTowerLayer:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_32_0, arg_32_1)
		return var_0_27, var_0_28
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_31_0, arg_31_1)
		local var_31_0 = arg_31_0:dequeueCell()

		if not var_31_0 then
			var_31_0 = cc.TableViewCell:create()

			local var_31_1 = self:createNode()

			var_31_1:setName("node")
			var_31_1:setPosition(cc.p(5, 5))
			self:updateNode(var_31_1, self.data[arg_31_1 + 1])

			if not self.sucessflag then
				if arg_31_1 <= math.floor(self.roleTableViewhight / var_0_28) then
					var_31_1:setOpacity(0)
					var_31_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_31_1), cc.FadeIn:create(0.1)))
				else
					var_31_1:setOpacity(255)
				end
			end

			var_31_0:addChild(var_31_1)
		else
			local var_31_2 = var_31_0:getChildByName("node")

			if not self.sucessflag then
				var_31_2:setOpacity(255)
			end

			self:updateNode(var_31_2, self.data[arg_31_1 + 1])
		end

		return var_31_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_33_0, arg_33_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function AdventureRandomTowerLayer:getListData(arg_34_1)
	local var_34_1

	for iter_34_0, iter_34_1 in pairs(levelmode_data) do
		if iter_34_1.modetype == arg_34_1 then
			var_34_1 = iter_34_1
		end
	end

	if self.chaptermode then
		for iter_34_2, iter_34_3 in pairs(levelmode_data) do
			if iter_34_3.mode == self.chaptermode then
				var_34_1 = iter_34_3
			end
		end
	end

	if not var_34_1 then
		return
	end

	self.leveldata = var_34_1
	self.mode = var_34_1.mode
	self.numchapter = var_34_1.totalchapter
	self.curlevel = playermodel.levelmode[self.mode].status

	local var_34_2 = self:dealEndData2(global_deepCopy((self:getData(self.mode))))

	if self.sucessflag and self.sucessflag == 1 and self.beatbigboss then
		local var_34_3 = {}

		for iter_34_4 = #var_34_2 - (self.curlevel - 1) + 1, #var_34_2 do
			table.insert(var_34_3, var_34_2[iter_34_4])
		end

		self.newdata = var_34_2
		self.data = var_34_3

		self:initTableView()

		self.isscoll = true
	else
		self.data = var_34_2

		self:initTableView()
	end
end

function AdventureRandomTowerLayer:getScollPercetn()
	return (self.tableviewcontensize / var_0_28 + (self.data[1].layer - self.curlevel + 1)) / #self.data * 100
end

function AdventureRandomTowerLayer:getData(arg_36_1)
	if not arg_36_1 then
		return
	end

	local var_36_0 = {}

	for iter_36_0 = 1, level_manager:getModeTotalChapter(arg_36_1) do
		local var_36_1 = monster_manager.getLevelBoss(arg_36_1, iter_36_0 .. "-1")
		local var_36_2 = {
			bossmode = var_36_1.majorlist.modelid,
			layer = iter_36_0,
			item = self:getDropData((level_manager:getLevelDropID(arg_36_1, iter_36_0 .. "-1"))),
			isbigboss = var_36_1.isFinal
		}
		local var_36_3 = horcrux_manager:getMonsterHorcruxAssistConfig(var_36_1.majorlist)

		var_36_2.horcruxAffix = {}

		if var_36_3 then
			for iter_36_1, iter_36_2 in ipairs(var_36_3.skills) do
				var_36_2.horcruxAffix[iter_36_1] = {
					id = iter_36_2,
					name = total_skill_data[iter_36_2].name,
					des = string.format("%s。", total_skill_data[iter_36_2].description),
					icon = total_skill_data[iter_36_2].icon
				}
			end
		end

		var_36_0[iter_36_0] = var_36_2
	end

	return var_36_0
end

function AdventureRandomTowerLayer:dealEndData2(arg_37_1)
	local var_37_0 = {}
	local var_37_1 = {}
	local var_37_2 = {}
	local var_37_3 = {}
	local var_37_5

	self.beatbigboss = not not (arg_37_1[self.curlevel - 1] and arg_37_1[self.curlevel - 1].isbigboss)

	for iter_37_0 = self.curlevel, #arg_37_1 do
		if arg_37_1[iter_37_0].isbigboss then
			var_37_5 = iter_37_0

			break
		end
	end

	if var_37_5 then
		for iter_37_1 = 1, var_37_5 - self.curlevel do
			if arg_37_1[var_37_5 - iter_37_1 + 1] then
				arg_37_1[var_37_5 - iter_37_1 + 1].status = 1

				table.insert(var_37_0, arg_37_1[var_37_5 - iter_37_1 + 1])
			end
		end

		arg_37_1[self.curlevel].status = 2
		var_37_2 = arg_37_1[self.curlevel]

		for iter_37_2 = 1, self.curlevel - 1 do
			arg_37_1[self.curlevel - iter_37_2].status = 3

			table.insert(var_37_1, arg_37_1[self.curlevel - iter_37_2])
		end
	else
		for iter_37_3 = 1, #arg_37_1 do
			arg_37_1[#arg_37_1 - iter_37_3 + 1].status = 3

			table.insert(var_37_1, arg_37_1[#arg_37_1 - iter_37_3 + 1])
		end

		self.beatbigboss = false
	end

	if next(var_37_0) then
		var_37_3 = var_37_0
	end

	if next(var_37_2) then
		table.insert(var_37_3, var_37_2)
	end

	if next(var_37_1) then
		for iter_37_4, iter_37_5 in ipairs(var_37_1) do
			table.insert(var_37_3, iter_37_5)
		end
	end

	self.beatbigboss = not not (arg_37_1[self.curlevel - 1] and arg_37_1[self.curlevel - 1].isbigboss)

	return var_37_3
end

function AdventureRandomTowerLayer:dealEndData(arg_38_1)
	local var_38_0 = {}
	local var_38_1 = {}
	local var_38_2 = {}
	local var_38_3 = 0

	if arg_38_1[self.curlevel + 3] then
		var_38_3 = 3
	elseif arg_38_1[self.curlevel + 2] then
		var_38_3 = 2
	elseif arg_38_1[self.curlevel + 1] then
		var_38_3 = 1
	end

	for iter_38_0 = 1, var_38_3 do
		arg_38_1[self.curlevel + var_38_3 - iter_38_0 + 1].status = 1

		table.insert(var_38_0, arg_38_1[self.curlevel + var_38_3 - iter_38_0 + 1])
	end

	if var_38_3 > 0 then
		var_38_2 = var_38_0
	end

	if self.curlevel <= self.numchapter then
		arg_38_1[self.curlevel].status = 2

		table.insert(var_38_2, arg_38_1[self.curlevel])
	end

	for iter_38_1 = 1, self.curlevel - 1 do
		arg_38_1[self.curlevel - iter_38_1].status = 3

		table.insert(var_38_1, arg_38_1[self.curlevel - iter_38_1])
	end

	if #var_38_1 > 0 then
		for iter_38_2, iter_38_3 in ipairs(var_38_1) do
			table.insert(var_38_2, iter_38_3)
		end
	end

	local var_38_4 = #var_38_2

	if #var_38_2 < 7 then
		for iter_38_4 = 1, 7 - #var_38_2 do
			table.insert(var_38_2, {
				istempdata = true,
				layer = var_38_4 + iter_38_4
			})
		end
	end

	return var_38_2
end

function AdventureRandomTowerLayer.showBossInfo(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = {
		fight_type = "ADVENTURE",
		level = 1,
		mode = arg_39_1,
		chapter = arg_39_2,
		callback = arg_39_3
	}

	var_39_0.initindex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)

	LayerManager:pushInLayer("LevelDetailLayer", var_39_0)
end

function AdventureRandomTowerLayer:showDetailsofItems(arg_40_1, arg_40_2)
	local function var_40_1()
		return
	end

	if arg_40_2 == "item" then
		if var_0_14[arg_40_1].bag_item_type == kITEM_HORCRUX then
			local var_40_2 = -1
			local horcrux_data = require("data.horcrux_data")

			for iter_40_0, iter_40_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if iter_40_1.model_id == horcrux_data[arg_40_1].model then
					var_40_2 = iter_40_0

					break
				end
			end

			if var_40_2 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_40_2,
				itemid = arg_40_1,
				callback = var_40_1
			})
		elseif var_0_14[arg_40_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = var_0_14[arg_40_1].servant,
				exitCallback = var_40_1
			})
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_40_4 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_40_1
			})
		end
	elseif arg_40_2 == "gold" then
		-- block empty
	elseif arg_40_2 == "diamond" then
		-- block empty
	end
end

function AdventureRandomTowerLayer.dealChangeBtn(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = arg_42_1
	local var_42_1 = arg_42_2
	local var_42_2, var_42_3 = level_manager:isModeValid(arg_42_1)

	if not var_42_2 then
		audio_manager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(level_manager:getModeUnlockMsg(arg_42_1, var_42_3))

		return
	end

	local function var_42_4(arg_43_0)
		if arg_43_0 == 1 then
			AnalyticManager.click_bosstower()
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			FightManager.refreshFightToType(FIGHTTYPE_ADVENTURE)
		else
			if arg_43_0 == 2 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[2])
			elseif arg_43_0 == 3 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[3])
			elseif arg_43_0 == 4 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[4])
			elseif arg_43_0 == 5 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[5])
			elseif arg_43_0 == 6 then
				audio_manager:playeffectMusicTest("sound/invalid")

				if chapter_data["" .. var_42_0 .. "-" .. var_42_1] and chapter_data["" .. var_42_0 .. "-" .. var_42_1].boss_combat then
					global_ShowBlockWords(L_ADVENTURE_WARNING[6] .. chapter_data["" .. var_42_0 .. "-" .. var_42_1].boss_combat .. L_ADVENTURE_WARNING[7])
				end
			end

			GuideListener.showAllGuidesWithFullScreen(true)
		end
	end

	local function var_42_5(arg_44_0)
		GuideListener.showAllGuidesWithFullScreen(false)
		array_manager:resetHangupArray(arg_44_0)
		RoleDefault:getInstance():setIntegerForKey("adventurearray", arg_44_0)
		RoleDefault:getInstance():setIntegerForKey("lastadventurearray", arg_44_0)
		level_manager:switchToAdventureMode(var_42_0, var_42_1, var_42_4, arg_44_0)
	end

	local var_42_6 = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)

	LayerManager:pushInLayer("LevelDetailLayer", {
		fight_type = "ADVENTURE",
		level = 1,
		mode = arg_42_1,
		chapter = arg_42_2,
		callback = arg_42_3,
		adventuresurecallback = function()
			require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationModeLayer", {
				initindex = var_42_6,
				mode = var_42_0,
				configtype = CONFIG_TYPE_ADVENTURE,
				configcallback = var_42_5,
				exitcallback = arg_42_3
			})
		end,
		initindex = var_42_6
	})
end

function AdventureRandomTowerLayer.getDropData(arg_46_0, arg_46_1)
	local var_46_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_46_1 = drop_data[arg_46_1] or {}

	if var_46_1.gold then
		var_46_0.gold = var_46_0.gold + var_46_1.gold
	end

	if var_46_1.diamond then
		var_46_0.diamond = var_46_0.diamond + var_46_1.diamond
	end

	local var_46_2 = 1

	if var_46_1["drop_id" .. 1] then
		local var_46_3 = 1

		while var_46_1["drop_id" .. var_46_3] do
			var_46_0.items[var_46_2] = {
				itemid = var_46_1["drop_id" .. var_46_3],
				num = var_46_1["drop_num" .. var_46_3]
			}
			var_46_3 = var_46_3 + 1
			var_46_2 = var_46_2 + 1
		end
	end

	if var_46_1["dropmodel_id" .. 1] then
		local var_46_4 = 1

		while var_46_1["dropmodel_id" .. var_46_4] do
			if drop_data[var_46_1["dropmodel_id" .. var_46_4]].gold then
				var_46_0.gold = var_46_0.gold + drop_data[var_46_1["dropmodel_id" .. var_46_4]].gold
			end

			if drop_data[var_46_1["dropmodel_id" .. var_46_4]].diamond then
				var_46_0.diamond = var_46_0.diamond + drop_data[var_46_1["dropmodel_id" .. var_46_4]].diamond
			end

			if drop_data[var_46_1["dropmodel_id" .. var_46_4]]["drop_id" .. 1] then
				local var_46_5 = 1

				while drop_data[var_46_1["dropmodel_id" .. var_46_4]]["drop_id" .. var_46_5] do
					var_46_0.items[var_46_2] = {
						itemid = drop_data[var_46_1["dropmodel_id" .. var_46_4]]["drop_id" .. var_46_5],
						num = drop_data[var_46_1["dropmodel_id" .. var_46_4]]["drop_num" .. var_46_5]
					}
					var_46_5 = var_46_5 + 1
					var_46_2 = var_46_2 + 1
				end
			end

			if drop_data[var_46_1["dropmodel_id" .. var_46_4]]["rd_drop_id" .. 1] then
				local var_46_6 = 1

				while drop_data[var_46_1["dropmodel_id" .. var_46_4]]["rd_drop_id" .. var_46_6] do
					var_46_0.items[var_46_2] = {
						itemid = drop_data[var_46_1["dropmodel_id" .. var_46_4]]["rd_drop_id" .. var_46_6],
						num = drop_data[var_46_1["dropmodel_id" .. var_46_4]]["rd_drop_num" .. var_46_6]
					}
					var_46_6 = var_46_6 + 1
					var_46_2 = var_46_2 + 1
				end
			end

			var_46_4 = var_46_4 + 1
		end
	end

	if var_46_1["rd_drop_id" .. 1] then
		local var_46_7 = 1

		while var_46_1["rd_drop_id" .. var_46_7] do
			var_46_0.items[var_46_2] = {
				itemid = var_46_1["rd_drop_id" .. var_46_7],
				num = var_46_1["rd_drop_num" .. var_46_7]
			}
			var_46_7 = var_46_7 + 1
			var_46_2 = var_46_2 + 1
		end
	end

	if var_46_1["rd_dropmodel_id" .. 1] then
		local var_46_8 = 1

		while var_46_1["rd_dropmodel_id" .. var_46_8] do
			if drop_data[var_46_1["rd_dropmodel_id" .. var_46_8]].gold then
				var_46_0.gold = var_46_0.gold + drop_data[var_46_1["rd_dropmodel_id" .. var_46_8]].gold
			end

			if drop_data[var_46_1["rd_dropmodel_id" .. var_46_8]].diamond then
				var_46_0.diamond = var_46_0.diamond + drop_data[var_46_1["rd_dropmodel_id" .. var_46_8]].diamond
			end

			if drop_data[var_46_1["rd_dropmodel_id" .. var_46_8]]["drop_id" .. 1] then
				local var_46_9 = 1

				while drop_data[var_46_1["rd_dropmodel_id" .. var_46_8]]["drop_id" .. var_46_9] do
					var_46_0.items[var_46_2] = {
						itemid = drop_data[var_46_1["rd_dropmodel_id" .. var_46_8]]["drop_id" .. var_46_9],
						num = drop_data[var_46_1["rd_dropmodel_id" .. var_46_8]]["drop_num" .. var_46_9]
					}
					var_46_9 = var_46_9 + 1
					var_46_2 = var_46_2 + 1
				end
			end

			if drop_data[var_46_1["rd_dropmodel_id" .. var_46_8]]["rd_drop_id" .. 1] then
				local var_46_10 = 1

				while drop_data[var_46_1["rd_dropmodel_id" .. var_46_8]]["rd_drop_id" .. var_46_10] do
					var_46_0.items[var_46_2] = {
						itemid = drop_data[var_46_1["rd_dropmodel_id" .. var_46_8]]["rd_drop_id" .. var_46_10],
						num = drop_data[var_46_1["rd_dropmodel_id" .. var_46_8]]["rd_drop_num" .. var_46_10]
					}
					var_46_10 = var_46_10 + 1
					var_46_2 = var_46_2 + 1
				end
			end

			var_46_8 = var_46_8 + 1
		end
	end

	return var_46_0
end

function AdventureRandomTowerLayer.fullScreen(arg_47_0, arg_47_1)
	arg_47_1:setContentSize((GameDisplay.getScreenSize()))
	arg_47_1:setPositionY(arg_47_1:getPositionY() - GameDisplay.fix_y)
end
