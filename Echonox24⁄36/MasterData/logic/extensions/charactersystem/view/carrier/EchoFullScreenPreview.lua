-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/EchoFullScreenPreview.lua

module("logic.extensions.charactersystem.view.carrier.EchoFullScreenPreview", package.seeall)

local M = class("EchoFullScreenPreview", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "clickExit"))
	self._cardGo = goutil.findChild(self.mainGO, "echo_show_card")
	self._showCardView = Astral.LuaComponentContainer.Add(self._cardGo, EchoItemShowCardView)

	local imgDiGo = goutil.findChild(self.mainGO, "echo_show_card/zhengmian/imgBg")
	local imgDi2Go = goutil.findChild(self.mainGO, "echo_show_card/zhengmian/imgDi (1)")
	local qualityGo = goutil.findChild(self.mainGO, "echo_show_card/zhengmian/normal2/imgQuality")
	local rawImageGo = goutil.findChild(self.mainGO, "echo_show_card/zhengmian/normal1/RawImage")

	self._rawImageGlowGo = goutil.findChild(self.mainGO, "echo_show_card/zhengmian/normal1/RawImageGlow")

	local effect1Go = goutil.findChild(self.mainGO, "echo_show_card/zhengmian/normal2/effect1")
	local effect2Go = goutil.findChild(self.mainGO, "echo_show_card/zhengmian/normal2/effect2")
	local width = 344
	local height = 538

	goutil.setWidth(rawImageGo.transform, width)
	goutil.setWidth(self._rawImageGlowGo.transform, width)
	goutil.setWidth(effect1Go.transform, width)
	goutil.setWidth(effect2Go.transform, width)
	goutil.setHeight(rawImageGo.transform, height)
	goutil.setWidth(self._rawImageGlowGo.transform, height)
	goutil.setHeight(effect1Go.transform, height)
	goutil.setHeight(effect2Go.transform, height)
	goutil.setActive(imgDiGo, false)
	goutil.setActive(qualityGo, false)
end

function M:destroyUI()
	self._showCardView:onExit()

	self._showCardView = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	local echoItemData = self:getFirstParam()
	local echoItemId = echoItemData:getId()

	self._showCardView:updateDynamicEffect(echoItemData)
	self._showCardView:setIsVertical(true)
	self._showCardView:onEnter()
	self._showCardView:showGyros()
	self._showCardView:refreshView(echoItemId, true)
	self._showCardView:setAddBtnVisible(false)
	goutil.setActive(self._rawImageGlowGo, false)
	Astral.TransformUtil.SetLocalRotation(self._cardGo.transform, 0, 0, 0)
	Astral.TransformUtil.SetLocalScale(self._cardGo.transform, 0.3, 0.3, 1)
	self._cardGo.transform:DORotate(Vector3.New(0, 0, 90), 0.5, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
	self._cardGo.transform:DOScale(1.7, 0.5):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
end

function M:onExit()
	self._showCardView:onExit()
end

function M:_onClickClose()
	self._cardGo.transform:DORotate(Vector3.New(0, 0, 0), 0.5, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
	self._cardGo.transform:DOScale(0.5, 0.5):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
	settimer(0.5, function()
		self:close()
	end, self, false)
end

return M
