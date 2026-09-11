local var_0_0 = singletonClass("SeaWarfareModelView")

function var_0_0:Load()
	self:LoadBg()
	self:LoadModel()
end

function var_0_0:Unload()
	self:UnloadBg()
	self:UnloadModel()
end

function var_0_0:LoadBg()
	self:InstantiateBg()
end

function var_0_0:InstantiateBg()
	if isNil(self.bgGo_) then
		self.bgGo_ = Asset.Instantiate(SeaWarfareConst.BG_PATH)
		self.bgTrans_ = self.bgGo_.transform
		self.bgTrans_.localPosition = Vector3.New(SeaWarfareConst.BG_POS[1], SeaWarfareConst.BG_POS[2], SeaWarfareConst.BG_POS[3]) + Vector3.New(SeaWarfareConst.CAMERA_POS[1], SeaWarfareConst.CAMERA_POS[2], SeaWarfareConst.CAMERA_POS[3])

		self:AdaptBg()
	end
end

function var_0_0:AdaptBg()
	local var_5_0 = self.bgTrans_:GetComponentInChildren(typeof(SpriteRenderer))

	if var_5_0 then
		local var_5_1 = 2 * (self.bgTrans_.localPosition - Vector3.New(SandPlayIlluConst.CAMERA_POS[1], SandPlayIlluConst.CAMERA_POS[2], SandPlayIlluConst.CAMERA_POS[3])).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
		local var_5_2 = Mathf.Max(var_5_1 * manager.ui.mainCameraCom_.aspect / var_5_0.bounds.size.x, var_5_1 / var_5_0.bounds.size.y)

		self.bgTrans_.localScale = Vector2(var_5_2, var_5_2, 1)
	end
end

function var_0_0:UnloadBg()
	if not isNil(self.bgGo_) then
		Object.Destroy(self.bgGo_)
	end

	self.bgGo_ = nil
	self.bgTrans_ = nil
end

function var_0_0:LoadModel()
	if isNil(self.modelGo_) then
		self.modelGo_ = Asset.Instantiate(SeaWarfareConst.MODEL_PATH)
		self.modelTrans_ = self.modelGo_.transform
		self.modelTrans_.localPosition = Vector3.New(SeaWarfareConst.MODEL_POS[1], SeaWarfareConst.MODEL_POS[2], SeaWarfareConst.MODEL_POS[3])
		self.modelAnim_ = self.modelGo_:GetComponent("Animator")
		self.lastSkillIndex_ = nil
	end
end

function var_0_0:UnloadModel()
	if not isNil(self.modelGo_) then
		Object.Destroy(self.modelGo_)
	end

	self.modelGo_ = nil
	self.modelTrans_ = nil
	self.modelAnim_ = nil
end

function var_0_0:SwitchModelAnim(arg_9_1)
	self.lastSkillIndex_ = self.lastSkillIndex_ or 0

	self.modelAnim_:Play((string.format("ship_transition_%d_%d", self.lastSkillIndex_, arg_9_1)))

	self.lastSkillIndex_ = arg_9_1
end

return var_0_0
