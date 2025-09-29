-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/editor/MainlineDungeonEditorView.lua

module("logic.extensions.dungeon.view.editor.MainlineDungeonEditorView", package.seeall)

local M = class("MainlineDungeonEditorView", ViewComponent)
local DungeonItemPath = "Assets/GameAssets/shared/ui/views/instance/level_item_copy.prefab"
local MainLinePartImg = {
	"fbzx_text_parta_01",
	"fbzx_text_partb_01"
}
local DungeonPaddingX = 420
local DungeonInitX = 170

function M:ctor()
	self._mapViewList = {}
	self._curChapterId = 1
	self._curDifficulty = DungeonEnum.Difficulty.Easy
	self._mapGo = {}
end

function M:buildUI()
	self.mainGO = self._viewPresentor:getResInstance(ResName.Instance_instance_view_copy)

	local root = ViewMgr.instance:getRoot(self._viewPresentor:attachToWhichRoot())

	goutil.addChildToParent(self.mainGO, root)

	local bg = goutil.findChild(self.mainGO, "worldMapScroll/drag")

	self._btnBG = UIComponentType.ButtonAdapter(bg)

	local registry = ViewElementsRegistry.New(self.mainGO)

	local function findElement(key, compType)
		return registry:findUIElement(key, compType)
	end

	self._difficultToggleGroup = findElement("branch_line_view_-993977823", UIComponentType.SpaceXToggleGroup)
	self._scrollRect = findElement("instance_view_copy_-2008417913", UIComponentType.ScrollRect)
	self._goMapRoot = findElement("instance_view_copy_-1140195853")
	self._easyToggle = findElement("instance_view_copy_-1469012216", UIComponentType.SpaceXToggle)
	self._normalToggle = findElement("instance_view_copy_-1357573776", UIComponentType.SpaceXToggle)
	self._goNormalLock = findElement("instance_view_82524848")
	self._goTitle = findElement("1&title_view_-478490097")
	self._goDetail = findElement("branch_line_view_1973018685")
	self._goCurency = findElement("0&top_currency_1050779625")
	self._goBounty = findElement("branch_line_view_512892577")
	self._imgName = findElement("instance_view_copy_-859100203", UIComponentType.Image)
	self._imgPart = findElement("instance_view_copy_1993255615", UIComponentType.Image)
	self._textName = findElement("instance_view_copy_2024921884", UIComponentType.Text)
	self._imgTitle = findElement("instance_view_copy_-859100203", ComponentType.ImageLocalization)
	self._imgPart = findElement("instance_view_copy_1993255615", UIComponentType.Image)
	self._txtNum = findElement("instance_view_copy_2024921884", UIComponentType.Text)

	goutil.setActive(self._goTitle, false)
	goutil.setActive(self._goDetail, false)
	goutil.setActive(self._goCurency, false)
	goutil.setActive(self._goBounty, false)
	goutil.setActive(self._goNormalLock, false)

	self._editorView = self._viewPresentor:getEditorView()

	self:_init()
end

function M:bindEvents()
	self._easyToggle:AddListener(self._onEasyToggle, self)
	self._normalToggle:AddListener(self._onNormalToggle, self)
	self._btnBG:AddClickListener(self._onClickBg, self)
end

function M:unbindEvents()
	self._easyToggle:RemoveListener()
	self._normalToggle:RemoveListener()
	self._btnBG:RemoveClickListener()
end

function M:onEnter()
	goutil.setActive(self.mainGO, true)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dungeon)
	self:_showChapter(self._curChapterId)
end

function M:onExit()
	goutil.setActive(self.mainGO, false)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Dungeon)
end

function M:destroyUI()
	goutil.destroy(self.mainGO)
end

function M:_init()
	self._hasInit = true
	self._screenWidth = ViewMgr.instance:getUIWidth()
	self._screenHeight = ViewMgr.instance:getUIHeight()
end

function M:_clearMap()
	if self._mapViewList then
		for _, mapView in pairs(self._mapViewList) do
			mapView:clear()
		end

		table.clear(self._mapViewList)
	end
end

function M:_onMapLoaded()
	self._mapLoaded = true

	self:_showDifficulty()
end

function M:_onSwitchDifficulty()
	local mapPath = self:_getCurMainlineUrl()

	if self:_existAsset(mapPath) or self._mapViewList[self._curDifficulty] then
		if self._mapGo[mapPath] or self._mapViewList[self._curDifficulty] then
			self:_showDifficulty()
		else
			self:_loadMainline()
		end
	else
		local dialog = Dialog.showMessage("提示", string.format("不存在主线[%s][%s]，是否创建主线？", self._chapterCO.chapterId, self._chapterCO.name))

		dialog:setConfirmListener(self._createMainline, self)
	end
