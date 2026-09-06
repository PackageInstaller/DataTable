-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualactivity/view/AnnualTaskView.lua

module("logic.extensions.annualactivity.view.AnnualTaskView", package.seeall)

local AnnualTaskView = class("AnnualTaskView", TableViewComponent)

function AnnualTaskView:ctor()
	AnnualTaskView.super.ctor(self)

	self._curViewDatas = nil
end

function AnnualTaskView:bindEvents()
	AnnualTaskView.super.bindEvents(self)
end

function AnnualTaskView:unbindEvents()
	AnnualTaskView.super.unbindEvents(self)
end

function AnnualTaskView:onExit()
	AnnualTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataAnnualActivityTask, self._updataViewTaskShow, self)

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
end

function AnnualTaskView:destroyUI()
	AnnualTaskView.super.destroyUI(self)

	self._curViewDatas = nil
end

function AnnualTaskView:buildUI()
	AnnualTaskView.super.buildUI(self)

	self._sprineGo = self:getGo("sprineGo")
end

function AnnualTaskView:onEnter()
	AnnualTaskView.super.onEnter(self)

	self._paramCfg = self:getFirstParam()

	if self._paramCfg == nil then
		printError("sr----  AnnualTaskView:onEnter() y运营-周年拼图    未传入参数！！")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdataAnnualActivityTask, self._updataViewTaskShow, self)
	self:_updataViewTaskShow()

	local x, y, scale = 0, 0, 0.7

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, 16008, self._sprineGo, scale, nil, true, x, y)

	AnnualActivityController.instance:csRequestPJGetTaskInfoReq(self._paramCfg.activityId)
end

function AnnualTaskView:_updataViewTaskShow()
	self._taskInfos = AnnualActivityModel.instance:getTaskInfos()
	self._curViewDatas = AnnualActivityModel.instance:getAnnualTaskCfgs(self._paramCfg.taskPlanId)

	self._tableview:ReloadData()
end

function AnnualTaskView:_getPath()
	return {
		cellPath = "taskItem",
		viewPath = "taskItemSR"
	}
end

function AnnualTaskView:_cellSize()
	return 768, 114
end

function AnnualTaskView:_updateCell(view, cell, data)
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local gotoBtnGo = goutil.findChild(cell, "gotoBtn")
	local gotoTxt = goutil.findChildTextComponent(cell, "gotoBtn/gotoTxt")
	local finishGo = goutil.findChild(cell, "finishGo")
	local gotoIma = gotoBtnGo:GetComponent("UIImageSpriteChange")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local numberTxt = goutil.findChildTextComponent(cell, "numberTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local progTxt = goutil.findChildTextComponent(cell, "progTxt")

	MaterialMgr.resetAll(goodsGo)
	GameUtil.asBtn(gotoBtnGo):RemoveClickListener()

	nameTxt.text = data.cfg.title
	numberTxt.text = langPara("text_annual_desc_6", data.cfg.showNum)
	descTxt.text = data.cfg.desc

	local haveCount = 0

	if self._taskInfos and self._taskInfos[data.cfg.taskId] then
		haveCount = self._taskInfos[data.cfg.taskId].haveCount
	end

	if data.stage == 1 then
		progTxt.text = haveCount .. "/" .. data.cfg.maxProgress

		GameUtil.SetActive(finishGo, false)
		GameUtil.SetActive(gotoBtnGo, true)
		gotoIma:SetState(1)

		gotoTxt.text = lang("mail_get")
	elseif data.stage == 3 then
		progTxt.text = ""

		GameUtil.SetActive(gotoBtnGo, false)
		GameUtil.SetActive(finishGo, true)
	else
		progTxt.text = haveCount .. "/" .. data.cfg.maxProgress

		GameUtil.SetActive(finishGo, false)
		GameUtil.SetActive(gotoBtnGo, true)
		gotoIma:SetState(0)

		gotoTxt.text = lang("goto")
	end

	MaterialMgr.setCellByCfg(data.cfg.prize, goodsGo)

	if data.stage == 3 then
		return
	end

	GameUtil.asBtn(gotoBtnGo):AddClickListener(function()
		if data.stage == 1 then
			AnnualActivityController.instance:csRequestPJGainTaskPrizeReq(self._paramCfg.activityId, data.cfg.taskId)
		else
			GotoMgr.gotoByString(data.cfg.jumpTo)
		end
	end, self)
end

return AnnualTaskView
