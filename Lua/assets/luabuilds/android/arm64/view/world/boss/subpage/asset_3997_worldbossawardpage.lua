local WorldBossAwardPage = class("WorldBossAwardPage", import("....base.BaseSubView"))

function WorldBossAwardPage:getUIName()
	return "WorldBossAwardUI"
end

function WorldBossAwardPage:OnLoaded()
	return
end

function WorldBossAwardPage:OnInit()
	local var_3_0 = self._tf:Find("frame/list/container1/tpl")

	self.uilist1 = UIItemList.New(self._tf:Find("frame/list/container1"), var_3_0)
	self.uilist2 = UIItemList.New(self._tf:Find("frame/list/container2"), var_3_0)

	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function WorldBossAwardPage:Update(arg_5_1)
	self.worldBoss = arg_5_1

	self:UpdateAwards()
	self:Show()

	return
end

function WorldBossAwardPage:UpdateAwards()
	local var_6_0 = self.worldBoss:GetAwards()

	local function var_6_1(arg_7_0, arg_7_1)
		local var_7_0 = {
			count = 0,
			type = var_6_0[arg_7_0 + 1][1],
			id = var_6_0[arg_7_0 + 1][2]
		}

		updateDrop(arg_7_1:Find("equipment/bg"), var_7_0)
		arg_7_1:Find("mask/name"):GetComponent("ScrollText"):SetText((var_7_0:getConfig("name")))
		onButton(self, arg_7_1, function()
			self:emit(BaseUI.ON_DROP, var_7_0)

			return
		end, SFX_PANEL)

		return
	end

	self.uilist1:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			var_6_1(arg_9_1, arg_9_2)
		end

		return
	end)
	self.uilist2:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			var_6_1(arg_10_1 + 4, arg_10_2)
		end

		return
	end)
	self.uilist1:align(math.min(#var_6_0, 4))
	self.uilist2:align(math.max(0, #var_6_0 - 4))

	return
end

function WorldBossAwardPage:OnDestroy()
	return
end

return WorldBossAwardPage
