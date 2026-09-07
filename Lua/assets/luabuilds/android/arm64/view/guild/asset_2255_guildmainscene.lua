local GuildMainScene = class("GuildMainScene", import("..base.BaseUI"))

function GuildMainScene:forceGC()
	return true
end

function GuildMainScene:getUIName()
	return "GuildMainUI"
end

function GuildMainScene:getGroupName()
	return "group_GuildMainUI"
end

function GuildMainScene:setGuildVO(arg_4_1)
	self.guildVO = arg_4_1

	if self.guildRes and self.guildRes:GetLoaded() then
		self.guildRes:Update(self.playerVO, arg_4_1)
	end

	if self.themePage and self.themePage:GetLoaded() then
		self.themePage:UpdateGuild(self.guildVO)
	end

	return
end

function GuildMainScene:setPlayerVO(arg_5_1)
	self.playerVO = arg_5_1

	return
end

function GuildMainScene:setChatMsgs(arg_6_1)
	self.chatMsgs = arg_6_1

	return
end

function GuildMainScene:setActivity(arg_7_1)
	self.activity = arg_7_1

	return
end

function GuildMainScene:setGuildEvent(arg_8_1)
	self.guildEvent = arg_8_1

	return
end

function GuildMainScene:UpdateRes()
	if self.guildRes and self.guildRes:GetLoaded() then
		self.guildRes:Update(self.playerVO, self.guildVO)
	end

	return
end

function GuildMainScene:OnReportUpdated()
	if self.themePage and self.themePage:GetLoaded() then
		self.themePage:RefreshReportBtn()
	end

	return
end

local var_0_1 = "main"
local var_0_2 = "member"
local var_0_3 = "apply"
local var_0_4 = "office"
local var_0_5 = "technology"
local var_0_6 = "battle"
local var_0_7 = {}

var_0_7[1] = "main"
var_0_7[2] = "member"
var_0_7[3] = "apply"
var_0_7[4] = "office"
var_0_7[5] = "technology"
var_0_7[6] = "battle"
GuildMainScene.TOGGLE_TAG = var_0_7
GuildMainScene.NOTIFY_TYPE_ALL = 0
GuildMainScene.NOTIFY_TYPE_MAIN = 1
GuildMainScene.NOTIFY_TYPE_APPLY = 2
GuildMainScene.NOTIFY_TYPE_OFFICE = 3
GuildMainScene.NOTIFY_TYPE_BATTLE = 4
GuildMainScene.NOTIFY_TYPE_TECH = 5

function GuildMainScene:init()
	self._bg = self._tf:Find("bg")

	pg.GuildPaintingMgr.GetInstance():Enter(self._bg:Find("painting"))

	self._playerResOb = self._tf:Find("blur_panel/adapt/top/res")
	self.guildRes = GuildResPage.New(self._playerResOb, self.event)
	self.toggleRoot = self._tf:Find("blur_panel/adapt/left_length/frame/scroll_rect/tagRoot")
	self.mainTip = self.toggleRoot:Find("main/tip")
	self.applyTip = self.toggleRoot:Find("apply/tip")
	self.officeTip = self.toggleRoot:Find("office/tip")
	self.techTip = self.toggleRoot:Find("technology/tip")
	self.battleTip = self.toggleRoot:Find("battle/tip")
	self.back = self._tf:Find("blur_panel/adapt/top/back")
	self.blurPanel = self._tf:Find("blur_panel")
	self.mainTF = self._tf:Find("main")
	self.eyeTF = self._tf:Find("blur_panel/adapt/eye")
	self._leftLength = findTF(self.blurPanel, "adapt/left_length")
	self._topPanel = findTF(self.blurPanel, "adapt/top")
	self.topBg = self._tf:Find("blur_panel/top_bg")
	self.topBgWidth = self.topBg.rect.height
	self.topWidth = self._topPanel.rect.height
	self.letfWidth = -1 * (self._leftLength.rect.width + 300)
	self.logPage = GuildOfficeLogPage.New(self._tf, self.event)
	self.dynamicBg = GuildDynamicBG.New(self._tf:Find("dynamic_bg"))
	Input.multiTouchEnabled = false

	return
