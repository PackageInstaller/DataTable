-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aocore/AoCoreView.lua

module("logic.extensions.aocore.AoCoreView", package.seeall)

local AoCoreView = class("AoCoreView", ViewComponent)
local resPath = "effect/prefabs/story/story_mofang/fx_mofang_story_02.prefab"

function AoCoreView:ctor()
	AoCoreView.super.ctor(self)
end

function AoCoreView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function AoCoreView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function AoCoreView:buildUI()
	AoCoreView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._modelCam = goutil.findChild(self.mainGO, "modelCam")
	self._container = goutil.findChild(self._modelCam, "uiroot/container")
	self._ovalmove = self._container:GetComponent("UIOvalMove")
	self._rawImage = goutil.findChildComponent(self.mainGO, "rawImage", typeof(UnityEngine.UI.RawImage))
	self._rectTrans = self._rawImage:GetComponent(typeof(UnityEngine.RectTransform))
end

function AoCoreView:destroyUI()
	return
end

function AoCoreView:onEnter()
	AoCoreView.super.onEnter(self)

	self._cellClickCallBackMap = {}

	self._modelCam.transform:SetParent(nil)

	self._curViewDatas = AocoreConfig.instance:getCfgList()

	print("active = " .. tostring(self._ovalmove.gameObject.activeInHierarchy))

	self._ovalmove._r = 234
	self._ovalmove._R = 549
	self._ovalmove._angleOffset = -12

	self._ovalmove:CreateObjs(#self._curViewDatas)
	self._ovalmove:RefreshAll(self._updateCell, self)
	self._ovalmove:CenterOn(0)
	GlobalDispatcher:addListener("guide_core_at", self.onPauseAt, self)
	goutil.setActive(self._rawImage.gameObject, false)
	getres(resPath, self._onResLoaded, self)

	local joystickView = VirtualJoystickModel.instance:getJoystickView()

	if joystickView then
		joystickView:setEnable(false)
	end

	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self.checkUp, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self.checkUp, self)
	GlobalDispatcher:addListener(GlobalNotify.GetDivineEvolveInfoRes, self._onDivineEvolveInfoGet, self)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_AOCORE_DIVINE, false)
	PetAgent.instance:sendPM_GetDivineEvolveInfoReq()
end

function AoCoreView:_onResLoaded(res)
	if res and res.IsSuccess then
		res:Retain()
		print("resLoaded")

		local go = goutil.create("mofang_container", false)

		self._res = res
		self._go = go

		local mofang = goutil.cloneAndSetParent(res:GetMainAsset(), go.transform)

		Framework.TransformUtil.SetPos(go.transform, 2000, 0, 0)
		Framework.TransformUtil.SetLocalScale(mofang.transform, 1, 1, 1)
	end
end

function AoCoreView:onPauseAt(param)
	print(">>>>>>>>>>>>>>>>>>>>>>>>       AoCoreView:onEnterFinished()     ", param)
	self._ovalmove:CenterOn(checknumber(param) - 1)
	self._ovalmove:IsPause(true)
end

function AoCoreView:onEnterFinished()
	GlobalModel.instance:visibleSceneHUDs(false)
end

function AoCoreView:onExit()
	AoCoreView.super.onExit(self)
	GlobalModel.instance:visibleSceneHUDs(true)

	self._curViewDatas = nil

	GlobalDispatcher:removeListener("guide_core_at", self.onPauseAt, self)
	removeresl(resPath, self._onResLoaded, self)

	if self._res then
		self._res:Release()
	end

	self._res = nil

	if not goutil.isNil(self._go) then
		goutil.destroy(self._go)
	end

	self._go = nil

	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpen, self.checkUp, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self.checkUp, self)
	GlobalDispatcher:removeListener(GlobalNotify.GetDivineEvolveInfoRes, self._onDivineEvolveInfoGet, self)
	self._modelCam.transform:SetParent(self.mainGO.transform)
	self._ovalmove:RefreshAll(self._clearCell, self)

	self._cellClickCallBackMap = nil

	local joystickView = VirtualJoystickModel.instance:getJoystickView()

	if joystickView then
		joystickView:setEnable(true)
	end
