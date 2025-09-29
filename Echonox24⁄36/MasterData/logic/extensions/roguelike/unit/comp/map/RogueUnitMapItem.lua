-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/map/RogueUnitMapItem.lua

module("logic.extensions.roguelike.unit.comp.map.RogueUnitMapItem", package.seeall)

local M = class("RogueUnitMapItem", RogueUnitCompBase)

function M:onInit()
	self._followUIComp = self._unit.followUIComp
	self._lineDir = {}
	self._lineAnis = {}
	self._originGoName = nil
	self._plateIndex = nil
	self._blockObjs = nil
	self._mapRole = nil
	self._mapLiPai = nil
end

function M:onReset()
	if self._followUIComp then
		self._followUIComp:removeAllFollowGameObject()
	end

	if self._plateObj ~= nil then
		goutil.destroy(self._plateObj)

		self._plateObj = nil
	end

	if self._mapRole ~= nil then
		self._mapRole:destroy()

		self._mapRole = nil
	end

	if self._mapLiPai ~= nil then
		self._mapLiPai:destroy()

		self._mapLiPai = nil
	end

	if self._point ~= nil then
		goutil.destroy(self._point)

		self._point = nil
	end

	if self._planeEmpty ~= nil then
		goutil.destroy(self._planeEmpty)

		self._planeEmpty = nil
	end

	for k, v in pairs(self._lineDir) do
		goutil.destroy(v)
	end

	for k, v in pairs(self._blockObjs or {}) do
		goutil.destroy(v)
	end

	for k, v in pairs(self._blockTargets or {}) do
		v:onDestroy()
	end

	for k, v in pairs(self._plateUnitCompObjs or {}) do
		v:onDestroy()
	end

	self._lineDir = {}
	self._lineAnis = {}
	self._originGoName = nil
	self._plateIndex = nil
	self._animation = nil
	self._inEnterAni = false
	self._blockObjs = nil
	self._blockTargets = nil
	self._plateUnitCompObjs = nil

	self:onBlockAniFinish()
	removetimer(self.activePlateObj, self)
end

function M:onDestroy()
	self:onReset()
end

function M:getPlateIndex()
	if self:getIsCurCoordinate() then
		return 1
	end

	return self._plateIndex or math.random(1, 8)
end

function M:setLineActive(isActive, isIgnoreModel)
	for k, v in pairs(self._lineDir) do
		goutil.setActive(v, isActive and self._data.visible)
	end

	for k, v in pairs(self._lineAnis) do
		if isActive then
			v:Play("line_open")
		end
	end

	self:setPointActive(isActive and self._data.visible, nil, isIgnoreModel)
end

function M:setPointActive(isActive, useAni, isIgnoreModel)
	if self._point ~= nil then
		goutil.setActive(self._point, isActive)

		if isActive and self._aniPointType then
			self._aniPointType:Play("point_type2_open2")
		end

		for k, v in pairs(self._blockObjs or {}) do
			goutil.setActive(v, isActive)
		end

		if not isIgnoreModel and self._mapRole ~= nil then
			if not self._mapRole.go.activeInHierarchy and isActive and not self._data.isFinish then
				self._mapRole.meshModel:play(RoguelikeConst.ROGUE_ROLE_ANI.FALL, false, true)
			end

			goutil.setActive(self._mapRole.go, isActive and not self._data.isFinish)
		end

		if self._mapLiPai ~= nil then
			goutil.setActive(self._mapLiPai.go, isActive and not self._data.isFinish)
		end

		if not isActive and useAni then
			goutil.setActive(self._point, true)
			settimer(0.2, function()
				self._isFinish = true

				self._aniPointType:Play("point_type2_close")
			end, self, false)
		end
	end
end

function M:setModelActive(isActive)
	if self._mapLiPai ~= nil then
		goutil.setActive(self._mapLiPai.go, isActive)
	end

	if self._mapRole ~= nil then
		goutil.setActive(self._mapRole.go, isActive)
	end
end

function M:getMapItemExitAniName()
	return "pt_bankuai_xs@secu"
end

function M:getMapItemEnterAniName()
	return "pt_bankuai_cx@secu"
end

