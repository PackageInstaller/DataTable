local util = {}

function util.handle(method, binder)
  return handler(binder, method)
end

function util.isValid(obj)
  return obj ~= nil and not obj:IsNull()
end

function util.setObjActive(obj, active)
  if not util.isValid(obj) then
    return
  end
  if obj.gameObject.activeSelf == active then
    return
  end
  obj.gameObject:SetActive(active)
  return true
end

function util.getGameObject(name, isCreate)
  local go = Unity.GameObject.Find(name)
  if isCreate ~= false and not util.isValid(go) then
    go = Unity.GameObject(name)
  end
  return go
end

function util.setLayer(go, layerID)
  go.gameObject:SetLayerWithChildren(layerID)
end

function util.compareLayer(go, layerID)
  return go.gameObject.layer == layerID
end

function util.dicToTable(csharpDic)
  local dic = {}
  local index = 1
  local iter = csharpDic:GetEnumerator()
  while iter:MoveNext() do
    local v = iter.Current.Value
    dic[iter.Current.Key] = v
    index = index + 1
  end
  return dic
end

function util.getClip(animator, clipName)
  local runController = animator.runtimeAnimatorController
  local clips = util.isValid(runController) and runController.animationClips
  if clips and clips.Length > 0 then
    for i = 0, clips.Length - 1 do
      local clip = clips[i]
      if clip.name == clipName then
        return clip
      end
    end
  end
end

function util.rotateV2(x, y, angle)
  local sin = math.sin(angle)
  local cos = math.cos(angle)
  return x * cos + y * sin, x * -sin + y * cos
end

function util.setGray(trans, isGray)
  util._gray(trans, isGray)
end

function util._gray(trans, isGray)
  local img = trans:GetComponent(typeof(C_LImage))
  if img then
  else
    local txt = trans:GetComponent(typeof(C_LTextMeshProUGUI))
    if txt then
    end
  end
  if trans.childCount > 0 then
    for i = 0, trans.childCount - 1 do
      util._gray(trans:GetChild(i), isGray)
    end
  end
end

function util.findTranByName(name, tran)
  local function _find(t)
    local target = t:Find(name)
    
    if target == nil then
      local count = t.childCount - 1
      for i = 0, count do
        local child = t:GetChild(i)
        local find = _find(child)
        if find ~= nil then
          return find
        end
      end
    end
    return target
  end
  
  return _find(tran)
end

function util.findTranByType(type, tran)
  local function _find(t)
    local target = t:GetComponent(type)
    
    if not util.isValid(target) then
      local count = t.childCount - 1
      for i = 0, count do
        local child = t:GetChild(i)
        local find = _find(child)
        if util.isValid(find) then
          return find
        end
      end
    end
    return t
  end
  
  return _find(tran)
end

function util.getTextToLua(strPath, isBytes)
  local str
  if isBytes then
    str = C_LuaUtility.LoadBytes(strPath)
  else
    str = C_LuaUtility.LoadTexts(strPath)
  end
  return string.toTable(str)
end

function util.transformPoint(targetPos, targetRot, offset)
  local r3 = C_Vector3(targetRot.x, targetRot.y, targetRot.z)
  local o3 = C_Vector3(offset.x, offset.y, offset.z)
  local point = Unity.Quaternion.Euler(r3.x, r3.y, r3.z) * o3
  return point + targetPos
end

function util.getIsInRange(owner, target, dis, angle)
  local isInRange = true
  if angle and angle ~= 360 then
    local posA = owner.forward
    local posB = target.position
    posA.y = 0
    posB.y = 0
    local ag = C_Vector3.Angle(posA, posB)
    isInRange = ag <= angle * 0.5
  end
  return isInRange and dis ~= nil and dis >= C_Vector3.Distance(owner.position, target.position)
end

function util.getPosIsInRange(owner, pos, dis, angle)
  local isInRange = true
  if angle and angle ~= 360 then
    local posA = owner.forward
    local posB = pos
    posA.y = 0
    posB.y = 0
    local ag = C_Vector3.Angle(posA, posB)
    isInRange = ag <= angle * 0.5
  end
  return isInRange and dis ~= nil and dis >= C_Vector3.Distance(owner.position, target.position)
end

function util.uiPosRot(uiPos, angle)
  local tempX = uiPos.x
  local tempY = uiPos.y
  local tempRot = math.rad(360 - angle)
  local rotX = tempX * math.cos(tempRot) - tempY * math.sin(tempRot)
  local rotY = tempX * math.sin(tempRot) + tempY * math.cos(tempRot)
  return C_Vector2(rotX, rotY)
end

function util.vector3ToStr(vector3, flag)
  return table.concat({
    vector3.x or 0,
    vector3.y or 0,
    vector3.z or 0
  }, flag or ",")
end

function util.numberToBool(num)
  if num == nil then
    return
  end
  local res = {}
  while num / 2 > 0 do
    table.insert(res, num % 2 == 1)
    num = num >> 1
  end
  return res
end

