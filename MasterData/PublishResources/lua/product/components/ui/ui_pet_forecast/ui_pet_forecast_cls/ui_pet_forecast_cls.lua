_class("PetForecastData", Object)
PetForecastData = PetForecastData

function PetForecastData:Constructor()
  self.mRole = GameGlobal.GetModule(RoleModule)
  self.cacheVigorous = 0
  self.last = nil
  self.normal = nil
  self.close = nil
end

function PetForecastData:Init(serData)
  self.id = serData.id
  self.endTime = serData.end_time or 0
  self.curDay = serData.day + 1
  self.cfg = Cfg.cfg_prediction[self.id]
  if self.cfg then
    local cg = self.cfg.cg
    if cg and 0 < #cg then
      self.prefab = cg.prefab or "UIPetForecast"
      self.imgLeftTime = cg.imgLeftTime or "main_prec_timebg"
      if cg.titleRect then
        self.posTitle = Vector2(cg.titleRect.x, cg.titleRect.y)
        self.sizeTitle = Vector2(cg.titleRect.w, cg.titleRect.h)
      else
        self.posTitle = Vector2(0, -440)
        self.sizeTitle = Vector2(1800, 195)
      end
      if self.cfg.rects then
        local mSignIn = GameGlobal.GetModule(SignInModule)
        self.pieces = {}
        for i, rect in ipairs(self.cfg.rects) do
          local piece = PetForecastPiece:New()
          piece.day = i
          piece.pos.x = rect.x
          piece.pos.y = rect.y
          piece.wh.x = rect.w
          piece.wh.y = rect.h
          piece.apos.x = rect.ax
          piece.apos.y = rect.ay
          piece.awh.x = rect.aw
          piece.awh.y = rect.ah
          piece.ppos.x = rect.px
          piece.ppos.y = rect.py
          local index = i - 1
          piece.state = serData.status[index] or PredictionStatus.PRES_UnReach
          piece.awards = self.cfg["award" .. i] or {}
          if piece.state == PredictionStatus.PRES_UnReach and piece:IsCurDay() then
            piece.curValue = self.mRole:GetAssetCount(RoleAssetID.RoleAssetVigorous)
            piece.maxValue = self.cfg["Vigorous" .. i] or 0
          end
          piece:Init(i, self.cfg)
          table.insert(self.pieces, piece)
        end
      else
        Log.fatal("### cfg_prediction.rects nil. id=", self.id)
      end
      if self.cfg.pets then
        self.pets = {}
        for i, pet in ipairs(self.cfg.pets) do
          table.insert(self.pets, {
            petId = pet.petId,
            pos = Vector2(pet.x, pet.y)
          })
        end
      else
        Log.fatal("### cfg_prediction.rects nil. id=", self.id)
      end
      if self.cfg.effect then
        self:InitPetForecastView(self.cfg.effect)
      end
    else
      local cfg = self:GetNewCfg(serData)
      self.cfg = cfg
      if cfg == nil then
        Log.fatal("### no data in cfg_prediction_new. id=", self.id)
      end
    end
  else
    Log.fatal("### no data in cfg_prediction. id=", self.id)
  end
end

function PetForecastData:GetNewCfg(serData)
  local cfg
  cfg = Cfg.cfg_prediction_new[self.id]
  if cfg then
    self.pieces = {}
    for i = 1, 6 do
      local piece = PetForecastPiece:New()
      piece.day = i
      local index = i - 1
      piece.state = serData.status[index] or PredictionStatus.PRES_UnReach
      piece.awards = self.cfg["award" .. i]
      if piece.state == PredictionStatus.PRES_UnReach and piece:IsCurDay() then
        piece.curValue = self.mRole:GetAssetCount(RoleAssetID.RoleAssetVigorous)
        piece.maxValue = self.cfg["Vigorous" .. i] or 0
      end
      if piece.awards then
        table.insert(self.pieces, piece)
      end
    end
  end
  return cfg
end

function PetForecastData.CheckCode(code, isToast)
  if code == Prediction_Result_Code.PREDICTION_SUCCEED then
    return true
  end
  if isToast then
    ToastManager.ShowToast(StringTable.Get("str_prediction_error_code_" .. code))
  end
  return false
end

function PetForecastData:UpdateState(day, state)
  for i, piece in ipairs(self.pieces) do
    if piece.day == day then
      piece.state = state
      break
    end
  end
end

function PetForecastData:IsAllAccepted()
  for i, piece in ipairs(self.pieces) do
    if piece.state == PredictionStatus.PRES_UnAccept or piece.state == PredictionStatus.PRES_UnReach then
      return false
    end
  end
  return true
end

