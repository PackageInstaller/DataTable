GuidePhoneLayer = class("GuidePhoneLayer", (require("view.Layer.BaseUILayer")))

local var_0_0 = string.format
local TempWidget = require("view.Sprite.TempWidget")
local QuickCell = require("view/Sprite/QuickCell")
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = "GuidePhoneLayer/"
local roleguide_jump_data = require("data.roleguide_jump_data")
local roleguide_type_data = require("data.roleguide_type_data")
local roleguide_new_type_data = require("data/roleguide_new_type_data")
local var_0_8 = {
	{
		img = "mainScenebg/guide_phone_layer_fight_guide.png"
	}
}
local var_0_9 = {}
local var_0_10 = 1
local var_0_11 = 3

function GuidePhoneLayer:ctor()
	GuidePhoneLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/guide_phone_manager"):getInstance()
	self._data = {}
end

function GuidePhoneLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = GuidePhoneLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function GuidePhoneLayer.onEnter(arg_3_0)
	GuidePhoneLayer.super.onEnter(arg_3_0)
end

function GuidePhoneLayer:onExit()
	GuidePhoneLayer.super.onExit(self)
	self:updateListViewPer()
end

function GuidePhoneLayer:init(arg_5_1)
	self:initData()
	self:initLayer()
	self:initListener()

	return true
end

function GuidePhoneLayer:initData()
	local var_6_0 = {}
	local level_manager = require("controller.level_manager")

	for iter_6_0, iter_6_1 in pairs(roleguide_type_data) do
		table.insert(var_6_0, {
			id = iter_6_1.id,
			sort = iter_6_1.sort,
			des = iter_6_1.des
		})
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		return arg_7_0.sort < arg_7_1.sort
	end)

	self._data[3] = var_6_0
end

function GuidePhoneLayer:initLayer()
	local var_8_0 = TempWidget:CreateTempLayout(self)

	var_8_0:_setBack()
	var_8_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_8_0

	TempWidget:CreateTempImg("mainScenebg/guide_phone_layer_bg.png", var_8_0, 0):center()

	local var_8_1 = TempWidget:CreateTempImg(var_0_4 .. "title.png", var_8_0)

	var_8_1:align(cc.p(0.5, 1), var_8_0:size().w / 2, var_8_0:size().h)

	local var_8_2 = TempWidget:CreateTempLabel(GUIDEPHONELAYER_CONSTANTS[1], FONT_NAME, 23, var_8_1)

	var_8_2:setMaxLineWidth(280)
	var_8_2:_setColor("8fc3fd")
	var_8_2:align(cc.p(0, 1), var_8_1:size().w / 2 + 15, var_8_1:size().h / 2 - 15)

	local var_8_3 = TempWidget:CreateTempImg(var_0_4 .. "bottom.png", var_8_0)

	var_8_3:align(cc.p(0.5, 0), var_8_0:size().w / 2, 0)

	local var_8_4 = TempWidget:CreateTempBtn("public/button/bottom_return_btn_archives.png", var_8_3)

	var_8_4:align(cc.p(0, 0), 10, 5)
	var_8_4:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	local var_8_5 = TempWidget:CreateTempListView(var_8_3)

	var_8_5:setContentSize(cc.size(var_8_3:size().w - 100, var_8_3:size().h))
	var_8_5:setDirection(ccui.ListViewDirection.horizontal)
	var_8_5:align(cc.p(1, 0.5), var_8_3:size().w, var_8_3:size().h / 2)

	self._selectList = var_8_5

	local var_8_6 = TempWidget:CreateTempListView(var_8_0)

	var_8_6:setContentSize(cc.size(var_8_0:size().w, var_8_0:size().h - var_8_3:size().h - var_8_1:size().h))
	var_8_6:setDirection(ccui.ListViewDirection.vertical)
	var_8_6:align(cc.p(0.5, 1), var_8_0:size().w / 2, var_8_0:size().h - var_8_1:size().h)

	self._listView = var_8_6

	self:initSelect()
end

function GuidePhoneLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
end

