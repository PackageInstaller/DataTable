local var_0_0 = class("AstrolabeNode")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.data_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.transform_.localPosition = Vector3(0, 0, 0)
	arg_1_0.posX = arg_1_3
	arg_1_0.aniStrCfg = {
		"yellow",
		"red",
		"blue"
	}

	arg_1_0:InitUI()
	arg_1_0:Init()
end

function var_0_0.SetParent(arg_2_0, arg_2_1)
	if arg_2_0.transform_ then
		arg_2_0.transform_:SetParent(arg_2_1)

		arg_2_0.transform_.localEulerAngles = Vector3(0, 0, 0)
		arg_2_0.transform_.localPosition = Vector3(0, 0, 0)
		arg_2_0.transform_.localScale = Vector3(1, 1, 1)
	end
end

function var_0_0.RefreshData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.data_ = arg_3_1
	arg_3_0.info_ = arg_3_2

	arg_3_0:Render()
end

function var_0_0.InitUI(arg_4_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_4_0, arg_4_0.transform_)
	arg_4_0.itemEventtriggerlistener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.OnClick)))
end

function var_0_0.Render(arg_5_0)
	arg_5_0:RefreshUI(arg_5_0.info_)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.textTm_.font = Asset.Load("Fonts/SourceHanSans_SDF", true)
	arg_6_0.data_ = arg_6_1
	arg_6_0.info_ = arg_6_2

	if arg_6_1 then
		local var_6_0 = {
			arg_6_0.yellowAni_,
			arg_6_0.redAni_,
			arg_6_0.blueAni_
		}

		if HeroTools.IsSpHero(arg_6_2.id) then
			if arg_6_0.spAni_ then
				arg_6_0.curAnimator.runtimeAnimatorController = arg_6_0.spAni_.runtimeAnimatorController
			end

			arg_6_0:ShowSpState(arg_6_1)
		else
			arg_6_0.curAnimator.runtimeAnimatorController = var_6_0[arg_6_0.posX].runtimeAnimatorController

			arg_6_0:ShowNormalState(arg_6_1)
		end

		arg_6_0.textTm_.text = GetI18NText(HeroAstrolabeCfg[arg_6_1.id].name)

		local var_6_1 = arg_6_0.heroViewProxy_:GetNextIsEquiped(arg_6_1.id, arg_6_0.info_.id)

		if arg_6_0.lineStar then
			SetActive(arg_6_0.lineStar.gameObject, var_6_1)
		end
	end
end

function var_0_0.ShowNormalState(arg_7_0, arg_7_1)
	if arg_7_1.isEquiped then
		arg_7_0.curAnimator:Update(0)
		arg_7_0.curAnimator:Play("star1_" .. arg_7_0.aniStrCfg[arg_7_0.posX], 0, 0)

		arg_7_0.nodeState = AstrolabeConst.NODE_STATE.EQUIPED
	elseif not arg_7_1.isUnlock then
		if arg_7_1.isCanLock then
			arg_7_0.nodeState = AstrolabeConst.NODE_STATE.CANLOCK

			arg_7_0.curAnimator:Play("lock1")
		else
			arg_7_0.curAnimator:Play("lock2")

			arg_7_0.nodeState = AstrolabeConst.NODE_STATE.LOCK
		end
	elseif arg_7_1.isUnlock then
		arg_7_0.curAnimator:Play("star2_" .. arg_7_0.aniStrCfg[arg_7_0.posX])

		arg_7_0.nodeState = AstrolabeConst.NODE_STATE.UNLOCK
	end
end

function var_0_0.ShowNextEffect(arg_8_0)
	local var_8_0 = arg_8_0.heroViewProxy_:GetNextIsEquiped(arg_8_0.data_.id, arg_8_0.info_.id)

	if arg_8_0.lineStar then
		SetActive(arg_8_0.lineStar.gameObject, var_8_0)
	end
end

function var_0_0.ShowSelfEffect(arg_9_0)
	local var_9_0 = arg_9_0.data_.isEquiped

	if arg_9_0.lineStar then
		SetActive(arg_9_0.lineStar.gameObject, var_9_0)
	end
end

function var_0_0.ShowNextSpEffect(arg_10_0)
	local var_10_0 = arg_10_0.heroViewProxy_:GetNextSPNodeIsEquiped(arg_10_0.data_.id, arg_10_0.info_.id)

	if arg_10_0.posX == 3 then
		var_10_0 = arg_10_0.heroViewProxy_:GetLastIsEquiped(arg_10_0.data_.id, arg_10_0.info_.id)
	end

	if arg_10_0.lineStar2 then
		SetActive(arg_10_0.lineStar2.gameObject, var_10_0)
	end
end

function var_0_0.ResetEffect(arg_11_0)
	if arg_11_0.lineStar2 then
		SetActive(arg_11_0.lineStar2.gameObject, false)
	end

	if arg_11_0.lineStar then
		SetActive(arg_11_0.lineStar.gameObject, false)
	end
end

function var_0_0.ShowSpState(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.curAnimator

	if arg_12_1.isEquiped then
		arg_12_0.curAnimator:Play("star_sp_2")

		arg_12_0.nodeState = AstrolabeConst.NODE_STATE.EQUIPED
	elseif not arg_12_1.isUnlock then
		arg_12_0.nodeState = AstrolabeConst.NODE_STATE.LOCK

		arg_12_0.curAnimator:Play("lock_sp_1")
	elseif arg_12_1.isUnlock then
		arg_12_0.curAnimator:Play("star_sp_1")

		arg_12_0.nodeState = AstrolabeConst.NODE_STATE.UNLOCK
	end
end

function var_0_0.ShowSelect(arg_13_0, arg_13_1)
	if arg_13_0.icon_selectGo_ then
		SetActive(arg_13_0.icon_selectGo_, arg_13_1)
	end
end

function var_0_0.Init(arg_14_0)
	arg_14_0:RefreshUI(arg_14_0.info_)
end

function var_0_0.SetNodeNameIsHide(arg_15_0, arg_15_1)
	if arg_15_0.textTm_ then
		SetActive(arg_15_0.textTm_.gameObject, not arg_15_1)
	end

	arg_15_0:SetRedPoint(false)
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:RemoveAllListeners()

	arg_16_0.clickFunc = nil

	if arg_16_0.gameObject_ then
		Object.Destroy(arg_16_0.gameObject_)

		arg_16_0.gameObject_ = nil
		arg_16_0.transform_ = nil
	end
end

function var_0_0.OnClick(arg_17_0)
	if arg_17_0.clickFunc then
		arg_17_0.clickFunc(arg_17_0)
	end
end

function var_0_0.RemoveAllListeners(arg_18_0)
	if arg_18_0.gameObject_ and not isNil(arg_18_0.gameObject_) then
		arg_18_0.itemEventtriggerlistener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)
	end
end

function var_0_0.RegistCallBack(arg_19_0, arg_19_1)
	arg_19_0.clickFunc = arg_19_1
end

function var_0_0.GetItemInfo(arg_20_0)
	return arg_20_0.data_
end

function var_0_0.SetRedPoint(arg_21_0, arg_21_1)
	if arg_21_0.notice_imgGo_ then
		SetActive(arg_21_0.notice_imgGo_, arg_21_1)
	end
end

function var_0_0.SetProxy(arg_22_0, arg_22_1)
	arg_22_0.heroViewProxy_ = arg_22_1
end

return var_0_0
