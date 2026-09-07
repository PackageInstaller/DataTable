local BeatMonsterMeidator = class("BeatMonsterMeidator")
local var_0_1 = 1
local var_0_2 = 0.1
local var_0_3 = 1

function BeatMonsterMeidator:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self.controller = arg_1_1

	return
end

function BeatMonsterMeidator:SetUI(arg_2_1)
	self._go = arg_2_1
	self._tf = tf(arg_2_1)
	self.monsterNian = self._tf:Find("AD/monster")
	self.fushun = self._tf:Find("AD/fushun")
	self.hpTF = self._tf:Find("AD/hp"):GetComponent(typeof(Slider))
	self.attackCntTF = self._tf:Find("AD/attack_count/Text"):GetComponent(typeof(Text))
	self.actions = self._tf:Find("AD/actions")
	self.actionKeys = {
		self.actions:Find("content/1"),
		self.actions:Find("content/2"),
		self.actions:Find("content/3")
	}
	self.curtainTF = self._tf:Find("AD/curtain")
	self.startLabel = self.curtainTF:Find("start_label")
	self.ABtn = self._tf:Find("AD/A_btn")
	self.BBtn = self._tf:Find("AD/B_btn")
	self.joyStick = self._tf:Find("AD/joyStick")

	return
end

function BeatMonsterMeidator:DoCurtainUp(arg_3_1)
	local var_3_0 = getProxy(SettingsProxy)

	if var_3_0:IsShowBeatMonseterNianCurtain() then
		var_3_0:SetBeatMonseterNianFlag()
		self:StartCurtainUp(arg_3_1)
	else
		arg_3_1()
	end

	return
end

function BeatMonsterMeidator:StartCurtainUp(arg_4_1)
	setActive(self.curtainTF, true)
	LeanTween.color(self.curtainTF, Color.white, var_0_1):setFromColor(Color.black):setOnComplete(System.Action(function()
		setActive(self.startLabel, true)
		blinkAni(self.startLabel, var_0_2, 2):setOnComplete(System.Action(function()
			LeanTween.alpha(self.curtainTF, 0, var_0_3):setFrom(1)
			LeanTween.alpha(self.startLabel, 0, var_0_3):setFrom(1):setOnComplete(System.Action(arg_4_1))

			return
		end))

		return
	end))

	return
end

function BeatMonsterMeidator:OnInited()
	local function var_7_0()
		if self.attackCnt <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("activity_hit_monster_nocount"))

			return false
		end

		if self.hp <= 0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("activity_hit_monster_reset_tip"),
				onYes = function()
					self.controller:ReStartGame()

					return
				end
			})

			return false
		end

		return true
	end

	self:OnTrigger(self.ABtn, var_7_0, function()
		self.controller:Input(BeatMonsterNianConst.ACTION_NAME_A)

		return
	end)
	self:OnTrigger(self.BBtn, var_7_0, function()
		self.controller:Input(BeatMonsterNianConst.ACTION_NAME_B)

		return
	end)
	self:OnJoyStickTrigger(self.joyStick, var_7_0, function(arg_12_0)
		if arg_12_0 > 0 then
			self.controller:Input(BeatMonsterNianConst.ACTION_NAME_R)
		elseif arg_12_0 < 0 then
			self.controller:Input(BeatMonsterNianConst.ACTION_NAME_L)
		end

		return
	end)

	return
end

function BeatMonsterMeidator:OnAttackCntUpdate(arg_13_1, arg_13_2)
	self.attackCnt = arg_13_1
	self.attackCntTF.text = arg_13_2 and "-" or arg_13_1

	return
end

function BeatMonsterMeidator:OnMonsterHpUpdate(arg_14_1)
	self.hp = arg_14_1

	self.fuShun:SetInteger("hp", arg_14_1)
	self.nian:SetInteger("hp", arg_14_1)

	return
end

function BeatMonsterMeidator:OnUIHpUpdate(arg_15_1, arg_15_2, arg_15_3)
	LeanTween.value(self.hpTF.gameObject, self.hpTF.value, arg_15_1 / arg_15_2, 0.3):setOnUpdate(System.Action_float(function(arg_16_0)
		self.hpTF.value = arg_16_0

		return
	end)):setOnComplete(System.Action(function()
		if arg_15_3 then
			arg_15_3()
		end

		return
	end))

	return
end

function BeatMonsterMeidator:OnAddFuShun(arg_18_1)
	self.fuShun = self.fushun:GetComponent(typeof(Animator))

	self.fuShun:SetInteger("hp", arg_18_1)

	return
