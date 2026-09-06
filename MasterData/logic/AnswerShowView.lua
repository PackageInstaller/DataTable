-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerfunc/view/AnswerShowView.lua

module("logic.extensions.answerfunc.view.AnswerShowView", package.seeall)

local AnswerShowView = class("AnswerShowView", ViewComponent)

function AnswerShowView:ctor()
	AnswerShowView.super.ctor(self)

	self._isHaveAnswer = nil
	self._curNumber = nil
	self._choiseList = nil
	self._answerItemList = nil
	self._isThisOver = nil
	self._getAllScore = nil
	self._tweenTime = nil
	self._supTime = nil
end

function AnswerShowView:onExit()
	AnswerShowView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.Answer_UpdataCurrentAnswer, self._updataAllAnswerItemShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.Answer_UpdataResultAnswer, self._openAnswerResultView, self)
end

function AnswerShowView:destroyUI()
	AnswerShowView.super.destroyUI(self)
	MaterialMgr.resetAll(self._roleGo)
	MaterialMgr.resetAll(self._iconGo)

	self._isHaveAnswer = nil
	self._curNumber = nil
	self._choiseList = nil
	self._answerItemList = nil
	self._isThisOver = nil
	self._getAllScore = nil
	self._tweenTime = nil
	self._supTime = nil
end

function AnswerShowView:bindEvents()
	AnswerShowView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		if checknumber(self._supTime) > 0 then
			TipsFacade.instance:openPopupWindow("提示", "是否确认结束本轮游戏？", function()
				AnswerFuncModel.instance.curChoiseParam = nil
				self._supTime = -1
			end, nil, "结束", "继续")
		else
			AnswerFuncModel.instance.curChoiseParam = nil

			self:close()
		end
	end, self)
	GameUtil.asBtn(self._resultShowGo):AddClickListener(function()
		AnswerFuncModel.instance.curChoiseParam = nil

		self:close()
	end, self)
end

function AnswerShowView:unbindEvents()
	AnswerShowView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	GameUtil.asBtn(self._resultShowGo):RemoveClickListener()
end

function AnswerShowView:buildUI()
	AnswerShowView.super.buildUI(self)

	self._closeBtn = self:getBtn("leftTopGo/closeBtn")
	self._roleGo = self:getGo("roleMask/roleGo")
	self._timeTxt = self:getTxt("timeTxt")
	self._titleTxt = self:getTxt("titleTxt")
	self._descTxt = self:getTxt("descTxt")
	self._topicTxt = self:getTxt("topicTxt")
	self._socreTxt = self:getTxt("socreTxt")
	self._addTxt = self:getTxt("addTxt")
	self._addScoreGo = self:getGo("addScoreGo")
	self._btnsComTran = self:getGo("btnsComTran").transform
	self._answerItem = self:getGo("answerItem")
	self._imageGo = self:getGo("imageGo")
	self._iconGo = goutil.findChild(self._imageGo, "iconGo")
	self._btnsImaTran = goutil.findChild(self._imageGo, "btnsImaTran").transform
	self._answerItemList = {}
	self._answerItemList[1] = {
		itemGo = goutil.findChild(self.mainGO, "answerItem_1"),
		rightGo = goutil.findChild(self.mainGO, "answerItem_1/rightGo"),
		errorGo = goutil.findChild(self.mainGO, "answerItem_1/errorGo"),
		itemTxt = goutil.findChildTextComponent(self.mainGO, "answerItem_1/answerTxt")
	}
	self._answerItemList[2] = {
		itemGo = goutil.findChild(self.mainGO, "answerItem_2"),
		rightGo = goutil.findChild(self.mainGO, "answerItem_2/rightGo"),
		errorGo = goutil.findChild(self.mainGO, "answerItem_2/errorGo"),
		itemTxt = goutil.findChildTextComponent(self.mainGO, "answerItem_2/answerTxt")
	}
	self._answerItemList[3] = {
		itemGo = goutil.findChild(self.mainGO, "answerItem_3"),
		rightGo = goutil.findChild(self.mainGO, "answerItem_3/rightGo"),
		errorGo = goutil.findChild(self.mainGO, "answerItem_3/errorGo"),
		itemTxt = goutil.findChildTextComponent(self.mainGO, "answerItem_3/answerTxt")
	}
	self._answerItemList[4] = {
		itemGo = goutil.findChild(self.mainGO, "answerItem_4"),
		rightGo = goutil.findChild(self.mainGO, "answerItem_4/rightGo"),
		errorGo = goutil.findChild(self.mainGO, "answerItem_4/errorGo"),
		itemTxt = goutil.findChildTextComponent(self.mainGO, "answerItem_4/answerTxt")
	}
	self._timeTxt.text = ""
	self._titleTxt.text = ""
	self._descTxt.text = ""
	self._topicTxt.text = ""
	self._socreTxt.text = ""
	self._addTxt.text = ""
	self._resultShowGo = self:getGo("resultShowGo")
	self._numTxt = goutil.findChildTextComponent(self._resultShowGo, "bgGo/numTxt")
	self._scoreTxt = goutil.findChildTextComponent(self._resultShowGo, "bgGo/scoreTxt")
	self._descTxt = goutil.findChildTextComponent(self._resultShowGo, "bgGo/descTxt")
	self._daanTxt = self:getTxt("daanTxt")
	self._daanTxt.text = ""
