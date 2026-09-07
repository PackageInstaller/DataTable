local IJNUranamiPileGamePage = class("IJNUranamiPileGamePage", import("view.base.BaseActivityPage"))

IJNUranamiPileGamePage.MINIGAME_HUB_ID = 39
IJNUranamiPileGamePage.MINIGAME_ID = 47

function IJNUranamiPileGamePage:OnInit()
	self.goBtn = self._tf:Find("AD/go")
	self.indexTpl = self._tf:Find("AD/index")
	self.markContainer = self._tf:Find("AD/marks")
	self.markTpl = self._tf:Find("AD/marks/1")
	self.markTrs = {}

	for iter_1_0 = 1, 7 do
		table.insert(self.markTrs, (cloneTplTo(self.markTpl, self.markContainer, iter_1_0)))
	end

	return
end

function IJNUranamiPileGamePage:OnDataSetting()
	return
end

function IJNUranamiPileGamePage:OnFirstFlush()
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, IJNUranamiPileGamePage.MINIGAME_ID)

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(MiniGameProxy):GetHubByHubId(IJNUranamiPileGamePage.MINIGAME_HUB_ID)

	self:FlushMarks(var_3_0)
	Canvas.ForceUpdateCanvases()
	self:FlushIndex(var_3_0)

	return
end

function IJNUranamiPileGamePage:FlushMarks(arg_5_1)
	local var_5_0 = arg_5_1.usedtime + arg_5_1.count

	for iter_5_0, iter_5_1 in ipairs(self.markTrs) do
		setActive(iter_5_1, iter_5_0 <= var_5_0)
		setActive(iter_5_1:Find("finish"), iter_5_0 <= arg_5_1.usedtime)
	end

	return
end

function IJNUranamiPileGamePage:FlushIndex(arg_6_1)
	setActive(self.indexTpl, arg_6_1.usedtime > 0)

	if arg_6_1.usedtime > 0 then
		local var_6_0 = self.indexTpl.parent:InverseTransformPoint(self.markTrs[math.min(arg_6_1.usedtime, #self.markTrs)].position)

		self.indexTpl.localPosition = Vector3(var_6_0.x, var_6_0.y, 0)
	end

	return
end

function IJNUranamiPileGamePage:OnUpdateFlush()
	return
end

function IJNUranamiPileGamePage:OnDestroy()
	return
end

return IJNUranamiPileGamePage
