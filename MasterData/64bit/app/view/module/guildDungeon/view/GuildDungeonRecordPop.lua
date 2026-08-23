local GuildDungeonRecordPop = class("GuildDungeonRecordPop", require("app.fairyGUI.guildDungeon.UI_GuildDungeonRecordPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/guildDungeon/guildDungeon",
		resName = "GuildDungeonRecordPop",
		pkgName = "guildDungeon",
		isFullScreen = true
	})
end)
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.const.ConstMgr

function GuildDungeonRecordPop:ctor(arg_2_1)
	if arg_2_1 then
		self._tabEnterIdx = arg_2_1.index or 0
	end

	self._stageList = g.core.model.User.guildDungeonData:getChapterById((arg_2_1 or nil) and (arg_2_1.chapterId or 0)):getStageList()
	self._curStageData = {}
	self._recordData = {}
	self._recordMap = {}
	self._rankList = nil
	self._stageIndex = 1

	self:_initUI()
end

function GuildDungeonRecordPop:_initUI()
	self.m_topBar:updateTopRes({
		{
			type = var_0_1.TYPE_RESOURCE,
			value = var_0_1.RESOURCE.TYPE_GUILD_DUN_TIME
		},
		{
			value = 0,
			type = var_0_1.TYPE_GOLD
		},
		{
			type = var_0_1.TYPE_RESOURCE,
			value = var_0_1.RESOURCE.TYPE_STAMINA
		}
	})
	self.m_topBar:setHelpId(var_0_2.HelpConst.HELP_TYPE.GUILD_DUNGEON)
	self:addBg("bg/common/pic_bb_beijing.jpg")

	for iter_3_0 = 1, g.core.const.ConstMgr.GuildDungeonConst.STAGE_NUM do
		self["m_tab" .. iter_3_0]:setTitle(self._stageList[iter_3_0]:getCfg().dungeon_name_1)
	end

	self.m_rankList:setVirtual(self)
	self.m_rankList:setItemRenderer(handler(self, self._onRankItemRenderer))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
end

function GuildDungeonRecordPop:_onRankItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell({
		recordData = self._recordData[arg_4_1 + 1],
		rank = arg_4_1 + 1
	})
end

function GuildDungeonRecordPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETSTAGEMVPAWARD, self._onRcvGetMvpAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETMEMBERDAMAGE, self._onRcvGetMemberDamage, self)
	self:_updateView()
end

function GuildDungeonRecordPop:_updateView()
	if self._tabEnterIdx > 0 then
		self.m_tabController:setSelectedIndex(self._tabEnterIdx - 1)
		self:_refreshTab(self._tabEnterIdx)

		self._tabEnterIdx = 0
	else
		self:_switchTab()
	end
end

function GuildDungeonRecordPop:_onRcvGetMvpAward(arg_7_1, arg_7_2, arg_7_3)
	g.core.module.ModuleManager:awardSummary(arg_7_3.awards)
end

function GuildDungeonRecordPop:_onRcvGetMemberDamage(arg_8_1, arg_8_2, arg_8_3)
	self._recordMap[arg_8_3.stage_id] = {}

	for iter_8_0 = 1, #(arg_8_3.members or {}) do
		local var_8_1 = {}

		var_8_1.damage = arg_8_3.damages[iter_8_0] or 0
		var_8_1.member = arg_8_3.members[iter_8_0] or {}

		table.insert(self._recordMap[arg_8_3.stage_id], var_8_1)
	end

	table.sort(self._recordMap[arg_8_3.stage_id], function(arg_9_0, arg_9_1)
		if not math.uint64_equal(arg_9_0.damage, arg_9_1.damage) then
			return not math.uint64_lt(arg_9_0.damage, arg_9_1.damage, true)
		end
	end)
	self:_updateRecordList(arg_8_3.stage_id)
end

function GuildDungeonRecordPop:_switchTab()
	self:_refreshTab(self.m_tabController:getSelectedIndex() + 1)
end

function GuildDungeonRecordPop:_refreshTab(arg_11_1)
	self._stageIndex = arg_11_1
	self._curStageData = self._stageList[arg_11_1]

	local var_11_0 = self._curStageData:getStageId()

	if not self._recordMap[var_11_0] then
		g.core.network.GameNetProxy:send_C2S_GuildDungeon_GetMemberDamage({
			stage_id = var_11_0
		})
	else
		self:_updateRecordList(var_11_0)
	end
end

function GuildDungeonRecordPop:_updateRecordList(arg_12_1)
	self._recordData = self._recordMap[arg_12_1]

	self.m_isEmptyController:setSelectedIndex(next(self._recordData) and 0 or 1)

	if self._recordData then
		self.m_rankList:setNumItems(#self._recordData)
	end

	self:_updateMvpAward(self._stageIndex)
end

function GuildDungeonRecordPop:_updateMvpAward(arg_13_1)
	local var_13_0 = self._stageList[arg_13_1]:getCfg()

	self.m_resComp:updateByTVS({
		type = var_13_0.mvp_award_type_1,
		value = var_13_0.mvp_award_value_1,
		size = var_13_0.mvp_award_size_1
	})
end

function GuildDungeonRecordPop:_onChangeTabCtrl()
	self:_switchTab()
end

return GuildDungeonRecordPop