function GuidePhoneLayer:initSelect()
	for iter_12_0 = 1, var_0_11 do
		local var_12_0 = TempWidget:CreateTempLayout()

		var_12_0:setContentSize(cc.size(134, 77))

		local var_12_1 = TempWidget:CreateTempBtn(var_0_4 .. var_0_0("select_index_%d_on.png", iter_12_0), var_12_0)

		var_12_1:setVisible(iter_12_0 == var_0_10)
		var_12_1:center()
		var_12_1:setSwallowTouches(false)

		var_12_0._onBtn = var_12_1

		local var_12_2 = TempWidget:CreateTempBtn(var_0_4 .. var_0_0("select_index_%d_off.png", iter_12_0), var_12_0)

		var_12_2:setVisible(iter_12_0 ~= var_0_10)
		var_12_2:center()
		var_12_2:setSwallowTouches(false)

		var_12_0._offBtn = var_12_2

		var_12_0:_addEvent(function()
			if iter_12_0 == var_0_10 then
				return
			end

			self:updateListViewPer()

			var_0_10 = iter_12_0

			self:updateSelectIndex()
		end)
		self._selectList:pushBackCustomItem(var_12_0)
	end

	self:updateListView()
end

function GuidePhoneLayer.updateLayer(arg_14_0)
	return
end

function GuidePhoneLayer.updateRed(arg_15_0)
	return
end

function GuidePhoneLayer:updateSelectIndex()
	local var_16_0 = self._selectList:getChildren()

	for iter_16_0 = 1, #var_16_0 do
		if iter_16_0 == var_0_10 then
			var_16_0[iter_16_0]._onBtn:setOpacity(0)
			var_16_0[iter_16_0]._onBtn:show()
			var_16_0[iter_16_0]._onBtn:runAction(cc.Sequence:create(cc.FadeIn:create(0.1)))
			var_16_0[iter_16_0]._offBtn:runAction(cc.Sequence:create(cc.FadeOut:create(0.1), cc.Hide:create(), cc.FadeIn:create(0)))
		else
			var_16_0[iter_16_0]._onBtn:hide()
			var_16_0[iter_16_0]._offBtn:show()
		end
	end

	self:updateListView()
end

function GuidePhoneLayer:updateListView()
	local var_17_0 = self._listView

	self._listView:removeAllItems()

	if var_0_10 == 1 then
		self:updateListViewType1()
	elseif var_0_10 == 2 then
		self:updateListViewType2()
	elseif var_0_10 == 3 then
		self:updateListViewType3()
	end

	performWithDelay(self._listView, function()
		if var_0_9[var_0_10] then
			var_17_0:getInnerContainer():setPositionPercent(cc.p(var_17_0:getInnerContainer():getPositionPercent().x, var_0_9[var_0_10]))
		end
	end, 0.016666666666666666)
end

