local UniteTokenCommon = require("app.view.module.uniteToken.common.UniteTokenCommon")
local UniteTokenInfoPop = class("UniteTokenInfoPop", require("app.fairyGUI.uniteToken.UI_UniteTokenInfoPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		resName = "UniteTokenInfoPop",
		pkgName = "uniteToken"
	})
end)

function UniteTokenInfoPop:ctor(arg_2_1)
	self:showAtCenter()

	self._domainComp = nil

	if type(arg_2_1) == "number" then
		self._tokenData = g.core.model.User.uniteTokenData:getTokenDataBy(arg_2_1)

		if not self._tokenData then
			return
		end
	else
		self._tokenData = arg_2_1.tokenData
	end

	self:_updateView()
	self:addClickListener(handler(self, self._hideDomainComp))
end

function UniteTokenInfoPop:_updateView()
	if not self._tokenData then
		return
	end

	local var_3_0 = self._tokenData:getCfg()
	local var_3_1 = fgui.UIPackage:createObject("uniteToken", "UniteTokenInfoNameComp")

	var_3_1:setData(self._tokenData)

	local var_3_2 = fgui.GLoader:create()

	var_3_2:setAutoSize(true)
	var_3_2:setPivot(0.5, 0.5, true)
	var_3_2:setURL(g.core.common.Path:getUniteTokenCardImg(var_3_0.res_id))

	local var_3_3 = self._tokenData:getQuality()
	local var_3_4

	if var_3_3 >= g.core.const.ConstMgr.QUALITY_TYPE.UR then
		var_3_4 = fgui.UIPackage:createObject("base_new", "UniteTokenDomainButton")

		var_3_4:addClickListener(handler(self, self._onClickDomainButton))

		self._domainComp = fgui.UIPackage:createObject("base_new", "UniteTokenDomainHelpComp")

		var_3_4:addChild(self._domainComp)
		self._domainComp:setPosition(cc.p(0, var_3_4:getSize().height))
		self._domainComp:setVisible(false)
	end

	self.m_infoPopBase:setPopView({
		quality = var_3_3,
		tabParam = {
			{
				compName = "UniteTokenTabBaseComp",
				package = "uniteToken",
				title = g.core.lang:get(202501)
			},
			{
				compName = "UniteTokenTabTalentComp",
				package = "uniteToken",
				title = g.core.lang:get(202530)
			}
		},
		commonParam = {
			tokenData = self._tokenData
		},
		itemComp = var_3_2,
		nameComp = var_3_1,
		iconComp = var_3_4
	})
end

function UniteTokenInfoPop:_onAddPieceClick()
	UniteTokenCommon.openPieceGetPop(self._tokenData)
end

function UniteTokenInfoPop:_onClickDomainButton()
	if self._domainComp then
		self._domainComp:setVisible(not self._domainComp:isVisible())
	end
end

function UniteTokenInfoPop:_hideDomainComp()
	if self._domainComp then
		self._domainComp:setVisible(false)
	end
end

return UniteTokenInfoPop
