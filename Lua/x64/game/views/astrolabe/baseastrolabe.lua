local var_0_0 = class("BaseAstrolabe")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.animationState = AstrolabeConst.AnimationState.none
	arg_1_0.pathDic = {}

	arg_1_0:CheckLoad()
end

function var_0_0.LoadAstrolabeByPath(arg_2_0, arg_2_1, arg_2_2)
	print("LoadAstrolabeByPath ", arg_2_1)
	arg_2_0:CheckLoad()

	if arg_2_0.heroID then
		arg_2_0.lastHeroID = arg_2_0.heroID
	end

	arg_2_0.heroID = arg_2_2

	local var_2_0 = HeroPosAndRotCfg[arg_2_2]
	local var_2_1 = var_2_0.hero_view_height == 0 and 1 or var_2_0.hero_view_height
	local var_2_2 = arg_2_0[string.format("height_%sGo_", var_2_1)]

	arg_2_0.gameObject = arg_2_0:GetPrefab(arg_2_1)

	for iter_2_0, iter_2_1 in pairs(arg_2_0.pathDic) do
		if iter_2_1 then
			iter_2_1:SetActive(false)
		end
	end

	print(arg_2_0.gameObject, "LoadAstrolabeByPath", var_2_2)

	if arg_2_0.gameObject and var_2_2 then
		arg_2_0.gameObject.transform:SetParent(var_2_2.transform)

		arg_2_0.gameObject.transform.localPosition = Vector3(0, 0, 0)

		ComponentBinder.GetInstance():BindCfgUI(arg_2_0, arg_2_0.gameObject)

		arg_2_0.animator = arg_2_0.gameObject.transform:GetComponent("Animator")

		SetActive(arg_2_0.gameObject, true)
		arg_2_0:InitItem()
	end
end

function var_0_0.GetPrefab(arg_3_0, arg_3_1)
	if not arg_3_0.pathDic[arg_3_1] then
		arg_3_0.pathDic[arg_3_1] = Object.Instantiate(Asset.Load("UI/HeroGodHood/" .. arg_3_1))

		arg_3_0.pathDic[arg_3_1].transform:SetParent(arg_3_0.baseParent.transform)
	end

	return arg_3_0.pathDic[arg_3_1]
end

function var_0_0.InitItem(arg_4_0)
	return
end

function var_0_0.CheckLoad(arg_5_0)
	if isNil(arg_5_0.baseParent) then
		arg_5_0.baseParent = Object.Instantiate(Asset.Load("UI/HeroGodHood/TX_GodHood"))
		arg_5_0.baseParent.transform.localPosition = Vector3(500, 0, 0)

		ComponentBinder.GetInstance():BindCfgUI(arg_5_0, arg_5_0.baseParent)

		arg_5_0.itemS_ = {}
	end
end

