local GoldMinerHook = class("GoldMinerHook", ReduxView)
local var_0_1 = 70
local var_0_2 = 1
local var_0_3 = 540
local var_0_4 = 1200
local var_0_6 = {
	x = 0,
	y = 0
}
local var_0_7 = 1000
local var_0_8 = 130
local var_0_9 = 80

function GoldMinerHook:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.gameView_ = arg_1_2

	self:Init()
end

function GoldMinerHook:Init()
	self.angleSpeed_ = 60
	self.hooking_ = false
	self.catchingThingIndex_ = 0
	self.catchingThing_ = nil
	self.movePointList_ = {}
	self.moveLineList_ = {}
	self.hookCurDir_ = nil
	self.curTransThing_ = nil
	self.boomShowTime_ = 0
	self.addPointSkillEnable_ = false
	self.addSpeedSkillEnable_ = false
	self.playBackAudio_ = false
	self.heroID_ = 0

	self:GetTmpCorners()
	self:InitUI()
end

function GoldMinerHook:InitUI()
	self:BindCfgUI()

	self.oriHeight_ = self.hookTransform_.rect.height
	self.hookSpine_ = self.hookSpineGo_:GetComponent("Spine.Unity.SkeletonGraphic")

	SetActive(self.boomAni_, false)
end

function GoldMinerHook:UseSkill(arg_4_1)
	self.heroID_ = arg_4_1

	if arg_4_1 == 1045 then
		self.addPointSkillEnable_ = true
	elseif arg_4_1 == 1046 then
		self.addSpeedSkillEnable_ = true
	end
end

function GoldMinerHook:ClearSkill()
	self.addPointSkillEnable_ = false
	self.addSpeedSkillEnable_ = false
end

function GoldMinerHook:StartHooking()
	if not self.hooking_ then
		self.hooking_ = true
		self.curTransThing_ = nil

		self.hookGo_.transform:SetParent(GoldMinerManager.GetInstance():GetGameRoot())

		self.movePointList_ = {
			(Vector2.New(self.hookGo_.transform.localPosition.x, self.hookGo_.transform.localPosition.y))
		}
		self.hookCurDir_ = (self.hitGo_.transform.position - self.hookTransform_.position):Normalize()

		return true
	end

	return false
end

function GoldMinerHook:TryToBoom()
	if self.catchingThingIndex_ > 0 and not self.catching_ then
		SetActive(self.boomAni_, true)

		self.boomAni_.transform.parent = self.gameView_.container_
		self.boomShowTime_ = 1

		self.catchingThing_:Dispose()

		self.catchingThing_ = nil
		self.catchingThingIndex_ = 0
		self.catchingEmpty_ = true

		self.gameView_:SubBoom(-1)

		return true
	end

	return false
end

