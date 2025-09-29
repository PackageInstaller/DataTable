-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/CharacterPastInfoView.lua

module("logic.extensions.characterinformation.view.CharacterPastInfoView", package.seeall)

local M = class("CharacterPastInfoView", DynamicFragmentView)

function M:buildUI()
	self._scrollBarAdapter = self._registry:findUIElement("role_file_tips_-12817213", UIComponentType.ScrollRectAdapter)
	self._scrollRect = self._registry:findUIElement("role_file_tips_-12817213", UIComponentType.ScrollRect)
	self._roleNameTxt = self._registry:findUIElement("role_file_tips_-1433663698", UIComponentType.Text)
	self._sexTxt = self._registry:findUIElement("role_file_tips_-2138386764", UIComponentType.Text)
	self._areaTxt = self._registry:findUIElement("role_file_tips_-204142067", UIComponentType.Text)
	self._ageTxt = self._registry:findUIElement("role_file_tips_-1936110938", UIComponentType.Text)
	self._bloodTypeTxt = self._registry:findUIElement("role_file_tips_-1511183293", UIComponentType.Text)
	self._birthTxt = self._registry:findUIElement("role_file_tips_-2103534619", UIComponentType.Text)
	self._weightTxt = self._registry:findUIElement("role_file_tips_-771980729", UIComponentType.Text)
	self._heightTxt = self._registry:findUIElement("role_file_tips_-190581710", UIComponentType.Text)
	self._measurementTxt = self._registry:findUIElement("role_file_tips_-697519570", UIComponentType.Text)
	self._belongItemTxt = self._registry:findUIElement("role_file_tips_-1600202846", UIComponentType.Text)
	self._favourItemTxt = self._registry:findUIElement("role_file_tips_92606155", UIComponentType.Text)
	self._hateItemTxt = self._registry:findUIElement("role_file_tips_-1549595721", UIComponentType.Text)
	self._anchorTxt = self._registry:findUIElement("role_file_tips_-2013963618", UIComponentType.Text)
	self._positionTxt = self._registry:findUIElement("role_file_tips_-1960165483", UIComponentType.Text)
	self._heightLockTxt = self._registry:findUIElement("role_file_tips_-1126256841", UIComponentType.Text)
	self._weightLockTxt = self._registry:findUIElement("role_file_tips_-1422966868", UIComponentType.Text)
	self._measurementLockTxt = self._registry:findUIElement("role_file_tips_-602040512", UIComponentType.Text)
	self._belongItemLockTxt = self._registry:findUIElement("role_file_tips_-1564294167", UIComponentType.Text)
	self._favourItemLockTxt = self._registry:findUIElement("role_file_tips_-1501861107", UIComponentType.Text)
	self._hateItemLockTxt = self._registry:findUIElement("role_file_tips_761525179", UIComponentType.Text)
	self._anchorLockTxt = self._registry:findUIElement("role_file_tips_277945012", UIComponentType.Text)
	self._postionLockTxt = self._registry:findUIElement("role_file_tips_360446029", UIComponentType.Text)
	self._file1PanelGo = self._registry:findUIElement("role_file_tips_-281296668")
	self._filePanelGoList = {}

	for i = 1, 7 do
		local go = Astral.GameObjectUtil.CloneAndSetParent(self._file1PanelGo, self._file1PanelGo.transform.parent, nil)

		table.insert(self._filePanelGoList, go)
	end

	goutil.setActive(self._file1PanelGo, false)

	self._campIcon = self._registry:findUIElement("role_file_tips_-737166707", UIComponentType.Image)

	local mainGO = self._registry:getMainGO()

	self._guiAnimation = goutil.addComponentOnce(mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:bindEvents()
	self._guiAnimation:AddListener(self._handleViewAniDoneEvent, self)

	for i, v in ipairs(self._filePanelGoList) do
		local btn = Astral.ButtonAdapter.Get(goutil.findChild(v, "role_file_item/btnUnlock"))

		btn:AddClickListener(function()
			self:_onClickUnlockFile(i)
		end, nil)
	end
end

function M:unbindEvents()
	self._guiAnimation:RemoveListener()

	for i, v in ipairs(self._filePanelGoList) do
		local btn = Astral.ButtonAdapter.Get(goutil.findChild(v, "role_file_item/btnUnlock"))

		btn:RemoveClickListener()
	end
end

function M:onEnter()
	self._curFileInfos = {}
	self._fileIndexContents = {}

	self:setEvent(true)
	self._scrollBarAdapter:AddOnValueChanged(self._onValueChange, self)
	self:_refreshByHeroChange()
	self:playGuiAni("open")
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CHARACTER_VIEW_SWITCH, self._refreshByHeroChange, self)
		GlobalDispatcher:addEventListener(EventType.HERO_INFO_UNLOCK, self._refreshView, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HERO_INFO_UNLOCK, self._refreshView, self)
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_VIEW_SWITCH, self._refreshByHeroChange, self)
	end
