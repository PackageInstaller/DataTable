local HorcruxDevourLayer = class("HorcruxDevourLayer", (require("view.Layer.BaseUILayer")))

require("view/Sprite/TitleSprite")
require("view/Sprite/BottomBtnList")
require("view/Sprite/RichTextPro")
require("view.Sprite.HorcruxSprite")

local var_0_1 = {
	s = "public/rolebg/h_fac_s.png",
	a = "public/rolebg/h_fac_grade_a.png",
	s_plus = "public/rolebg/h_fac_s_plus.png",
	b_minus = "public/rolebg/h_fac_grade_b_minus.png",
	b_plus = "public/rolebg/h_fac_grade_b_plus.png",
	a_minus = "public/rolebg/h_fac_grade_a_minus.png",
	b = "public/rolebg/h_fac_grade_b.png",
	c = "public/rolebg/h_fac_grade_c.png",
	a_puls = "public/rolebg/h_fac_a_puls.png"
}
local TempWidget = require("view.Sprite.TempWidget")
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = "HorcruxDevourLayer/"
local horcrux_manager = require("controller/horcrux_manager")
local playermodel = require("model.playermodel")
local total_skill_data = require("data.total_skill_data")
local servant_data = require("data.servant_data")

function HorcruxDevourLayer:ctor()
	HorcruxDevourLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/horcrux_devour/horcrux_devour_manager"):getInstance()
end

function HorcruxDevourLayer:create(arg_2_1)
	local var_2_0 = HorcruxDevourLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function HorcruxDevourLayer:onEnter()
	HorcruxDevourLayer.super.onEnter(self)
	self.manager:registerNotification("HorcruxDevourSucceeded", function(arg_4_0)
		self:updateListView()
	end)
	self.manager:registerNotification("CoreResetSuccess", function(arg_5_0)
		self:updateListView()
	end)
	self.manager:registerNotification("StrengthenCoreSuccess", function(arg_6_0)
		self:updateListView()
	end)
	self.manager:registerNotification("HorcruxDevourConfirmNewSkillSucceeded", function(arg_7_0)
		self:updateListView()
	end)
	self.manager:registerNotification("HorcruxDevourChenge", function(arg_8_0)
		self:updateListView()
	end)
	self.manager:registerNotification("DisassembleHorcruxSuccess", function(arg_9_0)
		self:updateListView()
	end)
	self.manager:registerNotification("HorcruxLevelUpSucceeded", function(arg_10_0)
		self:updateListView(arg_10_0)
	end)
	self.manager:registerNotification("HorcruxBreakoutSucceeded", function(arg_11_0)
		self:updateListView(arg_11_0)
	end)
	self.manager:registerNotification("HorcruxUpStarSucceeded", function(arg_12_0)
		self:updateListView(arg_12_0)
	end)
end

function HorcruxDevourLayer:onExit()
	HorcruxDevourLayer.super.onExit(self)
end

function HorcruxDevourLayer:init(arg_14_1)
	self._servantId = arg_14_1.servantId

	self:initLayer()
	self:initListener()

	return true
end

