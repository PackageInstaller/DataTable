local AnniversaryNineMainPage = class("AnniversaryNineMainPage", import("view.activity.CorePage.CoreActivityPage"))

function AnniversaryNineMainPage:OnInit()
	self.AD = self._tf:Find("AD")
	self.btnGo = self.AD:Find("title/btn_act")
	self.btnManual = self.AD:Find("TopPage/top/manual")
	self.Txtmanual = self.btnManual:Find("Text")
	self.redPoint = self.btnGo:Find("red_point")
	self.redMalPoint = self.btnManual:Find("tip")

	return
end

function AnniversaryNineMainPage:OnFirstFlush()
	if self:GetMallActOpen() then
		onButton(self, self.btnGo, function()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.MALL_MAP)

			return
		end, SFX_PANEL)
	else
		onButton(self, self.btnGo, function()
			self:emit(ActivityMediator.ON_ADD_SUBLAYER, Context.New({
				mediator = MallAwardMediator,
				viewComponent = MallAwardLayer,
				data = {
					awardHandledByParent = true,
					onExit = function()
						self:refreshRed()

						return
					end
				}
			}))

			return
		end, SFX_PANEL)
	end

	onButton(self, self.btnManual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = FujinBayMedalAlbumView
		})))

		return
	end, SFX_PANEL)
	setText(self.Txtmanual, i18n("anniversary_nine_main_page"))
	self:refreshRed()

	return
end

function AnniversaryNineMainPage:GetMallActOpen()
	local var_7_0 = self.coreActivityUI:GetActivityIdByPageClass("AnniversaryNineGamePage")
	local var_7_1 = var_7_0 and getProxy(ActivityProxy):getActivityById(var_7_0)

	return var_7_1 ~= nil and not var_7_1:isEnd()
end

function AnniversaryNineMainPage:OnUpdateFlush()
	self:refreshRed()

	return
end

function AnniversaryNineMainPage:refreshRed()
	setActive(self.redPoint, AnniversaryNineMainPage.IsMallAwardTip())

	local var_9_0, var_9_1 = AnniversaryNineMainPage.GetFujinBayMedalTaskCount()

	setActive(self.redMalPoint, var_9_1 > 0)

	return
end

function AnniversaryNineMainPage:IsShowReminder()
	return AnniversaryNineMainPage.IsTip()
end

function AnniversaryNineMainPage.IsMallAwardTip()
	local var_11_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)

	if not var_11_0 or var_11_0:isEnd() then
		return false
	end

	return MallAwardLayer.IsAwardTip() or MallAwardLayer.IsInputTip() or MallAwardLayer.IsTaskTip()
end

function AnniversaryNineMainPage.IsTip()
	return AnniversaryNineMainPage.IsMallAwardTip() or AnniversaryNineMainPage.IsFujinBayMedalTaskTip()
end

function AnniversaryNineMainPage.IsFujinBayMedalTaskTip()
	local var_13_0, var_13_1 = AnniversaryNineMainPage.GetFujinBayMedalTaskCount()

	return var_13_1 > 0
end

function AnniversaryNineMainPage.GetFujinBayMedalTaskCount()
	local var_14_0

	if pg.activity_medal_group[FujinBayMedalAlbumView.GROUP_ID] then
		var_14_0 = pg.activity_medal_group[FujinBayMedalAlbumView.GROUP_ID].activity_link or {}
	end

	local var_14_1

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_2 = getProxy(ActivityProxy):getActivityById(iter_14_1[2])

		if var_14_2 and not var_14_2:isEnd() then
			var_14_1 = iter_14_1[3]

			break
		end
	end

	if not var_14_1 then
		return 0, 0, 0
	end

	local var_14_3 = getProxy(TaskProxy)
	local var_14_4 = 0
	local var_14_5 = 0

	for iter_14_2, iter_14_3 in ipairs(var_14_1) do
		local var_14_6 = var_14_3:getTaskById(iter_14_3) or var_14_3:getFinishTaskById(iter_14_3)

		if var_14_6 then
			local var_14_7 = var_14_6:getTaskStatus()

			if var_14_7 == 1 then
				var_14_5 = var_14_5 + 1
				var_14_4 = var_14_4 + 1
			elseif var_14_7 == 2 then
				var_14_4 = var_14_4 + 1
			end
		end
	end

	return var_14_4, var_14_5, #var_14_1
end

return AnniversaryNineMainPage
