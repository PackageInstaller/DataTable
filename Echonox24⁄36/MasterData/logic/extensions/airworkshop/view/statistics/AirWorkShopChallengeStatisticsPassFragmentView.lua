-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/statistics/AirWorkShopChallengeStatisticsPassFragmentView.lua

module("logic.extensions.airworkshop.view.statistics.AirWorkShopChallengeStatisticsPassFragmentView", package.seeall)

local M = class("AirWorkShopChallengeStatisticsPassFragmentView", StaticFragmentView)

function M:ctor(mainGO, viewPresentor)
	M.super.ctor(self, mainGO)

	self._viewPresentor = viewPresentor
end

function M:buildUI()
	self._dataLst = {}
	self._loopList = LoopListHelper.New(self:getGo("challenge_schema_statistics_tips_1383171516"))

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._cellComps = nil

	self._loopList:Dispose()

	self._loopList = nil
	self._dataLst = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:refreshView()
end

function M:onExit()
	return
end

function M:getMainGO()
	return self.mainGO
end

function M:setData(attackDataLst)
	self._dataLst = attackDataLst
end

function M:refreshView()
	local len = self._dataLst and #self._dataLst or 0

	if len > 0 then
		self._loopList:SetListItemCount(len, true)
		self._loopList:RefreshAllShownItem()
	else
		self._loopList:ClearCells()
	end
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._dataLst[curIndex]
	local prefabName = "statistics_item"
	local item = self._loopList:NewListViewItem(prefabName)

	self:_writeData(item.gameObject, data)

	return item
end

function M:_writeData(go, data)
	if not self._cellComps then
		self._cellComps = {}
	end

	local instanceId = go:GetInstanceID()
	local shower = self._cellComps[instanceId]

	if not shower then
		shower = {
			imgHero = goutil.findChildImageComponent(go, "head_item/mask/headIcon"),
			txtHero = goutil.findChildTextComponent(go, "txtPlayerName"),
			txtFightNum = goutil.findChildTextComponent(go, "txtFightNums"),
			imgEcho = goutil.findChildImageComponent(go, "imgEcho"),
			txtEcho = goutil.findChildTextComponent(go, "txtEchoName"),
			goThought = goutil.findChild(go, "thought_item").gameObject,
			imgThought = goutil.findChildImageComponent(go, "thought_item/thoughtIcon"),
			txtThought = goutil.findChildTextComponent(go, "txtThoughtName")
		}
		self._cellComps[instanceId] = shower
	end

	shower.txtFightNum.text = data.count

	local heroId = data.heroId or 0
	local heroName, heroIcon

	if heroId > 0 then
		local heroIntroCfg = PastInfoConfig.instance:getCharacterInfo(heroId)

		if not heroIntroCfg then
			printError(string.format("无法从[t_%s]获取[%s]的配置", ConfigName.CharacterInfo, heroId))
		end

		heroName = heroIntroCfg and heroIntroCfg.name or ""

		local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(heroId)

		if not cfgCharacter then
			printError(string.format("无法从[t_%s]获取[%s]的配置", ConfigName.Character, heroId))
		end

		heroIcon = cfgCharacter and CharacterCOUtil.getIcon(cfgCharacter) or ""
	end

	shower.txtHero.text = heroName

	if shower.imgHero and not string.nilorempty(heroIcon) then
		IconLoader.setSprite(shower.imgHero, IconType.HeadIcon, heroIcon)
	end

	local thoughtId = data.thinkingId or 0

	if thoughtId > 0 then
		local cfg = ThinkingConfig.instance:getThinkingCO(thoughtId)

		if not cfg then
			printError(string.format("无法从[t_%s]获取[%s]的配置", ConfigName.Thinking, thoughtId))
		end

		local icon = cfg and cfg.icon or ""

		if not string.nilorempty(icon) then
			IconLoader.setSprite(shower.imgThought, IconType.Thought, icon)
		end

		shower.txtThought.text = cfg and cfg.name or ""
	end

	goutil.setActive(shower.goThought, thoughtId > 0)

	local echoId = data.echoItemId or 0

	if echoId > 0 then
		local cfg = BackpackConfig.instance:getItemInfoByItemId(echoId)
		local icon = cfg and cfg.icon or ""

		shower.txtEcho.text = cfg and cfg.name or ""

		if not string.nilorempty(icon) then
			IconLoader.setSprite(shower.imgEcho, IconType.EchoItemIcon, icon)
		end
	end

	goutil.setActive(shower.imgEcho.gameObject, echoId > 0)
	goutil.setActive(shower.txtEcho.gameObject, echoId > 0)
end

return M
