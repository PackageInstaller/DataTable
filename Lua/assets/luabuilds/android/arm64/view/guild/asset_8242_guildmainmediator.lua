local GuildMainMediator = class("GuildMainMediator", import("..base.ContextMediator"))

GuildMainMediator.OPEN_MEMBER = "GuildMainMediator:OPEN_MEMBER"
GuildMainMediator.CLOSE_MEMBER = "GuildMainMediator:CLOSE_MEMBER"
GuildMainMediator.OPEN_APPLY = "GuildMainMediator:OPEN_APPLY"
GuildMainMediator.CLOSE_APPLY = "GuildMainMediator:CLOSE_APPLY"
GuildMainMediator.MODIFY = "GuildMainMediator:MODIFY"
GuildMainMediator.DISSOLVE = "GuildMainMediator:DISSOLVE"
GuildMainMediator.QUIT = "GuildMainMediator:QUIT"
GuildMainMediator.ON_BACK = "GuildMainMediator:ON_BACK"
GuildMainMediator.REBUILD_ALL = "GuildMainMediator:REBUILD_ALL"
GuildMainMediator.ON_REBUILD_LOG_ALL = "GuildMainMediator:ON_REBUILD_LOG_ALL"
GuildMainMediator.SEND_MSG = "GuildMainMediator:SEND_MSG"
GuildMainMediator.OPEN_EMOJI = "GuildMainMediator:OPEN_EMOJI"
GuildMainMediator.OPEN_OFFICE = "GuildMainMediator:OPEN_OFFICE"
GuildMainMediator.OPEN_TECH = "GuildMainMediator:OPEN_TECH"
GuildMainMediator.OPEN_BATTLE = "GuildMainMediator:OPEN_BATTLE"
GuildMainMediator.CLOSE_OFFICE = "GuildMainMediator:CLOSE_OFFICE"
GuildMainMediator.CLOSE_TECH = "GuildMainMediator:CLOSE_TECH"
GuildMainMediator.CLOSE_BATTLE = "GuildMainMediator:CLOSE_BATTLE"
GuildMainMediator.ON_FETCH_CAPITAL = "GuildOfficeMediator:ON_FETCH_CAPITAL"
GuildMainMediator.ON_FETCH_CAPITAL_LOG = "GuildOfficeMediator:ON_FETCH_CAPITAL_LOG"
GuildMainMediator.OPEN_EVENT_REPORT = "GuildOfficeMediator:OPEN_EVENT_REPORT"
GuildMainMediator.OPEN_EVENT = "GuildOfficeMediator:OPEN_EVENT"
GuildMainMediator.OPEN_MAIN = "GuildOfficeMediator:OPEN_MAIN"
GuildMainMediator.SWITCH_TO_OFFICE = "GuildOfficeMediator:SWITCH_TO_OFFICE"
GuildMainMediator.OPEN_SHOP = "GuildMainMediator:OPEN_SHOP"