end

function M:_hideAllMap()
	for _, mapView in pairs(self._mapViewList) do
		mapView:setVisible(false)
	end
end

function M:_showDifficulty()
	self:_hideAllMap()

	if self._mapViewList[self._curDifficulty] then
		self._mapView = self._mapViewList[self._curDifficulty]

		self._mapView:setVisible(true)
	else
		local goMap = self._mapGo[self:_getCurMainlineUrl()]

		goutil.addChildToParent(goMap, self._goMapRoot)
		TransformUtils.SetLocalScale(goMap.transform, 1, 1, 1)
		RectTransformUtils.SetAnchoredPosition(goMap.transform, 0, 0)

		self._mapView = Astral.SimpleLuaComponentContainer.Add(goMap, MainlineDungeonMapEditor)
		self._mapViewList[self._curDifficulty] = self._mapView
	end

	local chapterMO = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(self._curChapterId, self._curDifficulty)

	self._mapView:setData(chapterMO)
	self:_refreshTitle()
	self:_updateContentWidth()
end

function M:_refreshTitle()
	local chapterMO = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(self._curChapterId, self._curDifficulty)
	local chapterCO = chapterMO:getChapterCO()

	self._txtNum.text = chapterCO.chapterHint

	self._imgTitle:SetSprite(chapterCO.titleInChapter)

	local partImgName = MainLinePartImg[chapterCO.chapterId]

	goutil.setActive(self._imgPart.gameObject, partImgName)

	if partImgName then
		IconLoader.setSprite(self._imgPart, IconType.DynSpriteAtlas_Dungeon, partImgName)
	end
end

function M:_getCurMainlineUrl()
	if self._curDifficulty == DungeonEnum.Difficulty.Easy then
		return GameUrl.getNormalChapterUrl(self._curChapterId)
	else
		return GameUrl.getHardChapterUrl(self._curChapterId)
	end
end

function M:_updateContentWidth()
	local maxPosX = self._mapView:getMaxPosX()

	self._maxWidth = maxPosX + self._screenWidth / 2 + 100

	goutil.setWidth(self._goMapRoot.transform, self._maxWidth)

	self._scrollRect.horizontalNormalizedPosition = 0
end

function M:_onEasyToggle(_, isOn)
	if isOn then
		self._curDifficulty = DungeonEnum.Difficulty.Easy

		local chapterMO = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(self._curChapterId, self._curDifficulty)

		self._chapterCO = chapterMO:getChapterCO()

		self:_onSwitchDifficulty()
	end
end

function M:_onNormalToggle(_, isOn)
	if isOn then
		self._curDifficulty = DungeonEnum.Difficulty.Normal

		local chapterMO = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(self._curChapterId, self._curDifficulty)

		self._chapterCO = chapterMO:getChapterCO()

		self:_onSwitchDifficulty()
	end
end

function M:_onClickBg()
	GlobalDispatcher:dispatchEvent(EventType.MAINLINE_DUNGEON_SELECT_EDITOR, nil)
end

function M:_getAssetPath()
	return string.format("Assets/GameAssets/shared/%s", self:_getCurMainlineUrl())
end

function M:_existAsset(assetName)
	local path = string.format("%s/GameAssets/shared/%s", UnityEngine.Application.dataPath, assetName)

	return SpaceXFileUtil.IsFileExists(path)
end

function M:changeChapter(chapterId)
	if self._curChapterId == chapterId then
		return
	end

	if not self._hasInit then
		return
	end

	self:_showChapter(chapterId)
end

function M:_showChapter(chapterId)
	self._curChapterId = chapterId
	self._curDifficulty = DungeonEnum.Difficulty.Easy

	local chapterMO = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(self._curChapterId, self._curDifficulty)

	self._chapterCO = chapterMO:getChapterCO()

	self:_clearMap()

	local existAsset = self:_existAsset(GameUrl.getNormalChapterUrl(self._curChapterId))

	if not existAsset then
		self._dialog = Dialog.showMessage("提示", string.format("不存在主线[%s][%s]，是否创建主线？", self._chapterCO.chapterId, self._chapterCO.name))

		self._dialog:setConfirmListener(self._createMainline, self)
	else
		self:_loadMainline()
	end

	self._difficultToggleGroup:TryActiveChildOn(self._easyToggle, true)
end

