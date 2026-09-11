local GoldMinerThief = class("GoldMinerThief", ReduxView)
local var_0_1 = 540
local var_0_2 = 1200
local var_0_3 = 1
local var_0_4 = 70
local var_0_5 = 5
local var_0_6 = {
	idle = "idle",
	back = "hunter_back",
	pat = "hunter_pat"
}

function GoldMinerThief:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GoldMinerThief:Init()
	self.angleSpeed_ = 60
	self.hooking_ = false
	self.sleeping_ = true
	self.curSleepTime_ = 0
	self.catchingThingID_ = 0
	self.catchingThingDir_ = nil
	self.catchingThing_ = nil
	self.catchThingList_ = {}
	self.catchThingItemList_ = {}
	self.talkTime_ = 0

	if self.corners == nil then
		self.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end

	self:InitUI()
	self:AddUIListener()
end

function GoldMinerThief:InitUI()
	self:BindCfgUI()

	self.oriHeight_ = self.hookTransform_.rect.height
	self.thingNumController_ = self.controllerEx_:GetController("thingNum")
	self.spine_ = self.spineGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.spine_.AnimationState.Complete = self.spine_.AnimationState.Complete + function()
		self.spine_.AnimationState:SetAnimation(0, var_0_6.idle, true)
	end
	self.hookSpine_ = self.hookSpineGo_:GetComponent("Spine.Unity.SkeletonGraphic")
end

function GoldMinerThief:AddUIListener()
	return
end

function GoldMinerThief:AddEventListeners()
	return
end

function GoldMinerThief:SetData(arg_7_1)
	self.data_ = arg_7_1
	self.hitArea_.sizeDelta = Vector2(self.data_.hitWidth, self.data_.hitHeight)

	self:UpdateThingView()
end

function GoldMinerThief:GetData()
	return self.data_
end

