local var_0_0 = g.core.config.general_guide_info
local var_0_1 = g.core.const.ConstMgr.GuideConst
local var_0_2 = g.core.common.Path
local GuideCommonPopup = class("GuideCommonPopup", require("app.fairyGUI.guide.UI_GuideCommonPopup"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/guide/guide",
		resName = "GuideCommonPopup",
		pkgName = "guide"
	}, ...)
end)

function GuideCommonPopup:ctor(arg_2_1)
	self:showAtCenter()

	self._guideInfoArr = {}

	for iter_2_0, iter_2_1 in var_0_0.ipairs() do
		if iter_2_1.group == arg_2_1.group then
			table.insert(self._guideInfoArr, iter_2_1)
		end
	end

	self._curPage = 1
	self._movName = ""
	self._isMovieOn = false
	self._maxPage = #(self._guideInfoArr or {})

	self.m_playBtn:addClickListener(handler(self, self._onClickPlayBtn))
	self.m_prevBtn:addClickListener(handler(self, self._onClickPrevPage))
	self.m_nextBtn:addClickListener(handler(self, self._onClickNextPage))
	self:_updateView()
end

function GuideCommonPopup:_updateView()
	if self._guideInfoArr[self._curPage] then
		self.m_popPanel:setTitle(self._guideInfoArr[self._curPage].page_title)
		self.m_descTxt:getChild("descTxt"):setText(self._guideInfoArr[self._curPage].page_text)
		self.m_pageTxt:setText(self._curPage .. "/" .. self._maxPage)
		self.m_guidePic:setURL((var_0_2:getCommonGuidePic(self._guideInfoArr[self._curPage].pic)))
		self.m_guideTypeController:setSelectedIndex(self._guideInfoArr[self._curPage].page_show_type)

		self._movName = self._guideInfoArr[self._curPage].page_show_type == var_0_1.COMMON_GUIDE_PAGE_SHOW_TYPE.VIDEO and self._guideInfoArr[self._curPage].video or ""

		self.m_prevBtn:setVisible(self._curPage > 1)
		self.m_nextBtn:setVisible(self._curPage < self._maxPage)
	end
end

function GuideCommonPopup:_onClickNextPage()
	if self._curPage == self._maxPage then
		return
	end

	self:_onVideoPlayEnd()

	self._curPage = self._curPage + 1

	self:_updateView()
end

function GuideCommonPopup:_onClickPrevPage()
	if self._curPage == 1 then
		return
	end

	self:_onVideoPlayEnd()

	self._curPage = self._curPage - 1

	self:_updateView()
end

function GuideCommonPopup:_addMovie()
	self._movie = self.m_movieComp:addCriSprite({
		fullScreenState = 0,
		isLoop = false,
		moduleName = "commonGuide",
		x = 0,
		y = 0,
		movieName = self._movName,
		listener = handler(self, self._onPlayEnd)
	})
end

function GuideCommonPopup:_onPlayEnd(arg_7_1, arg_7_2)
	if arg_7_1 == "complete" then
		self:_onVideoPlayEnd()
	end
end

function GuideCommonPopup:_onVideoPlayEnd()
	if self._movie then
		self._movie:dispose()

		self._movie = nil
	end

	self._isMovieOn = false

	self.m_isMovieOnController:setSelectedIndex(0)
end

function GuideCommonPopup:_onClickPlayBtn()
	self.m_isMovieOnController:setSelectedIndex(1)
	self:_addMovie()
end

function GuideCommonPopup:onUnload()
	self:_onVideoPlayEnd()
end

return GuideCommonPopup
