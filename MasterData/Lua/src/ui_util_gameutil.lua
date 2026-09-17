local util = {httpMaskIndex = 0}

function util.getHeroModelConstId()
  return L_PlayerStore:getSex() == L_Const.sexType.male and 9999998 or 9999999
end

function util.getUnitIdByRole(id, type)
  if id == 0 then
    return
  end
  type = type or L_Const.roleType.hero
  local unitId = id
  if type == L_Const.roleType.hero then
    if id == util.getDefaultHeroId(L_Const.sexType.female) then
      unitId = L_GameConstTpl:getFemaleDefaultHeroUnitId()
    elseif id == util.getDefaultHeroId(L_Const.sexType.male) then
      unitId = L_GameConstTpl:getMaleDefaultHeroUnitId()
    else
      local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
      local clothing = heroClothingTpl:getTplById(id)
      unitId = heroClothingTpl:getUnitId(clothing)
    end
  elseif type == L_Const.roleType.boss then
    local bossTpl = L_GameTpl:getBossTpl()
    local tpl = bossTpl:getTplById(id)
    unitId = bossTpl:getUnitId(tpl)
  elseif type == L_Const.roleType.pet then
    local petInfoTpl = L_GameTpl:getPetTpl()
    local tpl = petInfoTpl:getTplById(id)
    unitId = petInfoTpl:getUnitID(tpl)
  end
  return unitId
end

function util.fillColor(key, colorKey)
  return string.format("<color=%s>%s</color>", colorKey, tostring(key))
end

function util.clearColor(key)
  if not key then
    return
  end
  local str = key
  if string.find(str, "<color=#(%x+)>") then
    str = string.gsub(str, "<color=#(%x+)>", "")
  end
  if string.find(str, "</color>") then
    str = string.gsub(str, "</color>", "")
  end
  return str
end

function util.setJoyStick(joystick)
  C_JoystickManager.SetPlayerJoystick(joystick)
end

function util.getJoyStick()
  return C_JoystickManager.GetPlayerJoystick()
end

function util.openMask(data, NoInputLock, NoTimePause)
  local targetPageName
  if data.fadeOut and not data.fadeIn then
    local status = L_UI:getPageStatus("pageMask")
    if status and (status == "shown" or status == "opening") then
      targetPageName = "pageMask"
    end
    if not targetPageName then
      status = L_UI:getPageStatus("pageMaskNoTimePause")
      if status and (status == "shown" or status == "opening") then
        targetPageName = "pageMaskNoTimePause"
      end
    end
    if not targetPageName then
      status = L_UI:getPageStatus("pageMaskNoInputLock")
      if status and (status == "shown" or status == "opening") then
        targetPageName = "pageMaskNoInputLock"
      end
    end
    if not targetPageName then
      status = L_UI:getPageStatus("pageMaskFree")
      if status and (status == "shown" or status == "opening") then
        targetPageName = "pageMaskFree"
      end
    end
    if not targetPageName then
      targetPageName = "pageMask"
    end
  elseif NoInputLock then
    if NoTimePause then
      targetPageName = "pageMaskFree"
    else
      targetPageName = "pageMaskNoInputLock"
    end
  elseif NoTimePause then
    targetPageName = "pageMaskNoTimePause"
  else
    targetPageName = "pageMask"
  end
  L_UI:open(targetPageName, data)
end

function util.httpMask(isOpen, desc)
  printf("httpMask", isOpen, desc)
  if isOpen == true then
    if util.httpMaskIndex == 0 then
      L_UI:open("pageHttpWaiting")
    end
    util.httpMaskIndex = util.httpMaskIndex + 1
  else
    util.httpMaskIndex = util.httpMaskIndex - 1
    if util.httpMaskIndex == 0 then
      L_UI:close("pageHttpWaiting")
    end
  end
end