end

function GuildMainScene:preload(arg_12_1)
	seriesAsync({
		function(arg_13_0)
			pg.m02:sendNotification(GAME.GET_GUILD_REPORT, {
				callback = arg_13_0
			})

			return
		end,
		function(arg_14_0)
			local var_14_0 = getProxy(GuildProxy):getRawData():GetActiveEvent()

			if not var_14_0 then
				pg.m02:sendNotification(GAME.GUILD_GET_ACTIVATION_EVENT, {
					force = false,
					callback = arg_14_0
				})
			elseif var_14_0 and var_14_0:IsExpired() then
				pg.m02:sendNotification(GAME.GUILD_GET_ACTIVATION_EVENT, {
					force = true,
					callback = arg_14_0
				})
			else
				arg_14_0()
			end

			return
		end
	}, arg_12_1)

	return
end

function GuildMainScene:didEnter()
	onButton(self, self.back, function()
		self:emit(GuildMainMediator.ON_BACK)

		return
	end, SOUND_BACK)

	self.hideFlag = false

	onButton(self, self.eyeTF, function()
		self.hideFlag = not self.hideFlag

		self:EnterOrExitPreView()

		return
	end, SFX_PANEL)
	self.guildRes:ExecuteAction("Update", self.playerVO, self.guildVO)
	self:initToggles()
	self:UpdateRes()
	pg.GuildLayerMgr.GetInstance():BlurTopPanel(self.blurPanel)

	if self.guildVO:shouldRefreshCaptial() then
		self:emit(GuildMainMediator.ON_FETCH_CAPITAL)
	end

	self.dynamicBg:Init((self.guildVO:GetMemberShips(GuildConst.MAX_DISPLAY_MEMBER_SHIP)))
	self:UpdateNotices(GuildMainScene.NOTIFY_TYPE_ALL)

	return
end

function GuildMainScene:OnDeleteMember(arg_18_1)
	self.dynamicBg:ExitShip(arg_18_1:GetShip().name)

	return
end

function GuildMainScene:OnAddMember(arg_19_1)
	self.dynamicBg:AddShip(arg_19_1:GetShip(), function()
		return
	end)

	return
end

function GuildMainScene:EnterOrExitPreView()
	if LeanTween.isTweening(go(self._topPanel)) or LeanTween.isTweening(go(self._leftLength)) or LeanTween.isTweening(go(self.topBg)) then
		return
	end

	if self.themePage and self.themePage:GetLoaded() then
		self.themePage:EnterOrExitPreView(self.hideFlag)
	end

	local var_21_0 = self.hideFlag and {
		0,
		self.topWidth
	} or {
		self.topWidth,
		0
	}

	LeanTween.value(go(self._topPanel), var_21_0[1], var_21_0[2], 0.3):setOnUpdate(System.Action_float(function(arg_22_0)
		setAnchoredPosition(self._topPanel, {
			y = arg_22_0
		})

		return
	end))

	local var_21_1 = self.hideFlag and {
		0,
		self.letfWidth
	} or {
		self.letfWidth,
		0
	}

	LeanTween.value(go(self._leftLength), var_21_1[1], var_21_1[2], 0.3):setOnUpdate(System.Action_float(function(arg_23_0)
		setAnchoredPosition(self._leftLength, {
			x = arg_23_0
		})

		return
	end))

	local var_21_2 = self.hideFlag and {
		0,
		self.topBgWidth
	} or {
		self.topBgWidth,
		0
	}

	LeanTween.value(go(self.topBg), var_21_2[1], var_21_2[2], 0.3):setOnUpdate(System.Action_float(function(arg_24_0)
		setAnchoredPosition(self.topBg, {
			y = arg_24_0
		})

		return
	end))

	return
end

function GuildMainScene:UpdateBg()
	local var_25_0 = self.guildVO:getBgName()

	if self.bgName ~= var_25_0 then
		GetSpriteFromAtlasAsync(var_25_0, "", function(arg_26_0)
			if not IsNil(self._tf) then
				setImageSprite(self._bg, arg_26_0, false)
			end

			return
		end)

		self.bgName = var_25_0
	end

	return
