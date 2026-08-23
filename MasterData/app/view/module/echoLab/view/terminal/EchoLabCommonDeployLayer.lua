local var_0_0 = g.core.const.ConstMgr.EchoLabConst
local var_0_1 = g.core.model.User.echoLabData
local EchoLabCommonDeployLayer = class("EchoLabCommonDeployLayer", require("app.fairyGUI.echoLab.UI_EchoLabCommonDeployLayer"), function()
	return fgui.GComponent:create({
		resName = "EchoLabCommonDeployLayer",
		pkgPath = "ui/echoLab/echoLab",
		isFullScreen = true,
		pkgName = "echoLab"
	}, ...)
end)

function EchoLabCommonDeployLayer:ctor(arg_2_1)
	self._type = arg_2_1.type
	self._cardType = arg_2_1.cardType
	self._isFirstEnter = true
	self._preCoreAttrValue = 0

	self:_initMainViewUI()
end

function EchoLabCommonDeployLayer:_initMainViewUI()
	self:addBg("bg/echoLab/bg_echo_zhongduan.jpg", nil, nil, 1)
	self.m_enterTransition:play()

	for iter_3_0, iter_3_1 in pairs((var_0_1:getAttrSumDataByCardType(self._cardType))) do
		self._preCoreAttrValue = iter_3_1
	end

	self.m_topBarComp:setReturnCallBack(handler(self, self._onClickClose))
end

function EchoLabCommonDeployLayer:onLoad()
	self:updateMainView()
end

function EchoLabCommonDeployLayer:updateMainView()
	if not self._isFirstEnter then
		self.m_backTransition:play(handler(self, self._checkCoreAttrUp))
	end

	self._isFirstEnter = false

	self.m_typeNameTxt:setText(var_0_0.EchoLabNameArray[self._type].name)
	self.m_coreComp:updateCoreComp(self._type, self._cardType)
	self.m_slotComp:updateSlotComp(self._type, self._cardType)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_ENERGYENTER)
end

function EchoLabCommonDeployLayer:_checkCoreAttrUp()
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in pairs((var_0_1:getAttrSumDataByCardType(self._cardType))) do
		var_6_0 = iter_6_1
	end

	if var_6_0 > self._preCoreAttrValue then
		self._preCoreAttrValue = var_6_0

		self.m_coreComp:playUpEff()
	end
end

function EchoLabCommonDeployLayer:_onClickClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return EchoLabCommonDeployLayer