function util.getDefaultHeroId(sexType)
  if sexType == L_Const.sexType.female then
    return L_GameConstTpl:getFemaleDefaultHeroConfigId()
  elseif sexType == L_Const.sexType.male then
    return L_GameConstTpl:getMaleDefaultHeroConfigId()
  end
  local defaultHeroGuid = L_HeroStore:getDefaultHeroGuid()
  local serverData = L_HeroStore:getHero(defaultHeroGuid)
  return serverData == nil and L_GameConstTpl:getFemaleDefaultHeroConfigId() or L_HeroStore:getHeroConfigId(serverData)
end

function util.isDefaultHero(configId)
  return configId == L_GameConstTpl:getMaleDefaultHeroConfigId() or configId == L_GameConstTpl:getFemaleDefaultHeroConfigId()
end

function util.normalizeHeroConfigId(configId, playerId)
  if not util.isDefaultHero(configId) then
    return configId
  end
  playerId = playerId or L_PlayerStore:getPlayerId()
  local baseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
  local wardrobe = baseInfo and baseInfo.wardrobe
  local sex = wardrobe and wardrobe.sex
  if sex == nil then
    return configId
  end
  return util.getDefaultHeroId(sex)
end

function util.getMainHeroPath(sexType)
  if sexType == nil then
    sexType = L_PlayerStore:getSex()
  end
  local path = ""
  if sexType == L_Const.sexType.male then
    path = L_GameConstTpl:getData(L_Const.playerPath.avatarPrefabMalePath, L_Const.GameTplType.string)
  else
    path = L_GameConstTpl:getData(L_Const.playerPath.avatarPrefabFemalePath, L_Const.GameTplType.string)
  end
  return path
end

function util.getAvatarTexturePath(clothingId, index)
  local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
  local clothing = heroClothingTpl:getTplById(clothingId)
  return heroClothingTpl:getAvatarTexture(clothing, index)
end

function util.getAvatarModelPathByUnitId(unitId, index)
  if unitId == L_GameConstTpl:getData("AVATAR_UNIT_ID_FEMALE", L_Const.GameTplType.int) then
    return L_GameConstTpl:getData(L_Const.playerPath.avatarPrefabFemalePath, L_Const.GameTplType.string)
  elseif unitId == L_GameConstTpl:getData("AVATAR_UNIT_ID_MALE", L_Const.GameTplType.int) then
    return L_GameConstTpl:getData(L_Const.playerPath.avatarPrefabMalePath, L_Const.GameTplType.string)
  end
  local unitTpl = L_GameTpl:getUnitTpl()
  return unitTpl:getModel(unitTpl:getTplById(unitId), index)
end

function util.getAnimatorControllerPathByUnitId(unitId, index)
  local unitTpl = L_GameTpl:getUnitTpl()
  return unitTpl:getAnimatorConfig(unitTpl:getTplById(unitId), index)
end

function util.getStrByKey(key)
  local output = L_WordsTpl:getValue(key)
  if string.isEmpty(output) then
    return key
  else
    return output
  end
end

function util.getComponentListAllByType(tran, type)
  local list = {}
  
  local function _find(t)
    local target = t:GetComponent(type)
    if not L_CommonUtil.isValid(target) then
    else
      table.insert(list, target)
    end
    local count = t.childCount - 1
    for i = 0, count do
      local child = t:GetChild(i)
      _find(child)
    end
  end
  
  _find(tran)
  return list
end

function util.findTranByName(gameObject, name)
  local modleControl = gameObject:GetComponent(typeof(C_ModelControl))
  local bindTran
  if modleControl then
    bindTran = modleControl:GetTransByName(name)
  end
  if bindTran == nil then
    bindTran = L_CommonUtil.findTranByName(name, gameObject.transform)
  end
  return bindTran
end

function util.getIsInRange(owner, target, dis, angle)
  local isInRange = true
  local sqrDis = dis * dis
  local abDis = util.getSqrDistance(owner, target)
  if angle and angle ~= 360 then
    local ag = util.getAngleByFwd(owner, target)
    isInRange = ag <= angle * 0.5
    if not isInRange then
      return false, abDis
    end
  end
  isInRange = isInRange and sqrDis >= abDis
  return isInRange, abDis
