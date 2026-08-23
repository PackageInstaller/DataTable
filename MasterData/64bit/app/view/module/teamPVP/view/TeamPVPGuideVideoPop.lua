local var_0_0 = g.core.model.User.teamPvpData
local TeamPVPGuideVideoPop = class("TeamPVPGuideVideoPop", require("app.fairyGUI.teamPVP.UI_TeamPVPGuideVideoPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/teamPVP/teamPVP",
		resName = "TeamPVPGuideVideoPop",
		pkgName = "teamPVP"
	}, ...)
end)

function TeamPVPGuideVideoPop:ctor()
	self:showAtCenter()

	self._movie = nil
	self._movieId = 0

	self.m_autoPopBtn:addEventListener(fgui.UIEventType.Changed, handler(self, self._onClickAutoPopBtn))
	self.m_playBtn:addClickListener(handler(self, self._onClickPlayBtn))
	self:_updateView()
end

function TeamPVPGuideVideoPop:_updateView()
	local var_3_0 = var_0_0:getMapInfo()

	self.m_mapName:setText(var_3_0.name)
	self.m_mapDesc:setText(var_3_0.details_des)

	self._movieId = var_3_0.video

	self.m_videoPreview:setURL(g.core.common.Path:getTeamPVPVideoPreview(self._movieId))

	local var_3_1 = var_0_0:isGuideVideoPopSelected()

	self.m_autoPopBtn:setSelected(var_3_1)
	var_0_0:saveGuideVideoPopState(var_3_1)
end

function TeamPVPGuideVideoPop:addMovie()
	self._movie = self.m_movieComp:addCriSprite({
		moduleName = "teamPvp",
		isLoop = false,
		x = 0,
		y = 0,
		fullScreenState = 0,
		movieName = string.format("teamPvp%d_684x390", self._movieId),
		listener = handler(self, self._onPlayEnd)
	})
end

function TeamPVPGuideVideoPop:_onPlayEnd(arg_5_1, arg_5_2)
	if arg_5_1 == "complete" then
		self:_onVideoPlayEnd()
	end
end

function TeamPVPGuideVideoPop:_onVideoPlayEnd()
	if self._movie then
		self._movie:dispose()

		self._movie = nil
	end

	self.m_playBtn:setVisible(true)
end

function TeamPVPGuideVideoPop:_onClickAutoPopBtn()
	var_0_0:saveGuideVideoPopState((self.m_autoPopBtn:isSelected()))
end

function TeamPVPGuideVideoPop:_onClickPlayBtn()
	self:addMovie()
	self.m_playBtn:setVisible(false)
end

function TeamPVPGuideVideoPop:onUnload()
	if self._movie then
		self._movie:dispose()

		self._movie = nil
	end

	self:dispatchCompEvent("close_guide_video")
end

return TeamPVPGuideVideoPop
