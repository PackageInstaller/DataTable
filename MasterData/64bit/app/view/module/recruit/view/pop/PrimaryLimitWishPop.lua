local var_0_0 = g.core.const.ConstMgr.RecruitConst
local PrimaryLimitWishPop = class("PrimaryLimitWishPop", require("app.fairyGUI.recruitKnight.UI_PrimaryLimitWishPop"), function()
	return fgui.GComponent:create({
		pkgName = "recruitKnight",
		resName = "PrimaryLimitWishPop",
		pkgPath = "ui/recruitKnight/recruitKnight"
	})
end)

function PrimaryLimitWishPop:ctor(arg_2_1)
	self:getView():setSize(display.width, display.height)
	self:showAtCenter()

	self._curWishInfo = nil
	self._selectIdx = -1
	self._recruitId = arg_2_1

	self.m_memberList:setIniter()
	self.m_memberList:setItemRenderer(handler(self, self._onMemberItemRender))
	self.m_memberList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onWishMemberChange))
	self:addClickListener(handler(self, self._onClickClose))
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmBtnClicked))
	self.m_enterTransition:play()
end

function PrimaryLimitWishPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self._playBackEffect), self)
	self:_updateMainView()
end

function PrimaryLimitWishPop:_updateMainView()
	self._members = g.core.model.User.recruitData:getWishMembersByRecruitType(var_0_0.RECRUIT_TYPE.PRIMARY_LIMIT, self._recruitId)

	self.m_memberList:setNumItems(#self._members)

	local var_4_0 = g.core.model.User.recruitData:getWishInfo(var_0_0.RECRUIT_TYPE.PRIMARY_LIMIT) or {}

	if var_4_0 and next(var_4_0) then
		for iter_4_0, iter_4_1 in ipairs(self._members) do
			if iter_4_1:getId() == var_4_0[1].r_value then
				self._curWishInfo = var_4_0[1]

				self.m_memberList:setSelectedIndex(iter_4_0 - 1)

				break
			end
		end
	end
end

function PrimaryLimitWishPop:_onConfirmBtnClicked()
	local var_5_0 = g.core.model.User.recruitData:getWishInfo(var_0_0.RECRUIT_TYPE.PRIMARY_LIMIT) or {}

	if not self._curWishInfo then
		g.core.module.ModuleManager:tip(g.core.lang:get(108493))

		return
	end

	local var_5_1 = self._curWishInfo
	local var_5_2

	if var_5_0 and #var_5_0 == 0 then
		var_5_2 = var_5_1
	elseif var_5_0 and #var_5_0 > 0 and var_5_1.r_value ~= var_5_0[1].r_value then
		var_5_2 = var_5_1
	end

	if not var_5_2 then
		self:_playBackEffect()

		return
	end

	g.core.network.GameNetProxy:send_C2S_NewRecruit_Luck({
		id = self._recruitId,
		wish = {
			var_5_2
		}
	})
end

function PrimaryLimitWishPop:_onMemberItemRender(arg_6_1, arg_6_2)
	local var_6_0 = self._members[arg_6_1 + 1]:getId()

	arg_6_2:getChild("maskPic"):setIcon(g.core.common.Path:getMiddleKnightPicById(var_6_0))
	arg_6_2:setTitle(self._members[arg_6_1 + 1]:getName())
	arg_6_2:setIcon("ui://recruitKnight/pic_zm_xs_name_" .. var_6_0)

	local var_6_1 = arg_6_2:getChild("eff")

	arg_6_2:getTransition("select"):play(function()
		var_6_1:removeAllEffect()
		var_6_1:addEffectSpine({
			isLoop = true,
			name = "eff_ui_recruitKnight_primaryLimitSelect"
		})
	end)
end

function PrimaryLimitWishPop:_onWishMemberChange(arg_8_1)
	local var_8_0 = self.m_memberList:getSelectedIndex()

	if self._selectIdx == var_8_0 then
		return
	end

	self._selectIdx = var_8_0

	self.m_memberList:getChildAt((self.m_memberList:itemIndexToChildIndex(var_8_0))):getTransition("select"):play()

	self._curWishInfo = {
		pos = 1,
		r_type = self._members[var_8_0 + 1]:getType(),
		r_value = self._members[var_8_0 + 1]:getId()
	}
end

function PrimaryLimitWishPop:_onClickClose(arg_9_1)
	if arg_9_1 then
		if not self.m_mask:containPoint((arg_9_1:getInput():getTouch():getLocation())) then
			self:_playBackEffect()
		end
	end
end

function PrimaryLimitWishPop:_playBackEffect()
	self.m_backTransition:play(handler(self, self._onClose))
end

function PrimaryLimitWishPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return PrimaryLimitWishPop
