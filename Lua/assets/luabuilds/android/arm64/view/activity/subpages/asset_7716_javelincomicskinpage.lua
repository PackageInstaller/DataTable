local JavelinComicSkinPage = class("JavelinComicSkinPage", import(".TemplatePage.SkinTemplatePage"))

JavelinComicSkinPage.FADE_OUT_TIME = 1

function JavelinComicSkinPage:OnFirstFlush()
	self:InitView()
	self:RegisterEvent()
	JavelinComicSkinPage.super.OnFirstFlush(self)

	return
end

function JavelinComicSkinPage:InitView()
	self.animations = {}
	self.puzzle = self.bg:Find("Puzzle")
	self.linkActId = self:GetLinkId()
	self.activityProxy = getProxy(ActivityProxy)
	self.chargeIDList = Clone(self.activityProxy:getActivityById(self.linkActId).data1_list)
	self.puzzleIDList = Clone(pg.activity_template[self.linkActId].config_data)

	self:CheckFinalAward()

	return
end

function JavelinComicSkinPage:RegisterEvent()
	self.helpBtn = self.bg:Find("HelpBtn")

	onButton(self, self.helpBtn, function()
		if pg.gametip.comic_help then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.comic_help.tip
			})
		end

		return
	end, SFX_PANEL)

	return
end

function JavelinComicSkinPage:GetLinkId()
	return pg.activity_const.JAVELIN_COMIC_PUZZLE_TASK.act_id
end

function JavelinComicSkinPage:OnUpdateFlush()
	JavelinComicSkinPage.super.OnUpdateFlush(self)

	self.linkActivity = self.activityProxy:getActivityById(self.linkActId)

	local var_6_0 = true

	for iter_6_0 = 1, #self.puzzleIDList do
		local var_6_1 = table.contains(self.linkActivity.data1_list, self.puzzleIDList[iter_6_0])

		self:UpdatePuzzle(self.puzzle:GetChild(iter_6_0 - 1), var_6_1, self.puzzleIDList[iter_6_0])

		if not var_6_1 then
			var_6_0 = false
		end
	end

	self:UpdateMainView(var_6_0)

	return
end

function JavelinComicSkinPage:UpdatePuzzle(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 and not table.contains(self.chargeIDList, arg_7_3) then
		table.insert(self.chargeIDList, arg_7_3)
		self:DoPieceAnimation(arg_7_1, 0, 1, function()
			setActive(arg_7_1, arg_7_2)
			self:CheckFinalAward()

			return
		end)
	else
		setActive(arg_7_1, arg_7_2)
	end

	return
end

function JavelinComicSkinPage:DoPieceAnimation(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if LeanTween.isTweening(arg_9_1) then
		LeanTween.cancel(go(arg_9_1), true)

		self.animations[arg_9_1] = nil
	end

	self.animations[arg_9_1] = true

	LeanTween.alpha(arg_9_1, arg_9_3, JavelinComicSkinPage.FADE_OUT_TIME):setFrom(arg_9_2):setOnComplete(System.Action(arg_9_4))

	return
end

function JavelinComicSkinPage:UpdateMainView(arg_10_1)
	setText(self.dayTF, #self.chargeIDList == #self.taskGroup and "<color=#00FF00><size=48>" .. #self.chargeIDList .. "</size></color><color=#00B8FF><size=28>     " .. #self.taskGroup .. "</size></color>" or "<color=#E75198><size=48>" .. #self.chargeIDList .. "</size></color><color=#00B8FF><size=28>     " .. #self.taskGroup .. "</size></color>")

	return
end

function JavelinComicSkinPage:OnDestroy()
	JavelinComicSkinPage.super.OnDestroy(self)

	for iter_11_0, iter_11_1 in pairs(self.animations or {}) do
		if LeanTween.isTweening(iter_11_0.gameObject) then
			LeanTween.cancel(iter_11_0.gameObject)
		end
	end

	self.animations = nil

	return
end

function JavelinComicSkinPage:CheckFinalAward()
	local var_12_0 = self.activityProxy:getActivityById(self.linkActId)

	if #var_12_0.data1_list == #self.puzzleIDList then
		if var_12_0.data1 == 0 then
			self:FetchFinalAward()
		else
			self:OnFetchFinalAwardDone()
		end
	end

	return
end

function JavelinComicSkinPage:FetchFinalAward()
	self:emit(ActivityMediator.EVENT_OPERATION, {
		cmd = 1,
		activity_id = self.linkActId
	})

	return
end

function JavelinComicSkinPage:OnFetchFinalAwardDone()
	return
end

return JavelinComicSkinPage