end

function GuildMainScene:UpdateNotices(arg_27_1)
	local var_27_0 = getProxy(GuildProxy)
	local var_27_1 = self.guildVO

	if arg_27_1 == GuildMainScene.NOTIFY_TYPE_ALL or arg_27_1 == GuildMainScene.NOTIFY_TYPE_MAIN then
		setActive(self.mainTip, var_27_0:ShouldShowMainTip())
	end

	if arg_27_1 == GuildMainScene.NOTIFY_TYPE_ALL or arg_27_1 == GuildMainScene.NOTIFY_TYPE_APPLY then
		setActive(self.applyTip, var_27_0:ShouldShowApplyTip())
	end

	if arg_27_1 == GuildMainScene.NOTIFY_TYPE_ALL or arg_27_1 == GuildMainScene.NOTIFY_TYPE_OFFICE then
		setActive(self.officeTip, var_27_1:ShouldShowOfficeTip())
	end

	if arg_27_1 == GuildMainScene.NOTIFY_TYPE_ALL or arg_27_1 == GuildMainScene.NOTIFY_TYPE_BATTLE then
		setActive(self.battleTip, var_27_0:ShouldShowBattleTip())
	end

	if arg_27_1 == GuildMainScene.NOTIFY_TYPE_ALL or arg_27_1 == GuildMainScene.NOTIFY_TYPE_TECH then
		setActive(self.techTip, var_27_1:ShouldShowTechTip())
	end

	return
end

function GuildMainScene:initTheme()
	local var_28_0 = self.guildVO:getFaction()

	if not self.faction or self.faction ~= var_28_0 then
		if self.themePage then
			self.themePage:Destroy()
		end

		self.themePage = GuildThemePage.New(self.mainTF, self.event, self.contextData)

		self.themePage:ExecuteAction("Update", self.guildVO, self.playerVO, self.chatMsgs)

		self.faction = var_28_0
	else
		self.themePage:ActionInvoke("Update", self.guildVO, self.playerVO, self.chatMsgs)
	end

	return
end

function GuildMainScene:OpenMainPage()
	if not self.themePage or not self.themePage:GetLoaded() then
		self:initTheme()
	else
		self.themePage:Show()
	end

	return
end

function GuildMainScene:initToggles()
	self.contextData.toggles = {}

	for iter_30_0, iter_30_1 in ipairs(GuildMainScene.TOGGLE_TAG) do
		self.contextData.toggles[iter_30_1] = self.toggleRoot:Find(iter_30_1)

		assert(self.contextData.toggles[iter_30_1], "transform canot be nil" .. iter_30_1)
		onToggle(self, self.contextData.toggles[iter_30_1], function(arg_31_0)
			if arg_31_0 then
				self:openPage(iter_30_1)
				setActive(self._bg, iter_30_1 ~= var_0_1)
			else
				self:closePage(iter_30_1)
			end

			return
		end, SFX_PANEL)
	end

	if LOCK_GUILD_BATTLE then
		setActive(self.contextData.toggles[var_0_6], false)
	end

	local var_30_0 = self.guildVO:getDutyByMemberId(self.playerVO.id)

	setActive(self.contextData.toggles[var_0_3], var_30_0 == GuildConst.DUTY_COMMANDER or var_30_0 == GuildConst.DUTY_DEPUTY_COMMANDER)

	local var_30_1 = self.contextData.page or var_0_1

	self.contextData.page = nil

	assert(self.contextData.toggles[var_30_1])
	triggerToggle(self.contextData.toggles[var_30_1], true)

	return
end

function GuildMainScene:TriggerOfficePage()
	triggerToggle(self.contextData.toggles[var_0_4], true)

	return
end