function M:playExitAni()
	if goutil.isNil(self._plateObj) then
		return
	end

	if not self._animation then
		self._animation = self._plateObj:GetComponent(ComponentType.Animation)
	end

	if self._animation ~= nil then
		self._animation:Play(self:getMapItemExitAniName())
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_scenery_monoblockfall)
	end
end

function M:playEnterAni()
	if goutil.isNil(self._plateObj) then
		return
	end

	if not self._animation then
		self._animation = self._plateObj:GetComponent(ComponentType.Animation)
	end

	if self._animation ~= nil then
		self._animation:Play(self:getMapItemEnterAniName())
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_scenery_monoblockarise)
	end
end

function M:delayPlayEnterAni(time)
	self._inEnterAni = true

	settimer(time, self.activePlateObj, self, false)
end

function M:activePlateObj()
	self._inEnterAni = false

	goutil.setActive(self._plateObj, true)
end

function M:getPlateObj()
	return self._plateObj
end

function M:setFollowGo(go)
	self._followUIComp:addCenterFollowGameObject(go)
end

function M:removeFollowGo()
	if self._followUIComp then
		self._followUIComp:removeAllFollowGameObject()
	end
end

function M:resetActiveObject()
	for k, v in pairs(self._lineDir or {}) do
		goutil.setActive(v, false)
	end

	goutil.setActive(self._planeEmpty, false)
	self:setPointActive(false)
end

function M:setPlaneEmptyActive(isActive)
	goutil.setActive(self._planeEmpty, isActive)
end

function M:showPlaneEmptyHideAni()
	if self._planeEmpty.activeInHierarchy then
		self._planeEmptyAni:Play("exit")
	end

	settimer(0.6, self._delayHidePlaneEmpty, self, false)
end

function M:showPlateAni(callback)
	self._plateAniCallback = callback

	if self._plateObj ~= nil and not goutil.isNil(self._plateObj) then
		if not self._plateObj.activeInHierarchy then
			-- block empty
		else
			self:_onPlateAniFinish()

			return
		end

		goutil.setActive(self._plateObj, true)
	else
		self:_onPlateAniFinish()

		return
	end

	settimer(0.7, self._onPlateAniFinish, self, false)
end

function M:_onPlateAniFinish()
	if self._plateAniCallback then
		self._plateAniCallback()
	end
end

function M:getCoordinateStr()
	return self._coordinateStr
end

function M:getCoordinate()
	return self._data.coordinate
end

function M:getIsCurCoordinate()
	return RoguelikeModel.instance:getCurRoomMo() and self:getCoordinateStr() == RoguelikeModel.instance:getCurRoomMo():getCoordinateStr()
end

function M:setUiActive(isActive)
	self:setLineActive(isActive)
end

