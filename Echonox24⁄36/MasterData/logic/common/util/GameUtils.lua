-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/GameUtils.lua

module("logic.common.util.GameUtils", package.seeall)

local M = class("GameUtils")

function tableMO(super)
	local M = {}

	M.__index = M

	if super and type(super) == "table" then
		M.__newindex = super.__newindex
	else
		function M.__newindex(t, key, value)
			if type(value) == "userdata" or type(value) == "function" then
				error("tableMO instance object field not support userdata or function,key=" .. key)
			else
				rawset(t, key, value)
			end
		end
	end

	function M.ctor(object)
		return
	end

	function M.New()
		local object = {}

		setmetatable(object, M)
		M.ctor(object)

		return object
	end

	setmetatable(M, {
		__index = super,
		__newindex = function(t, key, value)
			if type(value) ~= "function" then
				error("tableMO table only support function!key=" .. key)
			else
				rawset(t, key, value)
			end
		end
	})

	return M
end

setglobal("tableMO", tableMO)

M.json = require("cjson")

local originJsonDecode = require("cjson").decode

function M.json.decode(...)
	local args = {
		...
	}
	local string = unpack(args, 1)

	if M.isEmptyString(string) then
		return {}, false
	end

	local ok, jsonTable = pcall(originJsonDecode, ...)

	if not ok then
		forcePrint(string.format("jsonString:%s decode error", tostring(string)))

		return {}, false
	end

	return jsonTable, true
end

function M.isString(value)
	return type(value) == "string"
end

function M.isFunction(f)
	return type(f) == "function"
end

function M.isTable(value)
	return type(value) == "table"
end

function M.isNumber(value)
	return type(value) == "number"
end

function M.isEmptyString(str)
	if str == nil or M.isString(str) and string.gsub(str, "^%s*(.-)%s*$", "%1") == "" then
		return true
	end

	return false
end

function M.isBitOpenByDigit(num, digit)
	if digit >= 0 then
		if num < 0 then
			num = 4294967295 + num + 1
		end

		local mask = 2^digit
		local mod = num % (2 * mask)

		if mask <= mod then
			return true
		end
	end

	return false
end

function M.getOpenBitCount(value)
	value = value < 0 and 4294967295 + value + 1 or value

	local ret, mask, mod = 0, 1

	for i = 1, 32 do
		mask = mask * 2
		mod = value % mask

		if mod ~= 0 then
			value = value - mod
			ret = ret + 1
		end
	end

	return ret
end

function M.getValueByOpenBitCount(bitCount)
	bitCount = bitCount > 32 and 32 or bitCount

	local ret = 2^bitCount - 1

	return ret
end

function M.setPos(go, x, y, z)
	if goutil.isNil(go) == false then
		Astral.TransformUtil.SetPos(go.transform, x, y, z)
	end
end

function M.getPos(go)
	if go and not goutil.isNil(go) then
		return Astral.TransformUtil.GetPos(go.transform, 0, 0, 0)
	end

	return 0, 0, 0
end

function M.setLocalPos(go, x, y, z)
	if goutil.isNil(go) == false then
		Astral.TransformUtil.SetLocalPos(go.transform, x, y, z)
	end
end

function M.getLocalPos(go)
	if go then
		return Astral.TransformUtil.GetLocalPos(go.transform, 0, 0, 0)
	end

	return 0, 0, 0
end

function M.setLocalScale(go, x, y, z)
	if go then
		Astral.TransformUtil.SetLocalScale(go.transform, x, y, z)
	end
end

function M.getLocalScale(go)
	if go then
		return Astral.TransformUtil.GetLocalScale(go.transform, 0, 0, 0)
	end
end

function M.setLocalRotation(go, x, y, z)
	if not goutil.isNil(go) then
		Astral.TransformUtil.SetLocalRotation(go.transform, x, y, z)
	end
end

function M.setRotation(go, x, y, z, w)
	if not goutil.isNil(go) then
		Astral.TransformUtil.SetRotation(go.transform, x, y, z, w)
	end
end

function M.getLocalRotation(go)
	if not goutil.isNil(go) then
		return Astral.TransformUtil.GetLocalRotation(go.transform, 0, 0, 0)
	end
end

function M.setAnchorX(rectTransform, value)
	Astral.GeometryUtil.SetAnchorPosX(rectTransform, value)
end