function PetForecastData:IsVigorousChanged()
  local curVigorous = self.mRole:GetAssetCount(RoleAssetID.RoleAssetVigorous)
  if self.cacheVigorous ~= curVigorous then
    self.cacheVigorous = curVigorous
    return true
  end
  return false
end

function PetForecastData:GetPiece(day)
  for i, piece in ipairs(self.pieces) do
    if piece.day == day then
      return piece
    end
  end
end

function PetForecastData:InitPetForecastView(cfgv)
  if cfgv.last then
    self.last = PetForecastView:New()
    self.last:Init(cfgv.last)
  end
  if cfgv.normal then
    self.normal = PetForecastView:New()
    self.normal:Init(cfgv.normal)
  end
  if cfgv.close then
    self.close = PetForecastView:New()
    self.close:Init(cfgv.close)
  end
end

function PetForecastData:HasNewPieceImage()
  local b = self.last and true or false
  return b
end

function PetForecastData:GetCfg_cg(key)
  local cfg = (self.cfg or {}).cg or {}
  return cfg[key]
end

function PetForecastData:GetCfg_imgs(id, key)
  local cfgs = (self.cfg or {}).imgs or {}
  return (cfgs[id] or {})[key]
end

function PetForecastData:SetObjTransform(obj, anchorMin, anchorMax, anchoredPosition, sizeDelta)
  local tran = obj:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  if anchorMin then
    tran.anchorMin = anchorMin
  end
  if anchorMax then
    tran.anchorMax = anchorMax
  end
  if anchoredPosition then
    tran.anchoredPosition = anchoredPosition
  end
  if sizeDelta then
    tran.sizeDelta = sizeDelta
  end
end

function PetForecastData:SetObjColor(uiView, widgetType, widgetName, key)
  local function GetColorFunc(colorCfg)
    if colorCfg then
      local r, g, b = colorCfg[1] / 255, colorCfg[2] / 255, colorCfg[3] / 255
      
      local a = colorCfg[4] and colorCfg[4] / 255 or 1
      return Color(r, g, b, a)
    end
    return Color.white
  end
  
  local colorCfg = self:GetCfg_cg(key)
  local color = GetColorFunc(colorCfg)
  local obj = uiView:GetUIComponent(widgetType, widgetName)
  obj.color = color
end

_class("PetForecastPiece", Object)
PetForecastPiece = PetForecastPiece

function PetForecastPiece:Constructor()
  self.day = 0
  self.pos = Vector2.zero
  self.wh = Vector2.zero
  self.apos = Vector2.zero
  self.awh = Vector2.zero
  self.ppos = Vector2.zero
  self.state = PredictionStatus.PRES_UnReach
  self.curValue = 0
  self.maxValue = 0
  self.awards = {}
  self.imgSelect = ""
  self.imgFull = ""
  self.imgBG = ""
  self.imgComic = ""
  self.imgSentence = ""
  self.imgSelectUnlock = ""
  self.imgFullUnlock = ""
  self.imgBGUnlock = ""
  self.imgComicUnlock = ""
  self.imgSentenceUnlock = ""
end

function PetForecastPiece:IsCurDay()
  local data = GameGlobal.GetModule(SignInModule):GetPredictionData()
  if data then
    return data.curDay == self.day
  end
  return false
end

function PetForecastPiece:Init(i, cfgv)
  self:InitImgUnlock(cfgv.unlockImgs[i])
end

function PetForecastPiece:InitImgUnlock(cfgvImgs)
  if cfgvImgs then
    self.imgSelectUnlock = cfgvImgs.s
    self.imgFullUnlock = cfgvImgs.f
    self.imgBGUnlock = cfgvImgs.bg
    self.imgComicUnlock = cfgvImgs.comic
    self.imgSentenceUnlock = cfgvImgs.sentence
  end
end

_class("PetForecastView", Object)
PetForecastView = PetForecastView

function PetForecastView:Constructor()
  self.parallel = {}
end

function PetForecastView:Init(t)
  if not t then
    return
  end
  for _, pi in pairs(t) do
    local p = PetForecastViewParallel:New()
    for _, ci in ipairs(pi) do
      local c = PetForecastViewCommand:New()
      local strs = string.split(ci, ",")
      for i, str in ipairs(strs) do
        str = string.trim(str)
        if i == 1 then
          c.name = str
        else
          table.insert(c.params, str)
        end
      end
      table.insert(p.commands, c)
    end
    table.insert(self.parallel, p)
  end
end

_class("PetForecastViewParallel", Object)
PetForecastViewParallel = PetForecastViewParallel

function PetForecastViewParallel:Constructor()
  self.commands = {}
end

_class("PetForecastViewCommand", Object)
PetForecastViewCommand = PetForecastViewCommand

function PetForecastViewCommand:Constructor()
  self.name = ""
  self.params = {}
end
