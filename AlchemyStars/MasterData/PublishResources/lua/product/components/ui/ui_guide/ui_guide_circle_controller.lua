_class("UIGuideCircleController", UIController)
UIGuideCircleController = UIGuideCircleController

function UIGuideCircleController:Constructor()
  self._scaleFactor = 0.44140625
  self._updateInterval = 1
  self._curInterval = 0
end

function UIGuideCircleController:OnShow(UIParams)
  GuideHelper.GuideLoadLock(false, "Circle")
  self.atlas = self:GetAsset("UIGuide.spriteatlas", LoadType.SpriteAtlas)
  self._main = self:GetModule(AircraftModule):GetClientMain()
  self._seasonMgr = self:GetUIModule(SeasonModule):SeasonManager()
  self._seasonMazeMgr = GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager()
  self.canClick = false
  self.data = UIParams[1]
  self.gridPos = UIParams[2]
  self.selectRect = self:GetUIComponent("RectTransform", "bg")
  self.selectTrans = self:GetUIComponent("Transform", "bg")
  self.backs = {}
  for i = 1, 4 do
    local back = self:GetUIComponent("RectTransform", "Back" .. i)
    self.backs[i] = back
  end
  self.ltTitleTxt = self:GetUIComponent("UILocalizationText", "lttitle")
  self.rtTitleTxt = self:GetUIComponent("UILocalizationText", "rttitle")
  self.ldTitleTxt = self:GetUIComponent("UILocalizationText", "ldtitle")
  self.rdTitleTxt = self:GetUIComponent("UILocalizationText", "rdtitle")
  self.ltDescTxt = self:GetUIComponent("UILocalizationText", "ltdesc")
  self.rtDescTxt = self:GetUIComponent("UILocalizationText", "rtdesc")
  self.ldDescTxt = self:GetUIComponent("UILocalizationText", "lddesc")
  self.rdDescTxt = self:GetUIComponent("UILocalizationText", "rddesc")
  self.ltGO = self:GetGameObject("lt")
  self.rtGO = self:GetGameObject("rt")
  self.ldGO = self:GetGameObject("ld")
  self.rdGO = self:GetGameObject("rd")
  self.ltMaskRect = self:GetUIComponent("RectTransform", "ltmask")
  self.ltMaskRect.sizeDelta = Vector2(0, 70)
  self.rtMaskRect = self:GetUIComponent("RectTransform", "rtmask")
  self.rtMaskRect.sizeDelta = Vector2(0, 70)
  self.ldMaskRect = self:GetUIComponent("RectTransform", "ldmask")
  self.ldMaskRect.sizeDelta = Vector2(0, 70)
  self.rdMaskRect = self:GetUIComponent("RectTransform", "rdmask")
  self.rdMaskRect.sizeDelta = Vector2(0, 70)
  self.ltTitleGO = self:GetGameObject("lttitlego")
  self.ltTitleGO:SetActive(false)
  self.rtTitleGO = self:GetGameObject("rttitlego")
  self.rtTitleGO:SetActive(false)
  self.ldTitleGO = self:GetGameObject("ldtitlego")
  self.ldTitleGO:SetActive(false)
  self.rdTitleGO = self:GetGameObject("rdtitlego")
  self.rdTitleGO:SetActive(false)
  self.continueGO = self:GetGameObject("continue")
  self.continueGO:SetActive(false)
  self.fingerGO = self:GetGameObject("finger")
  self.fingerGO:SetActive(false)
  self.fingerImage = self:GetUIComponent("Image", "circle")
  self.p_black = self:GetGameObject("p_black")
  self.p_black_mask = self:GetUIComponent("RectTransform", "p_black_mask")
  self.p_black_masked = self:GetUIComponent("Image", "p_black_masked")
  self.p_black_masked_mat = self.p_black_masked.material
  self.describeGO = self:GetGameObject("describe")
  self.describeRect = self:GetUIComponent("RectTransform", "describe")
  self.desCharactorImg = self:GetUIComponent("Image", "des_charactor")
  self.describeText = self:GetUIComponent("UILocalizationText", "des_text")
  self.describeTextRect = self:GetUIComponent("RectTransform", "des_text")
  self:Refresh()
  self:AttachEvent(GameEventType.UIBlackChange, self.Refresh)