end

function util.getSkillDesc(skillId, skillLevel)
  skillLevel = skillLevel or 1
  local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
  local tpl_skillLevel = skillLevelTpl:getTplByIdAndLevel(skillId, skillLevel)
  return skillLevelTpl:getSkillDescribe(tpl_skillLevel)
end

function util.getConfigIdByGuid(heroGuid, playerId)
  local hero = L_HeroStore:getHero(heroGuid)
  if hero then
    return L_HeroStore:getHeroConfigId(hero)
  end
  return heroGuid
end

function util.spToLpInRectangle(rectTrans, postion)
  local uiCamera = C_CameraManager.uiCamera
  local _, pos = C_RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTrans, postion, uiCamera)
  return pos and L_Vector3.new(pos.x, pos.y, pos.z)
end

function util.forceRebuildLayout(trans)
  C_GameUtil.ForceRebuildLayout(trans)
end

function util.itemShowNum(n)
  if n < 1000000 then
    return tostring(n)
  elseif n < 1000000000 then
    n = math.floor(n / 100000) / 10
    return string.concat(n, "m")
  else
    n = math.floor(n / 100000000) / 10
    return string.concat(n, "b")
  end
end

function util.checkCanMod()
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.PlayerModChange))
    return false
  end
  if AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
    L_FlyMsgManager:showNormalMsg(L_GameTpl:getWordsTpl():getTplById("notice_mount_unable_change_image"))
    return false
  end
  if L_PlayerManager:inKiBoTransformMainControl() then
    L_FlyMsgManager:showNormalMsg(L_GameTpl:getWordsTpl():getTplById("notice_qibohenshin_unable_change_image"))
    return false
  end
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.CustomizeCharacterImage, true) then
    return false
  end
  return true
end

function util.logEvent(eventName, eventData)
  local eventDataJsonStr = eventData ~= nil and L_Json.encode(eventData) or string.empty
  C_GameUtil.LogEvent(eventName, eventDataJsonStr)
end

function util.LogClientADEvent(eventName, customData)
  if customData == nil then
    C_MJSDKManager.LogEvent(eventName, nil, nil, "{\"channels\":{\"SolarEngine\":{}}}")
    return
  end
  local custom = {
    channels = {
      SolarEngine = {custom_data = customData}
    }
  }
  local customJson = L_Json.encode(custom)
  C_MJSDKManager.LogEvent(eventName, nil, nil, customJson)
end

function util.showCommonTip(data)
  data = data or {}
  C_GameUtil.ShowCommonTipFLua(data)
end

function util.showNetCommonTip(data)
  C_GameUtil.ShowNetCommonTip(data)
end

function util.showNormalTextBox(data)
  data = data or {}
  data.closeCallbackTemp = data.closeCallback
  data.closeCallback = nil
  L_UI:open("pageCommonTextBox", data)
end

function util.showReportPlayerBox(data)
  data = data or {}
  CS.Lens.Gameplay.UI.ReportStore.GetStore():TryOpenReportPlayerBox(data)
end

function util.isUnder2K()
  return C_Screen.height <= 1440 and C_Screen.width <= 2560
end

function util.tableClone(luaTable)
  return table.clone(luaTable)
end

