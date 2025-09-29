-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardUnpackResultView.lua

module("logic.extensions.echocardpack.view.EchoCardUnpackResultView", package.seeall)

local M = class("EchoCardUnpackResultView", ViewComponent)

function M:buildUI()
	self._goContent = self:getGo("echocard_gather_view_-759563607")
	self._btnAgain = self:getBtn("echocard_gather_view_-1854399937")
	self._imgAgain = self:getImage("echocard_gather_view_-1854399937")
	self._btnContinue = self:getBtn("echocard_gather_view_1175747429")
	self._txtTips = self:getText("echocard_gather_view_164616006")
	self._txtBtn = self:getText("echocard_gather_view_1775734423")
	self._goContent = self:getGo("echocard_gather_view_-759563607")
	self._goRawImg = self:getGo("echocard_gather_view_314341705")
	self._rawImg = self._goRawImg:GetComponent(UIComponentType.RawImage)
	self._imgBottom = self:getImage("echocard_gather_view_457456993")
	self._goItem = goutil.findChild(self.mainGO, "echocard_gather_item")
	self._goContent2 = self:getGo("echocard_gather_view_373821707")
	self._goUIEffect = goutil.findChild(self.mainGO, "ui_jiesuan")
	self._goUIEffects = {}
	self._goUIEffects[GameEnum.QualityEnum.B] = goutil.findChild(self._goUIEffect, "b")
	self._goUIEffects[GameEnum.QualityEnum.A] = goutil.findChild(self._goUIEffect, "a")
	self._goUIEffects[GameEnum.QualityEnum.S] = goutil.findChild(self._goUIEffect, "s")

	goutil.setActive(self._goItem, false)

	self._goPositions = {}
	self._goPositions2 = {}
	self._pool = Queue.create()
	self._items = {}

	for i = 1, 25 do
		self._goPositions[i] = goutil.findChild(self._goContent, "pos" .. i)
	end

	for i = 1, 5 do
		self._goPositions2[i] = goutil.findChild(self._goContent2, "pos" .. i)
	end
end

function M:destroyUI()
	self._photo = nil
	self._resLoader = nil
end

function M:bindEvents()
	self._btnAgain:AddClickListener(self._onClickAgain, self)
	self._btnContinue:AddClickListener(self._onClickContinue, self)
end

function M:unbindEvents()
	self._btnAgain:RemoveClickListener()
	self._btnContinue:RemoveClickListener()
end

function M:onEnter()
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_canxiang_jiesuan, nil, nil, nil)
	self:_initShowData()
	self:_initPhoto()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
	self:_updateMoneyView()

	self._unpackNum = EchoCardPackController.instance:getUnpackNum()

	local itemId = EchoCardPackController.instance:getEchoCardPackId()
	local itemCount = ItemModel.instance:getItemCountByItemId(itemId)
	local isCanUseAgain = itemCount >= self._unpackNum

	GameUtils.setImageGray(self._imgAgain, not isCanUseAgain)
	goutil.setActive(self._goContent, self._unpackNum > 1)
	goutil.setActive(self._goContent2, self._unpackNum == 1)
	self:_updateText()
end

function M:onExit()
	VolumeMgr.instance:turnOff(VolumeName.EchoCardPack)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
	removetimer(self._cloneObj, self)

	if self._resLoader then
		self._resLoader:clear()
	end

	if self._photo then
		self._photo:clear()
	end
end

function M:_initPhoto()
	local color = "#FFFFFF"

	if self._maxQuality == GameEnum.QualityEnum.S then
		color = "#FFCD4E"
	elseif self._maxQuality == GameEnum.QualityEnum.A then
		color = "#FF96E9"
	end

	local parseColor = Astral.ColorUtil.ParseColor(color)

	self._rawImg.color = parseColor
	self._imgBottom.color = parseColor
	self._photo = Astral.LuaComponentContainer.Add(self._goRawImg, PhotoModel)

	self._photo:setModelLoadCallback(self._onResLoad, self)
	self._photo:updateRes(ResName.EchoCardUnpackPosModel, nil, UnityEngine.RenderTextureFormat.RGB111110Float)
	self._photo:setCameraPostProcessing(true, SceneLayer.UI3D_Value)
	self._photo:setCameraCullingLayer(SceneLayer.UI3D_Value)
	self._photo:setCameraTag(SceneTag.RTCamera)
	self._photo:setCameraPosition(0, 34.44, 10.6)
	self._photo:setRotation(0, -180, 0)
	self._photo:setCameraOrthographic(50)
	VolumeMgr.instance:turnOn(VolumeName.EchoCardPack, self._onVolumeLoad, self)
end

function M:_onVolumeLoad(volumeUnit)
	if volumeUnit and self._photo then
		local x, y, z = self._photo:getCameraPosition()

		volumeUnit:setPosition(x, y, z)
	end
end

