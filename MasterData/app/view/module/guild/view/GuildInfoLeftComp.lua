local var_0_0 = g.core.model.User.guildData
local GuildInfoLeftComp = class("GuildInfoLeftComp", require("app.fairyGUI.guild.UI_GuildInfoLeftComp"))
local var_0_2 = {
	{
		icon = "ui://guild/icon_shezhi",
		tp = 1,
		title = g.core.lang:get(109562)
	},
	{
		icon = "ui://guild/icon_shenqing",
		tp = 2,
		redPointId = 275,
		title = g.core.lang:get(109563)
	},
	{
		icon = "ui://guild/icon_dongtai",
		tp = 3,
		title = g.core.lang:get(109564)
	},
	{
		icon = "ui://guild/icon_zhenghe",
		tp = 4,
		redPointId = 864,
		title = g.core.lang:get(109641)
	},
	{
		icon = "ui://guild/icon_tuichu",
		tp = 5,
		title = g.core.lang:get(109561)
	}
}

function GuildInfoLeftComp:ctor()
	self._guildData = {}
	self._baseData = {}
	self._functions = {
		handler(self, self._onSettingBtnClick),
		handler(self, self._onApplyBtnClick),
		handler(self, self._onDynamicClick),
		handler(self, self._onClickMergeList),
		(handler(self, self._onExitBtnClick))
	}
	self._listData = {}

	self:_init()
end

function GuildInfoLeftComp:onLoad()
	self.m_enterTransition:play()
end

function GuildInfoLeftComp:_init()
	self.m_changeAnnounceBtn:addClickListener(handler(self, self._onChangeAnnounceClick))
	self.m_changeDeclarationBtn:addClickListener(handler(self, self._onChangeDeclarationClick))
	self.m_announcementBg:addClickListener(handler(self, self._onChangeAnnounceClick))
	self.m_declarationBg:addClickListener(handler(self, self._onChangeDeclarationClick))
	self.m_opeartorBtnList:setVirtual()
	self.m_opeartorBtnList:setItemRenderer(handler(self, self._onOpeartorBtnRenderer))
	self.m_opeartorBtnList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onOpeartorClickItem))
	self.m_copyBtn:addClickListener(handler(self, self._onCopyClick))
	self.m_recruitImg:addClickListener(handler(self, self._onRecruitClick))
end

function GuildInfoLeftComp:_onSettingBtnClick()
	local var_4_0 = require("app.view.module.guild.view.GuildCreatePop").new({
		setting = true,
		curSingId = var_0_0:getGuildData().icon
	})

	if var_4_0 then
		var_4_0:setName("GuildSettingPop")
		g.core.module.ModuleManager:pushPopup(var_4_0)
	end
end

function GuildInfoLeftComp:_onExitBtnClick()
	if var_0_0:isLockUser() then
		g.core.module.ModuleManager:tip(g.core.lang:get(430012))

		return
	end

	if var_0_0:getMyRightInfo().dissolve > 0 then
		local var_5_0 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILD_DISMISS).parameter

		if var_5_0 <= var_0_0:getMemberNum() then
			g.core.module.ModuleManager:tip(g.core.lang:get(109568, {
				num = var_5_0
			}))

			return
		else
			local var_5_1 = 109571
			local var_5_2

			if g.core.model.User.allianceData:hasAlliance() then
				var_5_1 = 428608
				var_5_2 = require("app.view.base.pop.BaseConfirmPop").new
			end

			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(109550),
				desc = g.core.lang:get(var_5_1),
				onConfirm = function()
					local var_6_0, var_6_1 = g.core.model.User.guildData:getCanPlayerExitGuildOrAlliance()

					if not var_6_0 then
						g.core.module.ModuleManager:tip(var_6_1)

						return
					end

					g.core.network.GameNetProxy:send_C2S_Guild_Dismiss({})
				end
			}))
		end

		return
	end

	local var_5_3 = 109639
	local var_5_4

	if g.core.model.User.allianceData:hasAlliance() then
		var_5_3 = 428609
		var_5_4 = require("app.view.base.pop.BaseConfirmPop").new
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(109569),
		desc = g.core.lang:get(var_5_3, {
			hour = math.floor(var_0_0:getJoinCd() / 3600)
		}),
		onConfirm = function()
			local var_7_0, var_7_1 = g.core.model.User.guildData:getCanPlayerExitGuildOrAlliance()

			if not var_7_0 then
				g.core.module.ModuleManager:tip(var_7_1)

				return
			end

			g.core.network.GameNetProxy:send_C2S_Guild_Quit({})
			g.core.module.ModuleManager:tip(g.core.lang:get(109561))
		end
	}))
end

function GuildInfoLeftComp:_onClickMergeList()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.guild.view.merge.GuildMergeApplyPop").new(), {
		touchDisappear = true
	})
end

function GuildInfoLeftComp:_onDynamicClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.guild.view.GuildLogInfoPop").new(), {
		withoutAni = true
	})
end

function GuildInfoLeftComp:_onApplyBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.guild.view.GuildApplyListPop").new(), {
		withoutAni = true
	})
end

