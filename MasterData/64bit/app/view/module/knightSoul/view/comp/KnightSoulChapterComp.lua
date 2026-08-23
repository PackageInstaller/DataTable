local var_0_0 = g.core.model.User.knightSoulData
local var_0_1 = g.core.const.ConstMgr.KnightSoulConst
local var_0_2 = g.core.module.ModuleManager
local KnightSoulChapterComp = class("KnightSoulChapterComp", require("app.fairyGUI.knightSoul.UI_KnightSoulChapterComp"))

function KnightSoulChapterComp:ctor()
	self._cfg = {}
	self._isUnlock = false
	self._unlockTipHelp = 0
	self._chapterId = 0
	self._unlockType = var_0_1.UNLOCK_TYPE.LEVEL

	self:addClickListener(handler(self, self._onClickSelf))
	self.getSharedTrans(self, "listCardAUiScaleIn", "CombineBagList", self)
end

function KnightSoulChapterComp:updateChapterComp(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1.cfg

	self._cfg = arg_2_1.cfg

	self.m_chapterTitle:setText(var_2_0.name)
	self.m_chapterIcon:setURL(g.core.common.Path:getKnightSoulChapterPic(var_2_0.image))

	self._chapterId = var_2_0.id
	self._isUnlock, self._unlockType, self._unlockTipHelp = var_0_0:isChapterUnlock(self._chapterId)

	self.m_isUnlockController:setSelectedIndex(self._isUnlock and 1 or 0)

	if not self._isUnlock then
		if self._unlockType == var_0_1.UNLOCK_TYPE.LEVEL then
			self.m_lockTip:setText(g.core.lang:get(410626, {
				name = self._unlockTipHelp
			}))
		elseif self._unlockType == var_0_1.UNLOCK_TYPE.HONOR then
			self.m_lockTip:setText(g.core.lang:get(410605, {
				name = self._unlockTipHelp
			}))
		end
	end

	local var_2_1, var_2_2 = var_0_0:getBookActivateNumByChapterId(self._chapterId)

	self.m_isPerfectController:setSelectedIndex(var_2_1 == var_2_2 and 1 or 0)
	self.m_activateNum:setText(var_2_1 .. "/" .. var_2_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			chapterId = self._chapterId
		}
	})
	var_0_0:saveNewGMChapter(self._chapterId)
end

function KnightSoulChapterComp:_onClickSelf()
	if self._isUnlock then
		var_0_2:pushModule(g.view.entrance.KNIGHT_SOUL_BOOK_LAYER, {
			chapterId = self._chapterId
		})
	elseif self._unlockType == var_0_1.UNLOCK_TYPE.LEVEL then
		self.m_lockTip:setText(g.core.lang:get(410626, {
			name = self._unlockTipHelp
		}))
	elseif self._unlockType == var_0_1.UNLOCK_TYPE.HONOR then
		var_0_2:tip(g.core.lang:get(410605, {
			name = self._unlockTipHelp
		}))
	end
end

return KnightSoulChapterComp