function HorcruxDevourLayer:initLayer()
	local var_15_0 = TempWidget:CreateTempLayout(self)

	var_15_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_15_0

	TempWidget:CreateTempImg("mainScenebg/equip_skillinfo_bg.png", var_15_0, 0):center()

	local var_15_1 = TitleSprite:create("public/title/title_skill_detail.png", 2)

	var_15_1.title:setPositionX(0)
	var_15_1:setAnchorPoint(cc.p(0, 1))
	var_15_1:setPosition(0, var_15_0:size().h)
	var_15_1:setName("titleBg")
	var_15_0:addChild(var_15_1, 5)

	local var_15_2 = TempWidget:CreateTempBtn(var_0_4 .. "help.png", var_15_1)

	var_15_2:align(cc.p(0.5, 0.5), 200, var_15_1:getContentSize().height / 2)

	self._helpBtn = var_15_2

	local var_15_3 = TempWidget:CreateTempLayout(var_15_0)

	var_15_3:setContentSize(cc.size(var_15_0:size().w, 50))
	var_15_3:align(cc.p(0.5, 1), var_15_0:size().w / 2, var_15_1:getPositionY() - var_15_1:getContentSize().height)

	self._recommendedLayout = var_15_3

	self:initRecommendedLayout()

	local var_15_4 = BottomBtnList:create(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end, {
		{
			name = "btn_select",
			word = L_HORCRUX_DEVOUR[1],
			handler = function(arg_17_0, arg_17_1)
				if arg_17_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_17_0 = 1

				for iter_17_0 = 1, HORCRUX_DEVOUR_MAX do
					if not self.manager:getSkillInfo(self._servantId, iter_17_0) then
						var_17_0 = iter_17_0

						break
					end
				end

				LayerManager:pushInLayer("HorcruxDevourSelectLayer", {
					servantId = self._servantId,
					selectIndex = var_17_0
				})
			end
		}
	})

	var_15_0:addChild(var_15_4, 5)

	local var_15_5 = TempWidget:CreateTempListView(var_15_0)

	var_15_5:setContentSize(cc.size(var_15_0:size().w, var_15_3:pos().y - var_15_3:size().h - var_15_4:getContentSize().height))
	var_15_5:align(cc.p(0, 0), 0, var_15_4:getContentSize().height)
	var_15_5:setBackGroundColorOpacity(100)

	self._listView = var_15_5

	self:initListView()
end

