local DungeonLandComp = class("DungeonLandComp", require("app.fairyGUI.dungeon.UI_DungeonLandComp"))
local var_0_1 = g.core.config.dungeon_chapter_info
local var_0_2 = g.core.config.dungeon_land_info
local ShowFactory = require("app.view.module.show.ShowFactory")
local var_0_4 = g.core.model.User.dungeonData
local var_0_5 = g.core.event.EventManager
local var_0_6 = g.core.event.enum
local var_0_7 = g.core.model.User.storyData
local var_0_8 = g.core.const.ConstMgr
local var_0_9 = g.core.sound.SoundManager

function DungeonLandComp:ctor()
	self._chapterNum = 0
	self._landId = 0
	self._landInfo = nil
	self._newChapter = 0
	self._newChapterIndex = 1
	self._lastPassIndex = 0
	self._waitStateCount = 0
end

function DungeonLandComp:onLoad()
	ShowFactory:addLockLayer()
end

function DungeonLandComp:update(arg_3_1)
	self._landInfo = arg_3_1.landInfo
	self._newChapter = arg_3_1.newChapterId
	self._landId = self._landInfo.id or 1
	self._chapterNum = var_0_4:getChapterNumByLandId(self._landId)

	local var_3_0 = 0

	if self._landInfo.ctrl_id then
		var_3_0 = g.core.utils.Number.formatNumberByLimit(tonumber(self._landInfo.ctrl_id), 1, 4)
		var_3_0 = var_3_0 - 1
	end

	self.m_resIdController:setSelectedIndex(var_3_0)

	local var_3_1 = var_0_4:getLastPassedChapter()

	self._lastPassIndex = var_0_4:getChapterIndex(var_3_1)

	if self._newChapter and self._newChapter > 0 then
		var_0_5:dispatchEvent(var_0_6.EVENT_DUNGEON_CHAPTER_END, false, {
			story = {
				var_3_1
			}
		})

		self._newChapterIndex = var_0_4:getChapterIndex(self._newChapter)

		self:updateChapterState(var_3_1)

		if not var_0_7:isInStory() then
			self:_handleNewChapter(self._newChapter)
			var_0_4:resetNewChapterId()
			var_0_4:resetNewLandId()
		end
	else
		self:updateChapterState(var_0_4:getLastUnlockChapter(), arg_3_1.isNewLand)
		ShowFactory:unLockLayer()
	end
end

function DungeonLandComp:updateChapterState(arg_4_1, arg_4_2)
	local var_4_0

	for iter_4_0 = 1, var_0_4:getChapterNumByLandId(self._landId) do
		local var_4_1 = self._landInfo["chapter_" .. iter_4_0]
		local var_4_2 = self["m_chapter" .. iter_4_0]

		if not self["m_chapter" .. iter_4_0] then
			return
		end

		var_4_2:setVisible(var_4_1 > 0)

		if var_4_1 > 0 then
			var_4_2:update({
				chapterInfo = var_0_1.get(var_4_1),
				lastChapId = arg_4_1,
				preChapterId = var_4_0
			})

			var_4_0 = var_4_1
		end
	end

	if arg_4_2 then
		self:playNewLandChapterUnlockAni()
	end
end

