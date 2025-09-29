-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueEntranceView.lua

module("logic.extensions.roguelike.view.explore.RogueEntranceView", package.seeall)

local ScriptBannerItem = class("ScriptBannerItem")

function ScriptBannerItem:ctor(go)
	self._go = go
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click"))
	self._txtName = goutil.findChildTextComponent(go, "normal/txtName")
	self._txtName2 = goutil.findChildTextComponent(go, "select/txtName")
	self._imgIcon = goutil.findChildComponent(go, "mask/imgIcon", UIComponentType.Image)
	self._goLock = goutil.findChild(go, "lock")
	self._goSelect = goutil.findChild(go, "select")
	self._goNormal = goutil.findChild(go, "normal")
end

function ScriptBannerItem:updateData(data)
	self._txtName.text = data.name
	self._txtName2.text = data.name
	self._callback = data.callback

	IconLoader.setSprite(self._imgIcon, IconType.RunGroup, string.format("rungroup_drama/%s", data.path))
	self:setIsLock(data.isLock)
	goutil.setActive(self._go, data.isActive)
end

function ScriptBannerItem:bindEvents()
	self._btnClick:AddClickListener(self.onClick, self)
end

function ScriptBannerItem:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function ScriptBannerItem:onClick()
	if self._callback then
		self._callback()
	end
end

function ScriptBannerItem:setSelect(isSelect)
	goutil.setActive(self._goSelect, isSelect)
	goutil.setActive(self._goNormal, not isSelect)

	local scale = isSelect and 1.15 or 1

	Astral.TransformUtil.SetLocalScale(self._go.transform, scale, scale, scale)
end

function ScriptBannerItem:setIsLock(isLock)
	goutil.setActive(self._goLock, isLock)
end

function ScriptBannerItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

local DebuffItem = class("DebuffItem")

function DebuffItem:ctor(container)
	local go = container.gameObject

	self._go = go
	self._txtDesc = goutil.findChildTextComponent(go, "txtNegativeBuff")
end

function DebuffItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function DebuffItem:updateData(data)
	self._txtDesc.text = data.desc

	self:setActive(true)
end