end

function AoCoreView:_onDivineEvolveInfoGet()
	local isRed = self:_isShowBirthdayTag(375)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_AOCORE_DIVINE, isRed)
end

function AoCoreView:_clearCell(cell, idx)
	cell = goutil.findChild(cell, "container")

	local redPoint = goutil.findChild(cell, "imgPoint")

	RedPointController.instance:unregRedPoint(redPoint)
end

function AoCoreView:checkUp()
	return
end

function AoCoreView:getGuideGo()
	return self._modelCam
end

function AoCoreView:onExitFinished()
	return
end

function AoCoreView:_updateCell(parent, idx)
	local data = self._curViewDatas[idx + 1]

	parent.transform.name = "aohe_" .. idx + 1

	local cell = goutil.findChild(parent, "container")
	local _imgIcon = goutil.findChildComponent(cell, "imgIcon", "UIImageSpriteChange")
	local _goLock = goutil.findChild(cell, "lock")
	local _txtLock = goutil.findChildComponent(cell, "lock/txtLock", "Text")
	local _redpoint = goutil.findChild(cell, "imgPoint")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local nameBg = goutil.findChild(cell, "nameBg")
	local birthdayTag = goutil.findChild(cell, "birthdayTag")
	local _funcId = data.funcId
	local isLock = not FuncOpenModel.instance:getFuncIsOpen(_funcId)

	goutil.setActive(_goLock, isLock)

	local _cfg = FuncOpenConfig.instance:getFunctionOpenById(_funcId)
	local func = self._cellClickCallBackMap[data.id]

	if func == nil then
		func = GameUtil.handler(self._onClickCell, self, _cfg, data)
		self._cellClickCallBackMap[data.id] = func
	end

	GameUtil.addClickHandler(cell, func)
	_imgIcon:ChangeSprite(data.icon)

	if _cfg ~= nil then
		_txtLock.text = not string.nilorempty(_cfg.lockedTips) and _cfg.lockedTips or FuncOpenController.instance:getConditionLockTips(_cfg.openCondition)

		local repointId = data.redpointID

		if not isLock and repointId then
			if type(repointId) == "table" then
				RedPointController.instance:regRedPoint(_redpoint, unpack(repointId))
			else
				RedPointController.instance:regRedPoint(_redpoint, repointId)
			end
		else
			goutil.setActive(_redpoint, false)
		end

		goutil.setActive(nameBg, true)
	else
		goutil.setActive(_goLock, false)
		goutil.setActive(_redpoint, false)
		goutil.setActive(nameBg, false)
	end

	txtName.text = data.name

	goutil.setActive(nameBg, not string.nilorempty(txtName.text))

	if data.funcId == 375 then
		RedPointController.instance:regRedPoint(birthdayTag, RedPointModel.ID_AOCORE_DIVINE)
	end
end

function AoCoreView:_isShowBirthdayTag(funcId)
	if funcId == 375 then
		local divineList = DivineEvolveController.instance:getDivineMainList()

		if #divineList == 0 then
			return false
		else
			for i, v in ipairs(divineList) do
				if v.raceId == 14000 or v.raceId == 10145 then
					local cfg = EvolveConfig.instance:getDivineEvolveCfg(checknumber(v.raceId))

					if cfg then
						local isChanllenge = DivineEvolveModel.instance:isFinishEvolveCondition(cfg.newRaceId)

						if not isChanllenge then
							return true
						end
					end
				end
			end
		end
	end

	return false
end

function AoCoreView:_onClickCell(cfg, data)
	print("click cell")

	if cfg then
		FuncOpenController.instance:onClickFunc(cfg)
		SurveyController.instance:reportBehavior(200482, data.id)
	else
		FloatWordMgr.instance:show(ConstString.NotRelease)
	end
end

function AoCoreView:_onClickClose()
	self:close()
end

return AoCoreView
