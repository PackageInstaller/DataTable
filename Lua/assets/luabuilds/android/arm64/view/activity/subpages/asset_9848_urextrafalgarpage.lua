local UrExTrafalgarPage = class("UrExTrafalgarPage", import(".TemplatePage.UrExchangeTemplatePage"))
local var_0_1 = pg.activity_holiday_site

function UrExTrafalgarPage:OnInit()
	UrExTrafalgarPage.super.OnInit(self)

	self.icon = self._tf:Find("AD/icon")
	self.taskTypeDic = setmetatable({
		[UrExTrafalgarPage.MINI_GAME] = function(arg_2_0, arg_2_1)
			local var_2_0 = arg_2_1[1]
			local var_2_1 = getProxy(MiniGameProxy):GetHubByGameId(arg_2_1[1]).count == 0

			return var_2_1 and "1/1" or "0/1", not var_2_1 and function()
				if getProxy(TaskProxy):getFinishTaskById(var_0_1[getProxy(ActivityProxy):getActivityById(ActivityConst.HOLIDAY_ACT_ID):getConfig("config_client").function_id[1]].task_id) then
					arg_2_0:emit(ActivityMediator.GO_MINI_GAME, var_2_0)
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_minigame_unlock"))
				end

				return
			end or nil
		end
	}, {
		__index = self.taskTypeDic
	})

	return
end

function UrExTrafalgarPage:OnFirstFlush()
	UrExTrafalgarPage.super.OnFirstFlush(self)
	setActive(self._tasksTF, false)
	setActive(self.icon, false)
	setActive(self._btnHelp, false)

	return
end

function UrExTrafalgarPage:OnUpdateFlush()
	UrExTrafalgarPage.super.OnUpdateFlush(self)
	setGray(self._btnExchange, true, true)

	return
end

return UrExTrafalgarPage
