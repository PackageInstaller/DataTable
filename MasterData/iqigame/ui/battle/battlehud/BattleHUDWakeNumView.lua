-- chunkname: @IQIGame\\UI\\Battle\\BattleHUD\\BattleHUDWakeNumView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.breakEffect.gameObject:SetActive(false)
	self.changeEffect.gameObject:SetActive(false)

	self.changeAnim = self.normalLvText.gameObject:GetComponent("Animation")
end

function m:UpdateWakeNum(num, showEffect)
	self.breakEffect.gameObject:SetActive(false)
	self.changeEffect.gameObject:SetActive(false)

	if num == 0 then
		self:__onWakeBreak(showEffect)
	else
		self:__OnWakeChange(num, showEffect)
	end
end

function m:__OnWakeChange(num, showEffect)
	self.normalState.gameObject:SetActive(true)

	self.normalLvText.gameObject:GetComponent(typeof(UnityEngine.UI.Text)).text = tostring(num)

	self.breakState.gameObject:SetActive(false)

	if not showEffect then
		return
	end

	self.changeEffect.gameObject:SetActive(true)

	if self.changeAnim.isPlaying then
		return
	end

	self.changeAnim:Play(BattleUIApi:GetWakeChangeEffectAnimName())
end

function m:__onWakeBreak(showEffect)
	self.normalState.gameObject:SetActive(false)
	self.breakState.gameObject:SetActive(true)

	if showEffect then
		self.breakEffect.gameObject:SetActive(true)
	end
end

function m:Show()
	self.normalState.gameObject:SetActive(false)
	self.breakState.gameObject:SetActive(false)
	self.breakEffect.gameObject:SetActive(false)
	self.changeEffect.gameObject:SetActive(false)
	self.gameObject:SetActive(true)
end

function m:Hide()
	self.gameObject:SetActive(false)
end

function m:Dispose()
	self.changeAnim = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return m
