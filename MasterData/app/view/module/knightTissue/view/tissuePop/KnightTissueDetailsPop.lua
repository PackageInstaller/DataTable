local KnightTissueDetailsPop = class("KnightTissueDetailsPop", require("app.fairyGUI.knightTissue.UI_KnightTissueDetailsPop"), function()
	return fgui.GComponent:create({
		resName = "KnightTissueDetailsPop",
		pkgPath = "ui/knightTissue/knightTissue",
		pkgName = "knightTissue"
	})
end)
local var_0_1 = g.core.model.User.knightTissueData
local var_0_2 = g.core.config.knight_tissue_level_info
local var_0_3 = g.core.common.Path
local ShowFactory = require("app.view.module.show.ShowFactory")

function KnightTissueDetailsPop:ctor(arg_2_1)
	self._tissueId = 0
	self._tissueInfo = arg_2_1.info
	self._oldLv = 0
	self._clickOnce = false

	self:showAtCenter()
	self:_registerListener()
end

function KnightTissueDetailsPop:_registerListener()
	self.m_memberList:setVirtual()
	self.m_memberList:doFairyBatching(false)
	self.m_memberList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_detailsArea:addClickListener(handler(self, self._onClickDetailsButton))
	self.m_baseAttrBtn:addClickListener(handler(self, self._onClickBaseAttrButton))
	self.m_passiveAttrBtn:addClickListener(handler(self, self._onClickPassiveAttrButton))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickActiveOrLvUpBtn))
	self.m_touchGraph:addClickListener(handler(self, self._onClickCloseOneKey))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onClickLvUpMaxBtn))
end

function KnightTissueDetailsPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_TISSUE_ACTIVE, self._onRecKnightTissueActive, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_TISSUE_UPLV, self._onRecKnightTissueLevelUp, self)
	self:_updateMainView()
end

function KnightTissueDetailsPop:_updateMainView()
	if not self._tissueInfo then
		return
	end

	self._tissueId = self._tissueInfo.id
	self._memberCfgData = var_0_1:getTissueKnightCfgById(self._tissueId)

	self.m_memberList:setNumItems(#self._memberCfgData)

	local var_5_0 = var_0_3:getKnightTissuePic(self._tissueInfo.icon)

	if string.len(var_5_0) > 0 then
		self.m_tissueLoader:setURL(var_5_0)
	end

	self.m_popPanel:setTitle(self._tissueInfo.name)

	self._tissueLevel = var_0_1:getKnightTissueLevel(self._tissueId)

	local var_5_1 = var_0_1:isKnightTissueActive(self._tissueId)

	if var_5_1 and self._tissueLevel >= 0 then
		self.m_tissueLevelTxt:setText(g.core.lang:get(2052, {
			level = self._tissueLevel
		}))
	else
		self.m_tissueLevelTxt:setText("")
	end

	self:setPassiveState(var_5_1)
	self:_updatePlanCondView()
end

function KnightTissueDetailsPop:setPassiveState(arg_6_1)
	if arg_6_1 then
		local var_6_0 = var_0_2.get(self._tissueId, self._tissueLevel)

		if var_6_0.skill_id > 0 and var_6_0.skill_target > 0 then
			local var_6_1 = g.core.model.User.knightsData:getKnight({
				advance_id = var_6_0.skill_target
			})

			if var_6_1 then
				self.m_passiveAttrBtn:setTitle(g.core.lang:get(111905, {
					playName = var_6_1:getName(),
					skillName = g.core.config.passive_skill_info.get(var_6_0.skill_id).name
				}))
			end

			self.m_isHavePassiveController:setSelectedIndex(1)
		else
			self.m_isHavePassiveController:setSelectedIndex(0)
		end
	else
		local var_6_2 = false

		for iter_6_0 = 1, var_0_1:getTissueMaxLevel(self._tissueId) do
			local var_6_3 = var_0_2.get(self._tissueId, iter_6_0)

			if var_6_3.skill_id > 0 and var_6_3.skill_target > 0 then
				local var_6_4 = g.core.model.User.knightsData:getKnight({
					advance_id = var_6_3.skill_target
				})
				local var_6_5 = g.core.config.passive_skill_info.get(var_6_3.skill_id)

				if var_6_4 then
					self.m_passiveAttrBtn:setTitle(g.core.lang:get(111905, {
						playName = var_6_4:getName(),
						skillName = var_6_5.name
					}))
				end

				var_6_2 = true

				break
			end
		end

		self.m_isHavePassiveController:setSelectedIndex(var_6_2 and 1 or 0)
	end
end

function KnightTissueDetailsPop:_updatePlanCondView()
	local var_7_0 = var_0_1:isKnightTissueActive(self._tissueId)

	self.m_isMaxLevelController:setSelectedIndex(var_0_1:getTissueMaxLevel(self._tissueId) <= var_0_1:getKnightTissueLevel(self._tissueId) and 1 or 0)
	self.m_isActiveController:setSelectedIndex(var_7_0 and 1 or 0)

	local var_7_1 = false

	if not var_7_0 then
		local var_7_2 = self._tissueInfo.num

		if self._tissueInfo.free_upgrade == 1 then
			var_7_2 = 1
		end

		local var_7_3 = var_0_1:getTissueCollectCountById(self._tissueId)

		self.m_curValueTxt:setText(var_7_3)
		self.m_maxValueTxt:setText(g.core.lang:get(111903, {
			num = var_7_2
		}))
		self.m_condProgress:setPercent({
			cur = var_7_3,
			max = var_7_2
		})

		if var_7_3 < var_7_2 then
			var_7_1 = true
		end
	else
		local var_7_4 = var_0_1:getNextLevelSumValue(self._tissueId)
		local var_7_5 = var_0_1:getTotalLevelByKnightTissueId(self._tissueId)

		self.m_curValueTxt:setText(var_7_5)
		self.m_maxValueTxt:setText(g.core.lang:get(111903, {
			num = var_7_4
		}))
		self.m_condProgress:setPercent({
			cur = var_7_5,
			max = var_7_4
		})

		if var_7_5 < var_7_4 then
			var_7_1 = true
		end
	end

	if var_7_1 then
		self.m_curValueTxt:setColor(g.core.common.Color.A7)
		self.m_maxValueTxt:setColor(g.core.common.Color.A7)
	else
		self.m_curValueTxt:setColor(g.core.common.Color.A1)
		self.m_maxValueTxt:setColor(g.core.common.Color.A1)
	end
end

function KnightTissueDetailsPop:_onItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateKnight(self._memberCfgData[arg_8_1 + 1])
end

function KnightTissueDetailsPop:_onRecKnightTissueActive()
	local var_9_0 = {
		title = g.core.lang:get(111912),
		id = self._tissueId
	}

	var_9_0.oldLv = -1
	var_9_0.showComp = fgui.UIPackage:createObject("knightTissue", "KnightTissueLevelUpComp")

	ShowFactory:showFeedBackTipsPop(var_9_0, {
		hideContinue = true
	})

	self._clickOnce = false

	self:_updateMainView()
end

function KnightTissueDetailsPop:_onRecKnightTissueLevelUp(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = self._tissueId
	local var_10_1 = self._oldLv

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = {
			{
				flag = "TissueDetails",
				func = function()
					return ShowFactory:showFeedBackTipsPop({
						title = g.core.lang:get(111913),
						id = var_10_0,
						oldLv = var_10_1,
						showComp = fgui.UIPackage:createObject("knightTissue", "KnightTissueLevelUpComp")
					}, {
						hideContinue = true
					})
				end
			}
		}
	})

	self._clickOnce = false

	self:_updateMainView()