end

function M:playGuiAni(name)
	self._guiAnimation:StopTimelineAni()

	if self.mainGO.activeSelf and not string.nilorempty(name) then
		self._guiAnimation:PlayAniByName(name)
	end
end

function M:_handleViewAniDoneEvent(tagName, reason)
	if tagName == "open" then
		self:playGuiAni("xunhuan")
	end
end

function M:getHeroLv()
	return self._heroData:getLevel()
end

function M:getHeroPowerLv()
	return self._heroData:getPowerLv()
end

function M:getHeroTacit()
	return self._heroData:getTacit()
end

function M:_refreshByHeroChange()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	self._heroData = viewPageMo and viewPageMo.hero or false
	self._heroId = self._heroData:getId()
	self._heroInfoCO = PastInfoConfig.instance:getCharacterInfo(self._heroId)

	if self._tweenDelayUnlockHide then
		self._tweenDelayUnlockHide:Kill(false)
	end

	self:_setUnlockCache(nil, nil)
	self:_refreshView()

	self._scrollRect.verticalNormalizedPosition = 1

	self:playGuiAni("qiehuan")
end

function M:_refreshView()
	self:_refreshNoNeedUnlockView()
	self:_refreshAutoUnlockView()
	self:_refreshSpecialUnlockView()
	self:_refreshSilhouette()
	self:_refreshFileView()
	GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_TAB_CHANGE, false)
end

function M:_refreshNoNeedUnlockView()
	local name = PastInfoConfig.instance:getInfo(CharacterInfoEnum.Name).name

	self._roleNameTxt.text = string.format(name .. ": %s", self._heroInfoCO.name)

	goutil.setActive(self._roleNameTxt.gameObject, self._heroInfoCO.name ~= "")

	name = PastInfoConfig.instance:getInfo(CharacterInfoEnum.Sex).name
	self._sexTxt.text = string.format(name .. ": %s", self._heroInfoCO.gender)

	goutil.setActive(self._sexTxt.gameObject, self._heroInfoCO.gender ~= "")

	name = PastInfoConfig.instance:getInfo(CharacterInfoEnum.Area).name
	self._areaTxt.text = string.format(name .. ": %s", self._heroInfoCO.state)

	goutil.setActive(self._areaTxt.gameObject, self._heroInfoCO.state ~= "")

	name = PastInfoConfig.instance:getInfo(CharacterInfoEnum.Age).name
	self._ageTxt.text = string.format(name .. ": %s", self._heroInfoCO.age)

	goutil.setActive(self._ageTxt.gameObject, self._heroInfoCO.age ~= "")

	name = PastInfoConfig.instance:getInfo(CharacterInfoEnum.Blood).name
	self._bloodTypeTxt.text = string.format(name .. ": %s", self._heroInfoCO.blood)

	goutil.setActive(self._bloodTypeTxt.gameObject, self._heroInfoCO.blood ~= "")

	name = PastInfoConfig.instance:getInfo(CharacterInfoEnum.Birth).name

	local birthdayStr = self._heroInfoCO.birthday or ""

	if string.match(birthdayStr, "#") then
		local arrSingleStep = string.split(birthdayStr, "#")

		birthdayStr = string.format(lang("tip_month_day"), arrSingleStep[1], arrSingleStep[2])
	end

	self._birthTxt.text = string.format(name .. ": %s", birthdayStr)

	goutil.setActive(self._birthTxt.gameObject, birthdayStr ~= "")
