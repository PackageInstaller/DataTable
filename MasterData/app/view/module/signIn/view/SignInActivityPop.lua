local var_0_0 = g.core.model.User.SignInData
local SignInActivityPop = class("SignInActivityPop", require("app.fairyGUI.signIn.UI_SignInActivityPop"), function()
	return fgui.GComponent:create({
		resName = "SignInActivityPop",
		pkgPath = "ui/signIn/signIn",
		pkgName = "signIn"
	})
end)

function SignInActivityPop:ctor(arg_2_1)
	self:getView():center(true)

	self._accumulativeData = {}
	self._showAwardData = {}
	self.signedItem = nil
	self._itemTarget = nil

	if arg_2_1 and arg_2_1.endcall then
		self._closeCallBack = arg_2_1.endcall
	end

	self:_initView()
end

function SignInActivityPop:_initView()
	self.m_awardList:setVirtual()
	self:addListen(self.m_awardList)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRenderer))
	self.m_awardList:setItemProvider(handler(self, self._onAwardItemProvider))
	self.m_accumulativeList:setVirtual()
	self.m_accumulativeList:setItemRenderer(handler(self, self._onAccumulativeItemRenderer))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabControllerChanged))
	self.m_closeBtn:setClickCallBack(handler(self, self._onClickClose))
	self.m_openTransition:play()
end

function SignInActivityPop:_onClickClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	self:homeLayerAutoPopup()
end

function SignInActivityPop:_onTabControllerChanged()
	if self.m_tabController:getSelectedIndex() == 1 then
		self.m_accumulativeList:setNumItems(#var_0_0:getPreviewAwardList())
		self.m_accumulativeList:transitionShowCells("enter_up", 0.03, 1)
	else
		self.m_awardList:setNumItems((var_0_0:getCurTurnDays()))
		self.m_awardList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
	end
end

function SignInActivityPop:_onAwardItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateView(var_0_0:getSignAwardsByDay(arg_6_1 + 1), arg_6_1 + 1)
end

function SignInActivityPop:_onAwardItemProvider(arg_7_1)
	if (arg_7_1 + 1) % 7 == 0 then
		return "ui://signIn/SignInBigAwardCell"
	else
		return "ui://signIn/SignInAwardCell"
	end
end

function SignInActivityPop:_onAccumulativeItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateAwardCell({
		data = var_0_0:getPreviewAwardList()[arg_8_1 + 1]
	})
end

function SignInActivityPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SIGN_IN_INFO, self._onSignInInfoHandler, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SIGN_IN_SIGN, self._onSignInSignHandler, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SIGN_IN_AWARD, self._onSignInAwardHandler, self)

	if var_0_0:getCurTurnDays() == 0 then
		g.core.network.GameNetProxy:send_C2S_SignIn_Info({})
	else
		self:_refreshMainView()
	end
end

function SignInActivityPop:homeLayerAutoPopup()
	if self._closeCallBack then
		self._closeCallBack()

		self._closeCallBack = nil
	end
end

function SignInActivityPop:_refreshMainView()
	if tolua.isnull(self) then
		return
	end

	self.m_awardList:setNumItems((var_0_0:getCurTurnDays()))
	self.m_accumulativeList:setNumItems(#var_0_0:getPreviewAwardList())
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_signRedPointComp
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_cumulateRedPointComp
	})
end

function SignInActivityPop:receiveCompEvent(arg_12_1)
	if arg_12_1 == "activity_sign_in_item" then
		local var_12_0 = {
			...
		}

		self.signedItem = var_12_0[1]
		self._itemTarget = var_12_0[2]

		g.core.network.GameNetProxy:send_C2S_SignIn_Sign({})
	end
end

function SignInActivityPop:_onSignInSignHandler(arg_13_1, arg_13_2, arg_13_3)
	if self.signedItem ~= nil and self._itemTarget ~= nil and arg_13_3 ~= nil then
		g.core.module.ModuleManager:awardSummary({
			{
				type = self.signedItem.type,
				value = self.signedItem.value,
				size = self.signedItem.size * var_0_0:getSignAwardSize()
			}
		})
		self:_refreshMainView()
		self._itemTarget:playGetTransition()
	end
end

function SignInActivityPop:_onSignInAwardHandler(arg_14_1, arg_14_2, arg_14_3)
	g.core.module.ModuleManager:awardSummary(var_0_0:getCumulateItem(arg_14_3.id).award)
	self:_refreshMainView()
end

function SignInActivityPop:_onSignInInfoHandler()
	self:_refreshMainView()
end

return SignInActivityPop