end

function KnightTissueDetailsPop:_onClickDetailsButton()
	self:addPopup(require("app.view.module.knightTissue.view.tissuePop.KnightTissueWorldViewPop").new({
		id = self._tissueId
	}))
end

function KnightTissueDetailsPop:_onClickBaseAttrButton()
	self:addPopup(require("app.view.module.knightTissue.view.tissuePop.KnightTissueBaseAttrPop").new({
		id = self._tissueId
	}))
end

function KnightTissueDetailsPop:_onClickPassiveAttrButton()
	self:addPopup(require("app.view.module.knightTissue.view.tissuePop.KnightTissuePassiveAttrPop").new({
		id = self._tissueId
	}))
end

function KnightTissueDetailsPop:_onClickActiveOrLvUpBtn()
	local var_15_0 = var_0_1:getKnightTissueLevel(self._tissueId)

	self._oldLv = var_15_0

	local var_15_1 = var_0_1:getTissueMaxLevel(self._tissueId)
	local var_15_2 = var_0_1:isKnightTissueActive(self._tissueId)
	local var_15_3 = math.min(var_15_1, (var_0_1:getTotalLevelByKnightTissueId(self._tissueId)))

	if var_15_2 and self.m_openOneKeyController:getSelectedIndex() == 0 and var_15_3 - var_15_0 > 1 then
		self.m_oneKeyBtn:setTitle(g.core.lang:get(111921, {
			level = var_15_3
		}))
		self.m_openOneKeyController:setSelectedIndex(1)

		return
	end

	if var_15_1 <= var_15_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(111906))

		return
	end

	if not var_15_2 then
		if ((self._tissueInfo.free_upgrade == 1 or nil) and 1) > var_0_1:getTissueCollectCountById(self._tissueId) then
			g.core.module.ModuleManager:tip(g.core.lang:get(111907))
		elseif not self._clickOnce then
			g.core.network.GameNetProxy:send_C2S_KnightTissue_Active({
				id = self._tissueId
			})

			self._clickOnce = true
		end
	elseif var_15_3 < var_0_1:getNextLevelSumValue(self._tissueId) then
		g.core.module.ModuleManager:tip(g.core.lang:get(111908))
	else
		if not self._clickOnce then
			g.core.network.GameNetProxy:send_C2S_KnightTissue_UpLv({
				id = self._tissueId,
				level = var_15_0 + 1
			})

			self._clickOnce = true
		end

		self.m_openOneKeyController:setSelectedIndex(0)
	end
end

function KnightTissueDetailsPop:_onClickCloseOneKey()
	self.m_openOneKeyController:setSelectedIndex(0)
end

function KnightTissueDetailsPop:_onClickLvUpMaxBtn()
	local var_17_0 = var_0_1:getKnightTissueLevel(self._tissueId)

	self._oldLv = var_17_0

	local var_17_1 = var_0_1:getTissueMaxLevel(self._tissueId)

	if var_17_1 <= var_17_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(111906))

		return
	end

	local var_17_2 = var_0_1:getNextLevelSumValue(self._tissueId)
	local var_17_3 = math.min(var_17_1, (var_0_1:getTotalLevelByKnightTissueId(self._tissueId)))

	if var_17_3 < var_17_2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(111908))
	else
		g.core.network.GameNetProxy:send_C2S_KnightTissue_UpLv({
			id = self._tissueId,
			level = var_17_3
		})
		self.m_openOneKeyController:setSelectedIndex(0)
	end
end

return KnightTissueDetailsPop