function GoldMinerThief:TryToGetThing()
	if #self.catchThingList_ >= 1 then
		GoldMinerManager.GetInstance():AddReturnThiefThing(self.catchThingList_[#self.catchThingList_])
		table.remove(self.catchThingList_, #self.catchThingList_)
		table.remove(self.catchThingItemList_, #self.catchThingList_)
		SetActive(self.talkGo_, true)

		self.talkTime_ = 2
		self.talkText_.text = GetTips("GOLDMINER_THIEF_CHAT_" .. math.random(1, 2))

		self:UpdateThingView()

		return self.catchThingList_[#self.catchThingList_], self.catchThingItemList_[#self.catchThingList_]
	end

	return 0
end

function GoldMinerThief:UpdateThingView()
	if #self.catchThingList_ >= 2 then
		self.thingNumController_:SetSelectedState("2")

		self.iconLastImage_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/" .. self.catchThingList_[#self.catchThingList_])
		self.iconSecondImage_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/" .. self.catchThingList_[#self.catchThingList_ - 1])
	elseif #self.catchThingList_ == 1 then
		self.thingNumController_:SetSelectedState("1")

		self.iconLastImage_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/" .. self.catchThingList_[#self.catchThingList_])
	else
		self.thingNumController_:SetSelectedState("0")
	end
end

function GoldMinerThief:UpdateView()
	return
end

function GoldMinerThief:Update(arg_12_1)
	if self.talkTime_ > 0 then
		self.talkTime_ = self.talkTime_ - arg_12_1

		if self.talkTime_ <= 0 then
			self.talkTime_ = 0

			SetActive(self.talkGo_, false)
		end
	end

	if self.sleeping_ then
		self.isCallStartFunc_ = false
		self.isCallBackFunc_ = false
		self.curSleepTime_ = self.curSleepTime_ + arg_12_1

		if self.curSleepTime_ > var_0_5 then
			self.sleeping_ = false
			self.curSleepTime_ = 0
		end

		local var_12_0 = self.rotaryTransform_.eulerAngles

		var_12_0.z = arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z
		self.rotaryTransform_.eulerAngles = var_12_0

		if arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z > 0 and arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z <= 180 then
			if arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z > var_0_4 then
				var_0_3 = -1
			end
		elseif arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z > 180 and arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z <= 360 and arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z - 360 < -var_0_4 then
			var_0_3 = 1
		end
	elseif not self.hooking_ then
		if self.catchingThingID_ == 0 then
			local var_12_1 = GoldMinerManager.GetInstance():GetThing()
			local var_12_2 = 0
			local var_12_3 = 0

			for iter_12_0, iter_12_1 in pairs(var_12_1) do
				local var_12_4 = iter_12_1:GetData()

				if var_12_4.moveable == 0 and var_12_4.fishId ~= 7 then
					if var_12_2 == 0 then
						var_12_2 = iter_12_0
						var_12_3 = Vector3.Distance(self.transform_.localPosition, (iter_12_1:GetLocalPosition()))
					else
						local var_12_5 = Vector3.Distance(self.transform_.localPosition, (iter_12_1:GetLocalPosition()))

						if var_12_5 < var_12_3 then
							var_12_2 = iter_12_0
							var_12_3 = var_12_5
						end
					end
				end
			end

			if var_12_2 == 0 then
				self.sleeping_ = true
			else
				local var_12_6 = var_12_1[var_12_2]

				self.catchingThingID_ = var_12_1[var_12_2]:GetID()
				self.catchingThingDir_ = Vector3.Normalize(var_12_6:GetLocalPosition() - self.transform_.localPosition)
			end
		elseif GoldMinerManager.GetInstance():ThingIsActive(self.catchingThingID_) then
			self.rotaryTransform_.eulerAngles.z = arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z
			self.rotaryTransform_.eulerAngles = self.rotaryTransform_.eulerAngles

			if arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z > 0 and arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z <= 180 then
				if arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z > var_0_4 then
					var_0_3 = -1
				end
			elseif arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z > 180 and arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z <= 360 and arg_12_1 * self.angleSpeed_ * var_0_3 + self.rotaryTransform_.eulerAngles.z - 360 < -var_0_4 then
				var_0_3 = 1
			end

			if Vector3.Angle(Vector3.Normalize(self.hookTransform_.up * -1), self.catchingThingDir_) < 10 then
				self.hooking_ = true
				self.rotaryTransform_.up = self.catchingThingDir_ * -1
			end

			self:SetSpine("clue_idle", true)
		else
			self.catchingThingID_ = 0
		end
	elseif self.catchingThing_ ~= nil then
		self.catching_ = false

		if self.rotaryTransform_.eulerAngles.z >= 0 and self.rotaryTransform_.eulerAngles.z < 90 then
			self.hitImageTransform_.localScale.x = 1
			self.hitImageTransform_.localScale = self.hitImageTransform_.localScale
			self.fishContainer.localScale.x = 1
			self.fishContainer.localScale = self.fishContainer.localScale
		else
			local var_12_7 = self.hitImageTransform_.localScale

			var_12_7.x = -1
			self.hitImageTransform_.localScale = var_12_7
			self.fishContainer.localScale.x = -1
			self.fishContainer.localScale = self.fishContainer.localScale
		end

		if not self.catching_ then
			self:OnHookReturn()

			local var_12_8 = GameFishCfg[self.catchingThing_:GetData().fishId]

			self.hookTransform_.sizeDelta.y = self.hookTransform_.sizeDelta.y - var_0_2 * arg_12_1 / (var_12_8.weight * 0.5)

			if self.hookTransform_.sizeDelta.y <= self.oriHeight_ then
				self.hookTransform_.sizeDelta.y = self.oriHeight_

				GoldMinerManager.GetInstance():AddThiefThing(var_12_8.id)
				table.insert(self.catchThingList_, var_12_8.id)
				table.insert(self.catchThingItemList_, self.catchingThing_)
				self:UpdateThingView()

				self.hooking_ = false

				self.catchingThing_:SetActive(false)

				self.sleeping_ = true
				self.catchingThing_ = nil
				self.catchingThingID_ = 0
				self.catchingThingDir_ = nil
			end

			self.hookTransform_.sizeDelta = self.hookTransform_.sizeDelta
		end
	elseif self.catchingEmpty_ then
		self:OnHookReturn()

		self.hookTransform_.sizeDelta.y = self.hookTransform_.sizeDelta.y - var_0_2 * arg_12_1

		if self.hookTransform_.sizeDelta.y <= self.oriHeight_ then
			self.hookTransform_.sizeDelta.y = self.oriHeight_
			self.catchingEmpty_ = false
			self.hooking_ = false
			self.sleeping_ = true
			self.catchingThing_ = nil
			self.catchingThingID_ = 0
			self.catchingThingDir_ = nil
		end

		self.hookTransform_.sizeDelta = self.hookTransform_.sizeDelta
	else
		self:OnHookStart()

		self.hookTransform_.sizeDelta.y = self.hookTransform_.sizeDelta.y + var_0_1 * arg_12_1
		self.hookTransform_.sizeDelta = self.hookTransform_.sizeDelta

		local var_12_9 = self:GetHitThing()

		if var_12_9 then
			local var_12_10 = var_12_9:GetData()

			if var_12_10.fishId == 7 then
				return
			end

			self.catching_ = true

			var_12_9.transform_:SetParent(self.fishContainer, false)

			var_12_9.transform_.pivot = Vector2(var_12_10.pivotX / 100, 1 - var_12_10.pivotY / 100)
			var_12_9.transform_.localPosition = Vector2(0, 0)

			GoldMinerManager.GetInstance():RemoveThing(var_12_9)

			self.catchingThing_ = var_12_9
		elseif self:IsOutOfGameView() then
			self.catchingEmpty_ = true
		end
	end
end

function GoldMinerThief:IsOutOfGameView()
	local var_13_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_13_1 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_13_0, (self.hitGo_.transform:TransformPoint(0, 0, 0))) - UnityEngine.RectTransformUtility.WorldToScreenPoint(var_13_0, (GoldMinerManager.GetInstance():GetGameRoot():TransformPoint(0, 0, 0)))

	if -(1080 / Screen.height * var_13_1).y < 0 or -(1080 / Screen.height * var_13_1).y > 1080 or (1080 / Screen.height * var_13_1).x < 0 or (1080 / Screen.height * var_13_1).x > 1920 then
		return true
	end

	return false
end

function GoldMinerThief:GetHitThing()
	local var_14_0, var_14_1, var_14_2, var_14_3 = self:GetScreenCorners(self.hitGo_.transform)

	for iter_14_0, iter_14_1 in ipairs((GoldMinerManager.GetInstance():GetThing())) do
		if iter_14_1:GetID() == self.catchingThingID_ then
			local var_14_4 = iter_14_1:GetData()
			local var_14_5, var_14_6, var_14_7, var_14_8 = self:GetScreenCorners(iter_14_1.hitArea_)

			if self:HitCheckObb(var_14_0, var_14_1, var_14_2, var_14_3, var_14_5, var_14_6, var_14_7, var_14_8) then
				return iter_14_1
			end
		end
	end

	return nil
end

function GoldMinerThief:HitCheckObb(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7, arg_15_8)
	local var_15_0 = Vector2.New(((arg_15_1 + arg_15_3) / 2).x - ((arg_15_5 + arg_15_7) / 2).x, ((arg_15_1 + arg_15_3) / 2).y - ((arg_15_5 + arg_15_7) / 2).y)
	local var_15_1 = Vector2.New(arg_15_1.x - ((arg_15_1 + arg_15_3) / 2).x, arg_15_1.y - ((arg_15_1 + arg_15_3) / 2).y)
	local var_15_2 = Vector2.New(arg_15_2.x - ((arg_15_1 + arg_15_3) / 2).x, arg_15_2.y - ((arg_15_1 + arg_15_3) / 2).y)
	local var_15_3 = Vector2.New(arg_15_5.x - ((arg_15_5 + arg_15_7) / 2).x, arg_15_5.y - ((arg_15_5 + arg_15_7) / 2).y)
	local var_15_4 = Vector2.New(arg_15_6.x - ((arg_15_5 + arg_15_7) / 2).x, arg_15_6.y - ((arg_15_5 + arg_15_7) / 2).y)
	local var_15_5 = false

	for iter_15_0, iter_15_1 in ipairs({
		Vector2.Normalize(arg_15_2 - arg_15_1),
		Vector2.Normalize(arg_15_3 - arg_15_2),
		Vector2.Normalize(arg_15_6 - arg_15_5),
		Vector2.Normalize(arg_15_7 - arg_15_6)
	}) do
		if math.abs(iter_15_1.x * var_15_0.x + iter_15_1.y * var_15_0.y) > math.max(math.abs(iter_15_1.x * var_15_1.x + iter_15_1.y * var_15_1.y), (math.abs(iter_15_1.x * var_15_2.x + iter_15_1.y * var_15_2.y))) + math.max(math.abs(iter_15_1.x * var_15_3.x + iter_15_1.y * var_15_3.y), (math.abs(iter_15_1.x * var_15_4.x + iter_15_1.y * var_15_4.y))) then
			var_15_5 = true

			break
		end
	end

	return not var_15_5
end

function GoldMinerThief:GetScreenCorners(arg_16_1)
	local var_16_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	arg_16_1:GetWorldCorners(self.corners)

	return UnityEngine.RectTransformUtility.WorldToScreenPoint(var_16_0, self.corners[0]), UnityEngine.RectTransformUtility.WorldToScreenPoint(var_16_0, self.corners[1]), UnityEngine.RectTransformUtility.WorldToScreenPoint(var_16_0, self.corners[2]), (UnityEngine.RectTransformUtility.WorldToScreenPoint(var_16_0, self.corners[3]))
end

function GoldMinerThief:OnHookStart()
	self:SetSpine("clue_catch", true)

	if not self.isCallStartFunc_ then
		self.isCallStartFunc_ = true

		self.spine_.AnimationState:SetAnimation(0, var_0_6.pat, false)
	end
end

function GoldMinerThief:OnHookReturn()
	self:SetSpine("clue_take", true)

	if not self.isCallBackFunc_ then
		self.isCallBackFunc_ = true

		self.spine_.AnimationState:SetAnimation(0, var_0_6.back, false)
	end
end

function GoldMinerThief:SetSpine(arg_19_1, arg_19_2, arg_19_3)
	if arg_19_1 == self.animName_ then
		return
	end

	self.animName_ = self.hookSpine_.AnimationState:GetCurrent(0).Animation.Name

	self.hookSpine_.AnimationState:SetAnimation(0, arg_19_1, arg_19_2)

	if arg_19_3 then
		local function var_19_1()
			self.hookSpine_.AnimationState.Complete = self.hookSpine_.AnimationState.Complete - var_19_1

			arg_19_3()
		end

		self.hookSpine_.AnimationState.Complete = self.hookSpine_.AnimationState.Complete + nil
	end
end

function GoldMinerThief:Dispose()
	if self.catchingThing_ then
		self.catchingThing_:Dispose()

		self.catchingThing_ = nil
	end

	for iter_21_0, iter_21_1 in pairs(self.catchThingItemList_) do
		iter_21_1:Dispose()
	end

	self.catchThingItemList_ = nil

	Object.Destroy(self.gameObject_)
	GoldMinerThief.super.Dispose(self)
end

return GoldMinerThief
