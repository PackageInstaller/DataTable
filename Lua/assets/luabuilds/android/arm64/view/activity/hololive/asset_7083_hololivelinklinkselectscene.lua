local HoloLiveLinkLinkSelectScene = class("HoloLiveLinkLinkSelectScene", import("view.base.BaseUI"))

HoloLiveLinkLinkSelectScene.HOLOLIVE_LINKGAME_HUB_ID = 3
HoloLiveLinkLinkSelectScene.HOLOLIVE_LINKGAME_ID = 7

function HoloLiveLinkLinkSelectScene:getUIName()
	return "HoloLiveLinkGameSelectUI"
end

function HoloLiveLinkLinkSelectScene:init()
	self:initData()
	self:findUI()
	self:initUI()
	self:addListener()

	return
end

function HoloLiveLinkLinkSelectScene:didEnter()
	self:updateProgressBar()
	self:updateAwardPanel()
	self:updateEntranceList()

	return
end

function HoloLiveLinkLinkSelectScene:willExit()
	return
end

function HoloLiveLinkLinkSelectScene:initData()
	self.lightPointTFList = {}
	self.lightLineTFList = {}
	self.entranceTFList = {}

	self:updateData()

	return
end

function HoloLiveLinkLinkSelectScene:findUI()
	self.forNotchPanel = self._tf:Find("ForNotchPanel")
	self.backBtn = self.forNotchPanel:Find("BackBtn")
	self.helpBtn = self.forNotchPanel:Find("HelpBtn")
	self.awardMask = self.forNotchPanel:Find("AwardImg/Mask")
	self.progressText = self.forNotchPanel:Find("AwardImg/ProgressText")
	self.getAwardBtn = self.forNotchPanel:Find("AwardImg/GetBtn")
	self.gotAwardBtn = self.forNotchPanel:Find("AwardImg/GotBtn")
	self.progressPanel = self.forNotchPanel:Find("Progress")
	self.lightPointContainer = self.progressPanel:Find("Light")
	self.lightLineContainer = self.progressPanel:Find("LightLine")
	self.entranceContainer = self._tf:Find("EntranceContainer")

	return
end

function HoloLiveLinkLinkSelectScene:initUI()
	setActive(self.getAwardBtn, false)
	setActive(self.gotAwardBtn, false)
	eachChild(self.lightPointContainer, function(arg_8_0)
		table.insert(self.lightPointTFList, 1, arg_8_0)
		setActive(arg_8_0, false)
		setActive(arg_8_0:Find("Point"), false)

		return
	end)
	eachChild(self.lightLineContainer, function(arg_9_0)
		table.insert(self.lightLineTFList, 1, arg_9_0)
		setActive(arg_9_0, false)

		return
	end)

	for iter_7_0 = 0, 7 do
		local var_7_0 = self.entranceContainer:GetChild(iter_7_0)

		table.insert(self.entranceTFList, var_7_0)

		local var_7_1 = var_7_0:Find("GotImg")
		local var_7_2 = var_7_0:Find("LockText")

		setActive(var_7_0:Find("Mask"), true)
		setActive(var_7_1, false)
		setActive(var_7_2, true)
	end

	return
end

function HoloLiveLinkLinkSelectScene:addListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hololive_lianliankan.tip
		})

		return
	end, SFX_PANEL)

	for iter_10_0, iter_10_1 in ipairs(self.entranceTFList) do
		onButton(self, iter_10_1:Find("EntranceBtn"), function()
			self.linkGameData:SetRuntimeData("curLinkGameID", iter_10_0)
			pg.m02:sendNotification(GAME.GO_MINI_GAME, HoloLiveLinkLinkSelectScene.HOLOLIVE_LINKGAME_ID)

			return
		end, SFX_PANEL)
	end

	return
end