end

function M:_refreshAutoUnlockView()
	local name = PastInfoConfig.instance:getInfo(CharacterInfoEnum.Height).name

	self:_refreshOneAutoUnlockPanel(CharacterInfoEnum.Height, self._heightTxt, self._heightLockTxt, name .. ": ", self._heroInfoCO.hight)

	name = PastInfoConfig.instance:getInfo(CharacterInfoEnum.Weight).name

	self:_refreshOneAutoUnlockPanel(CharacterInfoEnum.Weight, self._weightTxt, self._weightLockTxt, name .. ": ", self._heroInfoCO.weight)

	name = PastInfoConfig.instance:getInfo(CharacterInfoEnum.BWH).name

	self:_refreshOneAutoUnlockPanel(CharacterInfoEnum.BWH, self._measurementTxt, self._measurementLockTxt, name .. ": ", self._heroInfoCO.BWH)

	name = PastInfoConfig.instance:getInfo(CharacterInfoEnum.BelongItem).name

	self:_refreshOneAutoUnlockPanel(CharacterInfoEnum.BelongItem, self._belongItemTxt, self._belongItemLockTxt, name .. ": ", self._heroInfoCO.belongings)

	name = PastInfoConfig.instance:getInfo(CharacterInfoEnum.Favour).name

	self:_refreshOneAutoUnlockPanel(CharacterInfoEnum.Favour, self._favourItemTxt, self._favourItemLockTxt, name .. ": ", self._heroInfoCO.favour)

	name = PastInfoConfig.instance:getInfo(CharacterInfoEnum.Dislike).name

	self:_refreshOneAutoUnlockPanel(CharacterInfoEnum.Dislike, self._hateItemTxt, self._hateItemLockTxt, name .. ": ", self._heroInfoCO.dislike)

	name = PastInfoConfig.instance:getInfo(CharacterInfoEnum.Memory).name

	self:_refreshOneAutoUnlockPanel(CharacterInfoEnum.Memory, self._anchorTxt, self._anchorLockTxt, name .. ": ", self._heroInfoCO.memory)
end

function M:_refreshSpecialUnlockView()
	if self._heroInfoCO.bodyparts == "" then
		goutil.setActive(self._positionTxt.gameObject, false)
	else
		goutil.setActive(self._positionTxt.gameObject, true)

		local pastCO = PastInfoConfig.instance:getInfo(CharacterInfoEnum.Bodyparts)

		self:_refreshOneAutoUnlockPanel(CharacterInfoEnum.Bodyparts, self._positionTxt, self._postionLockTxt, pastCO.name .. ": ", self._heroInfoCO.bodyparts)
	end
end

function M:_refreshOneAutoUnlockPanel(pastId, contentTxt, lockTxt, titleStr, resultStr)
	local isUnlock = CharacterInformationModel.instance:getIfCanUnlockByHeroIdAndPastId(self._heroId, pastId)
	local content

	contentTxt.color = isUnlock and Astral.ColorUtil.ParseColor("#f8f8f8") or Astral.ColorUtil.ParseColor("#d7d7d7")

	if isUnlock then
		content = resultStr

		goutil.setActive(lockTxt.gameObject.transform.parent.gameObject, false)
	else
		content = ""

		goutil.setActive(lockTxt.gameObject.transform.parent.gameObject, true)

		local unlockCO = CharacterUnlockContentConfig.instance:getUnlockConfigByHeroIdAndPastId(self._heroId, pastId)

		if unlockCO then
			for i, v in ipairs(unlockCO.condition) do
				if v.type == "tacitLv" then
					lockTxt.text = string.format("%d解锁", v.value)
				end
			end
		else
			local universallyUnlockCO = PastInfoConfig.instance:getUniversallyUnlockConfig(pastId + 1000)

			if universallyUnlockCO then
				for i, v in ipairs(universallyUnlockCO.condition) do
					if v.type == "tacitLv" then
						lockTxt.text = string.format("%d解锁", v.value)
					end
				end
			end
		end
	end

	contentTxt.text = titleStr .. content

	local isShow = true

	if resultStr == "" or resultStr == nil then
		isShow = false
	end

	goutil.setActive(contentTxt.gameObject, isShow)

	if contentTxt.preferredHeight > 40 then
		contentTxt.text = string.format("%s\n%s", titleStr, content)
	end
