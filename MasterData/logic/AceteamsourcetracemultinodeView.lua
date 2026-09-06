-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteamsourcetracemultinodeView.lua

module("logic.extensions.aceteam.view.AceteamsourcetracemultinodeView", package.seeall)

local AceteamsourcetracemultinodeView = class("AceteamsourcetracemultinodeView", ViewComponent)
local ICON_TYPE_LOAD = 1
local ICON_TYPE_SPRITE = 2
local LINK_MAX_COUNT = 3

function AceteamsourcetracemultinodeView:unbindEvents()
	AceteamsourcetracemultinodeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnNext)
	GameUtil.rmClickHandler(self._btnPre)
	GameUtil.rmClickHandler(self._btnClose)
end

function AceteamsourcetracemultinodeView:bindEvents()
	AceteamsourcetracemultinodeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnNext, self._onClickNext, self)
	GameUtil.addClickHandler(self._btnPre, self._onClickPre, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function AceteamsourcetracemultinodeView:buildUI()
	AceteamsourcetracemultinodeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._cost = self:getGo("cost")
	self._costCon = self:getGo("cost/con")
	self._txtCost = self:getTxt("cost/txtCost")
	self._colorChangeTxtCost = self._txtCost.gameObject:GetComponent(ComponentType.UITextColorChange)
	self._txtActiveTips = self:getGo("txtActiveTips")
	self._effectTableview = self:getGo("mutiInfo/effectTableview")
	self._effectTableCell = self:getGo("mutiInfo/effectTableview/effectTableCell")
	self._effectTableList = ScrollerList.create(self._effectTableview, self._effectTableCell, GameUtil.handler(self._updateEffectCell, self), GameUtil.handler(self._clearEffectCell, self))

	self._effectTableList:setCenterMode(true)

	self._txtNodeName = self:getTxt("txtNodeName")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtBaseDesc = self:getTxt("txtBaseDesc")
	self._nodeTablecell = self:getGo("mutiInfo/nodeTableview/nodeTablecell")
	self._nodeTableview = self:getGo("mutiInfo/nodeTableview")
	self._nodeTableList = ScrollerList.create(self._nodeTableview, self._nodeTablecell, GameUtil.handler(self._updateNodeCell, self), GameUtil.handler(self._clearNodeCell, self))
	self._linkGo = self:getGo("mutiInfo/link")
	self._linkGoMap = {}

	for i = 1, LINK_MAX_COUNT do
		self._linkGoMap[i] = self._linkGoMap[i] or {}

		for j = 1, LINK_MAX_COUNT do
			self._linkGoMap[i][j] = goutil.findChild(self._linkGo, string.format("link_%d_%d", i, j))
		end
	end

	self._btnNext = self:getGo("btnNext")
	self._btnPre = self:getGo("btnPre")
	self._canActiveTag = self:getGo("activeTag")
end

function AceteamsourcetracemultinodeView:onExit()
	AceteamsourcetracemultinodeView.super.onExit(self)
	MaterialMgr.resetAll(self._costCon)
end

function AceteamsourcetracemultinodeView:onEnter()
	AceteamsourcetracemultinodeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ACETEAM_SOURCE_TRACE_UNLOCK, self._PM_SourceTraceUnlockNodeRes, self)
	self.addGEvent(self, GlobalNotify.PM_ACETEAM_SOURCE_TRACE_SELECT, self._PM_SourceTraceChangeEffectRes, self)

	local params = self:getOpenParam()

	self._nodeId = checknumber(params[1])
	self._effectId = checknumber(params[2])

	self:_updateNodeData()

	self._cloneCfgMap = {}

	local nodesCfg = {}

	for i, v in ipairs(self._aceteamSTList) do
		local cfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(self._sourceTraceId, v.nodeId) or {}

		cfg = clone(cfg)
		cfg.preNodeIds = {}

		table.insert(nodesCfg, cfg)

		self._cloneCfgMap[v.nodeId] = cfg
	end

	self._multiNode = {}
	self._multiNodeIndex = 1

	for i, v in ipairs(nodesCfg) do
		if #v.effectIds > 1 then
			table.insert(self._multiNode, v.nodeId)

			if v.nodeId == self._nodeId then
				self._multiNodeIndex = #self._multiNode
			end
		end
	end

	self:_refreshView()
end