function M.getAnchorX(rectTransform)
	local x, y = Astral.TransformUtil.GetAnchoredPos(rectTransform, 0, 0)

	return x
end

function M.setAnchorY(rectTransform, value)
	Astral.GeometryUtil.SetAnchorPosY(rectTransform, value)
end

function M.getAnchorY(rectTransform)
	local x, y = Astral.TransformUtil.GetAnchoredPos(rectTransform, 0, 0)

	return y
end

function M.setAnchorXY(rectTransform, x, y)
	Astral.TransformUtil.SetAnchoredPos(rectTransform, x, y)
end

function M.getAnchorXY(rectTransform)
	return Astral.TransformUtil.GetAnchoredPos(rectTransform, nil, nil)
end

function M.setPivot(rectTransform, x, y)
	RectTransformUtils.SetPivot(rectTransform, x or 0, y or 0)
end

function M.getPivot(rectTransform)
	return RectTransformUtils.GetPivot(rectTransform, 0, 0)
end

function M.getCanvasXY(rectTransform)
	local uicanvas = ViewMgr.instance:getUICanvas()
	local v2 = Astral.GeometryUtil.LocalToCanvasPos(rectTransform, uicanvas)

	return v2.x, v2.y
end

function M.getStrLen(str)
	if M.isEmptyString(str) then
		return 0
	end

	local count = #str
	local strLen = 0

	for i = 1, count do
		local byte = string.byte(str, i)

		if byte > 0 and byte <= 127 then
			strLen = strLen + 1
		elseif byte >= 192 and byte <= 239 then
			strLen = strLen + 2
			i = i + 2
		end
	end

	return strLen
end

