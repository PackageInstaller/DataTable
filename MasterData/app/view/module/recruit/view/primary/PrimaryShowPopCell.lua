local var_0_0 = g.core.const.ConstMgr.RecruitConst
local PrimaryShowPopCell = class("PrimaryShowPopCell", require("app.fairyGUI.recruitKnight.UI_PrimaryShowPopCell"))

function PrimaryShowPopCell:ctor()
	self.m_clickNode:addClickListener(handler(self, self._onViewBtnClicked))
	self.m_viewBtn:addClickListener(handler(self, self._onViewBtnClicked))
	self.m_iconList:setVirtual(self)
	self.m_iconList:setItemProvider(handler(self, self._setListItemProvider))
	self.m_iconList:setItemRenderer(handler(self, self._onListItemRender))
end

function PrimaryShowPopCell:updateCell(arg_2_1, arg_2_2, arg_2_3)
	self._pos = arg_2_2

	self.m_indexText:setText(string.format("%02d", arg_2_2))

	local var_2_0 = 0

	self._rewards = arg_2_1
	self._highRewardList = {}

	local var_2_1 = {}
	local var_2_2 = "playSsrCommon"

	if not arg_2_1 then
		self.m_recruitedController:setSelectedIndex(0)
	else
		var_2_2 = "playSsrSingle"

		self.m_recruitedController:setSelectedIndex(1)

		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			local var_2_3 = g.core.common.Goods:convert(iter_2_1)

			if var_2_3.quality >= 4 then
				self._highRewardList[#self._highRewardList + 1] = var_2_3
			elseif var_2_3.quality == 3 then
				var_2_1[#var_2_1 + 1] = var_2_3
			end
		end

		if #self._highRewardList > 1 then
			var_2_0 = 1
			var_2_2 = "playSsrDouble"
		end
	end

	if #var_2_1 > 0 then
		var_2_2 = "playSsrSingleLeft"
		self._highRewardList[#self._highRewardList + 1] = {
			isSrr = true,
			data = var_2_1
		}
	end

	self.m_iconList:setNumItems(#self._highRewardList)
	self.m_isLuckController:setSelectedIndex(var_2_0)
	self.m_effNode:removeAllEffect()

	if arg_2_3 then
		self.m_effNode:addEffectSpine({
			name = "eff_ui_recruitPrimary_show",
			remove = true,
			isLoop = false,
			anim = var_2_2
		})
	end
end

function PrimaryShowPopCell:_onListItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._highRewardList[arg_3_1 + 1])
end

function PrimaryShowPopCell:_setListItemProvider(arg_4_1)
	return not self._highRewardList[arg_4_1 + 1].isSrr and "ui://recruitKnight/PrimaryShowPopCellIcon" or "ui://recruitKnight/PrimaryShowPopCellSRList"
end

function PrimaryShowPopCell:_onViewBtnClicked()
	if not self._rewards then
		return
	end

	local var_5_0 = g.core.model.User.recruitData:getLastCheckRoundData()

	for iter_5_0 = 1, #self._rewards do
		self._rewards[iter_5_0].isNew = g.core.model.User.recruitData:checkIsNew(self._rewards[iter_5_0].value)
		self._rewards[iter_5_0].hideFrag = true
	end

	local var_5_1 = {
		awards = self._rewards,
		recruit_type = var_0_0.RECRUIT_TYPE.PRIMARY
	}

	var_5_1.justShowResult = true
	var_5_1.isHideRecruitBtn = var_5_0.rewardState.state ~= "match"
	var_5_1.num = 10
	var_5_1.pos = self._pos

	g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT_REWARD, var_5_1)
end

return PrimaryShowPopCell
