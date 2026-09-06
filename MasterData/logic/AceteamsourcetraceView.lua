-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamsourcetraceView.lua

module("logic.extensions.aceteam.view.petshow.AceteamsourcetraceView", package.seeall)

local AceteamsourcetraceView = class("AceteamsourcetraceView", ViewComponent)
local NODE_TYPE_NORMAL = 1
local NODE_TYPE_MULTI = 2
local ICON_TYPE_LOAD = 1
local ICON_TYPE_SPRITE = 2

function AceteamsourcetraceView:unbindEvents()
	AceteamsourcetraceView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnDetail)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function AceteamsourcetraceView:bindEvents()
	AceteamsourcetraceView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	GameUtil.addClickHandler(self._btnDetail, self._onClickDetail, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function AceteamsourcetraceView:buildUI()
	AceteamsourcetraceView.super.buildUI(self)

	self._multiCell = self:getGo("sourceTraceSkillRoot/multiCell")
	self._normalCell = self:getGo("sourceTraceSkillRoot/normalCell")
	self._mapLinkRoot = self:getGo("sourceTraceSkillRoot/mapLinkRoot")
	self._mapRoot = self:getGo("sourceTraceSkillRoot/mapRoot")
	self._cellContain = self:getGo("sourceTraceSkillRoot/cellContain")
	self._mapBg = self:getGo("sourceTraceSkillRoot/mapBg")
	self._sourceTraceSkillRoot = self:getGo("sourceTraceSkillRoot")
	self._baseShowLine = goutil.findChildComponent(self._sourceTraceSkillRoot, "mapLinkRoot", "LineGraphic")

	GameUtil.SetActive(self._mapLinkRoot, false)

	self._skillTableview = self:getGo("attrRoot/skillTableview")
	self._skillTablecell = self:getGo("attrRoot/skillTablecell")
	self._skillTableList = ScrollerList.create(self._skillTableview, self._skillTablecell, GameUtil.handler(self._updateSkillCell, self), GameUtil.handler(self._clearSkillCell, self))
	self._skillEmptyTips = self:getGo("attrRoot/emptyTips")
	self._attrTablecell = self:getGo("attrRoot/attrTablecell")
	self._attrTableview = self:getGo("attrRoot/attrTableview")
	self._attrTableList = ScrollerList.create(self._attrTableview, self._attrTablecell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
	self._txtBaseDesc = self:getTxt("baseDesc/tableview/viewport/content/txt")
	self._detailInfo = self:getGo("detailInfo")
	self._txtNodeInfo = self:getTxt("detailInfo/nodeTableview/viewport/content/txtNodeInfo")
	self._txtDetailDesc = self:getTxt("detailInfo/baseTableview/viewport/content/txtDesc")
	self._customInput = UICustomInput.Get(self._detailInfo)
	self._btnOneKey = self:getGo("btnOneKey")
	self._btnDetail = self:getGo("btnDetail")
end

function AceteamsourcetraceView:onExit()
	AceteamsourcetraceView.super.onExit(self)
	self:_clearSourceTraceSkill()

	if self._cellPools then
		for i, v in pairs(self._cellPools) do
			v:clear()
		end
	end
end

function AceteamsourcetraceView:onEnter()
	AceteamsourcetraceView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ACETEAM_GETINFO, self._updateView, self)
	self.addGEvent(self, GlobalNotify.PM_ACETEAM_PETCHANGE, self._updateView, self)
	GameUtil.SetActive(self._detailInfo, false)
	self:_updateView()
end

function AceteamsourcetraceView:_updateView()
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

	for i, v in ipairs(self._curPetMo.sourceTraces) do
		local obj = self._nodeInfoMap[v.nodeId]

		if obj then
			obj.effectId = v.effectId

			for j, effId in ipairs(v.unlockEffectIds or {}) do
				table.insert(obj.unlockEffectIds, effId)
			end
		end
	end

	self:_clearSourceTraceSkill()
	self:_createSourceTraceSkill(self._mapRoot, sourceTraceId)
	self:_refreshAttrInfo(sourceTraceId)
	self:_refreshDetailInfo(sourceTraceId)
end

function AceteamsourcetraceView:_refreshDetailInfo(sourceTraceId)
	local groupInfoCfg = SourceTraceConfig.instance:getGroupInfoCfg(sourceTraceId)

	self._txtDetailDesc.text = groupInfoCfg and langPara("源起技：%s", groupInfoCfg.skillBaseDesc) or langPara("源起技无基础效果")

	local nodeInfoList = {}

	for i, v in ipairs(self._nodesCfg) do
		if #v.effectIds > 1 then
			if not NODE_TYPE_MULTI then
				local type = NODE_TYPE_NORMAL
				local petNodeInfo = self._nodeInfoMap[v.nodeId]

				if petNodeInfo and petNodeInfo.effectId > 0 then
					local effectCfg = SourceTraceConfig.instance:getEffectCfg(petNodeInfo.effectId)
					local content

					if type == NODE_TYPE_MULTI then
						local romanChar = string.sub(effectCfg.name, 1, 3)

						content = langPara("源核%s :\n%s", romanChar, effectCfg.desc)
					else
						content = langPara("%s :\n%s", effectCfg.name, effectCfg.desc)
					end

					table.insert(nodeInfoList, {
						index = 1,
						active = 1,
						type = type,
						nodeId = v.nodeId,
						content = content
					})
				else
					for j, id in ipairs(v.effectIds) do
						local effectCfg = SourceTraceConfig.instance:getEffectCfg(id)
						local content = type == NODE_TYPE_MULTI and langPara("源核%s :\n%s", effectCfg.name, effectCfg.desc) or langPara("%s :\n%s", effectCfg.name, effectCfg.desc)

						table.insert(nodeInfoList, {
							active = 0,
							type = type,
							nodeId = v.nodeId,
							index = j,
							content = content
						})
					end
				end
			end
		end
	end

	ArraySort.sortOn(nodeInfoList, {
		"active",
		"type",
		"nodeId",
		"index"
	}, {
		ArraySort.DESCENDING,
		ArraySort.NONE,
		ArraySort.NONE,
		ArraySort.NONE
	})

	local activeList = {}
	local unActIveList = {}

	for i, v in ipairs(nodeInfoList) do
		if v.active == 0 then
			table.insert(unActIveList, v.content)
		else
			table.insert(activeList, v.content)
		end
	end

	local resultStr = ""

	if #activeList > 0 then
		local activeStr = table.concat(activeList, "\n\n")

		resultStr = resultStr .. string.format("<color=#466687FF>%s</color>\n\n", activeStr)
	end

	if #unActIveList > 0 then
		local unActIveStr = table.concat(unActIveList, "\n\n")

		resultStr = resultStr .. string.format("<color=#909294FF>%s</color>", unActIveStr)
	end

	self._txtNodeInfo.text = resultStr
end

function AceteamsourcetraceView:_refreshAttrInfo(sourceTraceId)
	local attrMap = {}
	local buffList = {}

	for i, v in ipairs(self._curPetMo.sourceTraces) do
		local nodesCfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(sourceTraceId, v.nodeId)
		local effectCfg = SourceTraceConfig.instance:getEffectCfg(v.effectId)
		local attrValue = FightingPowerFormula.instance:parseAttrValues(effectCfg.propertyParam) or {}

		for attrType, value in pairs(attrValue) do
			attrMap[attrType] = checknumber(attrMap[attrType]) + value
		end

		if nodesCfg.effectIds and #nodesCfg.effectIds > 1 then
			table.insert(buffList, effectCfg)
		end
	end

	local attrList = {}

	for i, v in pairs(attrMap) do
		table.insert(attrList, {
			attrType = i,
			value = v
		})
	end

	table.sort(attrList, function(a, b)
		return a.attrType < b.attrType
	end)
	self._attrTableList:reloadData(attrList)
	GameUtil.SetActive(self._skillEmptyTips, #buffList <= 0)
	self._skillTableList:reloadData(buffList)

	local groupInfoCfg = SourceTraceConfig.instance:getGroupInfoCfg(sourceTraceId)

	if groupInfoCfg then
		uGuiUtil.setSpriteToImage(self._mapBg, nil, groupInfoCfg.mapBgRes)

		self._txtBaseDesc.text = langPara("源起技：%s", groupInfoCfg.skillBaseDesc)
	else
		printError("图谱背景图未配置，id = ", sourceTraceId)

		self._txtBaseDesc.text = langPara("源起技无基础效果")
	end
end

function AceteamsourcetraceView:_createSourceTraceSkill(rootGo, sourceTraceId)
	GameUtil.SetActive(self._multiCell, false)
	GameUtil.SetActive(self._normalCell, false)

	self._nodeCellList = {}

	for i, v in ipairs(self._nodesCfg) do
		local cell = self:_genarateNodeCell(rootGo, v)

		if #v.effectIds <= 1 then
			self:_updateNormalCell(cell, v, self._aceteamSTList[i])

			self._nodeCellList[v.nodeId] = {
				type = NODE_TYPE_NORMAL,
				cell = cell,
				index = v.nodeId
			}
		else
			self:_updateMultiCell(cell, v, self._aceteamSTList[i])

			self._nodeCellList[v.nodeId] = {
				type = NODE_TYPE_MULTI,
				cell = cell,
				index = v.nodeId
			}
		end
	end
end

function AceteamsourcetraceView:_clearSourceTraceSkill()
	if self._nodeCellList then
		for i, v in pairs(self._nodeCellList) do
			if v.type == NODE_TYPE_NORMAL then
				self:_clearNormalCell(v.cell)
			else
				self:_clearMultiCell(v.cell)
			end

			self._cellPools[v.type]:returnObject(v.cell)
		end

		self._nodeCellList = {}
	end
end

function AceteamsourcetraceView:_genarateNodeCell(rootGo, cellCfg)
	self._cellPools = self._cellPools or {}

	local index = NODE_TYPE_NORMAL

	if #cellCfg.effectIds > 1 then
		index = NODE_TYPE_MULTI
	end

	if not self._cellPools[index] then
		local function resetFunc(obj)
			self:_resetFunc(obj, index)
		end

		local function disposeFunc(obj)
			self:_disposeFunc(obj, index)
		end

		local createFunc

		self._cellPools[index] = ObjectPool.New(5, index == NODE_TYPE_MULTI and function()
			return (goutil.cloneAndSetParent(self._multiCell, rootGo.gameObject.transform))
		end or function()
			return (goutil.cloneAndSetParent(self._normalCell, rootGo.gameObject.transform))
		end, disposeFunc, resetFunc)
	end

	local cellObj = self._cellPools[index]:fetchObject()

	goutil.addChildToParent(cellObj.gameObject, rootGo.gameObject.transform)
	GameUtil.SetActive(cellObj.gameObject, true)

	return cellObj
end

function AceteamsourcetraceView:_disposeFunc(obj, index)
	goutil.destroy(obj)
end

function AceteamsourcetraceView:_resetFunc(obj, index)
	GameUtil.SetActive(obj.gameObject, false)
end

function AceteamsourcetraceView:_updateNormalCell(cellGo, cfg, aceTeamSTCfg)
	local go = cellGo

	GameUtil.setAnchoredPos(go, aceTeamSTCfg.pos[1], aceTeamSTCfg.pos[2])

	local iconGo = goutil.findChild(go, "Mask")
	local iconBg = goutil.findChild(go, "ImgC_Bg")
	local unActiveableMaskGo = goutil.findChild(go, "unActiveableMask")
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")
	local skillIconSprite = goutil.findChild(go, "Mask/ImgC_Icon")
	local imageChangeSkillIcon = skillIconSprite:GetComponent(ComponentType.UIImageSpriteChange)
	local btn = goutil.findChild(go, "btn")
	local activableGo = goutil.findChild(go, "activeableGo")
	local effectCfg = SourceTraceConfig.instance:getEffectCfg(cfg.effectIds[1])

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

	local isActive = self._nodeInfoMap[cfg.nodeId] ~= nil

	GameUtil.SetActive(unActiveableMaskGo, not isActive)

	if self:_isCanActiveNode(cfg.groupId, cfg.nodeId) == true then
		GameUtil.SetActive(activableGo, true)
	else
		GameUtil.SetActive(activableGo, false)
	end

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickNormalCell(cfg.nodeId)
	end)
end

function AceteamsourcetraceView:_clearNormalCell(cellGo)
	local go = cellGo
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")
	local btn = goutil.findChild(go, "btn")

	uGuiUtil.clearImage(skillIconLoad)
	GameUtil.rmClickHandler(btn)
end

function AceteamsourcetraceView:_updateMultiCell(cellGo, cfg, aceTeamSTCfg)
	local go = cellGo

	GameUtil.setAnchoredPos(go, aceTeamSTCfg.pos[1], aceTeamSTCfg.pos[2])

	local cellRoot = goutil.findChild(go, "cellsRoot")
	local cell = goutil.findChild(go, "cellsRoot/cell")
	local recordPos = cellRoot:GetComponent(ComponentType.TestRecordPos)
	local activableGo = goutil.findChild(go, "activeableGo")
	local activeTag = goutil.findChild(go, "activeTag")
	local btn = goutil.findChild(go, "btnEffect")
	local singleCellInfos = {}
	local firstEffectId, selectInfo

	for i, v in ipairs(cfg.effectIds) do
		firstEffectId = firstEffectId or v

		if self._nodeInfoMap[cfg.nodeId] and self._nodeInfoMap[cfg.nodeId].effectId == v then
			selectInfo = {
				nodeCfg = cfg,
				effectId = v
			}
		else
			table.insert(singleCellInfos, {
				nodeCfg = cfg,
				effectId = v
			})
		end
	end

	if selectInfo then
		firstEffectId = selectInfo.effectId

		table.insert(singleCellInfos, selectInfo)
	end

	GameUtil.updateCellsList(cellRoot, cell, singleCellInfos, self._updateMutiSingleCell, self)
	recordPos:LoadPlan(#singleCellInfos - 1)
	GameUtil.SetActive(activeTag, self._nodeInfoMap[cfg.nodeId])

	if self:_isCanActiveNode(cfg.groupId, cfg.nodeId) == true then
		GameUtil.SetActive(activableGo, true)
	else
		GameUtil.SetActive(activableGo, false)
	end

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickMutiCell(cfg.nodeId, firstEffectId)
	end)
end

function AceteamsourcetraceView:_clearMultiCell(cellGo)
	local go = cellGo
	local cellRoot = goutil.findChild(go, "cellsRoot")
	local btn = goutil.findChild(go, "btnEffect")

	GameUtil.SetActive(go, false)
	GameUtil.clearCells(cellRoot, self._clearMultiSingleCell, self, false)
	GameUtil.rmClickHandler(btn)
end

function AceteamsourcetraceView:_updateMutiSingleCell(cell, data, index)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")
	local skillIconSprite = goutil.findChild(go, "Mask/ImgC_Icon")
	local unActiveableMask = goutil.findChild(go, "unActiveableMask")
	local imageChangeSkillIcon = skillIconSprite:GetComponent(ComponentType.UIImageSpriteChange)
	local effectCfg = SourceTraceConfig.instance:getEffectCfg(data.effectId)

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

	local isActive = self._nodeInfoMap[data.nodeCfg.nodeId] ~= nil
	local isSelect = isActive and self._nodeInfoMap[data.nodeCfg.nodeId].effectId == data.effectId

	GameUtil.SetActive(unActiveableMask, not isSelect)
end

function AceteamsourcetraceView:_clearMultiSingleCell(cell)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")

	uGuiUtil.clearImage(skillIconLoad)
end

function AceteamsourcetraceView:_isCanActiveNode(groupId, nodeId)
	local cfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(groupId, nodeId)
	local isActivable = self._nodeInfoMap[cfg.nodeId] == nil

	if isActivable == true and cfg.preNodeIds then
		for i, v in ipairs(cfg.preNodeIds) do
			if self._nodeInfoMap[v] == nil then
				isActivable = false

				break
			end
		end
	end

	local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(cfg.unlockCost)

	if isActivable == true and not MaterialModel.instance:IsEnough(costMatType, costMatId, costMatNum) then
		isActivable = false
	end

	return isActivable
end

function AceteamsourcetraceView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local nameTxt = goutil.findChildTextComponent(go, "nameText")
	local valueTxt = goutil.findChildTextComponent(go, "valueText")
	local iconGo = goutil.findChild(go, "attr")
	local icon = goutil.findChildComponent(go, "attr", "UIImageSpriteChange")

	if data.attrType then
		goutil.setActive(iconGo, true)
		icon:SetState(data.attrType - 1)
	else
		goutil.setActive(iconGo, false)
	end

	valueTxt.text = data.value > 0 and data.value < 1 and string.format("%s%%", data.value * 100) or data.value
	nameTxt.text = GameEnum.AttrTypeName[data.attrType]
end

function AceteamsourcetraceView:_clearAttrCell(cell)
	return
end

function AceteamsourcetraceView:_updateSkillCell(view, cell, data, tag)
	local go = cell.gameObject
	local skillIcon = goutil.findChild(go, "Mask/ImgC_Skill")
	local txtDesc = goutil.findChildTextComponent(go, "desc")

	uGuiUtil.setSpriteToImage(skillIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(data.iconRes))

	txtDesc.text = data.desc
end

function AceteamsourcetraceView:_clearSkillCell(cell)
	local go = cell.gameObject
	local skillIcon = goutil.findChild(go, "Mask/ImgC_Skill")

	uGuiUtil.clearImage(skillIcon)
end

function AceteamsourcetraceView:_onClickNormalCell(nodeId)
	if enableDebug then
		printError(">>>>>>>>>>>>>.需求还没有的哦。文档没有，后端也没实现 2026.01.26")
		TipsFacade.instance:openCommonTips("需求还没有的哦。文档没有，后端也没实现 2026.01.26")
	end
end

function AceteamsourcetraceView:_onClickMutiCell(nodeId, effectId)
	UIStateManager.instance:push(ViewName.AceteamsourcetracemultinodeView, nodeId, effectId)
end

function AceteamsourcetraceView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._detailInfo, false)
	end
end

function AceteamsourcetraceView:_onClickDetail()
	GameUtil.SetActive(self._detailInfo, true)
end

function AceteamsourcetraceView:_onClickOneKey()
	return
end

return AceteamsourcetraceView
