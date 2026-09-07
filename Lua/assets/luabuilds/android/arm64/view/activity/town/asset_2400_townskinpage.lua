local TownSkinPage = class("TownSkinPage", import("view.base.BaseUI"))

function TownSkinPage:getUIName()
	return "TownSkinPageUI"
end

function TownSkinPage:init()
	self.activity = getProxy(ActivityProxy):getActivityById(5535)
	self.story = self.activity:getConfig("config_client").story
	self.storyStateDic = {}

	self:ShowMask(false)

	self.isPlaying = false

	self:InitStoryState()
	self:UpdateStoryView()
	self:UpdateItemView(self.activity)

	return
end

function TownSkinPage:InitStoryState()
	for iter_3_0, iter_3_1 in ipairs(self.story) do
		if checkExist(self.story, {
			iter_3_0
		}, {
			1
		}) then
			self.storyStateDic[pg.NewStoryMgr.GetInstance():StoryName2StoryId(iter_3_1[1])] = not not pg.NewStoryMgr.GetInstance():IsPlayed(iter_3_1[1])
		end
	end

	return
end

function TownSkinPage:UpdateStoryView()
	for iter_4_0, iter_4_1 in ipairs({
		"pittsburgh",
		"indiana",
		"fargo",
		"kersaint",
		"friedrich",
		"painleve"
	}) do
		local var_4_0 = pg.NewStoryMgr.GetInstance()
		local var_4_1 = var_4_0:StoryName2StoryId(self.story[iter_4_0][1])
		local var_4_2 = self._tf:Find("frame/bg/" .. iter_4_1 .. "/locked")
		local var_4_3 = self._tf:Find("frame/bg/" .. iter_4_1 .. "/unlocked")

		setActive(var_4_0, not self.storyStateDic[var_4_1])
		setActive(var_4_3, self.storyStateDic[var_4_1])

		if self.storyStateDic[var_4_1] then
			onButton(self, var_4_3, function()
				pg.NewStoryMgr.GetInstance():Play(pg.NewStoryMgr.GetInstance():StoryId2StoryName(var_4_1), nil, true)

				return
			end)
		else
			onButton(self, var_4_2, function()
				if getProxy(ActivityProxy):getActivityById(5535).data1 <= 0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("activity_0815_town_memory"))

					return
				end

				pg.m02:sendNotification(GAME.ACTIVITY_UNLOCKSTORY, {
					cmd = 1,
					activity_id = self.activity.id,
					arg1 = var_4_1
				})

				return
			end)
		end
	end

	return
end

function TownSkinPage:UpdateItemView(arg_7_1)
	setText(self._tf:Find("frame/des/count"), tostring(arg_7_1.data1))

	return
end

function TownSkinPage:UpdataStoryState(arg_8_1)
	local var_8_0 = arg_8_1.storyId

	self.storyStateDic[arg_8_1.storyId] = true

	local var_8_1 = 0

	for iter_8_0, iter_8_1 in ipairs(self.story) do
		if pg.NewStoryMgr.GetInstance():StoryName2StoryId(iter_8_1[1]) == arg_8_1.storyId then
			var_8_1 = iter_8_0
		end
	end

	for iter_8_2, iter_8_3 in ipairs({
		"pittsburgh",
		"indiana",
		"fargo",
		"kersaint",
		"friedrich",
		"painleve"
	}) do
		if iter_8_2 == var_8_1 then
			local var_8_2 = self.storyStateDic[arg_8_1.storyId]
			local var_8_3 = self._tf:Find("frame/bg/" .. iter_8_3 .. "/locked")
			local var_8_4 = self._tf:Find("frame/bg/" .. iter_8_3 .. "/unlocked")
			local var_8_5 = var_8_3:GetComponent(typeof(Animation))
			local var_8_6 = var_8_5:GetClip("anim_cowboy_skin_fargo_unlock").length

			var_8_5:Play("anim_cowboy_skin_fargo_unlock")
			self:ShowMask(true)

			self.isPlaying = true

			onDelayTick(function()
				self.isPlaying = false

				self:ShowMask(false)
				setActive(var_8_3, not var_8_2)
				setActive(var_8_4, var_8_2)
				pg.NewStoryMgr.GetInstance():Play(pg.NewStoryMgr.GetInstance():StoryId2StoryName(var_8_0))

				return
			end, var_8_6)

			if self.storyStateDic[arg_8_1.storyId] then
				onButton(self, var_8_4, function()
					pg.NewStoryMgr.GetInstance():Play(pg.NewStoryMgr.GetInstance():StoryId2StoryName(var_8_0), nil, true)

					return
				end)
			else
				onButton(self, var_8_3, function()
					if getProxy(ActivityProxy):getActivityById(5535).data1 <= 0 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("activity_0815_town_memory"))

						return
					end

					pg.m02:sendNotification(GAME.ACTIVITY_UNLOCKSTORY, {
						cmd = 1,
						activity_id = self.activity.id,
						arg1 = var_8_0
					})

					return
				end)
			end
		end
	end

	return
end

function TownSkinPage:didEnter()
	onButton(self, self._tf:Find("frame/back"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("bg"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("frame/des/itemDes"), function()
		self:emit(BaseUI.ON_DROP, {
			type = DROP_TYPE_VITEM,
			id = self.activity:getConfig("config_id"),
			count = getProxy(ActivityProxy):getActivityById(5535).data1
		})

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function TownSkinPage:ShowMask(arg_16_1)
	GetOrAddComponent(self._tf:Find("mask"), typeof(CanvasGroup)).blocksRaycasts = arg_16_1

	return
end

function TownSkinPage:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function TownSkinPage:onBackPressed()
	if self.isPlaying then
		return
	end

	self.super.onBackPressed(self)

	return
end

return TownSkinPage
