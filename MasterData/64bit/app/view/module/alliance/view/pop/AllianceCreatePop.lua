local var_0_0 = g.core.model.User.guildData
local var_0_1 = g.core.const.ConstMgr.AllianceConst
local var_0_2 = g.core.model.User.allianceData
local var_0_3 = g.core.common.GlobalFunc
local var_0_4 = g.core.config.guild_alliance_icon_info
local var_0_5 = g.core.config.guild_alliance_info
local var_0_6 = g.core.common.Path
local var_0_7 = g.core.config.guild_info
local AllianceCreatePop = class("AllianceCreatePop", require("app.fairyGUI.alliance.UI_AllianceCreatePop"), function()
	return fgui.GComponent:create({
		pkgName = "alliance",
		resName = "AllianceCreatePop",
		pkgPath = "ui/alliance/alliance"
	}, ...)
end)

function AllianceCreatePop:ctor()
	self._needCheck = false
	self._flagList = {}

	self:initView()
end

function AllianceCreatePop:initView()
	self:showAtCenter()
	self.m_noCheck:setSelected(not self._needCheck)
	self.m_needCheck:setSelected(self._needCheck)
	self.m_noCheck:addClickListener(handler(self, self._onClickNoCheck))
	self.m_needCheck:addClickListener(handler(self, self._onClickNeedCheck))
	self.m_createBtn:addClickListener(handler(self, self._onClickCreateBtn))
	self.m_chooseLevelComp:setMaxNum((var_0_7.getLength()))
	self.m_chooseLevelComp:setCurNum(1)
	self.m_fragList:setVirtual()
	self.m_fragList:setItemRenderer(handler(self, self._onRenderFragList))

	local var_3_0 = var_0_4.getLength()

	self.m_fragList:setNumItems(var_3_0)
	self.m_fragList:setSelectedIndex(math.random(0, var_3_0 - 1))

	local var_3_1

	for iter_3_0, iter_3_1 in var_0_5.ipairs() do
		if iter_3_1.level == 1 then
			var_3_1 = iter_3_1

			break
		end
	end

	self.m_resComp:updateByTVS({
		type = var_3_1.cost_type,
		value = var_3_1.cost_value,
		size = var_3_1.cost_size
	})

	local var_3_2 = var_0_2:getParams(var_0_1.PARAMETER.CREATE_MIN_LEVEL)

	self.m_levelCond:setText(g.core.lang:get(428529, {
		level = var_3_2
	}))
	self.m_isLevelEnoughController:setSelectedIndex(var_3_2 <= g.core.model.User.guildData:getGuildLevel() and 1 or 0)
end

function AllianceCreatePop:_onRenderFragList(arg_4_1, arg_4_2)
	arg_4_2:setIcon(var_0_6:getAllianceFlag128(var_0_4.indexOf(arg_4_1 + 1).res))
end

function AllianceCreatePop:_onClickNoCheck()
	self.m_noCheck:setSelected(true)
	self.m_needCheck:setSelected(false)

	self._needCheck = false
end

function AllianceCreatePop:_onClickNeedCheck()
	self.m_noCheck:setSelected(false)
	self.m_needCheck:setSelected(true)

	self._needCheck = true
end

function AllianceCreatePop:_onClickCreateBtn()
	local var_7_0 = var_0_2:getParams(var_0_1.PARAMETER.CREATE_MIN_LEVEL)

	if var_7_0 > var_0_0:getGuildLevel() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428517, {
			num = var_7_0
		}))

		return
	end

	if self.m_resComp:isLack() then
		self.m_resComp:popGotoSource()

		return
	end

	local var_7_1 = self.m_inputText:getText()
	local var_7_2

	if not var_0_3.isGuildNameValid(var_7_1, true, true) then
		do return end

		var_7_2 = {
			name = var_7_1,
			confirm = self._needCheck
		}
	end

	var_7_2.apply_level = self.m_chooseLevelComp:getCurNum()
	var_7_2.flag = var_0_4.indexOf(self.m_fragList:getSelectedIndex() + 1).id

	g.core.network.GameNetProxy:send_C2S_GuildAlliance_Create(var_7_2)
end

function AllianceCreatePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_CREATE, handler(self, self._onCreateAlliance), self)
end

function AllianceCreatePop:_onCreateAlliance()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return AllianceCreatePop