function M:_createMainline()
	self._mapLoaded = true
	self._scrollRect.horizontalNormalizedPosition = 0

	self:_hideAllMap()

	local mainlineGO = goutil.create(self:_getMainlineName(), true)
	local mainlineTransform = mainlineGO.transform

	goutil.addChildToParent(mainlineGO, self._goMapRoot)
	RectTransformUtils.SetAnchorMin(mainlineTransform, 0, 0)
	RectTransformUtils.SetAnchorMax(mainlineTransform, 0, 0)
	TransformUtils.SetLocalPosition(mainlineTransform, 0, 0, 0)
	RectTransformUtils.SetPivot(mainlineTransform, 0, 0)

	self._mapView = Astral.SimpleLuaComponentContainer.Add(mainlineGO, MainlineDungeonMapEditor)
	self._mapViewList[self._curDifficulty] = self._mapView

	local chapterMO = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(self._curChapterId, self._curDifficulty)
	local normalDungeonIds = chapterMO:getNormalDungeonIds()
	local branchlineIds = chapterMO:getBranchlineDungeonIds()
	local count = 0

	for i = 1, #normalDungeonIds do
		count = count + 1

		local name = string.format("level_item_%s", i)

		self:_createDungeon(name, i, count)
	end

	for i, list in ipairs(branchlineIds) do
		for j, id in ipairs(list) do
			count = count + 1

			local name = string.format("level_item_branch_%s_%s", i, j)
			local index = i * 100 + j

			self:_createDungeon(name, index, count)
		end
	end

	self._mapView:setData(chapterMO)
	self._mapView:adjustLine(self._editorView:getLineLeftOffset(), self._editorView:getLineRightOffset())
	self:_updateContentWidth()
	PrefabUtilityHelper.SaveAsPrefabAsset(mainlineGO, self:_getAssetPath(), true)
	self._dialog:close()
end

function M:_createDungeon(name, index, count)
	local goDungeon = PrefabUtilityHelper.LoadGameObjectWithReference(DungeonItemPath)

	goDungeon.name = name

	local posX = Astral.TransformUtil.GetAnchoredPos(self._goMapRoot.transform, 0, 0)

	posX = -posX + DungeonInitX + (count - 1) * DungeonPaddingX

	self._mapView:createDungeon(goDungeon, index, posX, self._screenHeight / 2)
end

function M:_getMainlineName()
	if self._curDifficulty == DungeonEnum.Difficulty.Easy then
		return string.format("instance_normal_chapter_%s", self._curChapterId)
	else
		return string.format("instance_hard_chapter_%s", self._curChapterId)
	end
end

function M:_loadMainline()
	self._mapLoaded = false

	local goMap = PrefabUtilityHelper.LoadGameObjectWithReference(self:_getAssetPath())

	self._mapGo[self:_getCurMainlineUrl()] = goMap

	self:_onMapLoaded()
end

function M:createDungeon(dungeonType)
	if not self._mapLoaded then
		return
	end

	local res = self._resLoader:getResource(DungeonItemPath)
	local goDungeon = goutil.clone(res:GetMainAsset())
	local posX = Astral.TransformUtil.GetAnchoredPos(self._goMapRoot.transform, 0, 0)

	self._mapView:createDungeon(dungeonType, goDungeon, -posX + self._screenWidth / 2, self._screenHeight / 2)
end

function M:adjustLine(leftOffset, rightOffset)
	if not self._mapLoaded then
		return
	end

	self._mapView:adjustLine(leftOffset, rightOffset)
end

function M:deleteDungeon(dungeonCell)
	if not self._mapLoaded then
		return
	end

	self._mapView:deleteDungeon(dungeonCell)
end

function M:save()
	if not self._mapLoaded then
		return
	end

	self._mapView:save(self:_getAssetPath(), self._onSave, self)
end

function M:_onSave(isSuccess, go)
	if isSuccess then
		local mapPath = self:_getCurMainlineUrl()

		self._mapGo[mapPath] = nil
		self._mapViewList[self._curDifficulty] = nil

		self:_onSwitchDifficulty()
	end
end

function M:createMainline()
	self:_createMainline()
end

function M:deleteMainline()
	if not self._mapLoaded then
		return
	end

	local chapterMO = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(self._curChapterId, self._curDifficulty)
	local dialog = Dialog.showMessage("提示", string.format("是否删除主线 [%s] 名字[%s]的配置？ \n %s", chapterMO:getChapterId(), chapterMO:getName(), self:_getAssetPath()))

	dialog:setConfirmListener(self._deleteMainline, self)
end

function M:_deleteMainline()
	local path = self:_getAssetPath()

	PrefabUtilityHelper.DeleteAsset(path)

	self._mapView = nil
end

return M
