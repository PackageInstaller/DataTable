local UniteTokenSuccessPop = class("UniteTokenSuccessPop", require("app.fairyGUI.uniteToken.UI_UniteTokenSuccessPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/uniteToken/uniteToken",
		resName = "UniteTokenSuccessPop",
		pkgName = "uniteToken",
		isFullScreen = true
	})
end)
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.config.unite_token_info
local var_0_3 = g.core.common.Path
local UniteTokenConst = require("app.view.module.uniteToken.const.UniteTokenConst")
local var_0_5 = g.core.model.User.uniteTokenData

function UniteTokenSuccessPop:ctor(arg_2_1, arg_2_2)
	self:showAtCenter()

	self._tokenData = arg_2_1
	self._type = arg_2_2
	self._tokenId = self._tokenData:getBaseId()
	self._name = self._tokenData:getName()
	self._quality = self._tokenData:getQuality()

	self:addClickListener(handler(self, self._onReturnBtnClick))
end

function UniteTokenSuccessPop:_onReturnBtnClick()
	var_0_1:popComponent()
end

function UniteTokenSuccessPop:onLoad()
	self.m_baseCompPop:initData({
		title = g.core.lang:get(202531),
		englishTitle = g.core.lang:get(202532),
		item = {
			type = 1,
			res = var_0_3:getUniteTokenCardImg(self._tokenData:getCfg().res_id)
		},
		quality = self._quality
	})
	self.m_infoComp:updateComp(self._tokenData)
	self.m_enterTransition:setHook("upGrade", handler(self, self._onPlayEnterSpineEff))
	self.m_enterTransition:play()
end

function UniteTokenSuccessPop:_onPlayEnterSpineEff()
	self.m_effPlaceHolder:addEffectSpine({
		remove = true,
		name = "eff_ui_uniteToken_upGrade",
		isLoop = false,
		anim = "play_" .. self._quality + 1
	})
end

function UniteTokenSuccessPop:_updateBottomView()
	self.m_starComp:setVisible(false)

	if self._currentComp then
		self._currentComp:setVisible(false)
	else
		local var_6_0 = fgui.UIPackage:createObject(UniteTokenConst.URL[self._type].pkg, UniteTokenConst.URL[self._type].comp)

		self:addChild(var_6_0)
		var_6_0:setPosition(self._childX, self._childY)
		var_6_0:setWidth(self._childSize.width)

		self._currentComp = var_6_0
	end

	self._currentComp:updateView(self._tokenData)

	if self._type == UniteTokenConst.SUCCESS_TYPE.START_UP then
		self.m_starComp:setVisible(true)

		local var_6_1 = var_0_5:getTokenStarInfo(self._tokenData:getAdvanceId(), (var_0_2.get(self._tokenId)))

		self.m_starComp:initStar({
			style = 2,
			index = 4,
			num = var_6_1.starNum,
			max = var_6_1.maxStarNum
		})
	end
end

return UniteTokenSuccessPop