function GoldMinerHook:Update(arg_8_1)
	if self.boomShowTime_ > 0 then
		self.boomShowTime_ = self.boomShowTime_ - arg_8_1

		if self.boomShowTime_ < 0 then
			SetActive(self.boomAni_, false)

			self.boomAni_.transform.parent = self.hitImageTransform_
			self.boomAni_.transform.localPosition = Vector3.New(0, 0, 0)
		end
	end

	if not self.hooking_ then
		self.isCallBackFunc_ = false
		self.playBackAudio_ = false
		self.rotaryTransform_.eulerAngles.z = arg_8_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z
		self.rotaryTransform_.eulerAngles = self.rotaryTransform_.eulerAngles

		if arg_8_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z > 0 and arg_8_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z <= 180 then
			if arg_8_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z > var_0_1 then
				var_0_2 = -1
			end
		elseif arg_8_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z > 180 and arg_8_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z <= 360 and arg_8_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z - 360 < -var_0_1 then
			var_0_2 = 1
		end

		self:SetSpine("clue_idle", true)
	elseif self.catchingThingIndex_ > 0 then
		self.catching_ = false

		if self.rotaryTransform_.eulerAngles.z >= 0 and self.rotaryTransform_.eulerAngles.z < 90 then
			self.hitImageTransform_.localScale.x = 1
			self.hitImageTransform_.localScale = self.hitImageTransform_.localScale
			self.fishContainer.localScale.x = 1
			self.fishContainer.localScale = self.fishContainer.localScale
		else
			local var_8_0 = self.hitImageTransform_.localScale

			var_8_0.x = -1
			self.hitImageTransform_.localScale = var_8_0
			self.fishContainer.localScale.x = -1
			self.fishContainer.localScale = self.fishContainer.localScale
		end

		if not self.catching_ then
			self:OnHookReturn()

			local var_8_1 = self.hookTransform_.sizeDelta
			local var_8_2 = GameFishCfg[self.catchingThing_:GetData().fishId]
			local var_8_3 = self.addSpeedSkillEnable_ and var_0_4 * ActivityGodEaterGoldminerHeroCfg[self.heroID_].skill_param or var_0_4

			var_8_1.y = var_8_1.y - var_8_3 * arg_8_1 / (var_8_2.weight * 0.5)

			if #self.movePointList_ > 1 then
				if var_8_1.y <= 0.1 then
					SetActive(self.moveLineList_[#self.movePointList_ - 1], false)

					self.hookTransform_.localPosition = Vector3.New(self.movePointList_[#self.movePointList_ - 1].x, self.movePointList_[#self.movePointList_ - 1].y, 0)
					self.hookTransform_.up = -Vector3.New((self.movePointList_[#self.movePointList_] - self.movePointList_[#self.movePointList_ - 1]).x, (self.movePointList_[#self.movePointList_] - self.movePointList_[#self.movePointList_ - 1]).y, 0):Normalize()

					table.remove(self.movePointList_, #self.movePointList_)

					var_8_1.y = Vector2.Distance(self.movePointList_[#self.movePointList_], self.movePointList_[#self.movePointList_ - 1])
				end
			elseif var_8_1.y > self.oriHeight_ and (var_8_2.id == 10 or var_8_2.id == 11) then
				if var_8_2.id == 10 then
					if var_8_1.y <= self.oriHeight_ + (var_0_8 or var_0_9) * (var_8_3 / var_0_4) then
						self.gameView_:PlayRoleSpine("eat", 1.5)
						self.gameView_:PlayAudio("kill")
					end
				end
			elseif var_8_1.y <= self.oriHeight_ then
				self.gameView_:PlayAudio("back4")

				var_8_1.y = self.oriHeight_

				if self.addPointSkillEnable_ then
					GoldMinerManager.GetInstance():AddScore(var_8_2.score * ActivityGodEaterGoldminerHeroCfg[self.heroID_].skill_param)
				else
					GoldMinerManager.GetInstance():AddScore(var_8_2.score)
				end

				GoldMinerManager.GetInstance():AddProp(var_8_2.id)

				if var_8_2.id == 12 then
					self.gameView_:SubBoom(1)
				end

				self.hooking_ = false
				self.curTransThing_ = nil

				self.hookGo_.transform:SetParent(self.rotaryTransform_)

				self.hookGo_.transform.localRotation = Quaternion.identity
				self.hookGo_.transform.localPosition = Vector3.New(var_0_6.x, var_0_6.y, 0)

				self.catchingThing_:Dispose()

				self.catchingThing_ = nil
				self.catchingThingIndex_ = 0
			end

			self.hookTransform_.sizeDelta = var_8_1
		end
	elseif self.catchingEmpty_ then
		self:OnHookReturn()

		local var_8_5 = self.hookTransform_.sizeDelta

		var_8_5.y = self.hookTransform_.sizeDelta.y - var_0_4 * arg_8_1

		if #self.movePointList_ > 1 then
			if var_8_5.y <= 0.1 then
				SetActive(self.moveLineList_[#self.movePointList_ - 1], false)

				self.hookTransform_.localPosition = Vector3.New(self.movePointList_[#self.movePointList_ - 1].x, self.movePointList_[#self.movePointList_ - 1].y, 0)
				self.hookTransform_.up = -Vector3.New((self.movePointList_[#self.movePointList_] - self.movePointList_[#self.movePointList_ - 1]).x, (self.movePointList_[#self.movePointList_] - self.movePointList_[#self.movePointList_ - 1]).y, 0):Normalize()

				table.remove(self.movePointList_, #self.movePointList_)

				var_8_5.y = Vector2.Distance(self.movePointList_[#self.movePointList_], self.movePointList_[#self.movePointList_ - 1])
			end
		elseif var_8_5.y <= self.oriHeight_ then
			self.gameView_:PlayAudio("back4")

			var_8_5.y = self.oriHeight_
			self.catchingEmpty_ = false
			self.hooking_ = false
			self.curTransThing_ = nil

			self.hookGo_.transform:SetParent(self.rotaryTransform_)

			self.hookGo_.transform.localRotation = Quaternion.identity
			self.hookGo_.transform.localPosition = Vector3.New(var_0_6.x, var_0_6.y, 0)
		end

		self.hookTransform_.sizeDelta = var_8_5
	else
		local var_8_6 = self.hookTransform_.sizeDelta

		var_8_6.y = self.hookTransform_.sizeDelta.y + var_0_3 * arg_8_1
		self.hookTransform_.sizeDelta = var_8_6

		self:SetSpine("clue_catch", true)

		local var_8_7, var_8_8 = self:GetHitThing()
		local var_8_9, var_8_10 = self:GetHitThief()

		if var_8_7 > 0 then
			local var_8_11 = var_8_8:GetData()

			if var_8_11.fishId == 7 then
				if var_8_8 ~= self.curTransThing_ then
					self.gameView_:PlayAudio("spring")

					self.curTransThing_ = var_8_8

					table.insert(self.movePointList_, (Vector2.New(self.curTransThing_.transform_.localPosition.x, self.curTransThing_.transform_.localPosition.y + 64)))

					local var_8_12

					if self.moveLineList_[#self.movePointList_ - 1] then
						var_8_12 = self.moveLineList_[#self.movePointList_ - 1]
					else
						var_8_12 = GameObject.Instantiate(self.lineGo_, GoldMinerManager.GetInstance():GetGameRoot())

						table.insert(self.moveLineList_, var_8_12)
					end

					SetActive(var_8_12, true)

					local var_8_13 = (self.movePointList_[#self.movePointList_] - self.movePointList_[#self.movePointList_ - 1]):Normalize()

					var_8_12.transform.localPosition = Vector3.New(self.movePointList_[#self.movePointList_ - 1].x, self.movePointList_[#self.movePointList_ - 1].y, 0)
					var_8_12.transform.up = Vector3.New(var_8_13.x, var_8_13.y, 0)
					var_8_12.transform.sizeDelta.y = Vector2.Distance(self.movePointList_[#self.movePointList_], self.movePointList_[#self.movePointList_ - 1])
					var_8_12.transform.sizeDelta = var_8_12.transform.sizeDelta
					self.hookTransform_.localPosition = Vector3.New(self.movePointList_[#self.movePointList_].x, self.movePointList_[#self.movePointList_].y, 0)
					self.hookTransform_.sizeDelta.y = 0
					self.hookTransform_.sizeDelta = self.hookTransform_.sizeDelta

					local var_8_14 = (self.hookCurDir_ - Vector3.up * 2 * Vector3.Dot(self.hookCurDir_, Vector3.up)):Normalize()

					self.hookCurDir_ = var_8_14
					self.hookTransform_.up = -Vector3.New(var_8_14.x, var_8_14.y, 0)
				end
			else
				self.gameView_:PlayAudio("catch")

				self.catchingThingIndex_ = var_8_7
				self.catching_ = true

				var_8_8.transform_:SetParent(self.fishContainer, false)

				var_8_8.transform_.pivot = Vector2(var_8_11.pivotX / 100, 1 - var_8_11.pivotY / 100)
				var_8_8.transform_.localPosition = Vector2(0, 0)

				GoldMinerManager.GetInstance():RemoveThing(var_8_8)

				self.catchingThing_ = var_8_8
			end
		elseif var_8_9 > 0 then
			local var_8_15, var_8_16 = var_8_10:TryToGetThing()

			if var_8_15 > 0 then
				self.catchingThingIndex_ = var_0_7
				self.catching_ = true

				var_8_16:SetActive(true)

				local var_8_17 = var_8_16:GetData()

				var_8_16.transform_:SetParent(self.fishContainer, false)

				var_8_16.transform_.pivot = Vector2(var_8_17.pivotX / 100, 1 - var_8_17.pivotY / 100)
				var_8_16.transform_.localPosition = Vector2(0, 0)
				self.catchingThing_ = var_8_16
			end
		elseif self:IsOutOfGameView() then
			self.catchingEmpty_ = true
		end
	end
end

function GoldMinerHook:IsOutOfGameView()
	local var_9_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_9_1 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_9_0, (self.hitGo_.transform:TransformPoint(0, 0, 0))) - UnityEngine.RectTransformUtility.WorldToScreenPoint(var_9_0, (GoldMinerManager.GetInstance():GetGameRoot():TransformPoint(0, 0, 0)))

	if -(1080 / Screen.height * var_9_1).y < 0 or -(1080 / Screen.height * var_9_1).y > 1080 or (1080 / Screen.height * var_9_1).x < 0 or (1080 / Screen.height * var_9_1).x > 1920 then
		return true
	end

	return false
end

function GoldMinerHook:GetHitThing()
	local var_10_0, var_10_1, var_10_2, var_10_3 = self:GetScreenCorners(self.hitGo_.transform)

	for iter_10_0, iter_10_1 in ipairs((GoldMinerManager.GetInstance():GetThing())) do
		local var_10_4 = iter_10_1:GetData()
		local var_10_5, var_10_6, var_10_7, var_10_8 = self:GetScreenCorners(iter_10_1.hitArea_)

		if self:HitCheckObb(var_10_0, var_10_1, var_10_2, var_10_3, var_10_5, var_10_6, var_10_7, var_10_8) then
			return iter_10_0, iter_10_1
		end
	end

	return 0
end

function GoldMinerHook:GetHitThief()
	local var_11_0, var_11_1, var_11_2, var_11_3 = self:GetScreenCorners(self.hitGo_.transform)

	for iter_11_0, iter_11_1 in ipairs((GoldMinerManager.GetInstance():GetThief())) do
		local var_11_4 = iter_11_1:GetData()
		local var_11_5, var_11_6, var_11_7, var_11_8 = self:GetScreenCorners(iter_11_1.hitArea_)

		if self:HitCheckObb(var_11_0, var_11_1, var_11_2, var_11_3, var_11_5, var_11_6, var_11_7, var_11_8) then
			return iter_11_0, iter_11_1
		end
	end

	return 0
end

function GoldMinerHook:GetScreenCorners(arg_12_1)
	local var_12_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	arg_12_1:GetWorldCorners(self.corners)

	return UnityEngine.RectTransformUtility.WorldToScreenPoint(var_12_0, self.corners[0]), UnityEngine.RectTransformUtility.WorldToScreenPoint(var_12_0, self.corners[1]), UnityEngine.RectTransformUtility.WorldToScreenPoint(var_12_0, self.corners[2]), (UnityEngine.RectTransformUtility.WorldToScreenPoint(var_12_0, self.corners[3]))
end

function GoldMinerHook:HitCheckObb(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6, arg_13_7, arg_13_8)
	local var_13_0 = Vector2.New(((arg_13_1 + arg_13_3) / 2).x - ((arg_13_5 + arg_13_7) / 2).x, ((arg_13_1 + arg_13_3) / 2).y - ((arg_13_5 + arg_13_7) / 2).y)
	local var_13_1 = Vector2.New(arg_13_1.x - ((arg_13_1 + arg_13_3) / 2).x, arg_13_1.y - ((arg_13_1 + arg_13_3) / 2).y)
	local var_13_2 = Vector2.New(arg_13_2.x - ((arg_13_1 + arg_13_3) / 2).x, arg_13_2.y - ((arg_13_1 + arg_13_3) / 2).y)
	local var_13_3 = Vector2.New(arg_13_5.x - ((arg_13_5 + arg_13_7) / 2).x, arg_13_5.y - ((arg_13_5 + arg_13_7) / 2).y)
	local var_13_4 = Vector2.New(arg_13_6.x - ((arg_13_5 + arg_13_7) / 2).x, arg_13_6.y - ((arg_13_5 + arg_13_7) / 2).y)
	local var_13_5 = false

	for iter_13_0, iter_13_1 in ipairs({
		Vector2.Normalize(arg_13_2 - arg_13_1),
		Vector2.Normalize(arg_13_3 - arg_13_2),
		Vector2.Normalize(arg_13_6 - arg_13_5),
		Vector2.Normalize(arg_13_7 - arg_13_6)
	}) do
		if math.abs(iter_13_1.x * var_13_0.x + iter_13_1.y * var_13_0.y) > math.max(math.abs(iter_13_1.x * var_13_1.x + iter_13_1.y * var_13_1.y), (math.abs(iter_13_1.x * var_13_2.x + iter_13_1.y * var_13_2.y))) + math.max(math.abs(iter_13_1.x * var_13_3.x + iter_13_1.y * var_13_3.y), (math.abs(iter_13_1.x * var_13_4.x + iter_13_1.y * var_13_4.y))) then
			var_13_5 = true

			break
		end
	end

	return not var_13_5
end

function GoldMinerHook:RegisterBackFunc(arg_14_1)
	self.backFunc_ = arg_14_1
end

function GoldMinerHook:OnHookReturn()
	self:SetSpine("clue_take", true)

	if not self.playBackAudio_ then
		if self.addSpeedSkillEnable_ then
			self.gameView_:PlayAudio("back1")
			self.gameView_:PlayAudio("back2")
		else
			self.gameView_:PlayAudio("back1")
			self.gameView_:PlayAudio("back3")
		end

		self.playBackAudio_ = true
	end

	if not self.isCallBackFunc_ and self.backFunc_ then
		self.backFunc_()

		self.isCallBackFunc_ = true
	end
end

function GoldMinerHook:GetTmpCorners()
	if self.corners == nil then
		self.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end
end

function GoldMinerHook:Reset()
	if self.catchingThing_ then
		self.catchingThing_:Dispose()

		self.catchingThing_ = nil
	end

	local var_17_0 = self.hookTransform_.sizeDelta

	if self.hookTransform_.sizeDelta.y <= self.oriHeight_ then
		var_17_0.y = self.oriHeight_
	end

	self.hooking_ = false
	self.curTransThing_ = nil

	self.hookGo_.transform:SetParent(self.rotaryTransform_)

	self.hookGo_.transform.localRotation = Quaternion.identity
	self.hookGo_.transform.localPosition = Vector3.New(var_0_6.x, var_0_6.y, 0)
	self.catchingThingIndex_ = 0
	self.hookTransform_.sizeDelta = var_17_0
	self.rotaryTransform_.eulerAngles.z = 0
	self.rotaryTransform_.eulerAngles = self.rotaryTransform_.eulerAngles
end

function GoldMinerHook:SetSpine(arg_18_1, arg_18_2, arg_18_3)
	if arg_18_1 == self.animName_ then
		return
	end

	self.animName_ = self.hookSpine_.AnimationState:GetCurrent(0).Animation.Name

	self.hookSpine_.AnimationState:SetAnimation(0, arg_18_1, arg_18_2)

	if arg_18_3 then
		local function var_18_1()
			self.hookSpine_.AnimationState.Complete = self.hookSpine_.AnimationState.Complete - var_18_1

			arg_18_3()
		end

		self.hookSpine_.AnimationState.Complete = self.hookSpine_.AnimationState.Complete + nil
	end
end

function GoldMinerHook:Dispose()
	if self.catchingThing_ then
		self.catchingThing_:Dispose()

		self.catchingThing_ = nil
	end

	local var_20_0 = self.hookTransform_.sizeDelta

	if self.hookTransform_.sizeDelta.y <= self.oriHeight_ then
		var_20_0.y = self.oriHeight_
	end

	self.hookTransform_.sizeDelta = var_20_0

	GoldMinerHook.super.Dispose(self)
end

return GoldMinerHook
