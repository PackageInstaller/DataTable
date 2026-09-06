-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchFmtBuffView.lua

module("logic.extensions.annimatch.view.AnnimatchFmtBuffView", package.seeall)

local AnnimatchFmtBuffView = class("AnnimatchFmtBuffView", ViewComponent)

function AnnimatchFmtBuffView:ctor()
	AnnimatchFmtBuffView.super.ctor(self)
end

function AnnimatchFmtBuffView:unbindEvents()
	AnnimatchFmtBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AnnimatchFmtBuffView:bindEvents()
	AnnimatchFmtBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function AnnimatchFmtBuffView:buildUI()
	AnnimatchFmtBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._buffGo = self:getGo("buff")
	self._fmt = self:getGo("buff/fmt")
	self._txtDesc = self:getTxt("buff/txtDesc")
	self._txtName = self:getTxt("buff/name/txtName")
end

function AnnimatchFmtBuffView:onExit()
	AnnimatchFmtBuffView.super.onExit(self)
	self:_killPathMoveSequence()
end

function AnnimatchFmtBuffView:onEnter()
	AnnimatchFmtBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 508001
	end

	self._formId = checknumber(params[2])
	self._buffPos = params[3] or Vector3.New(0, 0, 0)
	self._formCfg = AnnimatchConfig.instance:getFormCfg(self._activityId, self._formId)
	self._sequence = DG.Tweening.DOTween.Sequence()

	GameUtil.setLocalScale(self._buffGo, 1, 1, 1)
	self:_updateFmtUI()
end

function AnnimatchFmtBuffView:_killPathMoveSequence()
	if self._sequence then
		self._sequence:Kill(true)

		self._sequence = nil
	end
end

function AnnimatchFmtBuffView:_updateFmtUI()
	local activityId = AnnimatchController.instance:getCurrActId()
	local info = AnnimatchModel.instance:getInfo(activityId)

	if info then
		if not info.formId then
			local formId = 1
			local formCfg = AnnimatchConfig.instance:getFormCfg(activityId, formId) or {}
			local posList = formCfg.posList

			self._txtDesc.text = formCfg.desc
			self._txtName.text = formCfg.name

			for i = 1, 9 do
				local img = goutil.findChild(self._fmt, "img_" .. i)
				local isInPos = table.indexof(posList, i)

				GameUtil.SetActive(img, isInPos)
			end
		end
	end
end

function AnnimatchFmtBuffView:_onClickBtnClose()
	local newScale = Vector3.New(0, 0, 0)
	local duration = 0.2

	local function completeFunc()
		GlobalDispatcher:dispatch(GlobalNotify.AnniMatchCloseFmtBuff)
		self:close()
	end

	local tweener = self._buffGo.transform:DOScale(newScale, duration):SetEase(DG.Tweening.Ease.Linear):OnComplete(completeFunc)
	local moveTweener = self._buffGo.transform:DOLocalMove(self._buffPos, duration):SetEase(DG.Tweening.Ease.Linear)

	self._sequence:Append(tweener)
	self._sequence:Join(moveTweener)
end

return AnnimatchFmtBuffView