end

function M:_refreshSilhouette()
	IconLoader.setSprite(self._campIcon, IconType.Silhouette, tostring(self._heroData:getModelId()))
end

function M:_refreshFileView()
	for i, v in ipairs(self._filePanelGoList) do
		self._curFileInfos[i] = false

		self:_refreshOneFileView(i)
	end
end

function M:_refreshOneFileView(index)
	local uiData = self:_getFileUIData(index, self._filePanelGoList[index])
	local panelGo = uiData.panelGo
	local fileCotentGo = uiData.fileCotentGo
	local titleText = uiData.titleText
	local titleText2 = uiData.titleText2
	local contentTxt = uiData.contentTxt
	local lockPanelGo = uiData.lockPanelGo
	local btnGo = uiData.btnGo
	local canNotUnlockPanelGo = uiData.canNotUnlockPanelGo
	local lockTxt = uiData.lockTxt
	local pastId = CharacterInfoEnum.File1 + index - 1
	local pastCO = PastInfoConfig.instance:getInfo(pastId)

	titleText.text = pastCO.name
	titleText2.text = pastCO.name

	if self._heroInfoCO["file" .. index] == "" then
		goutil.setActive(panelGo, false)

		return
	end

	goutil.setActive(panelGo, true)

	self._curFileInfos[index] = CharacterInformationModel.instance:getHeroIsUnlockByHeroIdAndPastId(self._heroId, pastId)

	local isUnlock = self._curFileInfos[index]
	local isPreviousUnlock = true

	if index > 1 then
		isPreviousUnlock = self._curFileInfos[index - 1] or false
	else
		isPreviousUnlock = isUnlock
	end

	if isUnlock and isPreviousUnlock then
		self:_setUnlockShow(self._heroId, index)
	else
		goutil.setActive(fileCotentGo, false)

		contentTxt.text = ""

		local unlockCO = CharacterUnlockContentConfig.instance:getUnlockConfigByHeroIdAndPastId(self._heroId, pastId)
		local universallyUnlockCO = PastInfoConfig.instance:getUniversallyUnlockConfig(pastId + 1000)

		if not universallyUnlockCO then
			printError("找不到通用解锁信息", "过往信息id", pastId)
		end

		local condition = unlockCO ~= nil and unlockCO.condition or universallyUnlockCO.condition

		condition = condition or {}

		for i, v in ipairs(condition) do
			if v.type == "powerLv" then
				goutil.setActive(lockPanelGo, true)

				local target = CharacterExpConfig.instance:getPowerLvById(v.value)

				if isPreviousUnlock and target <= self:getHeroPowerLv() then
					goutil.setActive(canNotUnlockPanelGo, false)
					goutil.setActive(btnGo, true)
				else
					goutil.setActive(canNotUnlockPanelGo, true)
					goutil.setActive(btnGo, false)

					lockTxt.text = string.format("亲和度%d解锁", v.value)
				end
			end

			if v.type == "heroLv" then
				goutil.setActive(lockPanelGo, true)

				if v.value <= self:getHeroLv() and isPreviousUnlock then
					goutil.setActive(canNotUnlockPanelGo, false)
					goutil.setActive(btnGo, true)
				else
					goutil.setActive(canNotUnlockPanelGo, true)
					goutil.setActive(btnGo, false)

					lockTxt.text = string.format("等级达到%d解锁", v.value)
				end
			end

			if v.type == "tacitLv" then
				goutil.setActive(lockPanelGo, true)

				if v.value <= self:getHeroTacit() and isPreviousUnlock then
					goutil.setActive(canNotUnlockPanelGo, false)
					goutil.setActive(btnGo, true)
				else
					goutil.setActive(canNotUnlockPanelGo, true)
					goutil.setActive(btnGo, false)

					lockTxt.text = string.format("默契%d解锁", v.value)
				end
			end
		end
	end
