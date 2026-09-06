-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/jigsaw/CORJigsawScenceView.lua

module("logic.extensions.cantonoperaroad.view.copy.jigsaw.CORJigsawScenceView", package.seeall)

local CORJigsawScenceView = class("CORJigsawScenceView", ViewComponent)

function CORJigsawScenceView:buildUI()
	CORJigsawScenceView.super.buildUI(self)

	self._workCol = goutil.findChild(self.mainGO, "workCol")
	self._btnWorkClose = goutil.findChild(self.mainGO, "workCol/btnWorkClose")
	self._btnGet = goutil.findChild(self.mainGO, "workCol/btnGet")
	self._chipView = goutil.findChild(self.mainGO, "workCol/chipCol/chipView")
	self._chipCell = goutil.findChild(self.mainGO, "workCol/chipCol/chipCell")
	self._chipBoard = goutil.findChild(self.mainGO, "workCol/chipCol/chipBoard")

	local pieceScrollerview = goutil.findChild(self.mainGO, "workCol/pieceCol/pieceScrollerview")
	local pieceScrollercell = goutil.findChild(self.mainGO, "workCol/pieceCol/pieceScrollercell")

	self._pieceScrollList = ScrollerList.create(pieceScrollerview, pieceScrollercell, GameUtil.handler(self._updatePieceCell, self), GameUtil.handler(self._clearPieceCell, self))
	self._searchCol = goutil.findChild(self.mainGO, "searchCol")
	self._btnSearchClose = goutil.findChild(self.mainGO, "searchCol/btnSearchClose")
	self._btnStart = goutil.findChild(self.mainGO, "searchCol/btnStart")
	self._player = goutil.findChild(self.mainGO, "searchCol/player")
	self._stageView = goutil.findChild(self.mainGO, "searchCol/stageCol/stageView")
	self._txtCost = goutil.findChildTextComponent(self.mainGO, "searchCol/txtCost")
	self._costIcon = goutil.findChild(self.mainGO, "searchCol/txtCost/icon")
	self._chipTwinkleEffs = {}
end

function CORJigsawScenceView:bindEvents()
	CORJigsawScenceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnWorkClose, self.close, self)
	GameUtil.addClickHandler(self._btnSearchClose, self._playTurnDeskAnim, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickBtnGet, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function CORJigsawScenceView:unbindEvents()
	CORJigsawScenceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnWorkClose)
	GameUtil.rmClickHandler(self._btnSearchClose)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.rmClickHandler(self._btnStart)
end

function CORJigsawScenceView:onEnter()
	CORJigsawScenceView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CantonOperaRoad)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	local params = self:getOpenParam() or {}

	self._jigsawId = checknumber(params[1])

	if self._jigsawId == 0 then
		self:close()
		printError("缺少传入参数jigsawId")

		return
	end

	self._modelId = GameEnum.ModelTypeAsCOR.JIGSAW

	if self._isInBack == true then
		self._isInBack = false

		self:_playTurnDeskAnim()
	end

	self:_onSetUI()
	self:_onUpdate()
	GlobalDispatcher:addListener(GlobalNotify.CORJigsawInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.CORLightUpRes, self._handleLightUpRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CORGetInfoRes, self._checkIsCanEnter, self)
end

function CORJigsawScenceView:onExit()
	CORJigsawScenceView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CORJigsawInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.CORLightUpRes, self._handleLightUpRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CORGetInfoRes, self._checkIsCanEnter, self)
	ViewBlockMgr.instance:blockClick(false, self)

	if self._animSequence then
		self._animSequence:Kill(true)

		self._animSequence = nil
	end

	MaterialMgr.resetAll(self._costIcon)
	self:_onClearChipCol()
	self:_onClearPieceCol()

	if self._drawEff then
		UIEffectManager.instance:stopEffect(self._drawEff)

		self._drawEff = nil
	end
end

function CORJigsawScenceView:_handleLightUpRes(msg)
	self:_onUpdate()

	if checknumber(msg.changeSetId) ~= 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		self:close()
		UIStateManager.instance:push(ViewName.CORJigsawResultView)
	end
end

