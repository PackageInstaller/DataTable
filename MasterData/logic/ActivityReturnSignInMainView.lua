-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityreturnsignin/view/ActivityReturnSignInMainView.lua

module("logic.extensions.activityreturnsignin.view.ActivityReturnSignInMainView", package.seeall)

local ActivityReturnSignInMainView = class("ActivityReturnSignInMainView", ViewComponent)

ActivityReturnSignInMainView.StoryKey = "ActivityReturnSignIn_ReturnSignIn"

function ActivityReturnSignInMainView:ctor()
	ActivityReturnSignInMainView.super.ctor(self)
end

function ActivityReturnSignInMainView:unbindEvents()
	ActivityReturnSignInMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ActivityReturnSignInMainView:bindEvents()
	ActivityReturnSignInMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ActivityReturnSignInMainView:buildUI()
	ActivityReturnSignInMainView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._tableSignInView = self:getGo("tableSignInView")
	self._uiEffect = self:getGo("effect")
	self._onceEffect = self:getGo("onceEffect")
	self._signInCell = self:getGo("signInCell")
	self._txtTime = self:getTxt("openTime/txt")
	self._con = self:getGo("spriteInfoGo/spriteRawIma")
	self._bubble = self:getGo("spriteInfoGo/bubble")
	self._bubble_txt = goutil.findChildTextComponent(self._bubble, "txt")

	local nailongs = self:getGo("nailongs")

	self._nailongGos = {}

	for idx = 1, nailongs.transform.childCount do
		local mainGo = nailongs.transform:GetChild(idx - 1).gameObject

		table.insert(self._nailongGos, mainGo)
	end

	self._tableSignInList = ScrollerList.create(self._tableSignInView, self._signInCell, GameUtil.handler(self._updateSignInCell, self), GameUtil.handler(self._clearSignInCell, self))
end

function ActivityReturnSignInMainView:destroyUI()
	ActivityReturnSignInMainView.super.destroyUI(self)
end

function ActivityReturnSignInMainView:onEnter()
	ActivityReturnSignInMainView.super.onEnter(self)

	local activityType = GameEnum.ActivityType.SignIn

	self._activityId = self:getFirstParam() or ActivityDefineController.instance:getActivityIdByType(activityType)
	self._effectList = {}

	local storyId = OperationSignInConfig.instance:getSignInExtra(self._activityId).storyId

	self._txtTime.text = GameUtil.getActTimeDesc(activityType, self._activityId)

	self.addGEvent(self, GlobalNotify.OperationSignIn, self._onRefreshUI, self)
	self.addGEvent(self, GlobalNotify.OperationSignInGetPrize, self._onRefreshUI, self)
	OperationSignInModel.instance:setActivityId(self._activityId)
	OperationSignInController.instance:getInfo()

	local key = ActivityReturnSignInMainView.StoryKey

	if not GameUtil.getUserData(key) then
		self:_playStory(key, storyId)
	end
end

function ActivityReturnSignInMainView:onExit()
	ActivityReturnSignInMainView.super.onExit(self)
	self._tableSignInList:dispose()
	self:_removeEffect()
end

