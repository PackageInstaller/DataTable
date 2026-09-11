local ShiningMagicPacmanPage = class("ShiningMagicPacmanPage", import("view.activity.CorePage.CoreActivityPage"))

function ShiningMagicPacmanPage:OnInit()
	self.AD = self._tf:Find("AD")
	self.btnGo = self.AD:Find("btn_act")
	self.btnManual = self.AD:Find("TopPage/top/manual")
	self.Txtmanual = self.btnManual:Find("Text")
	self.redPoint = self.btnGo:Find("red_point")
	self.redMalPoint = self.btnManual:Find("tip")

	return
end

function ShiningMagicPacmanPage:OnFirstFlush()
	local var_2_0 = self.activity:getConfig("config_client").medal_group_id
	local var_2_1 = self.coreActivityUI:GetActivityIdByPageClass("ShiningMagicInvitationPage")

	if self:GetMallActOpen() then
		onButton(self, self.btnGo, function()
			local var_3_0 = getProxy(ActivityProxy):getActivityById(var_2_1)

			if not (not var_3_0 or var_3_0:isEnd()) then
				updateActivityTaskStatus(var_3_0)

				local var_3_1, var_3_2 = getActivityTask(var_3_0, true)

				if var_3_1 and var_3_2 and not var_3_2:isFinish() then
					pg.m02:sendNotification(GAME.UPDATE_TASK_PROGRESS, {
						taskId = var_3_1
					})
				end
			end

			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.REVERSE_PACMAN_HOME)

			return
		end, SFX_PANEL)
	else
		onButton(self, self.btnGo, function()
			self:emit(ActivityMediator.ON_ADD_SUBLAYER, Context.New({
				mediator = ReversePacmanTaskMediator,
				viewComponent = ReversePacmanTaskScene,
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
			viewComponent = self:GetMedalGropClassById(var_2_0)
		})))

		return
	end, SFX_PANEL)
	setText(self.Txtmanual, i18n("anniversary_nine_main_page"))
	self:refreshRed()

	return
end

function ShiningMagicPacmanPage:GetMallActOpen()
	local var_7_0 = ReversePacmanTools.GetActivity()

	return var_7_0 ~= nil and not var_7_0:isEnd()
end

function ShiningMagicPacmanPage:OnUpdateFlush()
	self:refreshRed()

	return
end

function ShiningMagicPacmanPage:refreshRed()
	local var_9_0 = self.activity:getConfig("config_client")

	if var_9_0.is_showMedal then
		setActive(self.redMalPoint, ActivityMedalGroup.showTip(var_9_0.medal_group_id))
	end

	setActive(self.redPoint, ReversePacmanTools.GetActivity():readyToAchieve())

	return
end

function ShiningMagicPacmanPage:GetMedalGropClassById(arg_10_1)
	return _G[pg.activity_medal_group[arg_10_1].ui_prefab.scene]
end

return ShiningMagicPacmanPage
