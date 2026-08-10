local var_0_0 = class("TransitionSkillSlotItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.isInSlotView = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:BuildContext()
end

function var_0_0.BuildContext(arg_4_0)
	arg_4_0.controller = {
		comps = arg_4_0.controller_,
		sel = {
			name = "sel",
			Select = "1",
			DeSelect = "0",
			comps = arg_4_0.controller_:GetController("sel")
		},
		position = {
			Pos3 = "3",
			Pos5 = "5",
			Pos1 = "1",
			Pos2 = "2",
			Pos6 = "6",
			Pos4 = "4",
			name = "position",
			comps = arg_4_0.controller_:GetController("position")
		},
		Activate = {
			Stage1 = "state1",
			Stage2 = "state2",
			Stage4 = "state4",
			name = "Activate",
			Stage6 = "state6",
			Stage3 = "state3",
			Stage5 = "state5",
			Stage0 = "state0",
			comps = arg_4_0.controller_:GetController("Activate")
		},
		lock = {
			name = "lock",
			Lock = "lock",
			Unlock = "unlock",
			comps = arg_4_0.controller_:GetController("lock")
		}
	}
	arg_4_0.data = {
		isLock = false,
		position = 1
	}
	arg_4_0.constVar = {
		chipObjPrefix = "chip%dObj_",
		firstRefreshDirty = true,
		chipImgPrefix = "chip%dImg_",
		position = 1,
		icon1Anim = arg_4_0.chip1Obj_:GetComponent(typeof(Animator)),
		icon2Anim = arg_4_0.chip2Obj_:GetComponent(typeof(Animator)),
		effect1Anim = arg_4_0.effect1Obj_:GetComponent(typeof(Animator)),
		effect2Anim = arg_4_0.effect2Obj_:GetComponent(typeof(Animator)),
		slotEmpty = {
			true,
			true
		}
	}
	arg_4_0.constVar.icon1Anim.enabled = false
	arg_4_0.constVar.icon2Anim.enabled = false
end

function var_0_0.InitAnim(arg_5_0)
	SetActive(arg_5_0.effect1Obj_, false)
	SetActive(arg_5_0.effect2Obj_, false)

	arg_5_0.constVar.firstRefreshDirty = true
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.JumpsBtn_, nil, function()
		arg_6_0:OnJumpsClick()
	end)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.RenderView(arg_9_0, arg_9_1)
	arg_9_0.data.param = arg_9_1

	local var_9_0 = 0
	local var_9_1 = arg_9_0.constVar.firstRefreshDirty

	arg_9_0.constVar.firstRefreshDirty = false

	for iter_9_0 = 1, 2 do
		local var_9_2 = arg_9_1.skills[iter_9_0]

		if var_9_2 then
			local var_9_3 = var_9_2.level or 1
			local var_9_4 = var_9_2.skillId
			local var_9_5 = EquipSkillCfg[var_9_4]

			var_9_0 = var_9_0 + var_9_3
			arg_9_0[string.format(arg_9_0.constVar.chipImgPrefix, iter_9_0)].sprite = getEquipSkillSprite(var_9_4)

			if not var_9_1 and arg_9_0.isInSlotView then
				arg_9_0.constVar[string.format("icon%dAnim", iter_9_0)].enabled = true

				SetActive(arg_9_0[string.format("effect%dObj_", iter_9_0)], true)
			end

			SetActive(arg_9_0[string.format(arg_9_0.constVar.chipObjPrefix, iter_9_0)], true)

			if not arg_9_0.constVar.slotEmpty[iter_9_0] then
				arg_9_0.constVar.slotEmpty[iter_9_0] = true

				arg_9_0.constVar[string.format("icon%dAnim", iter_9_0)]:Play("Fx_icon_cx")
				arg_9_0.constVar[string.format("effect%dAnim", iter_9_0)]:Play("Fx_icon_chuandai")
			end
		else
			arg_9_0.constVar.slotEmpty[iter_9_0] = false

			SetActive(arg_9_0[string.format(arg_9_0.constVar.chipObjPrefix, iter_9_0)], false)
		end
	end

	arg_9_0:RenderLevel(var_9_0)
end

function var_0_0.ClearSlot(arg_10_0)
	for iter_10_0 = 1, 2 do
		arg_10_0.constVar.slotEmpty[iter_10_0] = false

		SetActive(arg_10_0[string.format(arg_10_0.constVar.chipObjPrefix, iter_10_0)], false)
	end

	arg_10_0:RenderLevel(0)
end

function var_0_0.RenderPosition(arg_11_0, arg_11_1)
	arg_11_0.constVar.position = arg_11_1

	local var_11_0 = "Pos%d"
	local var_11_1 = arg_11_0.controller.position[string.format(var_11_0, arg_11_1)]

	if var_11_1 then
		arg_11_0.controller.position.comps:SetSelectedState(var_11_1)
	end
end

function var_0_0.RenderLevel(arg_12_0, arg_12_1)
	local var_12_0 = "Stage%d"
	local var_12_1 = arg_12_0.controller.Activate[string.format(var_12_0, arg_12_1)]

	if var_12_1 then
		arg_12_0.controller.Activate.comps:SetSelectedState(var_12_1)
	end
end

function var_0_0.RenderLock(arg_13_0, arg_13_1)
	arg_13_0.data.isLock = arg_13_1

	if arg_13_1 then
		arg_13_0.controller.lock.comps:SetSelectedState(arg_13_0.controller.lock.Lock)
	else
		arg_13_0.controller.lock.comps:SetSelectedState(arg_13_0.controller.lock.Unlock)
	end
end

function var_0_0.RenderSelect(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.controller.sel.Select

	if not arg_14_1 then
		var_14_0 = arg_14_0.controller.sel.DeSelect
	end

	arg_14_0.controller.sel.comps:SetSelectedState(var_14_0)
end

function var_0_0.RegisterClickListener(arg_15_0, arg_15_1)
	arg_15_0.constVar.clickCallback = arg_15_1
end

function var_0_0.OnJumpsClick(arg_16_0)
	local var_16_0 = arg_16_0.constVar.clickCallback

	if var_16_0 then
		var_16_0(arg_16_0.constVar.position)
	end
end

return var_0_0
