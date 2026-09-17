MainCityBgSelectLayer = class("MainCityBgSelectLayer", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local TableViewEx = require("view.Sprite.TableViewEx")
local var_0_2 = config._DEBUG and 0 or 1
local var_0_3 = "MainCityBgSelectLayer/"
local var_0_4 = cc.size(640, GameDisplay.height - 200)
local var_0_5 = cc.size(GameDisplay.width, 435)
local var_0_6 = "UsingLayout"
local var_0_7 = "Bg"
local var_0_8 = 10
local var_0_9 = "BuyLayout"
local var_0_10 = 10

function MainCityBgSelectLayer:ctor()
	MainCityBgSelectLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.main_city_bg_select_manager"):getInstance()
	self.bInit = false
	self.showInfo = nil
	self.curBuyInfo = nil
end

function MainCityBgSelectLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = MainCityBgSelectLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function MainCityBgSelectLayer:onEnter()
	MainCityBgSelectLayer.super.onEnter(self)
	self.manager:requestInitBackground()
end

function MainCityBgSelectLayer.onExit(arg_4_0)
	MainCityBgSelectLayer.super.onExit(arg_4_0)
end

function MainCityBgSelectLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function MainCityBgSelectLayer.initLayer(arg_6_0)
	local var_6_0 = TempWidget:CreateTempLayout(arg_6_0)

	var_6_0:setContentSize(GameDisplay.getUiScreenSize())
	var_6_0:_addEvent(function()
		return
	end)

	arg_6_0._root = var_6_0

	local var_6_1 = TempWidget:CreateTempImg("mainScenebg/girlselectlayer_bg.png", var_6_0, 0)

	var_6_1:setLocalZOrder(-1)
	var_6_1:align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h / 2)

	arg_6_0.bg = var_6_1

	local var_6_2 = TempWidget:CreateTempLayout(var_6_0)

	var_6_2:setContentSize(var_6_0:size())

	arg_6_0.tableViewLayout = var_6_2

	TempWidget:CreateTempImg(var_0_3 .. "title.png", var_6_0):align(cc.p(0.5, 1), var_6_0:size().w / 2, var_6_0:size().h - 37)

	local var_6_3 = TempWidget:CreateTempLayout(var_6_0)

	var_6_3:setContentSize(cc.size(var_6_0:size().w, 95))
	var_6_3:_addEvent(function()
		return
	end)

	arg_6_0.returnLayout = var_6_3

	local var_6_4 = TempWidget:CreateTempImg("public/button/bottom_return_btn_archives.png", var_6_3)

	var_6_4:move(50, 50)

	arg_6_0.returnBtn = var_6_4
end

function MainCityBgSelectLayer:initListener()
	self.returnBtn:_addEvent(function()
		LayerManager:removePopLayer()
	end)
end

function MainCityBgSelectLayer:initTableView()
	if not self.tableView then
		self.showInfo = self.manager:getShowInfo()

		local var_11_0 = TableViewEx:create({
			size = var_0_4,
			cellSizeForTable = function(arg_12_0, arg_12_1)
				return var_0_5.width, var_0_5.height
			end,
			tableCellAtIndex = function(self, arg_13_1)
				local var_13_0 = self:dequeueCell()

				if not var_13_0 then
					var_13_0 = cc.TableViewCell:new()
				else
					var_13_0:removeAllChildren()
				end

				var_13_0:addChild((self:createViewRowLayout(arg_13_1 + 1)))

				return var_13_0
			end,
			numberOfCellsInTableView = function(arg_14_0)
				return #self.showInfo
			end
		})

		var_11_0:setPosition(0, 100)
		self.tableViewLayout:addChild(var_11_0)

		self.tableView = var_11_0
	end
end

