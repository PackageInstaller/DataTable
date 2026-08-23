local var_0_0 = {}

var_0_0.URL = "ui://zu2o9ms9o0vs18"

function var_0_0:__ctor()
	self.m_isMovieOnController = self:getController("isMovieOn")
	self.m_guideTypeController = self:getController("guideType")
	self.m_popPanel = self:getChild("popPanel")
	self.m_movieComp = self:getChild("movieComp")
	self.m_guidePic = self:getChild("guidePic")
	self.m_playBtn = self:getChild("playBtn")
	self.m_prevBtn = self:getChild("prevBtn")
	self.m_nextBtn = self:getChild("nextBtn")
	self.m_descTxt = self:getChild("descTxt")
	self.m_pageTxt = self:getChild("pageTxt")
	self.m_content = self:getChild("content")
end

return var_0_0
