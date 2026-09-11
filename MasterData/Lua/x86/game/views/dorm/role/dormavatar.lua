local DormAvatar = class("DormAvatar", ReduxView)

function DormAvatar:Ctor(arg_1_1, arg_1_2)
	self.sceneId = arg_1_2
	self.heroId = arg_1_1

	self:Init(arg_1_1)
end

function DormAvatar:Init(arg_2_1)
	local var_2_0 = HeroTools.HeroUsingSkinInfo(arg_2_1).id
	local var_2_2 = manager.resourcePool:Get("CharDorm/" .. arg_2_1 .. "ui_tpose", ASSET_TYPE.TPOSE)

	HeroTools.SetHeroModelWeaponActivity(var_2_2.transform, false)

	self.animator_ = self:FindCom(typeof(Animator), "", var_2_2.transform)
	self.top = self:FindTrs("auto_hp_point", var_2_2.transform)
	self.heroModel_ = var_2_2
	self.gameObject_ = Object.Instantiate((Asset.Load("Dorm/DormPlayer")))
	self.gameObject_.name = "dormPlayer" .. var_2_0
	self.dormPlayer = self.gameObject_:GetComponent(typeof(Dorm.DormPlayer))

	self.dormPlayer:Init(self.heroModel_.transform, self.animator_, self.top, handler(self, self.OnBoardClick))

	self.active = true

	self:Reset()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.timer = Timer.New(handler(self, self.CheckState), 60, -1)

	self.timer:Start()
	self:CheckState()
end

function DormAvatar:CheckState()
	local var_3_0 = DormData:GetDormHero(self.heroId)

	if not var_3_0 then
		return
	end

	if DormTools.getHeroEarn(self.heroId) + var_3_0:GetEarnings() > 10 then
		SetActive(self.dormPlayer.goldBoard.gameObject, true)
	else
		SetActive(self.dormPlayer.goldBoard.gameObject, false)
	end

	if var_3_0:GetMood() <= 0 then
		SetActive(self.dormPlayer.moodBoard.gameObject, true)
	else
		SetActive(self.dormPlayer.moodBoard.gameObject, false)
	end
end

function DormAvatar:Reset()
	self.heroModel_.transform.localScale = Vector3(1, 1, 1)
end

function DormAvatar:GetSceneId()
	return self.sceneId
end

function DormAvatar:SetSceneId(arg_6_1)
	if arg_6_1 == self.sceneId then
		return
	end

	self.sceneId = arg_6_1

	self:Reset()
end

function DormAvatar:SetActive(arg_7_1)
	if arg_7_1 == self.active then
		return
	end

	self.active = arg_7_1

	SetActive(self.heroModel_, self.active)
	SetActive(self.gameObject_, self.active)
end

function DormAvatar:OnBoardClick()
	DormAction.QueryHeroEarnings({
		self.heroId
	})
end

function DormAvatar:Dispose()
	self.active = false

	if self.heroModel_ then
		manager.resourcePool:DestroyOrReturn(self.heroModel_, ASSET_TYPE.TPOSE)

		self.heroModel_ = nil
	end

	if self.dormPlayer then
		self.dormPlayer:Dispose()
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if not isNil(self.gameObject_) then
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
	end
end

return DormAvatar