function MainCityBgSelectLayer:createViewRowLayout(arg_15_1)
	local var_15_0 = TempWidget:CreateTempLayout()

	var_15_0:setContentSize(var_0_5)

	local var_15_1 = cc.size(190, 422)

	if self.showInfo[arg_15_1] then
		local var_15_2 = self.manager:getColNum()
		local var_15_3 = (var_15_0:size().w - 10 * 2 - (var_15_2 - 1) * 10) / var_15_2
		local var_15_4 = self.showInfo[arg_15_1]

		for iter_15_0 = 1, var_15_2 do
			if var_15_4[iter_15_0] then
				local var_15_5 = {
					x = 10 + (iter_15_0 - 1) * (var_15_3 + 10),
					y = var_15_0:size().h / 2
				}
				local var_15_6 = TempWidget:CreateTempLayout(var_15_0)

				var_15_6:setContentSize(cc.size(var_15_3, var_15_0:size().h))
				var_15_6:align(cc.p(0, 0.5), var_15_5)
				var_15_6:setClippingEnabled(true)

				if var_15_4[iter_15_0].bgPath then
					local var_15_8 = TempWidget:CreateTempImg(var_15_4[iter_15_0].bgPath, nil, var_15_4[iter_15_0].textureType or 0)

					var_15_8:move(cc.p(var_15_1.width / 2, var_15_1.height / 2))
					var_15_8:setScale9Enabled(true)
					var_15_8:setCapInsets(cc.rect(0, 0, var_15_8:getContentSize().width, var_15_8:getContentSize().height))
					var_15_8:setContentSize(var_15_1)

					local var_15_9 = TempWidget:CreateTempBtn()

					var_15_9:ignoreContentAdaptWithSize(false)
					var_15_9:setContentSize(var_15_8:size())
					var_15_9:setSwallowTouches(false)
					var_15_9:move(var_15_8:property().center)
					var_15_8:addChild(var_15_9)
					var_15_9:_addEvent(function()
						if var_15_4[iter_15_0].haveNum > 0 then
							self:createUsingLayout(var_15_4[iter_15_0])
						elseif var_15_4[iter_15_0].showTips then
							global_ShowBlockWords(var_15_4[iter_15_0].showTips)
						elseif var_15_4[iter_15_0].cost and next(var_15_4[iter_15_0].cost) then
							self:createBuyLayout(var_15_4[iter_15_0])
						end
					end)

					local var_15_10 = var_15_4[iter_15_0].isUsing()
					local var_15_11 = var_15_4[iter_15_0].haveNum > 0
					local var_15_12 = TempWidget:CreateTempImg(var_0_3 .. "select.png", var_15_8)

					var_15_12:move(var_15_8:property().center)
					var_15_12:setVisible(var_15_11 and var_15_10)

					local var_15_13 = TempWidget:CreateTempImg(var_0_3 .. "lock.png", var_15_8)

					var_15_13:move(var_15_8:property().center)
					var_15_13:setVisible(not var_15_11)
					TempWidget:CreateTempLabel(var_15_4[iter_15_0].name, FONT_DES, 20, var_15_8):move(cc.p(var_15_8:size().w / 2, 20))

					local var_15_14 = TempWidget:CreateTempLayout(var_15_8)

					var_15_14:setContentSize(var_15_8:size())
					var_15_14:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
					var_15_14:setBackGroundColor(cc.c3b(0, 0, 0))
					var_15_14:setBackGroundColorOpacity(150)
					var_15_14:setVisible(var_15_4[iter_15_0].haveNum <= 0)

					local var_15_15 = TempWidget:CreateTempLayout(var_15_8)

					var_15_15:setContentSize(cc.size(var_15_8:size().w, 70))
					var_15_15:align(cc.p(0, 0), 0, 35)
					var_15_15:setVisible(var_15_4[iter_15_0].haveNum <= 0)

					if var_15_4[iter_15_0].cost and next(var_15_4[iter_15_0].cost) then
						local var_15_16 = GetCurrencyIcon(var_15_4[iter_15_0].cost.currencytype)

						var_15_16:align(cc.p(0, 0.5), 30, 20)
						var_15_15:addChild(var_15_16)
						TempWidget:CreateTempLabel("x" .. var_15_4[iter_15_0].cost.price or "", FONT_DES, 24, var_15_15):align(cc.p(0, 0.5), 90, 20)
					else
						local var_15_17 = 25
						local var_15_18 = TempWidget:CreateTempLabel(var_15_4[iter_15_0].showTips or "", FONT_DES, 24, var_15_15)

						var_15_18:setMaxLineWidth(var_15_15:size().w - 10)
						var_15_18:align(cc.p(0.5, 0), var_15_15:size().w / 2, 10)
						var_15_15:setContentSize(cc.size(var_15_15:size().w, var_15_15:size().h + (var_15_18:size().h - var_15_17)))
					end

					TempWidget:CreateTempLabel(L_UNLOCK .. ":", FONT_DES, 20, var_15_15):align(cc.p(0, 1), 10, var_15_15:size().h - 5)

					local var_15_19 = var_0_2 == 0 and cc.Sprite:create(var_0_3 .. "mask.png") or cc.Sprite:createWithSpriteFrameName(var_0_3 .. "mask.png")

					var_15_19:setPosition(cc.p(var_15_1.width / 2, var_15_1.height / 2))

					local var_15_20 = cc.ClippingNode:create()

					var_15_20:setInverted(false)
					var_15_20:setAlphaThreshold(0.47)
					var_15_20:setContentSize(var_15_1)
					var_15_20:setAnchorPoint(cc.p(0.5, 0.5))
					var_15_20:setPosition(var_15_6:property().center)
					var_15_20:setStencil(var_15_19)
					var_15_20:addChild(var_15_8)
					var_15_6:addChild(var_15_20)
				end
			end
		end
	end

	return var_15_0
