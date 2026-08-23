local RecruitWishPop = class("RecruitWishPop", require("app.fairyGUI.recruit.UI_RecruitWishPop"), function()
	return fgui.GComponent:create({
		resName = "RecruitWishPop",
		pkgName = "recruit",
		pkgPath = "ui/recruit/recruit"
	})
end)

function RecruitWishPop:ctor(arg_2_1, arg_2_2)
	self:getView():setSize(display.width, display.height)
	self.m_percentText:setText(g.core.config.parameter_info.get(15003).parameter .. "%")

	self._recruitType = arg_2_1
	self._recruitId = arg_2_2
	self._changePos = 0
	self._tabIdx = 0

	self:_addListeners()
	self.m_wishList:setVirtual(self)
	self.m_wishList:doFairyBatching(false)

	local var_2_0 = self.m_wishList:getPosition()

	var_2_0.x = var_2_0.x + 30 * (math.max(0, display.width - 1334) / 290)

	self.m_wishList:setPosition(var_2_0)
	self:center(true)
end

function RecruitWishPop:_addListeners()
	self.m_closeBtn:addClickListener(handler(self, self._closeByAnim))
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmBtnClicked))
	self.m_wishList:setVirtual(self)
	self.m_wishList:setItemRenderer(handler(self, self._onWishItemRender))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabItemClick))
end

function RecruitWishPop:_onWishItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateItem(self._members[self._tabIdx + 1][arg_4_1 + 1], arg_4_1)
end

function RecruitWishPop:_onTabItemClick(arg_5_1)
	local var_5_0 = self.m_tabList:getSelectedIndex()

	if var_5_0 == self._tabIdx then
		return
	end

	self._tabIdx = var_5_0

	self:_updateView()
end

function RecruitWishPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self._close), self)
	self:_updateWishInfos()
	self.m_tabList:setSelectedIndex(self._tabIdx)
	self:_updateView()
end

function RecruitWishPop:_updateWishInfos()
	self._wishInfos = {
		false
	}

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(g.core.model.User.recruitData:getWishInfo(self._recruitType) or {}) do
		if iter_7_1.r_type ~= 0 then
			self._wishInfos[iter_7_1.pos] = clone(iter_7_1)
			var_7_0[iter_7_1.r_value] = iter_7_1.pos
		end
	end

	self._members = {
		{}
	}

	for iter_7_2, iter_7_3 in ipairs((g.core.model.User.recruitData:getWishMembersByRecruitType(self._recruitType, self._recruitId))) do
		local var_7_1 = iter_7_3:getId()
		local var_7_2 = {
			pos = var_7_0[var_7_1]
		}

		if var_7_0[var_7_1] then
			var_7_2.state = self._wishInfos[var_7_0[var_7_1]].status or nil
		end

		var_7_2.placeHolders = self._wishInfos

		iter_7_3:updateStructNetInfo(var_7_2)

		local var_7_3 = iter_7_3:getGroup() + 1

		self._members[var_7_3] = self._members[var_7_3] or {}

		table.insert(self._members[var_7_3], iter_7_3)
		table.insert(self._members[1], iter_7_3)
	end

	self:_updateChangePos()
	self:_sort()

	self._oldWishInfos = clone(self._wishInfos)
end

function RecruitWishPop:_updateChangePos()
	self._changePos = nil

	for iter_8_0, iter_8_1 in ipairs(self._wishInfos) do
		if iter_8_1 == false or type(iter_8_1) == "table" and iter_8_1.status < iter_8_1.statusMax then
			self._changePos = iter_8_0

			return
		end
	end
end

function RecruitWishPop:_sort()
	local function var_9_0(arg_10_0, arg_10_1)
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

function RecruitWishPop:_updateView()
	for iter_11_0, iter_11_1 in ipairs(self._wishInfos) do
		self:_updateWishMember((type(iter_11_1) == "table" and iter_11_1.r_type ~= 0 or nil) and self:_getMemberByTypeAndValue(iter_11_1.r_type, iter_11_1.r_value), iter_11_0)
	end

	self.m_wishList:setNumItems(#(self._members[self._tabIdx + 1] or {}))
end

function RecruitWishPop:_updateWishMember(arg_12_1, arg_12_2)
	if type(self._wishInfos[arg_12_2]) == "table" then
		self["m_knightComp" .. arg_12_2]:updateComp(arg_12_1, arg_12_2, self._wishInfos[arg_12_2].status)
	else
		self["m_knightComp" .. arg_12_2]:updateComp(arg_12_1, arg_12_2)
	end
end

function RecruitWishPop:receiveCompEvent(arg_13_1, arg_13_2)
	if arg_13_1 == "updateWishInfo" then
		local var_13_0 = arg_13_2.pos or self._changePos
		local var_13_1 = arg_13_2.info
		local var_13_2 = false

		if type(self._wishInfos[var_13_0]) == "table" then
			if self._wishInfos[var_13_0].status >= self._wishInfos[var_13_0].statusMax then
				return
			end

			self:_changeKnightPos(self._wishInfos[var_13_0].r_value, nil)
		end

		if var_13_1 then
			var_13_2 = {
				r_type = var_13_1:getType(),
				r_value = var_13_1:getId(),
				pos = var_13_0
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

function RecruitWishPop:_changeKnightPos(arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(self._members) do
		for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
			if iter_14_3:getId() == arg_14_1 then
				iter_14_3:setPos(arg_14_2)

				return
			end
		end
	end
end

function RecruitWishPop:_getMemberByTypeAndValue(arg_15_1, arg_15_2)
	local var_15_0

	for iter_15_0, iter_15_1 in ipairs(self._members[1]) do
		if iter_15_1:getType() == arg_15_1 and iter_15_1:getId() == arg_15_2 then
			var_15_0 = iter_15_1

			break
		end
	end

	return var_15_0
end

function RecruitWishPop:_onConfirmBtnClicked()
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

	g.core.network.GameNetProxy:send_C2S_NewRecruit_Luck({
		id = self._recruitId,
		wish = var_16_0
	})
end

function RecruitWishPop:_closeByAnim()
	self.m_mask:setVisible(true)
	self.m_backTransition:play(handler(self, self._close))
end

function RecruitWishPop:_close()
	g.core.module.ModuleManager:popComponent()
end

return RecruitWishPop
