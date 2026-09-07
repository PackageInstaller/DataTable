local SpringFestival2026RedPacketPage = class("SpringFestival2026RedPacketPage", import("view.activity.CorePage.CoreActivityPage"))

function SpringFestival2026RedPacketPage:OnInit()
	self:findUI()

	return
end

function SpringFestival2026RedPacketPage:OnUpdateFlush()
	self:updateUI()

	return
end

function SpringFestival2026RedPacketPage:OnDataSetting()
	self.activityProxy = getProxy(ActivityProxy)
	self.activityID = self.activity.id
	self.countToStory = {}

	local var_3_0 = self.activity:getConfig("config_client").story

	if var_3_0 then
		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			self.countToStory[iter_3_1[1]] = iter_3_1[2]
		end
	end

	return
end

function SpringFestival2026RedPacketPage:findUI()
	self.packetBtn = self._tf:Find("BG/Container/PacketBtn")
	self.packetMask = self._tf:Find("BG/Container/PacketBtnMask")
	self.helpBtn = self._tf:Find("BG/Container/HelpBtn")
	self.tagTF = self.packetBtn:Find("tag")
	self.countTF = self._tf:Find("BG/Container/Count")
	self.specialTF = self._tf:Find("BG/Container/Count/Special")
	self.specialCountText = self.specialTF:Find("Text")
	self.normalTF = self._tf:Find("BG/Container/Count/Normal")
	self.normalCountText = self.normalTF:Find("Text")
	self.awardBtnList = {}

	table.insert(self.awardBtnList, self._tf:Find("BG/Container/Award"))
	table.insert(self.awardBtnList, self._tf:Find("BG/Container/Award2"))

	self.countText = self._tf:Find("BG/Container/CountText")

	return
end

function SpringFestival2026RedPacketPage:OnFirstFlush()
	onButton(self, self.packetBtn, function()
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie_jiulou_2026.tip
		})

		return
	end, SFX_PANEL)

	for iter_5_0, iter_5_1 in ipairs(self.awardBtnList) do
		if iter_5_1 then
			onButton(self, iter_5_1, function()
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function SpringFestival2026RedPacketPage:updateUI()
	local var_9_1 = self.activity.data1
	local var_9_2 = math.min(self.activity.data1, self.activity.data2)
	local var_9_3 = self.activity.data1 - var_9_2

	setActive(self.tagTF, var_9_2 > 0)
	setActive(self.normalTF, var_9_3 > 0)
	setActive(self.specialTF, var_9_2 > 0)
	setActive(self.countTF, var_9_1 > 0)
	setText(self.normalCountText, var_9_3)
	setText(self.specialCountText, var_9_2)
	setActive(self.packetBtn, var_9_1 > 0)
	setActive(self.packetMask, not (var_9_1 > 0))
	setText(self.countText, self.activity.data1_list[2] .. "/" .. self.activity.data1_list[1])

	return
end

function SpringFestival2026RedPacketPage:tryPlayStory()
	local var_10_0 = self.activity.data1 - math.min(self.activity.data1, self.activity.data2)

	if self.countToStory[self.activity.data3 - self.activity.data2] then
		pg.NewStoryMgr.GetInstance():Play(self.countToStory[self.activity.data3 - self.activity.data2])
	end

	return
end

function SpringFestival2026RedPacketPage:OnUpdateFlush()
	self:updateUI()
	self:tryPlayStory()

	return
end

return SpringFestival2026RedPacketPage
