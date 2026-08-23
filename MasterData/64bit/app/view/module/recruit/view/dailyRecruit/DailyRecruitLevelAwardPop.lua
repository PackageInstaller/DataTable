local var_0_0 = g.core.model.User.recruitData
local DailyRecruitLevelAwardPop = class("DailyRecruitLevelAwardPop", require("app.fairyGUI.recruitDaily.UI_DailyRecruitLevelAwardPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/recruitDaily/recruitDaily",
		resName = "DailyRecruitLevelAwardPop",
		pkgName = "recruitDaily"
	})
end)

function DailyRecruitLevelAwardPop:ctor()
	self._showLevelList = var_0_0:getDailyRecruitLevelList()
	self._isInit = false

	self:showAtCenter()
	self:initView()
end

function DailyRecruitLevelAwardPop:initView()
	self.m_showList:setIniter()
	self.m_showList:setItemRenderer(handler(self, self._onShowListRenderer))
end

function DailyRecruitLevelAwardPop:_onShowListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateLevelAwardCell(g.core.config.daily_recruit_info.get(self._showLevelList[arg_4_1 + 1]))
end

function DailyRecruitLevelAwardPop:onLoad()
	self.m_showList:setNumItems(#self._showLevelList - 1)

	local var_5_0 = var_0_0:getDailyRecruitInfo().level

	self.m_showList:scrollToView(math.clamp(var_5_0 - 2, 0, #self._showLevelList - 1), true)
	self.m_levelText:setText(var_5_0)
	self.m_progressText:setText(var_0_0:getDailyRecruitTotalTimes())
end

return DailyRecruitLevelAwardPop
