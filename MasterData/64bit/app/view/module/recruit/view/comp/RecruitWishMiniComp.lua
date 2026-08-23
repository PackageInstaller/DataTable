local RecruitWishMiniComp = class("RecruitWishMiniComp", require("app.fairyGUI.recruit.UI_RecruitWishMiniComp"))

function RecruitWishMiniComp:ctor()
	self._wishInfos = nil
	self._recruitType = nil

	self:_addListListeners()
end

function RecruitWishMiniComp:_addListListeners()
	self.m_wishList:setVirtual(self)
	self.m_wishList:setItemRenderer(handler(self, self._onWishItemRender))
	self.m_wishList:doFairyBatching(false)
	self:addClickListener(handler(self, self._onClickedComp))
end

function RecruitWishMiniComp:_onWishItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateItem(self._wishInfos[arg_3_1 + 1], arg_3_1 + 1)
end

function RecruitWishMiniComp:updateComp(arg_4_1, arg_4_2, arg_4_3)
	self._openTimes = g.core.model.User.recruitData:getWishOpenTimes(arg_4_2, arg_4_3)

	local var_4_0 = g.core.model.User.recruitData:getDrawInfo(arg_4_3, arg_4_2)
	local var_4_1 = 0

	if var_4_0 then
		var_4_1 = var_4_0:getTotalCount()
	end

	if var_4_1 < self._openTimes then
		self._leftTime = self._openTimes - var_4_1

		self.m_isLockController:setSelectedIndex(1)

		local var_4_2 = g.core.lang:get(108028, {
			num = self._leftTime,
			name = g.core.lang:get(108500 + arg_4_2)
		})

		self.m_lockTipText:setText(var_4_2)
		self.m_lockTempText:setText(var_4_2)
		self.m_imgBg:setHeight((math.min(math.ceil(self.m_lockTempText:getSize().width / self.m_lockTipText:getSize().width) * self.m_lockTempText:getSize().height, 114)))
	else
		self.m_isLockController:setSelectedIndex(0)
	end

	self._recruitType = arg_4_2
	self._wishInfos = {
		false,
		false
	}

	if arg_4_1 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
			if iter_4_1.r_type ~= 0 then
				self._wishInfos[iter_4_1.pos] = iter_4_1
			end
		end
	end

	if var_4_1 >= self._openTimes and arg_4_2 == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.ARTIFACT_BASE then
		self.m_redPointComp:setId(305)
	else
		self.m_redPointComp:setId(0)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
	self.m_wishList:setNumItems(1)
end

function RecruitWishMiniComp:_onClickedComp()
	if self.m_isLockController:getSelectedIndex() == 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108070, {
			name = g.core.lang:get(108500 + self._recruitType),
			name2 = g.core.lang:get(108550 + self._recruitType),
			num = self._leftTime
		}))
	end
end

function RecruitWishMiniComp:refreshRed()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function RecruitWishMiniComp:isOpen()
	return self.m_isLockController:getSelectedIndex() == 0
end

return RecruitWishMiniComp