local M = class("RogueEntranceView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._scriptBanners = {}
	self._debuffItems = {}
	self._const = RoguelikeConst
end

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._btnClose = self:getBtn("title_view_-878360263")
	self._btnReport = self:getBtn("run_group_entrance_view_2043892388")
	self._btnExplore = self:getBtn("run_group_entrance_view_-977027661")
	self._animBtnExplore = self:getUIComponent("run_group_entrance_view_-977027661", ComponentType.Animation)
	self._btnDiffPre = self:getBtn("run_group_entrance_view_2042680036")
	self._btnDiffNext = self:getBtn("run_group_entrance_view_-1931161863")
	self._txtDiff = self:getText("run_group_entrance_view_332140891")
	self._traScriptsParent = self:getGo("run_group_entrance_view_-1121475802").transform
	self._goScriptItem = self:getGo("run_group_entrance_view_-1193480702")
	self._txtDesc = self:getText("run_group_entrance_view_-1921050130")
	self._txtName = self:getText("run_group_entrance_view_460711390")
	self._txtFloorCount = self:getText("run_group_entrance_view_-2055002773")
	self._txtPassCount = self:getText("run_group_entrance_view_-83306706")
	self._txtSchedule = self:getText("run_group_entrance_view_749130869")
	self._txtInfo = self:getText("run_group_entrance_view_181799144")
	self._goAttrParent = self:getGo("run_group_entrance_view_-1198176682")
	self._traBuffParent = self:getGo("run_group_entrance_view_554262364").transform
	self._goBuffItem = self:getGo("run_group_entrance_view_561038118")
	self._toggleDesc = self:getGo("run_group_entrance_view_copy_462877864"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleDeBuff = self:getGo("run_group_entrance_view_copy_1771070825"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleGroup = self:getUIComponent("run_group_entrance_view_929855631", UIComponentType.SpaceXToggleGroup)
	self._goDescScroll = self:getGo("run_group_entrance_view_copy_-685213808")
	self._goDeBuffScroll = self:getGo("run_group_entrance_view_copy_1974081125")
	self._scrollRect = self._goDeBuffScroll:GetComponent(UIComponentType.ScrollRect)
	self._goDeBuffItem = self:getGo("run_group_entrance_view_561038118")
	self._goDiff = self:getGo("run_group_entrance_view_copy_-1542427019")
	self._goDiffHint = self:getGo("run_group_entrance_view_copy_-414097517")
	self._goAttrs = {}

	for i = 1, 6 do
		local attr = goutil.findChild(self._goAttrParent, string.format("attribute%d", i))

		table.insert(self._goAttrs, attr)
	end

	self._goReadStory = self:getGo("run_group_entrance_view_1818183686")
	self._toggleReadStory = self:getUIComponent("run_group_entrance_view_1610519189", UIComponentType.SpaceXToggle)
	self._guiAnimation = self.mainGO:GetComponent(typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnReport:AddClickListener(self._onClickReport, self)
	self._btnExplore:AddClickListener(self._onClickExplore, self)
	self._btnDiffPre:AddClickListener(self._onClickDiffPre, self)
	self._btnDiffNext:AddClickListener(self._onClickDiffNext, self)
	self._toggleDesc:AddListener(self._onToggleDesc, self)
	self._toggleDeBuff:AddListener(self._onToggleDeBuff, self)
	self._toggleReadStory:AddListener(self._onToggleReadStory, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnReport:RemoveClickListener()
	self._btnExplore:RemoveClickListener()
	self._btnDiffPre:RemoveClickListener()
	self._btnDiffNext:RemoveClickListener()
	self._toggleDesc:RemoveListener()
	self._toggleDeBuff:RemoveListener()
	self._toggleReadStory:RemoveListener()
end

function M:onEnter()
	self._canvasGroup.interactable = true

	goutil.setActive(self.mainGO, false)
	goutil.setActive(self._goReadStory, RoguelikeConst.GetPlayedStory())

	if RoguelikeConst.GetPlayedStory() then
		self._toggleReadStory.IsOn = RogueLocalStorageUtil.instance:getReadStory()
	end

	self:setEvent(true)

	for k, v in pairs(self._scriptBanners) do
		v:bindEvents()
	end

	RogueMgr.instance:setIsClientMode(false)
	RoguelikeAgent.instance:sendLoadScriptRequest()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_EXPLORE_INFO, self._onExploreInfoRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_ROOM_INFO_REFRESH, self._onRoomInfoRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SCRIPT_INFO_REFRESH, self._onScriptsRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EXPLORE_INFO, self._onExploreInfoRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_ROOM_INFO_REFRESH, self._onRoomInfoRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SCRIPT_INFO_REFRESH, self._onScriptsRefresh, self)
	end
end

function M:_checkSkipGuide()
	if RoguelikeConst.IsGuildMode() then
		local content = lang("tip_roguelike_skip_guide")
		local dialog = Dialog.showMessage(lang("tip_title"), content, -1)

		dialog:setConfirmListener(function()
			return
		end, self)
		dialog:setCancelListener(function()
			GuideController.instance:passCurGuide()
			GuideController.instance:finishRoguelikeGuides()
		end, self)
		dialog:setCloseListener(function()
			GuideController.instance:passCurGuide()
			GuideController.instance:finishRoguelikeGuides()
		end, self)
	end
end

function M:_onExploreInfoRefresh()
	local curScriptId = RoguelikeModel.instance:getCurScriptId()

	if curScriptId ~= nil and curScriptId ~= 0 and RogueExploreModel.instance:getIsGaming() then
		print("当前在剧本中", curScriptId)
	else
		goutil.setActive(self.mainGO, true)

		if self._guiAnimation then
			self._guiAnimation:StopTimelineAni()
			self._guiAnimation:PlayAniByName("open")
		end
	end

	local allRoleState = RoguelikeModel.instance:getAllRoleState()

	if allRoleState == nil then
		-- block empty
	end

	self._allRoleState = allRoleState
end

function M:checkOpenScene()
	if self._allRoleState and RoguelikeModel.instance:getCurMapId() ~= nil and RogueExploreModel.instance:getIsGaming() then
		self:initRogue()

		local sceneId = RoguelikeController.instance:getSceneId(RoguelikeModel.instance:getCurMapId())

		RoguelikeController.instance:enterRunGroupScene(sceneId)
		self:setLocalDiffLevel(self._selectScriptId, self._curDiffLevel)

		for k, v in ipairs(self._allRoleState) do
			local heroData = HeroDepotModel.instance:getHeroInfoByID(v.code)

			if heroData then
				HeroPowerAgent.instance:sendHeroPowerInfoRequest(v.code)
			end
		end

		self:close()
		removetimer(self.checkOpenScene, self)
	end
end

function M:_onRoomInfoRefresh()
	local allRoleState = RoguelikeModel.instance:getAllRoleState()

	if allRoleState then
		self._allRoleState = allRoleState

		if RoguelikeModel.instance:getCurMapId() == nil then
			printError("没有地图id")

			return
		end

		settimer(0.1, self.checkOpenScene, self, true)
	end
end

function M:_onScriptsRefresh(sender, infos)
	local scriptId = RoguelikeConfig.instance:getConstByName("GuideScriptId").numValue
	local isFinish = RoguelikeConst.IsGuideFinish()
	local isFirstBanner = false

	for i, v in ipairs(infos) do
		local item = self._scriptBanners[i]

		if item == nil then
			local go = Astral.GameObjectUtil.CloneAndSetParent(self._goScriptItem, self._traScriptsParent, nil)

			item = ScriptBannerItem.New(go)
			self._scriptBanners[i] = item

			item:bindEvents()
		end

		local data = {}
		local temp = RoguelikeConfig.instance:getScriptById(v.scriptId)

		if temp == nil then
			printError("剧本配置为空", v.scriptId)

			return
		end

		data.name = temp.name
		data.path = temp.thumbnail

		function data.callback()
			self._useLongGuide = false

			self:updateScriptInfo(temp, v)

			for k1, v1 in pairs(self._scriptBanners) do
				v1:setSelect(i == k1)
			end

			RectTransformUtils.ForceRebuildLayoutImmediate(self._traScriptsParent)
		end

		local hadScriptLayer = RoguelikeConfig.instance:checkHadLayer(temp.id)

		if not hadScriptLayer then
			data.isLock = true
		end

		data.isActive = true

		if not isFinish then
			data.isActive = v.scriptId == scriptId
		else
			data.isActive = v.scriptId ~= scriptId
		end

		item:updateData(data)

		if data.isActive and not isFirstBanner then
			isFirstBanner = true

			self:updateScriptInfo(temp, v)

			for k1, v1 in pairs(self._scriptBanners) do
				v1:setSelect(i == k1)
			end
		end
	end

	RoguelikeAgent.instance:sendLoadInfoRequest()
end

function M:initRogue()
	if RogueMgr.instance:isInRogue() then
		return
	end

	local tb = {}

	tb.roleIds = {}
	self._allRoleState = self._allRoleState or RoguelikeModel.instance:getAllRoleState()

	for k, v in pairs(self._allRoleState) do
		table.insert(tb.roleIds, v.code)
	end

	RogueMgr.instance:enter(tb)
end

function M:updateBanner()
	local allScript = RoguelikeConfig.instance:getAllScript()

	for i = 1, #allScript do
		local item = self._scriptBanners[i]

		if item == nil then
			local go = Astral.GameObjectUtil.CloneAndSetParent(self._goScriptItem, self._traScriptsParent, nil)

			item = ScriptBannerItem.New(go)
			self._scriptBanners[i] = item
		end

		local data = {}
		local temp = allScript[i][#allScript[i]]

		data.name = temp.name

		function data.callback()
			self:updateScriptInfo(temp)

			for k1, v1 in pairs(self._scriptBanners) do
				v1:setSelect(i == k1)
			end
		end

		local hadScriptLayer = RoguelikeConfig.instance:checkHadLayer(temp.id)

		if not hadScriptLayer then
			data.isLock = true
		end

		item:updateData(data)

		if i == 1 then
			self:updateScriptInfo(temp)

			for k1, v1 in pairs(self._scriptBanners) do
				v1:setSelect(i == k1)
			end
		end
	end
end

function M:updateScriptInfo(co, scriptInfo)
	self._curScriptCo = co
	self._txtName.text = co.name
	self._txtDesc.text = co.desc
	self._selectScriptId = co.id

	local curFloor = scriptInfo and scriptInfo.maxLayer or 0
	local maxLayer = RoguelikeConfig.instance:getLayerCount(co.id) or 1

	maxLayer = maxLayer == 0 and 1 or maxLayer
	self._txtFloorCount.text = string.format(lang("tip_r_script_max_level"), maxLayer)

	local passCount = scriptInfo and scriptInfo.passCount or 0

	self._txtPassCount.text = string.format(lang("tip_r_script_pass_time"), passCount)

	local schedule = scriptInfo.progress

	self._txtSchedule.text = ""

	local props = {}
	local tempStr = ""

	for k, v in pairs(self._goAttrs) do
		goutil.setActive(v, false)
	end

	for idx, prop in pairs(props) do
		local map = RoguelikeConst.PROP_LANG_MAP[prop]

		goutil.setActive(self._goAttrs[prop], true)
	end

	if #props > 0 then
		self._txtInfo.text = string.format(lang("tip_r_script_prop_usefull"), tempStr)
	else
		self._txtInfo.text = lang("tip_r_script_not_usefull_prop")
	end

	self._curSelectScriptId = co.id
	self._maxDiffLevel = RoguelikeConfig.instance:getDiffLevelIndexByLevel(scriptInfo.unlockedDifficulty)
	self._curDiffLevel = 0

	local localDiffLevel = self:getLocalDiffLevel(co.id)

	goutil.setActive(self._goDiffHint, localDiffLevel < self._maxDiffLevel)
	goutil.setActive(self._toggleDeBuff.gameObject, self._maxDiffLevel > 0)
	self:updateDebuffDesc(co.id, self._curDiffLevel)

	self._toggleDesc.IsOn = true
end

local kLocalDiffLevel = "LocalDiffLevel"

function M:getLocalDiffLevel(scriptId)
	local key = kLocalDiffLevel .. scriptId .. PlayerModel.instance:getId()

	return Astral.LocalStorage.Instance:GetInt(key, 0)
end

function M:setLocalDiffLevel(scriptId, level)
	local key = kLocalDiffLevel .. scriptId .. PlayerModel.instance:getId()

	Astral.LocalStorage.Instance:SetInt(key, level)
end

function M:onExit()
	self:setEvent(false)
	removetimer(self.checkOpenScene, self)

	self._useLongGuide = false

	for k, v in pairs(self._scriptBanners) do
		v:unbindEvents()
	end
end

function M:updateDebuffDesc(scriptId, level)
	for k, v in pairs(self._debuffItems) do
		v:setActive(false)
	end

	goutil.setActive(self._btnDiffPre.gameObject, level > 0)
	goutil.setActive(self._btnDiffNext.gameObject, level < self._maxDiffLevel)
	goutil.setActive(self._toggleDeBuff.gameObject, level > 0)

	if level == 0 and self._toggleDeBuff.IsOn then
		self._toggleGroup:TryActiveChildOn(self._toggleDesc, true)
	end

	if level >= 1 and self._toggleDesc.IsOn then
		self._toggleGroup:TryActiveChildOn(self._toggleDeBuff, true)
	end

	if level > self._maxDiffLevel or self._maxDiffLevel == 0 then
		goutil.setActive(self._goDiff, false)

		return
	end

	local diffLevelCo = RoguelikeConfig.instance:getDiffLevelByLevelIndex(level, scriptId)

	if diffLevelCo then
		local effectIds = RoguelikeConfig.instance:getCurDiffLevelEffectsByIndex(level, scriptId)

		for k, v in pairs(effectIds) do
			local effectCo = RoguelikeConfig.instance:getEffectById(v)
			local item = self._debuffItems[k]

			if item == nil then
				local go = goutil.cloneAndSetParent(self._goBuffItem, self._traBuffParent)

				item = Astral.LuaComponentContainer.Add(go, DebuffItem)
				self._debuffItems[k] = item
			end

			local data = {}

			data.desc = StringUtil.replaceAllGraphicText2(effectCo.description)

			item:updateData(data)
		end

		self._txtDiff.text = diffLevelCo.name

		goutil.setActive(self._goDiff, true)
		RectTransformUtils.ForceRebuildLayoutImmediate(self._traBuffParent)

		self._scrollRect.verticalNormalizedPosition = 0
	elseif self._maxDiffLevel > 0 then
		self._txtDiff.text = lang("tip_r_script_first_diff")

		goutil.setActive(self._goDiff, true)
	else
		goutil.setActive(self._goDiff, false)
		goutil.setActive(self._toggleDeBuff.gameObject, false)
	end
end

function M:_onClickClose()
	self:back()
end

function M:_onClickReport()
	FloatWordMgr.instance:show(lang("tip_r_script_report"))
end

function M:_onClickExplore()
	self._animBtnExplore:Stop()
	self._animBtnExplore:Play("run_group_entrance_view_btnexplore")

	local hadScriptLayer = RoguelikeConfig.instance:checkHadLayer(self._selectScriptId)

	if not hadScriptLayer then
		printError(string.format("剧本%d暂没有对应的层配置", self._selectScriptId))

		return
	end

	self._canvasGroup.interactable = false

	settimer(0.29, function()
		self._canvasGroup.interactable = true

		local enterPlot = self._curScriptCo and self._curScriptCo.enterPlot or 0

		RoguelikeConst.SetReadPlayedStory(self._toggleReadStory.IsOn)

		if RoguelikeConst.GetPlayedStory() then
			RogueLocalStorageUtil.instance:setReadStory(self._toggleReadStory.IsOn)
		end

		if enterPlot ~= 0 and RoguelikeConst.GetPlayedStory() and not RoguelikeConst.IsGuildMode() and self._toggleReadStory.IsOn then
			StoryMgr.instance:startSingle(enterPlot, false, self.dealExplore, self)
			RoguelikeConst.SetStoryPlayed(enterPlot)
		else
			self:dealExplore()
		end
	end, self, false)
end

function M:dealExplore()
	if not RogueExploreModel.instance:getIsGaming() then
		RoguelikeController.instance:setIsSelectRoleScene(true)
		ViewMgr.instance:open(ViewName.RogueEntranceSelectRole, function()
			return
		end, self._curScriptCo, self._curDiffLevel)
		RogueTempModel.instance:setCurScriptInfo(self._selectScriptId, self._curDiffLevel)

		local mapId = RoguelikeConfig.instance:getFirstSceneMapId(self._curScriptCo.id, 1)
		local mapCo = RoguelikeConfig.instance:getMapById(mapId)
		local sceneId = mapCo.sceneCode

		RoguelikeController.instance:enterRunGroupScene(sceneId)
		RoguelikeUtil.instance:saveExploreScripts()
		self:close()
	else
		self:initRogue()
	end
end

function M:_onClickDiffPre()
	if self._curDiffLevel >= 1 and self._maxDiffLevel > 0 then
		self._curDiffLevel = self._curDiffLevel - 1

		self:updateDebuffDesc(self._curSelectScriptId, self._curDiffLevel)
	end
end

function M:_onClickDiffNext()
	local len = self._maxDiffLevel or 0

	if len > self._curDiffLevel then
		self._curDiffLevel = self._curDiffLevel + 1

		self:updateDebuffDesc(self._curSelectScriptId, self._curDiffLevel)
	end
end

local kToggleType = {
	DeBuff = 2,
	Desc = 1
}

function M:_onToggleDesc(toggle, isOn)
	if not isOn then
		return
	end

	self:switchToggleShow(kToggleType.Desc)
end

function M:_onToggleDeBuff(toggle, isOn)
	if not isOn then
		return
	end

	self:switchToggleShow(kToggleType.DeBuff)
end

function M:_onToggleReadStory(toggle, isOn)
	return
end

function M:switchToggleShow(type)
	goutil.setActive(self._goDescScroll, type == kToggleType.Desc)
	goutil.setActive(self._goDeBuffScroll, type == kToggleType.DeBuff)
end

return M
