local var_0_0 = class("GuildMainScene", import("..base.BaseUI"))

function var_0_0.forceGC(arg_1_0)
	return true
end

function var_0_0.getUIName(arg_2_0)
	return "GuildMainUI"
end

function var_0_0.getGroupName(arg_3_0)
	return "group_GuildMainUI"
end

function var_0_0.setGuildVO(arg_4_0, arg_4_1)
	arg_4_0.guildVO = arg_4_1

	if arg_4_0.guildRes and arg_4_0.guildRes:GetLoaded() then
		arg_4_0.guildRes:Update(arg_4_0.playerVO, arg_4_1)
	end

	if arg_4_0.themePage and arg_4_0.themePage:GetLoaded() then
		arg_4_0.themePage:UpdateGuild(arg_4_0.guildVO)
	end

	return
end

function var_0_0.setPlayerVO(arg_5_0, arg_5_1)
	arg_5_0.playerVO = arg_5_1

	return
end

function var_0_0.setChatMsgs(arg_6_0, arg_6_1)
	arg_6_0.chatMsgs = arg_6_1

	return
end

function var_0_0.setActivity(arg_7_0, arg_7_1)
	arg_7_0.activity = arg_7_1

	return
end

function var_0_0.setGuildEvent(arg_8_0, arg_8_1)
	arg_8_0.guildEvent = arg_8_1

	return
end

function var_0_0.UpdateRes(arg_9_0)
	if arg_9_0.guildRes and arg_9_0.guildRes:GetLoaded() then
		arg_9_0.guildRes:Update(arg_9_0.playerVO, arg_9_0.guildVO)
	end

	return
end

function var_0_0.OnReportUpdated(arg_10_0)
	if arg_10_0.themePage and arg_10_0.themePage:GetLoaded() then
		arg_10_0.themePage:RefreshReportBtn()
	end

	return
end

local var_0_1 = "member"
local var_0_2 = "apply"
local var_0_3 = "office"
local var_0_4 = "technology"
local var_0_5 = "battle"

;({})[1] = "main"
;({})[2] = "member"
;({})[3] = "apply"
;({})[4] = "office"
;({})[5] = "technology"
;({})[6] = "battle"
var_0_0.TOGGLE_TAG = {}
var_0_0.NOTIFY_TYPE_ALL = 0
var_0_0.NOTIFY_TYPE_MAIN = 1
var_0_0.NOTIFY_TYPE_APPLY = 2
var_0_0.NOTIFY_TYPE_OFFICE = 3
var_0_0.NOTIFY_TYPE_BATTLE = 4
var_0_0.NOTIFY_TYPE_TECH = 5

function var_0_0.init(arg_11_0)
	arg_11_0._bg = arg_11_0._tf:Find("bg")

	pg.GuildPaintingMgr.GetInstance():Enter(arg_11_0._bg:Find("painting"))

	arg_11_0._playerResOb = arg_11_0._tf:Find("blur_panel/adapt/top/res")
	arg_11_0.guildRes = GuildResPage.New(arg_11_0._playerResOb, arg_11_0.event)
	arg_11_0.toggleRoot = arg_11_0._tf:Find("blur_panel/adapt/left_length/frame/scroll_rect/tagRoot")
	arg_11_0.mainTip = arg_11_0.toggleRoot:Find("main/tip")
	arg_11_0.applyTip = arg_11_0.toggleRoot:Find("apply/tip")
	arg_11_0.officeTip = arg_11_0.toggleRoot:Find("office/tip")
	arg_11_0.techTip = arg_11_0.toggleRoot:Find("technology/tip")
	arg_11_0.battleTip = arg_11_0.toggleRoot:Find("battle/tip")
	arg_11_0.back = arg_11_0._tf:Find("blur_panel/adapt/top/back")
	arg_11_0.blurPanel = arg_11_0._tf:Find("blur_panel")
	arg_11_0.mainTF = arg_11_0._tf:Find("main")
	arg_11_0.eyeTF = arg_11_0._tf:Find("blur_panel/adapt/eye")
	arg_11_0._leftLength = findTF(arg_11_0.blurPanel, "adapt/left_length")
	arg_11_0._topPanel = findTF(arg_11_0.blurPanel, "adapt/top")
	arg_11_0.topBg = arg_11_0._tf:Find("blur_panel/top_bg")
	arg_11_0.topBgWidth = arg_11_0.topBg.rect.height
	arg_11_0.topWidth = arg_11_0._topPanel.rect.height
	arg_11_0.letfWidth = -1 * (arg_11_0._leftLength.rect.width + 300)
	arg_11_0.logPage = GuildOfficeLogPage.New(arg_11_0._tf, arg_11_0.event)
	arg_11_0.dynamicBg = GuildDynamicBG.New(arg_11_0._tf:Find("dynamic_bg"))
	Input.multiTouchEnabled = false

	return
