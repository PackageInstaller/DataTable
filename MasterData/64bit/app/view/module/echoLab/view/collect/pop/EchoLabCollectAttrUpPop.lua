local EchoLabCollectAttrUpPop = class("EchoLabCollectAttrUpPop", require("app.fairyGUI.echoLab.UI_EchoLabCollectAttrUpPop"), function()
	return fgui.GComponent:create({
		resName = "EchoLabCollectAttrUpPop",
		pkgPath = "ui/echoLab/echoLab",
		pkgName = "echoLab",
		isFullScreen = true
	})
end)

function EchoLabCollectAttrUpPop:ctor(arg_2_1, arg_2_2, arg_2_3)
	self._cardStruct = arg_2_1

	self.m_clickNode:addClickListener(handler(self, self._onClose))

	self._posY = self:getChild("title"):getPosition().y

	self:showAtCenter()
	self.m_bgLoader:setURL("pic/base_new/bg_tjshengjidi.png")
	self:_init(arg_2_2, arg_2_3)
end

function EchoLabCollectAttrUpPop:_init(arg_3_1, arg_3_2)
	if arg_3_1 then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	local var_3_0 = self._cardStruct:getCurGrade()
	local var_3_1 = var_3_0 - 1

	if arg_3_2 then
		var_3_1 = self._cardStruct:getOneKeyBeforeGrade()
	end

	self.m_levelTxt1:setText(var_3_1)
	self.m_levelTxt2:setText(var_3_0)
	self.m_knightPicComp:updatePic({
		url = self._cardStruct:getTargetPicURL()
	})
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 400, 0), 250)
	self.m_nameComp:updateView({
		name = self._cardStruct:getCardName(),
		quality = self._cardStruct:getCardQuality(true)
	})

	local var_3_2 = self._cardStruct:getAttrInfo(var_3_1) or {
		list = {},
		dict = {}
	}
	local var_3_6

	if self._cardStruct:getCfg(var_3_1) then
		var_3_6 = {
			{
				name = g.core.lang:get(408525),
				value = self._cardStruct:getCfg(var_3_0).exp_add
			}
		}
	end

	for iter_3_0, iter_3_1 in pairs(self._cardStruct:getAttrInfo(var_3_0).dict) do
		local var_3_7 = var_3_2.dict[iter_3_0] or 0

		if var_3_7 ~= iter_3_1 then
			var_3_6[#var_3_6 + 1] = {
				isAll = true,
				type = iter_3_0,
				value = var_3_7,
				value2 = iter_3_1
			}
		end
	end

	self.m_listComp:setMargin(15)
	self.m_listComp:setMidMode(true)

	for iter_3_2, iter_3_3 in ipairs(var_3_6) do
		local var_3_8 = fgui.UIPackage:createObject("base_new", "BaseAttrValueComp2")

		var_3_8:updateAttr(iter_3_3)
		self.m_listComp:addItem(var_3_8)
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_ACTIVATION)
end

function EchoLabCollectAttrUpPop:onLoad()
	self:dispatchCompEvent("echoLabCollectTipPopEnd", {
		name = "EchoLabCollectAttrUpPop"
	})

	local var_4_0 = self:getChild("title")
	local var_4_1 = var_4_0:getPosition()

	var_4_1.y = self._posY

	var_4_0:setPosition(var_4_1)
end

function EchoLabCollectAttrUpPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ECHO_LAB_COLLECT_POP_END, false)
end

function EchoLabCollectAttrUpPop:_onClose()
	g.core.module.ModuleManager:popByDisplay(self)
end

return EchoLabCollectAttrUpPop