function GuildInfoLeftComp:updateView()
	self._guildData = var_0_0:getGuildData()
	self._baseData = var_0_0:getCfg()

	self.m_idTxt:disableAutoChange()
	self.m_idTxt:setText(g.core.lang:get(109588, {
		id = self._guildData.show_id
	}))
	self.m_nameTxt:setText(self._guildData.name)
	self.m_leaderNameTxt:setText(self._guildData.leader_name or "")
	self.m_levelTxt:setText(g.core.lang:get(109501, {
		level = self._guildData.level
	}))
	self.m_processTxt:setText(g.core.lang:get(109544, {
		num1 = self._guildData.exp,
		num2 = self._baseData.exp
	}))
	self.m_processComp:setMax(self._baseData.exp)
	self.m_processComp:setValue(self._guildData.exp)
	self.m_guildIcon:updateInfo({
		style = 4,
		data = self._guildData
	})

	if self._guildData.confirm then
		self.m_auditTxt:setText(g.core.lang:get(109504))
	else
		self.m_auditTxt:setText(g.core.lang:get(109505))
	end

	self.m_limitLevelTxt:setText(g.core.lang:get(109515, {
		level = self._guildData.apply_level
	}))
	self.m_memberSizeTxt:setText(g.core.lang:get(109544, {
		num1 = var_0_0:getMemberNum(),
		num2 = self._baseData.number
	}))

	local var_11_0 = self._guildData.announcement

	if not self._guildData.announcement or var_11_0 == "" then
		var_11_0 = g.core.lang:get(109635)
	end

	self.m_announcementTxt:setTitle(var_11_0, nil, true)

	local var_11_1 = self._guildData.declaration

	if not self._guildData.declaration or var_11_1 == "" then
		var_11_1 = g.core.lang:get(109636)
	end

	self.m_declarationTxt:setTitle(var_11_1, nil, true)

	self._listData = {}

	local var_11_2 = var_0_0:getMyRightInfo()

	if var_11_2.apply_set > 0 then
		table.insert(self._listData, var_0_2[1])
	end

	if var_11_2.apply_approve > 0 then
		table.insert(self._listData, var_0_2[2])
	end

	table.insert(self._listData, var_0_2[3])

	if var_0_0:isShowMerge() then
		table.insert(self._listData, var_0_2[4])
	end

	table.insert(self._listData, var_0_2[5])

	if #self._listData < 3 then
		self.m_rankController:setSelectedIndex(1)
	else
		self.m_rankController:setSelectedIndex(0)
	end

	self.m_opeartorBtnList:setNumItems(#self._listData)
end

function GuildInfoLeftComp:_onOpeartorBtnRenderer(arg_12_1, arg_12_2)
	if self._listData[arg_12_1 + 1].redPointId then
		local var_12_0 = arg_12_2:getChild("redPointComp")

		if var_12_0 then
			var_12_0:setId(self._listData[arg_12_1 + 1].redPointId)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = var_12_0
			})
		end
	end

	arg_12_2:setIcon(self._listData[arg_12_1 + 1].icon)
	arg_12_2:setTitle((self._listData[arg_12_1 + 1].tp == 5 and var_0_0:getMyRightInfo().dissolve > 0 or nil) and g.core.lang:get(109550))
end

function GuildInfoLeftComp:_onChangeAnnounceClick()
	if self.m_rankController:getSelectedIndex() ~= 0 then
		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.guild.view.GuildAnnouncementPop").new({
		type = 1
	})))
end

function GuildInfoLeftComp:_onChangeDeclarationClick()
	if self.m_rankController:getSelectedIndex() ~= 0 then
		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.guild.view.GuildAnnouncementPop").new({
		type = 2
	})))
end

function GuildInfoLeftComp:_onOpeartorClickItem(arg_15_1)
	local var_15_0 = arg_15_1:getDataValue()

	if self._listData[var_15_0 + 1] and self._listData[var_15_0 + 1].tp then
		if self._functions[self._listData[var_15_0 + 1].tp] then
			self._functions[self._listData[var_15_0 + 1].tp]()
		end
	end
end

function GuildInfoLeftComp:_onCopyClick()
	g.core.module.ModuleManager:tip(g.core.lang:get(109551))
	g.core.platform.PlatformProxy:copyToClipboard(tostring(self._guildData.show_id))
end

function GuildInfoLeftComp:_onRecruitClick()
	fgui.UIPackage:addPackage("ui/share/share")

	local var_17_0 = {
		title = g.core.lang:get(308501)
	}
	local var_17_1 = fgui.UIPackage:createObject("share", "ShareSendMsgComp")

	var_17_0.childComp = var_17_1
	var_17_0.funcId = g.core.const.ConstMgr.FUNCTION_TYPE.GUILD

	var_17_1:setTitle(g.core.lang:get(308511, {
		name = self._guildData.name
	}))

	local var_17_2 = require("app.view.base.infoPop.BaseChatCallPop").new(var_17_0)

	var_17_2:showBtnNumber(2)
	g.core.module.ModuleManager:pushPopup(var_17_2)
end

return GuildInfoLeftComp
