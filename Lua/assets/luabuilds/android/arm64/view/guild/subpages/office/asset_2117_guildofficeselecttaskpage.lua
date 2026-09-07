local GuildOfficeSelectTaskPage = class("GuildOfficeSelectTaskPage", import("...base.GuildBasePage"))

function GuildOfficeSelectTaskPage:getTargetUI()
	return "GuildTaskSelectBluePage", "GuildTaskSelectRedPage"
end

function GuildOfficeSelectTaskPage:OnLoaded()
	self.uilist = UIItemList.New(self._tf:Find("frame/bg/scrollrect/content"), self._tf:Find("frame/bg/scrollrect/content/tpl"))
	self.closeBtn = self._tf:Find("frame/title/close")

	return
end

function GuildOfficeSelectTaskPage:OnInit()
	onButton(self, self._tf, function()
		self:Close()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Close()

		return
	end, SFX_PANEL)

	return
end

function GuildOfficeSelectTaskPage:Show(arg_6_1, arg_6_2)
	self.guild = arg_6_1
	self.isAdmin = arg_6_2

	setActive(self._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self._tf:SetAsLastSibling()
	self:Update()

	return
end

function GuildOfficeSelectTaskPage:Update()
	local var_7_0 = self.guild:getSelectableWeeklyTasks()

	self.uilist:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = GuildTaskCard.New(arg_8_2)
			local var_8_1 = var_7_0[arg_8_1 + 1]

			onButton(self, var_8_0.acceptBtn, function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("guild_task_selecte_tip", var_8_1:getConfig("name")),
					onYes = function()
						self:emit(GuildOfficeMediator.ON_SELECT_TASK, var_8_0.task.id)
						self:Close()

						return
					end
				})

				return
			end, SFX_PANEL)
			var_8_0:Update(var_7_0[arg_8_1 + 1])
		end

		return
	end)
	self.uilist:align(#var_7_0)

	return
end

function GuildOfficeSelectTaskPage:Close()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	setActive(self._tf, false)

	return
end

function GuildOfficeSelectTaskPage:OnDestroy()
	self:Close()

	return
end

return GuildOfficeSelectTaskPage