end

function UIGuideCircleController:Refresh()
  local pos = Vector2.zero
  if self:IsFingerType() then
    if self.data.type == GuideCircleType.AirPet then
      pos = self:AirPet2WorldPos()
    elseif self.data.type == GuideCircleType.Finger then
      pos = self:Room2WorldPos()
    elseif self.data.type == GuideCircleType.AirSmelt then
      pos = self:AirSmelt2WorldPos()
    elseif self.data.type == GuideCircleType.AirSandBox then
      pos = self:AirSandBox2WorldPos()
    elseif self.data.type == GuideCircleType.AirTactic then
      pos = self:AirTactic2WorldPos()
    elseif self.data.type == GuideCircleType.SeasonEventPoint then
      pos = self:SeasonEventPointPos(false)
    elseif self.data.type == GuideCircleType.SeasonMazePoint then
      pos = self:SeasonMazePointPos(false)
    end
  else
    local screenPos = InnerGameHelperRender.GridPos2WorldPos(self.gridPos, self.data)
    local sw = ResolutionManager.ScreenWidth()
    local rw = ResolutionManager.RealWidth()
    local factor = rw / sw
    local sx, sy = screenPos.x * factor, screenPos.y * factor
    pos = Vector2(sx - self.data.radius * 0.5 + self.data.offset[1], sy - self.data.radius * 0.5 + self.data.offset[2])
  end
  self.selectRect.sizeDelta = Vector2(self.data.radius, self.data.radius)
  self.selectRect.anchoredPosition = pos
  if self.data.alpha then
    self.p_black_masked.color = Color(0, 0, 0, self.data.alpha / 255)
  else
    self.p_black_masked.color = Color(0, 0, 0, 0.8745098039215686)
  end
  self:SetMaskPos(pos)
  self:RefreshTxt()
  self:RefreshFinger()
  self:RefreshDescribe()
end

function UIGuideCircleController:Room2WorldPos()
  local go = self._main:GetBtnGuide(self.data.param[1])
  local worldPos = go.transform.position
  local camera = self._main:GetMainCamera()
  local screenPos = camera:WorldToScreenPoint(worldPos)
  local sw = ResolutionManager.ScreenWidth()
  local rw = ResolutionManager.RealWidth()
  local factor = rw / sw
  local sx, sy = screenPos.x * factor, screenPos.y * factor
  screenPos = Vector2(sx - self.data.radius * 0.5 + self.data.offset[1], sy - self.data.radius * 0.5 + self.data.offset[2])
  return screenPos
end

function UIGuideCircleController:AirPet2WorldPos()
  local petId = self.data.param[1]
  local pet = self._main:GetPetByTmpID(petId)
  local go = pet:GameObject()
  local worldPos = go.transform.position
  local camera = self._main:GetMainCamera()
  local screenPos = camera:WorldToScreenPoint(worldPos)
  local sw = ResolutionManager.ScreenWidth()
  local rw = ResolutionManager.RealWidth()
  local factor = rw / sw
  local sx, sy = screenPos.x * factor, screenPos.y * factor
  screenPos = Vector2(sx - self.data.radius * 0.5 + self.data.offset[1], sy - self.data.radius * 0.5 + self.data.offset[2])
  return screenPos
end

function UIGuideCircleController:AirSmelt2WorldPos()
  local roomGo = self._main:GetRoomBySpaceID(self.data.param[1]):GetRoomGameObject()
  local tf = GameObjectHelper.FindChild(roomGo.transform, "UIAircraftSmeltTip")
  local worldPos = tf.position
  local camera = self._main:GetMainCamera()
  local screenPos = camera:WorldToScreenPoint(worldPos)
  local sw = ResolutionManager.ScreenWidth()
  local rw = ResolutionManager.RealWidth()
  local factor = rw / sw
  local sx, sy = screenPos.x * factor, screenPos.y * factor
  screenPos = Vector2(sx - self.data.radius * 0.5 + self.data.offset[1], sy - self.data.radius * 0.5 + self.data.offset[2])
  return screenPos
end