function CORJigsawScenceView:_onSetUI()
	local actData = CantonOperaRoadConfig.instance:getCorActData(self._activityId)
	local energyList = {}
	local energyCfg = EnergyConfig.instance:getEnergyCfg(actData.energyId)

	if energyCfg then
		local matType = MatType.ACTIVITY_ENERGY
		local matId = actData.energyId
		local matStr = string.format("%s:%s", matType, matId)
		local isNeedShowAdd = not string.nilorempty(energyCfg.source)

		local function callBack()
			EnergyController.instance:openBuyView(matId)
		end

		energyList = {
			id = matStr,
			showAdd = isNeedShowAdd,
			showAddCallBack = callBack
		}
	end

	if self._goldBarCon then
		local list = {
			energyList
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end

	local modelData = CantonOperaRoadConfig.instance:getCorModelDataById(self._activityId, self._modelId)

	if not string.nilorempty(modelData.costEnergy) then
		local matType, matId, matNum = MaterialMgr.getMatParams(modelData.costEnergy)

		MaterialMgr.setIcon(self._costIcon, matType, matId, nil, nil)
	else
		MaterialMgr.resetAll(self._costIcon)
	end
end

function CORJigsawScenceView:_onUpdate()
	if not CantonOperaRoadController.instance:isFitStageIdAsCORJigsaw(self._curStageId) then
		self._curStageId = 0
	end

	self:_onUpdateData()
	self:_onUpdateUI()
end

function CORJigsawScenceView:_onUpdateData()
	self:_onUpdatePieceColData()
	self:_onUpdateStageColData()
end

function CORJigsawScenceView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateChipColUI()
	self:_onUpdatePieceColUI()
	self:_onUpdateStageColUI()
	self:_onUpdatePlayerUI()
end

function CORJigsawScenceView:_onUpdatePlaneUI()
	local isPassAsJigsaw = CantonOperaRoadController.instance:isPassAsJigsaw(self._jigsawId)

	GameUtil.SetActive(self._btnStart, not isPassAsJigsaw)
	GameUtil.SetActive(self._txtCost.gameObject, not isPassAsJigsaw)

	self._txtCost.text = CantonOperaRoadController.instance:getEnergyCostAsCORModel(self._modelId)
end

function CORJigsawScenceView:_checkIsCanEnter()
	if not CantonOperaRoadController.instance:isCanEnterModelAsCOR(self._modelId) then
		local tipsStr = CantonOperaRoadController.instance:getTipsStrByEnterResultAsCOR(self._modelId)

		if not string.nilorempty(tipsStr) then
			FloatWordMgr.instance:show(tipsStr)
		end

		self:close()
	end
end

function CORJigsawScenceView:_onUpdateChipColUI()
	local parentTran = self._chipView.transform
	local children = GameUtil.getChildren(parentTran)
	local cfg = CantonOperaRoadConfig.instance:getCorJigsawPieceDataListById(self._activityId, self._jigsawId)

	for index, data in ipairs(cfg) do
		if not children[index] then
			local mainGo = goutil.cloneAndSetParent(self._chipCell, parentTran)

			self:_updateChipCell(mainGo, data)
		end
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= #cfg)
	end

	local jigsawData = CantonOperaRoadConfig.instance:getCorJigsawDataById(self._activityId, self._jigsawId)
	local path = jigsawData.chipBoard
	local bgGo = self._chipBoard

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/bigbg/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end
end

function CORJigsawScenceView:_onClearChipCol()
	local parentTran = self._chipView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		local icon = goutil.findChild(mainGo, "icon")

		UIEffectManager.instance:stopEffect(self._chipTwinkleEffs[icon])
		uGuiUtil.clearImage(icon)
	end

	uGuiUtil.clearImage(self._chipBoard)
end

function CORJigsawScenceView:_updateChipCell(mainGo, data)
	local icon = goutil.findChild(mainGo, "icon")
	local isLightUp = CantonOperaRoadController.instance:isLightUpAsPiece(data.pieceId)
	local path = data.icon
	local bgGo = icon

	if isLightUp and not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/picturepuzzle/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		uGuiUtil.clearImage(bgGo)
	end

	if self._lightUpPieceId == data.pieceId then
		self._lightUpPieceId = 0

		local effGo = icon
		local path = "fx_ui_zhuangbeijiemian/fx_ui_fangru_zhuangbei"

		UIEffectManager.instance:stopEffect(self._chipTwinkleEffs[effGo])

		if effGo and not string.nilorempty(path) then
			local pathName = path .. ".prefab"

			local function func(_, eff)
				eff:setParent(effGo.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1, 1, 1)
			end

			self._chipTwinkleEffs[effGo] = UIEffectManager.instance:playEffect(self, pathName, effGo, 0, 0, false, false, nil, func, nil)
		end
	end
end

function CORJigsawScenceView:_onUpdatePieceColData()
	local infoList = {}
	local cfg = CantonOperaRoadConfig.instance:getCorJigsawPieceDataListById(self._activityId, self._jigsawId)

	for _, data in ipairs(cfg) do
		local pieceId = data.pieceId
		local info = {
			data = data,
			num = CantonOperaRoadModel.instance:getPieceNum(pieceId),
			isLightUp = CantonOperaRoadController.instance:isLightUpAsPiece(pieceId)
		}

		table.insert(infoList, info)
	end

	table.sort(infoList, function(a, b)
		if a.isLightUp == true and b.isLightUp == false then
			return false
		end

		if a.isLightUp == false and b.isLightUp == true then
			return true
		end

		if a.num == b.num and a.data.pieceId < b.data.pieceId then
			return true
		end

		return a.num > b.num
	end)

	self._pieceInfoList = infoList
end

function CORJigsawScenceView:_onUpdatePieceColUI()
	self._pieceScrollList:reloadData(self._pieceInfoList)
end

function CORJigsawScenceView:_onClearPieceCol()
	self._pieceScrollList:dispose()
end

function CORJigsawScenceView:_updatePieceCell(view, cell, info, tag)
	local data = info.data
	local num = info.num
	local isLightUp = info.isLightUp
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local imgHasLight = goutil.findChild(mainGo, "imgHasLight")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local path = data.icon
	local bgGo = icon

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/picturepuzzle/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end

	txtNum.text = string.format("x%d", num)

	GameUtil.SetActive(imgHasLight, isLightUp)
	GameUtil.SetGray(icon, num == 0 or isLightUp)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickPieceCell, self, info))
