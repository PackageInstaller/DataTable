local Dorm3dInsPhoneLayer = class("Dorm3dInsPhoneLayer", import("...base.BaseUI"))

function Dorm3dInsPhoneLayer:getUIName()
	return "Dorm3dInsPhoneUI"
end

function Dorm3dInsPhoneLayer:init()
	self.bg = self._tf:Find("bg")
	self.btnBack = self.bg:Find("top/back")
	self.voiceListContainer = self.bg:Find("main/voice/scroll/mask/list")
	self.voiceItemList = UIItemList.New(self.voiceListContainer, self.voiceListContainer:Find("tpl"))

	self.voiceItemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			self:UpdateVoiceItem(arg_3_1, arg_3_2)
		end

		return
	end)

	local var_2_0 = getProxy(Dorm3dInsProxy):GetPhoneListByGroup(self.contextData.groupId)

	var_2_0 = var_2_0 or {}
	self.data = var_2_0
	self.player = VoiceChatLoader.New(self._tf)

	self:OverlayPanel(self._tf)

	return
end

function Dorm3dInsPhoneLayer:didEnter()
	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end)
	setText(self.voiceListContainer:Find("tpl/bg/uncheck/Text"), i18n("dorm3d_privatechat_telephone_noviewed"))
	setText(self.bg:Find("top/title"), i18n("dorm3d_privatechat_telephone_calllog"))
	setText(self.bg:Find("main/voice/title/Text"), i18n("dorm3d_privatechat_telephone_call"))
	self:Flush()

	return
end

function Dorm3dInsPhoneLayer:Flush()
	self.voiceItemList:align(#self.data)

	return
end

function Dorm3dInsPhoneLayer:UpdateVoiceItem(arg_7_1, arg_7_2)
	local var_7_0 = self.data[arg_7_1 + 1]
	local var_7_1 = self.data[arg_7_1 + 1]:IsLock()

	setText(arg_7_2:Find("bg/name"), self.data[arg_7_1 + 1]:GetName())
	setActive(arg_7_2:Find("bg/day"), not var_7_1)
	setActive(arg_7_2:Find("bg/lock"), var_7_1)
	setActive(arg_7_2:Find("bg/uncheck"), self.data[arg_7_1 + 1]:ShouldTip())

	if var_7_1 then
		setText(arg_7_2:Find("bg/lock/info"), self.data[arg_7_1 + 1]:GetDesc())
	else
		setText(arg_7_2:Find("bg/day"), self.data[arg_7_1 + 1]:GetDay())
	end

	onButton(self, arg_7_2, function()
		if var_7_1 then
			return
		end

		if var_7_0:GetType() == 1 then
			self:emit(Dorm3dInsPhoneMediator.ON_DORM, var_7_0:GetVideoData())
		elseif var_7_0:GetType() == 2 then
			self.player:ExecuteAction("Play", var_7_0:GetContent())
		end

		if var_7_0:ShouldTip() then
			self:emit(Dorm3dInsPhoneMediator.MARK_READ, {
				groupId = self.contextData.groupId,
				id = var_7_0.id
			})
		end

		pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataPhone(self.contextData.groupId, var_7_0:GetType(), var_7_0.id))

		return
	end)

	return
end

function Dorm3dInsPhoneLayer:willExit()
	self.player:Destroy()

	return
end

return Dorm3dInsPhoneLayer