end

function AnswerShowView:onEnter()
	AnswerShowView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.Answer_UpdataCurrentAnswer, self._updataAllAnswerItemShow, self)
	GlobalDispatcher:addListener(GlobalNotify.Answer_UpdataResultAnswer, self._openAnswerResultView, self)

	self._numTxt.text = ""
	self._scoreTxt.text = ""
	self._descTxt.text = ""

	GameUtil.SetActive(self._resultShowGo, false)

	local actId = AnswerFuncConfig.instance:getAnswerFuncActivityId()

	self._actCfg = AnswerFuncConfig.instance:getAnswerActivityCfg(actId)

	if self._actCfg == nil then
		printError("sr---问题功能      AnswerShowView:onEnter()       策划未配置 = " .. actId)

		return
	end

	self._curNumber = 0
	self._supTime = -1
	self._isHaveAnswer = false

	self:_updataAllAnswerItemShow(math.max(checknumber(self:getFirstParam()), 1), true, 0)

	self._titleTxt.text = lang("精灵问答")
	self._descTxt.text = lang("text_answer_desc_4")

	local curTypeId = AnswerFuncModel.instance:getTypeId()
	local typeData = AnswerFuncConfig.instance:getTypeData(self._actCfg.activityId, curTypeId)
	local skinId = typeData.skinId

	if skinId > 0 then
		uGuiUtil.setSpriteToImage(self._roleGo, uGuiUtil.SpriteType.BigBg, GameUrl.getLotteryPetImgUrl(skinId))
	end
end

