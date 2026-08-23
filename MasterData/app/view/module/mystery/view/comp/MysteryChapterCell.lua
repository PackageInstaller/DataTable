local var_0_0 = g.core.model.User.mysteryData
local MysteryChapterCell = class("MysteryChapterCell", require("app.fairyGUI.mystery.UI_MysteryChapterCell"))

function MysteryChapterCell:ctor()
	self._chapterData = {}

	self:addClickListener(handler(self, self._onClick))
end

function MysteryChapterCell:updateChapterCell(arg_2_1)
	self._chapterData = arg_2_1
	self._chapterCfg = arg_2_1:getChapterConfig()

	local var_2_0 = arg_2_1:getUnlockBossId()

	self.m_chapterNameTxt:setText(self._chapterCfg.name)
	self.m_chapterLoader:setURL(g.core.common.Path:getMysteryChapterPic(self._chapterCfg.pic_id))
	self.m_stateController:setSelectedIndex(arg_2_1:isUnlockChapter() and 0 or 1)
	self.m_isCurController:setSelectedIndex(self._chapterCfg.id == var_0_0:getCurChapterId() and 1 or 0)
	self.m_isPassController:setSelectedIndex(self._chapterData:isPassed() and 1 or 0)

	if var_2_0 > 0 then
		self.m_haveBossController:setSelectedIndex(1)
		self.m_bossIconComp:updateBossIcon(var_2_0)
	else
		self.m_haveBossController:setSelectedIndex(0)
	end

	self.m_enterTransition:play()
end

function MysteryChapterCell:_onClick()
	if not self._chapterData:isUnlockChapter() then
		g.core.module.ModuleManager:tip(g.core.lang:get(423004, {
			name = var_0_0:getChapterDataById(self._chapterCfg.last_id):getChapterConfig().name
		}))
	else
		local var_3_0 = self._chapterCfg.id

		if self._chapterCfg.id == var_0_0:getCurChapterId() then
			g.core.module.ModuleManager:tip(g.core.lang:get(423005))

			return
		end

		var_0_0:setCurChapterId(var_3_0)
		self:dispatchCompEvent("CHANGE_SELECT_MAP", var_3_0)
	end
end

return MysteryChapterCell