function util.enumToNum(enum)
  return enum:GetHashCode()
end

function util.commonSort(list, sortKeyList)
  table.sort(list, function(a, b)
    for i, v in ipairs(sortKeyList) do
      if a[v.key] == b[v.key] then
      elseif v.isDesc then
        return a[v] > b[v]
      else
        return a[v] < b[v]
      end
    end
    return false
  end)
end

function util.setLocalValue(key, value)
  C_PlayerPrefsUtility.SetString(string.format("%s_%s", L_PlayerStore:getPlayerId(), tostring(key)), tostring(value))
end

function util.getLocalValue(key)
  local totalKey = string.format("%s_%s", L_PlayerStore:getPlayerId(), tostring(key))
  local has = C_PlayerPrefsUtility.HasKey(totalKey)
  if has then
    local res = C_PlayerPrefsUtility.GetString(totalKey)
    return res
  end
  return nil
end

function util.setLocalBoolValue(key, value)
  C_PlayerPrefsUtility.SetBool(string.format("%s_%s", L_PlayerStore:getPlayerId(), tostring(key)), value)
end

function util.getLocalBoolValue(key)
  local totalKey = string.format("%s_%s", L_PlayerStore:getPlayerId(), tostring(key))
  local has = C_PlayerPrefsUtility.HasKey(totalKey)
  if has then
    local res = C_PlayerPrefsUtility.GetBool(totalKey)
    return res
  end
  return nil
end

function util.getLocalValueByDefault(key, default)
  local totalKey = string.format("%s_%s", L_PlayerStore:getPlayerId(), tostring(key))
  local res = C_PlayerPrefsUtility.GetString(totalKey, default)
  return res
end

function util.hasLocalValue(key)
  local totalKey = string.format("%s_%s", L_PlayerStore:getPlayerId(), tostring(key))
  if C_PlayerPrefsUtility.HasKey(totalKey) then
    return true
  end
  return false
end

function util.setGlobalValue(key, value)
  C_PlayerPrefsUtility.SetString(tostring(key), tostring(value))
end

function util.getGlobalValue(key)
  if C_PlayerPrefsUtility.HasKey(tostring(key)) then
    return C_PlayerPrefsUtility.GetString(tostring(key))
  end
  return nil
end

function util.getGlobalValueByDefault(key, default)
  return C_PlayerPrefsUtility.GetString(tostring(key), default)
end

function util.clearLocalValue(key)
  C_PlayerPrefsUtility.DeleteKey(L_PlayerStore:getPlayerId() .. "_" .. tostring(key))
end

function util.multipleSort(t, funcList)
  table.sort(t, function(a, b)
    for _, valueFunc in ipairs(funcList) do
      if valueFunc(a) ~= valueFunc(b) then
        return valueFunc(a) > valueFunc(b)
      end
    end
    return false
  end)
end

function util.multipleSortByKey(t, keyList)
  local isAscs = {}
  keyList = table.clone(keyList)
  for i, key in ipairs(keyList) do
    isAscs[i] = string.sub(key, 1, 1) == "-"
    if isAscs[i] then
      keyList[i] = string.sub(key, 2, string.len(key))
    end
  end
  table.sort(t, function(a, b)
    if a == nil or b == nil then
      return false
    end
    for i, key in ipairs(keyList) do
      if a[key] ~= nil and b[key] ~= nil and a[key] ~= b[key] then
        if isAscs[i] then
          return a[key] < b[key]
        else
          return a[key] > b[key]
        end
      end
    end
    return false
  end)
end

function util.getModComponent(tType, go)
  local modControl = go:GetComponent(typeof(C_ModelControl))
  local t = modControl:GetComponentByType(tType)
  return t
end

function util.csListToTable(list)
  local result = {}
  if list and list.Count > 0 then
    for i = 0, list.Count - 1 do
      table.insert(result, list[i])
    end
  end
  return result
end

function util.toBoolean(val)
  if val then
    if type(val) == "number" and val == 0 then
      return false
    end
    return true
  else
    return false
  end
end

function util.deepClone(object)
  local lookup_table = {}
  
  local function _copy(object)
    if type(object) ~= "table" then
      return object
    elseif lookup_table[object] then
      return lookup_table[object]
    end
    local new_table = {}
    lookup_table[object] = new_table
    for key, value in pairs(object) do
      new_table[_copy(key)] = _copy(value)
    end
    return setmetatable(new_table, getmetatable(object))
  end
  
  return _copy(object)
end

function util.getMultiPlatformScenePath(scenePath)
  return string.gsub(scenePath, "UIScene", C_AppConfigManager.IsMobilePlatformForUI and "UIScene/Mobile" or "UIScene/Standlone")
end

function util.reverseList(arr)
  if type(arr) ~= "table" or #arr <= 1 then
    return arr
  end
  local i = 1
  local j = #arr
  while i < j do
    arr[i], arr[j] = arr[j], arr[i]
    i = i + 1
    j = j - 1
  end
  return arr
end

return util
