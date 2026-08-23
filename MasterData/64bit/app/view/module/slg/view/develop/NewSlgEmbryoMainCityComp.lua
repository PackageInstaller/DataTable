local var_0_0 = g.core.model.User.newSlgDevelopData
local NewSlgEmbryoMainCityComp = class("NewSlgEmbryoMainCityComp", require("app.fairyGUI.newSlg.UI_NewSlgEmbryoMainCityComp"))

function NewSlgEmbryoMainCityComp:ctor()
	self.m_previewBtn:addClickListener(handler(self, self._onClickPreviewBtn))
end

function NewSlgEmbryoMainCityComp:updateView(arg_2_1)
	arg_2_1 = arg_2_1 or 0

	self:updateAuthority(arg_2_1)
	self.m_levelTxt:setText(g.core.lang:get(2052, {
		level = var_0_0:getMainCityLv()
	}))
	self.m_buildPic:setURL(g.core.common.Path:getNewSlgMainCityBigPic(var_0_0:getMainCityCfg().res_id))
	self.m_previewBtn:setVisible(arg_2_1 == 0)

	if arg_2_1 > 0 then
		self.m_showEmbryoController:setSelectedIndex(1)
		self.m_embryoPic:setURL(g.core.common.Path:getNewSlgEmbryoPic(arg_2_1))
	else
		self.m_showEmbryoController:setSelectedIndex(0)
	end
end

function NewSlgEmbryoMainCityComp:updateAuthority(arg_3_1)
	if arg_3_1 > 0 then
		self.m_authority:setText(g.core.lang:get(429532, {
			num = var_0_0:getAuthorityByType(arg_3_1)
		}))
	else
		local var_3_0 = {}

		var_3_0.num = var_0_0:getTotalAuthority()

		self.m_authority:setText(g.core.lang:get(429532, var_3_0))
	end
end

function NewSlgEmbryoMainCityComp:_onClickPreviewBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.slg.view.team.NewSlgTeamRulePop").new(), {
		touchDisappear = true
	})
end

return NewSlgEmbryoMainCityComp