end

function var_0_0.preload(arg_12_0, arg_12_1)
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

function var_0_0.didEnter(arg_15_0)
	onButton(arg_15_0, arg_15_0.back, function()
		arg_15_0:emit(GuildMainMediator.ON_BACK)

		return
	end, SOUND_BACK)

	arg_15_0.hideFlag = false

	onButton(arg_15_0, arg_15_0.eyeTF, function()
		arg_15_0.hideFlag = not arg_15_0.hideFlag

		arg_15_0:EnterOrExitPreView()

		return
	end, SFX_PANEL)
	arg_15_0.guildRes:ExecuteAction("Update", arg_15_0.playerVO, arg_15_0.guildVO)
	arg_15_0:initToggles()
	arg_15_0:UpdateRes()
	pg.GuildLayerMgr.GetInstance():BlurTopPanel(arg_15_0.blurPanel)

	if arg_15_0.guildVO:shouldRefreshCaptial() then
		arg_15_0:emit(GuildMainMediator.ON_FETCH_CAPITAL)
	end

	arg_15_0.dynamicBg:Init((arg_15_0.guildVO:GetMemberShips(GuildConst.MAX_DISPLAY_MEMBER_SHIP)))
	arg_15_0:UpdateNotices(var_0_0.NOTIFY_TYPE_ALL)

	return
end

function var_0_0.OnDeleteMember(arg_18_0, arg_18_1)
	arg_18_0.dynamicBg:ExitShip(arg_18_1:GetShip().name)

	return
end

function var_0_0.OnAddMember(arg_19_0, arg_19_1)
	arg_19_0.dynamicBg:AddShip(arg_19_1:GetShip(), function()
		return
	end)

	return
end

function var_0_0.EnterOrExitPreView(arg_21_0)
	if LeanTween.isTweening(go(arg_21_0._topPanel)) or LeanTween.isTweening(go(arg_21_0._leftLength)) or LeanTween.isTweening(go(arg_21_0.topBg)) then
		return
	end

	if arg_21_0.themePage and arg_21_0.themePage:GetLoaded() then
		arg_21_0.themePage:EnterOrExitPreView(arg_21_0.hideFlag)
	end

	if arg_21_0.hideFlag then
		local var_21_0 = {
			0,
			arg_21_0.topWidth
		}

		if not {
			0,
			arg_21_0.topWidth
		} then
			var_21_0 = {
				arg_21_0.topWidth,
				0
			}
		end

		LeanTween.value(go(arg_21_0._topPanel), var_21_0[1], var_21_0[2], 0.3):setOnUpdate(System.Action_float(function(arg_22_0)
			setAnchoredPosition(arg_21_0._topPanel, {
				y = arg_22_0
			})

			return
		end))

		if arg_21_0.hideFlag then
			local var_21_1 = {
				0,
				arg_21_0.letfWidth
			}

			if not {
				0,
				arg_21_0.letfWidth
			} then
				var_21_1 = {
					arg_21_0.letfWidth,
					0
				}
			end

			LeanTween.value(go(arg_21_0._leftLength), var_21_1[1], var_21_1[2], 0.3):setOnUpdate(System.Action_float(function(arg_23_0)
				setAnchoredPosition(arg_21_0._leftLength, {
					x = arg_23_0
				})

				return
			end))

			if arg_21_0.hideFlag then
				local var_21_2 = {
					0,
					arg_21_0.topBgWidth
				}

				if not {
					0,
					arg_21_0.topBgWidth
				} then
					var_21_2 = {
						arg_21_0.topBgWidth,
						0
					}
				end

				LeanTween.value(go(arg_21_0.topBg), var_21_2[1], var_21_2[2], 0.3):setOnUpdate(System.Action_float(function(arg_24_0)
					setAnchoredPosition(arg_21_0.topBg, {
						y = arg_24_0
					})

					return
				end))

				return
			end
		end
	end
end

function var_0_0.UpdateBg(arg_25_0)
	local var_25_0 = arg_25_0.guildVO:getBgName()

	if arg_25_0.bgName ~= var_25_0 then
		GetSpriteFromAtlasAsync(var_25_0, "", function(arg_26_0)
			if not IsNil(arg_25_0._tf) then
				setImageSprite(arg_25_0._bg, arg_26_0, false)
			end

			return
		end)

		arg_25_0.bgName = var_25_0
	end

	return
