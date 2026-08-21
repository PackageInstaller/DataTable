local var_0_0 = class("AshILLPropModule", ReduxView)
local var_0_1 = "Widget/System/Activity_EkChuah/EkChuah_IllustratedUI/PropItem"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.from = arg_1_3 or "DEFAULT"

	if not arg_1_2 then
		arg_1_0.gameObject_ = GameObject.Instantiate(Asset.Load(var_0_1))
		arg_1_0.transform_ = arg_1_0.gameObject_.transform
		arg_1_0.transform_.parent = arg_1_1
		arg_1_0.transform_.localPosition = Vector3.zero
		arg_1_0.transform_.localRotation = Quaternion.identity
		arg_1_0.transform_.localScale = Vector3.one
		arg_1_0.isCustomObj = false
	else
		arg_1_0.gameObject_ = arg_1_2
		arg_1_0.transform_ = arg_1_0.gameObject_.transform
		arg_1_0.isCustomObj = true
	end

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockController = arg_2_0.controller_:GetController("lock")

	arg_2_0:AddBtnListener(arg_2_0.maskBtn_, nil, function()
		local var_3_0 = arg_2_0.propCfg.unlockRate

		if var_3_0 > AshSystemData:GetHomologyRate() then
			ShowTips(string.format(GetTips("ASH_UNLOCK_TIP"), var_3_0))
		end
	end)
end

function var_0_0.Render(arg_4_0, arg_4_1)
	arg_4_0.propCfg = arg_4_1

	if not arg_4_0.propCfg then
		arg_4_0.lockController:SetSelectedState("true")

		return
	end

	if arg_4_0.propCfg.unlockRate > AshSystemData:GetHomologyRate() then
		arg_4_0.lockController:SetSelectedState("true")
		SetActive(arg_4_0.lockAniObj_, true)
	else
		arg_4_0.lockController:SetSelectedState("false")
		SetActive(arg_4_0.lockAniObj_, false)

		local var_4_0 = "CowbotPropLock" .. arg_4_0.from .. arg_4_0.propCfg.id
		local var_4_1 = getData("ash", var_4_0)

		if arg_4_0.aniTimer_ then
			arg_4_0.aniTimer_:Stop()

			arg_4_0.aniTimer_ = nil
		end

		if not var_4_1 then
			FrameTimer.New(function()
				SetActive(arg_4_0.lockAniObj_, true)
				saveData("ash", var_4_0, true)

				arg_4_0.aniTimer_ = Timer.New(function()
					if arg_4_0.lockAnim_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
						if arg_4_0.aniTimer_ then
							arg_4_0.aniTimer_:Stop()

							arg_4_0.aniTimer_ = nil
						end

						manager.ui:UIEventEnabled(true)
					end
				end, 0.033, -1)

				manager.ui:UIEventEnabled(false)
				arg_4_0.lockAnim_:Play("PropItem_unlock", 0, 0)
				arg_4_0.aniTimer_:Start()
			end, 1, 1):Start()
		end
	end

	local var_4_2 = arg_4_1.cfg

	arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas(var_4_2.icon)
	arg_4_0.nameText_.text = GetI18NText(var_4_2.name)
	arg_4_0.descTxt_.text = GetI18NText(var_4_2.desc)
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.aniTimer_ then
		arg_7_0.aniTimer_:Stop()

		arg_7_0.aniTimer_ = nil
	end

	if not arg_7_0.isCustomObj then
		GameObject.DestroyImmediate(arg_7_0.gameObject_)
		Asset.Unload(var_0_1)
	end

	arg_7_0.super.Dispose(arg_7_0)
end

return var_0_0
