-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/monsterdata/HandbookMonsterdataView.lua

module("logic.extensions.playerinfo.view.handbook.monsterdata.HandbookMonsterdataView", package.seeall)

local M = class("HandbookMonsterdataView", ViewComponent)

M.SubToggleType = {
	Skill = 2,
	Profile = 1,
	Evaluate = 3
}
M.TagColor = {
	"#898989",
	"#99D182",
	"#7ED6FF",
	"#D1B382"
}
M.LightCode = 8

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnReturn = self:getBtn("2&title_view_-878360263")
	self._txtName = self:getText("handbook_mosterdata_view_-1078987941")
	self._txtTyp = self:getText("handbook_mosterdata_view_-1476793534")
	self._imgLiHui = self:getImage("handbook_mosterdata_view_638921956")
	self._imgDynIconLiHui = Astral.ImageDynIcon.Get(self._imgLiHui.gameObject)
	self._rawImg = self:getUIComponent("handbook_mosterdata_view_-1904120744", UIComponentType.RawImage)
	self._photoUnit = Astral.LuaComponentContainer.Add(self._rawImg.gameObject, PhotoMultiModel)

	self._photoUnit:setFixAnimation({
		[UnitAnimState.Idle1] = UnitAnimState.Idle,
		[UnitAnimState.Idle2] = UnitAnimState.Idle1
	})
	self._photoUnit:setDefaultAnim(UnitAnimState.Idle2)
	self._photoUnit:setLightCode(self.LightCode)
	self._photoUnit:setModelsLoadedCallback(self._onModelsLoaded, self)
	self._photoUnit:enableTouch(nil, Handler.New(self._onBeginDragModel, self), Handler.New(self._onDragModel, self), Handler.New(self._onEndDragModel, self))

	self._goPanel = {}
	self._goPanel[self.SubToggleType.Profile] = self:getGo("handbook_mosterdata_view_1907296571")
	self._goPanel[self.SubToggleType.Skill] = self:getGo("handbook_mosterdata_view_-800645325")
	self._goPanel[self.SubToggleType.Evaluate] = self:getGo("handbook_mosterdata_view_2106583323")
	self._txtProfileDesc = self:getText("handbook_mosterdata_view_-685068660")
	self._loopLst = LoopListHelper.New(self:getGo("handbook_mosterdata_view_-1862151702"))

	self._loopLst:InitListView(0, self._onSkillCellUpdate, self)

	self._btnEvaluate = self:getBtn("handbook_mosterdata_view_1610525225")
	self._txtTotalEvaluateNum = self:getText("handbook_mosterdata_view_1313297133")
	self._goStarGroup = {}

	local starRoot = self:getUIComponent("handbook_mosterdata_view_-433546985", UIComponentType.RectTransform)

	for i = 0, starRoot.childCount - 1 do
		local go = starRoot:GetChild(i)

		table.insert(self._goStarGroup, go:GetChild(0).gameObject)
	end

	self._hotTagsGroup = {}

	local hotTagRoot = self:getUIComponent("handbook_mosterdata_view_1653922696", UIComponentType.RectTransform)

	for i = 0, hotTagRoot.childCount - 1 do
		local index = i + 1
		local go = hotTagRoot:GetChild(i).gameObject
		local img = go.transform:GetComponent(UIComponentType.Image)
		local txtTagName = goutil.findChildTextComponent(go, "txt1")
		local txtTagCount = goutil.findChildTextComponent(go, "txt2")

		self._hotTagsGroup[index] = {
			go = go,
			img = img,
			txtTagName = txtTagName,
			txtTagCount = txtTagCount
		}
	end

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(nil)
	self._toggleTabControl:addToggleTab(self:getUIComponent("right_tab_content_-242000516", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("right_tab_content_-1578871314", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("right_tab_content_1651451756", UIComponentType.SpaceXToggle))

	self._btnCheck = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "btnCheck"))
end