function GuildMainScene:openPage(arg_33_1)
	setActive(self.eyeTF, arg_33_1 == var_0_1)

	if arg_33_1 == var_0_4 or arg_33_1 == var_0_5 then
		self.guildRes:Show()
	elseif arg_33_1 == var_0_6 or arg_33_1 == var_0_3 or arg_33_1 == var_0_2 then
		self.guildRes:Hide()
	else
		self.guildRes:Hide()
	end

	if self.themePage and self.themePage:GetLoaded() and self.themePage.isShowChatWindow then
		self.themePage:ShowOrHideChatWindow(false)
	end

	if self.contextData.page == arg_33_1 then
		return
	end

	if arg_33_1 == var_0_1 then
		self:OpenMainPage()
		self:emit(GuildMainMediator.OPEN_MAIN)
	elseif arg_33_1 == var_0_2 then
		self:emit(GuildMainMediator.OPEN_MEMBER)
	elseif arg_33_1 == var_0_3 then
		self:emit(GuildMainMediator.OPEN_APPLY)
	elseif arg_33_1 == var_0_4 then
		self:emit(GuildMainMediator.OPEN_OFFICE)
	elseif arg_33_1 == var_0_5 then
		self:emit(GuildMainMediator.OPEN_TECH)
	elseif arg_33_1 == var_0_6 then
		self:emit(GuildMainMediator.OPEN_BATTLE)
	end

	self:UpdateBg()

	self.contextData.page = arg_33_1

	return
end

function GuildMainScene:closePage(arg_34_1)
	if arg_34_1 == var_0_1 then
		if self.themePage then
			self.themePage:ExecuteAction("Hide")
		end
	elseif arg_34_1 == var_0_2 then
		self:emit(GuildMainMediator.CLOSE_MEMBER)
	elseif arg_34_1 == var_0_3 then
		self:emit(GuildMainMediator.CLOSE_APPLY)
	elseif arg_34_1 == var_0_4 then
		self:emit(GuildMainMediator.CLOSE_OFFICE)
	elseif arg_34_1 == var_0_5 then
		self:emit(GuildMainMediator.CLOSE_TECH)
	elseif arg_34_1 == var_0_6 then
		self:emit(GuildMainMediator.CLOSE_BATTLE)
	end

	return
end

function GuildMainScene:BlurView(arg_35_1)
	pg.UIMgr.GetInstance():OverlayPanel(arg_35_1, {
		pbList = {
			arg_35_1:Find("Image1/Image1")
		}
	})

	return
end

function GuildMainScene:UnBlurView(arg_36_1, arg_36_2)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_36_1, arg_36_2)

	return
end

function GuildMainScene:Append(arg_37_1, arg_37_2)
	if self.themePage and self.themePage:GetLoaded() then
		self.themePage:Append(arg_37_1, arg_37_2)
	end

	return
end

function GuildMainScene:UpdateAllChat(arg_38_1)
	if self.themePage and self.themePage:GetLoaded() then
		self.themePage:UpdateAllChat(arg_38_1)
	end

	return
end

function GuildMainScene:UpdateAllLog(arg_39_1)
	if self.themePage and self.themePage:GetLoaded() then
		self.themePage:UpdateAllChat(arg_39_1)
	end

	return
end

function GuildMainScene:AppendLog(arg_40_1, arg_40_2)
	if self.themePage and self.themePage:GetLoaded() then
		self.themePage:AppendLog(arg_40_1, arg_40_2)
	end

	return
end

function GuildMainScene:openResourceLog()
	self.logPage:ExecuteAction("Show", self.guildVO)

	return
end

function GuildMainScene:willExit()
	self.dynamicBg:Dispose()
	self.logPage:Destroy()
	self.guildRes:Destroy()

	if self.themePage then
		self.themePage:Destroy()
	end

	pg.GuildLayerMgr.GetInstance():Clear()
	pg.GuildPaintingMgr.GetInstance():Exit()

	if self.contextData.page then
		self:closePage(self.contextData.page)
	end

	Input.multiTouchEnabled = true

	return
end

function GuildMainScene:insertEmojiToInputText(arg_43_1)
	if self.themePage then
		self.themePage:InsertEmojiToInputText(arg_43_1)
	end

	return
end

return GuildMainScene