function HorcruxDevourLayer:initRecommendedLayout()
	local var_18_0 = TempWidget:CreateTempLabel(L_HORCRUX_DEVOUR[51], FONT_NAME, 20, self._recommendedLayout)

	var_18_0:align(cc.p(0, 0.5), 10, self._recommendedLayout:size().h / 2)

	local var_18_1 = TempWidget:CreateTempLabel(L_COMPONENT_STRENGTHEN[11], FONT_NAME, 20, self._recommendedLayout)

	var_18_1:align(cc.p(0, 0.5), 355, self._recommendedLayout:size().h / 2)

	local var_18_2 = TempWidget:CreateTempImg(ATTRICONPATH[global_get_all_model_attrs(servant_data[self._servantId].modelid).main], self._recommendedLayout)

	var_18_2:setScale(0.4)
	var_18_2:align(cc.p(0, 0.5), 355 + var_18_1:getContentSize().width, self._recommendedLayout:size().h / 2)

	if global_get_all_model_attrs(servant_data[self._servantId].modelid).sub then
		local var_18_3 = TempWidget:CreateTempImg(ATTRICONPATH[global_get_all_model_attrs(servant_data[self._servantId].modelid).sub[1]], self._recommendedLayout)

		var_18_3:setScale(0.4)
		var_18_3:align(cc.p(0, 0.5), 355 + var_18_1:getContentSize().width + var_18_2:getContentSize().width * 0.5, self._recommendedLayout:size().h / 2)
		TempWidget:CreateTempLabel(L_HORCRUX_DEVOUR[56], FONT_NAME, 20, self._recommendedLayout):align(cc.p(0, 0.5), 355 + var_18_1:getContentSize().width + var_18_2:getContentSize().width * 0.5 + var_18_3:getContentSize().width * 0.5, self._recommendedLayout:size().h / 2)
	else
		TempWidget:CreateTempLabel(L_HORCRUX_DEVOUR[56], FONT_NAME, 20, self._recommendedLayout):align(cc.p(0, 0.5), 355 + var_18_1:getContentSize().width + var_18_2:getContentSize().width * 0.5, self._recommendedLayout:size().h / 2)
	end

	local var_18_4 = servant_data[self._servantId].race1
	local var_18_5 = TempWidget:CreateTempImg("public/rolebg/" .. servant_data[self._servantId].race1 .. ".png", self._recommendedLayout)

	var_18_5:setScale(0.4)
	var_18_5:align(cc.p(0, 0.5), var_18_0:pos().x + var_18_0:size().w + 10, self._recommendedLayout:size().h / 2)
	var_18_5:_addEvent(function()
		local var_19_0 = self.manager:getTypeSkillId(var_18_4)

		if var_19_0 then
			local var_19_1 = TempWidget:CreateTempLayout()

			var_19_1:setContentSize(self._root:size())
			var_19_1:_setBack()
			var_19_1:setBackGroundColor(cc.c3b(0, 0, 0))
			var_19_1:setBackGroundColorOpacity(120)
			var_19_1:_addEvent(function()
				var_19_1:runAction(cc.RemoveSelf:create())
			end)
			var_19_1:center()
			var_19_1:setLocalZOrder(999)
			self._root:addChild(var_19_1)

			local var_19_2 = ccui.ImageView:create(var_0_4 .. "skill_des_bg.png", var_0_3)

			var_19_2:setPosition(cc.p(var_19_1:getContentSize().width / 2, var_19_1:getContentSize().height / 2))
			var_19_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_19_1:addChild(var_19_2)

			local var_19_3 = ccui.Layout:create()

			var_19_3:setContentSize(cc.size(500, 124))
			var_19_3:setAnchorPoint(cc.p(0, 0))
			var_19_3:setPosition(cc.p(70, 500 + GameDisplay.fix_y))
			var_19_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			var_19_3:setBackGroundColor(cc.c3b(0, 0, 0))
			var_19_3:setBackGroundColorOpacity(0)
			var_19_1:addChild(var_19_3, 2)

			local var_19_4 = ccui.ImageView:create(var_0_4 .. "normal_skill_frame.png", var_0_3)

			var_19_4:setPosition(cc.p(58, 63))
			var_19_4:setAnchorPoint(cc.p(0.5, 0.5))
			var_19_3:addChild(var_19_4)

			local var_19_5 = ccui.ImageView:create("public/rolebg/" .. var_18_4 .. ".png", var_0_3)

			var_19_5:setScale(0.88)
			var_19_5:setPosition(cc.p(58, 63))
			var_19_3:addChild(var_19_5)

			local var_19_6 = cc.Label:createWithTTF(total_skill_data[var_19_0].name, FONT_DES, 24)

			var_19_6:setAnchorPoint(cc.p(0, 0.5))
			var_19_6:setPosition(cc.p(121, 96))
			var_19_3:addChild(var_19_6)

			if total_skill_data[var_19_0].cd then
				local var_19_7 = cc.Label:createWithTTF(L_SIKILL_CD .. total_skill_data[var_19_0].cd .. "s", FONT_DES, 20)

				var_19_7:setAnchorPoint(cc.p(1, 0.5))
				var_19_7:setPosition(cc.p(473, 96))
				var_19_3:addChild(var_19_7)
			end

			local var_19_8 = transSkillDesToRichText(total_skill_data[var_19_0].description)
			local var_19_9 = RichTextPro:create()

			var_19_9:setMaxWidth(380)
			var_19_9:setSize(20)
			var_19_9:setColor(cc.c3b(220, 251, 241))
			var_19_9:setLineSpace(0)
			var_19_9:setText(var_19_8)
			var_19_9:setName("richText")
			var_19_9:setPosition(cc.p(120, 86))
			var_19_3:addChild(var_19_9)
		end
	end)
end

function HorcruxDevourLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self._helpBtn:_addEvent(function()
		LayerManager:pushInLayer("PopActivityDetail", {
			key = "horcrux_devour"
		})
	end)
end

function HorcruxDevourLayer:initListView()
	for iter_24_0 = 1, HORCRUX_DEVOUR_MAX do
		self._listView:pushBackCustomItem((self:createSkillLayout(iter_24_0)))
	end
end

