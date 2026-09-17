ExploreTalkLayer = class("ExploreTalkLayer", function()
	return cc.NodeGrid:create()
end)

local playermodel = require("model.playermodel")
local l2utils = require("controller.l2utils")
local explore_manager = require("controller.explore_manager")
local conversation_data = require("data.conversation_data")
local model_data = require("data.model_data")
local var_0_5 = config._DEBUG and 0 or 1

function ExploreTalkLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ExploreTalkLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ExploreTalkLayer:init(arg_3_1)
	self.classification = arg_3_1.classification or 1
	self.finishCallback = arg_3_1.finishCallback
	self.selectConfig = arg_3_1.select_talk_conf or {}
	self.waitPrintText = false
	self.effectLock = false
	self.lineNum = 1
	self.dialogTabel = {}
	self.effectTbl = {}
	self.select = {}
	self.selectTalks = {
		self.classification
	}
	self.lastIcon = nil
	self.reviewDialogTabel = {}

	self:initConversation()
	self:initUI()
	self:registeTouchEvent()
	self:showNext()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			l2utils:removeNodeShake(self.roleImg)
		end
	end)
end

function ExploreTalkLayer:registeTouchEvent()
	self.touchLayer:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.waitPrintText then
			self:showAll()
		else
			self:showNext()
		end
	end)
end

function ExploreTalkLayer:initUI()
	self.touchLayer = ccui.Layout:create()

	self.touchLayer:setContentSize(cc.size(640, GameDisplay.height))
	self.touchLayer:setTouchEnabled(true)
	self:addChild(self.touchLayer, 999)

	self.effectLayer = ccui.Layout:create()

	self.effectLayer:setTouchEnabled(false)
	self.effectLayer:setContentSize(cc.size(640, GameDisplay.height))
	self:addChild(self.effectLayer, 999)
	self:initTextUI()
end

function ExploreTalkLayer:initTextUI()
	local var_8_0 = explore_manager:isHpInherit()
	local var_8_1 = ccui.ImageView:create("explore/talk_bottom.png", var_0_5)

	var_8_1:setScaleX(640 / var_8_1:getContentSize().width)
	var_8_1:setAnchorPoint(cc.p(0, 0))
	var_8_1:setPosition(0, 0)
	self:addChild(var_8_1)

	self.textBg = ccui.ImageView:create("explore/talk_bg.png", var_0_5)

	if var_8_0 then
		self.textBg = ccui.ImageView:create("explore/hpInherit/talk_bg.png", var_0_5)
	end

	self.textBg:setAnchorPoint(cc.p(0.5, 0))
	self.textBg:setPosition(320, 46)
	self:addChild(self.textBg)

	self.roleImg = cc.Sprite:create("roleimage/role1/1.png")

	self.roleImg:setAnchorPoint(cc.p(0.5, 0))
	self.roleImg:setPosition(100, 10)
	self.roleImg:setScale(0.6)
	self.textBg:addChild(self.roleImg)

	self.next_bnt = ccui.Button:create("explore/talk_next.png", "explore/talk_next.png", "explore/talk_next.png", var_0_5)

	if var_8_0 then
		self.next_bnt = ccui.Button:create("explore/hpInherit/talk_next.png", "explore/hpInherit/talk_next.png", "explore/hpInherit/talk_next.png", var_0_5)
	end

	self.next_bnt:setPosition(580, 22)
	self.textBg:addChild(self.next_bnt)

	self.skip_bnt = ccui.Button:create("explore/talk_skip.png", "explore/talk_skip.png", "explore/talk_skip.png", var_0_5)

	if var_8_0 then
		self.skip_bnt = ccui.Button:create("explore/hpInherit/talk_skip.png", "explore/hpInherit/talk_skip.png", "explore/hpInherit/talk_skip.png", var_0_5)
	end

	self.skip_bnt:setPosition(547, 240)
	self:addChild(self.skip_bnt, 999)

	local var_8_2 = ccui.ImageView:create("explore/aim_title_bg.png", var_0_5)

	if var_8_0 then
		var_8_2 = ccui.ImageView:create("explore/hpInherit/aim_title_bg.png", var_0_5)
	end

	var_8_2:setAnchorPoint(cc.p(0, 1))
	var_8_2:setPosition(200, self.textBg:getContentSize().height - 2)
	self.textBg:addChild(var_8_2)

	self.nameText = cc.Label:createWithTTF("", FONT_NAME, 30)

	self.nameText:setColor(cc.c3b(0, 216, 255))

	if var_8_0 then
		self.nameText:setColor(cc.c3b(230, 0, 0))
	end

	self.nameText:setAnchorPoint(cc.p(0, 0.5))
	self.nameText:setPosition(0, var_8_2:getContentSize().height / 2)
	var_8_2:addChild(self.nameText)

	local var_8_3 = ccui.ImageView:create("explore/talk_text_bg.png", var_0_5)

	if var_8_0 then
		var_8_3:loadTexture("explore/hpInherit/talk_text_bg.png", var_0_5)
	end

	var_8_3:setPosition(400, 85)
	self.textBg:addChild(var_8_3)

	self.wordBack = var_8_3
	self.button_review = ccui.Button:create("public/talk/new_huifang.png", nil, "public/talk/new_huifang.png", var_0_5)

	self.button_review:setPosition(320, 240)
	self:addChild(self.button_review, 999)

	self.richText = ccui.RichText:create()
	self.richText.index_tbl = {}

	self.richText:setVerticalSpace(5)
	self.richText:ignoreContentAdaptWithSize(false)
	self.richText:setPosition(402, 85)
	self.richText:setContentSize(cc.size(404, 100))
	self.textBg:addChild(self.richText, 9)

	self.normalText = cc.Label:createWithTTF("", FONT_NAME, 23)

	self.normalText:setColor(cc.c3b(190, 213, 228))
	self.normalText:setMaxLineWidth(404)
	self.normalText:setAnchorPoint(cc.p(0, 1))
	self.normalText:setPosition(200, 135)
	self.textBg:addChild(self.normalText, 9)
	self.skip_bnt:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:jumpToSelect()
	end)
	self.button_review:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:reviewConversation()
	end)