function AceteamsourcetracemultinodeView:_refreshView()
	self._nodeCfg = self._cloneCfgMap[self._nodeId] or {}

	self._effectTableList:reloadData(self._nodeCfg.effectIds)

	local effectId = self._effectId
	local unlockEffectIds = {}

	if self._nodeInfo then
		unlockEffectIds = self._nodeInfo.unlockEffectIds or {}
	end

	GameUtil.SetActive(self._cost, false)
	GameUtil.SetActive(self._txtActiveTips, true)

	if effectId > 0 and table.indexof(unlockEffectIds, effectId) == false then
		local cfg = AceTeamConfig.instance:getSourceTraceCfg(self._sourceTraceGroupId, self._nodeId) or {}
		local point = checknumber(cfg.point)
		local unlockCost = MaterialMgr.createSerName(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT, point)
		local matType, matId, matNum = MaterialMgr.getMatParams(unlockCost)

		MaterialMgr.resetAll(self._costCon)

		local proxy = MaterialMgr.setCell(matType, matId, self._costCon)

		if proxy then
			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				return
			end)
		end

		local curNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

		self._txtCost.text = langPara("%d<color=#1E356CFF>/%d</color>", curNum, matNum)

		if curNum < matNum then
			self._colorChangeTxtCost:SetState(0)
		else
			self._colorChangeTxtCost:SetState(1)
		end

		GameUtil.SetActive(self._cost, true)
		GameUtil.SetActive(self._txtActiveTips, false)
	end

	self._txtNodeName.text = langPara("源核%s", GameUtil.toRomanNumber(self._multiNodeIndex))
	self._txtTitle.text = langPara("源核%s信息", GameUtil.toRomanNumber(self._multiNodeIndex))

	local groupInfoCfg = SourceTraceConfig.instance:getGroupInfoCfg(self._sourceTraceId)

	self._txtBaseDesc.text = groupInfoCfg and groupInfoCfg.skillBaseDesc or lang("无基础效果描述")

	local nodeInfo = {}

	for i, v in ipairs(self._multiNode) do
		table.insert(nodeInfo, {
			nodeId = v,
			index = i,
			nodeInfo = self._nodeInfoMap[v]
		})
	end

	self._nodeTableList:reloadData(nodeInfo)

	for i, v in pairs(self._linkGoMap) do
		for j, go in ipairs(v) do
			GameUtil.SetActive(go, false)
		end
	end

	local selectEffectIndex = 1

	for i, v in ipairs(self._nodeCfg.effectIds) do
		if v == self._effectId then
			selectEffectIndex = i
		end
	end

	if self._linkGoMap[self._multiNodeIndex] then
		GameUtil.SetActive(self._linkGoMap[self._multiNodeIndex][selectEffectIndex], true)
	end

	local isActivable = true

	if self._nodeCfg.preNodeIds then
		for i, v in ipairs(self._nodeCfg.preNodeIds) do
			if self._nodeInfoMap[v] == nil then
				isActivable = false

				break
			end
		end
	end

	GameUtil.SetActive(self._canActiveTag, not isActivable)
	GameUtil.SetActive(self._btnSure, self._nodeInfo or isActivable == true)
end

function AceteamsourcetracemultinodeView:_updateEffectCell(view, cell, data, tag)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")
	local skillIconSprite = goutil.findChild(go, "Mask/ImgC_Icon")
	local imageChangeSkillIcon = skillIconSprite:GetComponent(ComponentType.UIImageSpriteChange)
	local activeTag = goutil.findChild(go, "activeTag")
	local btn = goutil.findChild(go, "btn")
	local imgSelect = goutil.findChild(go, "imgSelect")

	GameUtil.SetActive(imgSelect, data == self._effectId)
	GameUtil.SetActive(activeTag, self._nodeInfo and self._nodeInfo.effectId == data)

	local effectCfg = SourceTraceConfig.instance:getEffectCfg(data)

	uGuiUtil.clearImage(skillIconLoad)
	GameUtil.SetActive(skillIconLoad, false)
	GameUtil.SetActive(skillIconSprite, false)

	if effectCfg.iconType == ICON_TYPE_LOAD then
		GameUtil.SetActive(skillIconLoad, true)
		uGuiUtil.setSpriteToImage(skillIconLoad, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(effectCfg.iconRes))
	elseif effectCfg.iconType == ICON_TYPE_SPRITE then
		GameUtil.SetActive(skillIconSprite, true)
		imageChangeSkillIcon:ChangeSprite(effectCfg.iconRes)
	end

	GameUtil.addClickHandler(btn, function()
		self:_onClickEffectCell(data)
	end)
end

function AceteamsourcetracemultinodeView:_clearEffectCell(cell)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")

	uGuiUtil.clearImage(skillIconLoad)
end

function AceteamsourcetracemultinodeView:_updateNodeCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgBgSelect = goutil.findChild(go, "imgBgSelect")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")

	GameUtil.SetActive(imgBgSelect, data.index == self._multiNodeIndex)

	if self._multiNodeIndex == data.index then
		local effectCfg = SourceTraceConfig.instance:getEffectCfg(self._effectId)

		txtDesc.text = langPara("源核%s：%s", GameUtil.toRomanNumber(data.index), effectCfg.desc)
	elseif data.nodeInfo and checknumber(data.nodeInfo.effectId) > 0 then
		local effectCfg = SourceTraceConfig.instance:getEffectCfg(data.nodeInfo.effectId)

		txtDesc.text = langPara("源核%s：%s", GameUtil.toRomanNumber(data.index), effectCfg.desc)
	else
		txtDesc.text = langPara("源核%s：未激活", GameUtil.toRomanNumber(data.index))
	end
end

function AceteamsourcetracemultinodeView:_clearNodeCell(cell)
	return
end

