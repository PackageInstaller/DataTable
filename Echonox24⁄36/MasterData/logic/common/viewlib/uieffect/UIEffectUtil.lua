-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/uieffect/UIEffectUtil.lua

module("logic.common.viewlib.uieffect.UIEffectUtil", package.seeall)

local UIEffectUtil = class("UIEffectUtil")

function UIEffectUtil.getButtonTransition(goTarget)
	return UIEffectUtil.getEffect(UIEffectEnum.BUTTON_TRANSITION, goTarget)
end

function UIEffectUtil.getTextRollingEffect(goTarget)
	return UIEffectUtil.getEffect(UIEffectEnum.TEXT_ROLLING, goTarget)
end

function UIEffectUtil.getTextWaveEffect(goTarget)
	return UIEffectUtil.getEffect(UIEffectEnum.TEXT_WAVE, goTarget)
end

function UIEffectUtil.getChildTextRollingEffect(container, childName)
	return UIEffectUtil.getChildEffect(UIEffectEnum.TEXT_ROLLING, container, childName)
end

function UIEffectUtil.getChildEffect(effectEnum, container, childName)
	return UIEffectUtil._instance:_getChildEffect(effectEnum, container, childName)
end

function UIEffectUtil.getEffect(effectEnum, goTarget)
	return UIEffectUtil._instance:_getEffect(effectEnum, goTarget)
end

function UIEffectUtil:ctor()
	self._effectMap = {}

	self:_registerEffect(UIEffectEnum.TEXT_ROLLING, TextRollingEffectImpl)
	self:_registerEffect(UIEffectEnum.BUTTON_TRANSITION, ButtonTransitionImpl)
	self:_registerEffect(UIEffectEnum.TEXT_WAVE, TextWaveEffectImpl)
	self:_registerEffect(UIEffectEnum.EXP_GROW, ExpGrowEffectImpl)
end

function UIEffectUtil:_getChildEffect(effectEnum, container, childName)
	local goChild = goutil.findChild(container, childName)

	return self:_getEffect(effectEnum, goChild)
end

function UIEffectUtil:_getEffect(effectEnum, goTarget)
	local effectCls = self._effectMap[effectEnum]

	return Astral.SimpleLuaComponentContainer.Add(goTarget, effectCls)
end

function UIEffectUtil:_registerEffect(effectEnum, effectCls)
	self._effectMap[effectEnum] = effectCls
end

UIEffectUtil._instance = UIEffectUtil.New()

return UIEffectUtil