end

function var_0_0.UpdateNotices(arg_27_0, arg_27_1)
	local var_27_0 = getProxy(GuildProxy)

	if arg_27_1 == var_0_0.NOTIFY_TYPE_ALL or arg_27_1 == var_0_0.NOTIFY_TYPE_MAIN then
		setActive(arg_27_0.mainTip, var_27_0:ShouldShowMainTip())
	end

	if arg_27_1 == var_0_0.NOTIFY_TYPE_ALL or arg_27_1 == var_0_0.NOTIFY_TYPE_APPLY then
		setActive(arg_27_0.applyTip, var_27_0:ShouldShowApplyTip())
	end

	if arg_27_1 == var_0_0.NOTIFY_TYPE_ALL or arg_27_1 == var_0_0.NOTIFY_TYPE_OFFICE then
		setActive(arg_27_0.officeTip, var_27_1:ShouldShowOfficeTip())
	end

	if arg_27_1 == var_0_0.NOTIFY_TYPE_ALL or arg_27_1 == var_0_0.NOTIFY_TYPE_BATTLE then
		setActive(arg_27_0.battleTip, var_27_0:ShouldShowBattleTip())
	end

	if arg_27_1 == var_0_0.NOTIFY_TYPE_ALL or arg_27_1 == var_0_0.NOTIFY_TYPE_TECH then
		setActive(arg_27_0.techTip, var_27_1:ShouldShowTechTip())
	end

	return
end

function var_0_0.initTheme(arg_28_0)
	local var_28_0 = arg_28_0.guildVO:getFaction()

	if not arg_28_0.faction or arg_28_0.faction ~= var_28_0 then
		if arg_28_0.themePage then
			arg_28_0.themePage:Destroy()
		end

		arg_28_0.themePage = GuildThemePage.New(arg_28_0.mainTF, arg_28_0.event, arg_28_0.contextData)

		arg_28_0.themePage:ExecuteAction("Update", arg_28_0.guildVO, arg_28_0.playerVO, arg_28_0.chatMsgs)

		arg_28_0.faction = var_28_0
	else
		arg_28_0.themePage:ActionInvoke("Update", arg_28_0.guildVO, arg_28_0.playerVO, arg_28_0.chatMsgs)
	end

	return
end

function var_0_0.OpenMainPage(arg_29_0)
	if not arg_29_0.themePage or not arg_29_0.themePage:GetLoaded() then
		arg_29_0:initTheme()
	else
		arg_29_0.themePage:Show()
	end

	return
end

function var_0_0.initToggles(arg_30_0)
	arg_30_0.contextData.toggles = {}

	for iter_30_0, iter_30_1 in ipairs(var_0_0.TOGGLE_TAG) do
		arg_30_0.contextData.toggles[iter_30_1] = arg_30_0.toggleRoot:Find(iter_30_1)

		assert(arg_30_0.contextData.toggles[iter_30_1], "transform canot be nil" .. iter_30_1)
		onToggle(arg_30_0, arg_30_0.contextData.toggles[iter_30_1], function(arg_31_0)
			if arg_31_0 then
				arg_30_0:openPage(iter_30_1)
				setActive(arg_30_0._bg, iter_30_1 ~= var_0)
			else
				arg_30_0:closePage(iter_30_1)
			end

			return
		end, SFX_PANEL)
	end

	if LOCK_GUILD_BATTLE then
		setActive(arg_30_0.contextData.toggles[var_0_5], false)
	end

	local var_30_0 = arg_30_0.guildVO:getDutyByMemberId(arg_30_0.playerVO.id)

	setActive(arg_30_0.contextData.toggles[var_0_2], var_30_0 == GuildConst.DUTY_COMMANDER or var_30_0 == GuildConst.DUTY_DEPUTY_COMMANDER)

	local var_30_1 = arg_30_0.contextData.page or var_0

	arg_30_0.contextData.page = nil

	assert(arg_30_0.contextData.toggles[var_30_1])
	triggerToggle(arg_30_0.contextData.toggles[var_30_1], true)

	return
end

function var_0_0.TriggerOfficePage(arg_32_0)
	triggerToggle(arg_32_0.contextData.toggles[var_0_3], true)

	return
end