function DungeonLandComp:_handleNewChapter(arg_5_1)
	local var_5_0 = var_0_4:getPreChapterId(arg_5_1)
	local var_5_1 = var_0_4:getChapterIndex(var_5_0)
	local var_5_2 = var_0_1.get(arg_5_1)
	local var_5_3 = g.core.model.User:getLevel() >= var_5_2.condition_level
	local var_5_4 = var_5_2.land_id

	if var_0_1.get(var_5_0).land_id == var_5_2.land_id then
		var_0_4:resetNewChapterId()

		local var_5_5 = self["m_chapter" .. var_5_1]

		if self["m_chapter" .. var_5_1] then
			var_0_9:playSound(var_0_8.SoundConst.Sound.CHAPTER_UNLOCK)
			self["m_chapter" .. var_5_1]:setHidePassIcon()
			self["m_chapter" .. self._newChapterIndex]:setCtrlState("isOpen", {
				index = 0
			})
			var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_WAIT)

			self._waitStateCount = self._waitStateCount + 1

			self:runFGAction(fgui.FSequence:create(fgui.FDelayTime:create(1), fgui.FCallFunc:create(handler(self, function()
				if var_5_5 then
					var_5_5:playPassEffect(handler(self, function()
						if var_5_3 then
							self:_updateRouteState(self._newChapterIndex)
							var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_READY)

							self._waitStateCount = self._waitStateCount - 1
						else
							ShowFactory:unLockLayer()
						end
					end))
				end
			end))))
		end
	else
		for iter_5_0 = 1, 5 do
			self["m_chapter" .. iter_5_0]:setCtrlState("isOpen", {
				index = 1
			})
			self["m_chapter" .. iter_5_0]:getChild("refresh"):addEffectSpine({
				name = "eff_ui_dungeon_refresh",
				scale = 1,
				isLoop = false
			})
		end

		var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_WAIT)

		self._waitStateCount = self._waitStateCount + 1

		self:newScheduleOnce(handler(self, function()
			var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_READY)

			self._waitStateCount = self._waitStateCount - 1

			local var_8_0 = var_0_2.get(var_5_4)

			if var_8_0 then
				self:dispatchCompEvent("DungeonListComp_select", {
					isNew = true,
					landInfo = var_8_0
				})
			end
		end), 0.7)
	end
end

function DungeonLandComp:playNewLandChapterUnlockAni()
	if self.m_chapter1 then
		local var_9_0 = self.m_chapter1:getSize()

		self.m_chapter1:addEffectSpine({
			isLoop = false,
			name = "eff_ui_dungeon_lock",
			scale = 1,
			x = var_9_0.width / 2 - 2,
			y = var_9_0.height / 2
		})
		self.m_chapter1:getTransition("lock"):play(handler(self, self._onUnlockPlayFinish))
	end

	self:newScheduleOnce(handler(self, self.checkDungeonPrimaryAward), 0.3)
end

function DungeonLandComp:_onUnlockPlayFinish()
	return
end

function DungeonLandComp:isCanAutoAction()
	return self._waitStateCount == 0
end

function DungeonLandComp:_updateRouteState(arg_12_1)
	local var_12_0 = self["m_chapter" .. arg_12_1]

	if self["m_line" .. arg_12_1 - 1] and self["m_chapter" .. arg_12_1] then
		var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_WAIT)

		self._waitStateCount = self._waitStateCount + 1

		local var_12_1 = self["m_chapter" .. arg_12_1]:getSize()

		self["m_line" .. arg_12_1 - 1]:getTransition("switch"):changeParams({
			xy = {
				self["m_line" .. arg_12_1 - 1]:getWidth(),
				-1
			}
		}):play(handler(self, function()
			var_12_0:addEffectSpine({
				isLoop = false,
				name = "eff_ui_dungeon_lock",
				scale = 1,
				x = var_12_1.width / 2 - 2,
				y = var_12_1.height / 2
			})
			var_12_0:updateChapterState(self._newChapter, true)
			var_12_0:getTransition("lock"):play(handler(self, self._onLockTransPlayEnd))
		end))
	end
end

function DungeonLandComp:_onLockTransPlayEnd()
	var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_READY)

	self._waitStateCount = self._waitStateCount - 1

	ShowFactory:unLockLayer()
	self:checkDungeonPrimaryAward()
end

function DungeonLandComp:onUnload()
	if self._waitStateCount > 0 then
		for iter_15_0 = 1, self._waitStateCount do
			var_0_5:dispatchEvent(var_0_6.EVENT_GUIDE_READY)
		end

		self._waitStateCount = 0
	end

	ShowFactory:unLockLayer()
end

function DungeonLandComp:checkDungeonPrimaryAward()
	if g.core.model.User.recruitData:isNewDungeonPrimaryAwardMatch() then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = g.core.lang:get(108444),
			confirmText = g.core.lang:get(309118),
			onConfirm = function()
				g.core.module.ModuleManager:pushModule(g.view.entrance.PRIMARY_RECRUIT)
			end
		}), {
			touchDisappear = true
		})
	end
end

function DungeonLandComp:doAutoAction()
	for iter_18_0 = 1, var_0_4:getChapterNumByLandId(self._landId) do
		if not self["m_chapter" .. iter_18_0] then
			return
		end

		if self["m_chapter" .. iter_18_0]:doAutoAction() then
			return
		end
	end
end

return DungeonLandComp