function M.getUCharList(ucharStr)
	if M.isEmptyString(ucharStr) then
		return
	end

	local ucharList = {}

	for uchar in string.gmatch(ucharStr, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
		if M.isEmptyString(uchar) == false then
			table.insert(ucharList, uchar)
		end
	end

	return ucharList
end

function M.getBriefName(str, charCount, suffix)
	if M.isEmptyString(str) then
		return ""
	end

	local charLen = M.getStrLen(str)

	if charLen <= charCount then
		return str
	end

	local ucharList = M.getUCharList(str)

	if ucharList == nil or #ucharList <= 0 then
		return ""
	end

	suffix = suffix or "..."

	local newStr = ""
	local counter = 0

	for i = 1, #ucharList do
		local byte = string.byte(ucharList[i])

		if byte > 0 and byte <= 127 then
			counter = counter + 1
		elseif byte >= 192 and byte <= 239 then
			counter = counter + 2
		end

		if counter <= charCount then
			newStr = newStr .. ucharList[i]
		end
	end

	return newStr .. suffix
end

function M.getCharNum(str)
	if M.isEmptyString(str) then
		return 0
	end

	local count = #str
	local strLen = 0

	for i = 1, count do
		local byte = string.byte(str, i)

		if byte > 0 and byte <= 127 then
			strLen = strLen + 1
		elseif byte >= 192 and byte <= 239 then
			strLen = strLen + 1
			i = i + 2
		end
	end

	return strLen
end

function M.getSpineDir(isDefault)
	return isDefault and UnitSpineDir.Default or UnitSpineDir.Left
end

function M.setUIWidth(rectTransform, value)
	Astral.GeometryUtil.SetWidth(rectTransform, value)
end

function M.getUIWidth(rectTransform)
	return Astral.GeometryUtil.GetWidth(rectTransform)
end

function M.setUIHeight(rectTransform, value)
	Astral.GeometryUtil.SetHeight(rectTransform, value)
end

function M.getUIHeight(rectTransform)
	return Astral.GeometryUtil.GetHeight(rectTransform)
end

function M.copyRectTransform(distTrans, orgTrans)
	if goutil.isNil(distTrans) or goutil.isNil(orgTrans) then
		return
	end

	M.setAnchorXY(distTrans, M.getAnchorX(orgTrans), M.getAnchorY(orgTrans))

	distTrans.anchorMax = orgTrans.anchorMax
	distTrans.anchorMin = orgTrans.anchorMin
	distTrans.offsetMax = orgTrans.offsetMax
	distTrans.offsetMin = orgTrans.offsetMin
	distTrans.pivot = orgTrans.pivot

	local rotationX, rotationY, rotationZ = M.getLocalRotation(orgTrans)

	M.setLocalRotation(distTrans, rotationX, rotationY, rotationZ)

	local scaleX, scaleY, scaleZ = M.getLocalScale(orgTrans)

	M.setLocalScale(distTrans, scaleX, scaleY, scaleZ)
end

function M.copyRawImage(distRawImg, orgRawImg)
	if goutil.isNil(distRawImg) or goutil.isNil(orgRawImg) then
		return
	end

	distRawImg.material = orgRawImg.material
	distRawImg.texture = orgRawImg.texture
	distRawImg.uvRect = orgRawImg.uvRect
	distRawImg.raycastTarget = orgRawImg.raycastTarget
	distRawImg.color = orgRawImg.color
end

function M.setLayer(go, layer, deep)
	if not deep then
		go.layer = layer

		return
	end

	Astral.GameObjectUtil.SetLayerRecursively(go, layer)
end

function M.setLayerByName(go, layerName, deep)
	local layer = M.nameToLayer(layerName)

	M.setLayer(go, layer, deep)
end

function M.nameToLayer(layerName)
	return LayerMask.NameToLayer(layerName)
end

function M.nameToLayerMask(...)
	return Astral.LayerUtil.GetLayerMask(...)
end

function M.rayScreenPoint(screenPoint, maxDistance, layerMask)
	local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCamera = mainCameraTarget and mainCameraTarget:getCamera()

	if not mainCamera then
		return
	end

	maxDistance = maxDistance or 50

	local ray = mainCamera:ScreenPointToRay(screenPoint)
	local isHit, hitInfo

	if layerMask then
		isHit, hitInfo = UnityEngine.Physics.Raycast(ray, nil, maxDistance, layerMask)
	else
		isHit, hitInfo = UnityEngine.Physics.Raycast(ray, nil, maxDistance)
	end

	if not isHit then
		return
	end

	return hitInfo.point, hitInfo.transform
end

function M.rayScreenAllHitInfos(screenPoint, maxDistance, layerMask)
	local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCamera = mainCameraTarget and mainCameraTarget:getCamera()

	if not mainCamera then
		return
	end

	maxDistance = maxDistance or 50

	local ray = mainCamera:ScreenPointToRay(screenPoint)
	local isHit, hitInfos

	if layerMask then
		hitInfos = UnityEngine.Physics.RaycastAll(ray, maxDistance, layerMask)
	else
		hitInfos = UnityEngine.Physics.RaycastAll(ray, maxDistance)
	end

	isHit = hitInfos and hitInfos.Length > 0

	if not isHit then
		return
	end

	return hitInfos
end

function M.setLocalString(key, value)
	Astral.LocalStorage.Instance:SetString(key, value)
end

function M.getLocalString(key, defValue)
	return Astral.LocalStorage.Instance:GetString(key, defValue or "")
end

function M.setLocalFloat(key, value)
	Astral.LocalStorage.Instance:SetFloat(key, value)
end

function M.getLocalFloat(key, defValue)
	return Astral.LocalStorage.Instance:GetFloat(key, defValue or 0)
end

function M.setLocalInt(key, value)
	Astral.LocalStorage.Instance:SetInt(key, value)
end

function M.getLocalInt(key, defValue)
	return Astral.LocalStorage.Instance:GetInt(key, defValue or 0)
end

function M.getActiveSceneComponents(componentType)
	local gameObjects = SceneUtils.GetActiveSceneRootGameObjects()

	if gameObjects == nil or gameObjects.Length == 0 then
		return
	end

	local components = {}

	for i = 0, gameObjects.Length - 1 do
		local _components = gameObjects[i]:GetComponentsInChildren(componentType)

		if _components and _components.Length > 0 then
			for j = 0, _components.Length - 1 do
				table.insert(components, _components[j])
			end
		end
	end

	return components
end

function M.getChineseNum(str)
	if M.isEmptyString(str) then
		return 0
	end

	local count = #str
	local strLen = 0

	for i = 1, count do
		local byte = string.byte(str, i)

		if byte >= 192 and byte <= 239 then
			strLen = strLen + 1
			i = i + 2
		end
	end

	return strLen
end

function M.checkIsContainPunctuation(str)
	if M.isEmptyString(str) then
		return false
	end

	local count = #str
	local k = 1

	for i = 1, count do
		local byte = string.byte(str, k)

		if byte then
			if byte >= 48 and byte <= 57 or byte >= 65 and byte <= 90 or byte >= 97 and byte <= 122 then
				k = k + 1
			elseif byte >= 228 and byte <= 233 then
				k = k + 3
			else
				return true
			end
		end
	end

	return false
end

function M.getBriefName(str, charCount, suffix)
	if M.isEmptyString(str) then
		return ""
	end

	local charLen = M.getStrLen(str)

	if charLen <= charCount then
		return str
	end

	local ucharList = M.getUCharList(str)

	if ucharList == nil or #ucharList <= 0 then
		return ""
	end

	suffix = suffix or "..."

	local newStr = ""
	local counter = 0

	for i = 1, #ucharList do
		local byte = string.byte(ucharList[i])

		if byte > 0 and byte <= 127 then
			counter = counter + 1
		elseif byte >= 192 and byte <= 239 then
			counter = counter + 2
		end

		if counter <= charCount then
			newStr = newStr .. ucharList[i]
		end
	end

	return newStr .. suffix
end

function M.getTargetChilds(targetView, gameObjKey, container, isCell)
	if M.isEmptyString(gameObjKey) then
		return
	end

	local childs = {}
	local scripts = {}
	local goTarget

	if not isCell then
		goTarget = targetView:getGo(gameObjKey)
	else
		goTarget = targetView:findUIElement(gameObjKey)
	end

	for i = 1, goTarget.transform.childCount do
		local child = goTarget.transform:GetChild(i - 1)

		if child then
			table.insert(childs, child.gameObject)

			if container ~= nil then
				local luaScript = Astral.LuaComponentContainer.Add(child.gameObject, container)

				if luaScript then
					table.insert(scripts, luaScript)
				end
			end
		end
	end

	return childs, scripts
end

function M.getNonBreakingSpaceStr(str)
	local _str = string.gsub(str, " ", " ")

	return _str
end

function M.getIntegerLimit(printFunc, fmt)
	local floor = math.floor
	local step = 2
	local count = 1

	while true do
		local nextstep = step * 2

		if nextstep - (nextstep - 1) == 1 and nextstep > 0 then
			step = nextstep
			count = count + 1
		else
			break
		end
	end

	local limit, step = step, floor(step / 2)

	while step > 0 do
		local nextlimit = limit + step

		if nextlimit - (nextlimit - 1) == 1 and nextlimit > 0 then
			limit = nextlimit
		end

		step = floor(step / 2)
	end

	if printFunc then
		fmt = fmt or "bitCount=%d integetLimit=%.0f"

		printFunc(string.format(fmt, count, limit))
	end

	return limit
end

function M.findChild(transform, name, recursive)
	local childCount = transform.childCount

	for i = 1, childCount do
		local child = transform:GetChild(i - 1)

		if child.name == name then
			return child
		end

		if recursive and child.childCount > 0 then
			child = M.findChild(child, name, recursive)

			if child then
				return child
			end
		end
	end
end

function M.getScreenAspectRatio()
	return UnityEngine.Screen.width / UnityEngine.Screen.height
end

function M.isInUIRange(pos, rectTransform)
	if not pos or not rectTransform then
		return false
	end

	pos = goutil.screenToLocalPos(pos, rectTransform.parent.transform)

	local width = GameUtils.getUIWidth(rectTransform)
	local height = GameUtils.getUIHeight(rectTransform)
	local x, y, z = GameUtils.getLocalPos(rectTransform.gameObject)
	local minX = x - width / 2
	local maxX = x + width / 2
	local minY = y - height / 2
	local maxY = y + height / 2

	if minX > pos.x or maxX < pos.x then
		return false
	end

	if minY > pos.y or maxY < pos.y then
		return false
	end

	return true
end

function M.changeDebugState(value)
	setglobal("enableLog", value)
	setglobal("enableWarnLog", value)
	setglobal("enableDebug", value)

	Astral.LogManager.enableLog = value
	Astral.LogManager.enableWarnLog = value
	Astral.LogManager.enableErrorLog = value
	Astral.LogManager.isDebugBuild = value
end

function M.setImageGray(image, isGray)
	if not image then
		return
	end

	local ColorWhite = "#FFFFFFFF"
	local ColorGray = "#FFFFFF33"

	if isGray then
		local grayMat = CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.UIGray)

		image.material = grayMat
		image.color = parsecolor(ColorGray)
	else
		image.material = nil
		image.color = parsecolor(ColorWhite)
	end
end

return M
