local var_0_0 = g.core.model.User.allianceData
local var_0_1 = g.core.config.guild_alliance_box_info
local AllianceSendBoxLayer = class("AllianceSendBoxLayer", require("app.fairyGUI.alliance.UI_AllianceSendBoxLayer"), function()
	return fgui.GComponent:create({
		resName = "AllianceSendBoxLayer",
		pkgName = "alliance",
		isFullScreen = true,
		pkgPath = "ui/alliance/alliance"
	}, ...)
end)

function AllianceSendBoxLayer:ctor()
	self._selectIndex = 0
	self._showBoxList = {}
	self._boxData = var_0_0:getBoxData()

	self:initView()
	self.m_enterTransition:play()
end

function AllianceSendBoxLayer:initView()
	self:addBg("bg/alliance/bg_ghlm_wuzixiang.jpg")
	self.m_topBar:setResInfoById(342)
	self.m_sendBtn:addClickListener(handler(self, self._onClickSendBtn))
	self.m_maxNumBtm:addClickListener(handler(self, self._onClickMaxNumBtm))
	self.m_sendList:setIniter()
	self.m_sendList:setItemRenderer(handler(self, self._onRenderSendList))
	self.m_sendList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self.onChangeSelectIndex))

	for iter_3_0, iter_3_1 in var_0_1.ipairs() do
		if iter_3_1.give_out_show == 1 then
			table.insert(self._showBoxList, iter_3_1)
		end
	end

	self.m_sendList:setNumItems(#self._showBoxList)
end

function AllianceSendBoxLayer:_onClickSendBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_box_put_small)

	if not var_0_0:canSendBoxInJoinAllianceTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428521))

		return
	end

	if not var_0_0:canSendBoxInDayTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428523))

		return
	end

	local var_4_0 = self._showBoxList[self._selectIndex + 1]
	local var_4_1 = self.m_sendNumSlider:getValue()

	if var_4_1 > 0 then
		g.core.network.GameNetProxy:send_C2S_GuildAlliance_SendBox({
			box_info_id = var_4_0.id,
			num = var_4_1
		})
	else
		local var_4_2 = require("app.view.base.pop.BaseConfirmPop").new

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(428531),
			desc = g.core.lang:get(428532),
			onConfirm = function()
				g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, {
					shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.RECHARGE
				})
			end
		}))
	end
end

function AllianceSendBoxLayer:_onClickMaxNumBtm()
	self.m_sendNumSlider:setValue(self.m_sendNumSlider:getMax())
end

function AllianceSendBoxLayer:_onRenderSendList(arg_7_1, arg_7_2)
	arg_7_2:updateSendBoxCell(self._showBoxList[arg_7_1 + 1])
end

function AllianceSendBoxLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_SENDBOX, handler(self, self._onSendBox), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, handler(self, self._onNoticeState), self)
	self.m_sendList:setSelectedIndex(self._selectIndex)
	self:updateView()
end

function AllianceSendBoxLayer:_onNoticeState()
	if not var_0_0:hasAlliance() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428567))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function AllianceSendBoxLayer:_onSendBox()
	self:updateView()
	g.core.module.ModuleManager:tip(g.core.lang:get(428525))
end

function AllianceSendBoxLayer:onChangeSelectIndex()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_box_switch)
	self:updateView()
end

function AllianceSendBoxLayer:updateView()
	self._selectIndex = self.m_sendList:getSelectedIndex()

	local var_12_0 = self._boxData:getSendBoxCount(self._showBoxList[self._selectIndex + 1].id)
	local var_12_1 = var_12_0 > 0
	local var_12_2 = var_12_0

	self.m_sendNumSlider:setMin(var_12_0 > 0 and 1 or 0)
	self.m_sendNumSlider:setMax(var_12_2)
	self.m_sendNumSlider:setValue(var_12_2)
	self.m_sendList:setNumItems(#self._showBoxList)
	self.m_hasBoxController:setSelectedIndex(var_12_1 and 1 or 0)
end

return AllianceSendBoxLayer