end

function BeatMonsterMeidator:OnAddMonsterNian(arg_19_1, arg_19_2)
	self.hp = arg_19_1
	self.nian = self.monsterNian:GetComponent(typeof(Animator))
	self.hpTF.value = arg_19_1 / arg_19_2

	self.nian:SetInteger("hp", arg_19_1)

	return
end

function BeatMonsterMeidator:OnChangeFuShunAction(arg_20_1)
	self.fuShun:SetTrigger(arg_20_1)

	return
end

function BeatMonsterMeidator:OnChangeNianAction(arg_21_1)
	self.nian:SetTrigger(arg_21_1)

	return
end

function BeatMonsterMeidator:BanJoyStick(arg_22_1)
	setActive(self.joyStick:Find("ban"), arg_22_1)

	GetOrAddComponent(self.joyStick, typeof(EventTriggerListener)).enabled = not arg_22_1

	return
end

function BeatMonsterMeidator:OnInputChange(arg_23_1)
	local var_23_0 = arg_23_1 and arg_23_1 ~= ""

	if arg_23_1 and arg_23_1 ~= "" then
		for iter_23_0, iter_23_1 in ipairs(self.actionKeys) do
			local var_23_1 = string.sub(arg_23_1, iter_23_0, iter_23_0) or ""

			setActive(iter_23_1:Find("A"), var_23_1 == BeatMonsterNianConst.ACTION_NAME_A)
			setActive(iter_23_1:Find("L"), var_23_1 == BeatMonsterNianConst.ACTION_NAME_L)
			setActive(iter_23_1:Find("R"), var_23_1 == BeatMonsterNianConst.ACTION_NAME_R)
			setActive(iter_23_1:Find("B"), var_23_1 == BeatMonsterNianConst.ACTION_NAME_B)
		end
	end

	setActive(self.actions, var_23_0)
	self:BanJoyStick(#arg_23_1 == 2)

	return
end

function BeatMonsterMeidator:PlayStory(arg_24_1, arg_24_2)
	pg.NewStoryMgr.GetInstance():Play(arg_24_1, arg_24_2)

	return
end

function BeatMonsterMeidator:DisplayAwards(arg_25_1, arg_25_2)
	pg.m02:sendNotification(ActivityProxy.ACTIVITY_SHOW_AWARDS, {
		awards = arg_25_1,
		callback = arg_25_2
	})

	return
end

function BeatMonsterMeidator:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

function BeatMonsterMeidator:OnTrigger(arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_1:Find("off")
	local var_27_1 = true
	local var_27_2 = GetOrAddComponent(arg_27_1, typeof(EventTriggerListener))

	var_27_2:AddPointDownFunc(function(arg_28_0, arg_28_1)
		var_27_1 = arg_27_2()

		if var_27_1 then
			setActive(var_27_0, false)
		end

		return
	end)
	var_27_2:AddPointUpFunc(function(arg_29_0, arg_29_1)
		if var_27_1 then
			setActive(var_27_0, true)

			if arg_27_3 then
				arg_27_3()
			end
		end

		return
	end)

	return
end

function BeatMonsterMeidator:OnJoyStickTrigger(arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_1:Find("m")
	local var_30_1 = arg_30_1:Find("l")
	local var_30_2 = arg_30_1:Find("r")
	local var_30_3 = GetOrAddComponent(arg_30_1, typeof(EventTriggerListener))
	local var_30_4
	local var_30_5 = false

	var_30_3:AddBeginDragFunc(function(arg_31_0, arg_31_1)
		var_30_5 = arg_30_2()
		var_30_4 = arg_31_1.position

		return
	end)
	var_30_3:AddDragFunc(function(arg_32_0, arg_32_1)
		if not var_30_5 then
			return
		end

		local var_32_0 = arg_32_1.position.x - var_30_4.x

		setActive(var_30_0, arg_32_1.position.x - var_30_4.x == 0)
		setActive(var_30_1, var_32_0 < 0)
		setActive(var_30_2, var_32_0 > 0)

		return
	end)
	var_30_3:AddDragEndFunc(function(arg_33_0, arg_33_1)
		if not var_30_5 then
			return
		end

		arg_30_3(arg_33_1.position.x - var_30_4.x)
		setActive(var_30_0, true)
		setActive(var_30_1, false)
		setActive(var_30_2, false)

		return
	end)

	return
end

return BeatMonsterMeidator
