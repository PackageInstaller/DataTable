local var_0_0 = g.core.config.tower_stage_info
local var_0_1 = g.core.model.User.towerHardData
local var_0_2 = g.core.const.ConstMgr.TowerConst.STAGE_TYPE_HARD
local TowerHardMainChallengeComp = class("TowerHardMainChallengeComp", require("app.fairyGUI.tower.UI_TowerHardMainChallengeComp"))

function TowerHardMainChallengeComp:ctor()
	if self.m_difficultyController then
		self.m_difficultyController:setSelectedIndex(1)
	end

	self._rewardList = {}
end

function TowerHardMainChallengeComp:initView()
	self.m_enterTransition:play()
	self.m_challengeBtn:addClickListener(handler(self, self._onClickChallengeBtn))
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRendererRewardList))
	self.m_formationBtn:addClickListener(handler(self, self._gotoFormation))

	local var_2_0, var_2_1 = var_0_1:getCurTowerIdByType(var_0_2.MAIN)
	local var_2_2 = var_0_1:getCapacityAddListDataById(var_2_0, var_2_1)

	if table.nums(var_2_2) == 0 then
		self.m_hasAddCapacityController:setSelectedIndex(0)
	else
		self.m_hasAddCapacityController:setSelectedIndex(1)

		for iter_2_0 = 1, 4 do
			local var_2_3 = var_2_2[iter_2_0]
			local var_2_4 = self["m_addRes" .. iter_2_0]

			if self["m_addRes" .. iter_2_0] then
				var_2_4:update(var_2_3, true)
				var_2_4:setVisible(var_2_3 ~= nil)
			end
		end
	end

	self:updateView()
end

function TowerHardMainChallengeComp:_onClickChallengeBtn()
	if var_0_1:getMainTowerIsOpen() then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.tower.view.hard.TowerHardFormationLayer").new(var_0_2.MAIN), {
			touchDisappear = false,
			ignoreTouch = false
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(308011))
		self:dispatchCompEvent("TowerHardMainChallengeComp_remove")
	end
end

function TowerHardMainChallengeComp:updateView()
	local var_4_0, var_4_1 = var_0_1:getCurTowerIdByType(var_0_2.MAIN)

	self._stageInfo = var_0_0.fetch(var_4_1) or {}
	self._rewardList = var_0_1:getStageRewardList(var_4_1, true)

	self.m_rewardList:setNumItems(#self._rewardList)

	local var_4_2 = var_0_1:getTowerBuffInfo(var_0_2.MAIN)

	if var_4_2 == nil then
		self.m_buffServer:getChild("buffDesc"):setText(g.core.lang:get(308015))
	else
		self.m_buffServer:getChild("buffDesc"):setText(var_4_2.description)
	end

	self.m_buffActivity:setVisible(false)
	self.m_stageOrder:setText(g.core.lang:get(308008, {
		order = self._stageInfo.stage_order
	}))
	self.m_enemyTxt:setText(g.core.lang:get(308033, {
		num = self._stageInfo.enemy_num
	}))
end

function TowerHardMainChallengeComp:_gotoFormation()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function TowerHardMainChallengeComp:_onRendererRewardList(arg_6_1, arg_6_2)
	self._rewardList[arg_6_1 + 1].scaleIndex = 3

	arg_6_2:updateIcon(self._rewardList[arg_6_1 + 1])
end

return TowerHardMainChallengeComp