function M:_onResLoad(inst)
	self._mainGo = inst

	goutil.setActive(self._mainGo, true)

	self._resLoader = SingleResLoader.New()

	self._resLoader:load(ResName.EchoCardUnpackResultEffect, self._onQualityLoaded, self)
end

function M:_onQualityLoaded(resource)
	if not resource.IsSuccess then
		return
	end

	self._qualityEffectGo = self._resLoader:getResInstance()

	goutil.addChildToParent(self._qualityEffectGo, goutil.findChild(self._mainGo, "qualityGo"))

	self._goQualityEffects = {}
	self._goQualityEffects[GameEnum.QualityEnum.B] = goutil.findChild(self._qualityEffectGo, "low")
	self._goQualityEffects[GameEnum.QualityEnum.A] = goutil.findChild(self._qualityEffectGo, "in")
	self._goQualityEffects[GameEnum.QualityEnum.S] = goutil.findChild(self._qualityEffectGo, "higt")
	self._results = EchoCardPackController.instance:getCacheResult()
	self._index = 1

	self:hideQualityEffect()
	settimer(0.001, self._cloneObj, self, true)
end

function M:hideQualityEffect()
	for key, obj in pairs(self._goQualityEffects) do
		goutil.setActive(obj, false)
	end

	for key, obj in pairs(self._goUIEffects) do
		goutil.setActive(obj, key == self._maxQuality)
	end
end

function M:_initShowData()
	self._hasShowNum = 0
	self._showResults = {}

	local tempResults = {}
	local results = EchoCardPackController.instance:getCacheResult()

	self._maxQuality = GameEnum.QualityEnum.C

	for i = 1, #results do
		local itemData = results[i].itemData

		if itemData:getQuality() > self._maxQuality then
			self._maxQuality = itemData:getQuality()
		end

		if itemData:getQuality() == GameEnum.QualityEnum.S then
			table.insert(self._showResults, results[i])
		else
			table.insert(tempResults, results[i])
		end
	end

	table.sort(self._showResults, function(a, b)
		return a.itemData:getItemId() < b.itemData:getItemId()
	end)
	table.insertto(self._showResults, tempResults, 0)
end

function M:_onClickAgain()
	local curTime = os.clock()

	if self._clickTime and curTime - self._clickTime < 0.5 then
		return
	end

	self._clickTime = curTime

	if self._hasShowNum < #self._showResults then
		return
	end

	local itemId = EchoCardPackController.instance:getEchoCardPackId()
	local itemCount = ItemModel.instance:getItemCountByItemId(itemId)

	if itemCount < self._unpackNum then
		-- block empty
	else
		local isActivity = EchoCardPackController.instance:isActivityUnpack()
		local poolConfig = EchoCardPackController.instance:getEchoPoolConfig(itemId)

		if poolConfig then
			RetrieveAgent.instance:sendLotteryEchoRequest(poolConfig.code, self._unpackNum, isActivity, itemId)
		end
	end
end

function M:_updateText()
	local guaranteeA, guaranteeB = EchoCardPackController.instance:getGuaranteeData()

	if guaranteeA > 0 and guaranteeB > 0 then
		if guaranteeA < guaranteeB then
			self._txtTips.text = langF("tip_echo_unpack_guarantee_A", guaranteeA)
		else
			self._txtTips.text = langF("tip_echo_unpack_guarantee_S", guaranteeB)
		end
	elseif guaranteeA > 0 then
		self._txtTips.text = langF("tip_echo_unpack_guarantee_A", guaranteeA)
	elseif guaranteeB > 0 then
		self._txtTips.text = langF("tip_echo_unpack_guarantee_S", guaranteeB)
	end

	goutil.setActive(self._txtTips.gameObject, guaranteeA > 0 or guaranteeB > 0)

	self._txtBtn.text = langF("tip_echo_unpack_again", self._unpackNum)
end

function M:_onClickContinue()
	if self._hasShowNum < #self._showResults then
		return
	end

	self:back()
end

function M:_cloneObj()
	if self._index <= #self._showResults then
		local item = self._items[self._index]

		if not item then
			local go = goutil.clone(self._goItem)

			goutil.setActive(go, true)

			item = Astral.LuaComponentContainer.Add(go, EchoCardUnpackResultViewItem)
			self._items[self._index] = item
		end

		self._hasShowNum = self._hasShowNum + 1

		item:setData(self._showResults[self._index])

		if self._unpackNum == 1 then
			goutil.addChildToParent(item._go, self._goPositions2[self._index])
		else
			goutil.addChildToParent(item._go, self._goPositions[self._index])
		end

		GameUtils.setLocalPos(item._go, 0, 0, 0)
	else
		removetimer(self._cloneObj, self)
	end

	self._index = self._index + 1
end

function M:_updateMoneyView()
	local itemId = EchoCardPackController.instance:getEchoCardPackId()

	self._viewPresentor:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, nil, {
		itemId
	})
end

return M
