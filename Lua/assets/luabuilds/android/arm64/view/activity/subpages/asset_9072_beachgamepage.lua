local BeachGamePage = class("BeachGamePage", import("view.base.BaseActivityPage"))

BeachGamePage.MINIGAME_HUB_ID = 37
BeachGamePage.MINIGAME_ID = 44

function BeachGamePage:OnInit()
	self.goBtn = self._tf:Find("AD/go")
	self.indexTpl = self._tf:Find("AD/index")
	self.markContainer = self._tf:Find("AD/marks")
	self.markTpl = self._tf:Find("AD/marks/1")
	self.markTrs = {}

	for iter_1_0 = 1, 7 do
		local var_1_0 = cloneTplTo(self.markTpl, self.markContainer, iter_1_0)

		setActive(var_1_0:Find("open"), iter_1_0 ~= 7)
		setActive(var_1_0:Find("openL"), iter_1_0 == 7)
		table.insert(self.markTrs, var_1_0)
	end

	return
end

function BeachGamePage:OnDataSetting()
	return
end

function BeachGamePage:OnFirstFlush()
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, BeachGamePage.MINIGAME_ID)

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(MiniGameProxy):GetHubByHubId(BeachGamePage.MINIGAME_HUB_ID)

	self:FlushMarks(var_3_0)
	Canvas.ForceUpdateCanvases()
	self:FlushIndex(var_3_0)

	return
end

function BeachGamePage:FlushMarks(arg_5_1)
	local var_5_0 = arg_5_1.usedtime + arg_5_1.count

	for iter_5_0, iter_5_1 in ipairs(self.markTrs) do
		setActive(iter_5_1, iter_5_0 <= var_5_0)
		setActive(iter_5_1:Find("finish"), iter_5_0 <= arg_5_1.usedtime and iter_5_0 ~= 7)
		setActive(iter_5_1:Find("finishL"), iter_5_0 <= arg_5_1.usedtime and iter_5_0 == 7)
	end

	return
end

function BeachGamePage:FlushIndex(arg_6_1)
	setActive(self.indexTpl, arg_6_1.usedtime > 0)

	if arg_6_1.usedtime > 0 then
		local var_6_0 = self.indexTpl.parent:InverseTransformPoint(self.markTrs[math.min(arg_6_1.usedtime, #self.markTrs)].position)

		self.indexTpl.localPosition = Vector3(var_6_0.x, var_6_0.y, 0)
	end

	return
end

function BeachGamePage:OnUpdateFlush()
	return
end

function BeachGamePage:OnDestroy()
	return
end

return BeachGamePage
