local var_0_0 = g.core.const.ConstMgr.RecruitConst
local RecruitWishPopBase = class("RecruitWishPopBase")

function RecruitWishPopBase:ctor(arg_1_1, arg_1_2)
	self:getView():setSize(display.width, display.height)

	self._recruitType = arg_1_1
	self._recruitId = arg_1_2
	self._changePos = 0
	self._tabIdx = 0

	self:_addListeners()

	local var_1_0 = self.m_wishList:getPosition()

	var_1_0.x = var_1_0.x + 30 * (math.max(0, display.width - 1334) / 290)

	self.m_wishList:setPosition(var_1_0)
	self:center(true)
end

function RecruitWishPopBase:_addListeners()
	self.m_closeBtn:addClickListener(handler(self, self._closeByAnim))
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmBtnClicked))
	self.m_wishList:setVirtual(self)
	self.m_wishList:setItemRenderer(handler(self, self._onWishItemRender))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabItemClick))
end

function RecruitWishPopBase:_onWishItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateItem(self._members[self._tabIdx + 1][arg_3_1 + 1], arg_3_1)
end

function RecruitWishPopBase:_onTabItemClick(arg_4_1)
	local var_4_0 = self.m_tabList:getSelectedIndex()

	if var_4_0 == self._tabIdx then
		return
	end

	self._tabIdx = var_4_0

	self:_updateView()
end

function RecruitWishPopBase:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self._close), self)
	self:_updateWishInfos()
	self.m_tabList:setSelectedIndex(self._tabIdx)
	self:_updateView()
end

function RecruitWishPopBase:_updateWishInfos()
	local var_6_0 = g.core.model.User.recruitData:getWishInfo(self._recruitType, self._recruitId) or {}

	if self._recruitType == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.LIMIT_KNIGHT_SOUL_RECRUIT and #var_6_0 == 0 then
		var_6_0 = {}
	end

	self._wishInfos = {}

	for iter_6_0 = 1, 10 do
		if not self["m_memberComp" .. iter_6_0] then
			break
		end

		self._wishInfos[iter_6_0] = false
	end

	local var_6_1 = {}
	local var_6_2

	for iter_6_1, iter_6_2 in pairs(var_6_0) do
		if iter_6_2.r_type and iter_6_2.r_type ~= 0 then
			self._wishInfos[iter_6_2.pos] = clone(iter_6_2)
			var_6_1[iter_6_2.r_value] = iter_6_2.pos
			var_6_2 = iter_6_2
		end
	end

	self._members = {
		{}
	}

	for iter_6_3, iter_6_4 in ipairs((g.core.model.User.recruitData:getWishMembersByRecruitType(self._recruitType, self._recruitId))) do
		local var_6_3 = iter_6_4:getId()
		local var_6_4 = {
			pos = var_6_1[var_6_3]
		}

		if var_6_1[var_6_3] then
			var_6_4.state = self._wishInfos[var_6_1[var_6_3]].status or nil
		end

		var_6_4.placeHolders = self._wishInfos

		if ({
			[var_0_0.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT] = true,
			[var_0_0.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT] = true
		})[self._recruitType] and var_6_2 then
			var_6_4.state = var_6_2.status
		end

		iter_6_4:updateStructNetInfo(var_6_4)

		local var_6_5 = iter_6_4:getGroup() + 1

		self._members[var_6_5] = self._members[var_6_5] or {}

		table.insert(self._members[var_6_5], iter_6_4)
		table.insert(self._members[1], iter_6_4)
	end

	self:_updateChangePos()
	self:_sort()

	self._oldWishInfos = clone(self._wishInfos)
end

function RecruitWishPopBase:_updateOtherUI()
	return
end

function RecruitWishPopBase:_updateChangePos()
	self._changePos = 0

	for iter_8_0, iter_8_1 in ipairs(self._wishInfos) do
		if iter_8_1 == false or type(iter_8_1) == "table" and (iter_8_1.status < iter_8_1.statusMax or iter_8_1.pos ~= 0) then
			self._changePos = iter_8_0

			return
		end
	end
end

function RecruitWishPopBase:_sort()
	local function var_9_0(arg_10_0, arg_10_1)
		if arg_10_0:isMaxStar() ~= arg_10_1:isMaxStar() then
			return arg_10_1:isMaxStar()
		end

		if arg_10_0:isLimitMember() ~= arg_10_1:isLimitMember() then
			return not not arg_10_0:isLimitMember()
		end

		if arg_10_0:getState() ~= arg_10_1:getState() and (arg_10_0:getState() == 1 or arg_10_1:getState() == 1) then
			return arg_10_0:getState() == 1
		end

		if arg_10_0:getQuality() ~= arg_10_1:getQuality() then
			return arg_10_0:getQuality() > arg_10_1:getQuality()
		end

		if arg_10_0:getStar() ~= arg_10_1:getStar() then
			return arg_10_0:getStar() > arg_10_1:getStar()
		end

		if arg_10_0:getLevel() ~= arg_10_1:getLevel() then
			return arg_10_0:getLevel() > arg_10_1:getLevel()
		end

		return arg_10_0:getId() < arg_10_1:getId()
	end

	for iter_9_0, iter_9_1 in ipairs(self._members) do
		table.sort(iter_9_1, var_9_0)
	end