function AceteamsourcetracemultinodeView:_onClickSure()
	local effectId = self._effectId
	local unlockEffectIds = {}

	if self._nodeInfo then
		unlockEffectIds = self._nodeInfo.unlockEffectIds or {}
	end

	GameUtil.SetActive(self._txtActiveTips, true)

	if effectId > 0 and table.indexof(unlockEffectIds, effectId) == false then
		local cfg = AceTeamConfig.instance:getSourceTraceCfg(self._sourceTraceGroupId, self._nodeId) or {}
		local point = checknumber(cfg.point)
		local unlockCost = MaterialMgr.createSerName(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT, point)
		local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(unlockCost)

		if not MaterialModel.instance:IsEnough(costMatType, costMatId, costMatNum) then
			FloatWordMgr.instance:show(lang("所需材料不足"))

			return
		end

		AceTeamAgent.instance:sendPM_AceTeamSourceTraceUnlockEffectReq(self._curPetMo.petId, self._nodeId, effectId)
	elseif checknumber(self._nodeInfo.effectId) == self._effectId then
		FloatWordMgr.instance:show(lang("已激活"))
	else
		AceTeamAgent.instance:sendPM_AceTeamSourceTraceSelectEffectReq(self._curPetMo.petId, self._nodeId, effectId)
	end
end

function AceteamsourcetracemultinodeView:_onClickEffectCell(effectId)
	self._effectId = effectId

	self:_refreshView()
end

function AceteamsourcetracemultinodeView:_onClickNext()
	self._multiNodeIndex = self._multiNodeIndex + 1

	if self._multiNodeIndex > #self._multiNode then
		self._multiNodeIndex = 1
	end

	self:_showCurrTab(self._multiNodeIndex)
end

function AceteamsourcetracemultinodeView:_onClickPre()
	self._multiNodeIndex = self._multiNodeIndex - 1

	if self._multiNodeIndex <= 0 then
		self._multiNodeIndex = #self._multiNode
	end

	self:_showCurrTab(self._multiNodeIndex)
end

function AceteamsourcetracemultinodeView:_showCurrTab(index)
	self._nodeId = self._multiNode[index]
	self._nodeInfo = self._nodeInfoMap[self._nodeId]

	if self._nodeInfo and checknumber(self._nodeInfo.effectId) > 0 then
		self._effectId = self._nodeInfo.effectId
	else
		self._nodeCfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(self._sourceTraceId, self._nodeId)
		self._effectId = self._nodeCfg.effectIds[1]
	end

	self:_refreshView()
end

function AceteamsourcetracemultinodeView:_PM_SourceTraceUnlockNodeRes()
	self:_updateNodeData()

	if self._nodeInfo and checknumber(self._nodeInfo.effectId) ~= self._effectId then
		AceTeamAgent.instance:sendPM_AceTeamSourceTraceSelectEffectReq(self._curPetMo.petId, self._nodeId, self._effectId)
	else
		self:_refreshView()
	end
end

function AceteamsourcetracemultinodeView:_PM_SourceTraceChangeEffectRes()
	self:_updateNodeData()
	self:_refreshView()
end

function AceteamsourcetracemultinodeView:_updateNodeData()
	self._curPetMo = AceTeamModel.instance:getCurrPetMo() or {}

	local groupId = checknumber(AceTeamModel.instance.teamId)
	local petId = self._curPetMo.petId
	local cfg = AceTeamConfig.instance:getPetCfgById(groupId, petId)
	local sourceTraceGroupId = checknumber(cfg.sourceTraceGroupId)
	local petCfg = CharacterConfig.instance:getPetCo(self._curPetMo.raceId)
	local sourceTraceId = checknumber(petCfg.sourceTraceId)

	if sourceTraceId <= 0 then
		return
	end

	self._sourceTraceGroupId = sourceTraceGroupId
	self._sourceTraceId = sourceTraceId

	local aceSTCfg = AceTeamConfig.instance:getSourceTraceGroupCfg(sourceTraceGroupId) or {}
	local list = {}

	for k, v in pairs(aceSTCfg) do
		table.insert(list, v)
	end

	ArraySort.sortOn(list, "nodeId", ArraySort.NUMERIC)

	self._aceteamSTList = list

	local defaultST = {}
	local nodesCfg = {}

	for i, v in ipairs(self._aceteamSTList) do
		local cfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(sourceTraceId, v.nodeId) or {}

		table.insert(nodesCfg, cfg)

		local obj = {}

		obj.nodeId = v.nodeId
		obj.effectId = 0
		obj.unlockEffectIds = {}
		defaultST[v.nodeId] = obj
	end

	self._nodesCfg = nodesCfg
	self._nodeInfoMap = defaultST
	self._nodeInfo = nil

	for i, v in ipairs(self._curPetMo.sourceTraces) do
		local obj = self._nodeInfoMap[v.nodeId]

		if obj then
			obj.effectId = v.effectId

			for j, effId in ipairs(v.unlockEffectIds or {}) do
				table.insert(obj.unlockEffectIds, effId)
			end
		end
	end

	for i, v in pairs(self._nodeInfoMap) do
		if v.nodeId == self._nodeId then
			self._nodeInfo = v

			break
		end
	end
end

return AceteamsourcetracemultinodeView
