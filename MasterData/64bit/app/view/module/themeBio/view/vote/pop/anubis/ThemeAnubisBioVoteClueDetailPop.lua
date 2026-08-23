local ThemeAnubisBioVoteClueDetailPop = class("ThemeAnubisBioVoteClueDetailPop", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteClueDetailPop"), function()
	return fgui.GComponent:create({
		pkgName = "themeBio",
		resName = "ThemeAnubisBioVoteClueDetailPop",
		pkgPath = "ui/themeBio/themeBio"
	}, ...)
end)

function ThemeAnubisBioVoteClueDetailPop:ctor(arg_2_1)
	self:showAtCenter()

	arg_2_1 = arg_2_1 or {}
	self._info = arg_2_1.info
end

function ThemeAnubisBioVoteClueDetailPop:onLoad()
	self:_updateClue()
	self.m_enterTransition:play()
end

function ThemeAnubisBioVoteClueDetailPop:_updateClue()
	if self._info then
		self.m_title:setText(self._info.name)
		self.m_titleShadow:setText(self._info.name)
		self.m_descTxt:setTitle(self._info.description)
		self.m_icon:setURL(g.core.common.Path:getMiddleItemIconById(self._info.icon))
	end
end

return ThemeAnubisBioVoteClueDetailPop