function util.convertValue(data, typeId)
  if data == nil then
    return nil
  end
  local val
  if typeId == L_Const.GameTplType.int then
    val = data.intVal
    val = tonumber(val)
  elseif typeId == L_Const.GameTplType.float then
    val = data.floatVal
    val = tonumber(val)
  elseif typeId == L_Const.GameTplType.string then
    val = data.stringVal
    val = tostring(val)
  elseif typeId == L_Const.GameTplType.list_int then
    val = G_ConfigParser.ParseConfigStr(data.value, G_ConfigConst.ParseType.list, "number")
  elseif typeId == L_Const.GameTplType.list_float then
    val = G_ConfigParser.ParseConfigStr(data.value, G_ConfigConst.ParseType.list, "number")
  elseif typeId == L_Const.GameTplType.list_string then
    val = G_ConfigParser.ParseConfigStr(data.value, G_ConfigConst.ParseType.list, "string")
  elseif typeId == L_Const.GameTplType.list_list_int then
    val = G_ConfigParser.ParseConfigStr(data.value, G_ConfigConst.ParseType.compositeList, "number")
  elseif typeId == L_Const.GameTplType.dict_int_int then
    val = G_ConfigParser.ParseConfigStr(data.value, G_ConfigConst.ParseType.dictionary, "number", "number")
  elseif typeId == L_Const.GameTplType.bool then
    val = data.boolVal
  elseif typeId == L_Const.GameTplType.condition then
    val = G_ConfigParser.ParseConfigStr(data.value, G_ConfigConst.ParseType.listCondition)
  elseif typeId == L_Const.GameTplType.reward then
    val = G_ConfigParser.ParseConfigStr(data.value, G_ConfigConst.ParseType.compositeList, "number")
  end
  return val
end

function util.getIsHadItemListNum(itemList, showTips)
  if table.isEmpty(itemList) then
    return true
  end
  local isHadThroughNum = true
  for _, item in ipairs(itemList) do
    local itemType = item[1]
    local itemId = item[2]
    local itemNum = item[3]
    local hadNum = L_ItemTplManager:getItemNum(itemType, itemId)
    if itemNum > hadNum then
      isHadThroughNum = false
      if showTips then
        local itemConfig = L_ItemTplManager:getItemConfig(itemType, itemId)
        if itemConfig ~= nil and not string.isEmpty(itemConfig.name) then
          local tipStr = L_WordsTpl:getValueParam("hero_rank_levelup_tips", itemConfig.name)
          L_FlyMsgManager:showNormalMsg(tipStr)
        end
      end
      break
    end
  end
  return isHadThroughNum
end

function util.getIsUseUseGiftType(systemJumpId)
  local commonJumpTpl = L_GameTpl:getCommonJumpTpl()
  local jumpCfg = commonJumpTpl:getTplById(systemJumpId)
  if jumpCfg == nil then
    return false
  end
  local jumpType = commonJumpTpl:getType(jumpCfg)
  local result = jumpType == L_Const.commonJumpType.UseGift
  return result
end

function util.getHierarchyPath(go)
  if go == nil then
    return ""
  end
  local transform = go.transform
  local path = transform.name
  while transform.parent ~= nil do
    transform = transform.parent
    path = transform.name .. "/" .. path
  end
  return path
end

function util.checkClothingBlocked()
  return C_GameUtil.CheckClothingBlocked()
end

local avatarReadyRequest = {}
avatarReadyRequest.__index = avatarReadyRequest

function avatarReadyRequest:cancel()
  local biologyData = self.biologyData
  local listener = self.listener
  self.biologyData = nil
  self.listener = nil
  self.onLoaded = nil
  if biologyData and listener then
    biologyData:RemoveAllPartUpdateListener(listener)
  end
end

local function isAllAvatarPartsLoaded(biologyData)
  local partList = biologyData:GetListPart()
  if not partList then
    return false
  end
  local hasPart = false
  for _, part in pairs(partList) do
    if part then
      hasPart = true
      if not part.isLoaded then
        return false
      end
    end
  end
  return hasPart
end

function util.waitAllAvatarPartsLoaded(biologyData, onLoaded)
  local request = setmetatable({biologyData = biologyData, onLoaded = onLoaded}, avatarReadyRequest)
  if not biologyData then
    request.onLoaded = nil
    if onLoaded then
      onLoaded()
    end
    return request
  end
  local listener
  
  function listener()
    if request.listener ~= listener or not isAllAvatarPartsLoaded(biologyData) then
      return
    end
    local callback = request.onLoaded
    request:cancel()
    if callback then
      callback()
    end
  end
  
  request.listener = listener
  biologyData:AddAllPartUpdateListener(listener)
  biologyData:Init()
  listener()
  return request
end

return util