function GuidePhoneLayer:updateListViewType1()
	local var_19_0 = {}

	for iter_19_0 = 1, 6 do
		var_19_0[iter_19_0] = {
			title = roleguide_new_type_data[iter_19_0].title,
			des = roleguide_new_type_data[iter_19_0].des,
			jump = roleguide_new_type_data[iter_19_0].jump
		}
	end

	local var_19_1 = cc.size(self._listView:size().w, 155)

	local function var_19_2(arg_20_0)
		local var_20_0 = TempWidget:CreateTempLayout()

		var_20_0:setContentSize(var_19_1)

		local var_20_1 = var_0_4 .. "purple_layout_bg.png"
		local var_20_2 = "f06dff"

		if arg_20_0 % 2 == 0 then
			var_20_1 = var_0_4 .. "blue_layout_bg.png"
			var_20_2 = "00ffff"
		end

		local var_20_3 = TempWidget:CreateTempImg(var_20_1, var_20_0)

		var_20_3:center()

		local var_20_4 = TempWidget:CreateTempBtn(var_0_4 .. var_0_0("type_%d_%d.png", var_0_10, arg_20_0), var_20_3)

		var_20_4:align(cc.p(1, 0.5), var_20_3:size().w, var_20_3:size().h / 2)
		var_20_4:_addEvent(function()
			if var_19_0[arg_20_0].jump then
				goto_complete_system({
					jump_to_system = var_19_0[arg_20_0].jump
				})
			elseif arg_20_0 == 3 then
				require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationMainLayer", {})
			elseif arg_20_0 == 4 then
				LayerManager:pushInLayer("FastSoulStrengthLayer", {})
			elseif arg_20_0 == 6 then
				self:updateListViewPer()

				var_0_10 = 2

				performWithDelay(var_20_4, function()
					self:updateSelectIndex()
				end, 0.016666666666666666)
			else
				print("no jump")
			end
		end)

		local var_20_5 = TempWidget:CreateTempLabel(var_0_0("%.2d", arg_20_0), FONT_NAME, 45, var_20_3)

		var_20_5:_setColor("cdd2ff")
		var_20_5:align(cc.p(0, 1), 13, var_20_3:size().h - 5)

		local var_20_6 = TempWidget:CreateTempLabel(var_19_0[arg_20_0].title, FONT_NAME, 45, var_20_3)

		var_20_6:_setColor(var_20_2)
		var_20_6:align(cc.p(0, 1), 180, var_20_3:size().h - 5)

		local var_20_7 = TempWidget:CreateTempLabel(var_19_0[arg_20_0].des, FONT_NAME, 24, var_20_3)

		var_20_7:setMaxLineWidth(var_20_3:size().w - 150)
		var_20_7:align(cc.p(0, 1), 25, var_20_3:size().h / 2 + 7)

		return var_20_0
	end

	for iter_19_1 = 1, #var_19_0 do
		self._listView:pushBackCustomItem((QuickCell:Create({
			wid = var_19_1.width,
			hei = var_19_1.height,
			createCell = function()
				return var_19_2(iter_19_1)
			end
		})))
	end
end

function GuidePhoneLayer:updateListViewType2()
	local var_24_0 = {}

	for iter_24_0 = 7, 15 do
		var_24_0[#var_24_0 + 1] = {
			title = roleguide_new_type_data[iter_24_0].title,
			des = roleguide_new_type_data[iter_24_0].des,
			jump = roleguide_new_type_data[iter_24_0].jump
		}
	end

	local var_24_1 = cc.size(self._listView:size().w, 155)

	local function var_24_2(arg_25_0)
		local var_25_0 = TempWidget:CreateTempLayout()

		var_25_0:setContentSize(var_24_1)

		local var_25_1 = TempWidget:CreateTempImg(var_0_4 .. var_0_0("type_%d_%d.png", var_0_10, arg_25_0), var_25_0)

		var_25_1:center()
		TempWidget:CreateTempLabel(var_24_0[arg_25_0].title, FONT_NAME, 40, var_25_1):align(cc.p(0, 1), 260, var_25_1:size().h - 15)

		local var_25_2 = TempWidget:CreateTempLabel(var_24_0[arg_25_0].des, FONT_NAME, 24, var_25_1)

		var_25_2:setMaxLineWidth(var_25_1:size().w - 210)
		var_25_2:align(cc.p(0, 1), 200, var_25_1:size().h / 2 + 14)
		var_25_0:_addEvent(function()
			if var_24_0[arg_25_0].jump then
				goto_complete_system({
					jump_to_system = var_24_0[arg_25_0].jump
				})
			elseif arg_25_0 == 7 then
				self:showFightGuide()
			else
				print("no jump")
			end
		end)

		return var_25_0
	end

	for iter_24_1 = 1, #var_24_0 do
		self._listView:pushBackCustomItem((QuickCell:Create({
			wid = var_24_1.width,
			hei = var_24_1.height,
			createCell = function()
				return var_24_2(iter_24_1)
			end
		})))
	end
end

function GuidePhoneLayer:updateListViewType3()
	local var_28_0 = self._data[3]
	local var_28_1 = cc.size(self._listView:size().w, 155)

	local function var_28_2(arg_29_0)
		local var_29_0 = TempWidget:CreateTempLayout()

		var_29_0:setContentSize(var_28_1)

		local var_29_1 = TempWidget:CreateTempImg(var_0_4 .. var_0_0("type_%d_%d.png", var_0_10, arg_29_0), var_29_0)

		var_29_1:center()
		var_29_0:_addEvent(function()
			LayerManager:switchShowLayer("GuidePhoneJumpLayer", {
				type = var_28_0[arg_29_0].id
			})
		end)

		local var_29_2 = TempWidget:CreateTempLabel(var_28_0[arg_29_0].des, FONT_NAME, 24, var_29_1)

		var_29_2:setMaxLineWidth(var_29_1:size().w - 230)
		var_29_2:align(cc.p(0, 1), 210, var_29_1:size().h / 2 - 3)

		return var_29_0
	end

	for iter_28_0 = 1, #self._data[3] do
		self._listView:pushBackCustomItem((QuickCell:Create({
			wid = var_28_1.width,
			hei = var_28_1.height,
			createCell = function()
				return var_28_2(iter_28_0)
			end
		})))
	end
