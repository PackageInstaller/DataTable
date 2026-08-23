local PrimarySelectItem = class("PrimarySelectItem", require("app.fairyGUI.recruitKnight.UI_PrimarySelectItem"))

function PrimarySelectItem:ctor()
	self._pos = -1
	self._info = nil
	self._stateData = nil

	self.m_iconBtn:addClickListener(handler(self, self._onIconBtnClicked))
	self.m_checkBtn:addClickListener(handler(self, self._onCheckBtnClicked))
	self.m_reviceBtn:addClickListener(handler(self, self._onRewardBtnClicked))
	self.m_mask:addClickListener(handler(self, self._clickMask))
end

function PrimarySelectItem:updateItem(arg_2_1, arg_2_2, arg_2_3)
	self._info = arg_2_1
	self._pos = arg_2_3
	self._stateData = arg_2_2

	local var_2_0 = g.core.lang:get(108329, {
		num = arg_2_3
	})
	local var_2_1 = next(arg_2_1)

	self.m_indexTextFront:setText(arg_2_3)
	self.m_indexTextBack:setText(arg_2_3)

	if not var_2_1 then
		local var_2_2 = 0

		var_2_0 = g.core.lang:get(109531)

		if arg_2_2.openState.state == "match" then
			var_2_2 = 1
			var_2_0 = g.core.lang:get(108328)
		end

		self.m_stateController:setSelectedIndex(var_2_2)
	elseif arg_2_2.rewardState.state == "recived" then
		self.m_stateController:setSelectedIndex(3)
	else
		self.m_stateController:setSelectedIndex(2)
	end

	self:setTitle(var_2_0)

	if var_2_1 then
		self.m_knightIcon:setIcon((g.core.common.Path:getKnightBookPicRes(g.core.config.knight_base_info.get(g.core.config.knight_info.get(self._info.knightId).res_id).painted_id)))
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			pos = arg_2_3
		}
	})

	local var_2_3 = self.m_reviceBtn:getChild("redPointComp")

	if var_2_3 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = var_2_3
		})
	end
end

function PrimarySelectItem:_onCheckBtnClicked()
	self:dispatchCompEvent("showReward", {
		pos = self._pos
	})
end

function PrimarySelectItem:_onRewardBtnClicked()
	self:dispatchCompEvent("receiveReward", {
		pos = self._pos
	})
end

function PrimarySelectItem:_onIconBtnClicked()
	if self.m_stateController:getSelectedIndex() == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108330))

		return
	end

	self:dispatchCompEvent("doRecruit", {
		pos = self._pos
	})
end

function PrimarySelectItem:resetSize()
	self.m_sizePic:setSize(cc.size(112, 140))
end

function PrimarySelectItem:_clickMask()
	return
end

return PrimarySelectItem