function HoloLiveLinkLinkSelectScene:updateProgressBar()
	local var_14_0 = math.min(self.linkGameHub.usedtime, 7)

	if var_14_0 > 0 then
		for iter_14_0 = 1, var_14_0 do
			setActive(self.lightPointTFList[iter_14_0], true)
		end

		setActive(self.lightPointTFList[var_14_0]:Find("Point"), true)
	end

	if var_14_0 > 1 then
		for iter_14_1 = 1, var_14_0 - 1 do
			setActive(self.lightLineTFList[iter_14_1], true)
		end
	end

	return
end

function HoloLiveLinkLinkSelectScene:updateAwardPanel()
	local var_15_0 = self.linkGameHub.usedtime

	setText(self.progressText, self.linkGameHub.usedtime > 7 and 7 or var_15_0)

	if self.linkGameHub.ultimate > 0 then
		setActive(self.getAwardBtn, false)
		setActive(self.gotAwardBtn, true)
		setActive(self.awardMask, true)
	elseif var_15_0 >= self.linkGameHub:getConfig("reward_need") then
		setActive(self.getAwardBtn, true)
		setActive(self.gotAwardBtn, false)
		setActive(self.awardMask, true)
		onButton(self, self.getAwardBtn, function()
			pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = self.linkGameHub.id,
				cmd = MiniGameOPCommand.CMD_ULTIMATE,
				args1 = {}
			})

			return
		end, SFX_PANEL)
	else
		setActive(self.getAwardBtn, false)
		setActive(self.gotAwardBtn, false)
		setActive(self.awardMask, false)
	end

	return
end

function HoloLiveLinkLinkSelectScene:updateEntranceList()
	for iter_17_0 = 1, 8 do
		local var_17_0 = self.entranceTFList[iter_17_0]:Find("Mask")
		local var_17_1 = self.entranceTFList[iter_17_0]:Find("GotImg")
		local var_17_2 = self.entranceTFList[iter_17_0]:Find("LockText")

		setText(var_17_2, self.linkGameData:GetConfigCsvLine(iter_17_0).unlock_txt)

		if iter_17_0 <= self.linkGameHub.usedtime then
			setActive(var_17_0, false)
			setActive(var_17_1, true)
			setActive(var_17_2, false)
		elseif iter_17_0 == self.linkGameHub.usedtime + 1 then
			if self.linkGameHub.count == 0 then
				setActive(var_17_0, true)
				setActive(var_17_1, false)
				setActive(var_17_2, true)
			elseif self.linkGameHub.count > 0 then
				setActive(var_17_0, false)
				setActive(var_17_1, false)
				setActive(var_17_2, false)
			end
		elseif iter_17_0 > self.linkGameHub.usedtime + 1 then
			setActive(var_17_0, true)
			setActive(var_17_1, false)
			setActive(var_17_2, true)
		end
	end

	return
end

function HoloLiveLinkLinkSelectScene:updateData()
	self.miniGameProxy = getProxy(MiniGameProxy)
	self.linkGameHub = self.miniGameProxy:GetHubByHubId(HoloLiveLinkLinkSelectScene.HOLOLIVE_LINKGAME_HUB_ID)
	self.linkGameData = self.miniGameProxy:GetMiniGameData(HoloLiveLinkLinkSelectScene.HOLOLIVE_LINKGAME_ID)

	return
end

function HoloLiveLinkLinkSelectScene:updateUI()
	self:updateProgressBar()
	self:updateAwardPanel()
	self:updateEntranceList()

	return
end

function HoloLiveLinkLinkSelectScene.isTip()
	local var_20_0 = getProxy(MiniGameProxy):GetHubByHubId(HoloLiveLinkLinkSelectScene.HOLOLIVE_LINKGAME_HUB_ID)

	if var_20_0.ultimate == 0 and var_20_0.usedtime >= 7 then
		return true
	elseif var_20_0.count > 0 then
		return true
	end

	return
end

return HoloLiveLinkLinkSelectScene
