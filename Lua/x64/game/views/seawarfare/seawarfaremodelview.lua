local var_0_0 = singletonClass("SeaWarfareModelView")

function var_0_0.Load(arg_1_0)
	arg_1_0:LoadBg()
	arg_1_0:LoadModel()
end

function var_0_0.Unload(arg_2_0)
	arg_2_0:UnloadBg()
	arg_2_0:UnloadModel()
end

function var_0_0.LoadBg(arg_3_0)
	arg_3_0:InstantiateBg()
end

function var_0_0.InstantiateBg(arg_4_0)
	if isNil(arg_4_0.bgGo_) then
		local var_4_0 = Vector3.New(SeaWarfareConst.CAMERA_POS[1], SeaWarfareConst.CAMERA_POS[2], SeaWarfareConst.CAMERA_POS[3])
		local var_4_1 = manager.ui.mainCamera.transform

		arg_4_0.bgGo_ = Asset.Instantiate(SeaWarfareConst.BG_PATH)
		arg_4_0.bgTrans_ = arg_4_0.bgGo_.transform
		arg_4_0.bgTrans_.localPosition = Vector3.New(SeaWarfareConst.BG_POS[1], SeaWarfareConst.BG_POS[2], SeaWarfareConst.BG_POS[3]) + var_4_0

		arg_4_0:AdaptBg()
	end
end

function var_0_0.AdaptBg(arg_5_0)
	local var_5_0 = arg_5_0.bgTrans_:GetComponentInChildren(typeof(SpriteRenderer))

	if var_5_0 then
		local var_5_1 = var_5_0.bounds.size
		local var_5_2 = var_5_1.x
		local var_5_3 = var_5_1.y
		local var_5_4 = Vector3.New(SandPlayIlluConst.CAMERA_POS[1], SandPlayIlluConst.CAMERA_POS[2], SandPlayIlluConst.CAMERA_POS[3])
		local var_5_5 = (arg_5_0.bgTrans_.localPosition - var_5_4).z
		local var_5_6 = manager.ui.mainCameraCom_
		local var_5_7 = 2 * var_5_5 * Mathf.Tan(var_5_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
		local var_5_8 = var_5_7 * var_5_6.aspect / var_5_2
		local var_5_9 = var_5_7 / var_5_3
		local var_5_10 = Mathf.Max(var_5_8, var_5_9)

		arg_5_0.bgTrans_.localScale = Vector2(var_5_10, var_5_10, 1)
	end
end

function var_0_0.UnloadBg(arg_6_0)
	if not isNil(arg_6_0.bgGo_) then
		Object.Destroy(arg_6_0.bgGo_)
	end

	arg_6_0.bgGo_ = nil
	arg_6_0.bgTrans_ = nil
end

function var_0_0.LoadModel(arg_7_0)
	if isNil(arg_7_0.modelGo_) then
		arg_7_0.modelGo_ = Asset.Instantiate(SeaWarfareConst.MODEL_PATH)
		arg_7_0.modelTrans_ = arg_7_0.modelGo_.transform
		arg_7_0.modelTrans_.localPosition = Vector3.New(SeaWarfareConst.MODEL_POS[1], SeaWarfareConst.MODEL_POS[2], SeaWarfareConst.MODEL_POS[3])
		arg_7_0.modelAnim_ = arg_7_0.modelGo_:GetComponent("Animator")
		arg_7_0.lastSkillIndex_ = nil
	end
end

function var_0_0.UnloadModel(arg_8_0)
	if not isNil(arg_8_0.modelGo_) then
		Object.Destroy(arg_8_0.modelGo_)
	end

	arg_8_0.modelGo_ = nil
	arg_8_0.modelTrans_ = nil
	arg_8_0.modelAnim_ = nil
end

function var_0_0.SwitchModelAnim(arg_9_0, arg_9_1)
	arg_9_0.lastSkillIndex_ = arg_9_0.lastSkillIndex_ or 0

	local var_9_0 = string.format("ship_transition_%d_%d", arg_9_0.lastSkillIndex_, arg_9_1)

	arg_9_0.modelAnim_:Play(var_9_0)

	arg_9_0.lastSkillIndex_ = arg_9_1
end

return var_0_0