end

function CORJigsawScenceView:_clearPieceCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(mainGo)
end

function CORJigsawScenceView:_onClickPieceCell(info)
	if info.isLightUp then
		FloatWordMgr.instance:show("该拼图碎片您已点亮")

		return
	end

	if info.num <= 0 then
		FloatWordMgr.instance:show("拼图碎片不足")

		return
	end

	self._lightUpPieceId = info.data.pieceId

	CantonOperaRoadController.instance:sendPM_CantonOperaRoadLightUpReq(self._activityId, self._jigsawId, info.data.pieceId)
end

function CORJigsawScenceView:_onUpdateStageColData()
	local parentTran = self._stageView.transform

	self._stageInfoList = {}

	local stageIds = CantonOperaRoadModel.instance:getStageIdsAsJigsaw()

	for idx, stageId in ipairs(stageIds) do
		local mainGo = parentTran:GetChild(idx - 1)
		local data = CantonOperaRoadConfig.instance:getCorJigsawChallengeDataById(self._activityId, stageId)

		if mainGo == nil then
			printError(string.format("预制不足,至少需要%d个预制", idx))
		else
			local info = {
				data = data,
				mainGo = mainGo
			}

			table.insert(self._stageInfoList, info)
		end
	end
end

function CORJigsawScenceView:_onUpdateStageColUI()
	for _, info in ipairs(self._stageInfoList) do
		self:_updateStageCell(info.mainGo, info.data)
	end

	local parentTran = self._stageView.transform

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= #self._stageInfoList)
	end
end

function CORJigsawScenceView:_clearStageCol()
	local parentTran = self._stageView.transform

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)
		local icon = goutil.findChild(mainGo, "icon")

		MaterialMgr.resetAll(icon)
		GameUtil.rmClickHandler(mainGo)
	end
end

function CORJigsawScenceView:_updateStageCell(mainGo, data)
	local icon = goutil.findChild(mainGo, "icon")
	local battleImg = goutil.findChild(mainGo, "battleImg")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName/txt")

	txtName.text = data.stageName

	MaterialMgr.setIcon(icon, MatType.Pet, data.skinId, nil, nil)
	GameUtil.SetActive(battleImg, self._curStageId == data.stageId)
	GameUtil.addClickHandler(btnFormation, GameUtil.handler(self._onClickStageCell, self, info))
end

function CORJigsawScenceView:_onClickStageCell(data)
	if self._curStageId == 0 then
		local text = "还未寻觅关卡，是否开始寻觅？"
		local func
		local btnText = "确定"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", text, func, btnText, alignment)

		return
	end

	if self._curStageId ~= data.stageId then
		FloatWordMgr.instance:show("不是当前已寻觅的关卡，无法进入挑战")

		return
	end

	self:_onClickBtnStart()
end

local SmbNameHash = {
	coroadrolepuzzle_anim = UnityEngine.Animator.StringToHash("Base Layer.coroadrolepuzzle_anim"),
	coroadrolepuzzle_anim2 = UnityEngine.Animator.StringToHash("Base Layer.coroadrolepuzzle_anim2")
}
local SmbNameHash_IgnoreFather = {
	coroadrolepuzzle_anim = UnityEngine.Animator.StringToHash("coroadrolepuzzle_anim"),
	coroadrolepuzzle_anim2 = UnityEngine.Animator.StringToHash("coroadrolepuzzle_anim2")
}
local deskAnimKey = "coroadrolepuzzle_anim"
local deskAnimKey_back = "coroadrolepuzzle_anim2"

function CORJigsawScenceView:_getSmbNameHash(key, isIgnoreFather)
	if isIgnoreFather then
		return SmbNameHash_IgnoreFather[key]
	else
		return SmbNameHash[key]
	end
end

