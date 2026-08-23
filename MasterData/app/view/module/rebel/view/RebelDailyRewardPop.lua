local var_0_0 = g.core.model.User.rebelData
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local RebelDailyRewardPop = class("RebelDailyRewardPop", require("app.fairyGUI.rebel.UI_RebelDailyRewardPop"), function()
	return fgui.GComponent:create({
		resName = "RebelDailyRewardPop",
		pkgPath = "ui/rebel/rebel",
		pkgName = "rebel"
	})
end)

function RebelDailyRewardPop:ctor(arg_2_1)
	self._rankDailyTaskArr = nil
	self._cellAniPalyed = false

	self:showAtCenter()
	self:initDailyReward()
end

function RebelDailyRewardPop:onLoad()
	self:_initRegisterUI()
	self:_refreshDailyView()
end

function RebelDailyRewardPop:initDailyReward()
	self:_initDailyRewardData()
	self:_initDailyRewardUI()
end

function RebelDailyRewardPop:_initDailyRewardData()
	self._rankDailyTaskArr = {}

	local var_5_0, var_5_1 = var_0_0:getAllDamage()
	local var_5_2 = var_0_0:getDailyAwards()
	local var_5_3 = var_0_0:getMaxLevel()
	local var_5_4 = 0

	for iter_5_0 = 1, g.core.config.rebel_award_info.getLength() do
		local var_5_5 = g.core.config.rebel_award_info.indexOf(iter_5_0)

		if var_5_3 >= var_5_5.seen_grade_min and var_5_3 <= var_5_5.seen_grade_max then
			var_5_4 = var_5_4 + 1

			table.insert(self._rankDailyTaskArr, {
				baseInfo = var_5_5,
				total = var_5_1,
				got = var_5_2[tostring(var_5_5.id)] ~= nil,
				ready = math.uint64_lt(var_5_5.damage, var_5_1, true),
				order = var_5_4
			})
		end
	end

	table.sort(self._rankDailyTaskArr, self._sortCompare)
end

function RebelDailyRewardPop:_initDailyRewardUI()
	self.m_fullBtn:addClickListener(handler(self, self._onGetFullAwardClick))
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
end

function RebelDailyRewardPop:_initRegisterUI()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_REBEL_AWARD, self._onNetRebelAward, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_REBEL_ONE_BUTTON_AWARD, self._onNetFullRebelAward, self)
end

function RebelDailyRewardPop:_onRenderRewardList(arg_8_1, arg_8_2)
	arg_8_2:refreshDailyRewardCell(self._rankDailyTaskArr[arg_8_1 + 1])
end

function RebelDailyRewardPop:_refreshDailyView()
	local var_9_0, var_9_1 = var_0_0:getAllDamage()

	self.m_totalTxt:setText(var_9_1)
	self.m_rewardList:setNumItems(#self._rankDailyTaskArr)

	if not self._cellAniPalyed then
		self._cellAniPalyed = true

		self.m_rewardList:transitionShowCells("enter_down", 0.03)
	end

	self:_refreshBtnStatus()
end

function RebelDailyRewardPop:_refreshBtnStatus()
	if not g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.REBEL_ONCE_GOT) then
		self.m_fullBtn:setVisible(false)
	end

	self.m_fullBtn:setVisible(true)

	if self:_isExistAward() and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.REBEL_ONCE_GOT) then
		self.m_fullBtn:setVisible(true)
	else
		self.m_fullBtn:setVisible(false)
	end
end

function RebelDailyRewardPop:_isExistAward()
	for iter_11_0, iter_11_1 in ipairs(self._rankDailyTaskArr) do
		if iter_11_1.ready and not iter_11_1.got then
			return true
		end
	end

	return false
end

function RebelDailyRewardPop:_sortCompare(arg_12_1)
	if self.got ~= arg_12_1.got then
		return arg_12_1.got
	end

	if self.ready ~= arg_12_1.ready then
		return self.ready
	end

	return self.baseInfo.id < arg_12_1.baseInfo.id
end

function RebelDailyRewardPop:_onGetFullAwardClick()
	g.core.network.GameNetProxy:send_C2S_Rebel_One_Button_Award({})
end

function RebelDailyRewardPop:_onNetRebelAward(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0

	for iter_14_0, iter_14_1 in ipairs(self._rankDailyTaskArr) do
		if iter_14_1.baseInfo.id == arg_14_3.id then
			iter_14_1.got = true
			var_14_0 = iter_14_1.baseInfo

			break
		end
	end

	table.sort(self._rankDailyTaskArr, self._sortCompare)
	self:_refreshDailyView()

	if var_14_0 then
		g.core.module.ModuleManager:awardSummary({
			{
				type = var_14_0.type,
				value = var_14_0.value,
				size = var_14_0.size
			}
		})
	end
end

function RebelDailyRewardPop:_onNetFullRebelAward(arg_15_1, arg_15_2, arg_15_3)
	if arg_15_3.ids == nil then
		return
	end

	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(self._rankDailyTaskArr) do
		for iter_15_2, iter_15_3 in ipairs(arg_15_3.ids) do
			if iter_15_1.baseInfo.id == iter_15_3 then
				iter_15_1.got = true

				table.insert(var_15_0, iter_15_1.baseInfo)

				break
			end
		end
	end

	table.sort(self._rankDailyTaskArr, self._sortCompare)
	self:_refreshDailyView()

	if #var_15_0 > 0 then
		local var_15_1 = {}

		for iter_15_4, iter_15_5 in ipairs(var_15_0) do
			table.insert(var_15_1, {
				type = iter_15_5.type,
				value = iter_15_5.value,
				size = iter_15_5.size
			})
		end

		g.core.module.ModuleManager:awardSummary(var_15_1)
	end
end

function RebelDailyRewardPop:getOneKeyDailyReward()
	self:_onGetFullAwardClick()
end

return RebelDailyRewardPop