end

function MainCityBgSelectLayer:createUsingLayout(arg_17_1)
	local var_17_0 = self._root:getChildByName(var_0_6)

	if var_17_0 then
		var_17_0:show()

		if arg_17_1.bgPath then
			var_17_0:getChildByName(var_0_7):loadTextureEx(arg_17_1.bgPath, arg_17_1.textureType or 0)
		end

		var_17_0._childData.sureBtn:_addEvent(function()
			self.manager:setBackGroundId(arg_17_1.id, function()
				local var_19_0 = MainLayer.getInstance()

				if var_19_0 then
					var_19_0:updateBackGround()
				end
			end)
		end)
	else
		var_17_0 = TempWidget:CreateTempLayout(self._root)

		var_17_0:setLocalZOrder(var_0_8)
		var_17_0:setContentSize(self._root:size())
		var_17_0:setName(var_0_6)
		var_17_0:_addEvent(function()
			var_17_0:hide()
		end)

		var_17_0._childData = {}

		if arg_17_1.bgPath then
			local var_17_3 = TempWidget:CreateTempImg(arg_17_1.bgPath, var_17_0, arg_17_1.textureType or 0)

			var_17_3:setName(var_0_7)
			var_17_3:move(var_17_0:property().center)

			local var_17_4 = TempWidget:CreateTempBtn(var_0_3 .. "sure.png", var_17_0)

			var_17_4:move(var_17_0:size().w / 2 + 150, 100)
			var_17_4:_addEvent(function()
				self.manager:setBackGroundId(arg_17_1.id, function()
					local var_22_0 = MainLayer.getInstance()

					if var_22_0 then
						var_22_0:updateBackGround()
					end
				end)
			end)

			var_17_0._childData.sureBtn = var_17_4

			local var_17_5 = TempWidget:CreateTempBtn(var_0_3 .. "cancel.png", var_17_0)

			var_17_5:move(var_17_0:size().w / 2 - 150, 100)
			var_17_5:_addEvent(function()
				var_17_0:hide()
			end)
		end
	end
end