function var_0_0.openPage(arg_33_0, arg_33_1)
	setActive(arg_33_0.eyeTF, arg_33_1 == var_0)

	if arg_33_1 == var_0_3 or arg_33_1 == var_0_4 then
		arg_33_0.guildRes:Show()
	elseif arg_33_1 == var_0_5 or arg_33_1 == var_0_2 or arg_33_1 == var_0_1 then
		arg_33_0.guildRes:Hide()
	else
		arg_33_0.guildRes:Hide()
	end

	if arg_33_0.themePage and arg_33_0.themePage:GetLoaded() and arg_33_0.themePage.isShowChatWindow then
		arg_33_0.themePage:ShowOrHideChatWindow(false)
	end

	if arg_33_0.contextData.page == arg_33_1 then
		return
	end

	if arg_33_1 == var_0 then
		arg_33_0:OpenMainPage()
		arg_33_0:emit(GuildMainMediator.OPEN_MAIN)
	elseif arg_33_1 == var_0_1 then
		arg_33_0:emit(GuildMainMediator.OPEN_MEMBER)
	elseif arg_33_1 == var_0_2 then
		arg_33_0:emit(GuildMainMediator.OPEN_APPLY)
	elseif arg_33_1 == var_0_3 then
		arg_33_0:emit(GuildMainMediator.OPEN_OFFICE)
	elseif arg_33_1 == var_0_4 then
		arg_33_0:emit(GuildMainMediator.OPEN_TECH)
	elseif arg_33_1 == var_0_5 then
		arg_33_0:emit(GuildMainMediator.OPEN_BATTLE)
	end

	arg_33_0:UpdateBg()

	arg_33_0.contextData.page = arg_33_1

	return
end

function var_0_0.closePage(arg_34_0, arg_34_1)
	if arg_34_1 == var_0 then
		if arg_34_0.themePage then
			arg_34_0.themePage:ExecuteAction("Hide")
		end
	elseif arg_34_1 == var_0_1 then
		arg_34_0:emit(GuildMainMediator.CLOSE_MEMBER)
	elseif arg_34_1 == var_0_2 then
		arg_34_0:emit(GuildMainMediator.CLOSE_APPLY)
	elseif arg_34_1 == var_0_3 then
		arg_34_0:emit(GuildMainMediator.CLOSE_OFFICE)
	elseif arg_34_1 == var_0_4 then
		arg_34_0:emit(GuildMainMediator.CLOSE_TECH)
	elseif arg_34_1 == var_0_5 then
		arg_34_0:emit(GuildMainMediator.CLOSE_BATTLE)
	end

	return
end

function var_0_0.BlurView(arg_35_0, arg_35_1)
	pg.UIMgr.GetInstance():OverlayPanel(arg_35_1, {
		pbList = {
			arg_35_1:Find("Image1/Image1")
		}
	})

	return
end

function var_0_0.UnBlurView(arg_36_0, arg_36_1, arg_36_2)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_36_1, arg_36_2)

	return
end

function var_0_0.Append(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0.themePage and arg_37_0.themePage:GetLoaded() then
		arg_37_0.themePage:Append(arg_37_1, arg_37_2)
	end

	return
end

function var_0_0.UpdateAllChat(arg_38_0, arg_38_1)
	if arg_38_0.themePage and arg_38_0.themePage:GetLoaded() then
		arg_38_0.themePage:UpdateAllChat(arg_38_1)
	end

	return
end

function var_0_0.UpdateAllLog(arg_39_0, arg_39_1)
	if arg_39_0.themePage and arg_39_0.themePage:GetLoaded() then
		arg_39_0.themePage:UpdateAllChat(arg_39_1)
	end

	return
end

function var_0_0.AppendLog(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_0.themePage and arg_40_0.themePage:GetLoaded() then
		arg_40_0.themePage:AppendLog(arg_40_1, arg_40_2)
	end

	return
end

function var_0_0.openResourceLog(arg_41_0)
	arg_41_0.logPage:ExecuteAction("Show", arg_41_0.guildVO)

	return
end

function var_0_0.willExit(arg_42_0)
	arg_42_0.dynamicBg:Dispose()
	arg_42_0.logPage:Destroy()
	arg_42_0.guildRes:Destroy()

	if arg_42_0.themePage then
		arg_42_0.themePage:Destroy()
	end

	pg.GuildLayerMgr.GetInstance():Clear()
	pg.GuildPaintingMgr.GetInstance():Exit()

	if arg_42_0.contextData.page then
		arg_42_0:closePage(arg_42_0.contextData.page)
	end

	Input.multiTouchEnabled = true

	return
end

function var_0_0.insertEmojiToInputText(arg_43_0, arg_43_1)
	if arg_43_0.themePage then
		arg_43_0.themePage:InsertEmojiToInputText(arg_43_1)
	end

	return
end

return var_0_0
