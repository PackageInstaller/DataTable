-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/modalmask/impl/BlackMaskImpl.lua

module("logic.common.viewlib.modalmask.impl.BlackMaskImpl", package.seeall)

local M = class("BlackMaskImpl", AbstractGlobalReusable, IModelMask)
local kBlackColor = Astral.ColorUtil.ParseColor("#00000096")

function M:ctor()
	self.mainGO = goutil.create("BlackMask", true)

	goutil.addChildToParent(self.mainGO, ModalMask.maskRoot)

	self.rawImg = goutil.addComponentOnce(self.mainGO, UIComponentType.RawImage)
	self.rawImg.color = kBlackColor

	ModalMask.internal_setFullScreen(self.mainGO)
	self:buildUI()
end

function M:reset()
	self:resetUI()
	goutil.addChildToParent(self.mainGO, ModalMask.maskRoot)
end

function M:reuse()
	self.rawImg.color = kBlackColor
end

function M:destroy()
	self:destroyUI()
	goutil.destroy(self.mainGO)

	self.mainGO = false
	self.rawImg = nil
end

function M:buildUI()
	self._btnClick = Astral.UIClickTrigger.Get(self.mainGO)

	self._btnClick:AddClickListener(self._onClick, self)

	self._handler = Handler.New()
end

function M:resetUI()
	self._handler:clear()
end

function M:destroyUI()
	self._btnClick:RemoveClickListener()

	self._btnClick = false
end

function M:setBackgroundMask(targetGO)
	GameObjectUtils.SetABehindB(self.mainGO, targetGO)
end

function M:setClickListener(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
end

function M:_onClick()
	self._handler:call()
end

function M:setColor(colorStr)
	if not string.nilorempty(colorStr) then
		self.rawImg.color = parsecolor(colorStr)
	end
end

return M
