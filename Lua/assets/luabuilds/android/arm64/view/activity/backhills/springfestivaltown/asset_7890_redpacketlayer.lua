local RedPacketLayer = class("RedPacketLayer", import("view.base.BaseUI"))

function RedPacketLayer:getUIName()
	if PLATFORM_CODE == PLATFORM_CHT then
		return "RedPacket2023UI"
	else
		return "RedPacket2023UI"
	end

	return
end

function RedPacketLayer:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function RedPacketLayer:didEnter()
	self:updateUI()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function RedPacketLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function RedPacketLayer:initData()
	self.activityProxy = getProxy(ActivityProxy)

	local var_5_0 = self.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKETS)

	self.activityID = var_5_0.id
	self.countToStory = {}

	local var_5_1 = var_5_0:getConfig("config_client").story

	if var_5_1 then
		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			self.countToStory[iter_5_1[1]] = iter_5_1[2]
		end
	end

	return
end

function RedPacketLayer:findUI()
	self.packetBtn = self._tf:Find("Container/PacketBtn")
	self.packetMask = self._tf:Find("Container/PacketBtnMask")
	self.helpBtn = self._tf:Find("Container/HelpBtn")
	self.tagTF = self.packetBtn:Find("tag")
	self.countTF = self._tf:Find("Container/Count")
	self.specialTF = self._tf:Find("Container/Count/Special")
	self.specialCountText = self.specialTF:Find("Text")
	self.normalTF = self._tf:Find("Container/Count/Normal")
	self.normalCountText = self.normalTF:Find("Text")
	self.awardBtnList = {}

	table.insert(self.awardBtnList, self._tf:Find("Container/Award"))
	table.insert(self.awardBtnList, self._tf:Find("Container/Award2"))

	self.countText = self._tf:Find("Container/CountText")
	self.backBtn = self._tf:Find("Top/BackBtn")

	return
end

function RedPacketLayer:addListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.packetBtn, function()
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = self.activityID
		})

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie_jiulou.tip
		})

		return
	end, SFX_PANEL)

	for iter_7_0, iter_7_1 in ipairs(self.awardBtnList) do
		if iter_7_1 then
			onButton(self, iter_7_1, function()
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function RedPacketLayer:updateUI()
	local var_12_0 = self.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKETS)
	local var_12_2 = var_12_0.data1
	local var_12_3 = math.min(var_12_0.data1, var_12_0.data2)
	local var_12_4 = var_12_0.data1 - var_12_3

	print(var_12_0.data1 - var_12_3, var_12_3, var_12_0.data1)
	setActive(self.tagTF, var_12_3 > 0)
	setActive(self.normalTF, var_12_4 > 0)
	setActive(self.specialTF, var_12_3 > 0)
	setActive(self.countTF, var_12_2 > 0)
	setText(self.normalCountText, var_12_4)
	setText(self.specialCountText, var_12_3)
	setActive(self.packetBtn, var_12_2 > 0)
	setActive(self.packetMask, not (var_12_2 > 0))
	setText(self.countText, var_12_0.data1_list[2] .. "/" .. var_12_0.data1_list[1])

	return
end

function RedPacketLayer:tryPlayStory()
	local var_13_0 = self.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKETS)
	local var_13_1 = var_13_0.data1 - math.min(var_13_0.data1, var_13_0.data2)

	if self.countToStory[var_13_0.data3 - var_13_0.data2] then
		pg.NewStoryMgr.GetInstance():Play(self.countToStory[var_13_0.data3 - var_13_0.data2])
	end

	return
end

function RedPacketLayer:onSubmitFinished()
	self:updateUI()
	self:tryPlayStory()

	return
end

function RedPacketLayer.isShowRedPoint()
	return getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKETS).data1 > 0
end

return RedPacketLayer
