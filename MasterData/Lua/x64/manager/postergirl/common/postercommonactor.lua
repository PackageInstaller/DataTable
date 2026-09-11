local PosterCommonActor = class("PosterCommonActor", PosterGirlBaseActor)

function PosterCommonActor:Ctor(arg_1_1, arg_1_2)
	PosterCommonActor.super.Ctor(self, arg_1_1, arg_1_2)
	self:InitSceneEffect()
end

function PosterCommonActor:GetModelPath()
	return HeroUITimelineMgr.GetModelPath(self:GetSkinId(), self:GetModelId())
end

function PosterCommonActor:LoadModel()
	PosterCommonActor.super.LoadModel(self)

	self.animator = self.ui_tpose:GetComponent(typeof(Animator))

	self:GetHeroTimelineMgr():BindHero(self:GetSkinId(), self:GetModelId(), self.tpose)
end

function PosterCommonActor:GetTag()
	return PosterGirlConst.PosterGirlTag.common
end

function PosterCommonActor:GetAnimator()
	return self.animator
end

function PosterCommonActor:GetState(arg_6_1)
	if self._states[arg_6_1] then
		return self._states[arg_6_1]
	end

	local var_6_0 = PosterGirlTools.ProduceCommonState(arg_6_1, self)

	if var_6_0 ~= nil then
		var_6_0:SetStateKey(arg_6_1)

		self._states[arg_6_1] = var_6_0

		return var_6_0
	end
end

function PosterCommonActor:GetInteractionCfg()
	if self.skinId == 108501 then
		local var_7_0 = tonumber("99" .. self.skinId)

		if HeroTools.GetOldInteractionCfg(var_7_0) then
			return self:_GetInteractionCfg(var_7_0)
		end
	end

	return self:_GetInteractionCfg(nullable(SkinCfg, self.skinId, "hero") or HeroTools.GetHeroIDFromFormID(self.skinId))
end

function PosterCommonActor:RegisterEvents()
	self:RegisterActorEvents("ON_SCENE_INTERACT", self.OnSceneInteract)
end

function PosterCommonActor:PlayTalkVoice(arg_9_1, arg_9_2, arg_9_3)
	return HeroTools.PlayTalkForceUseOriginalSkinID(arg_9_1, arg_9_2, arg_9_3, self:GetModel().transform)
end

function PosterCommonActor:DoShacking()
	if not self:CheckInitState() then
		return
	end

	self:ChangeState(PosterGirlConst.StateKay.shake)
	self.super.DoShacking(self)
end

function PosterCommonActor:DoTouch()
	if not self:CheckInitState() then
		return
	end

	self:ChangeState(PosterGirlConst.StateKay.touch)
	self.super.DoTouch(self)
end

function PosterCommonActor:DoQuickTouch()
	if not self:CheckInitState() then
		return
	end

	self:ChangeState(PosterGirlConst.StateKay.quickclick)
	self.super.DoQuickTouch(self)
end

function PosterCommonActor:DoShowing()
	if not self:CheckInitState() then
		return
	end

	self:ChangeState(PosterGirlConst.StateKay.show)
	self.super.DoShowing(self)
end

function PosterCommonActor:DoGreeting()
	if not self:CheckInitState() then
		return
	end

	self:ChangeState(PosterGirlConst.StateKay.greet)
	self.super.DoGreeting(self)
end

function PosterCommonActor:DoIdle()
	if not self:CheckInitState() then
		return
	end

	self:ChangeState(PosterGirlConst.StateKay.idle)
end

function PosterCommonActor:DoInit(arg_16_1)
	self:ChangeState(PosterGirlConst.StateKay.init)
end

local var_0_1 = 0.4

function PosterCommonActor:DoAction(arg_17_1, arg_17_2)
	if arg_17_1 == nil then
		self:ChangeState(PosterGirlConst.StateKay.init)
	else
		self:ChangeState(PosterGirlConst.StateKay.custom)
		self:AddInteractionsTimes()

		local var_17_0 = self:GetCurrentState()

		var_17_0:PlayAni(arg_17_1, arg_17_2)
		var_17_0:SetCompleteCallback(function()
			self:ChangeState(PosterGirlConst.StateKay.init)
		end)
	end
end

function PosterCommonActor:DoActionChain(arg_19_1, arg_19_2, ...)
	if arg_19_1 == nil then
		self:ChangeState(PosterGirlConst.StateKay.init)
	else
		self:ChangeState(PosterGirlConst.StateKay.custom)
		self:AddInteractionsTimes()

		local var_19_0
		local var_19_1

		if type(arg_19_2) == "number" then
			var_19_1 = arg_19_2
			var_19_0 = {
				...
			}
		else
			var_19_1 = var_0_1
			var_19_0 = {
				arg_19_2,
				...
			}
		end

		local var_19_2 = self:GetCurrentState()

		var_19_2:PlayAni(arg_19_1, var_19_1)
		var_19_2:SetCompleteCallback(function()
			self:DoActionChain(unpack(var_19_0))
		end)
	end
end

function PosterCommonActor:Dispose()
	self:GetHeroTimelineMgr():Unbind()
	PosterCommonActor.super.Dispose(self)
end

local function var_0_2(arg_22_0, arg_22_1, ...)
	if arg_22_0 == nil then
		return {}
	end

	local var_22_0 = var_0_2(...)

	var_22_0[arg_22_0] = arg_22_1

	return var_22_0
end

local var_0_3 = {
	play = function(self, ...)
		self:DoActionChain(...)
		self:RecordDoActionChain({
			...
		})
	end,
	talk = function(self, ...)
		self:DoSpecialTalk(...)
	end,
	jump = function(arg_25_0, arg_25_1, arg_25_2)
		JumpTools.OpenPageByJump(arg_25_1, arg_25_2)
	end,
	record = function(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
		SDKTools.SendMessageToSDK("activity_combat_over", {
			sys_id = arg_26_1,
			skin_id = arg_26_2,
			scene_id = arg_26_3,
			other_data = arg_26_4
		})
	end,
	recordCustom = function(arg_27_0, arg_27_1, arg_27_2)
		SDKTools.SendMessageToSDK(arg_27_1, arg_27_2)
	end,
	print = function(arg_28_0, ...)
		print(...)
	end
}

function PosterCommonActor:OnSceneInteract(arg_29_1, ...)
	local var_29_0 = nullable(var_0_3, arg_29_1)

	if manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.home and var_29_0 then
		var_29_0(self, ...)
	end
end

local cjson = require("cjson")

function PosterCommonActor:RecordDoActionChain(arg_30_1)
	SDKTools.SendMessageToSDK("activity_combat_over", {
		sys_id = 101,
		skin_id = self.skinId,
		scene_id = HomeSceneSettingData:GetCurScene(),
		other_data = cjson.encode(arg_30_1)
	})
end

return PosterCommonActor
