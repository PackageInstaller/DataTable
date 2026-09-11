local FishHook = class("FishHook", ReduxView)
local var_0_1 = 70
local var_0_2 = 1
local var_0_3 = 540
local var_0_4 = 1200
local var_0_5 = 1200

function FishHook:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.catchingFishIndex_ = 0

	self:Init()
end

function FishHook:Init()
	self.angleSpeed_ = 60

	self:GetTmpCorners()
	self:InitUI()
	self:AddUIListener()
end

function FishHook:InitUI()
	self:BindCfgUI()

	self.haveBuffController_ = ControllerUtil.GetController(self.gameObject_.transform, "haveBuff")
	self.oriHeight_ = self.hookTransform_.rect.height

	FishGameManager.GetInstance():AddBuffHandler(handler(self, self.OnBuffChange))
end

function FishHook:OnBuffChange(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == 2 then
		self.haveBuffController_:SetSelectedState("true")
	else
		self.haveBuffController_:SetSelectedState("false")
	end
end

function FishHook:AddUIListener()
	return
end

function FishHook:AddEventListeners()
	return
end

function FishHook:OnTop()
	self:UpdateBar()
end

function FishHook:UpdateBar()
	return
end

function FishHook:OnEnter()
	self:AddEventListeners()
end

function FishHook:OnExit()
	self:RemoveAllEventListener()
end

function FishHook:StartHooking()
	if not self.hooking_ then
		self.hooking_ = true

		manager.audio:PlayEffect("minigame_fishing", "fishing_hook_swing", "")
	end
end

function FishHook:Update(arg_12_1)
	if not self.hooking_ then
		FishGameManager.GetInstance():SetStatus("idle")
		self:SwitchToAnimatorState("Hook_idle")

		self.rotaryTransform_.eulerAngles.z = arg_12_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z
		self.rotaryTransform_.eulerAngles = self.rotaryTransform_.eulerAngles

		if arg_12_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z > 0 and arg_12_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z <= 180 then
			if arg_12_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z > var_0_1 then
				var_0_2 = -1
			end
		elseif arg_12_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z > 180 and arg_12_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z <= 360 and arg_12_1 * self.angleSpeed_ * var_0_2 + self.rotaryTransform_.eulerAngles.z - 360 < -var_0_1 then
			var_0_2 = 1
		end
	elseif self.catchingFishIndex_ >= 1 then
		if self.catchingFish_:GetData().fishId == 4 then
			FishGameManager.GetInstance():SetStatus("fail")
		else
			FishGameManager.GetInstance():SetStatus("catch")
		end

		self:SwitchToAnimatorState("Hook_catch", function()
			self.catching_ = false
			self.animator_.speed = 0
		end)

		if self.rotaryTransform_.eulerAngles.z >= 0 and self.rotaryTransform_.eulerAngles.z < 90 then
			self.hitImageTransform_.localScale.x = 1
			self.hitImageTransform_.localScale = self.hitImageTransform_.localScale
			self.fishContainer.localScale.x = 1
			self.fishContainer.localScale = self.fishContainer.localScale
		else
			local var_12_0 = self.hitImageTransform_.localScale

			var_12_0.x = -1
			self.hitImageTransform_.localScale = var_12_0
			self.fishContainer.localScale.x = -1
			self.fishContainer.localScale = self.fishContainer.localScale
		end

		if not self.catching_ then
			local var_12_1 = self.hookTransform_.sizeDelta
			local var_12_2 = GameFishCfg[self.catchingFish_:GetData().fishId]

			var_12_1.y = FishGameManager.GetInstance():GetBuff() == 2 and var_12_1.y - var_0_5 * arg_12_1 or var_12_1.y - var_0_4 * arg_12_1 / (var_12_2.weight * 0.5)

			if var_12_1.y <= self.oriHeight_ then
				var_12_1.y = self.oriHeight_

				FishGameManager.GetInstance():AddScore(var_12_2.score)

				if self.catchingFish_:GetData().fishId == 6 then
					FishGameManager.GetInstance():RandomBuff()
				elseif self.catchingFish_:GetData().fishId == 5 then
					FishGameManager.GetInstance():AddTreasure()
				end

				FishGameManager.GetInstance():CheckEnd()

				self.hooking_ = false

				FishGameManager.GetInstance():PlayFishDisappear(self.catchingFish_, function(arg_14_0)
					arg_14_0:Dispose()
				end)

				self.catchingFish_ = nil
				self.catchingFishIndex_ = 0

				manager.audio:PlayEffect("minigame_fishing", "fishing_hook_swing", "")
			end

			self.hookTransform_.sizeDelta = var_12_1
		end
	elseif self.catchingEmpty_ then
		FishGameManager.GetInstance():SetStatus("fail")
		self:SwitchToAnimatorState("Hook_catchEmpty", function()
			self.animator_.speed = 0
		end)

		self.hookTransform_.sizeDelta.y = self.hookTransform_.sizeDelta.y - var_0_4 * arg_12_1

		if self.hookTransform_.sizeDelta.y <= self.oriHeight_ then
			self.hookTransform_.sizeDelta.y = self.oriHeight_
			self.catchingEmpty_ = false
			self.hooking_ = false

			manager.audio:PlayEffect("minigame_fishing", "fishing_hook_swing", "")
		end

		self.hookTransform_.sizeDelta = self.hookTransform_.sizeDelta
	else
		FishGameManager.GetInstance():SetStatus("cast")
		self:SwitchToAnimatorState("Hook_cast", function()
			self.animator_.speed = 0
		end)

		self.hookTransform_.sizeDelta.y = self.hookTransform_.sizeDelta.y + var_0_3 * arg_12_1
		self.hookTransform_.sizeDelta = self.hookTransform_.sizeDelta

		local var_12_3, var_12_4 = self:GetHitFish()

		if var_12_3 > 0 then
			local var_12_5 = var_12_4:GetData()

			self.catchingFishIndex_ = var_12_3
			self.catching_ = true

			var_12_4.transform_:SetParent(self.fishContainer, false)

			var_12_4.transform_.pivot = Vector2(var_12_5.pivotX / 100, 1 - var_12_5.pivotY / 100)
			var_12_4.transform_.localPosition = Vector2(0, 0)

			FishGameManager.GetInstance():RemoveFish(var_12_4)

			self.catchingFish_ = var_12_4
		elseif self:IsOutOfGameView() then
			self.catchingEmpty_ = true

			manager.audio:PlayEffect("minigame_fishing", "fishing_hook_up_empty", "")
		end
	end

	if self.animator_:GetCurrentAnimatorStateInfo(0):IsName(self.curState_) and self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 and self.handler_ ~= nil then
		self.handler_(self.curState_)
	end
end

function FishHook:SwitchToAnimatorState(arg_17_1, arg_17_2)
	if self.curState_ ~= nil and arg_17_1 == self.curState_ then
		return
	end

	self.handler_ = arg_17_2
	self.curState_ = arg_17_1

	self.animator_:Play(arg_17_1, -1, 0)

	self.animator_.speed = 1
end

function FishHook:IsOutOfGameView()
	local var_18_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_18_1 = FishGameManager.GetInstance()
	local var_18_2 = var_18_1:GetGameRoot()

	if -(1080 / Screen.height * var_18_1).y > 1080 or (1080 / Screen.height * var_18_2).x < 0 or (1080 / Screen.height * var_18_2).x > 1920 then
		CustomLog.Log(string.format("out !!!!!!!!!!!!!!!, screenPoint = %s", tostring(1080 / Screen.height * (UnityEngine.RectTransformUtility.WorldToScreenPoint(var_18_0, (self.hitGo_.transform:TransformPoint(0, 0, 0))) - UnityEngine.RectTransformUtility.WorldToScreenPoint(var_18_0, (var_18_2:TransformPoint(0, 0, 0)))))))

		return true
	end

	return false
end

function FishHook:GetHitFish()
	local var_19_0, var_19_1, var_19_2, var_19_3 = self:GetScreenCorners(self.hitGo_.transform)

	for iter_19_0, iter_19_1 in ipairs((FishGameManager.GetInstance():GetFishes())) do
		local var_19_4 = iter_19_1:GetData()
		local var_19_5, var_19_6, var_19_7, var_19_8 = self:GetScreenCorners(iter_19_1.hitArea_)

		if self:HitCheckObb(var_19_0, var_19_1, var_19_2, var_19_3, var_19_5, var_19_6, var_19_7, var_19_8) then
			return iter_19_0, iter_19_1
		end
	end

	return 0
end

function FishHook:GetScreenCorners(arg_20_1)
	local var_20_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	arg_20_1:GetWorldCorners(self.corners)

	return UnityEngine.RectTransformUtility.WorldToScreenPoint(var_20_0, self.corners[0]), UnityEngine.RectTransformUtility.WorldToScreenPoint(var_20_0, self.corners[1]), UnityEngine.RectTransformUtility.WorldToScreenPoint(var_20_0, self.corners[2]), (UnityEngine.RectTransformUtility.WorldToScreenPoint(var_20_0, self.corners[3]))
end

function FishHook:HitCheckObb(arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6, arg_21_7, arg_21_8)
	local var_21_0 = Vector2.New(((arg_21_1 + arg_21_3) / 2).x - ((arg_21_5 + arg_21_7) / 2).x, ((arg_21_1 + arg_21_3) / 2).y - ((arg_21_5 + arg_21_7) / 2).y)
	local var_21_1 = Vector2.New(arg_21_1.x - ((arg_21_1 + arg_21_3) / 2).x, arg_21_1.y - ((arg_21_1 + arg_21_3) / 2).y)
	local var_21_2 = Vector2.New(arg_21_2.x - ((arg_21_1 + arg_21_3) / 2).x, arg_21_2.y - ((arg_21_1 + arg_21_3) / 2).y)
	local var_21_3 = Vector2.New(arg_21_5.x - ((arg_21_5 + arg_21_7) / 2).x, arg_21_5.y - ((arg_21_5 + arg_21_7) / 2).y)
	local var_21_4 = Vector2.New(arg_21_6.x - ((arg_21_5 + arg_21_7) / 2).x, arg_21_6.y - ((arg_21_5 + arg_21_7) / 2).y)
	local var_21_5 = false

	for iter_21_0, iter_21_1 in ipairs({
		Vector2.Normalize(arg_21_2 - arg_21_1),
		Vector2.Normalize(arg_21_3 - arg_21_2),
		Vector2.Normalize(arg_21_6 - arg_21_5),
		Vector2.Normalize(arg_21_7 - arg_21_6)
	}) do
		if math.abs(iter_21_1.x * var_21_0.x + iter_21_1.y * var_21_0.y) > math.max(math.abs(iter_21_1.x * var_21_1.x + iter_21_1.y * var_21_1.y), (math.abs(iter_21_1.x * var_21_2.x + iter_21_1.y * var_21_2.y))) + math.max(math.abs(iter_21_1.x * var_21_3.x + iter_21_1.y * var_21_3.y), (math.abs(iter_21_1.x * var_21_4.x + iter_21_1.y * var_21_4.y))) then
			var_21_5 = true

			break
		end
	end

	return not var_21_5
end

function FishHook:GetTmpCorners()
	if self.corners == nil then
		self.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end
end

function FishHook:Reset()
	if self.catchingFish_ then
		self.catchingFish_:Dispose()

		self.catchingFish_ = nil
	end

	local var_23_0 = self.hookTransform_.sizeDelta

	if self.hookTransform_.sizeDelta.y <= self.oriHeight_ then
		var_23_0.y = self.oriHeight_
	end

	self.hooking_ = false
	self.catchingFishIndex_ = 0
	self.hookTransform_.sizeDelta = var_23_0
	self.rotaryTransform_.eulerAngles.z = 0
	self.rotaryTransform_.eulerAngles = self.rotaryTransform_.eulerAngles
end

function FishHook:Dispose()
	if self.catchingFish_ then
		self.catchingFish_:Dispose()

		self.catchingFish_ = nil
	end

	local var_24_0 = self.hookTransform_.sizeDelta

	if self.hookTransform_.sizeDelta.y <= self.oriHeight_ then
		var_24_0.y = self.oriHeight_
	end

	self.hookTransform_.sizeDelta = var_24_0

	FishHook.super.Dispose(self)
end

return FishHook