end

function M:_onClickUnlockFile(index)
	local pastId = 17 + index + 1000

	self:_setUnlockCache(self._heroId, index)
end

function M:_onValueChange(v)
	return
end

function M:onExit()
	self._scrollBarAdapter:RemoveOnValueChanged()
	self:setEvent(false)
	self:playGuiAni("close")
end

function M:_getFileUIData(index, go)
	if not self._cacheUIFile then
		self._cacheUIFile = {}
	end

	if not self._cacheUIFile[index] and go then
		local data = {}

		data.panelGo = go
		data.fileCotentGo = goutil.findChild(go, "fileCotent")
		data.titleText = goutil.findChildTextComponent(go, "fileCotent/txtTittle")
		data.titleText2 = goutil.findChildTextComponent(go, "role_file_item/txtId")
		data.contentTxt = goutil.findChildTextComponent(go, "fileCotent/txtContent")
		data.lockPanelGo = goutil.findChild(go, "role_file_item")
		data.lockAnimation = data.lockPanelGo.gameObject:GetComponent(ComponentType.Animation)
		data.btnGo = goutil.findChild(go, "role_file_item/btnUnlock")
		data.canNotUnlockPanelGo = goutil.findChild(go, "role_file_item/lock")
		data.lockTxt = goutil.findChildTextComponent(go, "role_file_item/lock/Text1")
		self._cacheUIFile[index] = data
	end

	return self._cacheUIFile[index]
end

function M:_setUnlockCache(heroId, index)
	self._cache_unlock_heroId = heroId
	self._cache_unlock_uiIndex = index
end

function M:_getUnlockCache()
	return self._cache_unlock_heroId, self._cache_unlock_uiIndex
end

function M:_setUnlockShow(heroId, uiIndex)
	local uiData = self:_getFileUIData(uiIndex)

	if uiData then
		local setDirectly = true
		local cacheHeroId, cacheUiIndex = self:_getUnlockCache()

		if uiIndex == cacheUiIndex then
			if self._tweenDelayUnlockHide then
				self._tweenDelayUnlockHide:Kill(false)
			end

			if cacheHeroId == heroId then
				GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_SET_CAN_SWITCH_HERO, false)

				setDirectly = false

				uiData.lockAnimation:Stop()
				uiData.lockAnimation:Play("role_file_item_jiesuo")

				self._tweenDelayUnlockHide = DoTweenUtil.DelayedCall(0.7, function()
					if self._fileIndexContents[uiIndex] ~= self._heroInfoCO["file" .. uiIndex] or string.nilorempty(uiData.contentTxt.text) then
						uiData.contentTxt.text = StringUtil.randomReplaceBlackBlock(self._heroInfoCO["file" .. uiIndex])
					end

					self._fileIndexContents[uiIndex] = self._heroInfoCO["file" .. uiIndex]

					goutil.setActive(uiData.lockPanelGo, false)
					goutil.setActive(uiData.fileCotentGo, true)
					self._tweenDelayUnlockHide:Kill(false)
				end):OnKill(function()
					GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_SET_CAN_SWITCH_HERO, true)

					self._tweenDelayUnlockHide = nil
				end, self)
			end

			self:_setUnlockCache(nil, nil)
		end

		if setDirectly then
			if self._fileIndexContents[uiIndex] ~= self._heroInfoCO["file" .. uiIndex] or string.nilorempty(uiData.contentTxt.text) then
				uiData.contentTxt.text = StringUtil.randomReplaceBlackBlock(self._heroInfoCO["file" .. uiIndex])
			end

			self._fileIndexContents[uiIndex] = self._heroInfoCO["file" .. uiIndex]

			goutil.setActive(uiData.lockPanelGo, false)
			goutil.setActive(uiData.fileCotentGo, true)
		end
	end
end

return M