function AnswerShowView:_updataAllAnswerItemShow(questionId, isStart, score)
	self._addTxt.text = ""
	self._tweenTime = nil

	if checknumber(questionId) <= 0 then
		AnswerFuncModel.instance.curChoiseParam = nil
		self._supTime = -1

		return
	end

	if isStart then
		self._getAllScore = 0

		GameUtil.SetActive(self._addScoreGo, false)

		self._curNumber = 1
		self._supTime = self._actCfg.timeout
		self._timeTxt.text = string.format("倒计时：<color=#FF0000FF><size=30>%s</size></color>s", self._supTime)

		settimer(1, self._calculationSurplusTime, self, true)
	else
		self._curNumber = self._curNumber + 1
		self._isHaveAnswer = true
	end

	local curTypeId = AnswerFuncModel.instance:getTypeId()

	self._topicCfg = AnswerFuncConfig.instance:getAnswerProblemDataByType(self._actCfg.activityId, curTypeId, questionId)

	if self._topicCfg == nil then
		FloatWordMgr.instance:show(string.format("没有此题，题目%s", questionId))
		AnswerFuncController.instance:csGetAnswerProblemUnlockPlotAnswerEndReq(self._actCfg.activityId)
		self:close()

		return
	end

	self._choiseList = nil
	self._isThisOver = false
	self._socreTxt.text = "当前得分：" .. score

	if score >= self._actCfg.scoreLimit and self._getAllScore >= self._actCfg.scoreLimit then
		FloatWordMgr.instance:show("你太厉害了 积分达到上限 可以手动退出 直接结算哦~")
	elseif score > self._getAllScore then
		self._addTxt.text = "+" .. tostring(score - self._getAllScore)
		self._tweenTime = 1

		UnityTweens.TweenPosition.StartTween(self._addTxt.gameObject, Vector3.New(520, 170, 0), Vector3.New(520, 185, 0), 0.4, UnityTweens.EaseType.easeInSine)
	end

	self._getAllScore = score
	self._topicTxt.text = #self._topicCfg.correctOptionId > 1 and string.format("第%s题：%s (多选题)", self._curNumber, self._topicCfg.question) or string.format("第%s题：%s", self._curNumber, self._topicCfg.question)

	local parentTran = self._btnsComTran

	MaterialMgr.resetAll(self._iconGo)

	if self._topicCfg.type == 3 then
		GameUtil.SetActive(self._btnsComTran, false)
		GameUtil.SetActive(self._imageGo, true)

		parentTran = self._btnsImaTran

		uGuiUtil.setSpriteToImage(self._iconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(self._topicCfg.icon))
	else
		GameUtil.SetActive(self._imageGo, false)
		GameUtil.SetActive(self._btnsComTran, true)
	end

	GameUtil.asBtn(self._answerItemList[1].itemGo):RemoveClickListener()

	if not string.nilorempty(self._topicCfg.option1) then
		GameUtil.SetActive(self._answerItemList[1].itemGo, true)
		self._answerItemList[1].itemGo.transform:SetParent(parentTran)
		self._answerItemList[1].itemGo:GetComponent("UIImageSpriteChange"):SetState(0)
		GameUtil.SetActive(self._answerItemList[1].rightGo, false)
		GameUtil.SetActive(self._answerItemList[1].errorGo, false)

		self._answerItemList[1].itemTxt.text = "A." .. self._topicCfg.option1

		GameUtil.asBtn(self._answerItemList[1].itemGo):AddClickListener(function()
			self:_onClickAnswerBtn(1)
		end, self)
	else
		GameUtil.SetActive(self._answerItemList[1].itemGo, false)
	end

	GameUtil.asBtn(self._answerItemList[2].itemGo):RemoveClickListener()

	if not string.nilorempty(self._topicCfg.option2) then
		GameUtil.SetActive(self._answerItemList[2].itemGo, true)
		self._answerItemList[2].itemGo.transform:SetParent(parentTran)
		self._answerItemList[2].itemGo:GetComponent("UIImageSpriteChange"):SetState(0)
		GameUtil.SetActive(self._answerItemList[2].rightGo, false)
		GameUtil.SetActive(self._answerItemList[2].errorGo, false)

		self._answerItemList[2].itemTxt.text = "B." .. self._topicCfg.option2

		GameUtil.asBtn(self._answerItemList[2].itemGo):AddClickListener(function()
			self:_onClickAnswerBtn(2)
		end, self)
	else
		GameUtil.SetActive(self._answerItemList[2].itemGo, false)
	end

	GameUtil.asBtn(self._answerItemList[3].itemGo):RemoveClickListener()

	if not string.nilorempty(self._topicCfg.option3) then
		GameUtil.SetActive(self._answerItemList[3].itemGo, true)
		self._answerItemList[3].itemGo.transform:SetParent(parentTran)
		self._answerItemList[3].itemGo:GetComponent("UIImageSpriteChange"):SetState(0)
		GameUtil.SetActive(self._answerItemList[3].rightGo, false)
		GameUtil.SetActive(self._answerItemList[3].errorGo, false)

		self._answerItemList[3].itemTxt.text = "C." .. self._topicCfg.option3

		GameUtil.asBtn(self._answerItemList[3].itemGo):AddClickListener(function()
			self:_onClickAnswerBtn(3)
		end, self)
	else
		GameUtil.SetActive(self._answerItemList[3].itemGo, false)
	end

	GameUtil.asBtn(self._answerItemList[4].itemGo):RemoveClickListener()

	if not string.nilorempty(self._topicCfg.option4) then
		GameUtil.SetActive(self._answerItemList[4].itemGo, true)
		self._answerItemList[4].itemGo.transform:SetParent(parentTran)
		self._answerItemList[4].itemGo:GetComponent("UIImageSpriteChange"):SetState(0)
		GameUtil.SetActive(self._answerItemList[4].rightGo, false)
		GameUtil.SetActive(self._answerItemList[4].errorGo, false)

		self._answerItemList[4].itemTxt.text = "D." .. self._topicCfg.option4

		GameUtil.asBtn(self._answerItemList[4].itemGo):AddClickListener(function()
			self:_onClickAnswerBtn(4)
		end, self)
	else
		GameUtil.SetActive(self._answerItemList[4].itemGo, false)
	end