function UIGuideCircleController:AirSandBox2WorldPos()
  local roomGo = self._main:GetRoomBySpaceID(self.data.param[1]):GetRoomGameObject()
  local tf = GameObjectHelper.FindChild(roomGo.transform, "DispatchTaskMap")
  local worldPos = tf.position
  local camera = self._main:GetMainCamera()
  local screenPos = camera:WorldToScreenPoint(worldPos)
  local sw = ResolutionManager.ScreenWidth()
  local rw = ResolutionManager.RealWidth()
  local factor = rw / sw
  local sx, sy = screenPos.x * factor, screenPos.y * factor
  screenPos = Vector2(sx - self.data.radius * 0.5 + self.data.offset[1], sy - self.data.radius * 0.5 + self.data.offset[2])
  return screenPos
end

function UIGuideCircleController:AirTactic2WorldPos()
  local roomGo = self._main:GetRoomBySpaceID(self.data.param[1]):GetRoomGameObject()
  local tf = GameObjectHelper.FindChild(roomGo.transform, "tactic")
  local worldPos = tf.position
  local camera = self._main:GetMainCamera()
  local screenPos = camera:WorldToScreenPoint(worldPos)
  local sw = ResolutionManager.ScreenWidth()
  local rw = ResolutionManager.RealWidth()
  local factor = rw / sw
  local sx, sy = screenPos.x * factor, screenPos.y * factor
  screenPos = Vector2(sx - self.data.radius * 0.5 + self.data.offset[1], sy - self.data.radius * 0.5 + self.data.offset[2])
  return screenPos
end

function UIGuideCircleController:SeasonEventPointPos(isUpdate)
  local id = self.data.param[1]
  local eventPoint = self._seasonMgr:SeasonMapManager():GetEventPoint(id)
  if eventPoint then
    local worldPos = eventPoint:Position()
    local camera = self._seasonMgr:SeasonCameraManager():Camera()
    if not isUpdate then
      self._seasonMgr:SeasonCameraManager():SeasonCamera():Focus(eventPoint:Position())
    end
    local screenPos = camera:WorldToScreenPoint(worldPos)
    local sw = ResolutionManager.ScreenWidth()
    local rw = ResolutionManager.RealWidth()
    local factor = rw / sw
    local sx, sy = screenPos.x * factor, screenPos.y * factor
    screenPos = Vector2(sx - self.data.radius * 0.5 + self.data.offset[1], sy - self.data.radius * 0.5 + self.data.offset[2])
    return screenPos
  else
    Log.error("UIGuideCircleController SeasonEventPointPos eventpoint is nil.", id)
  end
  return Vector2.zero
end

function UIGuideCircleController:SeasonMazePointPos(isUpdate)
  local id = self.data.param[1]
  local node = self._seasonMazeMgr:MapManager():GetNode(id)
  if node then
    local worldPos = node:Position()
    local camera = self._seasonMazeMgr:SeasonMazeCameraManager():Camera()
    local screenPos = camera:WorldToScreenPoint(worldPos)
    local sw = ResolutionManager.ScreenWidth()
    local rw = ResolutionManager.RealWidth()
    local factor = rw / sw
    local sx, sy = screenPos.x * factor, screenPos.y * factor
    screenPos = Vector2(sx - self.data.radius * 0.5 + self.data.offset[1], sy - self.data.radius * 0.5 + self.data.offset[2])
    return screenPos
  else
    Log.error("UIGuideCircleController SeasonMazeNodePos node is nil.", id)
  end
  return Vector2.zero
end

function UIGuideCircleController:RefreshTxt()
  if self.data.lt then
    self.ltGO:SetActive(true)
    self.ltTitleTxt:SetText(StringTable.Get(self.data.lttitle))
    self.ltDescTxt:SetText(StringTable.Get(self.data.lt))
  else
    self.ltGO:SetActive(false)
  end
  if self.data.rt then
    self.rtGO:SetActive(true)
    self.rtTitleTxt:SetText(StringTable.Get(self.data.rttitle))
    self.rtDescTxt:SetText(StringTable.Get(self.data.rt))
  else
    self.rtGO:SetActive(false)
  end
  if self.data.lb then
    self.ldGO:SetActive(true)
    self.ldTitleTxt:SetText(StringTable.Get(self.data.lbtitle))
    self.ldDescTxt:SetText(StringTable.Get(self.data.lb))
  else
    self.ldGO:SetActive(false)
  end
  if self.data.rb then
    self.rdGO:SetActive(true)
    self.rdTitleTxt:SetText(StringTable.Get(self.data.rbtitle))
    self.rdDescTxt:SetText(StringTable.Get(self.data.rb))
  else
    self.rdGO:SetActive(false)
  end
  if not self:IsFingerType() then
    self:DoAni()
  else
    self.canClick = true
  end
