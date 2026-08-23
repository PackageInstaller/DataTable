local var_0_0 = g.core.common.Path
local BaseKnightNameComp = class("BaseKnightNameComp", require("app.fairyGUI.base_new.UI_BaseKnightNameComp"))

function BaseKnightNameComp:ctor()
	self._classical = 0
	self._knightCfg = nil

	self.m_elementLoader:addClickListener(handler(self, self._onClickElemDetail))
end

function BaseKnightNameComp:updateComp(arg_2_1)
	local var_2_0 = arg_2_1:getBaseInfo()

	self._knightCfg = var_2_0

	if var_2_0.type == 1 then
		self.m_nameText:setText((g.core.model.User:getName()))
	else
		self.m_nameText:setText(var_2_0.name)
	end

	local var_2_1 = arg_2_1:getAdvStageAndLevel()
	local var_2_2

	if var_2_1 > 0 then
		self.m_stageText:setText("+" .. var_2_1)
	else
		self.m_stageText:setText("")

		var_2_2 = {
			index = 3,
			style = 2,
			gap = -1
		}
	end

	var_2_2.num = arg_2_1:getStarLv()

	self.m_starComp:initStar(var_2_2)

	local var_2_3 = arg_2_1:getInfo()

	self.m_fightValueText:setText((var_2_3 or nil) and (var_2_3.fight_value or 0))
	self.m_featureNumController:setSelectedIndex(0)
	self.m_featureText1:setText(var_2_0.feature)
	self.m_isElementLeaderController:setSelectedIndex(arg_2_1:isElementLeader() and 1 or 0)
	self.m_nameBgLoader:setURL((var_0_0:getKnightNameQualityBg(var_2_0.quality)))
	self.m_qualityLoader:setURL((var_0_0:getQualityArtTxtURLNew(var_2_0.quality)))
	self.m_professionIcon:setURL((var_0_0:getKnightProfessionAndDamageTypeIcon(var_2_0.profession, var_2_0.attack_type)))
	self.m_professionTxt:setText(arg_2_1:getProfessionTxt())

	self._classical = var_2_0.classical

	if var_2_0.classical ~= 0 then
		self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(var_2_0.classical))
	else
		self.m_elementLoader:setURL("")
	end
end

function BaseKnightNameComp:setIsOthers(arg_3_1)
	return
end

function BaseKnightNameComp:_onClickElemDetail()
	if self._classical == 0 then
		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.BaseClassicalDetailPop").new({
		classical = self._classical,
		knightCfg = self._knightCfg
	})))
end

return BaseKnightNameComp
