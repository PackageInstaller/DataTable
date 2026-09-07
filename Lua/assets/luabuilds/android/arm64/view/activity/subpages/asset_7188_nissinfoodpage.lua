local NissinFoodPage = class("NissinFoodPage", import("...base.BaseActivityPage"))

function NissinFoodPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.helpBtn = self.bg:Find("help_btn")
	self.startBtn = self.bg:Find("start_btn")
	self.cupList = self.bg:Find("cup_list")

	return
end

function NissinFoodPage:OnFirstFlush()
	self.hubID = self.activity:getConfig("config_id")
	self.drop_list = self.activity:getConfig("config_client")

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("chazi_tips")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.startBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 29)

		return
	end, SFX_PANEL)

	return
end

function NissinFoodPage:OnUpdateFlush()
	local var_5_0 = getProxy(MiniGameProxy):GetHubByHubId(self.hubID)

	eachChild(self.cupList, function(arg_6_0)
		local var_6_0 = tonumber(arg_6_0.name)

		setActive(arg_6_0:Find("lock"), var_6_0 > var_5_0.count + var_5_0.usedtime)
		setActive(arg_6_0:Find("got"), var_6_0 <= var_5_0.usedtime)

		local var_6_1 = arg_6_0:Find("mask/award")
		local var_6_2 = {
			type = self.drop_list[var_6_0][1],
			id = self.drop_list[var_6_0][2],
			count = self.drop_list[var_6_0][3]
		}

		updateDrop(var_6_1, var_6_2)
		onButton(self, var_6_1, function()
			self:emit(BaseUI.ON_DROP, var_6_2)

			return
		end, SFX_PANEL)

		return
	end)

	if var_5_0.ultimate == 0 and var_5_0.usedtime >= var_5_0:getConfig("reward_need") then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_5_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

return NissinFoodPage
