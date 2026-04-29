_class("ChooseAssistantHelper", Object)
ChooseAssistantHelper = ChooseAssistantHelper

function ChooseAssistantHelper:Constructor()
end

function ChooseAssistantHelper.GetLocalDBStr(isPet, type, id)
  local staticSpineSettings = ChooseAssistantHelper.GetSpineSettings()
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local title
  if isPet then
    title = "MAIN_PET_OFFSET_" .. staticSpineSettings
  else
    title = "MAIN_BG_OFFSET_" .. staticSpineSettings .. "|" .. type .. "|" .. id
  end
  local key = title .. open_id
  return key
end

function ChooseAssistantHelper.GetAssistantPetSetting()
  local dbStr = ChooseAssistantHelper.GetLocalDBStr(true)
  local resPos = Vector2(0, 0)
  local resScale = 1
  local pos_offset_str = LocalDB.GetString(dbStr, "null")
  if pos_offset_str == "null" then
  else
    local strs = string.split(pos_offset_str, "|")
    local x = tonumber(strs[1])
    local y = tonumber(strs[2])
    resPos = Vector2(x, y)
    resScale = tonumber(strs[3])
  end
  return resPos, resScale
end

function ChooseAssistantHelper.GetAssistantPetSize()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local assistantSkinID = roleModule.m_choose_painting.skin_id
  local resPos, resScale = ChooseAssistantHelper.GetAssistantPetSetting()
  local size
  if assistantSkinID and 0 < assistantSkinID then
    local cfg = Cfg.cfg_pet_skin[assistantSkinID]
    if cfg then
      local mainSize = cfg.MainLobbySize
      if mainSize then
        size = Vector2(mainSize[1], mainSize[2])
        local realWidth = ResolutionManager.RealWidth()
        local realHeight = ResolutionManager.RealHeight()
        local safeArea = Vector2(realWidth, realHeight)
        local rate_x = 1
        local rate_y = 1
        if size.x * resScale < safeArea.x then
          rate_x = size.x * resScale / safeArea.x
        end
        if size.y * resScale < safeArea.y then
          rate_y = size.y * resScale / safeArea.y
        end
        if rate_x < 1 or rate_y < 1 then
          local changex = true
          if rate_x < rate_y then
            changex = true
          else
            changex = false
          end
          if changex then
            resScale = resScale / rate_x
          else
            resScale = resScale / rate_y
          end
        end
      end
    end
  end
  return size
end

function ChooseAssistantHelper.SaveAssistantPetSetting(pos, scale)
  local dbStr = ChooseAssistantHelper.GetLocalDBStr(true)
  local value = pos.x .. "|" .. pos.y .. "|" .. scale
  LocalDB.SetString(dbStr, value)
end

function ChooseAssistantHelper.GetAssistantBgSetting(type, id)
  local dbStr = ChooseAssistantHelper.GetLocalDBStr(false, type, id)
  local resPos = Vector2(0, 0)
  local resScale = 1
  local pos_offset_str = LocalDB.GetString(dbStr, "null")
  if pos_offset_str == "null" then
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pos = Vector2(roleModule.m_choose_painting.background_x, roleModule.m_choose_painting.background_y)
    resPos = pos
    if roleModule.m_choose_painting.background_scale ~= 0 then
      resScale = roleModule.m_choose_painting.background_scale or resScale
    end
  else
    local strs = string.split(pos_offset_str, "|")
    local x = tonumber(strs[1])
    local y = tonumber(strs[2])
    resPos = Vector2(x, y)
    resScale = tonumber(strs[3])
  end
  return resPos, resScale
end

function ChooseAssistantHelper.GetAssistantBgSize(type, id)
  local size = Vector2(2539, 1439)
  if type == UIChooseAssistantBgType.Normal then
    local cfg = Cfg.cfg_main_bg[id]
    if cfg.Size then
      size = Vector2(cfg.Size[1], cfg.Size[2])
    end
  elseif type == UIChooseAssistantBgType.Story or type == UIChooseAssistantBgType.Skin or type == UIChooseAssistantBgType.Season then
    local cfg = Cfg.cfg_cg_book[id]
    if cfg.Size then
      size = Vector2(cfg.Size[1], cfg.Size[2])
    end
  end
  return size
end

function ChooseAssistantHelper.SaveAssistantBgSetting(pos, scale, type, id, handle, spineId)
  GameGlobal.UIStateManager():Lock("ChooseAssistantHelper.SaveAssistantBgSetting")
  local dbStr = ChooseAssistantHelper.GetLocalDBStr(false, type, id)
  if scale == 0 or scale <= 0.1 then
    scale = 1
  end
  local value = pos.x .. "|" .. pos.y .. "|" .. scale
  LocalDB.SetString(dbStr, value)
  if GameSingle then
    GameGlobal.UIStateManager():UnLock("ChooseAssistantHelper.SaveAssistantBgSetting")
    return
  end
  GameGlobal.TaskManager():StartTask(function(TT)
    local roleModule = GameGlobal.GetModule(RoleModule)
    local params = {
      nBackImageID = id,
      background_type = type,
      background_x = pos.x,
      background_y = pos.y,
      background_scale = scale,
      is_hand_operate = handle,
      spine_id = spineId
    }
    roleModule:RequestRole_BackID(TT, params)
    GameGlobal.UIStateManager():UnLock("ChooseAssistantHelper.SaveAssistantBgSetting")
  end)
end

