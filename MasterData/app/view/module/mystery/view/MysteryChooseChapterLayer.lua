local var_0_0 = g.core.model.User.mysteryData
local var_0_1 = g.core.const.ConstMgr.MysteryConst
local var_0_2 = g.core.event.enum
local MysteryChooseChapterLayer = class("MysteryChooseChapterLayer", require("app.fairyGUI.mystery.UI_MysteryChooseChapterLayer"), function()
	return fgui.GComponent:create({
		resName = "MysteryChooseChapterLayer",
		pkgPath = "ui/mystery/mystery",
		pkgName = "mystery"
	}, ...)
end)

function MysteryChooseChapterLayer:ctor()
	self:showAtCenter()
	self:getView():setSize(display.width, display.height)
	self:addBg("bg/mystery/bg_symj_zhangjie.jpg", nil, nil, 1)

	self._curChapterId = var_0_0:getCurChapterId()
	self._pageIndex = math.max(1, math.ceil(self._curChapterId / var_0_1.CHAPTER_MAX_COUNT))
	self._chapterList = {}

	self:_initRegisterUI()
	self.m_enterTransition:play()
end

function MysteryChooseChapterLayer:_initRegisterUI()
	self.m_lastBtn:addClickListener(handler(self, self._onClickLastBtn))
	self.m_nextBtn:addClickListener(handler(self, self._onClickNextBtn))
	self.m_chapterList:setIniter()
	self.m_chapterList:setItemRenderer(handler(self, self._onChapterItemRenderer))
	self.m_chapterList:setScrollEnabled(false)
	self:addListen(self.m_chapterList)
	self.m_playTimesComp:initView({
		playNum = g.core.const.ConstMgr.ShopConst.PLAY_TYPE.MYSTERY_MONSTER_COUNT,
		getTimesFunc = function()
			return (var_0_0:getChallengeTime())
		end,
		refreshEvent = {
			var_0_2.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM,
			var_0_2.EVENT_CROSS_DAY_NOTIFY
		}
	})
end

function MysteryChooseChapterLayer:_onChapterItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateChapterCell(self._chapterList[arg_5_1 + 1])
end

function MysteryChooseChapterLayer:onLoad()
	self:_updateMainView()
end

function MysteryChooseChapterLayer:_updateMainView()
	self._chapterPage = var_0_0:getChapterPage()
	self._maxPageCount = table.nums(self._chapterPage)

	if self._pageIndex > self._maxPageCount then
		self._pageIndex = self._maxPageCount
	end

	self._chapterList = self._chapterPage[self._pageIndex]

	self.m_chapterList:setNumItems(#self._chapterList)
	self.m_lastBtn:setVisible(not checkbool(self._pageIndex <= 1))
	self.m_nextBtn:setVisible(not checkbool(self._pageIndex >= self._maxPageCount))
end

function MysteryChooseChapterLayer:_onClickLastBtn()
	if self._pageIndex <= 1 then
		self.m_lastBtn:setVisible(false)

		return
	end

	self._pageIndex = self._pageIndex - 1

	self:_updateMainView()
end

function MysteryChooseChapterLayer:_onClickNextBtn()
	if self._pageIndex >= self._maxPageCount then
		self.m_nextBtn:setVisible(false)

		return
	end

	self._pageIndex = self._pageIndex + 1

	self:_updateMainView()
end

function MysteryChooseChapterLayer:receiveCompEvent(arg_10_1)
	if arg_10_1 == "CHANGE_SELECT_MAP" then
		var_0_0:setCurChapterId(({
			...
		})[1])
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MYSTERY_CHAGNG_CHAPTER, true, {})
	end
end

return MysteryChooseChapterLayer
