local SSSSPtPage = class("SSSSPtPage", import(".TemplatePage.PtTemplatePage"))
local var_0_1 = {
	{
		11,
		1.5
	},
	{
		19,
		2
	},
	{
		25,
		3
	},
	{
		28,
		4
	}
}
local var_0_2 = 0.25
local var_0_3 = 20
local var_0_4 = 20
local var_0_5 = 0.75
local var_0_6 = 3
local var_0_7 = 0.75
local var_0_8 = 5
local var_0_9 = "he"

function SSSSPtPage:OnInit()
	SSSSPtPage.super.OnInit(self)

	self.maskNode = self.bg:Find("mask")
	self.role = self.maskNode:Find("role")
	self.food = self.maskNode:Find("food")
	self.monster = self.maskNode:Find("monster")
	self.reflectNode = self.maskNode:Find("reflection")
	self.monsterReflect = self.reflectNode:Find("monster_reflection")
	self.roleReflect = self.reflectNode:Find("role_reflection")
	self.feedBtn = self.bg:Find("feed_btn")
	self.window = self._tf:Find("window")
	self.monsterAni = GetComponent(self.window:Find("panel/monster"), typeof(Animator))
	self.spineRole = self.window:Find("panel/spinechar")
	self.spriteRole = self.window:Find("panel/spritechar")
	self.isPlaying = false
	self.coutinuePlay = {}

	return
end

function SSSSPtPage:OnFirstFlush()
	SSSSPtPage.super.OnFirstFlush(self)
	setActive(self.window, false)
	onButton(self, self.monster, function()
		if self.monster.localScale.x == var_0_1[#var_0_1][2] then
			self:OpenMonsterWin()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.window:Find("close"), function()
		setActive(self.window, false)

		return
	end, SFX_PANEL)
	onButton(self, self.window:Find("close_btn"), function()
		setActive(self.window, false)

		return
	end, SFX_PANEL)
	onButton(self, self.feedBtn, function()
		local var_6_0 = {}
		local var_6_1 = self.ptData:GetAward()
		local var_6_2 = getProxy(PlayerProxy):getRawData()
		local var_6_3, var_6_4 = Task.StaticJudgeOverflow(var_6_2.gold, var_6_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
			{
				var_6_1.type,
				var_6_1.id,
				var_6_1.count
			}
		})

		if var_6_3 then
			table.insert(var_6_0, function(arg_7_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_6_4,
					onYes = arg_7_0
				})

				return
			end)
		end

		seriesAsync(var_6_0, function()
			local var_8_0, var_8_1 = self.ptData:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = var_8_1,
				callback = function()
					self:PlayFeedAni()

					return
				end
			})

			return
		end)

		return
	end, SFX_PANEL)
	setActive(self.bg:Find("blink_effect"), true)
	self:UpdateMonster()

	return
end

function SSSSPtPage:OnUpdateFlush()
	SSSSPtPage.super.OnUpdateFlush(self)

	local var_10_0, var_10_1, var_10_2 = self.ptData:GetLevelProgress()
	local var_10_3, var_10_4, var_10_5 = self.ptData:GetResProgress()

	setText(self.step, setColorStr(var_10_0, "#f0dbff") .. "/" .. var_10_1)
	setText(self.progress, (var_10_5 >= 1 and setColorStr(var_10_3, "#f0dbff") or var_10_3) .. "/" .. var_10_4)

	if isActive(self.getBtn) and self:IsSpecialPhase() then
		setActive(self.getBtn, false)
		setActive(self.feedBtn, true)
	else
		setActive(self.feedBtn, false)
	end

	return
end

function SSSSPtPage:IsSpecialPhase()
	local var_11_0 = self.ptData:GetLevelProgress()
	local var_11_1 = false

	for iter_11_0, iter_11_1 in ipairs(var_0_1) do
		if var_11_0 == iter_11_1[1] then
			var_11_1 = true
		end
	end

	return var_11_1
end

function SSSSPtPage:GetMonsterScale(arg_12_1)
	local var_12_0 = 1

	for iter_12_0, iter_12_1 in ipairs(var_0_1) do
		if arg_12_1 > iter_12_1[1] then
			var_12_0 = iter_12_1[2]
		end
	end

	return var_12_0
end

function SSSSPtPage:UpdateMonster()
	local var_13_0 = self:GetMonsterScale((self.ptData:GetLevelProgress()))

	setLocalScale(self.monster, Vector2(var_13_0, var_13_0))
	setLocalScale(self.monsterReflect, Vector2(var_13_0, var_13_0))

	return