function M:destroyUI()
	self._btnReturn = nil
	self._txtName = nil
	self._rawImg = nil
	self._photoUnit = nil
	self._goPanel = nil
	self._txtProfileDesc = nil
	self._btnEvaluate = nil
	self._txtTotalEvaluateNum = nil
	self._goStarGroup = nil
	self._hotTagsGroup = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	for _, shower in pairs(self._cellItem or {}) do
		shower:destroyUI()
	end

	self._loopLst:Dispose()

	self._loopLst = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnEvaluate:AddClickListener(self._onClickEvaluate, self)
	self._btnCheck:AddClickListener(self._onClickBtnCheck, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnEvaluate:RemoveClickListener()
	self._btnCheck:RemoveClickListener()

	for _, shower in pairs(self._cellItem or {}) do
		shower:unbindEvents()
	end
end

function M:onEnter()
	local info = self:getFirstParam()

	self._monsterId = info.id

	self:_setEvent(true)
	HandbookController.instance:tryGetMonsterComment(self._monsterId)

	self._cellItem = {}

	self:refreshBase()
	self:refreshProfile()
	self:refreshSkill()
	self:setActiveIndex(nil)

	local defaultSelectTabIndex = 1

	self._toggleTabControl:selectTab(defaultSelectTabIndex)
end

function M:onExit()
	self:_setEvent(false)

	for _, shower in pairs(self._cellItem or {}) do
		shower:onExit()
	end

	self._loopLst:ClearCells()

	if self._goPanel[self:getActiveIndex()] then
		goutil.setActive(self._goPanel[self:getActiveIndex()], false)
	end

	self:setActiveIndex(nil)

	if self._photoUnit then
		self._photoUnit:clear()
	end

	self._imgDynIconLiHui:ClearImage()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HANDBOOK_MONSTER_TAG_CHANGE, self._handleMonsterTagChange, self)
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseEvent, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HANDBOOK_MONSTER_TAG_CHANGE, self._handleMonsterTagChange, self)
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseEvent, self)
	end
end

function M:getMonsterId()
	return self._monsterId
end

function M:_onClickReturn()
	self:close()
end

function M:_onClickEvaluate()
	ToolTipsMgr.showHandbookMonsterdataEvaluateTips(self:getMonsterId())
end

function M:_onClickBtnCheck()
	ViewMgr.instance:open(ViewName.HandbookMonsterCompare, self:getMonsterId())
end

function M:_handleMonsterTagChange(e, monsterId)
	if monsterId and self:getMonsterId() == monsterId then
		self:refreshEvaluate()
	end
end

function M:refreshBase()
	local id = self:getMonsterId()
	local cfg = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryMonster, id)
	local cfgMonster = MonsterConfig.instance:getMonsterCO(id)
	local name = cfgMonster and cfgMonster.name or nil
	local modelId = cfgMonster and cfgMonster.modelId or nil

	self._txtName.text = name
	self._txtTyp.text = CommEnum.CampType2Name[cfgMonster.camp]

	goutil.setActive(self._rawImg.gameObject, false)
	goutil.setActive(self._imgLiHui.gameObject, false)

	if modelId then
		local modelCO = ModelConfig.instance:getModelConfig(modelId)

		if cfg.showLiHui > 0 then
			local lihui = modelCO and modelCO.wholeIconName or nil

			if not string.nilorempty(lihui) then
				local setting = IconType.getSetting(IconType.CharaterIcon)

				self._imgDynIconLiHui:SetImage(string.format(setting.url, lihui), function()
					self._imgLiHui:SetNativeSize()
				end, self)
				goutil.setActive(self._imgLiHui.gameObject, true)
			else
				printWarn(string.format("怪物[%s] modelId[%s],不显示立绘,wholeIconName为空", id, modelId))
			end
		else
			RawImageUtil.SetColor(self._rawImg, "#FFFFFF00")
			goutil.setActive(self._rawImg.gameObject, true)

			local clipCO = CutImageConfig.instance:getClipCO(modelId)
			local posInfo = clipCO:getModelClipInfoArr("fullPosInfo")

			self._photoUnit:setContainerPosInfos({
				posInfo
			})
			self._photoUnit:showModels({
				GameUrl.getHighMeshModelUrl(modelCO.resName)
			})
			self._rawImg:DOFade(1, 0.5)
		end
	else
		printWarn(string.format("怪物[%s] modelId[%s],不显示立绘", id, modelId))
		self._photoUnit:clear()
	end
end

function M:refreshProfile()
	local id = self:getMonsterId()
	local content
	local cfg = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryMonster, id)

	if cfg then
		content = cfg.profile
	end

	self._txtProfileDesc.text = content
end

