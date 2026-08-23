local var_0_0 = g.core.const.ConstMgr.RecruitConst
local RecruitTreeCell = class("RecruitTreeCell", require("app.fairyGUI.recruit.UI_RecruitTreeCell"))

function RecruitTreeCell:ctor(arg_1_1)
	self._cfg = nil
	self._otherTip = nil
	self._otherSortTip = nil
	self.m_enterTrans = self:getSharedTrans("alpha_In", "RecruitTreeList")
	self.m_buttonController = self:getController("button")

	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self.onChanged))
end

function RecruitTreeCell:onChanged()
	local var_2_0 = self.m_buttonController:getSelectedIndex()

	if var_2_0 == 1 then
		self.m_tabBgTransition:play()
		self:dispatchCompEvent("cellIndexChange", {
			index = var_2_0
		})
	end

	self:_updateOtherTip()
end

function RecruitTreeCell:updateView(arg_3_1, arg_3_2)
	if not arg_3_1 then
		return
	end

	local var_3_0 = true

	if arg_3_1.isUnlock then
		var_3_0 = arg_3_1.isUnlock()
	end

	if self._showTimeScheduler then
		self:cancelSchedule(self._showTimeScheduler)

		self._showTimeScheduler = 0
	end

	self:setAlpha(0)

	self._showTimeScheduler = self:newScheduleOnce(function()
		self:playEnterAnim()

		self._showTimeScheduler = nil
	end, arg_3_2 * 0.03)
	self._cfg = arg_3_1

	self.m_icon1:setURL(arg_3_1.iconUrl1)
	self.m_icon2:setURL(arg_3_1.iconUrl2)
	self:setTitle(arg_3_1.title)
	self.m_tipText:setText(arg_3_1.titleTip)
	self:_updateTip()

	if var_3_0 then
		self.m_isUnlockController:setSelectedIndex(1)
	else
		self.m_isUnlockController:setSelectedIndex(0)
	end

	self:updateRedPoint()
end

function RecruitTreeCell:_updateTip()
	local var_5_0 = g.core.model.User.recruitData:getDisplayInfoById(self._cfg.id)

	if var_5_0.cfg.type_label > 0 then
		self._otherTip = g.core.lang:get(108600 + var_5_0.cfg.type_label), self.m_isOtherTipController:setSelectedIndex(var_0_0.IS_OTHER_TIP.OTHER_TIP)
		self._otherSortTip = g.core.lang:get(108423)

		local var_5_1

		self.m_otherTipText:setVisible(true)

		if var_5_0.cfg.type_label == 1 then
			var_5_1 = "ui://recruit/pic_zm_tab_icon_up_1_2"
		elseif var_5_0.cfg.type_label == 2 then
			var_5_1 = "ui://recruit/pic_zm_tab_icon_up_2_2"
		elseif var_5_0.cfg.type_label == 3 then
			var_5_1 = "ui://recruit/pic_qihangup"

			self.m_isOtherTipController:setSelectedIndex(var_0_0.IS_OTHER_TIP.NEW_PLAYER)
		elseif var_5_0.cfg.type_label == 4 then
			var_5_1 = "ui://recruit/pic_zm_tab_icon_up_1_2"

			if not g.core.model.User.recruitData:isGetAdvanceRecruitFirstSSR() then
				self.m_isOtherTipController:setSelectedIndex(var_0_0.IS_OTHER_TIP.NEW_PLAYER)

				self._otherSortTip = g.core.lang:get(1264)
			else
				self.m_isOtherTipController:setSelectedIndex(var_0_0.IS_OTHER_TIP.NORMAL)
			end
		elseif var_5_0.cfg.type_label == 5 then
			var_5_1 = "ui://recruit/pic_zm_xs_biaoqian"
			self._otherSortTip = g.core.lang:get(108486)

			if not g.core.model.User.recruitData:isGetAdvanceRecruitFirstSSR() then
				self.m_isOtherTipController:setSelectedIndex(var_0_0.IS_OTHER_TIP.NEW_PLAYER)
			else
				self.m_isOtherTipController:setSelectedIndex(var_0_0.IS_OTHER_TIP.OTHER_TIP)
			end
		elseif var_5_0.cfg.type_label == 7 then
			var_5_1 = "ui://recruit/pic_zm_xs_biaoqian"
			self._otherSortTip = g.core.lang:get(108500)

			if not g.core.model.User.recruitData:isGetAdvanceRecruitFirstSSR() then
				self.m_isOtherTipController:setSelectedIndex(var_0_0.IS_OTHER_TIP.NEW_PLAYER)
			else
				self.m_isOtherTipController:setSelectedIndex(var_0_0.IS_OTHER_TIP.OTHER_TIP)
			end
		elseif var_5_0.cfg.type_label == 9 then
			var_5_1 = "ui://recruit/pic_zm_xs_biaoqian"
			self._otherSortTip = g.core.lang:get(108486)

			if not g.core.model.User.recruitData:isGetAdvanceRecruitFirstSSR() then
				self.m_isOtherTipController:setSelectedIndex(var_0_0.IS_OTHER_TIP.NEW_PLAYER)
			else
				self.m_isOtherTipController:setSelectedIndex(var_0_0.IS_OTHER_TIP.OTHER_TIP)
			end
		elseif var_5_0.cfg.type_label == 12 then
			var_5_1 = "ui://recruit/pic_zm_mbpzjiaobiaour"

			self.m_otherTipText:setVisible(false)
		elseif var_5_0.cfg.type_label == 13 then
			var_5_1 = "ui://recruit/pic_zm_mbpzjiaobiaomr"

			self.m_otherTipText:setVisible(false)
		end

		self.m_textBgLoader:setURL(var_5_1)
		self:_updateOtherTip()
	else
		self.m_isOtherTipController:setSelectedIndex(var_0_0.IS_OTHER_TIP.NORMAL)
	end
end

function RecruitTreeCell:_updateOtherTip()
	if self.m_isOtherTipController:getSelectedIndex() == var_0_0.IS_OTHER_TIP.NORMAL then
		return
	end

	if self.m_buttonController:getSelectedIndex() == 1 then
		self.m_otherTipText:setText(self._otherTip)
	else
		self.m_otherTipText:setText(self._otherSortTip)
	end
end

function RecruitTreeCell:playEnterAnim()
	self:setAlpha(1)

	if self.m_enterTrans then
		self.m_enterTrans:play()
	end
end

function RecruitTreeCell:playCloseAnim()
	if self.m_enterTrans then
		self.m_enterTrans:playReverse()
	end
end

function RecruitTreeCell:onLoad()
	if not self._cfg then
		return
	end

	self:updateRedPoint()
end

function RecruitTreeCell:updateRedPoint(arg_10_1)
	if self._cfg and self._cfg.redId then
		self.m_redPoint:setId(self._cfg.redId)
		self.m_redPoint:setVisible(true)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPoint,
			customData = {
				recruitId = (self._cfg.actId or nil) and self._cfg.actId,
				autoSave = arg_10_1
			}
		})
	else
		self.m_redPoint:setVisible(false)
	end
end

function RecruitTreeCell:onUnload()
	if self._showTimeScheduler then
		self:cancelSchedule(self._showTimeScheduler)

		self._showTimeScheduler = 0
	end
end

return RecruitTreeCell
