PopMsgLayer = class("PopMsgLayer", function()
	return PopBaseLayer:create()
end)

local Utility = require("common.Utility")
local playermodel = require("model.playermodel")
local var_0_2 = config._DEBUG and 0 or 1
local var_0_3 = {
	YES_AND_CANCEL = 2,
	YES_ONLY = 1,
	UNKNOWN = 0
}
local var_0_4 = {
	DIAMOND = 1
}
local var_0_5 = {
	[var_0_4.DIAMOND] = "public/currency/UI_battleEnd_diamond.png"
}
local var_0_6 = {
	DEFAULT = 0
}
local var_0_7 = {
	[var_0_6.DEFAULT] = "public/panelbg/title_default.png"
}

function PopMsgLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopMsgLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopMsgLayer:init(arg_3_1)
	self:initData(arg_3_1)
	self:initUI()
	self:registerEvents()
	self:show()
end

function PopMsgLayer:initData(arg_4_1)
	if arg_4_1 then
		self.msgType = arg_4_1.msgType or var_0_3.UNKNOWN
	end

	if arg_4_1 then
		self.cancelCallBack = arg_4_1.cancelCallBack or nil
	end

	if arg_4_1 then
		self.confirmCallBack = arg_4_1.confirmCallBack or nil
	end

	if arg_4_1 then
		self.strTitle = arg_4_1.strTitle or ""
	end

	if arg_4_1 then
		self.titleFlag = arg_4_1.titleFlag or var_0_6.DEFAULT
	end

	if arg_4_1 then
		self.costInfo = arg_4_1.costInfo or {}
	end

	self.costType = self.costInfo.costType or arg_4_1.costType
	self.costImg = self.costInfo.costImg or arg_4_1.costImg
	self.costNum = self.costInfo.costNum or arg_4_1.costNum or 0
	self.strInfo = arg_4_1.strInfo or ""

	if arg_4_1 then
		self.buttons = arg_4_1.buttons or {}
	end

	self.ownNum = self.costInfo.ownNum or 0

	if self.costType == var_0_4.DIAMOND then
		self.ownNum = playermodel.diamond
	end
end

function PopMsgLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopMsgLayer.json" or "PopMsgLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self:addChild(self.rootNode)
	self.rootNode:setPositionY(-GameDisplay.fix_y)

	self.rootpanel = self.rootNode:getChildByName("rootPanel")

	self.rootpanel:setContentSize(GameDisplay.size)
	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(GameDisplay.size.height / 2)
	self.rootpanel:setTouchEnabled(false)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)

	self.imgBg = self.panelMain:getChildByName("imgBg")
	self.labelInfo = self.imgBg:getChildByName("labelInfo")
	self.imgTitle = self.panelMain:getChildByName("imgTitle")
	self.labelTitle = self.panelMain:getChildByName("labelTitle")
	self.btnCancel = self.panelMain:getChildByName("btnCancel")
	self.btnConfirm = self.panelMain:getChildByName("btnConfirm")
	self.imgCost = self.panelMain:getChildByName("imgCost")
	self.labelCost = self.imgCost:getChildByName("labelCost")

	self:updateLayout()
end

function PopMsgLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.rootNode, function()
		if self.cancelCallBack then
			self.cancelCallBack()
		end

		self:hide()
	end)
	Utility:addClickEventListener(self.btnCancel, handler(self, self.onBtnCancel))
	Utility:addClickEventListener(self.btnConfirm, handler(self, self.onBtnConfirm))
end

function PopMsgLayer:updateLayout()
	if self.msgType == var_0_3.UNKNOWN then
		self.btnConfirm:setVisible(false)
		self.btnCancel:setVisible(false)
	elseif self.msgType == var_0_3.YES_ONLY then
		self.btnCancel:setVisible(false)
		self.btnConfirm:setPositionX(320)
	end

	self.labelInfo:setString(self.strInfo)
	self.labelTitle:setString(self.strTitle)
	self.imgTitle:setVisible(self.strTitle == "")
	self.imgTitle:loadTexture(var_0_7[self.titleFlag], var_0_2)
	self.labelCost:setString("x" .. self.costNum)

	if self.ownNum and self.ownNum < self.costNum then
		self.labelCost:setColor(cc.c3b(255, 0, 0))
	else
		self.labelCost:setColor(cc.c3b(255, 255, 255))
	end

	if self.costNum == 0 or not self.costType and not self.costImg then
		self.imgCost:setVisible(false)
	else
		self.imgCost:loadTexture(self.costImg or var_0_5[self.costType], self.costInfo.loadTextureType or var_0_2)
	end

	if self.costInfo then
		if self.costInfo.posIcon then
			self.imgCost:setPosition(self.costInfo.posIcon)
			self.labelInfo:setPositionY(self.labelInfo:getPositionY() + 60)
			self.labelCost:setString(self.costNum .. "/" .. self.ownNum)
		end

		self.imgCost:setScale(self.costInfo.scaleIcon or 1)
		self.labelCost:setScale(1 / self.imgCost:getScale())
		self.labelCost:setColor(self.costInfo.colorLabel or cc.c3b(255, 255, 255))

		if self.costInfo.posLabel then
			self.labelCost:setPosition(self.costInfo.posLabel)
			self.labelCost:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
			self.labelCost:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
			self.labelCost:setAnchorPoint(0.5, 0.5)
		end
	end

	if self.buttons.cancel then
		self.btnCancel:setTitleText(self.buttons.cancel.label or "取消")
		self.btnCancel:setTitleColor(self.buttons.cancel.color or cc.c3b(255, 255, 255))
	end

	if self.buttons.confirm then
		if self.buttons.confirm.img then
			self.btnConfirm:loadTextures(self.buttons.confirm.img, nil, self.buttons.confirm.img, var_0_2)
		end

		self.btnConfirm:setTitleText(self.buttons.confirm.label or "确定")
		self.btnConfirm:setTitleColor(self.buttons.confirm.color or cc.c3b(255, 255, 255))
	end
end

function PopMsgLayer:onBtnConfirm(arg_9_1)
	if self.confirmCallBack then
		self.confirmCallBack()
	end

	self:hide()
end

function PopMsgLayer:onBtnCancel(arg_10_1)
	if self.cancelCallBack then
		self.cancelCallBack()
	end

	self:hide()
end

function PopMsgLayer.onEnter(arg_11_0)
	return
end

function PopMsgLayer.onExit(arg_12_0)
	return
end

function PopMsgLayer:show()
	self.showActions.extendVertical(self)
end

function PopMsgLayer:hide()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
