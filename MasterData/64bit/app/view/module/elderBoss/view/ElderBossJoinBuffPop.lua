local var_0_0 = g.core.model.User.knightsData
local ElderBossJoinBuffPop = class("ElderBossJoinBuffPop", require("app.fairyGUI.elderBoss.UI_ElderBossJoinBuffPop"), function()
	return fgui.GComponent:create({
		pkgName = "elderBoss",
		resName = "ElderBossJoinBuffPop",
		pkgPath = "ui/elderBoss/elderBoss"
	}, ...)
end)

function ElderBossJoinBuffPop:ctor(arg_2_1)
	self:showAtCenter()
	self:setSize(display.width, display.height)

	self._knightList = {}
	self._param = arg_2_1
	self._buffId = arg_2_1.buff
	self._confirmCallBack = arg_2_1.onConfirm

	self:_initView()
	self.m_enterTransition:play()
end

function ElderBossJoinBuffPop:_initView()
	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightListRenderer))
	self.m_closeBtn:addClickListener(handler(self, self._onClickCloseBtn))
	self.m_joinBtn:addClickListener(handler(self, self._onClickJoinBtn))
end

function ElderBossJoinBuffPop:_onKnightListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._knightList[arg_4_1 + 1])
end

function ElderBossJoinBuffPop:onLoad()
	self.m_descText:setText(self._param.desc)

	self._knightList = var_0_0:getSpList(self:_getKnightFilter())

	table.sort(self._knightList, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0:isOwn()

		if var_6_0 ~= arg_6_1:isOwn() then
			return var_6_0
		end

		return false
	end)
	self.m_knightList:setNumItems(#self._knightList)
end

function ElderBossJoinBuffPop:_getKnightFilter()
	return function(arg_8_0)
		return arg_8_0:getBaseInfo().classical > 0 and arg_8_0:getBaseInfo().classical == self._buffId and arg_8_0:getBaseInfo().put == 1
	end
end

function ElderBossJoinBuffPop:_onClickJoinBtn()
	if self._confirmCallBack then
		self._confirmCallBack()
	end

	self:_onClose()
end

function ElderBossJoinBuffPop:_onClickCloseBtn()
	self:_onClose()
end

function ElderBossJoinBuffPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return ElderBossJoinBuffPop
