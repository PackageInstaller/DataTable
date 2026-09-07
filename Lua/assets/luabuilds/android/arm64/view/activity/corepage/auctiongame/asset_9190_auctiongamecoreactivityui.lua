local AuctionGameCoreActivityUI = class("AuctionGameCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))

function AuctionGameCoreActivityUI:getUIName()
	return "AuctionGameCoreActivityUI"
end

function AuctionGameCoreActivityUI:preload(arg_2_1)
	local var_2_0 = {}

	table.insert(var_2_0, function(arg_3_0)
		pg.m02:sendNotification(GAME.AUCTION_GAME_INIT, {
			callback = arg_3_0
		})

		return
	end)
	seriesAsync(var_2_0, arg_2_1)

	return
end

AuctionGameCoreActivityUI.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function AuctionGameCoreActivityUI:init(...)
	AuctionGameCoreActivityUI.super.init(self, ...)

	self.btnBack = self._tf:Find("adapt/TopPage/top/btn_back")
	self.topPage = self._tf:Find("adapt/TopPage")

	setText(self._tf:Find("adapt/TopPage/top/deco/Text"), i18n("HelenaCoreActivity_title"))
	setText(self._tf:Find("adapt/TopPage/top/deco/Text/Text_1"), i18n("HelenaCoreActivity_title2"))
	setText(self._tf:Find("adapt/taskBtn/Text"), i18n("auction_signin_task"))
	setText(self._tf:Find("adapt/auctionGameBtn/Text"), i18n("auction_signin_goto"))

	self.uiTaskTipGo = findTF(self._tf, "adapt/taskBtn/tip")
	self.uiAuctionTipGo = findTF(self._tf, "adapt/auctionGameBtn/tip")

	onButton(self, findTF(self._tf, "adapt/auctionGameBtn"), function()
		local var_5_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME)

		if var_5_0 == nil or var_5_0 and var_5_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_activity_closed_tip"))

			return
		end

		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.AUCTION_GAME_ENTRANCE)

		return
	end, SFX_PANEL)
	onButton(self, findTF(self._tf, "adapt/taskBtn"), function()
		local var_6_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME)

		if var_6_0 == nil or var_6_0 and var_6_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_activity_closed_tip"))

			return
		end

		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameTaskScene,
			mediator = AuctionGameTaskMediator,
			data = {}
		}))

		return
	end, SFX_PANEL)

	local var_4_0

	self.tabsList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = underscore.detect(self.activities, function(arg_8_0)
				return tostring(arg_8_0:getConfig("is_show")) == arg_7_2.name
			end)

			if not var_7_0 or var_7_0:isEnd() then
				setActive(arg_7_2, false)
			elseif not self.pageDic[var_7_0.id] then
				warning(string.format("without page in act:", var_7_0.id))
			else
				self:OnToggleName(arg_7_2, var_7_0)

				if self.pageDic[var_7_0.id] ~= nil then
					setActive(arg_7_2:Find("tip"), var_7_0:readyToAchieve())
					onToggle(self, arg_7_2, function(arg_9_0)
						if arg_9_0 then
							if var_4_0 ~= var_7_0.id then
								self:selectActivity(var_7_0)
							end

							var_4_0 = var_7_0.id
						end

						setActive(arg_7_2:Find("off"), not arg_9_0)

						return
					end, SFX_PANEL)
				end
			end
		end

		return
	end)

	return
end

function AuctionGameCoreActivityUI:didEnter()
	AuctionGameCoreActivityUI.super.didEnter(self)
	pg.NewStoryMgr.GetInstance():Play("TEBIEJINGPAISHIKE1")
	self:RefreshTip()

	return
end

function AuctionGameCoreActivityUI:updateActivity(arg_11_1)
	AuctionGameCoreActivityUI.super.updateActivity(self, arg_11_1)
	self:RefreshTip()

	return
end

function AuctionGameCoreActivityUI:RefreshTip()
	local var_12_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME)

	if var_12_0 == nil then
		setActive(self.uiTaskTipGo, false)
		setActive(self.uiAuctionTipGo, false)
	else
		setActive(self.uiTaskTipGo, var_12_0:GetTaskTip())
		setActive(self.uiAuctionTipGo, var_12_0:readyToAchieve())
	end

	return
end

function AuctionGameCoreActivityUI:verifyTabs(arg_13_1)
	if self.activities[self:getActivityIndex(arg_13_1) or self:getActivityIndex(self:GetActiveActivity()) or 1] == nil then
		return
	end

	local var_13_0 = self.tabs:Find(tostring((self.activities[self:getActivityIndex(arg_13_1) or self:getActivityIndex(self:GetActiveActivity()) or 1]:getConfig("is_show"))))

	if #self.activities == 1 then
		setActive(self._tf:Find("adapt/tabs"), false)
	else
		setActive(self._tf:Find("adapt/tabs"), true)
	end

	triggerToggle(var_13_0, true)

	return
end

function AuctionGameCoreActivityUI:OnToggleName(arg_14_1, arg_14_2)
	setText(arg_14_1:Find("on/name"), i18n(arg_14_2:getConfig("title_res_tag")))
	setText(arg_14_1:Find("off/name"), i18n(arg_14_2:getConfig("title_res_tag")))

	return
end

function AuctionGameCoreActivityUI:willExit()
	AuctionGameCoreActivityUI.super.willExit(self)

	return
end

return AuctionGameCoreActivityUI