function GuildMainMediator:register()
	local var_1_0 = getProxy(ContextProxy)
	local var_1_1 = var_1_0:GetPrevContext(1)

	if var_1_1.mediator == NewGuildMediator then
		var_1_0:RemoveContext(var_1_1)
	end

	local var_1_2 = getProxy(GuildProxy)

	self.viewComponent:setGuildVO((var_1_2:getData()))
	self.viewComponent:setChatMsgs((var_1_2:getChatMsgs()))
	self:bind(GuildMainMediator.OPEN_SHOP, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_GUILD
		})

		return
	end)
	self:bind(GuildMainMediator.OPEN_MAIN, function()
		self:closePage(GuildEventReportMediator)

		return
	end)
	self:bind(GuildMainMediator.OPEN_EVENT, function(arg_4_0)
		self.viewComponent:openPage(GuildMainScene.TOGGLE_TAG[6])

		return
	end)
	self:bind(GuildMainMediator.OPEN_EVENT_REPORT, function(arg_5_0)
		self:sendNotification(GAME.GUILD_OPEN_EVENT_REPORT)

		return
	end)
	self:bind(GuildMainMediator.ON_FETCH_CAPITAL, function(arg_6_0)
		self:sendNotification(GAME.GUILD_REFRESH_CAPITAL)

		return
	end)
	self.viewComponent:setPlayerVO((getProxy(PlayerProxy):getData()))
	self:bind(GuildMainMediator.ON_BACK, function(arg_7_0)
		self:sendNotification(GAME.GO_BACK)

		return
	end)
	self:bind(GuildMainMediator.REBUILD_ALL, function(arg_8_0)
		self.viewComponent:UpdateAllChat((getProxy(GuildProxy):getChatMsgs()))

		return
	end)
	self:bind(GuildMainMediator.OPEN_MEMBER, function()
		self:closePage(GuildEventReportMediator)
		self:addSubLayers(Context.New({
			viewComponent = GuildMemberLayer,
			mediator = GuildMemberMediator
		}))

		return
	end)
	self:bind(GuildMainMediator.CLOSE_MEMBER, function()
		self:closePage(GuildMemberMediator)

		return
	end)
	self:bind(GuildMainMediator.OPEN_APPLY, function()
		self:closePage(GuildEventReportMediator)
		self:addSubLayers(Context.New({
			viewComponent = GuildRequestLayer,
			mediator = GuildRequestMediator
		}))

		return
	end)
	self:bind(GuildMainMediator.CLOSE_APPLY, function()
		self:closePage(GuildRequestMediator)

		return
	end)
	self:bind(GuildMainMediator.MODIFY, function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		self:sendNotification(GAME.MODIFY_GUILD_INFO, {
			type = arg_13_1,
			int = arg_13_2,
			string = arg_13_3
		})

		return
	end)
	self:bind(GuildMainMediator.DISSOLVE, function(arg_14_0, arg_14_1)
		self:sendNotification(GAME.GUILD_DISSOLVE, arg_14_1)

		return
	end)
	self:bind(GuildMainMediator.QUIT, function(arg_15_0, arg_15_1)
		self:sendNotification(GAME.GUILD_QUIT, arg_15_1)

		return
	end)
	self:bind(GuildMainMediator.ON_REBUILD_LOG_ALL, function(arg_16_0)
		self.viewComponent:UpdateAllLog((getProxy(GuildProxy):getData():getLogs()))

		return
	end)
	self:bind(GuildMainMediator.SEND_MSG, function(arg_17_0, arg_17_1)
		self:sendNotification(GAME.GUILD_SEND_MSG, arg_17_1)

		return
	end)
	self:bind(GuildMainMediator.OPEN_EMOJI, function(arg_18_0, arg_18_1, arg_18_2)
		self:addSubLayers(Context.New({
			viewComponent = EmojiLayer,
			mediator = EmojiMediator,
			data = {
				pos = arg_18_1,
				callback = arg_18_2,
				groupName = self.viewComponent:getGroupName(),
				emojiIconCallback = function(arg_19_0)
					self.viewComponent:insertEmojiToInputText(arg_19_0)

					return
				end
			}
		}))

		return
	end)
	self:bind(GuildMainMediator.OPEN_OFFICE, function()
		self:closePage(GuildEventReportMediator)
		self:addSubLayers(Context.New({
			viewComponent = GuildOfficeLayer,
			mediator = GuildOfficeMediator
		}))

		return
	end)
	self:bind(GuildMainMediator.CLOSE_OFFICE, function()
		self:closePage(GuildOfficeMediator)

		return
	end)
	self:bind(GuildMainMediator.OPEN_TECH, function()
		self:closePage(GuildEventReportMediator)
		self:addSubLayers(Context.New({
			viewComponent = GuildTechnologyLayer,
			mediator = GuildTechnologyMediator
		}))

		return
	end)
	self:bind(GuildMainMediator.CLOSE_TECH, function()
		self:closePage(GuildTechnologyMediator)

		return
	end)
	self:bind(GuildMainMediator.ON_FETCH_CAPITAL_LOG, function(arg_24_0)
		if var_1_2:getData():shouldRequestCapitalLog() then
			self:sendNotification(GAME.GUILD_FETCH_CAPITAL_LOG)
		else
			self.viewComponent:openResourceLog()
		end

		return
	end)
	self:bind(GuildMainMediator.OPEN_BATTLE, function()
		self:closePage(GuildEventReportMediator)
		self:addSubLayers(Context.New({
			viewComponent = GuildEventLayer,
			mediator = GuildEventMediator
		}))

		return
	end)
	self:bind(GuildMainMediator.CLOSE_BATTLE, function()
		self:closePage(GuildEventMediator)

		return
	end)
	self.viewComponent:setPlayerVO((getProxy(PlayerProxy):getData()))

	return
end

function GuildMainMediator:closePage(arg_27_1)
	local var_27_0 = getProxy(ContextProxy):getContextByMediator(arg_27_1)

	if var_27_0 then
		self:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_27_0
		})
	end

	return
end

function GuildMainMediator:listNotificationInterests()
	return {
		GuildProxy.GUILD_UPDATED,
		GuildProxy.EXIT_GUILD,
		GAME.MODIFY_GUILD_INFO_DONE,
		GuildProxy.NEW_MSG_ADDED,
		GuildProxy.LOG_ADDED,
		GuildProxy.REQUEST_COUNT_UPDATED,
		GuildProxy.REQUEST_DELETED,
		GAME.GUILD_GET_REQUEST_LIST_DONE,
		GAME.REMOVE_LAYERS,
		PlayerProxy.UPDATED,
		GAME.GUILD_FETCH_CAPITAL_LOG_DONE,
		GAME.GUILD_COMMIT_DONATE_DONE,
		GuildProxy.ON_DELETED_MEMBER,
		GuildProxy.ON_ADDED_MEMBER,
		GAME.GUILD_OPEN_EVENT_REPORT,
		GuildProxy.BATTLE_BTN_FLAG_CHANGE,
		GAME.BEGIN_STAGE_DONE,
		GAME.SUBMIT_GUILD_REPORT_DONE,
		GuildTechnologyMediator.ON_OPEN_OFFICE,
		GAME.OPEN_MSGBOX_DONE,
		GuildProxy.TECHNOLOGY_START,
		GAME.GO_WORLD_BOSS_SCENE,
		GAME.GUILD_START_TECH_DONE,
		GuildMainMediator.SWITCH_TO_OFFICE,
		GAME.ON_GUILD_JOIN_EVENT_DONE,
		GAME.GUILD_JOIN_MISSION_DONE,
		GAME.GUILD_GET_SUPPLY_AWARD_DONE,
		GAME.LOAD_LAYERS,
		GAME.REMOVE_LAYERS
	}
