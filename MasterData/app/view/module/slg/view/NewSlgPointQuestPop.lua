local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local var_0_1 = g.core.model.User.newSlgData
local NewSlgPointQuestPop = class("NewSlgPointQuestPop", require("app.fairyGUI.newSlg.UI_NewSlgPointQuestPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgPointQuestPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgPointQuestPop:ctor(arg_2_1)
	self:showAtCenter()

	self._id = arg_2_1

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderListAwardCell))
	self.m_enterTransition:play()

	var_0_1.gateBtnRedPoint = false
end

function NewSlgPointQuestPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_NOTIFYCHECKPOINTQUEST, handler(self, self._onRcvNewSlgNotifyCheckpointQuest), self)
	self:_updateView()
end

function NewSlgPointQuestPop:_updateView()
	local var_4_0, var_4_1, var_4_2 = var_0_1:getCheckPointState(self._id)

	self._unlockState = var_4_2

	if var_4_2 == var_0_0.SLGCheckPointQuestLockState.Lock then
		self.m_tipTxt:setText(g.core.lang:get(428879, {
			name = var_4_1
		}))
	else
		self.m_tipTxt:setText(g.core.lang:get(428880))
	end

	self._cfg = var_0_1:getCheckPointInfoById(self._id)

	self.m_descTxt:setText(self._cfg.group_contain)
	self.m_groupPic:setURL(g.core.common.Path:getNewSlgGroupIcon(self._cfg.group_pic))
	self.m_taskDescTxt:setText(self._cfg.description .. g.core.lang:get(428988, {
		num1 = var_0_1:getCheckPointProgressByGroup(self._cfg.group),
		num2 = self._cfg.quest_value_2
	}))

	self._awards = {}

	for iter_4_0, iter_4_1, iter_4_2 in self._cfg.gmatch({
		"reward_type_%d+",
		"reward_value_%d+",
		"reward_size_%d+"
	}) do
		if iter_4_2 and iter_4_2[1] ~= 0 then
			table.insert(self._awards, {
				type = iter_4_2[1],
				value = iter_4_2[2],
				size = iter_4_2[3]
			})
		end
	end

	self.m_awardList:setNumItems(#self._awards)
end

function NewSlgPointQuestPop:_onRenderListAwardCell(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._awards[arg_5_1 + 1])
end

function NewSlgPointQuestPop:_onRcvNewSlgNotifyCheckpointQuest()
	self:_updateView()
end

return NewSlgPointQuestPop
