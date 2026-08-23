local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local DrawKnight = require("app.view.common.DrawKnight")
local SpineBase = require("app.view.common.SpineBase")
local BattleConst = require("app.view.battle.const.BattleConst")
local BioChapterEndPop = class("BioChapterEndPop", require("app.fairyGUI.biography.UI_BioChapterEndPop"), function()
	return fgui.GComponent:create({
		pkgName = "biography",
		resName = "BioChapterEndPop",
		pkgPath = "ui/biography/biography"
	}, ...)
end)

function BioChapterEndPop:ctor(arg_2_1)
	self:showAtCenter()

	self._isCanAuto = false

	if arg_2_1 then
		self._chapterInfo = arg_2_1.chapterInfo or {}
	end

	self._callFunc = arg_2_1 and arg_2_1.callFunc

	if arg_2_1 then
		self._closeTime = arg_2_1.showTime or 2
	end

	self:_initView()
	self.m_bgIcon:setSize(display.width, display.height)
	self.m_bgIcon:setURL("bg/bio/pic_lzzy_tiaozhanjianglibg.png")
	self.m_enterTransition:play(handler(self, self._onChapterEnterFinish))
	self:addClickListener(handler(self, self.onCloseBioChapterEnd))
end

function BioChapterEndPop:onUnload()
	KnightVoiceCommon.stopVoice()
end

function BioChapterEndPop:_onChapterEnterFinish()
	self._isCanAuto = true
end

function BioChapterEndPop:_initView()
	local var_5_0 = g.core.config.biography_land_info.get(self._chapterInfo.land_id)

	self.m_nameTxt:setText(self._chapterInfo.name)
	self.m_descTxt:setText(self._chapterInfo.chapter_clear)

	for iter_5_0 = 1, 5 do
		if var_5_0["chapter_" .. iter_5_0] == 0 then
			break
		end

		if var_5_0["chapter_" .. iter_5_0] == self._chapterInfo.id then
			break
		end
	end

	self.m_chapterTxt:setText(var_5_0.id .. "-" .. self._chapterInfo.id)

	local var_5_4 = DrawKnight.new({
		isShowBg = true,
		isAlphaNode = true,
		scale = 1,
		resId = g.core.config.knight_base_info.get(self._chapterInfo.base_id).fight_id
	})

	var_5_4:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-150, -10, 390, 100), 300)
	self.m_placeComp:addChild(var_5_4)
	KnightVoiceCommon.playVoice({
		voiceType = "biography_sound",
		resId = self._chapterInfo.base_id,
		func = handler(self, self.onCloseBioChapterEnd)
	})
end

function BioChapterEndPop:doAutoAction()
	if self._isCanAuto then
		self:onCloseBioChapterEnd()

		return
	end

	self._isCanAuto = false
end

function BioChapterEndPop:onCloseBioChapterEnd()
	if not self._onExit and self.m_backTransition then
		self._onExit = true

		self.m_backTransition:play(handler(self, function()
			g.core.module.ModuleManager:popComponent()
			g.core.module.ModuleManager:tip(g.core.lang:get(111533))

			if self._callFunc then
				self._callFunc()
			end
		end))
	end
end

return BioChapterEndPop
