local var_0_0 = class("AshILLSkillModule", ReduxView)
local var_0_1 = "Widget/System/Activity_EkChuah/EkChuah_IllustratedUI/SkillItemV2"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.from = arg_1_2 or "DEFAULT"
	arg_1_0.gameObject_ = GameObject.Instantiate(Asset.Load(var_0_1))
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.transform_.parent = arg_1_1
	arg_1_0.transform_.localPosition = Vector3.zero
	arg_1_0.transform_.localRotation = Quaternion.identity
	arg_1_0.transform_.localScale = Vector3.one

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockController = arg_2_0.controller_:GetController("lock")

	arg_2_0:ShowSkill(false)
	arg_2_0:AddBtnListener(arg_2_0.maskBtn_, nil, function()
		local var_3_0 = arg_2_0.skillCfg.unlockRate

		if var_3_0 > AshSystemData:GetHomologyRate() then
			ShowTips(string.format(GetTips("ASH_UNLOCK_TIP"), var_3_0))
		else
			arg_2_0:ShowSkill(not arg_2_0.isShowSkill)
		end
	end)
end

function var_0_0.ShowSkill(arg_4_0, arg_4_1)
	if arg_4_1 ~= arg_4_0.isShowSkill then
		SetActive(arg_4_0.descObj1_, arg_4_1)
		SetActive(arg_4_0.descObj2_, arg_4_1)

		arg_4_0.isShowSkill = arg_4_1
	end
end

function var_0_0.Render(arg_5_0, arg_5_1)
	arg_5_0.skillCfg = arg_5_1

	local var_5_0 = arg_5_1.cfg

	arg_5_0.icon_.sprite = pureGetSpriteWithoutAtlas(var_5_0.icon)
	arg_5_0.nameTxt_.text = GetI18NText(var_5_0.name)
	arg_5_0.descTxt_.text = GetI18NText(var_5_0.desc)

	arg_5_0:RenderLock()

	if arg_5_0.skillCfg.unlockRate > AshSystemData:GetHomologyRate() or arg_5_0.from == "PREPARE" then
		arg_5_0:ShowSkill(false)
	else
		arg_5_0:ShowSkill(true)
	end
end

function var_0_0.RenderLock(arg_6_0)
	if arg_6_0.skillCfg.unlockRate > AshSystemData:GetHomologyRate() then
		arg_6_0.lockController:SetSelectedState("true")
	else
		arg_6_0.lockController:SetSelectedState("false")

		local var_6_0 = "CowbotSkillModuleLock" .. arg_6_0.from .. arg_6_0.skillCfg.id
		local var_6_1 = getData("ash", var_6_0)

		if arg_6_0.aniTimer_ then
			arg_6_0.aniTimer_:Stop()

			arg_6_0.aniTimer_ = nil
		end

		if not var_6_1 then
			saveData("ash", var_6_0, true)
			FrameTimer.New(function()
				arg_6_0.aniTimer_ = Timer.New(function()
					if arg_6_0.lockAnim_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
						if arg_6_0.aniTimer_ then
							arg_6_0.aniTimer_:Stop()

							arg_6_0.aniTimer_ = nil
						end

						manager.ui:UIEventEnabled(true)
					end
				end, 0.033, -1)

				manager.ui:UIEventEnabled(false)
				arg_6_0.lockAnim_:Play("SkillItem_unlock", 0, 0)
				arg_6_0.aniTimer_:Start()
			end, 1, 1):Start()
		end
	end
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.aniTimer_ then
		arg_9_0.aniTimer_:Stop()

		arg_9_0.aniTimer_ = nil
	end

	GameObject.DestroyImmediate(arg_9_0.gameObject_)
	Asset.Unload(var_0_1)
	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
