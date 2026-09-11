local BaseAstrolabe = class("BaseAstrolabe")

function BaseAstrolabe:Ctor()
	self.animationState = AstrolabeConst.AnimationState.none
	self.pathDic = {}

	self:CheckLoad()
end

function BaseAstrolabe:LoadAstrolabeByPath(arg_2_1, arg_2_2)
	print("LoadAstrolabeByPath ", arg_2_1)
	self:CheckLoad()

	if self.heroID then
		self.lastHeroID = self.heroID
	end

	self.heroID = arg_2_2

	local var_2_0 = self[string.format("height_%sGo_", HeroPosAndRotCfg[arg_2_2].hero_view_height == 0 and 1 or HeroPosAndRotCfg[arg_2_2].hero_view_height)]

	self.gameObject = self:GetPrefab(arg_2_1)

	for iter_2_0, iter_2_1 in pairs(self.pathDic) do
		if iter_2_1 then
			iter_2_1:SetActive(false)
		end
	end

	print(self.gameObject, "LoadAstrolabeByPath", var_2_0)

	if self.gameObject and var_2_0 then
		self.gameObject.transform:SetParent(var_2_0.transform)

		self.gameObject.transform.localPosition = Vector3(0, 0, 0)

		ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject)

		self.animator = self.gameObject.transform:GetComponent("Animator")

		SetActive(self.gameObject, true)
		self:InitItem()
	end
end

function BaseAstrolabe:GetPrefab(arg_3_1)
	if not self.pathDic[arg_3_1] then
		self.pathDic[arg_3_1] = Object.Instantiate(Asset.Load("UI/HeroGodHood/" .. arg_3_1))

		self.pathDic[arg_3_1].transform:SetParent(self.baseParent.transform)
	end

	return self.pathDic[arg_3_1]
end

function BaseAstrolabe:InitItem()
	return
end

function BaseAstrolabe:CheckLoad()
	if isNil(self.baseParent) then
		self.baseParent = Object.Instantiate(Asset.Load("UI/HeroGodHood/TX_GodHood"))
		self.baseParent.transform.localPosition = Vector3(500, 0, 0)

		ComponentBinder.GetInstance():BindCfgUI(self, self.baseParent)

		self.itemS_ = {}
	end
end

function BaseAstrolabe:RefreshAnimationState(arg_6_1)
	if self.animationState == arg_6_1 and arg_6_1 ~= 3 then
		return
	end

	self.animationState = arg_6_1

	if self.animationState == 5 and self.animationState == 1 then
		self:SetActive(true)
		self:PlayAni("TX_GodHood_01", 0, 0)
	elseif self.animationState == 3 and self.animationState == 1 then
		self:SetActive(true)
		self:PlayAni("TX_GodHood_01", 0, 0)
	elseif self.animationState == 3 and self.animationState == 2 then
		self:PlayAni("TX_GodHood_02", 0, 0)

		self.ClickAnimaton = false
	elseif self.animationState == 6 and self.animationState == 2 then
		self:PlayAni("TX_GodHood_02", 0, 0)
	elseif self.animationState == 2 and self.animationState == 1 then
		self:PlayAni("TX_GodHood_04", 0, 0)
	elseif self.animationState == 1 and self.animationState == 3 and not self.ClickAnimaton then
		self:PlayAni("TX_GodHood_03", 0, 0)
	elseif self.animationState == 4 and self.animationState == 2 then
		self:SetActive(true)
	elseif self.animationState == 4 and self.animationState == 1 then
		self:SetActive(true)
		self:PlayAni("TX_GodHood_04", 0, 1)
	elseif self.animationState == 5 then
		self:SetActive(false)
	end
end

function BaseAstrolabe:SetClickAnimaton(arg_7_1)
	self.ClickAnimaton = arg_7_1
end

function BaseAstrolabe:SetAdjustHide(arg_8_1)
	self.adjustHide = arg_8_1
end

function BaseAstrolabe:CheckadjustHide()
	if self.adjustHide then
		self:SetActive(true)
		self:PlayAni("TX_GodHood_02", 0, 1)

		self.adjustHide = nil
	end
end

function BaseAstrolabe:PlayAni(arg_10_1, arg_10_2, arg_10_3)
	if self.animator and not isNil(self.animator) then
		self.animator:Play(arg_10_1, arg_10_2 or 0, arg_10_3 or 0)
	end
end

function BaseAstrolabe:PlayAni2(arg_11_1, arg_11_2)
	if self.animator and not isNil(self.animator) then
		self.animator:CrossFade(arg_11_1, arg_11_2 or 0)
	end
end

function BaseAstrolabe:UpdateAni(arg_12_1)
	if self.animator and not isNil(self.animator) then
		self.animator:Update(arg_12_1)
	end
end

function BaseAstrolabe:PlayAni1(arg_13_1)
	if self.animator and not isNil(self.animator) then
		self.animator:Play(arg_13_1)
	end
end

function BaseAstrolabe:SetActive(arg_14_1)
	if self.baseParent then
		self.baseParent.gameObject:SetActive(arg_14_1)
	end

	if arg_14_1 then
		if self.raycaster == nil then
			self.raycaster = manager.ui.mainCamera:AddComponent(typeof(PhysicsRaycaster))
		end
	elseif self.raycaster then
		Object.Destroy(self.raycaster)

		self.raycaster = nil
	end
end

function BaseAstrolabe:SetProxy(arg_15_1)
	self.heroViewProxy_ = arg_15_1
end

function BaseAstrolabe:OnClick()
	if self.clickFunc then
		self:clickFunc()
	end
end

function BaseAstrolabe:RegistCallBack(arg_17_1)
	self.clickFunc = arg_17_1
end

function BaseAstrolabe:OnExit()
	if self.raycaster then
		Object.Destroy(self.raycaster)

		self.raycaster = nil
	end
end

function BaseAstrolabe:PlayExitAnimator()
	AnimatorTools.PlayAnimationWithCallback(self.animator, "TX_GodHood_03", function()
		if self.gameObject then
			SetActive(self.gameObject, false)
		end

		AnimatorTools.Stop()
	end)
end

function BaseAstrolabe:Dispose()
	AnimatorTools.Stop()

	self.gameObject = nil
	self.animator = nil

	self:ClearItem()

	for iter_21_0, iter_21_1 in ipairs(self.pathDic) do
		Object.Destroy(iter_21_1)
	end

	self.pathDic = {}

	if self.baseParent then
		Object.Destroy(self.baseParent)

		self.baseParent = nil
	end

	if self.raycaster then
		Object.Destroy(self.raycaster)

		self.raycaster = nil
	end
end

return BaseAstrolabe