end

function ExploreTalkLayer:jumpToSelect()
	for iter_11_0, iter_11_1 in ipairs(self.dialogTabel) do
		if (iter_11_1.showName == L_EXPLORETALK_ME or iter_11_1.next_classification_1) and iter_11_0 >= self.lineNum then
			self.lineNum = iter_11_0
			self.waitPrintText = false
			self.lastIcon = nil

			self:showNext()

			break
		elseif iter_11_0 == #self.dialogTabel then
			self:runAction(cc.RemoveSelf:create())

			if self.finishCallback then
				self.finishCallback(self.selectTalks)

				self.finishCallback = nil
			end
		end
	end
end

function ExploreTalkLayer:initConversation()
	for iter_12_0, iter_12_1 in pairs(conversation_data) do
		if iter_12_1.classification == self.classification then
			table.insert(self.dialogTabel, iter_12_1)
		end
	end

	table.sort(self.dialogTabel, function(arg_13_0, arg_13_1)
		return arg_13_0.id < arg_13_1.id
	end)

	self.selectTalkInfos = {}

	for iter_12_2, iter_12_3 in pairs(self.selectConfig) do
		self.selectTalkInfos[iter_12_3.talkid] = iter_12_3
	end
end

function ExploreTalkLayer.decodeDes(arg_14_0, arg_14_1)
	local var_14_0 = 0
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in arg_14_1:gmatch("([^<-^>]+)") do
		var_14_1[#var_14_1 + 1] = {
			dec = iter_14_0
		}

		if iter_14_0:find("#") then
			var_14_1[#var_14_1].dec = var_14_1[#var_14_1].dec:match("([^#]+)")

			local var_14_2 = {}

			for iter_14_2 in iter_14_0:gmatch("([%d]+)") do
				var_14_2[#var_14_2 + 1] = iter_14_2
			end

			var_14_1[#var_14_1].color = {
				r = var_14_2[1],
				g = var_14_2[2],
				b = var_14_2[3]
			}
		else
			var_14_1[#var_14_1].color = {
				g = 213,
				b = 228,
				r = 190
			}
		end

		var_14_0 = var_14_0 + string.len(var_14_1[#var_14_1].dec)
		var_14_1[#var_14_1].strLen = var_14_0
	end

	return var_14_1, var_14_0
end

local function var_0_7(arg_15_0, arg_15_1)
	if #arg_15_0 > #arg_15_1.select then
		for iter_15_0 = 1, #arg_15_0 - #arg_15_1.select do
			local var_15_0 = ccui.Button:create("public/talk/new_duihua.png", nil, "public/talk/new_duihua.png", var_0_5)

			arg_15_1.selectLayer:addChild(var_15_0, 1000)
			var_15_0:setTouchEnabled(true)
			table.insert(arg_15_1.select, var_15_0)

			local var_15_1 = ccui.Layout:create()

			var_15_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			var_15_1:setBackGroundColor(cc.c3b(0, 0, 0))
			var_15_1:setBackGroundColorOpacity(120)
			var_15_1:setVisible(false)
			var_15_1:setContentSize(var_15_0:getContentSize())
			var_15_1:setName("mask")
			var_15_0:addChild(var_15_1, 999)

			local var_15_2 = ccui.ImageView:create("public/button/lock.png", var_0_5)

			var_15_2:setVisible(false)
			var_15_2:setName("lockicon")
			var_15_2:setPosition(var_15_0:getContentSize().width - var_15_2:getContentSize().width - 10, var_15_0:getContentSize().height / 2)
			var_15_0:addChild(var_15_2, 2)
		end
	end

	for iter_15_1, iter_15_2 in pairs(arg_15_1.select) do
		iter_15_2:setVisible(false)
	end
end

function ExploreTalkLayer:checkMyConservation()
	local var_16_0 = false

	if self.dialogTabel[self.lineNum].showName == L_EXPLORETALK_ME or self.dialogTabel[self.lineNum].next_classification_1 then
		var_16_0 = true

		local var_16_1 = self:genMyConservation(self.dialogTabel[self.lineNum])

		if not self.selectLayer then
			self.selectLayer = ccui.Layout:create()

			self.selectLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			self.selectLayer:setBackGroundColor(cc.c3b(0, 0, 0))
			self.selectLayer:setCascadeOpacityEnabled(false)
			self.selectLayer:setBackGroundColorOpacity(100)
			self.selectLayer:setTouchEnabled(true)
			self.selectLayer:setContentSize(cc.size(640, GameDisplay.height))
			self:addChild(self.selectLayer, 1001)
		end

		var_0_7(var_16_1, self)
		self.selectLayer:setVisible(true)
		self:dealMyConservation(self.dialogTabel[self.lineNum], var_16_1)
	else
		table.insert(self.reviewDialogTabel, {
			showName = self.dialogTabel[self.lineNum].showName,
			dec = self.dialogTabel[self.lineNum].dec
		})

		if self.selectLayer then
			self.selectLayer:setVisible(false)
		end
	end

	return var_16_0
end

function ExploreTalkLayer.genMyConservation(arg_17_0, arg_17_1)
	local var_17_0 = {}

	while arg_17_1["dec_" .. 1] do
		table.insert(var_17_0, arg_17_1["dec_" .. 1])
	end

	return var_17_0
end

function ExploreTalkLayer:dealMyConservation(arg_18_1, arg_18_2)
	local function var_18_0(arg_19_0, arg_19_1)
		if arg_19_0:getChildByName("richTextWord") then
			arg_19_0:getChildByName("richTextWord"):removeFromParent()
		end

		local var_19_0 = require("view.Sprite.RichTextPro"):create()

		var_19_0:setMaxWidth(560)
		var_19_0:setSize(28)
		var_19_0:setLineSpace(0)

		if not string.find(arg_19_1, "^%b<>.+%b<>$") then
			arg_19_1 = table.concat({
				"<p>",
				arg_19_1,
				"</p>"
			})
		end

		var_19_0:setText(arg_19_1, nil, true)

		local var_19_1, var_19_2 = var_19_0:getContentSize()

		if var_19_2 >= 58 then
			var_19_0:setPosition(cc.p(313 - var_19_1 / 2, 85))
		else
			var_19_0:setPosition(cc.p(313 - var_19_1 / 2, 70))
		end

		var_19_0:setName("richTextWord")
		arg_19_0:addChild(var_19_0, 100000)
	end

	local function var_18_1(arg_20_0)
		if not self.selectTalkInfos[arg_20_0] then
			return true
		end

		if not self.selectTalkInfos[arg_20_0].unlock_type then
			return true
		end

		local var_20_0 = {
			ROLE = 2,
			TALK = 3,
			ITEM = 1
		}
		local var_20_1 = {
			[var_20_0.ITEM] = function(arg_21_0, arg_21_1)
				arg_21_0 = tonumber(arg_21_0)

				if explore_manager.curMapConfig.itemcache[arg_21_0] and arg_21_1 <= explore_manager.curMapConfig.itemcache[arg_21_0].number then
					return true
				else
					return false
				end
			end,
			[var_20_0.ROLE] = function(arg_22_0)
				for iter_22_0, iter_22_1 in pairs(explore_manager.curMapConfig.followQueue) do
					if arg_22_0 == iter_22_1.tileInfo.model then
						return true
					end
				end

				return false
			end,
			[var_20_0.TALK] = function(arg_23_0)
				arg_23_0 = tonumber(arg_23_0)

				for iter_23_0, iter_23_1 in pairs(self.select) do
					if arg_23_0 == iter_23_1 then
						return true
					end
				end

				return false
			end
		}

		setmetatable(var_20_1, {
			__index = function()
				return function()
					return false
				end
			end
		})
		print("???????", self.selectTalkInfos[arg_20_0].unlock_type, self.selectTalkInfos[arg_20_0].unlock_param1, self.selectTalkInfos[arg_20_0].unlock_param2)

		return var_20_1[self.selectTalkInfos[arg_20_0].unlock_type](self.selectTalkInfos[arg_20_0].unlock_param1, self.selectTalkInfos[arg_20_0].unlock_param2)
	end

	if #arg_18_2 == 1 then
		self.select[1]:setVisible(true)
		self.select[1]:setPosition(cc.p(320, 568 + GameDisplay.fix_y))
		var_18_0(self.select[1], arg_18_2[1])
		self.select[1]:addTouchEventListener(function(arg_26_0, arg_26_1)
			if arg_26_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_18_1.next_classification_1 then
				self:dealSelectBtn(arg_18_1.next_classification_1, arg_18_1.dec_1)
			else
				table.insert(self.reviewDialogTabel, {
					showName = arg_18_1.showName,
					dec = arg_18_1.dec
				})

				self.lineNum = self.lineNum + 1

				self:showNext()
			end
		end)
	else
		for iter_18_0 = 1, #arg_18_2 do
			self.select[iter_18_0]:setVisible(true)
			var_18_0(self.select[iter_18_0], arg_18_2[iter_18_0])
			self.select[iter_18_0]:setPosition(320, 623 + GameDisplay.fix_y + (iter_18_0 - (#self.select + 1) / 2) * (self.select[iter_18_0]:getContentSize().height + 15))
			print("??????????", var_18_1(arg_18_1["next_classification_" .. iter_18_0]))

			if not var_18_1(arg_18_1["next_classification_" .. iter_18_0]) then
				self.select[iter_18_0]:getChildByName("mask"):setVisible(true)
				self.select[iter_18_0]:getChildByName("lockicon"):setVisible(true)

				self.select[iter_18_0].isLock = true
			else
				self.select[iter_18_0]:getChildByName("mask"):setVisible(false)
				self.select[iter_18_0]:getChildByName("lockicon"):setVisible(false)

				self.select[iter_18_0].isLock = false
			end

			self.select[iter_18_0]:addTouchEventListener(function(arg_27_0, arg_27_1)
				if arg_27_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_27_0.isLock then
					global_ShowBlockWords(self.selectTalkInfos[arg_18_1["next_classification_" .. iter_18_0]].unlock_des or L_BOND_TIPS.NO_MATCH)
					self:runAction(cc.CallFunc:create(function()
						self:setVisible(true)
						self:setOpacity(255)
					end))

					return
				end

				if arg_18_1["next_classification_" .. iter_18_0] then
					self:dealSelectBtn(arg_18_1["next_classification_" .. iter_18_0], arg_18_1["dec_" .. iter_18_0])
					table.insert(self.selectTalks, arg_18_1["next_classification_" .. iter_18_0])
				else
					table.insert(self.reviewDialogTabel, {
						showName = arg_18_1.showName,
						dec = arg_18_1.dec
					})

					self.lineNum = self.lineNum + 1

					self:showNext()
				end
			end)
		end
	end
end

function ExploreTalkLayer.resetStatus(arg_29_0)
	arg_29_0.lineNum = 1
	arg_29_0.waitPrintText = false
	arg_29_0.lastIcon = nil
end

function ExploreTalkLayer:dealSelectBtn(arg_30_1, arg_30_2)
	table.insert(self.reviewDialogTabel, {
		showName = L_EXPLORETALK_ME,
		dec = arg_30_2
	})

	self.dialogTabel = {}
	self.classification = arg_30_1

	self:initConversation()
	self.selectLayer:setVisible(false)
	self:resetStatus()
	self:showNext()
end

function ExploreTalkLayer:showNext()
	if self.effectLock then
		return
	end

	if self.lineNum > #self.dialogTabel then
		self:runAction(cc.RemoveSelf:create())

		if self.finishCallback then
			self.finishCallback(self.selectTalks)

			self.finishCallback = nil
		end

		return
	end

	if self:checkMyConservation() then
		return
	end

	if self.dialogTabel[self.lineNum].icon then
		self.roleImg:setVisible(true)

		local var_31_0 = tostring(self.dialogTabel[self.lineNum].icon)

		if not model_data[var_31_0] then
			print("modelid = " .. var_31_0 .. "not exist")
		end

		self.roleImg:setTexture("roleimage/role1/" .. model_data[var_31_0].cute_Q .. ".png")
		self.roleImg:setFlippedX(self.dialogTabel[self.lineNum].isFlippedX and true or false)

		if self.roleImg.last_modeid ~= var_31_0 then
			l2utils:shakeNode(self.roleImg, {
				scanlinethreshold = 0.025,
				driftpixel = 0,
				waitframe = 0,
				shakeframe = 12,
				restoreframe = 12,
				scanlinedriftfac = 5
			})
			self.roleImg:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
				l2utils:removeNodeShake(self.roleImg)
			end)))

			self.roleImg.last_modeid = var_31_0
		end
	else
		self.roleImg:setVisible(false)
	end

	if self.dialogTabel[self.lineNum].showName == L_EXPLORETALK_SHOWNAME.Show_Name[1] then
		self.nameText:setString(playermodel.nickname)
	else
		self.nameText:setString(self.dialogTabel[self.lineNum].showName or L_EXPLORETALK_SHOWNAME.Show_Name[2])
	end

	self.normalText:setString("")

	if next(self.richText.index_tbl) ~= nil then
		self.richText:removeFromParent()

		self.richText = nil
		self.richText = ccui.RichText:create()
		self.richText.index_tbl = {}
		self.richText.str_tbl = nil

		self.richText:setVerticalSpace(5)
		self.richText:ignoreContentAdaptWithSize(false)
		self.richText:setPosition(402, 85)
		self.richText:setContentSize(cc.size(404, 100))
		self.textBg:addChild(self.richText, 9)
	end

	self:playTalkEffect(function()
		self.effectLock = false
		self.waitPrintText = true

		;(function()
			local function var_34_0()
				self.waitPrintText = false
				self.lineNum = self.lineNum + 1
			end

			local var_34_1 = self.dialogTabel[self.lineNum].dec

			if self.wordBack:getChildByName("richTextWord") then
				self.wordBack:getChildByName("richTextWord"):removeFromParent()
			end

			if not var_34_1 then
				if var_34_0 then
					var_34_0()
				end

				return
			end

			local var_34_2 = require("view.Sprite.RichTextPro"):create()

			var_34_2:setMaxWidth(390)
			var_34_2:setSize(23)
			var_34_2:setLineSpace(0)
			var_34_2:setplayAni(1)

			if not string.find(var_34_1, "^%b<>.+%b<>$") then
				var_34_1 = table.concat({
					"<p>",
					var_34_1,
					"</p>"
				})
			end

			var_34_2:setText(var_34_1, var_34_0, true)
			var_34_2:setPosition(cc.p(self.wordBack:getContentSize().width / 2 - 200, self.wordBack:getContentSize().height / 2 + 50))
			var_34_2:setName("richTextWord")
			self.wordBack:addChild(var_34_2, 100000)
		end)()
	end)
end

function ExploreTalkLayer:showAll()
	if not self.dialogTabel[self.lineNum].dec then
		return
	end

	if self.wordBack:getChildByName("richTextWord") then
		self.wordBack:getChildByName("richTextWord"):removeFromParent()
	end

	local var_36_0 = self.dialogTabel[self.lineNum].dec
	local var_36_1 = require("view.Sprite.RichTextPro"):create()

	var_36_1:setMaxWidth(390)
	var_36_1:setSize(23)
	var_36_1:setLineSpace(0)

	if not string.find(var_36_0, "^%b<>.+%b<>$") then
		var_36_0 = table.concat({
			"<p>",
			var_36_0,
			"</p>"
		})
	end

	var_36_1:setText(var_36_0, nil, true)
	var_36_1:setPosition(cc.p(self.wordBack:getContentSize().width / 2 - 200, self.wordBack:getContentSize().height / 2 + 50))
	var_36_1:setName("richTextWord")
	self.wordBack:addChild(var_36_1, 100000)

	self.waitPrintText = false
	self.lineNum = self.lineNum + 1
end

function ExploreTalkLayer:playTalkEffect(arg_37_1)
	local var_37_0 = false

	if self.dialogTabel[self.lineNum].black_screen then
		(function(arg_38_0)
			self.effectLock = true
			var_37_0 = true

			self.effect_layer:setBackGroundColor(cc.c3b(0, 0, 0))
			self.effect_layer:setBackGroundColorOpacity(255)
			self.effect_layer:setOpacity(255)
			self.effect_layer:runAction(cc.Sequence:create(cc.Blink:create(0.3, 1), cc.DelayTime:create(arg_38_0), cc.FadeOut:create(0.3), cc.CallFunc:create(arg_37_1)))
		end)(self.dialogTabel[self.lineNum].black_screen_time)
	end

	if self.dialogTabel[self.lineNum].shock_screen then
		(function(arg_39_0, arg_39_1)
			self.effectLock = true
			var_37_0 = true

			local var_39_0 = {}

			for iter_39_0 = 1, 3 do
				var_39_0[iter_39_0] = cc.Sequence:create(cc.MoveBy:create(0.05 / (iter_39_0 * iter_39_0), cc.p(arg_39_0 * 10 / iter_39_0, arg_39_1 * 10 / iter_39_0)), cc.MoveBy:create(0.05 / (iter_39_0 * iter_39_0), cc.p(-(arg_39_0 * 10 / iter_39_0), -(arg_39_1 * 10 / iter_39_0))), cc.MoveBy:create(0.05 / (iter_39_0 * iter_39_0), cc.p(-(arg_39_0 * 10 / iter_39_0), -(arg_39_1 * 10 / iter_39_0))), cc.MoveBy:create(0.05 / (iter_39_0 * iter_39_0), cc.p(arg_39_0 * 10 / iter_39_0, arg_39_1 * 10 / iter_39_0)))
			end

			self:runAction(cc.Sequence:create(var_39_0[1], var_39_0[2], var_39_0[3], cc.CallFunc:create(arg_37_1)))
		end)(2, 5)
	end

	if self.dialogTabel[self.lineNum].splash_screen then
		(function(arg_40_0)
			self.effectLock = true
			var_37_0 = true

			self.effect_layer:setBackGroundColor(cc.c3b(255, 255, 255))
			self.effect_layer:setBackGroundColorOpacity(255)
			self.effect_layer:setOpacity(255)
			self.effect_layer:runAction(cc.Sequence:create(cc.Blink:create(0.3, 1), cc.DelayTime:create(arg_40_0), cc.FadeOut:create(0.3), cc.CallFunc:create(arg_37_1)))
		end)(self.dialogTabel[self.lineNum].splash_screen_time)
	end

	if self.dialogTabel[self.lineNum].color then
		(function(arg_41_0)
			self.effectLock = true
			var_37_0 = true
			self.panel_access = ccui.Layout:create()

			self.panel_access:setContentSize(cc.size(640, 1136))
			self.panel_access:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)

			if arg_41_0 == "black" then
				self.panel_access:setBackGroundColor(cc.c3b(0, 0, 0))
			else
				self.panel_access:setBackGroundColor(cc.c3b(255, 255, 255))
			end

			self.panel_access:setAnchorPoint(cc.p(0.5, 0.5))
			self.panel_access:setPosition(cc.p(320, 568))
			rootLayout:addChild(self.panel_access, 10)
			self.panel_access:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(arg_37_1)))
		end)(self.dialogTabel[self.lineNum].color)
	end

	if not false and arg_37_1 then
		arg_37_1()
	end
end

function ExploreTalkLayer:reviewConversation()
	local var_42_1 = ccui.ListView:create()

	var_42_1:setVisible(true)
	var_42_1:setContentSize(GameDisplay.getScreenSize())
	var_42_1:setTouchEnabled(true)
	var_42_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_42_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_42_1:setBackGroundColorOpacity(200)

	if self.parenttype and self.parenttype == 1 then
		var_42_1:setPositionY(var_42_1:getPositionY() - GameDisplay.fix_y)
	end

	local var_42_2 = ccui.Layout:create()

	var_42_2:setContentSize(cc.size(640, 66))
	var_42_1:pushBackCustomItem(var_42_2)

	for iter_42_0 = 1, #self.reviewDialogTabel do
		local var_42_3 = ccui.Layout:create()

		var_42_3:setVisible(true)

		local var_42_4 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_42_4:setAnchorPoint(cc.p(0, 0))

		if self.reviewDialogTabel[iter_42_0].showName then
			var_42_4:setString(self.reviewDialogTabel[iter_42_0].showName .. ":" or playermodel.nickname .. ":" or L_EXPLORETALK_SHOWNAME.Show_Name[2] .. ":")
		else
			var_42_4:setString(L_EXPLORETALK_SHOWNAME.Show_Name[2] .. ":")
		end

		if var_42_4:getString() == L_EXPLORETALK_ME .. ":" then
			var_42_4:setString(L_MONITOR .. ":")
		end

		var_42_3:addChild(var_42_4)

		local var_42_6 = self.reviewDialogTabel[iter_42_0].dec
		local var_42_7 = require("view.Sprite.RichTextPro"):create()

		var_42_7:setMaxWidth(460)
		var_42_7:setSize(24)
		var_42_7:setLineSpace(0)

		if not string.find(var_42_6, "^%b<>.+%b<>$") then
			var_42_6 = table.concat({
				"<p>",
				var_42_6,
				"</p>"
			})
		end

		var_42_7:setText(var_42_6, nil, true)
		var_42_7:setPosition(cc.p(40, 200))
		var_42_3:addChild(var_42_7, 100000)

		local var_42_8 = var_42_7:getContentHeight()

		var_42_4:setPosition(cc.p(50, var_42_8 - 3))
		var_42_7:setPosition(cc.p(var_42_4:getPositionX() + var_42_4:getContentSize().width, var_42_4:getPositionY() + 24))
		var_42_3:setContentSize(cc.size(640, var_42_8 + var_42_4:getContentSize().height))
		var_42_1:pushBackCustomItem(var_42_3)
	end

	self:addChild(var_42_1, 1000)
	var_42_1:addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_43_0:getTouchBeganPosition().y - arg_43_0:getTouchEndPosition().y) < 10 then
			var_42_1:runAction(cc.RemoveSelf:create())
		end
	end)
end