function CORJigsawScenceView:_playTurnDeskAnim()
	self._deskAnimator = self._deskAnimator or self.mainGO:GetComponent(ComponentType.Animator)

	local nameHash

	self._isInBack = not self._isInBack

	self._deskAnimator:Play(self._isInBack and self:_getSmbNameHash(deskAnimKey_back, true) or self:_getSmbNameHash(deskAnimKey, true), 0, 0)
end

function CORJigsawScenceView:_onUpdatePlayerUI()
	local oldStageId = CantonOperaRoadController.instance:getOldStageIdAsCORJigsaw(self._activityId)
	local fitStageIdList = CantonOperaRoadModel.instance:getStageIdsAsJigsaw()
	local stageIdx = table.indexof(fitStageIdList, oldStageId) or 1
	local info = self._stageInfoList[stageIdx]

	if info then
		local pos = GameUtil.getPos(info.mainGo)

		GameUtil.setPos(self._player, pos.x, pos.y, pos.z)
	end

	HeadItemController.instance:setMyHeadCell(self._player)
end

function CORJigsawScenceView:_readyPlayDrawStageAnim()
	ViewBlockMgr.instance:blockClick(true, self)

	self._stageAnimInfo = {}

	if self._stageInfoList == nil then
		printError("没有关卡可以抽取")

		return
	end

	local fitStageIdList = CantonOperaRoadModel.instance:getStageIdsAsJigsaw()
	local fitStageId = CantonOperaRoadController.instance:getFitStageIdAsCORJigsaw()
	local targetIdx = table.indexof(fitStageIdList, fitStageId)

	if targetIdx == false then
		printError("错误,抽取出来的stageId不符合要求")

		return
	end

	self._curStageId = fitStageId
	self._stageCount = #self._stageInfoList

	local oldStageId = CantonOperaRoadController.instance:getOldStageIdAsCORJigsaw(self._activityId)

	CantonOperaRoadController.instance:saveOldStageIdAsCORJigsaw(self._activityId, fitStageId)

	if not CantonOperaRoadController.instance:isFitStageIdAsCORJigsaw(oldStageId) then
		oldStageId = 0
	end

	self._curStageIdx = table.indexof(fitStageIdList, oldStageId) or 1
	self._totalStepCount = targetIdx + 0 * self._stageCount + (self._stageCount - self._curStageIdx)
	self._animSequence = DG.Tweening.DOTween.Sequence()

	for i = 1, self._totalStepCount do
		local targetStageIdx = math.max((self._curStageIdx + 1) % (self._stageCount + 1), 1)
		local targetInfo = self._stageInfoList[targetStageIdx]
		local targetPos = GameUtil.getPos(targetInfo.mainGo)

		if targetStageIdx > self._curStageIdx then
			self._animSequence:Append(self._player.transform:DOMove(targetPos, 0.5))
		else
			local function CallBack()
				GameUtil.setPos(self._player, targetPos.x, targetPos.y, targetPos.z)
			end

			self._animSequence:AppendCallback(CallBack)
			self._animSequence:AppendInterval(0.5)
		end

		self._curStageIdx = targetStageIdx
	end

	local function finishCallback()
		ViewBlockMgr.instance:blockClick(false, self)
		self:_enterChallenge()
	end

	self._animSequence:AppendCallback(finishCallback)
end

function CORJigsawScenceView:_onClickBtnGet()
	self:_playTurnDeskAnim()
end

function CORJigsawScenceView:_onClickBtnStart()
	local result = CantonOperaRoadController.instance:getEnterChallengeResultAsCORJigsaw(self._jigsawId)

	if result ~= GameEnum.ResultCode.Success then
		local str = ""

		str = result == GameEnum.ResultCode.IsPassJigsaw and "该拼图您已点亮" or result == GameEnum.ResultCode.IsCollectEnough and "您已收集足够拼图碎片" or result == GameEnum.ResultCode.NoEnergy and "能量不足" or CantonOperaRoadController.instance:getTipsStrByEnterResultAsCOR(self._modelId)

		if not string.nilorempty(str) then
			FloatWordMgr.instance:show(str)
		end

		return
	end

	self:_readyPlayDrawStageAnim()

	local effParent = self.mainGO
	local pathName = "20220902/yuejuzhilu/fx_ui_yjzl_shizhong"

	UIEffectManager.instance:stopEffect(self._drawEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._drawEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function CORJigsawScenceView:_enterChallenge()
	self:close()
	CantonOperaRoadModel.instance:clearViewInfos()
	CantonOperaRoadModel.instance:addViewInfo(ViewName.CORoadMainView)
	CantonOperaRoadModel.instance:addViewInfo(ViewName.CORJigsawMainView)
	CantonOperaRoadModel.instance:addViewInfo(self._viewPresentor.viewName, self._jigsawId)
	CantonOperaRoadController.instance:enterBattleAsJigsaw(self._jigsawId, self._curStageId)
end

return CORJigsawScenceView
