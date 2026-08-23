local var_0_0 = g.core.config.outpost_guide_info
local OutpostGuideVideoPop = class("OutpostGuideVideoPop", require("app.fairyGUI.outpost.UI_OutpostGuideVideoPop"), function()
	return fgui.GComponent:create({
		resName = "OutpostGuideVideoPop",
		pkgPath = "ui/outpost/outpost",
		pkgName = "outpost"
	}, ...)
end)

function OutpostGuideVideoPop:ctor()
	self:showAtCenter()

	self._movie = nil
	self._movieId = 0

	self.m_playBtn:addClickListener(handler(self, self._onClickPlayBtn))
	self:_updateView()
end

function OutpostGuideVideoPop:onLoad()
	if g.core.guide.GuideProxy:isGuideRunning() then
		self:_onClickPlayBtn()
	end
end

function OutpostGuideVideoPop:_updateView()
	local var_4_0 = var_0_0.get(1)

	self.m_mapDesc:setText(var_4_0.des)

	self._movieId = var_4_0.video

	self.m_videoPreview:setURL("pic/outpost/" .. var_4_0.thumbnail .. ".png")
end

function OutpostGuideVideoPop:addMovie()
	self._movie = self.m_movieComp:addCriSprite({
		x = 0,
		isLoop = false,
		y = 0,
		moduleName = "outpost",
		fullScreenState = 0,
		movieName = string.format("outpost%d_684x390", self._movieId),
		listener = handler(self, self._onPlayEnd)
	})
end

function OutpostGuideVideoPop:_onPlayEnd(arg_6_1, arg_6_2)
	if arg_6_1 == "complete" then
		self:_onVideoPlayEnd()
	end
end

function OutpostGuideVideoPop:_onVideoPlayEnd()
	if self._movie then
		self._movie:dispose()

		self._movie = nil
	end

	self.m_playBtn:setVisible(true)
end

function OutpostGuideVideoPop:_onClickPlayBtn()
	self:addMovie()
	self.m_playBtn:setVisible(false)
end

function OutpostGuideVideoPop:onUnload()
	if self._movie then
		self._movie:dispose()

		self._movie = nil
	end

	self:dispatchCompEvent("close_guide_video")
end

return OutpostGuideVideoPop
