local BeachPacketLayer = class("BeachPacketLayer", import("view.base.BaseUI"))

function BeachPacketLayer:getUIName()
	return "BeachPacketUI"
end

function BeachPacketLayer:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function BeachPacketLayer:didEnter()
	self:updateUI()

	return
end

function BeachPacketLayer:willExit()
	return
end

function BeachPacketLayer:initData()
	self.activityProxy = getProxy(ActivityProxy)

	local var_5_0 = self.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKET_LOTTER)

	self.activityID = var_5_0.id
	self.awardList = {}
	self.awardListMap = {}

	local var_5_1 = var_5_0:getConfig("config_client")

	if var_5_1 then
		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			self.awardListMap[iter_5_1[4]] = self.awardListMap[iter_5_1[4]] or {}

			local var_5_2 = {
				id = iter_5_1[2][2],
				type = iter_5_1[2][1],
				count = iter_5_1[3],
				awardID = iter_5_1[1]
			}

			table.insert(self.awardListMap[iter_5_1[4]], var_5_2)

			self.awardList[iter_5_1[1]] = var_5_2
		end
	end

	self:updateActData()

	return
end

function BeachPacketLayer:findUI()
	local var_6_0 = self._tf:Find("Adapt")

	self.backBtn = var_6_0:Find("BackBtn")
	self.homeBtn = var_6_0:Find("HomeBtn")
	self.helpBtn = var_6_0:Find("HelpBtn")

	local var_6_1 = self._tf:Find("PacketPanel")

	self.countText = var_6_1:Find("Count/CountText")
	self.packetTFList = {}

	local var_6_2 = var_6_1:Find("ContainerBehide")

	for iter_6_0 = 1, 5 do
		table.insert(self.packetTFList, (var_6_2:GetChild(iter_6_0 - 1)))
	end

	local var_6_3 = var_6_1:Find("ContainerFront")

	for iter_6_1 = 1, 5 do
		table.insert(self.packetTFList, (var_6_3:GetChild(iter_6_1 - 1)))
	end

	local var_6_4 = self._tf:Find("AwardPanel")

	self.awardTpl = var_6_4:Find("AwardTpl")
	self.iconTpl = self.awardTpl:Find("Icon/IconTpl")
	self.awardTFList = {}

	local function var_6_5(arg_7_0, arg_7_1, arg_7_2)
		for iter_7_0, iter_7_1 in ipairs((self:getAwardListByLevel(arg_7_0))) do
			self.awardTFList[iter_7_1.awardID] = cloneTplTo(arg_7_1, arg_7_2)
		end

		return
	end

	var_6_5(1, self.awardTpl, var_6_4:Find("Container_1"))
	var_6_5(2, self.awardTpl, var_6_4:Find("Container_2"))
	var_6_5(3, self.awardTpl, var_6_4:Find("Container_3"))
	var_6_5(4, self.awardTpl, var_6_4:Find("Container_4"))

	self.aniPanel = self._tf:Find("AniPanel")
	self.aniTF = self.aniPanel:Find("Ani")
	self.aniSC = GetComponent(self.aniTF, "SpineAnimUI")

	return
end

function BeachPacketLayer:addListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.homeBtn, function()
		self:emit(BeachPacketLayer.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.tips_yuandanhuoyue2023.tip
		})

		return
	end, SFX_PANEL)

	return
end

function BeachPacketLayer:updateActData()
	local var_12_0 = self.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKET_LOTTER)
	local var_12_1 = pg.TimeMgr.GetInstance()

	self.curCount = math.min(10, var_12_1:DiffDay(var_12_0.data2, (var_12_1:GetServerTime())) + 1) - var_12_0.data1
	self.gotIndexList = {}

	for iter_12_0, iter_12_1 in pairs(var_12_0.data2_list) do
		if not table.contains(self.gotIndexList, iter_12_1) then
			table.insert(self.gotIndexList, iter_12_1)
		end
	end

	self.gotIDList = {}

	for iter_12_2, iter_12_3 in pairs(var_12_0.data1_list) do
		if not table.contains(self.gotIDList, iter_12_3) then
			table.insert(self.gotIDList, iter_12_3)
		end
	end

	return
end

function BeachPacketLayer:updatePacketTpl(arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2:Find("Selected")
	local var_13_1 = self:isPacketIndexGot(arg_13_1)

	setActive(arg_13_2:Find("Got"), var_13_1)
	setActive(arg_13_2:Find("Normal"), not var_13_1)
	onButton(self, arg_13_2, function()
		if not var_13_1 and self.curCount > 0 then
			pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = self.activityID,
				arg1 = arg_13_1
			})
		end

		return
	end, SFX_PANEL)

	return
end

function BeachPacketLayer:updatePacketList()
	for iter_15_0, iter_15_1 in ipairs(self.packetTFList) do
		self:updatePacketTpl(iter_15_0, iter_15_1)
	end

	return
end

function BeachPacketLayer:updateAwardTpl(arg_16_1, arg_16_2)
	local var_16_0 = self.awardList[arg_16_1]

	updateDrop(self._tf:Find("Icon/IconTpl(Clone)", arg_16_2), self.awardList[arg_16_1])

	local var_16_1 = self:isAwardGot(arg_16_1)

	setActive(arg_16_2:Find("Got"), var_16_1)
	onButton(self, arg_16_2, function()
		if not var_16_1 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_SINGLE_ITEM,
				drop = var_16_0
			})
		end

		return
	end, SFX_PANEL)

	return
end

function BeachPacketLayer:updateAwardList()
	for iter_18_0, iter_18_1 in ipairs(self.awardTFList) do
		self:updateAwardTpl(iter_18_0, iter_18_1)
	end

	return
end

function BeachPacketLayer:updateUI()
	self:updatePacketList()
	self:updateAwardList()
	setText(self.countText, self.curCount)

	return
end

function BeachPacketLayer:playAni(arg_20_1)
	self.isPlaying = true

	setActive(self.aniPanel, true)
	self.aniSC:SetActionCallBack(nil)

	local var_20_0 = 0

	self.aniSC:SetActionCallBack(function(arg_21_0)
		if arg_21_0 == "action" then
			var_20_0 = var_20_0 + 1

			if var_20_0 == 2 then
				self.aniSC:SetActionCallBack(nil)
				setActive(self.aniPanel, false)

				self.isPlaying = false

				if arg_20_1 then
					arg_20_1()
				end

				var_20_0 = 0
			end
		end

		return
	end)
	self.aniSC:SetAction("4", 0)

	return
end

function BeachPacketLayer:isPacketIndexGot(arg_22_1)
	return table.contains(self.gotIndexList, arg_22_1)
end

function BeachPacketLayer:isAwardGot(arg_23_1)
	return table.contains(self.gotIDList, arg_23_1)
end

function BeachPacketLayer:getAwardCountByLevel(arg_24_1)
	return #self:getAwardListByLevel(arg_24_1)
end

function BeachPacketLayer:getAwardListByLevel(arg_25_1)
	return self.awardListMap[arg_25_1]
end

function BeachPacketLayer:onSubmitFinished()
	self:updateActData()
	self:updateUI()

	return
end

function BeachPacketLayer.isShowRedPoint()
	local var_27_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKET_LOTTER)
	local var_27_1 = pg.TimeMgr.GetInstance()
	local var_27_2 = var_27_1:GetServerTime()
	local var_27_3 = var_27_1:DiffDay(var_27_0.data2, var_27_2) + 1

	return math.min(10, var_27_1:DiffDay(var_27_0.data2, var_27_2) + 1) - var_27_0.data1 > 0
end

return BeachPacketLayer