function M:updateData(data)
	local mapMgr = RogueMgr.instance:getMapMgr()
	local plateMgr = RogueMgr.instance:getPlateMgr()
	local coordinate = data.coordinate

	self._coordinateStr = data.coordinateStr

	local tra = self._unit.go.transform
	local originCoordinate = RoguelikeTempParam.ROOM_START_COORDINATE
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local pos = Vector3.New((coordinate[1] + data.offset - originCoordinate[1]) * kMapItemSize, 0, (coordinate[2] - originCoordinate[2]) * -kMapItemSize)

	tra.localPosition = pos

	local plateCo = data.plateCo
	local lineDir = data.lineDir
	local lineDirVectors = {
		Vector3.New(90, 0, 0),
		Vector3.New(90, 0, 180),
		Vector3.New(90, -90, 90),
		Vector3.New(90, -90, -90)
	}
	local breakDirVectors = {
		Vector3.New(0, 90, 0),
		Vector3.New(0, 90, 0),
		Vector3.New(0, 0, 0),
		Vector3.New(0, 0, 0)
	}

	if self._point == nil then
		local point = mapMgr:getPointIns()

		point.transform:SetParent(tra, false)

		point.transform.localPosition = Vector3.New(0, 0, 0)
		self._point = point
		self._pointType1 = goutil.findChild(point, "type1")
		self._pointType2 = goutil.findChild(point, "type2")
		self._goDi1 = goutil.findChild(point, "type2/di1")
		self._goDi2 = goutil.findChild(point, "type2/di2")
		self._goType2Point1 = goutil.findChild(point, "point_1")
		self._goType2Point2 = goutil.findChild(point, "point_2")
		self._iconType = goutil.findChild(point, "type2/icon"):GetComponent("SpriteRenderer")
		self._aniPointType = self._pointType2:GetComponent(ComponentType.Animation)
	end

	goutil.setActive(self._point, data.visible)
	goutil.setActive(self._pointType1, data.isFinish)
	goutil.setActive(self._pointType2, not data.isFinish)
	goutil.setActive(self._goType2Point1, data.isClear)
	goutil.setActive(self._goType2Point2, not data.isClear)

	local isFinish = data.isFinish

	if self._isFinish ~= isFinish then
		if not isFinish then
			self._aniPointType:Play("point_type2_open2")
		else
			goutil.setActive(self._pointType2, true)
			self._aniPointType:Play("point_type2_close")
			settimer(0.2, function()
				goutil.setActive(self._pointType2, false)
			end, self, false)
		end
	end

	if not isFinish and data.icon ~= "" then
		local setting = IconType.getSetting(IconType.RunGroup)
		local url = setting.url
		local dynIcon = SpriteDynIcon.Get(self._iconType.gameObject)

		dynIcon:SetImage(string.format(url, string.format("rungroup_point/%s", data.icon)), nil, nil)
	end

	self._isFinish = isFinish

	goutil.setActive(self._goDi1, data.mo:getIsQuestion() and not data.isCurRoom and data.icon ~= "rungroup_point12" and data.icon ~= "")
	goutil.setActive(self._goDi2, not data.mo:getIsQuestion() and not data.isCurRoom and data.icon ~= "rungroup_point12" and data.icon ~= "")
	goutil.setActive(self._iconType.gameObject, not isFinish and not data.isCurRoom and data.icon ~= "")

	self._data = data

	local offsets = {
		{
			0,
			-1
		},
		{
			0,
			1
		},
		{
			-1,
			0
		},
		{
			1,
			0
		}
	}

	for k, v in pairs(lineDir) do
		if self._lineDir[k] == nil then
			local line

			if k <= 4 then
				if k == 3 or k == 4 then
					line = mapMgr:getLineIns()
				else
					line = mapMgr:getLineYIns()
				end

				line.transform:SetParent(tra, false)

				line.transform.localPosition = Vector3.New(0, 0.01, 0)
				line.transform.eulerAngles = lineDirVectors[k]
				line.name = "line" .. k
				self._lineDir[k] = line
			else
				line = mapMgr:getPointBreakIns()

				line.transform:SetParent(tra, false)

				local offset = offsets[k - 4]
				local x = offset[1] * RoguelikeConst.MAP_ITEM_SIZE * 0.5
				local y = offset[2] * RoguelikeConst.MAP_ITEM_SIZE * 0.5

				line.transform.localPosition = Vector3.New(x, 0, y)
				line.transform.eulerAngles = breakDirVectors[k - 4]
				line.name = "line_break"
				self._lineDir[k] = line
			end

			self._lineAnis[k] = line:GetComponent(ComponentType.Animation)

			self._lineAnis[k]:Play("line_open")
		end

		if k <= 4 then
			local goType1 = goutil.findChild(self._lineDir[k], "type1")
			local goType2 = goutil.findChild(self._lineDir[k], "type2")

			goutil.setActive(goType1, v > 0)
			goutil.setActive(goType2, v < 0)
			goutil.setActive(self._lineDir[k], true)
		end
	end

	local isShowPlate = false

	if plateCo then
		isShowPlate = data.mo:getShowPlate()

		if self._plateObj == nil or goutil.isNil(self._plateObj) then
			local mapParent2 = UnityEngine.GameObject.Find("dachangjing")

			if not mapParent2 then
				settimer(0.2, function()
					self:updateData(data)
				end, self, false)

				return
			end

			if data.sceneType == 1 then
				settimer(self:getPlateIndex() * 0.02, function()
					self._plateObj = mapMgr:getPlateIns(plateCo.id)
					self._plateObj.name = self._plateObj.name .. data.coordinateStr

					self._plateObj.transform:SetParent(mapParent2.transform, false)

					local blockChild = self._plateObj.transform:GetChild(0):GetChild(0)

					blockChild.name = "block"
					self._plateObj.transform.position = tra.position
					self._plateUnitCompObjs = plateMgr:generatePlateObj(self._plateObj)

					goutil.setActive(self._plateObj, isShowPlate)

					for k, v in pairs(self._plateUnitCompObjs) do
						v:setLightActive(self:getIsMinDisWithCurPoint())
					end
				end, self, false)
			end
		end

		if self._plateObj and not self._inEnterAni then
			goutil.setActive(self._plateObj, isShowPlate)

			for k, v in pairs(self._plateUnitCompObjs) do
				v:setLightActive(self:getIsMinDisWithCurPoint())
			end
		end
	end

	if not isShowPlate and self._plateObj ~= nil then
		goutil.setActive(self._plateOb, false)
	end

	if goutil.isNil(self._planeEmpty) then
		self._planeEmpty = mapMgr:getPlaneEmptyIns()

		self._planeEmpty.transform:SetParent(tra, false)

		self._planeEmpty.transform.localPosition = Vector3.New(0, 0, 0)
		self._planeEmptyAni = self._planeEmpty:GetComponent(ComponentType.Animator)

		goutil.setActive(self._planeEmpty, false)
	end

	local plateMo = data.mo:getPlateMo()
	local isPlateMoShow = plateMo and plateMo:getShowPlate()
	local isPlaneEmptyShow = data.mo:getIsQuestion() and not isPlateMoShow and not RoguelikeModel.instance:getIsInSecondRoom()

	if not isPlaneEmptyShow and data.mo:getIsVisible() and not isShowPlate and not isPlateMoShow then
		isPlaneEmptyShow = true
	end

	if RoguelikeModel.instance:getIsInSecondRoom() or data.mo:getIsInNearArea() or RoguelikeModel.instance:getCurMapIsFixed() then
		isPlaneEmptyShow = false
	end

	isPlaneEmptyShow = false

	if not self._planeEmpty.activeInHierarchy and isPlaneEmptyShow then
		goutil.setActive(self._planeEmpty, isPlaneEmptyShow)
		self._planeEmptyAni:Play("enter")
	elseif self._planeEmpty.activeInHierarchy and not isPlaneEmptyShow then
		self._planeEmptyAni:Play("exit")
		settimer(0.6, self._delayHidePlaneEmpty, self, false)
	end

	local breakPos = {}

	if data.visible and not isPlaneEmptyShow and data.cellInfo then
		local cell = data.cellInfo
		local matchKey = "1"

		if cell.up == matchKey then
			table.insert(breakPos, {
				1,
				Vector3.New(0, 0, 0.9)
			})
		end

		if cell.down == matchKey then
			table.insert(breakPos, {
				1,
				Vector3.New(0, 0, -1.1)
			})
		end

		if cell.left == matchKey then
			table.insert(breakPos, {
				2,
				Vector3.New(-0.9, 0, -0.5)
			})
		end

		if cell.right == matchKey then
			table.insert(breakPos, {
				2,
				Vector3.New(1, 0, -0.5)
			})
		end
	end

	if self._blockObjs == nil and #breakPos > 0 then
		self._blockObjs = {}
		self._blockTargets = {}

		for k, v in pairs(breakPos) do
			local go = Astral.GameObjectUtil.AddNewChildToParent(tra.gameObject, "block" .. k)

			go.transform.localPosition = v[2]

			local plateObj = RogueUnitCompPlateObj.New(go)

			plateObj:loadAsset("block", v[1])
			table.insert(self._blockObjs, go)
			table.insert(self._blockTargets, plateObj)
		end
	end

	if self._mapRole ~= nil then
		goutil.setActive(self._mapRole.go, data.visible and not data.isCurRoom and not data.isFinish)
	end

	local isShowMapRole, mapModelId, plotId = data.mo:getShowMapRole()

	if isShowMapRole and self._mapRole == nil then
		self._mapRole = RogueMapGenerator.createMapRole()

		self._mapRole.go.transform:SetParent(tra, false)

		self._mapRole.go.transform.localPosition = Vector3.New(0, 0, 0)

		local modelCO = ModelConfig.instance:getModelConfig(mapModelId)

		self._mapRole.meshModel:setBody(GameUrl.getRoguelikeMeshModelUrl(modelCO.rogueResName))

		self._plotId = plotId

		local dir = self._mapRole.go.transform.position.x < mapMgr:getMapRole().go.transform.position.x and UnitSpineDir.Right or UnitSpineDir.Left

		self._mapRole.meshModel:setDirection(dir)

		self._pointType2.transform.localScale = Vector3.New(0.5, 0.5, 0.5)
		self._pointType2.transform.localPosition = Vector3.New(0, 0, -0.7)

		goutil.setActive(self._pointType2, false)
		goutil.setActive(self._mapRole.go, data.visible and not data.isCurRoom and not data.isFinish)

		if data.visible and not data.isCurRoom and not data.isFinish then
			settimer(0.2, function()
				self._mapRole.meshModel:play(RoguelikeConst.ROGUE_ROLE_ANI.FALL, false, true)
				settimer(0.75, function()
					if self._aniPointType ~= nil then
						goutil.setActive(self._pointType2, true)
						self._aniPointType:Play("point_type2_open2")
					end
				end, self, false)
			end, self, false)
		end
	end

	local lipai, offset = data.mo:getShowMapLiPai()

	if lipai ~= nil and self._mapLiPai == nil and data.visible and not data.isCurRoom then
		self._mapLiPai = RogueMapGenerator.createMapModel()

		self._mapLiPai.go.transform:SetParent(tra, false)

		self._mapLiPai.go.transform.localPosition = Vector3.New(0, 0, 0)

		self._mapLiPai.meshModel:setBody(GameUrl.getRoguelikeMeshModelUrl(data.mo:getShowMapLiPai()))
		self._mapLiPai.meshModel:setDirection(UnitSpineDir.Right)

		self._pointType2.transform.localScale = Vector3.New(offset[1], offset[1], offset[2])
		self._pointType2.transform.localPosition = Vector3.New(0, offset[3], offset[4])
	end

	if data.isCurRoom then
		self:setPointActive(false)
	end