end

function GuidePhoneLayer:updateListViewPer()
	local var_32_0 = self._listView:getInnerContainer():getPositionPercent().y

	print("percent = " .. var_32_0, "selectIndex = " .. var_0_10)

	var_0_9[var_0_10] = var_32_0
end

function GuidePhoneLayer:showFightGuide()
	if not self._panelShowGuide then
		self:initFightGuide()
	end

	self._panelShowGuide:setAnchorPoint(0.5, 0.5)
	self._panelShowGuide:setPosition(self._root:getContentSize().width / 2, self._root:getContentSize().height / 2)
	self._panelShowGuide:setScale(1, 0)
	self._panelShowGuide:setVisible(true)
	self._panelShowGuide:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1.1), cc.ScaleTo:create(0.1, 1, 1)))
end

function GuidePhoneLayer:initFightGuide()
	local Utility = require("common.Utility")
	local l2utils = require("controller.l2utils")

	self._panelShowGuide = ccui.Layout:create()

	self._panelShowGuide:setContentSize(self._root:size())
	self._panelShowGuide:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self._panelShowGuide:setBackGroundColor(cc.c3b(0, 0, 0))
	self._panelShowGuide:setBackGroundColorOpacity(150)
	self._panelShowGuide:setLocalZOrder(15)
	self._root:addChild(self._panelShowGuide)
	Utility:addClickEventListener(self._panelShowGuide, function()
		self._panelShowGuide:setVisible(false)
	end)

	local var_34_2 = ccui.PageView:create()

	var_34_2:setContentSize(540, 960)
	var_34_2:setAnchorPoint(0.5, 0.5)
	var_34_2:setPosition(self._panelShowGuide:getContentSize().width / 2, self._panelShowGuide:getContentSize().height / 2)
	var_34_2:addEventListener(handler(self, self.onPageViewScroll))
	self._panelShowGuide:addChild(var_34_2)

	local var_34_3 = ccui.ListView:create()

	var_34_3:setItemsMargin(20)
	var_34_3:setPosition(0, -20)
	self._panelShowGuide:addChild(var_34_3)

	local var_34_4 = {}

	local function var_34_5(arg_36_0, arg_36_1)
		for iter_36_0, iter_36_1 in ipairs(var_34_4) do
			iter_36_1:setScale(arg_36_0 == iter_36_1 and 1.2 or 1)
			iter_36_1:setTouchEnabled(arg_36_0 ~= iter_36_1)
		end

		var_34_2:scrollToPage(arg_36_1 - 1)
	end

	for iter_34_0, iter_34_1 in ipairs(var_0_8) do
		local var_34_6 = ccui.ImageView:create(iter_34_1.img, 0)

		var_34_2:addWidgetToPage(var_34_6, iter_34_0 - 1, true)
		var_34_6:setPosition(270, 480)

		local var_34_7 = ccui.ImageView:create("", var_0_3)

		var_34_3:pushBackCustomItem(var_34_7)

		var_34_4[#var_34_4 + 1] = var_34_7

		Utility:addClickEventListener(var_34_7, var_34_5, iter_34_0)
	end

	var_34_3:setContentSize(var_34_3:getItem(0):getContentSize().width * #var_0_8 + 20 * (#var_0_8 - 1), 20)
	var_34_3:setVisible(#var_0_8 > 1)
	var_34_5(var_34_4[1], 1)
end

function GuidePhoneLayer.onPageViewScroll(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_2 == ccui.PageViewEventType.turning then
		local var_37_0 = arg_37_1:getCurPageIndex()
	end
end

return GuidePhoneLayer
