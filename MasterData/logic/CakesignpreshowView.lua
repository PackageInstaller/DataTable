-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cakesign/view/CakesignpreshowView.lua

module("logic.extensions.cakesign.view.CakesignpreshowView", package.seeall)

local CakesignpreshowView = class("CakesignpreshowView", ViewComponent)

function CakesignpreshowView:ctor()
	CakesignpreshowView.super.ctor(self)
end

function CakesignpreshowView:buildUI()
	CakesignpreshowView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnInfo = self:getBtn("btnInfo")
	self._btnSkill = self:getBtn("btnSkill")
	self._showPrizes = {}

	for i = 1, 10 do
		local cell = {}
		local go = self:getGo("showPrizes/cell" .. i)

		cell.go = go
		cell.item = goutil.findChild(go, "item")
		cell.mark = goutil.findChild(go, "mark")
		self._showPrizes[i] = cell
	end

	self._lihui = self:getGo("petSkinLihui")
	self.petPhoto = PetPhotoShow.Get(self._lihui)
end

function CakesignpreshowView:bindEvents()
	CakesignpreshowView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnInfo:AddClickListener(self._onClickBtnInfo, self)
	self._btnSkill:AddClickListener(self._onClickBtnSkill, self)
end

function CakesignpreshowView:unbindEvents()
	CakesignpreshowView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function CakesignpreshowView:destroyUI()
	CakesignpreshowView.super.destroyUI(self)
end

function CakesignpreshowView:onEnter()
	CakesignpreshowView.super.onEnter(self)

	self._datas = self:getFirstParam() or {}
	self._showSkinId = checkint(string.split(self._datas[1].prizeStr, ":")[2])

	for i = 1, 10 do
		MaterialMgr.resetAll(self._showPrizes[i].item)

		if self._datas[i] and self._datas[i].prizeStr then
			MaterialMgr.setCellByCfg(self._datas[i].prizeStr, self._showPrizes[i].item)
			goutil.setActive(self._showPrizes[i].mark, self._datas[i].isHasGain)
			goutil.setActive(self._showPrizes[i].go, true)
		else
			goutil.setActive(self._showPrizes[i].go, false)
		end
	end

	self.petPhoto:showPetEffect(self._showSkinId, true, 2.5)
	self.petPhoto:setPetLocalPosAndScale(0, 0.05)
end

function CakesignpreshowView:onEnterFinished()
	CakesignpreshowView.super.onEnterFinished(self)
end

function CakesignpreshowView:onExit()
	CakesignpreshowView.super.onExit(self)
	self.petPhoto:clear()

	for i = 1, 10 do
		MaterialMgr.resetAll(self._showPrizes[i].item)
	end
end

function CakesignpreshowView:onExitFinished()
	CakesignpreshowView.super.onExitFinished(self)
end

function CakesignpreshowView:_onClickBtnInfo()
	UIStateManager.instance:push(ViewName.PetDrawing, self._showSkinId)
end

function CakesignpreshowView:_onClickBtnSkill()
	if self._showSkinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(self._showSkinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, self._showSkinId)
		end
	end
end

return CakesignpreshowView