end

function M:getMapRole()
	return self._mapRole
end

function M:getMapLiPai()
	return self._mapLiPai
end

function M:getNeedShowPlot()
	return false
end

local kMinDistance = 2

function M:getIsMinDisWithCurPoint()
	local roomMo = RoguelikeModel.instance:getCurRoomMo()

	if roomMo then
		local pos = RoguelikeModel.instance:getCurRoomMo():getCoordinate()
		local shapeCo = self._data.mo:getShapeCo()

		if shapeCo then
			local links = shapeCo.link or {}
			local coordinats = {}

			for i = 1, #links, 2 do
				table.insert(coordinats, {
					links[i],
					links[i + 1]
				})
			end

			local coordinate = self._data.mo:getCoordinate()

			for k1, v1 in pairs(coordinats) do
				local x, y = v1[1], v1[2]

				if math.abs(coordinate[1] + x - pos[1]) <= kMinDistance and math.abs(coordinate[2] + y - pos[2]) <= kMinDistance then
					return true
				end
			end

			if math.abs(coordinate[1] - pos[1]) <= kMinDistance and math.abs(coordinate[2] - pos[2]) <= kMinDistance then
				return true
			end
		end
	end

	return false
end

function M:_delayHidePlaneEmpty()
	if not goutil.isNil(self._planeEmpty) then
		goutil.setActive(self._planeEmpty, false)
	end
end

function M:showBlockAnimation(tra, callback)
	local endRotate = Vector3.New(5, 0, 5)
	local rotateDuration = 0.6
	local traDuration = 0.4
	local time = 5
	local pos = tra.localPosition

	tra.localPosition = Vector3.New(pos.x, pos.y - math.random(10, 15), pos.z)

	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:Append(tra:DOLocalRotate(endRotate, rotateDuration / time * 2))
	sequence:Append(tra:DOLocalRotate(Vector3.New(math.random(-4, 4), math.random(-2, 2), math.random(-4, 4)), rotateDuration / time))
	sequence:Append(tra:DOLocalRotate(Vector3.zero, rotateDuration / time))
	sequence:Append(tra:DOLocalMove(pos, 0.1))
	sequence:AppendCallback(self.onBlockAniFinish, self)

	self._aniTween = sequence
end

function M:onBlockAniFinish()
	TweenUtil.killTween(self._aniTween)
end

return M
