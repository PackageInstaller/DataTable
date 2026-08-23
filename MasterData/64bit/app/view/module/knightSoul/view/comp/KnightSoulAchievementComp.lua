local var_0_0 = g.core.config.ksoul_honor_info
local var_0_1 = g.core.model.User.knightSoulData
local KnightSoulAchievementComp = class("KnightSoulAchievementComp", require("app.fairyGUI.knightSoul.UI_KnightSoulAchievementComp"))

function KnightSoulAchievementComp:ctor()
	self:addListen(self.m_scrollComp)

	self._selData = self.m_scrollComp:getCurSelPointData()

	self:updateSoulAchievementView()
	self.m_activeBtn:addClickListener(handler(self, self._onActiveClick))
end

function KnightSoulAchievementComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_K_SOUL_HONORADVANCE, handler(self, self._onActiveHonorBack), self)
end

function KnightSoulAchievementComp:updateSoulAchievementView()
	self.m_ksValueTxt:setText(var_0_1:getCurHonorNum())
	self:updateActiveState()
	self:updateSelPoint()
end

function KnightSoulAchievementComp:updateActiveState()
	if not self._selData then
		return
	end

	local var_4_0 = var_0_1:getActivationHonorId()
	local var_4_1 = self._selData.cfg
	local var_4_2 = var_4_0 >= self._selData.cfg.id

	self.m_activeStateController:setSelectedIndex(var_4_0 >= self._selData.cfg.id and 1 or 0)

	if not var_4_2 then
		if var_4_1.honor_num > var_0_1:getCurHonorNum() then
			self.m_ksValueNeedTxt:setText(g.core.lang:get(410620, {
				num = var_4_1.honor_num
			}))
		else
			self.m_ksValueNeedTxt:setText(g.core.lang:get(410625, {
				num = var_4_1.honor_num
			}))
		end
	end
end

function KnightSoulAchievementComp:_onActiveHonorBack(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.m_scrollComp:updateActiveSuccess(arg_5_4)
	self:updateSoulAchievementView()
	self:onActiveSuccess(arg_5_4.honor_id)
end

function KnightSoulAchievementComp:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "KnightSoulAchievementSelectItem" then
		self._selData = arg_6_2

		self:updateSelPoint()
		self.m_scrollComp:setSelectPoint(self._selData.index)
	end
end

function KnightSoulAchievementComp:updateSelPoint()
	if not self._selData then
		return
	end

	local var_7_0 = self._selData.cfg
	local var_7_1 = self:getAllAttrs(self._selData.cfg)

	self.m_attrNumController:setSelectedIndex(#var_7_1 - 1)

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		iter_7_1.isGray = not self._selData.isActive

		self["m_attrComp" .. iter_7_0]:updateAttr(iter_7_1)
	end

	if var_7_0.type == 2 then
		self.m_eDescTxt:setText(var_7_0.if_unlock_chapter)
	elseif var_7_0.type == 3 then
		self.m_eDescTxt:setText(var_7_0.unlock_chapter_star)
	else
		self.m_eDescTxt:setText("")
	end

	self:updateActiveState()
end

function KnightSoulAchievementComp:getAllAttrs(arg_8_1)
	local var_8_0 = {}

	while var_0_0.hasKey("affect_type_" .. 1) do
		if arg_8_1["affect_type_" .. 1] ~= 0 then
			table.insert(var_8_0, {
				isAll = true,
				type = arg_8_1["affect_type_" .. 1],
				value = arg_8_1["affect_value_" .. 1]
			})
		end
	end

	return var_8_0
end

function KnightSoulAchievementComp:_onActiveClick()
	if not self._selData then
		return
	end

	local var_9_0 = self._selData.cfg

	if var_0_1:getActivationHonorId() < self._selData.cfg.front_node then
		g.core.module.ModuleManager:tip(g.core.lang:get(410621))

		return
	end

	if var_0_1:getCurHonorNum() >= var_9_0.honor_num then
		g.core.network.GameNetProxy:send_C2S_KSoul_HonorAdvance({
			honor_id = var_9_0.id
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(410622))
	end
end

function KnightSoulAchievementComp:onActiveSuccess(arg_10_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		data = {
			id = arg_10_1
		},
		title = g.core.lang:get(105516),
		showComp = fgui.UIPackage:createObject("knightSoul", "KnightSoulAchievementActiveComp")
	}), {
		touchDisappear = true,
		hideContinue = false
	})
end

return KnightSoulAchievementComp