function ActivityReturnSignInMainView:_updateSignInCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgPrize = goutil.findChildImageComponent(go, "imgPrize")
	local txtDay = goutil.findChildTextComponent(go, "txtDay")
	local lockGo = goutil.findChild(go, "imgLock")
	local item = goutil.findChild(go, "item")
	local btnGet = goutil.findChild(go, "btnGet")
	local effectRoot = goutil.findChild(go, "effectRoot")

	txtDay.text = string.format("第%s天", data.day)

	MaterialMgr.setCellByCfg(data.reward, item)

	local isCanGet = self:_isCanGet(data.day)

	self._prizeEffPool = self._prizeEffPool or {}

	UIEffectManager.instance:stopEffect(self._prizeEffPool[go])

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(self._tableSignInView:GetComponent(ComponentType.ScrollRect))
			eff:setParent(effectRoot.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._prizeEffPool[go] = UIEffectManager.instance:playEffect(self, effPath, effectRoot, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.SetActive(btnGet, isCanGet)
	GameUtil.SetActive(lockGo, self:_isHasGain(data.day))
	GameUtil.addClickHandler(btnGet, function()
		if isCanGet then
			OperationSignInController.instance:gainPrize(data.day)
			self:_loadOnceEffect()
			self:_playAnimSpine("idle2")
		end
	end)
end

function ActivityReturnSignInMainView:_clearSignInCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local btnGet = goutil.findChild(go, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[go])
	end
end

function ActivityReturnSignInMainView:_isCanGet(day)
	return day <= self._onlineDay and self._signInMap[day] == false
end

function ActivityReturnSignInMainView:_isHasGain(day)
	return self._signInMap[day] ~= false
end

function ActivityReturnSignInMainView:_onRefreshUI()
	local hasRec = {}
	local noRec = {}
	local onLineday = OperationSignInModel.instance:getOnlineDay() or {}

	self._onlineDay = checknumber(onLineday)
	self._signInMap = OperationSignInModel.instance:getDaysList()

	local signInCfg = OperationSignInConfig.instance:getSignInCfgList(self._activityId)
	local tempSignInCfg = {}

	for i, v in pairs(signInCfg) do
		table.insert(tempSignInCfg, v)
	end

	table.sort(tempSignInCfg, function(a, b)
		return a.day < b.day
	end)

	for i, v in pairs(tempSignInCfg) do
		if self._signInMap[v.day] == true then
			table.insert(hasRec, v)
		else
			table.insert(noRec, v)
		end
	end

	if next(hasRec) ~= nil then
		table.sort(hasRec, function(a, b)
			return a.day < b.day
		end)

		for k, v in pairs(hasRec) do
			table.insert(noRec, v)
		end
	end

	self._tableSignInList:reloadData(noRec)

	local normal = Framework.ColorUtil.ParseColor("#FFFFFFFF")
	local black = Framework.ColorUtil.ParseColor("#898989FF")

	for day, mainGo in ipairs(self._nailongGos) do
		local img = mainGo:GetComponent(ComponentType.RawImage)

		img.color = self:_isHasGain(day) and normal or black
	end
end

function ActivityReturnSignInMainView:_playStory(key, id)
	if checknumber(id) > 0 then
		GameUtil.saveUserData(key, true)
		StoryController.instance:startStory(checknumber(id))
	end
end

function ActivityReturnSignInMainView:_loadSpine()
	local spineRoot = self._con
	local view = self
	local spinePath = "lihui_spine/14022_yuanchushenglong01_beibao_lihui/14022_yuanchushenglong01_beibao_lihui-ui_p.prefab"
	local pos = {
		-135,
		-359
	}
	local scale = {
		0.7,
		0.7
	}

	pos = pos or {}

	local posX, posY = checknumber(pos[1]), checknumber(pos[2])

	GameUtil.setLocalPos(self._con, posX, posY)

	scale = scale or {}

	if not scale[2] then
		local scaleX, scaleY = scale[1] or 1, 1

		GameUtil.setLocalScale(self._con, scaleX, scaleY)

		self._spineCtrl = self._spineCtrl or ActivityReturnSpineCtrl.New()

		self._spineCtrl:onInit(spineRoot, view, spinePath)
	end
end

function ActivityReturnSignInMainView:_unloadSpine()
	if self._spineCtrl then
		self._spineCtrl:onClear()
	end
end

function ActivityReturnSignInMainView:_showBubble(bubbleId)
	if bubbleId <= 0 then
		GameUtil.SetActive(self._bubble, false)
	else
		local data = NewYearPrayConfig.instance:getNypBubbleData(bubbleId)

		self._bubble_txt.text = data.desc

		GameUtil.SetActive(self._bubble, true)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._bubble:GetComponent(goutil.Type_RectTransform))
	end
end

function ActivityReturnSignInMainView:_playAnimSpine(animName)
	if self._spineCtrl and not string.nilorempty(animName) then
		self._spineCtrl:_playAnim(animName, false, function(animName)
			self._spineCtrl:_playAnim("idle", true)
		end)
	end
end

function ActivityReturnSignInMainView:_loadEffect()
	self:_removeEffect()

	local bgEffectPath = "20240209/yeyanjiedaili/fx_ui_yeyanjiedaili_fenwei.prefab"
	local bgUIEffect = UIEffectManager.instance:playEffect(self, bgEffectPath, self._uiEffect.transform, 0, 0, true, false)

	bgUIEffect:setParent(self._uiEffect.transform)
	bgUIEffect:setScale(1)
	bgUIEffect:setLocalPos(0, 0, 0)

	self._bgUIEffect = bgUIEffect
end

function ActivityReturnSignInMainView:_removeEffect()
	if self._bgUIEffect then
		UIEffectManager.instance:stopEffect(self._bgUIEffect)

		self._bgUIEffect = nil
	end
end

function ActivityReturnSignInMainView:_loadOnceEffect()
	self:_removeOnceEffect()

	local bgEffectPath = "20230929/shangyuetai/fx_ui_shangyuetai_yanhua.prefab"
	local bgUIEffect = UIEffectManager.instance:playEffect(self, bgEffectPath, self._onceEffect.transform, 0, 0, false, false)

	bgUIEffect:setParent(self._onceEffect.transform)
	bgUIEffect:setScale(1)
	bgUIEffect:setLocalPos(0, 0, 0)

	self._onceUIEffect = bgUIEffect
end

function ActivityReturnSignInMainView:_removeOnceEffect()
	if self._onceUIEffect then
		UIEffectManager.instance:stopEffect(self._onceUIEffect)

		self._onceUIEffect = nil
	end
end

return ActivityReturnSignInMainView
