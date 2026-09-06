-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerscene/view/AnswerSceneResultView.lua

module("logic.extensions.answerscene.view.AnswerSceneResultView", package.seeall)

local AnswerSceneResultView = class("AnswerSceneResultView", ViewComponent)

function AnswerSceneResultView:buildUI()
	AnswerSceneResultView.super.buildUI(self)

	self._sureButton = self:getBtn("btnSure")
	self._answersNum = self:getTxt("answersnum/txtDesc")
	self._unansweredNum = self:getTxt("unanswered/txtDesc")
	self._correctNum = self:getTxt("correct/txtDesc")
	self._wrongNum = self:getTxt("wrong/txtDesc")
	self._comobNum = self:getTxt("comob/txtDesc")
	self._totalNum = self:getTxt("total/txtDesc")
	self._tableview = self:getGo("tableview"):GetComponent(typeof(UITableview))
	self._tableCell = self:getGo("cell")
	self._roleParent = self:getGo("roleMask/roleParent")

	self._tableCell:SetActive(false)

	local txtTitle = self:getTxt("txtTitle")
	local txtGet = self:getTxt("btnSure/Text")
	local titleNum = self:getTxt("answersnum/txt")
	local titleCombo = self:getTxt("comob/txt")
	local titleRight = self:getTxt("correct/txt")
	local titleWrong = self:getTxt("wrong/txt")
	local titleTotal = self:getTxt("total/txtDesc/txt")

	txtTitle.text = lang("answerscene_result_title")
	txtGet.text = lang("mail_get")
	titleNum.text = lang("answerscene_answernum")
	titleCombo.text = lang("answerscene_answermaxcombo")
	titleRight.text = lang("answerscene_answerright")
	titleWrong.text = lang("answerscene_answerwrong")
	titleTotal.text = lang("answerscene_scores_total")
end

function AnswerSceneResultView:bindEvents()
	self._sureButton:AddClickListener(self._onClickSure, self)
	self._tableview:RegisterCallback(self._numItemsInView, self._itemCellSizeForIndex, self._itemCellAtIndex, self)
end

function AnswerSceneResultView:unbindEvents()
	self._sureButton:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function AnswerSceneResultView:destroyUI()
	return
end

function AnswerSceneResultView:onEnter()
	AnswerSceneResultView.super.onEnter(self)

	local reportResult = self:getFirstParam()

	if reportResult then
		local report = reportResult.report

		self._answersNum.text = tostring(report.anwerTimes)
		self._correctNum.text = tostring(report.rightNum)
		self._wrongNum.text = tostring(report.anwerTimes - report.rightNum)
		self._comobNum.text = tostring(report.bestCombo)
		self._totalNum.text = tostring(report.score)
		self._changesetId = reportResult.scoreChangeSetId
	end

	self:_checkDataReady()

	self._obj = RoleObjectPool.instance:addRoleToParent(self._obj, 80001, self._roleParent, 1, function(go)
		self:_updateSpineMat(go)
	end, false)

	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClose, self)
end

function AnswerSceneResultView:_checkDataReady()
	if self._changesetId and self._changesetId ~= 0 then
		self._itemsData = MaterialController.instance:getTempItemsByChangeSetId(self._changesetId)
	end

	self._tableview:SetOffsetWithoutRefresh(0)
	self._tableview:ReloadData()
end

function AnswerSceneResultView:_updateSpineMat(go)
	local r = goutil.findChildComponent(go, "skeleton", "SkeletonGraphic")

	self._spineRenderer = r
	self._saveMaterial = r.material
	self._tempMat = UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphic (Premultiply Alpha)"))
	self._tempMat.mainTexture = r.material.mainTexture
	r.material = self._tempMat
end

function AnswerSceneResultView:onEnterFinished()
	AnswerSceneResultView.super.onEnterFinished(self)
	self._tableview:Travel(self._clearTableCells, self)
end

function AnswerSceneResultView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	AnswerSceneResultView.super.onExit(self)
end

function AnswerSceneResultView:onExitFinished()
	if self._spineRenderer then
		self._spineRenderer.material = self._saveMaterial
		self._saveMaterial = nil
		self._spineRenderer = nil
	end

	if self._tempMat then
		goutil.destroy(self._tempMat)

		self._tempMat = nil
	end

	RoleObjectPool.instance:removeRole(self._role)

	self._role = nil
end

function AnswerSceneResultView:_numItemsInView(view)
	if not self._itemsData then
		return 0
	end

	return #self._itemsData
end

function AnswerSceneResultView:_itemCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._itemsData[idx + 1]

	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByMo(data, cell.gameObject)

	return cell
end

function AnswerSceneResultView:_itemCellSizeForIndex(view, idx)
	return 80, 80
end

function AnswerSceneResultView:_clearTableCells(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function AnswerSceneResultView:_onClickSure()
	if self._changesetId and self._changesetId ~= 0 and self._itemsData and #self._itemsData > 0 then
		MaterialController.instance:setChangeSetPopup(self._changesetId)
		MaterialController.instance:showChangeSetItemMo(self._itemsData, self._changesetId)
	else
		self:close()
		AnswerSceneController.instance:exitAnswerScene()
	end
end

function AnswerSceneResultView:_onViewClose(view)
	if view.viewName ~= ViewName.ItemGet then
		return
	end

	local topView = GlobalModel.instance:getTopView()

	if topView and topView.viewName == self._viewPresentor.viewName then
		self:close()
		AnswerSceneController.instance:exitAnswerScene()
	end
end

return AnswerSceneResultView