end

function AnswerShowView:_calculationSurplusTime()
	self._supTime = self._supTime - 1

	if self._tweenTime and self._tweenTime > 0 then
		self._tweenTime = self._tweenTime - 1

		if self._tweenTime <= 0 then
			self._addTxt.text = ""
			self._tweenTime = nil

			UnityTweens.TweenPosition.StopTween(self._addTxt.gameObject)
		end
	end

	if self._isThisOver then
		local isRight = false

		if self._choiseList and #self._choiseList == #self._topicCfg.correctOptionId then
			isRight = true

			for i = 1, #self._choiseList do
				if not table.indexof(self._topicCfg.correctOptionId, self._choiseList[i]) then
					isRight = false

					break
				end
			end
		end

		AnswerFuncController.instance:csGetAnswerProblemUnlockPlotAnswerReq(self._actCfg.activityId, isRight, self._topicCfg.questionId)

		self._isThisOver = false
	end

	if self._supTime < 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timeTxt.text = "本轮问答已结束"

		AnswerFuncController.instance:csGetAnswerProblemUnlockPlotAnswerEndReq(self._actCfg.activityId)

		return
	end

	self._timeTxt.text = string.format("倒计时：<color=#FF0000FF><size=30>%s</size></color>s", self._supTime)
end

function AnswerShowView:_onClickAnswerBtn(index)
	if checknumber(self._supTime) <= 0 then
		FloatWordMgr.instance:show("本轮问答已结束")

		return
	end

	if checknumber(index) <= 0 or self._answerItemList[index] == nil then
		return
	end

	if self._isThisOver then
		return
	end

	self._choiseList = self._choiseList or {}

	if table.indexof(self._choiseList, index) or #self._choiseList >= #self._topicCfg.correctOptionId then
		return
	end

	table.insert(self._choiseList, index)
	self._answerItemList[index].itemGo:GetComponent("UIImageSpriteChange"):SetState(1)

	if table.indexof(self._topicCfg.correctOptionId, index) then
		GameUtil.SetActive(self._answerItemList[index].rightGo, true)
		GameUtil.SetActive(self._answerItemList[index].errorGo, false)
	else
		self._isThisOver = true

		GameUtil.SetActive(self._answerItemList[index].rightGo, false)
		GameUtil.SetActive(self._answerItemList[index].errorGo, true)
	end

	if #self._choiseList >= #self._topicCfg.correctOptionId then
		self._isThisOver = true
	end
end

function AnswerShowView:_openAnswerResultView(msg)
	local count = msg and checknumber(msg.num) or 0
	local score = msg and checknumber(msg.addScore) or 0

	GameUtil.SetActive(self._resultShowGo, true)

	if self._isHaveAnswer or count > 0 or score > 0 then
		self._descTxt.text = ""
		self._numTxt.text = langPara("text_answer_desc_1", count)
		self._scoreTxt.text = langPara("text_answer_desc_2", score)
	else
		self._numTxt.text = ""
		self._scoreTxt.text = ""
		self._descTxt.text = "快醒醒！你一题都没回答呢 ！"
	end
end

return AnswerShowView