end

local time1 = 0.4
local time2 = 400

function UIGuideCircleController:DoAni()
  self._taskID = self:StartTask(function(TT)
    if self.data.lt then
      self.ltMaskRect:DOSizeDelta(Vector2(600, 70), time1)
      YIELD(TT, time2)
      self.ltTitleGO:SetActive(true)
    end
    if self.data.rt then
      self.rtMaskRect:DOSizeDelta(Vector2(600, 70), time1)
      YIELD(TT, time2)
      self.rtTitleGO:SetActive(true)
    end
    if self.data.lb then
      self.ldMaskRect:DOSizeDelta(Vector2(600, 70), time1)
      YIELD(TT, time2)
      self.ldTitleGO:SetActive(true)
    end
    if self.data.rb then
      self.rdMaskRect:DOSizeDelta(Vector2(600, 70), time1)
      YIELD(TT, time2)
      self.rdTitleGO:SetActive(true)
    end
    YIELD(TT, 800)
    self.canClick = true
    self.continueGO:SetActive(true)
  end)
end

function UIGuideCircleController:RefreshFinger()
  if self:IsFingerType() then
    if self.data.showFinger == false then
      self.fingerGO:SetActive(false)
    else
      self.fingerGO:SetActive(true)
    end
  else
    self.fingerGO:SetActive(false)
  end
end

function UIGuideCircleController:RefreshDescribe()
  if self.data.describe then
    if not self.describeBgOldWidth or not self.describeBgOldHeight then
      self.describeBgOldWidth = self.describeRect.sizeDelta.x
      self.describeBgOldHeight = self.describeRect.sizeDelta.y
    end
    if self.data.descrbeIcon then
      self.desCharactorImg.sprite = self.atlas:GetSprite(self.data.descrbeIcon)
    end
    self.describeText:SetText(StringTable.Get(self.data.describe))
    local settings = self.describeText:GetGenerationSettings(self.describeTextRect.rect.size)
    local tg = self.describeText.cachedTextGenerator
    tg:Invalidate()
    tg:Populate(self.describeText.text, settings)
    UnityEngine.Canvas.ForceUpdateCanvases()
    if tg.lines.Count > 4 then
      self.describeRect.sizeDelta = Vector2(self.describeBgOldWidth, self.describeBgOldHeight + (tg.lines.Count - 4) * self.describeText.fontSize)
    else
      self.describeRect.sizeDelta = Vector2(self.describeBgOldWidth, self.describeBgOldHeight)
    end
    if self.data.describeOffset then
      self.describeRect.anchoredPosition = Vector3(self.data.describeOffset[1], self.data.describeOffset[2])
    end
    self.describeGO:SetActive(true)
  else
    self.describeGO:SetActive(false)
  end
end

function UIGuideCircleController:IsFingerType()
  return self.data and (self.data.type == GuideCircleType.Finger or self.data.type == GuideCircleType.AirPet or self.data.type == GuideCircleType.AirSmelt or self.data.type == GuideCircleType.AirSandBox or self.data.type == GuideCircleType.AirTactic or self.data.type == GuideCircleType.SeasonMazePoint or self.data.type == GuideCircleType.SeasonEventPoint)
end

function UIGuideCircleController:AnyClickClose()
  return self.data and self.data.anyClose
end

function UIGuideCircleController:OnHide()
  if self._taskID then
    GameGlobal.TaskManager():KillTask(self._taskID)
  end
end

function UIGuideCircleController:circleOnClick()
  self:OnClickBack()
end

function UIGuideCircleController:Back1OnClick()
  self:CheckClick()
end

function UIGuideCircleController:Back2OnClick()
  self:CheckClick()
end

function UIGuideCircleController:Back3OnClick()
  self:CheckClick()
