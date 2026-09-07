local LinkDunHuangPage = class("LinkDunHuangPage", import(".JavelinComicSkinPage"))

function LinkDunHuangPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.item = self.bg:Find("items/item")
	self.items = self.bg:Find("items")
	self.uilist = UIItemList.New(self.items, self.item)
	self.bgImg = self.bg:GetComponent(typeof(Image))
	self.isReplaceBG = false

	return
end

function LinkDunHuangPage:GetLinkId()
	return self.activity:getConfig("config_client").link_act
end

function LinkDunHuangPage:UpdatePuzzle(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 and not table.contains(self.chargeIDList, arg_3_3) then
		table.insert(self.chargeIDList, arg_3_3)
		self:DoPieceAnimation(arg_3_1, 1, 0, function()
			setActive(arg_3_1, not arg_3_2)
			self:CheckFinalAward()

			return
		end)
	else
		setActive(arg_3_1, not arg_3_2)
	end

	return
end

function LinkDunHuangPage:DoPieceAnimation(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if LeanTween.isTweening(arg_5_1) then
		LeanTween.cancel(go(arg_5_1), true)

		self.animations[arg_5_1] = nil
	end

	pg.UIMgr.GetInstance():LoadingOn(false)

	self.animations[arg_5_1] = true

	LeanTween.value(arg_5_1.gameObject, 1, 0, 1):setOnUpdate(System.Action_float(function(arg_6_0)
		setFillAmount(arg_5_1, arg_6_0)

		return
	end)):setFrom(1):setOnComplete(System.Action(function()
		pg.UIMgr.GetInstance():LoadingOff()
		arg_5_4()

		return
	end))

	return
end

function LinkDunHuangPage:RegisterEvent()
	return
end

function LinkDunHuangPage:UpdateMainView(arg_9_1)
	if arg_9_1 and not self.isReplaceBG then
		self:ReplaceBg()
	end

	return
end

function LinkDunHuangPage:PlayStory()
	return
end

function LinkDunHuangPage:FetchFinalAward()
	LinkDunHuangPage.super.FetchFinalAward(self)

	local var_11_0 = self.activity:getConfig("config_client").story[self.nday] or {}

	if var_11_0[1] then
		pg.NewStoryMgr.GetInstance():Play(var_11_0[1])
	end

	return
end

function LinkDunHuangPage:OnFetchFinalAwardDone()
	local var_12_0 = {}
	local var_12_1 = self.activity:getConfig("config_client").story

	for iter_12_0, iter_12_1 in ipairs(var_12_1 or {}) do
		local var_12_2 = var_12_1[iter_12_0] or {}

		if var_12_2[1] then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(var_12_2[1]) then
				table.insert(var_12_0, var_12_2[1])
			end
		end
	end

	pg.NewStoryMgr.GetInstance():SeriesPlay(var_12_0)

	return
end

function LinkDunHuangPage:ReplaceBg()
	self.isReplaceBG = true
	self.bgImg.sprite = GetSpriteFromAtlas("ui/activityuipage/LinkDunhuangPage_atlas", "bg_finish")

	return
end

return LinkDunHuangPage
