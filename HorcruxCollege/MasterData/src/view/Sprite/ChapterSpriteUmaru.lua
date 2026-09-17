local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local patrol_manager = require("controller.patrol_manager")
local item_data = require("data.item_data")
local var_0_4 = config._DEBUG and 0 or 1
local var_0_6 = 13713

ChapterSpriteUmaru = class("ChapterSpriteUmaru", function()
	return ccui.Button:create("LevelMapUmaru/levelItem_easy.png", "LevelMapUmaru/levelItem_easy.png", "LevelMapUmaru/levelItem_easy.png", var_0_4)
end)

function ChapterSpriteUmaru.create(arg_2_0, arg_2_1)
	local var_2_0 = ChapterSpriteUmaru.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ChapterSpriteUmaru:init(arg_3_1)
	self:setPressedActionEnabled(true)
	self:setAnchorPoint(cc.p(0.5, 0))

	local var_3_0 = ccui.TextBMFont:create(1, "fonts/umr_map_number.fnt")

	var_3_0:setAnchorPoint(cc.p(0, 0.5))
	var_3_0:setPosition(cc.p(self:getContentSize().width / 2 - 60, self:getContentSize().height / 2 - 18))
	var_3_0:setName("name")
	self:addChild(var_3_0)

	local var_3_1 = ccui.ImageView:create("LevelMapUmaru/frame_drop.png", var_0_4)

	var_3_1:setPosition(cc.p(self:getContentSize().width / 2 + 120, self:getContentSize().height / 2 + 25))
	var_3_1:setName("drop")
	self:addChild(var_3_1)

	local var_3_2 = ccui.ImageView:create("LevelMapUmaru/img_unknow_drop.png", var_0_4)

	var_3_2:setPosition(cc.p(var_3_1:getContentSize().width / 2, var_3_1:getContentSize().height / 2))
	var_3_2:setName("dropimg")
	var_3_1:addChild(var_3_2)

	local var_3_3 = ccui.Button:create("public/box/1.png", "public/box/1.png", "public/box/1.png", var_0_4)

	var_3_3:setVisible(false)
	var_3_3:setScale(var_3_2:getContentSize().width / var_3_3:getContentSize().width)
	var_3_3:setPosition(cc.p(self:getContentSize().width / 2 + 120, self:getContentSize().height / 2 + 25))
	var_3_3:setName("item")
	self:addChild(var_3_3)

	local var_3_4 = ccui.Button:create("equipment/1000000.png", "equipment/1000000.png", "equipment/1000000.png")

	var_3_4:setScale(var_3_3:getContentSize().width / var_3_4:getContentSize().width)
	var_3_4:setPosition(var_3_3:getContentSize().width / 2, var_3_3:getContentSize().height / 2)
	var_3_4:setName("icon")
	var_3_3:addChild(var_3_4)

	local var_3_5 = ccui.ImageView:create("LevelMapUmaru/img_curtag.png", var_0_4)

	var_3_5:setAnchorPoint(cc.p(0.5, 0))
	var_3_5:setPosition(cc.p(self:getContentSize().width / 2 + 50, self:getContentSize().height - 15))
	var_3_5:setVisible(false)
	var_3_5:setName("curtag")
	self:addChild(var_3_5)

	function var_3_5.runFadeAction(...)
		var_3_5:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(2, 255), cc.FadeTo:create(2, 128))))
	end

	local var_3_7 = ccui.ImageView:create((arg_3_1.curcity >= var_0_6 or nil) and "LevelMapUmaru/levelItem_select5.png", var_0_4)

	var_3_7:setAnchorPoint(cc.p(0.5, 0))
	var_3_7:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height - 94))
	var_3_7:setVisible(false)
	var_3_7:setName("biling")
	self:addChild(var_3_7, -1)

	local var_3_8 = ccui.ImageView:create("LevelMapUmaru/img_tag_can_patrol.png", var_0_4)

	var_3_8:setAnchorPoint(cc.p(0, 0))
	var_3_8:setPosition(cc.p(35, 80))
	var_3_8:setVisible(false)
	var_3_8:setName("newtag")
	self:addChild(var_3_8)

	local var_3_9 = ccui.ImageView:create("LevelMapUmaru/img_tagcomplete.png", var_0_4)

	var_3_9:setAnchorPoint(cc.p(0, 0))
	var_3_9:setPosition(cc.p(35, 80))
	var_3_9:setVisible(false)
	var_3_9:setName("completetag")
	self:addChild(var_3_9)

	local var_3_10 = cc.Label:createWithTTF("00:00", FONT_DES, 25)

	var_3_10:setAnchorPoint(cc.p(0, 0))
	var_3_10:setPosition(cc.p(42, 88))
	var_3_10:setName("timer")
	self:addChild(var_3_10)

	for iter_3_0 = 1, LEVEL_STARS_NUM do
		local var_3_11 = ccui.ImageView:create("LevelMapUmaru/star_icon.png", var_0_4)

		var_3_11:setName("star" .. iter_3_0)
		var_3_11:setPosition(55 + (iter_3_0 - 1) * 25, 65)
		self:addChild(var_3_11)
	end
end

function ChapterSpriteUmaru:_setSwallowTouches(arg_5_1)
	self:setSwallowTouches(arg_5_1)
	ccui.Helper:seekWidgetByName(self, "item"):setSwallowTouches(arg_5_1)