function HorcruxDevourLayer:createSkillLayout(arg_25_1)
	local var_25_0 = self.manager:getDevourHorcruxMinDataFromIndex(self._servantId, arg_25_1 - 1)
	local var_25_1 = TempWidget:CreateTempLayout()

	var_25_1:setContentSize(cc.size(self._root:size().w, 240))
	var_25_1:_addEvent(function()
		if not self.manager:isUnlock(self._servantId, arg_25_1) then
			LayerManager:pushInLayer("SoulStrengthLayer", {
				topServants = {
					self._servantId
				}
			})
		else
			local var_26_0 = self.manager:getSkillInfo(self._servantId, arg_25_1)

			if not var_26_0 then
				LayerManager:pushInLayer("HorcruxDevourSelectLayer", {
					servantId = self._servantId,
					selectIndex = arg_25_1
				})

				local var_26_1 = require("controller.horcrux_devour.horcrux_devour_select_manager"):getInstance()
				local var_26_2 = 1
				local var_26_3 = {
					isHorcruxDevour = true,
					selectType = SELECT_HORCRUX_DEVOUR,
					outSide = {},
					selectGirlServantId = self._servantId,
					selectCallback = function()
						print("selectCallback")
					end,
					outSide = {}
				}
				local var_26_4 = {
					attrFilter = 1 == 1
				}

				var_26_4.index = 1
				var_26_4.selectIndex = arg_25_1

				local var_26_5 = var_26_1:getOutSideHorcruxs(self._servantId, var_26_4)

				for iter_26_0 = 1, #var_26_3.outSide do
					var_26_5[#var_26_5 + 1] = var_26_3.outSide[iter_26_0]
				end

				var_26_3.outSide = var_26_5
				var_26_3.mainHorcrux = var_26_2 == 1

				var_26_1:setSelectIndex(var_26_2)
				LayerManager:pushInLayer("HorcruxSelectLayer", var_26_3)
			else
				LayerManager:pushInLayer("HorcruxInfoLayer", var_26_0.horcrux, "horcruxlayer", false, {
					isDevour = true,
					devourPos = arg_25_1,
					servantId = self._servantId
				})
			end
		end
	end)
	TempWidget:CreateTempImg(var_0_4 .. "skill_line.png", var_25_1):align(cc.p(0.5, 0), var_25_1:size().w / 2, 0)

	local var_25_2 = TempWidget:CreateTempLayout(var_25_1)

	var_25_2:setContentSize(var_25_1:size())

	local var_25_3 = TempWidget:CreateTempImg(var_0_4 .. "title.png", var_25_2)

	var_25_3:align(cc.p(1, 1), var_25_2:size().w, var_25_2:size().h)

	local var_25_4 = RichTextPro:create()

	var_25_4:setMaxWidth(var_25_3:size().w - 10)
	var_25_4:setSize(24)
	var_25_4:setColor(cc.c3b(220, 251, 241))
	var_25_4:setLineSpace(0)
	var_25_4:setName("richText1")
	var_25_4:setPosition(cc.p(200, var_25_2:size().h / 2))
	var_25_4:setText((transSkillDesToRichText(string.format(L_HORCRUX_DEVOUR[45], var_25_0.star))))
	var_25_2:addChild(var_25_4, 2)

	local var_25_5 = TempWidget:CreateTempImg(var_0_4 .. "horcrux_bg.png", var_25_2)

	var_25_5:align(cc.p(0, 0.5), 20, var_25_2:size().h / 2)
	TempWidget:CreateTempImg(var_0_4 .. "lock_img.png", var_25_5):center()

	local var_25_6 = TempWidget:CreateTempLayout(var_25_1)

	var_25_6:setContentSize(var_25_1:size())

	local var_25_7 = TempWidget:CreateTempImg(var_0_4 .. "title.png", var_25_6)

	var_25_7:align(cc.p(1, 1), var_25_6:size().w, var_25_6:size().h)

	local var_25_8 = RichTextPro:create()

	var_25_8:setMaxWidth(var_25_7:size().w - 10)
	var_25_8:setSize(24)
	var_25_8:setColor(cc.c3b(220, 251, 241))
	var_25_8:setLineSpace(0)
	var_25_8:setName("richText1")
	var_25_8:setPosition(cc.p(200, var_25_6:size().h / 2))
	var_25_8:setText((transSkillDesToRichText(string.format(L_HORCRUX_DEVOUR[45], var_25_0.star))))
	var_25_6:addChild(var_25_8, 2)

	local var_25_9 = TempWidget:CreateTempImg(var_0_4 .. "horcrux_bg.png", var_25_6)

	var_25_9:align(cc.p(0, 0.5), 20, var_25_6:size().h / 2)
	TempWidget:CreateTempImg(var_0_4 .. "horcrux_add.png", var_25_9):center()

	local var_25_10 = self:createStarLayout()

	var_25_9:addChild(var_25_10)
	var_25_10._update(var_25_0.star)
	var_25_10:align(cc.p(0.5, 0), var_25_9:size().w / 2, 5)
	var_25_9:setName("noSkill_horcrux_bg" .. arg_25_1)

	local var_25_11 = TempWidget:CreateTempLayout(var_25_1)

	var_25_11:setContentSize(var_25_1:size())

	local var_25_12 = TempWidget:CreateTempImg(var_0_4 .. "title.png", var_25_11)

	var_25_12:align(cc.p(1, 1), var_25_11:size().w, var_25_11:size().h)
	var_25_12:setName("img")

	local var_25_13 = TempWidget:CreateTempImg(var_0_4 .. "atk.png", var_25_12)
	local var_25_14 = RichTextPro:create()

	var_25_14:setMaxWidth(var_25_12:size().w - 10)
	var_25_14:setSize(24)
	var_25_14:setColor(cc.c3b(220, 251, 241))
	var_25_14:setLineSpace(0)
	var_25_14:setName("richText")
	var_25_14:setPosition(cc.p(var_25_1:size().w / 2 + 60, var_25_1:size().h - 50))
	var_25_14:setText((transSkillDesToRichText(string.format(L_HORCRUX_DEVOUR[2], self.manager:getUnlockLevel(arg_25_1)))))
	var_25_1:addChild(var_25_14, 3)
	var_25_13:align(cc.p(0, 0.5), var_25_12:size().w / 2 - 60, var_25_12:size().h / 2)

	local var_25_15 = TempWidget:CreateTempImg(var_0_4 .. "value_bg.png", var_25_12)

	var_25_15:align(cc.p(0, 0.5), var_25_13:pos().x + var_25_13:size().w + 5, var_25_12:size().h / 2)

	local var_25_16 = TempWidget:CreateTempLabel("atk", FONT_NAME, 20, var_25_15)

	var_25_16:align(cc.p(0, 0.5), 10, var_25_15:size().h / 2)

	local var_25_17 = TempWidget:CreateTempImg(var_0_1.c, var_25_15)

	var_25_17:align(cc.p(1, 0.5), var_25_15:size().w - 10, var_25_15:size().h / 2)

	local var_25_18 = TempWidget:CreateTempImg(var_0_4 .. "hp.png", var_25_12)

	var_25_18:align(cc.p(0, 0.5), var_25_15:pos().x + var_25_15:size().w + 5, var_25_12:size().h / 2)

	local var_25_19 = TempWidget:CreateTempImg(var_0_4 .. "value_bg.png", var_25_12)

	var_25_19:align(cc.p(0, 0.5), var_25_18:pos().x + var_25_18:size().w + 5, var_25_12:size().h / 2)

	local var_25_20 = TempWidget:CreateTempLabel("hp", FONT_NAME, 20, var_25_19)

	var_25_20:align(cc.p(0, 0.5), 10, var_25_19:size().h / 2)

	local var_25_21 = TempWidget:CreateTempImg(var_0_1.c, var_25_19)

	var_25_21:align(cc.p(1, 0.5), var_25_19:size().w - 10, var_25_19:size().h / 2)

	local var_25_22 = TempWidget:CreateTempImg(var_0_4 .. "common_skill_frame.png", var_25_11)

	var_25_22:setScale(0.8)
	var_25_22:align(cc.p(0.5, 0.5), 190, var_25_11:size().h / 2 + 30)

	local var_25_23 = TempWidget:CreateTempImg("skill_new/skill/20100.png", var_25_22)

	var_25_23:setScale(0.84)
	var_25_23:center()

	local var_25_24 = TempWidget:CreateTempImg(var_0_4 .. "repeat.png", var_25_23)

	var_25_24:setScale(1.4)
	var_25_24:center()

	local var_25_25 = TempWidget:CreateTempLabel("skillNameLabel1", FONT_NAME, 24, var_25_11)

	var_25_25:_setColor("00ffle")
	var_25_25:align(cc.p(0, 1), var_25_22:pos().x + var_25_22:size().w / 2, var_25_11:size().h / 2 + 70)

	local var_25_26 = RichTextPro:create()

	var_25_26:setAnchorPoint(cc.p(0, 1))
	var_25_26:setPosition(cc.p(var_25_25:pos().x, var_25_25:pos().y - var_25_25:size().h - 5))
	var_25_26:setMaxWidth(var_25_11:size().w - var_25_26:getPositionX() - 15)
	var_25_26:setSize(22)
	var_25_26:setText("")
	var_25_26:setLineSpace(0)
	var_25_11:addChild(var_25_26)

	local var_25_27 = TempWidget:CreateTempImg(var_0_4 .. "common_skill_frame.png", var_25_11)

	var_25_27:setScale(0.8)
	var_25_27:align(cc.p(0.5, 0.5), 190, var_25_11:size().h / 2 - 70)

	local var_25_28 = TempWidget:CreateTempImg("skill_new/skill/20100.png", var_25_27)

	var_25_28:setScale(0.84)
	var_25_28:center()

	local var_25_29 = TempWidget:CreateTempImg(var_0_4 .. "repeat.png", var_25_28)

	var_25_29:setScale(1.4)
	var_25_29:center()

	local var_25_30 = TempWidget:CreateTempLabel("skillNameLabel2", FONT_NAME, 24, var_25_11)

	var_25_30:_setColor("00ffle")
	var_25_30:align(cc.p(0, 1), var_25_22:pos().x + var_25_22:size().w / 2, var_25_11:size().h / 2 - 30)

	local var_25_31 = RichTextPro:create()

	var_25_31:setAnchorPoint(cc.p(0, 1))
	var_25_31:setPosition(cc.p(var_25_30:pos().x, var_25_30:pos().y - var_25_30:size().h - 5))
	var_25_31:setMaxWidth(var_25_11:size().w - var_25_31:getPositionX() - 15)
	var_25_31:setSize(22)
	var_25_31:setText("")
	var_25_31:setLineSpace(0)
	var_25_11:addChild(var_25_31)
	TempWidget:CreateTempImg(var_0_4 .. "horcrux_go.png", var_25_11):align(cc.p(1, 0.5), var_25_11:size().w - 5, var_25_11:size().h / 2 - 20)

	local var_25_32 = HorcruxSprite:create({
		initType = "previewStyle"
	})

	var_25_32:setAnchorPoint(cc.p(0, 0.5))
	var_25_11:addChild(var_25_32)
	var_25_32:setPosition(cc.p(20, var_25_11:size().h / 2 - 20))
	var_25_32:setScale(0.8)
	var_25_32:setTouchEnabled(false)

	local var_25_33 = TempWidget:CreateTempImg(var_0_4 .. "mask.png", var_25_1)

	var_25_33:setOpacity(160)
	var_25_33:center()

	function var_25_1._update()
		var_25_2:hide()
		var_25_6:hide()
		var_25_11:hide()
		var_25_24:hide()
		var_25_29:hide()

		local var_28_0 = self.manager:isUnlock(self._servantId, arg_25_1)
		local var_28_1 = self.manager:getSkillInfo(self._servantId, arg_25_1)

		var_25_14:setVisible(not var_28_0)
		var_25_33:setVisible(not var_28_0)

		local function var_28_2()
			var_25_11:show()
			var_25_14:setVisible(not var_28_0)
			var_25_33:setVisible(not var_28_0)
			var_25_16:setString(string.format(L_HORCRUX_DEVOUR[15], global_trans_number(var_28_1.damage)))
			var_25_20:setString(string.format(L_HORCRUX_DEVOUR[14], global_trans_number(var_28_1.hp)))
			var_25_17:loadTextureEx(var_0_1[horcrux_manager:getHorcruxDamageFacSectionGrade(var_28_1.horcrux)])
			var_25_21:loadTextureEx(var_0_1[horcrux_manager:getHorcruxHpFacSectionGrade(var_28_1.horcrux)])

			local var_29_0 = math.abs(var_28_1.skillid)
			local var_29_1 = math.abs(var_28_1.skillid2)

			var_25_23:loadTexture("skill_new/skill/" .. total_skill_data[var_29_0].icon .. ".png", var_0_3)
			var_25_28:loadTexture("skill_new/skill/" .. total_skill_data[var_29_1].icon .. ".png", var_0_3)

			local var_29_2 = total_skill_data[var_29_0].name
			local var_29_3 = total_skill_data[var_29_1].name

			if playermodel.items[var_28_1.horcrux].horcrux_attr.enable_skill_idxs then
				local var_29_4 = playermodel.items[var_28_1.horcrux].horcrux_attr.star or 0

				if playermodel.items[var_28_1.horcrux].horcrux_attr.enable_skill_idxs[1] == 1 then
					if var_29_4 == 6 then
						var_29_2 = var_29_2 .. "+"
						var_29_3 = var_29_3 .. "+"
					elseif var_29_4 == 7 then
						var_29_2 = var_29_2 .. "++"
						var_29_3 = var_29_3 .. "++"
					elseif var_29_4 == 8 then
						var_29_2 = var_29_2 .. "Max"
						var_29_3 = var_29_3 .. "Max"
					end
				end
			end

			var_25_25:setString(var_29_2)
			var_25_30:setString(var_29_3)
			var_25_26:clearText()
			var_25_26:setText((transSkillDesToRichText(total_skill_data[var_29_0].description)))
			var_25_31:clearText()
			var_25_31:setText((transSkillDesToRichText(total_skill_data[var_29_1].description)))
			var_25_32:update(var_28_1.horcrux)
			ccui.Helper:seekWidgetByName(var_25_32, "lock"):setVisible(false)
			var_25_32.servantclip:setVisible(false)
			var_25_32.raceIcon:setVisible(true)

			if var_28_1.skillid < 0 then
				var_25_24:show()

				if var_28_0 then
					var_25_24:loadTexture(var_0_4 .. "repeat.png", var_0_3)
				else
					var_25_24:loadTexture(var_0_4 .. "hide.png", var_0_3)
				end
			end

			if var_28_1.skillid2 < 0 then
				var_25_29:show()

				if var_28_0 then
					var_25_29:loadTexture(var_0_4 .. "repeat.png", var_0_3)
				else
					var_25_29:loadTexture(var_0_4 .. "hide.png", var_0_3)
				end
			end
		end

		if var_28_0 then
			var_25_2:hide()

			if var_28_1 then
				var_28_2()
			else
				var_25_6:show()
			end
		elseif var_28_1 then
			var_28_2()
		else
			var_25_2:show()
		end
	end

	var_25_1._update()

	return var_25_1
end

function HorcruxDevourLayer:createStarLayout()
	local var_30_0 = TempWidget:CreateTempLayout()

	var_30_0:setContentSize(cc.size(100, 30))

	local var_30_1 = TempWidget:CreateTempImg("public/currency/star1.png", var_30_0)

	var_30_1:center()

	function var_30_0._update(arg_31_0)
		var_30_1:loadTextureEx("public/currency/star" .. arg_31_0 .. ".png")
	end

	return var_30_0
end

function HorcruxDevourLayer:updateLayer()
	return
end

function HorcruxDevourLayer:updateRed()
	return
end

function HorcruxDevourLayer:updateListView()
	local var_34_0 = self._listView:getItems()

	for iter_34_0 = 1, #var_34_0 do
		var_34_0[iter_34_0]._update()
	end
end

return HorcruxDevourLayer