end

function UIGuideCircleController:Back4OnClick()
  self:CheckClick()
end

function UIGuideCircleController:CheckClick()
  if self:AnyClickClose() then
    self:OnClickBack()
  elseif not self:IsFingerType() then
    self:OnClickBack()
  end
end

function UIGuideCircleController:OnClickBack()
  if self.canClick then
    if self.data.type == GuideCircleType.SeasonEventPoint and self.data.param[2] then
      local id = self.data.param[2]
      local eventPoint = self._seasonMgr:SeasonMapManager():GetEventPoint(id)
      self._seasonMgr:SeasonInputManager():GetInput():SetClickUnLockZone(true)
      self._seasonMgr:SeasonInputManager():GetInput():GetClickEffect():Click()
      self._seasonMgr:SeasonInputManager():GetInput():SetCurClickEventPoint(eventPoint)
      eventPoint:GuideMove(function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Circle)
      end)
    elseif self.data.type == GuideCircleType.SeasonMazePoint and self.data.param[1] and not self.data.anyClose then
      local id = self.data.param[1]
      local node = self._seasonMazeMgr:MapManager():GetNode(id)
      if node then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonMazeClickRoom, node:Room():Type(), node:Room():ID(), node:Position())
      else
        Log.fatal("UIGuideCircleController OnClickBack  can't find node ", id)
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Circle)
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Circle)
    end
    self:CloseDialog()
  end
end

function UIGuideCircleController:SetMaskPos(pos)
  local w, h = self.data.radius, self.data.radius
  local x = pos.x
  local y = pos.y
  local screenWidth = ResolutionManager.RealWidth()
  local screenHeight = ResolutionManager.RealHeight()
  local width = ResolutionManager.ScreenWidth()
  local height = ResolutionManager.ScreenHeight()
  local wc, hc = screenWidth / width, screenHeight / height
  if wc ~= hc then
    if wc < hc then
      screenHeight = height * wc
    else
      screenWidth = width * hc
    end
  end
  local rects = {
    {
      x = 0,
      y = 0,
      width = x,
      height = screenHeight
    },
    {
      x = x,
      y = y + h,
      width = screenWidth - x,
      height = screenHeight - y - h
    },
    {
      x = x + w,
      y = 0,
      width = screenWidth - x - w,
      height = y + h
    },
    {
      x = x,
      y = 0,
      width = w,
      height = y
    }
  }
  for i = 1, 4 do
    local back = self.backs[i]
    local data = rects[i]
    back.sizeDelta = Vector2(data.width, data.height)
    back.anchoredPosition = Vector2(data.x, data.y)
  end
  if self.p_black_masked_mat then
    local realRadius = self.data.radius * self._scaleFactor
    self.p_black_masked_mat:SetFloat("_Radius", realRadius)
    local offsetX = pos.x + (self.data.radius - screenWidth) * 0.5
    local offsetY = pos.y + (self.data.radius - screenHeight) * 0.5
    self.p_black_masked_mat:SetVector("_Center", Vector4(offsetX, offsetY, 0, 0))
  end
end

function UIGuideCircleController:OnUpdate()
  self._curInterval = self._curInterval + 1
  if self._curInterval >= self._updateInterval then
    self._curInterval = 0
    local pos = Vector2.zero
    if self:IsFingerType() then
      if self.data.type == GuideCircleType.AirPet then
        pos = self:AirPet2WorldPos()
      elseif self.data.type == GuideCircleType.Finger then
        pos = self:Room2WorldPos()
      elseif self.data.type == GuideCircleType.AirSmelt then
        pos = self:AirSmelt2WorldPos()
      elseif self.data.type == GuideCircleType.AirSandBox then
        pos = self:AirSandBox2WorldPos()
      elseif self.data.type == GuideCircleType.AirTactic then
        pos = self:AirTactic2WorldPos()
      elseif self.data.type == GuideCircleType.SeasonEventPoint then
        pos = self:SeasonEventPointPos(true)
      elseif self.data.type == GuideCircleType.SeasonMazePoint then
        pos = self:SeasonMazePointPos(true)
      end
      self.selectRect.anchoredPosition = pos
      self:SetMaskPos(pos)
    end
  end
end
