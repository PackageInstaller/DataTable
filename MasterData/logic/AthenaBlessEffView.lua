-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/athenabless/view/AthenaBlessEffView.lua

module("logic.extensions.athenabless.view.AthenaBlessEffView", package.seeall)

local AthenaBlessEffView = class("AthenaBlessEffView")

function AthenaBlessEffView.Get(go)
	return (Framework.LuaComponentContainer.Add(go, AthenaBlessEffView))
end

function AthenaBlessEffView:ctor(container)
	self._container = container
end

function AthenaBlessEffView:playAthenaEffect(effectPath)
	local rootGo = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	if goutil.isNil(rootGo) then
		return
	end

	local rangeTrans = rootGo:GetComponent(goutil.Type_RectTransform)

	self:removeAthenaEffect()

	if not string.nilorempty(effectPath) and not goutil.isNil(self._container) then
		local uiEffect = UIEffectManager.instance:playHUDEffect(effectPath, self._container, true, nil, nil, function(target, eff)
			if not goutil.isNil(rangeTrans) then
				eff:setClipping(rangeTrans)
			end
		end)

		uiEffect:setParent(self._container.transform)
		uiEffect:setScale(1)

		self._athenaUIEffect = uiEffect
	end
end

function AthenaBlessEffView:removeAthenaEffect()
	if self._athenaUIEffect then
		UIEffectManager.instance:stopEffect(self._athenaUIEffect)

		self._athenaUIEffect = nil
	end
end

return AthenaBlessEffView
