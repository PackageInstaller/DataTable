local var_0_0 = class("TransitionSkillSlotsModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.isInSlotView = arg_1_2 or false

	arg_1_0:Init()

	if arg_1_2 then
		arg_1_0.slotRootObj_:GetComponent(typeof(Animator)).enabled = false
	end
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:BuildContext()

	arg_3_0.ringController_ = arg_3_0.discCon_:GetController("default0")
	arg_3_0.itemController_ = arg_3_0.itemCon_:GetController("default0")

	local var_3_0 = not arg_3_0.isInSlotView

	arg_3_0.ringController_:SetSelectedState(var_3_0 and "B" or "A")
	arg_3_0.itemController_:SetSelectedState(var_3_0 and "open" or "close")
end

function var_0_0.BuildContext(arg_4_0)
	arg_4_0.constVar = {
		selectLocked = false,
		slotPrefix = "slot%dObj_",
		jumpDuration = 0.5,
		showLocked = true,
		animLocked = true
	}
	arg_4_0.slots = {}

	for iter_4_0 = 1, 6 do
		local var_4_0 = TransitionSkilSlotItem.New(arg_4_0[string.format(arg_4_0.constVar.slotPrefix, iter_4_0)], arg_4_0.isInSlotView)

		arg_4_0.slots[iter_4_0] = {
			viewModule = var_4_0
		}

		var_4_0:RenderPosition(iter_4_0)
		var_4_0:RegisterClickListener(handler(arg_4_0, arg_4_0.OnSlotClick))
	end

	arg_4_0.data = {
		slotIdx = 1,
		heroID = 0,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		slotContext = {
			slots = {}
		}
	}
end

function var_0_0.InitContext(arg_5_0)
	arg_5_0.data = {
		slotIdx = 1,
		heroID = 0,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		slotContext = {
			slots = {}
		}
	}

	for iter_5_0 = 1, 6 do
		arg_5_0.slots[iter_5_0].viewModule:InitAnim()
	end
end

function var_0_0.AddUIListeners(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveAllListeners()
	arg_7_0:RemoveTween()

	for iter_7_0 = 1, 6 do
		arg_7_0.slots[iter_7_0].viewModule:Dispose()

		arg_7_0.slots[iter_7_0] = nil
	end

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.RenderView(arg_8_0, arg_8_1)
	if arg_8_1.needRefresh then
		arg_8_0:InitContext()

		if not arg_8_0:GetJumpAnimLock() then
			arg_8_0:JumpDirectly(5)
			arg_8_0:JumpToSlot(arg_8_1.index or 1)
		end

		arg_8_0:SelectSlot(0)
	end

	local var_8_0 = not arg_8_0.isInSlotView

	arg_8_0.ringAAni_:Play(var_8_0 and "UI_ringA" or "UI_ringB")
	arg_8_0.ringAAni_:Update(0)

	arg_8_0.data.heroID = arg_8_1.heroID

	if arg_8_1.proxy then
		arg_8_0.data.heroDataProxy = arg_8_1.proxy
		arg_8_0.data.type = arg_8_0.data.heroDataProxy:GetViewDataType()
	else
		arg_8_0.data.type = arg_8_1.type or HeroConst.HERO_DATA_TYPE.DEFAULT
		arg_8_0.data.heroDataProxy = HeroViewDataProxy.New(arg_8_0.data.type)
	end

	if arg_8_1.slots then
		local var_8_1 = {
			slots = arg_8_1.slots
		}

		for iter_8_0 = 1, 6 do
			if not var_8_1.slots[iter_8_0] then
				var_8_1.slots[iter_8_0] = {
					totalPoint = 0,
					isLock = true,
					skills = {},
					slotIdx = iter_8_0
				}
			end
		end

		arg_8_0.data.slotContext = var_8_1

		for iter_8_1, iter_8_2 in ipairs(arg_8_1.slots) do
			arg_8_0:RenderSlot(iter_8_1, iter_8_2)
		end
	else
		local var_8_2 = {
			slots = {}
		}
		local var_8_3 = arg_8_0.data.heroDataProxy:GetHeroTransitionInfoList(arg_8_1.heroID)

		for iter_8_3, iter_8_4 in ipairs(var_8_3) do
			local var_8_4 = iter_8_4.slot_id
			local var_8_5 = iter_8_4.skill_list or {}
			local var_8_6 = {
				skills = {},
				slotIdx = var_8_4,
				isLock = arg_8_0:GetSlotLockStatus(var_8_4),
				totalPoint = iter_8_4.talent_points or 0
			}

			var_8_2.slots[var_8_4] = var_8_6

			for iter_8_5, iter_8_6 in ipairs(var_8_5) do
				table.insert(var_8_6.skills, {
					skillId = iter_8_6.skill_id,
					level = iter_8_6.skill_level
				})
			end
		end

		for iter_8_7 = 1, 6 do
			if not var_8_2.slots[iter_8_7] then
				var_8_2.slots[iter_8_7] = {
					totalPoint = 0,
					skills = {},
					slotIdx = iter_8_7,
					isLock = arg_8_0:GetSlotLockStatus(iter_8_7)
				}
			end
		end

		arg_8_0.data.slotContext = var_8_2

		for iter_8_8, iter_8_9 in pairs(var_8_2.slots) do
			arg_8_0:RenderSlot(iter_8_8, iter_8_9)
		end
	end

	if arg_8_0:GetShowLocked() then
		arg_8_0:RenderLock()
	else
		arg_8_0:ClearLock()
	end
end

function var_0_0.ClearLock(arg_9_0)
	for iter_9_0 = 1, 6 do
		arg_9_0.slots[iter_9_0].viewModule:RenderLock(false)
	end
end

function var_0_0.RenderLock(arg_10_0)
	for iter_10_0 = 1, 6 do
		if arg_10_0.data.slotContext.slots[iter_10_0] then
			arg_10_0.slots[iter_10_0].viewModule:RenderLock(arg_10_0.data.slotContext.slots[iter_10_0].isLock or false)
		end
	end
end

function var_0_0.RenderSlot(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.slots[arg_11_1].viewModule:RenderView(arg_11_2)
end

function var_0_0.RefreshSlot(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.data.slotContext

	arg_12_1.heroId = arg_12_0.data.heroID

	local var_12_1 = arg_12_1.slotIdx

	var_12_0.slots[var_12_1] = deepClone(arg_12_1)

	arg_12_0:RenderSlot(var_12_1, var_12_0.slots[var_12_1])
end

function var_0_0.ClearSlot(arg_13_0, arg_13_1)
	arg_13_0.slots[arg_13_1].viewModule:ClearSlot()
end

function var_0_0.LockJumpAnim(arg_14_0, arg_14_1)
	arg_14_0.constVar.animLocked = arg_14_1
end

function var_0_0.GetJumpAnimLock(arg_15_0)
	return arg_15_0.constVar.animLocked
end

function var_0_0.LockSelect(arg_16_0, arg_16_1)
	arg_16_0.constVar.selectLocked = arg_16_1

	if arg_16_1 then
		arg_16_0:SelectSlot(0)
	end
end

function var_0_0.SetShowLocked(arg_17_0, arg_17_1)
	arg_17_0.constVar.showLocked = arg_17_1
end

function var_0_0.GetShowLocked(arg_18_0)
	return arg_18_0.constVar.showLocked
end

function var_0_0.GetSelectLock(arg_19_0)
	return arg_19_0.constVar.selectLocked
end

function var_0_0.RegisterSlotClickCallback(arg_20_0, arg_20_1)
	arg_20_0.constVar.slotClickCallback = arg_20_1
end

function var_0_0.GetAllSlotMessage(arg_21_0, arg_21_1)
	return arg_21_0.data.slotContext.slots
end

function var_0_0.GetCurEulerAngle(arg_22_0)
	return arg_22_0.slotRootObj_.transform.eulerAngles.z
end

function var_0_0.JumpDirectly(arg_23_0, arg_23_1)
	local var_23_0 = (2 - (arg_23_1 + 3) % 6) * 60
	local var_23_1 = Quaternion.Euler(Vector3.New(0, 0, var_23_0))

	arg_23_0.slotRootObj_.transform.rotation = var_23_1
	arg_23_0.data.slotIdx = arg_23_1
end

function var_0_0.JumpToSlot(arg_24_0, arg_24_1)
	if arg_24_0.data.slotIdx ~= arg_24_1 then
		arg_24_0:StartTween(arg_24_1)

		arg_24_0.data.slotIdx = arg_24_1
	end
end

function var_0_0.GetAngle(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:GetCurEulerAngle()
	local var_25_1 = (2 - (arg_25_1 + 3) % 6) * 60
	local var_25_2 = var_25_1 + 360

	if math.abs(var_25_0 - var_25_1) > math.abs(var_25_0 - var_25_2) then
		return var_25_2
	else
		return var_25_1
	end
end

function var_0_0.RemoveTween(arg_26_0)
	if arg_26_0.constVar.tweenRef then
		arg_26_0.constVar.tweenRef:setOnComplete(nil)
		LeanTween.cancel(arg_26_0.constVar.tweenRef.id)

		arg_26_0.constVar.tweenRef = nil
	end
end

function var_0_0.StartTween(arg_27_0, arg_27_1)
	if arg_27_0:GetJumpAnimLock() then
		return
	end

	arg_27_0:RemoveTween()

	local var_27_0 = arg_27_0:GetAngle(arg_27_1)

	manager.audio:PlayEffect("ui_system_3_0", "ui_sight_listchange", "")

	arg_27_0.constVar.tweenRef = LeanTween.rotateLocal(arg_27_0.slotRootObj_, Vector3.New(0, 0, var_27_0), arg_27_0.constVar.jumpDuration):setEase(LeanTweenType.easeOutCubic):setOnComplete(System.Action(function()
		arg_27_0:OnTweenComplete()
		arg_27_0:RemoveTween()
	end))
end

function var_0_0.OnTweenComplete(arg_29_0)
	return
end

function var_0_0.SelectSlot(arg_30_0, arg_30_1)
	for iter_30_0 = 1, 6 do
		if iter_30_0 == arg_30_1 then
			arg_30_0.slots[iter_30_0].viewModule:RenderSelect(true)
		else
			arg_30_0.slots[iter_30_0].viewModule:RenderSelect(false)
		end
	end
end

function var_0_0.ClearSelect(arg_31_0)
	arg_31_0:SelectSlot(0)
end

function var_0_0.OnSlotClick(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.constVar.slotClickCallback

	if var_32_0 then
		local var_32_1 = arg_32_0.data.slotContext.slots[arg_32_1]

		if var_32_1 then
			var_32_0(var_32_1)
		end
	end

	if not arg_32_0:GetSelectLock() then
		arg_32_0:SelectSlot(arg_32_1)
	end
end

function var_0_0.GetSlotLockStatus(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.data.heroDataProxy:GetEquipDataList(arg_33_0.data.heroID)
	local var_33_1 = 0

	if var_33_0[arg_33_1] and var_33_0[arg_33_1].prefab_id and var_33_0[arg_33_1].prefab_id ~= 0 then
		var_33_1 = var_33_0[arg_33_1]:GetLevel()
	end

	return var_33_1 < GameSetting.exclusive_open_need.value[1]
end

return var_0_0