end

function SSSSPtPage:PlayFeedAni()
	if self.isPlaying then
		table.insert(self.coutinuePlay, self.ptData:GetLevelProgress() - 1)

		return
	end

	self.isPlaying = true

	self:managedTween(LeanTween.moveX, function()
		self:PlayThrowFoodAni(function()
			self:PlayMonsterAni()

			return
		end)

		return
	end, self.role, self.role.localPosition.x + var_0_3, var_0_2):setLoopPingPong(1)

	return
end

function SSSSPtPage:PlayThrowFoodAni(arg_17_1)
	local var_17_0 = Vector2(280, -70)
	local var_17_1 = Vector2(500, -70)
	local var_17_2 = 1
	local var_17_3 = (var_17_1.x - var_17_0.x) / var_0_6
	local var_17_4 = (var_17_1.y - var_17_0.y) / var_0_6

	setLocalPosition(self.food, var_17_0)
	setActive(self.food, true)

	self.foodTimer = Timer.New(function()
		setLocalPosition(self.food, (Vector2(var_17_0.x + var_17_3 * var_17_2, var_17_0.y + var_17_4 * var_17_2)))

		if var_17_2 == var_0_6 then
			self.foodTimer:Stop()
			setActive(self.food, false)

			if arg_17_1 then
				arg_17_1()
			end
		else
			var_17_2 = var_17_2 + 1
		end

		return
	end, var_0_5 / var_0_6, var_0_6)

	self.foodTimer:Start()

	return
end

function SSSSPtPage:PlayMonsterAni()
	local var_19_0 = self.monster.localScale.x
	local var_19_1

	if self.coutinuePlay[1] then
		var_19_1 = self.coutinuePlay[1]

		if not self.coutinuePlay[1] then
			var_19_1 = self.ptData:GetLevelProgress()

			local var_19_2 = 1
		end
	end

	local var_19_3 = (self:GetMonsterScale(var_19_1) - var_19_0) / var_0_8

	setLocalScale(self.monster, Vector2(var_19_0, var_19_0))
	setLocalScale(self.monsterReflect, Vector2(var_19_0, var_19_0))

	self.monsterTimer = Timer.New(function()
		local var_20_0 = Vector2(var_19_0 + var_19_3 * var_19_2, var_19_0 + var_19_3 * var_19_2)

		setLocalScale(self.monster, var_20_0)
		setLocalScale(self.monsterReflect, var_20_0)

		if var_19_2 == var_0_8 then
			self.monsterTimer:Stop()

			self.monsterTimer = nil
			self.isPlaying = false

			if #self.coutinuePlay > 0 then
				table.remove(self.coutinuePlay, 1)
				self:PlayFeedAni()
			end
		else
			var_19_2 = var_19_2 + 1
		end

		return
	end, var_0_7 / var_0_8, var_0_8)

	self:managedTween(LeanTween.moveX, function()
		self:managedTween(LeanTween.moveY, function()
			self.monsterTimer:Start()

			return
		end, self.monster, self.monster.localPosition.y + var_0_4, var_0_2):setLoopPingPong(2)

		return
	end, self.monster, self.monster.localPosition.x + var_0_3, var_0_2):setLoopPingPong(2)

	return
end

function SSSSPtPage:OpenMonsterWin()
	setActive(self.window, true)
	self.monsterAni:Play("ATK")
	setLocalPosition(self.spriteRole, Vector2(-180, -115))

	if LeanTween.isTweening(go(self.spriteRole)) then
		LeanTween.cancel(go(self.spriteRole))
	end

	self:managedTween(LeanTween.moveX, nil, self.spriteRole, self.spriteRole.localPosition.x + 20, 0.8):setLoopPingPong()

	return
end

function SSSSPtPage:OnHideFlush()
	setActive(self.window, false)

	return
end

function SSSSPtPage:OnDestroy()
	self:cleanManagedTween()

	if self.foodTimer then
		self.foodTimer:Stop()

		self.foodTimer = nil
	end

	if self.monsterTimer then
		self.monsterTimer:Stop()

		self.monsterTimer = nil
	end

	if self.model then
		PoolMgr.GetInstance():ReturnSpineChar(var_0_9, self.model)

		self.model = nil
	end

	return
end

return SSSSPtPage