end

function GuildMainMediator:handleNotification(arg_29_1)
	local var_29_0 = arg_29_1:getName()
	local var_29_1 = arg_29_1:getBody()

	if var_29_0 == GuildProxy.GUILD_UPDATED then
		self.viewComponent:setGuildVO(var_29_1)
	elseif var_29_0 == GuildProxy.EXIT_GUILD then
		self.viewComponent:emit(GuildMainMediator.ON_BACK)
	elseif var_29_0 == GAME.MODIFY_GUILD_INFO_DONE then
		self.viewComponent:initTheme()
	elseif var_29_0 == GuildProxy.NEW_MSG_ADDED then
		self.viewComponent:Append(var_29_1, -1)
	elseif var_29_0 == GuildProxy.LOG_ADDED then
		self.viewComponent:AppendLog(var_29_1, true)
	elseif var_29_0 == GuildProxy.REQUEST_COUNT_UPDATED or var_29_0 == GuildProxy.REQUEST_DELETED or var_29_0 == GAME.GUILD_GET_REQUEST_LIST_DONE then
		local var_29_2 = getProxy(GuildProxy)

		self.viewComponent:UpdateNotices(GuildMainScene.NOTIFY_TYPE_APPLY)
	elseif var_29_0 == GAME.GUILD_FETCH_CAPITAL_LOG_DONE then
		self.viewComponent:openResourceLog()
	elseif var_29_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayerVO(var_29_1)
		self.viewComponent:UpdateRes()
	elseif var_29_0 == GAME.GUILD_COMMIT_DONATE_DONE or var_29_0 == GAME.GUILD_GET_SUPPLY_AWARD_DONE then
		self.viewComponent:UpdateNotices(GuildMainScene.NOTIFY_TYPE_OFFICE)
	elseif GuildProxy.ON_DELETED_MEMBER == var_29_0 then
		self.viewComponent:OnDeleteMember(var_29_1.member)
	elseif GuildProxy.ON_ADDED_MEMBER == var_29_0 then
		self.viewComponent:OnAddMember(var_29_1.member)
	elseif var_29_0 == GAME.GUILD_OPEN_EVENT_REPORT then
		self:addSubLayers(Context.New({
			viewComponent = GuildEventReportLayer,
			mediator = GuildEventReportMediator
		}))
	elseif var_29_0 == GAME.SUBMIT_GUILD_REPORT_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_29_1.awards, var_29_1.callback)
		self.viewComponent:OnReportUpdated()
		self.viewComponent:UpdateNotices(GuildMainScene.NOTIFY_TYPE_BATTLE)
		self.viewComponent:UpdateNotices(GuildMainScene.NOTIFY_TYPE_MAIN)
	elseif var_29_0 == GuildProxy.BATTLE_BTN_FLAG_CHANGE or var_29_0 == GAME.ON_GUILD_JOIN_EVENT_DONE or var_29_0 == GAME.GUILD_ACTIVE_EVENT_DONE or var_29_0 == GAME.GUILD_JOIN_MISSION_DONE then
		self.viewComponent:UpdateNotices(GuildMainScene.NOTIFY_TYPE_BATTLE)
	elseif var_29_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_29_1)
	elseif var_29_0 == GuildTechnologyMediator.ON_OPEN_OFFICE then
		triggerToggle(self.contextData.toggles[GuildMainScene.TOGGLE_TAG[4]], true)
	elseif var_29_0 == GAME.OPEN_MSGBOX_DONE then
		pg.GuildLayerMgr.GetInstance():OnShowMsgBox()
	elseif var_29_0 == GuildProxy.TECHNOLOGY_START then
		self.viewComponent:UpdateNotices(GuildMainScene.NOTIFY_TYPE_TECH)
	elseif var_29_0 == GAME.GUILD_START_TECH_DONE then
		self.viewComponent:setPlayerVO((getProxy(PlayerProxy):getData()))
		self.viewComponent:UpdateRes()
	elseif var_29_0 == GAME.GO_WORLD_BOSS_SCENE then
		self.contextData.page = nil
	elseif var_29_0 == GuildMainMediator.SWITCH_TO_OFFICE then
		self.viewComponent:TriggerOfficePage()
	elseif var_29_0 == GAME.LOAD_LAYERS then
		if var_29_1.context.mediator == AwardInfoMediator then
			pg.GuildLayerMgr.GetInstance():UnBlurTopPanel()
		end
	elseif var_29_0 == GAME.REMOVE_LAYERS and var_29_1.context.mediator == AwardInfoMediator then
		pg.GuildLayerMgr.GetInstance():_BlurTopPanel()
	end

	return
end

return GuildMainMediator
