local GuildDungeonChapComp = class("GuildDungeonChapComp", require("app.fairyGUI.guildDungeon.UI_GuildDungeonChapComp"))
local var_0_1 = g.core.model.User.guildDungeonData
local var_0_2 = g.core.model.User.guildData
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.common.Path
local var_0_5 = g.core.const.ConstMgr.GuildDungeonConst

function GuildDungeonChapComp:ctor()
	self._chapterId = 0
	self._chapterInfo = {}
	self._isCurChap = true
	self._curChapterId = 0
	self._isClear = true
	self._isLvEnough = true
	self._battleEffect = nil

	local var_1_0 = self.m_loop:getSize()

	self.m_loop:addEffectSpine({
		isLoop = true,
		name = "eff_ui_dungeon_locationLoop",
		scale = 1,
		x = var_1_0.width / 2,
		y = var_1_0.height / 2
	})
	self:_addListener()
end

function GuildDungeonChapComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_FINISH, handler(self, self._onForceGuideEnd), self)
end

function GuildDungeonChapComp:updateComp(arg_3_1)
	if arg_3_1 then
		self._chapterId = arg_3_1.chapterId or 0
	end

	if self._chapterId <= 0 then
		return
	end

	if self._chapterId == var_0_5.MAX_CHAPTER_NUM then
		self.m_isLastController:setSelectedIndex(1)
	else
		self.m_isLastController:setSelectedIndex(0)
	end

	local var_3_0 = var_0_1:getCurChapter()

	self._curChapterId = var_3_0:getChapterId()
	self._isCurChap = self._chapterId == self._curChapterId
	self._isClear = self._chapterId < self._curChapterId

	local var_3_1 = var_0_2:getGuildLevel()
	local var_3_2 = var_0_1:getChapterById(self._chapterId)

	self._chapterInfo = var_3_2:getCfg()
	self._isLvEnough = var_3_1 >= self._chapterInfo.level

	self.m_chapterIcon:setURL((var_0_4:getGuildDungeonPicById(self._chapterInfo.pic)))
	self.m_nameTxt:setText(self._chapterId .. "." .. self._chapterInfo.name)

	if self._isCurChap then
		self.m_isCurController:setSelectedIndex(1)

		if self._isLvEnough then
			local var_3_3 = var_3_2:getChapterTotalHp()

			self.m_stateController:setSelectedIndex(1)

			local var_3_4 = math.uint64_sub(var_3_3, (var_3_0:getCurrentHp()))

			self.m_progressTxt:setText(string.format("%d", math.uint64_mul(math.uint64_div(var_3_4, var_3_3), 100)) .. "%")
			self.m_progress:setPercent({
				cur = var_3_4,
				max = var_3_3
			})
		else
			self.m_stateController:setSelectedIndex(0)
		end
	else
		self.m_stateController:setSelectedIndex(self._isClear and 2 or 0)
		self.m_isCurController:setSelectedIndex(0)
	end

	self:_checkSpeWeakGuide()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		customData = {
			chapterId = self._chapterId
		},
		redPointComp = self.m_redPointComp
	})
end

function GuildDungeonChapComp:_addListener()
	self:addClickListener(handler(self, self._onClickChap))
end

function GuildDungeonChapComp:_onClickChap()
	local var_5_0 = self._curChapterId < self._chapterId

	if self._isCurChap then
		if self._isLvEnough then
			self:dispatchCompEvent("GuildDungeonChapComp_goToChap", {
				chapterId = self._chapterId
			})
			var_0_3:pushModule(g.view.entrance.GUILD_CHAPTER, {
				chapterId = self._chapterId
			})
		else
			var_0_3:tip(g.core.lang:get(306008, {
				level = self._chapterInfo.level
			}))
		end
	elseif var_5_0 then
		var_0_3:tip(g.core.lang:get(306009, {
			chapter = math.max(1, self._chapterInfo.id - 1)
		}))
	else
		self:dispatchCompEvent("GuildDungeonChapComp_goToChap", {
			chapterId = self._chapterId
		})
	end
end

function GuildDungeonChapComp:_onForceGuideEnd()
	self:_checkSpeWeakGuide()
end

function GuildDungeonChapComp:_checkSpeWeakGuide()
	if self.m_stateController:getSelectedIndex() == 1 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_DUNGEON_WEAK_FINGER",
			targetBtn = self
		})
	end
end

function GuildDungeonChapComp:onUnload()
	if self.m_stateController:getSelectedIndex() == 1 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	end
end

return GuildDungeonChapComp