function M:refreshSkill()
	self._skillData = {}

	local id = self:getMonsterId()
	local cfgMonster = MonsterConfig.instance:getMonsterCO(id)

	if cfgMonster then
		self:_addSkill(cfgMonster.normalSkill, self._skillData)
		self:_addSkill(cfgMonster.specialSkill, self._skillData)
		self:_addSkill(cfgMonster.trumpSkill, self._skillData)
		self:_addSkill(cfgMonster.giftSkill, self._skillData)
	end

	self._loopLst:SetListItemCount(#self._skillData, true)
	self._loopLst:RefreshAllShownItem()
end

function M:_addSkill(skillId, theTable)
	if skillId > 0 then
		local skillEnhanceCO = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

		if skillEnhanceCO then
			table.insert(theTable, skillEnhanceCO)
		end
	end
end

function M:refreshEvaluate()
	local id = self:getMonsterId()
	local mo = GalleryModel.instance:getMonsterComment(id)
	local globalStar = 0
	local globalCommentPlayerCount = 0
	local hotTags, myTags

	if mo then
		globalStar = mo:getStar()
		hotTags = mo:getHotTags()
		myTags = mo:getMyTags()
		globalCommentPlayerCount = mo:getCommentPlayerCount()
	else
		printWarn(string.format("无[%s]的评价数据", id))
	end

	local numStr = string.format(lang("tip_handbook_monster_evaluate_3"), globalCommentPlayerCount)

	self._txtTotalEvaluateNum.text = string.format("(%s)", numStr)

	for index, goStar in ipairs(self._goStarGroup) do
		local show = index <= globalStar

		goutil.setActive(goStar, show)
	end

	local lenHotTags = hotTags and #hotTags or 0
	local lenMyTags = myTags and #myTags or 0

	if lenHotTags > 0 then
		table.sort(hotTags, self.sortHotTag)
	end

	for index, hotTagG in ipairs(self._hotTagsGroup) do
		local show = index <= lenHotTags

		if show then
			local data = hotTags[index]
			local cfg = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryCommentTag, data.id)

			hotTagG.txtTagName.text = cfg and cfg.content or "???"
			hotTagG.txtTagCount.text = data.count
		end

		goutil.setActive(hotTagG.go, show)
	end
end

function M:getActiveIndex()
	return self._activeIndex or -1
end

function M:setActiveIndex(index)
	self._activeIndex = index
end

function M:setPage(tabIndex)
	local orgIndex = self:getActiveIndex()
	local needReresh = orgIndex ~= tabIndex

	self:setActiveIndex(tabIndex)

	if needReresh then
		if self._goPanel[orgIndex] then
			goutil.setActive(self._goPanel[orgIndex], false)
		end

		goutil.setActive(self._goPanel[self:getActiveIndex()], true)
	end
end

function M:_onSkillCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._skillData[curIndex]
	local item = self._loopLst:NewListViewItem("moster_skill_item")
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, HandbookMonsterSkillItemCell)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, HandbookMonsterSkillItemCell)

		shower:buildUI()
		shower:bindEvents()
	end

	shower:onEnter()
	shower:setData(data)

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

function M.sortHotTag(commentTagNO1, commentTagNO2)
	local ascending = false
	local cfgTagA = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryCommentTag, commentTagNO1.id)
	local cfgTagB = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryCommentTag, commentTagNO2.id)

	if not cfgTagA or not cfgTagB then
		return false
	end

	if cfgTagA.typ == cfgTagB.typ then
		if ascending then
			return cfgTagA.id < cfgTagB.id
		else
			return cfgTagB.id < cfgTagA.id
		end
	end

	if ascending then
		return cfgTagA.typ < cfgTagB.typ
	else
		return cfgTagB.typ < cfgTagA.typ
	end
end

function M:_onBeginDragModel(posX, posY, pointerId)
	self._lastPosX = posX
end

function M:_onDragModel(posX, posY, pointerId)
	local deltaX = posX - self._lastPosX

	self:_rotaModel(deltaX)

	self._lastPosX = posX
end

function M:_onEndDragModel(posX, posY, pointerId)
	return
end

function M:_rotaModel(deltaX)
	local _, rotaY, _ = self._photoUnit:getContainerRotation(1)
	local rotationY = rotaY + -deltaX

	self._photoUnit:setContainerRotationY(1, rotationY)
end

function M:_onModelsLoaded()
	self._photoUnit:showUIReflection()
	self._photoUnit:setCameraCullingMask(Astral.LayerUtil.GetLayerMask(SceneLayer.UI3D, SceneLayer.Unit))
	self._photoUnit:setCameraTag(SceneTag.RTCamera)
end

function M:_handleViewCloseEvent(e, viewName, opType)
	if viewName == ViewName.HandbookMonsterdataEvaluateTipsView or viewName == ViewName.HandbookMonsterCompare then
		self._photoUnit:updateUIRefPanelPosY()
	end
end

return M
