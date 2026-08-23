local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.model.User.guildData
local var_0_2 = g.core.model.User.guildDungeonData
local GuildDungeonBoxPop = class("GuildDungeonBoxPop", require("app.fairyGUI.guildDungeon.UI_GuildDungeonBoxPop"), function()
	return fgui.GComponent:create({
		resName = "GuildDungeonBoxPop",
		pkgPath = "ui/guildDungeon/guildDungeon",
		pkgName = "guildDungeon"
	})
end)

function GuildDungeonBoxPop:ctor(arg_2_1)
	self._stageList = self:_getGuildList((arg_2_1 or nil) and (arg_2_1.stageList or {}))
	self._rebirth = var_0_2:getRebirth()
	self._stageTreaData = {}
	self._curStageData = {}
	self._treasureList = nil
	self._curIndex = 0

	self:_initComp()
	self:_addListener()
end

function GuildDungeonBoxPop:onLoad()
	self:_addNetWorkListener()

	if not var_0_1:isResponse() then
		g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
	else
		self:_switchTab(true)
	end
end

function GuildDungeonBoxPop:_initComp()
	self:_initData()
	self:_initUI()
end

function GuildDungeonBoxPop:_initData()
	return
end

function GuildDungeonBoxPop:_initUI()
	self:showAtCenter()
	self.m_popPanel:setTitle(g.core.lang:get(306017, {
		num = self._rebirth
	}))
	self.m_descTxt:enableRich()
	self.m_descTxt:setText(g.core.lang:get(306002))
	self.m_tabList:setVirtual(self)
	self.m_tabList:setItemRenderer(handler(self, self._onRenderListTab))
	self.m_tabList:setNumItems(#self._stageList)
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onRenderListAward))
end

function GuildDungeonBoxPop:_addListener()
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickBoxItem))
	self.m_previewBtn:addClickListener(handler(self, self._onClickPreview))
end

function GuildDungeonBoxPop:_addNetWorkListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETTREASUREBOX, self._onRcvGetTreasureBox, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_GETINFO, handler(self, self._onRcvGetInfo), self)
end

function GuildDungeonBoxPop:_onRcvGetInfo()
	self:_switchTab(true)
end

function GuildDungeonBoxPop:_updateTreasureList(arg_10_1)
	self._curStageData = self._stageList[arg_10_1]
	self._stageTreaData = self._curStageData:getStageTreasure()
	self._isRec = self._curStageData:isRecTreasure()

	self.m_awardList:setNumItems(#self._stageTreaData)
end

function GuildDungeonBoxPop:_getGuildList(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if iter_11_1:getCfg().if_show == 1 then
			var_11_0[#var_11_0 + 1] = iter_11_1
		end
	end

	return var_11_0
end

function GuildDungeonBoxPop:_onRenderListTab(arg_12_1, arg_12_2)
	local var_12_0 = self._stageList[arg_12_1 + 1]:getCfg()

	arg_12_2:setTitle(var_12_0.dungeon_name_1)

	local var_12_1 = arg_12_2:getChild("redPointComp")

	var_12_1:setId(var_0_0.GuildDungeonConst.BOX_TAB_RED_POINT_ID)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		customData = {
			stageId = var_12_0.id
		},
		redPointComp = var_12_1
	})
end

function GuildDungeonBoxPop:_onRenderListAward(arg_13_1, arg_13_2)
	arg_13_2:updateCell({
		hasRec = self._isRec,
		index = arg_13_1 + 1,
		awardData = self._stageTreaData[arg_13_1 + 1],
		stageData = self._curStageData
	})
end

function GuildDungeonBoxPop:_switchTab(arg_14_1)
	if arg_14_1 then
		self._curIndex = 0

		for iter_14_0 = 1, #self._stageList do
			if math.uint64_lt(self._stageList[iter_14_0]:getStageCurHp(), 0, true) and not self._stageList[iter_14_0]:isRecTreasure() then
				self._curIndex = iter_14_0 - 1

				break
			end
		end

		self.m_tabList:setSelectedIndex(self._curIndex)
	end

	self:_updateTreasureList(self._curIndex + 1)
end

function GuildDungeonBoxPop:_onClickBoxItem(arg_15_1)
	self._curIndex = arg_15_1 and arg_15_1:getDataValue() or 0

	self:_switchTab()
end

function GuildDungeonBoxPop:_onClickPreview()
	self:addPopup(require("app.view.module.guildDungeon.view.GuildDungeonAwardPrevPop").new({
		stageList = self._stageList[self._curIndex + 1]
	}))
end

function GuildDungeonBoxPop:_onRcvGetTreasureBox(arg_17_1, arg_17_2, arg_17_3)
	g.core.module.ModuleManager:awardSummary(arg_17_3.awards or {})
	self.m_tabList:setNumItems(#self._stageList)
	self:_switchTab()
end

return GuildDungeonBoxPop
