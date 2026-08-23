local var_0_0 = g.core.const.ConstMgr.GuildDungeonConst.LAYER_CHAP_NUM
local var_0_1 = g.core.const.ConstMgr.GuildDungeonConst.LAST_LAYER_CHAP_NUM
local GuildDungeonChapterComp = class("GuildDungeonChapterComp", require("app.fairyGUI.guildDungeon.UI_GuildDungeonChapterComp"))

function GuildDungeonChapterComp:ctor()
	self._chapterData = nil

	for iter_1_0 = 1, var_0_1 do
		if self["m_chap" .. iter_1_0] then
			self:addListen(self["m_chap" .. iter_1_0])
		end
	end
end

function GuildDungeonChapterComp:initComp(arg_2_1)
	self._chapterData = arg_2_1
end

function GuildDungeonChapterComp:updateComp(arg_3_1, arg_3_2)
	local var_3_0 = var_0_0

	if arg_3_2 then
		var_3_0 = var_0_1

		self.m_styleController:setSelectedIndex(2)
	else
		self.m_styleController:setSelectedIndex(arg_3_1 % 2)
	end

	for iter_3_0 = 1, var_3_0 do
		if self["m_chap" .. iter_3_0] and self["m_chap" .. iter_3_0].updateComp then
			self["m_chap" .. iter_3_0]:updateComp({
				chapterId = self._chapterData[arg_3_1 * var_0_0 + iter_3_0]
			})
		end
	end
end

return GuildDungeonChapterComp