end

function ChapterSpriteUmaru:_addTouchEventListener(arg_6_1)
	self:addTouchEventListener(arg_6_1)
	self:getChildByName("item"):getChildByName("icon"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if type(arg_6_1) == "function" then
			arg_6_1()
		end
	end)
end

local var_0_7 = {
	"easy",
	"hard",
	"hell",
	"nightmare"
}

function ChapterSpriteUmaru:update(arg_8_1)
	local var_8_0 = arg_8_1.curdifficuty or 1
	local var_8_1 = arg_8_1.chapter
	local var_8_2 = level_manager:getModeByDifficulty(arg_8_1.curcity, var_8_0)
	local var_8_3 = level_manager:getChapterStrongholdLv(var_8_2, arg_8_1.chapter)

	if var_8_3 ~= 1 and var_8_1 % 2 == 1 then
		var_8_3 = 3
	end

	local var_8_4 = not level_manager:isLevelModeUnlocked(var_8_2) and (arg_8_1.curcity >= var_0_6 and "LevelMapUmaru/levelItem_lock5.png" or "LevelMapUmaru/levelItem_lock.png") or level_manager:isChapterModeUnlocked(var_8_2, var_8_1) and (arg_8_1.curcity >= var_0_6 and "LevelMapUmaru/levelItem" .. "_" .. var_0_7[1] .. "5.png" or "LevelMapUmaru/levelItem" .. "_" .. var_0_7[var_8_0] .. ".png") or arg_8_1.curcity >= var_0_6 and "LevelMapUmaru/levelItem_lock5.png" or "LevelMapUmaru/levelItem_lock.png"

	self:loadTextures(var_8_4, var_8_4, var_8_4, var_0_4)

	if var_8_3 == 1 then
		self:getChildByName("name"):setString(level_manager:getChapterName(var_8_2, var_8_1))
		self:getChildByName("drop"):setVisible(false)
		self:getChildByName("newtag"):setVisible(false)
		self:getChildByName("completetag"):setVisible(false)
		self:getChildByName("timer"):setVisible(false)
		self:getChildByName("item"):setVisible(false)
	else
		if var_8_3 == 2 then
			self:getChildByName("name"):setPosition(cc.p(self:getContentSize().width / 2 + 73, self:getContentSize().height / 2 - 5))
		else
			self:getChildByName("item"):setPositionX(self:getContentSize().width / 2 + 86)
		end

		self:getChildByName("name"):setString(level_manager:getChapterName(var_8_2, var_8_1))
		self:getChildByName("drop"):setVisible(true)
		self:getChildByName("item"):setVisible(false)
		self:getChildByName("newtag"):setVisible(false)
		self:getChildByName("completetag"):setVisible(false)
		self:getChildByName("timer"):setVisible(false)

		if level_manager:isChapterModeUnlocked(var_8_2, var_8_1) then
			local var_8_5 = level_manager:getChapterStrongholdDrop(var_8_2, var_8_1)

			if var_8_5 then
				self:getChildByName("drop"):setVisible(false)
				self:getChildByName("item"):setVisible(true)

				local var_8_6 = self:getChildByName("item")
				local var_8_7 = var_8_6:getChildByName("icon")
				local var_8_8 = item_data[var_8_5].equip_quality or 1
				local var_8_9 = item_data[var_8_5].image_id or 100

				var_8_6:loadTextures("public/box/" .. var_8_8 .. ".png", "public/box/" .. var_8_8 .. ".png", "public/box/" .. var_8_8 .. ".png", var_0_4)
				var_8_7:loadTextures("equipment/" .. var_8_9 .. ".png", "equipment/" .. var_8_9 .. ".png", "equipment/" .. var_8_9 .. ".png")
				var_8_7:setScale(var_8_6:getContentSize().width / var_8_7:getContentSize().width)
			else
				self:getChildByName("drop"):setVisible(true)
			end

			;(function()
				if arg_8_1.timer then
					local var_9_0 = patrol_manager:getPatrolInfo(arg_8_1.timer.key)

					if var_9_0 and var_9_0.time > 0 then
						self:getChildByName("timer"):setVisible(true)
					else
						self:getChildByName("timer"):setVisible(false)
					end
				else
					local var_9_1 = patrol_manager:getPatrolState(var_8_2 .. "-" .. var_8_1)

					if var_9_1 == 3 then
						self:getChildByName("timer"):setVisible(true)
					elseif var_9_1 == 2 then
						self:getChildByName("timer"):setVisible(false)
						self:getChildByName("completetag"):setVisible(true)
					else
						self:getChildByName("timer"):setVisible(false)
					end
				end
			end)()
		end
	end

	local var_8_10 = level_manager:getChapterStarsState(var_8_2, var_8_1)

	for iter_8_0 = 1, LEVEL_STARS_NUM do
		local var_8_11 = self:getChildByName("star" .. iter_8_0)

		if var_8_10[iter_8_0] then
			var_8_11:setVisible(true)
		else
			var_8_11:setVisible(false)
		end
	end

	self:getChildByName("item"):getChildByName("icon").chapter = self.chapter
end

function ChapterSpriteUmaru:updateTimer(arg_10_1)
	self:getChildByName("timer"):setString(arg_10_1)
end