function var_0_0.RefreshAnimationState(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.animationState

	if var_6_0 == arg_6_1 and arg_6_1 ~= 3 then
		return
	end

	arg_6_0.animationState = arg_6_1

	if var_6_0 == 5 and arg_6_0.animationState == 1 then
		arg_6_0:SetActive(true)
		arg_6_0:PlayAni("TX_GodHood_01", 0, 0)
	elseif var_6_0 == 3 and arg_6_0.animationState == 1 then
		arg_6_0:SetActive(true)
		arg_6_0:PlayAni("TX_GodHood_01", 0, 0)
	elseif var_6_0 == 3 and arg_6_0.animationState == 2 then
		arg_6_0:PlayAni("TX_GodHood_02", 0, 0)

		arg_6_0.ClickAnimaton = false
	elseif var_6_0 == 6 and arg_6_0.animationState == 2 then
		arg_6_0:PlayAni("TX_GodHood_02", 0, 0)
	elseif var_6_0 == 2 and arg_6_0.animationState == 1 then
		arg_6_0:PlayAni("TX_GodHood_04", 0, 0)
	elseif var_6_0 == 1 and arg_6_0.animationState == 3 and not arg_6_0.ClickAnimaton then
		arg_6_0:PlayAni("TX_GodHood_03", 0, 0)
	elseif var_6_0 == 4 and arg_6_0.animationState == 2 then
		arg_6_0:SetActive(true)
	elseif var_6_0 == 4 and arg_6_0.animationState == 1 then
		arg_6_0:SetActive(true)
		arg_6_0:PlayAni("TX_GodHood_04", 0, 1)
	elseif arg_6_0.animationState == 5 then
		arg_6_0:SetActive(false)
	end
end

function var_0_0.SetClickAnimaton(arg_7_0, arg_7_1)
	arg_7_0.ClickAnimaton = arg_7_1
end

function var_0_0.SetAdjustHide(arg_8_0, arg_8_1)
	arg_8_0.adjustHide = arg_8_1
end

function var_0_0.CheckadjustHide(arg_9_0)
	if arg_9_0.adjustHide then
		arg_9_0:SetActive(true)
		arg_9_0:PlayAni("TX_GodHood_02", 0, 1)

		arg_9_0.adjustHide = nil
	end
end

function var_0_0.PlayAni(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_0.animator and not isNil(arg_10_0.animator) then
		arg_10_0.animator:Play(arg_10_1, arg_10_2 or 0, arg_10_3 or 0)
	end
end

function var_0_0.PlayAni2(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.animator and not isNil(arg_11_0.animator) then
		arg_11_0.animator:CrossFade(arg_11_1, arg_11_2 or 0)
	end
end

function var_0_0.UpdateAni(arg_12_0, arg_12_1)
	if arg_12_0.animator and not isNil(arg_12_0.animator) then
		arg_12_0.animator:Update(arg_12_1)
	end
end

function var_0_0.PlayAni1(arg_13_0, arg_13_1)
	if arg_13_0.animator and not isNil(arg_13_0.animator) then
		arg_13_0.animator:Play(arg_13_1)
	end
end

function var_0_0.SetActive(arg_14_0, arg_14_1)
	if arg_14_0.baseParent then
		arg_14_0.baseParent.gameObject:SetActive(arg_14_1)
	end

	if arg_14_1 then
		if arg_14_0.raycaster == nil then
			arg_14_0.raycaster = manager.ui.mainCamera:AddComponent(typeof(PhysicsRaycaster))
		end
	elseif arg_14_0.raycaster then
		Object.Destroy(arg_14_0.raycaster)

		arg_14_0.raycaster = nil
	end
end

function var_0_0.SetProxy(arg_15_0, arg_15_1)
	arg_15_0.heroViewProxy_ = arg_15_1
end

function var_0_0.OnClick(arg_16_0)
	if arg_16_0.clickFunc then
		arg_16_0.clickFunc(arg_16_0)
	end
end

function var_0_0.RegistCallBack(arg_17_0, arg_17_1)
	arg_17_0.clickFunc = arg_17_1
end

function var_0_0.OnExit(arg_18_0)
	if arg_18_0.raycaster then
		Object.Destroy(arg_18_0.raycaster)

		arg_18_0.raycaster = nil
	end
end

function var_0_0.PlayExitAnimator(arg_19_0)
	AnimatorTools.PlayAnimationWithCallback(arg_19_0.animator, "TX_GodHood_03", function()
		if arg_19_0.gameObject then
			SetActive(arg_19_0.gameObject, false)
		end

		AnimatorTools.Stop()
	end)
end

function var_0_0.Dispose(arg_21_0)
	AnimatorTools.Stop()

	arg_21_0.gameObject = nil
	arg_21_0.animator = nil

	arg_21_0:ClearItem()

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.pathDic) do
		Object.Destroy(iter_21_1)
	end

	arg_21_0.pathDic = {}

	if arg_21_0.baseParent then
		Object.Destroy(arg_21_0.baseParent)

		arg_21_0.baseParent = nil
	end

	if arg_21_0.raycaster then
		Object.Destroy(arg_21_0.raycaster)

		arg_21_0.raycaster = nil
	end
end

return var_0_0