function MainCityBgSelectLayer:createBuyLayout(arg_24_1)
	local playermodel = require("model.playermodel")

	self.curBuyInfo = arg_24_1

	local var_24_1 = self._root:getChildByName(var_0_9)

	local function var_24_2()
		if arg_24_1.cost.currencytype == 0 then
			if playermodel.diamond < arg_24_1.cost.price then
				LayerManager:pushInLayer("PopGoBuyDiamond", {
					is_need_pop_layer = 1,
					callback = function()
						self.manager:updateBuyLayout()
					end
				})
			else
				self.manager:requestUnlockBackGround(arg_24_1.id)
			end
		end
	end

	if var_24_1 then
		var_24_1:show()
		var_24_1._childData.bg:setScaleY(0.01)
		var_24_1._childData.bg:runAction(cc.ScaleTo:create(0.2, 1, 1))
		var_24_1._childData.buyBtn:_addEvent(var_24_2)
	else
		local var_24_3 = TempWidget:CreateTempLayout(self._root)

		var_24_3:setLocalZOrder(var_0_10)
		var_24_3:setName(var_0_9)
		var_24_3:setContentSize(self._root:size())
		var_24_3:_addEvent(function()
			var_24_3:hide()
		end)
		var_24_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_24_3:setBackGroundColor(cc.c3b(0, 0, 0))
		var_24_3:setBackGroundColorOpacity(100)

		var_24_3._childData = {}

		local var_24_4 = TempWidget:CreateTempImg(var_0_3 .. "bg_change_name.png", var_24_3)

		var_24_4:_addEvent(function()
			return
		end)
		var_24_4:center()
		var_24_4:setScaleY(0.01)
		var_24_4:runAction(cc.ScaleTo:create(0.2, 1, 1))

		var_24_3._childData.bg = var_24_4

		TempWidget:CreateTempImg(var_0_3 .. "buy_title.png", var_24_4):align(cc.p(0, 0), var_24_4:property().left_top)

		local var_24_5 = TempWidget:CreateTempImg(var_0_3 .. "cost_bg.png", var_24_4)

		var_24_5:setScale9Enabled(true)
		var_24_5:setCapInsets(cc.rect(0, 0, var_24_5:getContentSize().width, var_24_5:getContentSize().height))
		var_24_5:setContentSize(cc.size(var_24_4:size().w - 10, 80))
		var_24_5:align(cc.p(0.5, 0), var_24_4:size().w / 2, 5)

		var_24_3._childData.costBg = var_24_5

		local var_24_6 = GetCurrencyIcon(arg_24_1.cost.currencytype)

		var_24_6:move(cc.p(var_24_5:size().w / 2 - 25, var_24_5:size().h / 2))
		var_24_5:addChild(var_24_6)

		local var_24_7 = TempWidget:CreateTempLabel(global_trans_number(arg_24_1.cost.price), FONT_DES, 30, var_24_5)

		var_24_7:move(cc.p(var_24_5:size().w / 2 + 25, var_24_5:size().h / 2))

		var_24_3._childData.costNumText = var_24_7

		self:updateBuyLayoutCostNumText()
		TempWidget:CreateTempLabel("是否购买该背景？", FONT_DES, 30, var_24_4):move(cc.p(var_24_4:size().w / 2, var_24_4:size().h / 2 + 30))

		local var_24_8 = TempWidget:CreateTempBtn(var_0_3 .. "sure1.png", var_24_4)

		var_24_8:move(cc.p(var_24_4:size().w / 2 + 120, -50))
		var_24_8:_addEvent(var_24_2)

		var_24_3._childData.buyBtn = var_24_8

		local var_24_9 = TempWidget:CreateTempBtn(var_0_3 .. "cancel.png", var_24_4)

		var_24_9:move(cc.p(var_24_4:size().w / 2 - 120, -50))
		var_24_9:_addEvent(function()
			var_24_3:hide()
		end)
	end
end

function MainCityBgSelectLayer:updateLayer()
	self.bInit = true

	self:initTableView()
end

function MainCityBgSelectLayer:updateRed()
	if self.bInit then
		-- block empty
	end
end

function MainCityBgSelectLayer:updateBackGround()
	if self.bInit then
		self.showInfo = self.manager:getShowInfo()

		self.tableView:reloadData()
		self.tableView:setContentOffset((self.tableView:getContentOffset()))

		local var_32_0 = self._root:getChildByName(var_0_6)

		if var_32_0 then
			var_32_0:hide()
		end
	end
end

function MainCityBgSelectLayer:setBackGroundIdSuccessful()
	if self.bInit then
		self.tableView:reloadData()
		self.tableView:setContentOffset((self.tableView:getContentOffset()))

		local var_33_0 = self._root:getChildByName(var_0_6)

		if var_33_0 then
			var_33_0:hide()
		end
	end
end

function MainCityBgSelectLayer:purchaseSuccessful()
	if self.bInit then
		local var_34_0 = self._root:getChildByName(var_0_9)

		if var_34_0 then
			var_34_0:hide()
		end

		local var_34_1 = self.tableView:getContentOffset()

		self.tableView:reloadData()
		self.tableView:setContentOffset(var_34_1)

		if self.curBuyInfo then
			global_ShowBlockWords("已成功购买" .. self.curBuyInfo.name .. "背景")
		end
	end
end

function MainCityBgSelectLayer:updateBuyLayout()
	if self.bInit and self.curBuyInfo and self._root:getChildByName(var_0_9) then
		self:updateBuyLayoutCostNumText()
	end
end

function MainCityBgSelectLayer:updateBuyLayoutCostNumText()
	if self.bInit and self.curBuyInfo then
		local var_36_0 = self._root:getChildByName(var_0_9)

		if var_36_0 then
			if self.curBuyInfo.cost.currencytype == 0 then
				if require("model.playermodel").diamond >= self.curBuyInfo.cost.price then
					var_36_0._childData.costNumText:_setColor("61FFE0")
				else
					var_36_0._childData.costNumText:_setColor("FF6161")
				end
			end
		end
	end
end

return MainCityBgSelectLayer