end

function RecruitWishPopBase:_updateView()
	for iter_11_0, iter_11_1 in ipairs(self._wishInfos) do
		self:_updateWishMember((type(iter_11_1) == "table" and iter_11_1.r_type ~= 0 or nil) and self:_getMemberByTypeAndValue(iter_11_1.r_type, iter_11_1.r_value), iter_11_0)
	end

	self.m_wishList:setNumItems(#(self._members[self._tabIdx + 1] or {}))
end

function RecruitWishPopBase:_updateWishMember(arg_12_1, arg_12_2)
	local var_12_0 = self["m_memberComp" .. arg_12_2]

	if type(self._wishInfos[arg_12_2]) == "table" then
		var_12_0:updateComp(arg_12_1, arg_12_2, self._wishInfos[arg_12_2].status)
	else
		var_12_0:updateComp(arg_12_1, arg_12_2)
	end

	self.m_wishState1Controller:setSelectedIndex((var_12_0:getWishStateIndex()))

	if self._recruitType ~= var_0_0.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT and self._recruitType ~= var_0_0.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT then
		self.m_percentComp:updatePercent(self._wishInfos, arg_12_1)
	end

	self:_updateOtherUI()
end

function RecruitWishPopBase:receiveCompEvent(arg_13_1, arg_13_2)
	if arg_13_1 == "updateWishInfo" then
		local var_13_0 = arg_13_2.pos or self._changePos
		local var_13_1 = arg_13_2.info
		local var_13_2 = false

		if type(self._wishInfos[var_13_0]) == "table" then
			if self._wishInfos[var_13_0].status >= self._wishInfos[var_13_0].statusMax then
				g.core.module.ModuleManager:tip(g.core.lang:get(108655))

				return
			end

			self:_changeKnightPos(self._wishInfos[var_13_0].r_value, nil)
		end

		if var_13_1 then
			var_13_2 = {
				r_type = var_13_1:getType(),
				r_value = var_13_1:getId(),
				pos = var_13_0,
				status = var_13_1:getState(),
				statusMax = var_13_1:getWishMaxNum()
			}

			var_13_1:setPos(var_13_0)
		end

		self._wishInfos[var_13_0] = var_13_2

		self:_updateChangePos()
		self:_updateWishMember(var_13_1, var_13_0)
		self.m_wishList:setNumItems(#(self._members[self._tabIdx + 1] or {}))

		return true
	end

	return false
end

function RecruitWishPopBase:_changeKnightPos(arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(self._members) do
		for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
			if iter_14_3:getId() == arg_14_1 then
				iter_14_3:setPos(arg_14_2)

				return
			end
		end
	end
end

function RecruitWishPopBase:_getMemberByTypeAndValue(arg_15_1, arg_15_2)
	local var_15_0

	for iter_15_0, iter_15_1 in ipairs(self._members[1]) do
		if iter_15_1:getType() == arg_15_1 and iter_15_1:getId() == arg_15_2 then
			var_15_0 = iter_15_1

			break
		end
	end

	return var_15_0
end

function RecruitWishPopBase:_onConfirmBtnClicked()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self._wishInfos) do
		if type(iter_16_1) ~= type(self._oldWishInfos[iter_16_0]) then
			local var_16_1 = {
				pos = iter_16_0
			}

			if type(iter_16_1) == "table" then
				var_16_1.r_value = iter_16_1.r_value
				var_16_1.r_type = iter_16_1.r_type
			else
				var_16_1.r_value = 0
				var_16_1.r_type = 0
			end

			var_16_0[#var_16_0 + 1] = var_16_1
		elseif type(iter_16_1) == "table" and (iter_16_1.r_value ~= self._oldWishInfos[iter_16_0].r_value or iter_16_1.r_type ~= self._oldWishInfos[iter_16_0].r_type) then
			var_16_0[#var_16_0 + 1] = {
				pos = iter_16_0,
				r_value = iter_16_1.r_value,
				r_type = iter_16_1.r_type
			}
		end
	end

	if not next(var_16_0) then
		self:_closeByAnim()

		return
	end

	if self._recruitType == var_0_0.RECRUIT_TYPE.LIMIT_KNIGHT_SOUL_RECRUIT and g.core.model.User.recruitData:getKnightSoulTotalTime() < 10 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108723))

		return
	end

	g.core.network.GameNetProxy:send_C2S_NewRecruit_Luck({
		id = self._recruitId,
		wish = var_16_0
	})
end

function RecruitWishPopBase:_closeByAnim()
	self.m_mask:setVisible(true)
	self.m_backTransition:play(handler(self, self._close))
end

function RecruitWishPopBase:_close()
	g.core.module.ModuleManager:popComponent()
end

return RecruitWishPopBase
