local var_0_0 = g.core.const.ConstMgr.AnniversaryConst
local var_0_1 = g.core.model.User.anniversaryData
local AnniversaryFloorLayer = class("AnniversaryFloorLayer", require("app.fairyGUI.anniversary.UI_AnniversaryFloorLayer"), function()
	return fgui.GComponent:create({
		resName = "AnniversaryFloorLayer",
		pkgName = "anniversary",
		isFullScreen = true,
		pkgPath = "ui/anniversary/anniversary"
	}, ...)
end)

function AnniversaryFloorLayer:ctor(arg_2_1)
	self._floorAwardList = {}

	self:_initBtn()
	self:_initListView()
	self:_initView()
end

function AnniversaryFloorLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETFLOORAWARD, handler(self, self._onRecvFloorAward), self)
	self:_updateView(true)
	self.m_enterTransition:play()
end

function AnniversaryFloorLayer:_initBtn()
	self.m_upFloorBtn:addClickListener(handler(self, self._onUpFloorBtnClick))
	self.m_downFloorBtn:addClickListener(handler(self, self._onDownFloorBtnClick))
end

function AnniversaryFloorLayer:_initListView()
	self.m_floorAwardList:setVirtual()
	self.m_floorAwardList:doFairyBatching(false)
	self.m_floorAwardList:setItemRenderer(handler(self, self._onRenderFloorAwardList))
end

function AnniversaryFloorLayer:_onRenderFloorAwardList(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._floorAwardList[arg_6_1 + 1], arg_6_1 + 1)
end

function AnniversaryFloorLayer:_initView(arg_7_1)
	self.m_bgLoader:setURL(var_0_1:getActivityResource("bg", "bg_xmhy_3.jpg"))
	self.m_upFloorBtn:setIcon(var_0_1:getActivityResource("ui_cocos", "pic_xmhy_jiantou.png"))
	self.m_downFloorBtn:setIcon(var_0_1:getActivityResource("ui_cocos", "pic_xmhy_jiantou.png"))
	self.m_curLoader:setURL(var_0_1:getActivityResource("ui_cocos", "pic_xmhy_zhaungshi.png"))
	self.m_curDescTxt:setColor(var_0_0.hexToRgb(var_0_1:getAnniversaryInfo().theater_current_session_color))
	self.m_curFloorText:setColor(var_0_0.hexToRgb(var_0_1:getAnniversaryInfo().current_session_number_color))
	self.m_bgEffLoader:addEffectSpine({
		anim = "play",
		isLoop = true,
		name = (var_0_1:getActivityId() > 1 or nil) and "eff_ui_anniversaryFloor_bgglow" .. var_0_1:getAnniversaryInfo().file_type
	})

	local var_7_1 = var_0_1:getAnniversaryInfo()

	self.m_topBarComp:setResInfoById(var_7_1.interface_main)
	self.m_topBarComp:setTitle(var_7_1.floor_name)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_StarNight_02)
end

function AnniversaryFloorLayer:_updateView(arg_8_1, arg_8_2)
	local var_8_0 = var_0_1:getCurFloor()

	if arg_8_2 and self._curFloor then
		var_8_0 = self._curFloor + arg_8_2
	end

	local var_8_1 = var_0_1:getMaxFloor()
	local var_8_2 = math.max(1, math.min(var_8_0, var_8_1))

	if self._curFloor and self._curFloor ~= var_8_2 then
		arg_8_1 = true
	end

	self._curFloor = var_8_2

	if var_8_2 < 10 then
		var_8_2 = "0" .. var_8_2
	end

	self.m_curFloorText:setText(g.core.lang:get(431601, {
		floor = var_8_2
	}))
	self.m_upFloorBtn:setVisible(var_8_1 > self._curFloor)
	self.m_downFloorBtn:setVisible(self._curFloor > 1)

	self._floorAwardList = var_0_1:getCurFloorAwardList(self._curFloor)

	self.m_floorAwardList:setNumItems(#self._floorAwardList)

	if arg_8_1 then
		self.m_floorAwardList:transitionShowCells("enter_left", 0.03)
	end
end

function AnniversaryFloorLayer:_onRecvFloorAward(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	g.core.module.ModuleManager:awardSummary(arg_9_4.awards, nil, nil, nil, handler(self, self._updateView))
end

function AnniversaryFloorLayer:_onUpFloorBtnClick()
	if self._curFloor and var_0_1:getCurFloor() <= self._curFloor then
		g.core.module.ModuleManager:tip(g.core.lang:get(431610))

		return
	end

	self:_updateView(false, 1)
end

function AnniversaryFloorLayer:_onDownFloorBtnClick()
	self:_updateView(false, -1)
end

return AnniversaryFloorLayer
