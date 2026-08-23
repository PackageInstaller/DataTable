local var_0_0 = g.core.const.ConstMgr.SpineConst
local var_0_1 = g.core.model.User.allianceData
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.config.guild_alliance_box_info
local AllianceOpenBoxLayer = class("AllianceOpenBoxLayer", require("app.fairyGUI.alliance.UI_AllianceOpenBoxLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/alliance/alliance",
		resName = "AllianceOpenBoxLayer",
		pkgName = "alliance",
		isFullScreen = true
	}, ...)
end)

function AllianceOpenBoxLayer:ctor()
	self._soundDict = {
		"UI_Event_box_white",
		"UI_Event_box_green",
		"UI_Event_box_blue",
		"UI_Event_box_purple",
		"UI_Event_box_orange"
	}
	self._showAwards = {}
	self._boxData = var_0_1:getBoxData()
	self._selectIndex = 0

	self:initView()
	self.m_enterTransition:play()
end

function AllianceOpenBoxLayer:initView()
	self:addBg("bg/alliance/bg_ghlm_wuzixiangkaiqi.jpg")
	self.m_topBar:setResInfoById(343)
	self.m_openBtn:addClickListener(handler(self, self._onClickOpenBtn))
	self.m_boxList:setIniter()
	self.m_boxList:setItemRenderer(handler(self, self._onRenderBoxList))

	local var_3_0 = var_0_3.getLength()

	self.m_boxList:setNumItems(var_3_0)
	self.m_boxList:setScrollEnabled(var_3_0 > 5)
	self.m_boxList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self.updateView))
end

function AllianceOpenBoxLayer:_onClickOpenBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_box_open_big)

	local var_4_0 = var_0_3.indexOf(self._selectIndex + 1)
	local var_4_1 = math.min(self._boxData:getOpenBoxCount(var_4_0.id), var_4_0.one_time_num)

	if var_4_1 > 0 then
		g.core.network.GameNetProxy:send_C2S_GuildAlliance_BoxOpen({
			box_info_id = var_4_0.id,
			num = var_4_1
		})
	end
end

function AllianceOpenBoxLayer:_onRenderBoxList(arg_5_1, arg_5_2)
	arg_5_2:updateBoxCell((var_0_3.indexOf(arg_5_1 + 1)))
end

function AllianceOpenBoxLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_BOXOPEN, handler(self, self._onBoxOpen), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_EXCHANGEBOXAWARD, handler(self, self._onBoxExchangeOpen), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, handler(self, self._onNoticeState), self)

	local var_6_0 = self._selectIndex

	for iter_6_0, iter_6_1 in var_0_3.ipairs() do
		if self._boxData:getOpenBoxCount(iter_6_1.id) > 0 then
			var_6_0 = iter_6_0 - 1

			break
		end
	end

	self.m_boxList:setSelectedIndex(var_6_0)
	self:updateView()
end

function AllianceOpenBoxLayer:updateView()
	self._selectIndex = self.m_boxList:getSelectedIndex()

	local var_7_0 = var_0_3.indexOf(self._selectIndex + 1)
	local var_7_1 = self._boxData:getOpenBoxCount(var_7_0.id)

	if var_7_1 > 0 then
		local var_7_2 = math.min(var_7_1, var_7_0.one_time_num)

		self.m_openBtn:setTitle(g.core.lang:get(428512, {
			num = var_7_2
		}))
		self.m_hasBoxController:setSelectedIndex(1)

		if var_7_2 > 10 then
			self.m_showBoxComp:getChild("moreIcon"):setURL(var_0_2:getAllianceBigNumBox(var_7_0.box_pic))
			self.m_boxNumController:setSelectedIndex(7)
		elseif var_7_2 > 5 then
			self.m_showBoxComp:getChild("moreIcon"):setURL(var_0_2:getAllianceMinNumBox(var_7_0.box_pic))
			self.m_boxNumController:setSelectedIndex(6)
		else
			self.m_boxNumController:setSelectedIndex(var_7_2)

			for iter_7_0 = 1, var_7_2 do
				local var_7_3 = self.m_showBoxComp:getChild("boxIcon" .. iter_7_0)

				if var_7_3 then
					var_7_3:setURL(var_0_2:getAllianceBox400(var_7_0.box_pic))
				else
					break
				end
			end
		end
	else
		self.m_boxNumController:setSelectedIndex(0)

		if var_7_0.id == 5 then
			self.m_openBtn:setTitle(g.core.lang:get(428533))
			self.m_hasBoxController:setSelectedIndex(2)
		else
			self.m_openBtn:setTitle(g.core.lang:get(428526))
			self.m_hasBoxController:setSelectedIndex(0)
		end
	end

	self.m_boxOpenDesc:setText(var_7_0.box_des)
	self.m_scoreComp:updateView()
	self.m_boxList:setNumItems(var_0_3.getLength())
end

function AllianceOpenBoxLayer:_onNoticeState()
	if not var_0_1:hasAlliance() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428567))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function AllianceOpenBoxLayer:_onBoxExchangeOpen(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self.m_scoreComp:showFullUpEff()
	self:updateView()
end

function AllianceOpenBoxLayer:_onBoxOpen(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self.m_isShowEffectController:setSelectedIndex(1)
	self.m_boxEff:addEffectSpine({
		remove = true,
		isLoop = false,
		anim = "play",
		name = "eff_ui_alliance_box_" .. arg_10_4.box_info_id,
		eventHandler = handler(self, self._boxEffectEnd)
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound[self._soundDict[arg_10_4.box_info_id]])

	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_4.awards or {}) do
		var_10_0[iter_10_1.type .. "_" .. iter_10_1.value] = not var_10_0[iter_10_1.type .. "_" .. iter_10_1.value] and iter_10_1.size or var_10_0[iter_10_1.type .. "_" .. iter_10_1.value] + iter_10_1.size
	end

	local var_10_1 = {}

	for iter_10_2, iter_10_3 in pairs(var_10_0) do
		local var_10_2 = string.split(iter_10_2, "_")

		table.insert(var_10_1, {
			type = tonumber(var_10_2[1]),
			value = tonumber(var_10_2[2]),
			size = iter_10_3
		})
	end

	self._showAwards = var_10_1
end

function AllianceOpenBoxLayer:_boxEffectEnd(arg_11_1)
	if arg_11_1.type == var_0_0.SPINE_EVENT.COMPLETE then
		self.m_isShowEffectController:setSelectedIndex(0)

		if #self._showAwards > 0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
				showNow = true,
				award = {
					awards = self._showAwards
				}
			})
		end

		self:updateView()
	end
end

return AllianceOpenBoxLayer
