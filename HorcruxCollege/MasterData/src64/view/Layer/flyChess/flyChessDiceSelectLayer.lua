local flyChessDiceSelectLayer = class("flyChessDiceSelectLayer", (require("view.Layer.BaseUILayer")))
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_4 = 6
local var_0_5 = 7

function flyChessDiceSelectLayer:ctor()
	flyChessDiceSelectLayer.super.ctor(self)
	self:setAutoAdapt(true)
end

function flyChessDiceSelectLayer:create(arg_2_1)
	self.activityId = arg_2_1.activityId
	self.ResPath = "activity_flyChess_" .. self.activityId .. "/"

	local var_2_0 = flyChessDiceSelectLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function flyChessDiceSelectLayer:onEnter()
	flyChessDiceSelectLayer.super.onEnter(self)
end

function flyChessDiceSelectLayer:onExit()
	flyChessDiceSelectLayer.super.onExit(self)
end

function flyChessDiceSelectLayer:init(arg_5_1)
	self:initLayer(arg_5_1)
	self:initListener(arg_5_1)

	return true
end

function flyChessDiceSelectLayer:initLayer(arg_6_1)
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:_setBack()
	var_6_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_0:setBackGroundColorOpacity(100)
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempImg(self.ResPath .. "bg.png", var_6_0)

	var_6_1:align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h / 2 + 50)
	var_6_1:_addEvent(function()
		return
	end)

	local var_6_2 = {
		cc.p(var_6_1:size().w / 2 - 200, var_6_1:size().h / 2 + 100 + -50),
		cc.p(var_6_1:size().w / 2, var_6_1:size().h / 2 + 100 + -50),
		cc.p(var_6_1:size().w / 2 + 200, var_6_1:size().h / 2 + 100 + -50),
		cc.p(var_6_1:size().w / 2 - 200, var_6_1:size().h / 2 - 100 + -50),
		cc.p(var_6_1:size().w / 2, var_6_1:size().h / 2 - 100 + -50),
		cc.p(var_6_1:size().w / 2 + 200, var_6_1:size().h / 2 - 100 + -50)
	}
	local var_6_3 = 0

	if arg_6_1.eventType == var_0_4 or arg_6_1.eventType == var_0_5 then
		var_6_2 = {
			cc.p(var_6_1:size().w / 2 - 200, var_6_1:size().h / 2 + -50),
			cc.p(var_6_1:size().w / 2, var_6_1:size().h / 2 + -50),
			cc.p(var_6_1:size().w / 2 + 200, var_6_1:size().h / 2 + -50)
		}
	end

	if arg_6_1.eventType == var_0_5 then
		var_6_3 = 3
	end

	local var_6_4 = {}

	for iter_6_0 = 1, #var_6_2 do
		local var_6_5 = TempWidget:CreateTempImg(self.ResPath .. "dice_bg.png", var_6_1)

		var_6_5:align(cc.p(0.5, 0.5), var_6_2[iter_6_0].x, var_6_2[iter_6_0].y)
		var_6_5:_addEvent(function()
			self:updateSelected(iter_6_0)
		end)
		TempWidget:CreateTempImg(self.ResPath .. "dice_" .. iter_6_0 + var_6_3 .. ".png", var_6_5):align(cc.p(0.5, 0.5), var_6_5:size().w / 2, var_6_5:size().h / 2)

		local var_6_6 = TempWidget:CreateTempImg(self.ResPath .. "selected.png", var_6_5)

		var_6_6:align(cc.p(0.5, 0.5), var_6_5:size().w / 2, var_6_5:size().h / 2)
		var_6_6:hide()

		if iter_6_0 == self.selectIndex then
			var_6_6:show()
		end

		var_6_4[iter_6_0] = var_6_6
	end

	self._selectedImgTable = var_6_4

	local var_6_7 = TempWidget:CreateTempBtn(self.ResPath .. "select_btn.png", var_6_1)

	var_6_7:align(cc.p(0.5, 0), var_6_1:size().w / 2, -120)

	self._selectBtn = var_6_7
end

function flyChessDiceSelectLayer:initListener(arg_9_1)
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self._selectBtn:_addEvent(function()
		if not self.selectIndex then
			global_ShowBlockWords(L_MONOPOLY[37])

			return
		end

		if arg_9_1.callback then
			arg_9_1.callback(self.selectIndex + (arg_9_1.eventType == var_0_5 and 3 or 0))
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function flyChessDiceSelectLayer:updateLayer()
	return
end

function flyChessDiceSelectLayer:updateRed()
	return
end

function flyChessDiceSelectLayer:updateSelected(arg_14_1)
	if self.selectIndex == arg_14_1 then
		return
	end

	self.selectIndex = arg_14_1

	for iter_14_0 = 1, #self._selectedImgTable do
		if iter_14_0 == arg_14_1 then
			self._selectedImgTable[iter_14_0]:setVisible(true)
		else
			self._selectedImgTable[iter_14_0]:setVisible(false)
		end
	end
end

return flyChessDiceSelectLayer
