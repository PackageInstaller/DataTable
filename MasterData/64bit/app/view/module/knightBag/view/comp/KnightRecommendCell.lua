local var_0_0 = g.core.model.User.knightsData
local KnightRecommendCell = class("KnightRecommendCell", require("app.fairyGUI.knightBag.UI_KnightRecommendCell"))

function KnightRecommendCell:ctor()
	self._knightId1 = 0
	self._knightId2 = 0

	self.m_knightCard1:addClickListener(handler(self, self._onClickKnight1))
	self.m_knightCard2:addClickListener(handler(self, self._onClickKnight2))
end

function KnightRecommendCell:updateCell(arg_2_1)
	self.m_index:setText(arg_2_1.pos)

	self._knightId1 = arg_2_1.knightId
	self._knightId2 = arg_2_1.replaceId

	self.m_hasKnight1Controller:setSelectedIndex(arg_2_1.hasKnight and 1 or 0)
	self.m_hasKnight2Controller:setSelectedIndex(arg_2_1.hasReplace and 1 or 0)

	if arg_2_1.replaceId == 0 then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)

		local var_2_0 = var_0_0:getKnight({
			base_id = arg_2_1.replaceId
		})

		self.m_knightCard2:updatePic(var_2_0)
		self.m_isCaptain2Controller:setSelectedIndex(var_2_0:isElementLeader() and 1 or 0)

		local var_2_1 = var_2_0:getCfg()

		self.m_professionBg2:setURL(g.core.common.Path:getProfessionBg(var_2_1.attack_type))
		self.m_professionIcon2:setURL(g.core.common.Path:getKnightProfessionAndDamageTypeIcon(var_2_1.profession, 0))
		self.m_elementIcon2:setURL(g.core.common.Path:getKnightElementIcon(var_2_1.classical))
	end

	local var_2_2 = var_0_0:getKnight({
		base_id = arg_2_1.knightId
	})

	self.m_knightCard1:updatePic(var_2_2)
	self.m_knightName1:setText((var_2_2:getName()))
	self.m_isCaptain1Controller:setSelectedIndex(var_2_2:isElementLeader() and 1 or 0)

	local var_2_3 = var_2_2:getCfg()

	self.m_professionBg1:setURL(g.core.common.Path:getProfessionBg(var_2_3.attack_type))
	self.m_professionIcon1:setURL(g.core.common.Path:getKnightProfessionAndDamageTypeIcon(var_2_3.profession, 0))
	self.m_elementIcon1:setURL(g.core.common.Path:getKnightElementIcon(var_2_3.classical))

	local var_2_4 = var_2_2:getArtifactId()

	self.m_artifactIcon1:setURL(g.core.common.Path:getArtifactIconById(var_2_4))
	self.m_hasArtifactController:setSelectedIndex(g.core.model.User.artifactData:hasArtifactByAdvanceId(var_2_4) and 1 or 0)
end

function KnightRecommendCell:_onClickKnight1()
	if self._knightId1 > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
			knightId = self._knightId1
		}), {
			touchDisappear = true,
			hideContinue = true
		})
	end
end

function KnightRecommendCell:_onClickKnight2()
	if self._knightId2 > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
			knightId = self._knightId2
		}), {
			touchDisappear = true,
			hideContinue = true
		})
	end
end

return KnightRecommendCell
