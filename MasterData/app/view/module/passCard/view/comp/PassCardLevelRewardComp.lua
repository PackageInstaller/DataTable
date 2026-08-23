local var_0_0 = g.core.model.User
local PassCardConst = require("app.view.module.passCard.const.PassCardConst")
local PassCardLevelRewardComp = class("PassCardLevelRewardComp", require("app.fairyGUI.passCard.UI_PassCardLevelRewardComp"))

function PassCardLevelRewardComp:ctor(arg_1_1)
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onListRenderer))
	self.m_rewardList:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onListScroll))
	self:addListen(self.m_rewardList)
end

function PassCardLevelRewardComp:onLoad()
	local var_2_0, var_2_1 = g.core.model.User.passCardData:getCardInfoByIndex(2)

	self.m_backRewardTxt:setText(var_2_0.cfg.discount .. "%")
end

function PassCardLevelRewardComp:updateRewardPool()
	local var_3_0 = var_0_0.passCardData:getAllAwardData()

	self._allRewardData = var_3_0
	self._bigNormalRewardData = self._allRewardData.bigNormalReward
	self._bigSeniorRewardData = self._allRewardData.bigSeniorReward
	self._curLevel = var_0_0.passCardData:getCardBaseInfo().level

	self.m_rewardList:setNumItems(#var_3_0.normalReward)

	local var_3_1 = var_0_0.passCardData:getCurCanGetAwardIndex()

	if var_3_1 then
		self.m_rewardList:scrollToView(var_3_1 - 1)
	end

	self:_onListScroll()
end

function PassCardLevelRewardComp:_onListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateSingleReward(self._allRewardData.normalReward[arg_4_1 + 1], self._allRewardData.seniorReward[arg_4_1 + 1], arg_4_1, self._curLevel)
end

function PassCardLevelRewardComp:_showNextBigNormalReward(arg_5_1)
	local var_5_0

	for iter_5_0, iter_5_1 in ipairs(self._bigNormalRewardData) do
		if arg_5_1 < iter_5_1.info.level then
			var_5_0 = iter_5_1

			break
		end
	end

	if not var_5_0 then
		local var_5_1 = var_0_0.passCardData:getLastLevelBigAward(PassCardConst.RewardType.NORMAL, arg_5_1)

		if var_5_1 then
			var_5_0 = var_5_1
		end
	end

	if var_5_0 then
		self.m_isNormalBigEmptyController:setSelectedIndex(0)
		self.m_bigRewardLevelTxt:setText(g.core.lang:get(405001, {
			level = var_5_0.info.level
		}))
		self.m_normalRightBigRewardIcon:updateReward(var_5_0)
	else
		self.m_isNormalBigEmptyController:setSelectedIndex(1)
	end
end

function PassCardLevelRewardComp:_showNextBigSeniorReward(arg_6_1)
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(self._bigSeniorRewardData) do
		if arg_6_1 < iter_6_1.info.level then
			var_6_0 = iter_6_1

			break
		end
	end

	if not var_6_0 then
		local var_6_1 = var_0_0.passCardData:getLastLevelBigAward(PassCardConst.RewardType.SENIOR, arg_6_1)

		if var_6_1 then
			var_6_0 = var_6_1
		end
	end

	if var_6_0 then
		self.m_isSeniorBigEmptyController:setSelectedIndex(0)
		self.m_bigRewardLevelTxt:setText(g.core.lang:get(405001, {
			level = var_6_0.info.level
		}))
		self.m_seniorRightBigRewardIcon:updateReward(var_6_0)
	else
		self.m_isSeniorBigEmptyController:setSelectedIndex(1)
	end
end

function PassCardLevelRewardComp:_onListScroll(arg_7_1, arg_7_2)
	local var_7_0

	for iter_7_0, iter_7_1 in ipairs((self.m_rewardList:getChildren())) do
		local var_7_1 = iter_7_1:getCurLevel()
		local var_7_2

		if -1 < var_7_1 then
			var_7_0 = iter_7_1
			var_7_2 = var_7_1
		end
	end

	local var_7_3 = var_7_0:getCurLevel()

	self:_showNextBigNormalReward(var_7_3)
	self:_showNextBigSeniorReward(var_7_3)
end

return PassCardLevelRewardComp