function ChooseAssistantHelper.GetSpineSettings()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local petid = roleModule:GetResId()
  local defaultPetID = 0
  local grade, skin, asid, staticSpineSettings, dynamicSpineSettings
  if petid and petid ~= 0 then
    defaultPetID = petid
    grade = roleModule.m_choose_painting.pet_grade
    skin = roleModule.m_choose_painting.skin_id
    asid = roleModule.m_choose_painting.board_pet
    if asid == 3400050 then
      asid = 10015
    end
  else
    defaultPetID = Cfg.cfg_global.main_default_spine_pet_id.IntValue
    grade = 0
    skin = 0
    asid = 0
  end
  local cfg_pet
  if 0 < grade then
    cfg_pet = Cfg.cfg_pet_grade({PetID = defaultPetID, Grade = grade})[1]
  else
    cfg_pet = Cfg.cfg_pet[defaultPetID]
  end
  if cfg_pet then
    if asid and asid ~= 0 then
      local cfg_as = Cfg.cfg_only_assistant[asid]
      if not cfg_as then
        Log.error("###[UIChooseMainCgController] cfg_as is nil ! id --> ", asid)
      end
      staticSpineSettings = cfg_as.CG
      dynamicSpineSettings = cfg_as.Spine
    else
      staticSpineSettings = HelperProxy:GetInstance():GetMainLobbyStaticBody(defaultPetID, grade, skin, PetSkinEffectPath.NO_EFFECT)
      staticSpineSettings = staticSpineSettings or HelperProxy:GetInstance():GetPetStaticBody(defaultPetID, grade, skin, PetSkinEffectPath.NO_EFFECT)
      dynamicSpineSettings = HelperProxy:GetInstance():GetMainLobbySpine(defaultPetID, grade, skin, PetSkinEffectPath.NO_EFFECT)
      if not dynamicSpineSettings then
        dynamicSpineSettings = HelperProxy:GetInstance():GetPetSpine(defaultPetID, grade, skin, PetSkinEffectPath.NO_EFFECT)
      end
    end
  else
    staticSpineSettings = defaultPetID .. "_cg"
    dynamicSpineSettings = defaultPetID .. "_spine_idle"
  end
  return staticSpineSettings, dynamicSpineSettings
end

ChooseAssistantHelper.MulSpine_Auto = 0
ChooseAssistantHelper.MulSpine_Manuel = 1

function ChooseAssistantHelper.GetMulSpineModel()
  local key = ChooseAssistantHelper.GetPrefsKey("multi_spine_model")
  return UnityEngine.PlayerPrefs.GetInt(key, ChooseAssistantHelper.MulSpine_Auto)
end

function ChooseAssistantHelper.SetMulSpineModel(model)
  local key = ChooseAssistantHelper.GetPrefsKey("multi_spine_model")
  UnityEngine.PlayerPrefs.SetInt(key, model)
end

function ChooseAssistantHelper.GetMulSpineIndex()
  local key = ChooseAssistantHelper.GetPrefsKey("multi_spine_index")
  return UnityEngine.PlayerPrefs.GetInt(key, 1)
end

function ChooseAssistantHelper.SetMulSpineIndex(index)
  local key = ChooseAssistantHelper.GetPrefsKey("multi_spine_index")
  UnityEngine.PlayerPrefs.SetInt(key, index)
end

function ChooseAssistantHelper.GetPrefsKey(str)
  local mRole = GameGlobal.GetModule(RoleModule)
  local pstId = mRole:GetPstId()
  local playerPrefsKey = pstId .. str
  return playerPrefsKey
end

function ChooseAssistantHelper:SaveTmpChooseCgPaintingData(isSave, id, grade, skinID, asID)
  local mRole = GameGlobal.GetModule(RoleModule)
  if isSave then
    if not self._currentCgID then
      self._currentCgID = mRole.m_choose_painting.pet_template_id and mRole.m_choose_painting.pet_template_id or -1
      self._currentGrade = mRole.m_choose_painting.pet_grade
      self._currentSkinID = mRole.m_choose_painting.skin_id
      self._currentAsID = mRole.m_choose_painting.board_pet
    end
    mRole.m_choose_painting.pet_template_id = id
    mRole.m_choose_painting.pet_grade = grade
    mRole.m_choose_painting.skin_id = skinID
    mRole.m_choose_painting.board_pet = asID
  else
    if self._currentCgID then
      mRole.m_choose_painting.pet_template_id = self._currentCgID
      mRole.m_choose_painting.pet_grade = self._currentGrade
      mRole.m_choose_painting.skin_id = self._currentSkinID
      mRole.m_choose_painting.board_pet = self._currentAsID
    end
    self._currentCgID = nil
    self._currentGrade = nil
    self._currentSkinID = nil
    self._currentAsID = nil
  end
end

function ChooseAssistantHelper:SaveTmpChooseBgPaintingData(isSave, id, type)
  local mRole = GameGlobal.GetModule(RoleModule)
  if isSave then
    if not self._currentBgID then
      self._currentBgID = mRole.m_choose_painting.back_id
      self._currentBgType = mRole.m_choose_painting.background_type
    end
    mRole.m_choose_painting.back_id = id
    mRole.m_choose_painting.background_type = type
  else
    if self._currentBgID then
      mRole.m_choose_painting.back_id = self._currentBgID
      mRole.m_choose_painting.background_type = self._currentBgType
    end
    self._currentBgID = nil
    self._currentBgType = nil
  end
end

function ChooseAssistantHelper:ClearTmpChoosePaintingData()
  self._currentCgID = nil
  self._currentGrade = nil
  self._currentSkinID = nil
  self._currentAsID = nil
  self._currentBgID = nil
  self._currentBgType = nil
end
