local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local SignInCumulateCell = class("SignInCumulateCell", require("app.fairyGUI.signIn.UI_SignInCumulateCell"))

function SignInCumulateCell:ctor()
	self._id = 0
	self._awardData = {}

	self.getSharedTrans(self, "enter_up", "CommonLongCellList", self)
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onItemAwardRender))
	self.m_getAwardBtn:addClickListener(handler(self, self._onClickGetAwardBtn))
end

function SignInCumulateCell:updateAwardCell(arg_2_1)
	self.m_dayTxt:setText(arg_2_1.data.days)
	self.m_stateController:setSelectedIndex(arg_2_1.data.state)

	self._awardData = arg_2_1.data.award
	self._id = arg_2_1.data.id

	self.m_awardList:setNumItems(#self._awardData)
end

function SignInCumulateCell:_onItemAwardRender(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awardData[arg_3_1 + 1])
end

function SignInCumulateCell:_onClickGetAwardBtn()
	g.core.network.GameNetProxy:send_C2S_SignIn_Award({
		id = self._id
	})
end

return SignInCumulateCell
