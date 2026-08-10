local var_0_0 = class("DormAvatar", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.sceneId = arg_1_2
	arg_1_0.heroId = arg_1_1

	arg_1_0:Init(arg_1_1)
end

function var_0_0.Init(arg_2_0, arg_2_1)
	local var_2_0 = HeroTools.HeroUsingSkinInfo(arg_2_1).id
	local var_2_1 = SkinCfg[var_2_0]
	local var_2_2 = manager.resourcePool:Get("CharDorm/" .. arg_2_1 .. "ui_tpose", ASSET_TYPE.TPOSE)

	HeroTools.SetHeroModelWeaponActivity(var_2_2.transform, false)

	arg_2_0.animator_ = arg_2_0:FindCom(typeof(Animator), "", var_2_2.transform)
	arg_2_0.top = arg_2_0:FindTrs("auto_hp_point", var_2_2.transform)
	arg_2_0.heroModel_ = var_2_2

	local var_2_3 = Asset.Load("Dorm/DormPlayer")

	arg_2_0.gameObject_ = Object.Instantiate(var_2_3)
	arg_2_0.gameObject_.name = "dormPlayer" .. var_2_0
	arg_2_0.dormPlayer = arg_2_0.gameObject_:GetComponent(typeof(Dorm.DormPlayer))

	arg_2_0.dormPlayer:Init(arg_2_0.heroModel_.transform, arg_2_0.animator_, arg_2_0.top, handler(arg_2_0, arg_2_0.OnBoardClick))

	arg_2_0.active = true

	arg_2_0:Reset()

	if arg_2_0.timer then
		arg_2_0.timer:Stop()

		arg_2_0.timer = nil
	end

	arg_2_0.timer = Timer.New(handler(arg_2_0, arg_2_0.CheckState), 60, -1)

	arg_2_0.timer:Start()
	arg_2_0:CheckState()
end

function var_0_0.CheckState(arg_3_0)
	local var_3_0 = DormData:GetDormHero(arg_3_0.heroId)

	if not var_3_0 then
		return
	end

	if DormTools.getHeroEarn(arg_3_0.heroId) + var_3_0:GetEarnings() > 10 then
		SetActive(arg_3_0.dormPlayer.goldBoard.gameObject, true)
	else
		SetActive(arg_3_0.dormPlayer.goldBoard.gameObject, false)
	end

	if var_3_0:GetMood() <= 0 then
		SetActive(arg_3_0.dormPlayer.moodBoard.gameObject, true)
	else
		SetActive(arg_3_0.dormPlayer.moodBoard.gameObject, false)
	end
end

function var_0_0.Reset(arg_4_0)
	arg_4_0.heroModel_.transform.localScale = Vector3(1, 1, 1)
end

function var_0_0.GetSceneId(arg_5_0)
	return arg_5_0.sceneId
end

function var_0_0.SetSceneId(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0.sceneId then
		return
	end

	arg_6_0.sceneId = arg_6_1

	arg_6_0:Reset()
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0.active then
		return
	end

	arg_7_0.active = arg_7_1

	SetActive(arg_7_0.heroModel_, arg_7_0.active)
	SetActive(arg_7_0.gameObject_, arg_7_0.active)
end

function var_0_0.OnBoardClick(arg_8_0)
	DormAction.QueryHeroEarnings({
		arg_8_0.heroId
	})
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.active = false

	if arg_9_0.heroModel_ then
		manager.resourcePool:DestroyOrReturn(arg_9_0.heroModel_, ASSET_TYPE.TPOSE)

		arg_9_0.heroModel_ = nil
	end

	if arg_9_0.dormPlayer then
		arg_9_0.dormPlayer:Dispose()
	end

	if arg_9_0.timer then
		arg_9_0.timer:Stop()

		arg_9_0.timer = nil
	end

	if not isNil(arg_9_0.gameObject_) then
		Object.Destroy(arg_9_0.gameObject_)

		arg_9_0.gameObject_ = nil
	end
end

return var_0_0
