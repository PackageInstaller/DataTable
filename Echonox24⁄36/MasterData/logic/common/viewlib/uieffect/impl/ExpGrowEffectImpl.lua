-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/uieffect/impl/ExpGrowEffectImpl.lua

module("logic.common.viewlib.uieffect.impl.ExpGrowEffectImpl", package.seeall)

local M = class("ExpGrowEffectImpl", UIEffectBase)

M.gameObject = nil
M._txpCurExp = nil
M._imgExpProgress = nil
M._tweenNumber = 0
M._levelHandler = nil
M._finishHandler = nil
M._expIdx = 1
M._curExp = 0
M._exps = nil

function M:_buildUI(mainGO)
	self.gameObject = mainGO
	self._txpCurExp = goutil.findChildTextComponent(self.gameObject, "txtExp")
	self._imgExpProgress = goutil.findChildImageComponent(self.gameObject, "exp")
	self._levelHandler = Handler.New()
	self._finishHandler = Handler.New()
end

function M:_destroyUI()
	self:stop()
end

function M:initExp(curExp, exps)
	self._curExp = curExp
	self._exps = exps
	self._expIdx = 1
	self._txpCurExp.text = string.format("%d/%d", curExp, exps[self._expIdx])
	self._imgExpProgress.fillAmount = curExp / exps[self._expIdx]
end

function M:growExp(targetExp)
	local curShowExp = self._curExp
	local sequence = DG.Tweening.DOTween.Sequence()

	for i = 1, #self._exps - 1 do
		local targetExp = self._exps[i]
		local duration = 1 - curShowExp / targetExp

		sequence:AppendCallback(self._onOneLevelPreCallback, self, {
			duration = duration,
			from = curShowExp,
			to = targetExp
		})
		sequence:Append(self._imgExpProgress:DOFillAmount(1, duration))
		sequence:AppendCallback(self._onOneLevelPostCallback, self)
		sequence:AppendInterval(0.05)

		curShowExp = 0
	end

	local duration = (targetExp - curShowExp) / self._exps[#self._exps] * 2

	sequence:AppendCallback(self._onOneLevelPreCallback, self, {
		duration = duration,
		from = curShowExp,
		to = targetExp,
		max = self._exps[#self._exps]
	})
	sequence:Append(self._imgExpProgress:DOFillAmount(targetExp / self._exps[#self._exps], duration))
	sequence:AppendCallback(self._onFinishPostCallback, self)
	sequence:SetTarget(self.mainGO)
end

function M:stop()
	DG.Tweening.DOTween.Kill(self.gameObject)

	if self._tweenNumber > 0 then
		TweenUtil.killTween(self._tweenNumber)

		self._tweenNumber = 0
	end
end

function M:setLevelCallback(callback, handler)
	self._levelHandler:setListener(callback, handler)
end

function M:setFinishCallback(callback, handler)
	self._finishHandler:setListener(callback, handler)
end

function M:_onOneLevelPreCallback(values)
	self._txpCurExp.text = string.format("%d/%d", values.from, values.to)
	self._tweenNumber = TweenUtil.tweenNumber(self._onUpdateExp, self, values.from, values.to, values.duration)
end

function M:_onOneLevelPostCallback()
	TweenUtil.killTween(self._tweenNumber)

	self._tweenNumber = 0
	self._imgExpProgress.fillAmount = 0
	self._expIdx = self._expIdx + 1

	self._levelHandler:call(self._expIdx - 1)
end

function M:_onFinishPostCallback()
	self._finishHandler:call()
end

function M:_onUpdateExp(exp)
	self._txpCurExp.text = string.format("%d/%d", exp, self._exps[self._expIdx])
end

return M
