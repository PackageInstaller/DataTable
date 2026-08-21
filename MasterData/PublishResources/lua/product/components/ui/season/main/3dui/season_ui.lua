_class("SeasonUI", Object)
SeasonUI = SeasonUI

function SeasonUI:Constructor()
  self._levelWidgetPool = {}
  self._signWidgetPool = {}
  self._bubbleWidget = nil
  self._functionWidgetPool = {}
  self._seasonObj = GameGlobal.GetModule(SeasonModule):GetCurSeasonObj()
  self._componentInfo = self._seasonObj:GetComponentInfo(ECCampaignSeasonComponentID.SEASON_MISSION)
  self:_InitUICanvas()
  self:_CreateLevelWidgets()
  self:_CreateSignWidgets()
  self:_CreateBubbleWidgets()
  self:_CreateFunctionWidgets()
end

function SeasonUI:_InitUICanvas()
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  self._mgr = self._seasonModule.uiModule:SeasonManager()
  self._uiCanvasRequest = ResourceManager:GetInstance():SyncLoadAsset("SeasonUICanvas.prefab", LoadType.GameObject)
  self._gameObject = self._uiCanvasRequest.Obj
  self._gameObject.name = "UICanvas"
  self._gameObject.transform:SetParent(nil)
  UnityEngine.SceneManagement.SceneManager.MoveGameObjectToScene(self._gameObject, self._mgr:SeasonSceneManager():Scene())
  self._gameObject:SetActive(true)
  self._gameObject.transform.position = Vector3.zero
  self._canvas = self._gameObject:GetComponent("Canvas")
  self._canvas.worldCamera = self._mgr:SeasonCameraManager():Camera()
  self._view = self._gameObject:GetComponentInChildren(typeof(UIView))
  self._level = self._view:GetUIComponent("UISelectObjectPath", "Level")
  self._sign = self._view:GetUIComponent("UISelectObjectPath", "Sign")
  self._function = self._view:GetUIComponent("UISelectObjectPath", "Function")
  self._bubble = self._view:GetUIComponent("UISelectObjectPath", "Bubble")
  local mainAtlas = UISeasonHelper.GetCurMainAtlas()
  if mainAtlas then
    self._atlasReq = ResourceManager:GetInstance():SyncLoadAsset(mainAtlas, LoadType.SpriteAtlas)
    self._atlas = self._atlasReq.Obj
  end
  self:_InitCfg()
end

function SeasonUI:Dispose()
  if self._uiCanvasRequest then
    self._uiCanvasRequest:Dispose()
    self._uiCanvasRequest = nil
  end
  if self._atlasReq then
    self._atlasReq:Dispose()
    self._atlasReq = nil
  end
  if self._funcAtlasReq then
    self._funcAtlasReq:Dispose()
    self._funcAtlasReq = nil
  end
  if self._levelAtlasReq then
    self._levelAtlasReq:Dispose()
    self._levelAtlasReq = nil
  end
  table.clear(self._levelWidgetPool)
  table.clear(self._signWidgetPool)
  self._bubbleWidget = nil
  UnityEngine.Object.Destroy(self._gameObject)
end

function SeasonUI:Update(deltaTime)
  if self._bubbleWidget then
    self._bubbleWidget:Update(deltaTime)
  end
end

function SeasonUI:Refresh()
  self:_RefreshWidgets()
end

function SeasonUI:SwitchDiff(diff)
  self:_RefreshWidgets()
end

function SeasonUI:_RefreshWidgets()
  self:_CreateLevelWidgets()
  self:_CreateSignWidgets()
  self:_CreateFunctionWidgets()
end

function SeasonUI:_CreateLevelWidgets()
  local mainLevels = self._mgr:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.MainLevel)
  local subLevels = self._mgr:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.SubLevel)
  local dailyLevels = self._mgr:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.DailyLevel)
  local storyLevels = self._mgr:SeasonMapManager():GetEventPointsByType(SeasonEventPointType.MainStory, true)
  local levels = {}
  if mainLevels then
    for _, value in pairs(mainLevels) do
      table.insert(levels, value)
    end
  end
  if subLevels then
    for _, value in pairs(subLevels) do
      table.insert(levels, value)
    end
  end
  if dailyLevels then
    for _, value in pairs(dailyLevels) do
      table.insert(levels, value)
    end
  end
  if storyLevels then
    for _, value in pairs(storyLevels) do
      table.insert(levels, value)
    end
  end
  local count = table.count(levels)
  local poolLength = #self._levelWidgetPool
  if count > poolLength then
    for i = poolLength, count - 1 do
      local go = self._level:SpawnOneObject(self._levelCfg.widget)
      table.insert(self._levelWidgetPool, SeasonUILevel:New(go, self._levelAtlas, self._levelCfg))
    end
  end
  for i = 1, #self._levelWidgetPool do
    local widget = self._levelWidgetPool[i]
    if i <= count then
      widget:SetData(levels[i], self._componentInfo)
    else
      widget:SetData(nil)
    end
  end
end

function SeasonUI:_CreateSignWidgets()
  self:ClearSignWidgets()
  for _, _type in pairs(SeasonEventPointType) do
    local eventPoints = self._mgr:SeasonMapManager():GetEventPointsByType(_type)
    if eventPoints then
      for _, eventPoint in pairs(eventPoints) do
        if eventPoint:IsUnlock() and eventPoint:ModeAble() then
          local curProgressExpress = eventPoint:CurProgressExpress()
          if curProgressExpress then
            local expresses = curProgressExpress:GetExpresses(SeasonExpressType.Sign)
            if expresses then
              for _, express in pairs(expresses) do
                local content = express:Content()
                local signType = content.type
                if signType == SeasonExpressTiming.Before then
                  self:AddSign(eventPoint, express)
                  break
                end
              end
            end
          end
        end
      end
    end
  end
end

function SeasonUI:AddSign(eventPoint, express)
  local widget = self:_GetFreeSignWidget()
  if not widget then
    local go = self._sign:SpawnOneObject("SeasonUISign")
    widget = SeasonUISign:New(go, self._atlas)
    table.insert(self._signWidgetPool, widget)
  end
  widget:SetData(eventPoint, express)
end

function SeasonUI:RemoveSign(eventPoint)
  for _, widget in pairs(self._signWidgetPool) do
    if widget:EventPoint() == eventPoint then
      widget:Clear()
      break
    end
  end
end

function SeasonUI:_GetFreeSignWidget()
  for _, widget in pairs(self._signWidgetPool) do
    if widget:IsFree() then
      return widget
    end
  end
  return nil
end

function SeasonUI:ClearSignWidgets()
  for _, widget in pairs(self._signWidgetPool) do
    widget:Clear()
  end
end

function SeasonUI:_CreateBubbleWidgets()
  local go = self._bubble:SpawnOneObject("SeasonUIBubble")
  self._bubbleWidget = SeasonUIBubble:New(go, self._atlas)
  self._bubbleWidget:SetData()
end

function SeasonUI:Bubble()
  return self._bubbleWidget
end

function SeasonUI:_InitCfg()
  self._levelCfg = UISeasonHelper.GetCurLevelInfo()
  if self._levelCfg.atlas then
    self._levelAtlasReq = ResourceManager:GetInstance():SyncLoadAsset(self._levelCfg.atlas, LoadType.SpriteAtlas)
    self._levelAtlas = self._levelAtlasReq.Obj
  else
    self._levelAtlas = self._atlas
  end
  self._level:SetObjectName(self._levelCfg.widget .. ".prefab")
  self._funcAtlasName = UISeasonHelper.GetCurFuncAtlas()
  if self._funcAtlasName then
    self._funcAtlasReq = ResourceManager:GetInstance():SyncLoadAsset(self._funcAtlasName, LoadType.SpriteAtlas)
    self._funcAtlas = self._funcAtlasReq.Obj
  end
end

function SeasonUI:_CreateFunctionWidgets()
  self:ClearFunctionWidgets()
  for _, _type in pairs(SeasonEventPointType) do
    local eventPoints = self._mgr:SeasonMapManager():GetEventPointsByType(_type)
    if eventPoints then
      for _, eventPoint in pairs(eventPoints) do
        if eventPoint:IsUnlock() and eventPoint:ModeAble() then
          local curProgressExpress = eventPoint:CurProgressExpress()
          if curProgressExpress then
            local expresses = curProgressExpress:GetExpresses(SeasonExpressType.Function)
            if expresses then
              for _, express in pairs(expresses) do
                local content = express:Content()
                local signType = content.type
                if signType == SeasonExpressTiming.Before then
                  self:AddFunction(eventPoint, express)
                  break
                end
              end
            end
          end
        end
      end
    end
  end
end

function SeasonUI:AddFunction(eventPoint, express)
  local widget = self:_GetFreeFunctionWidget()
  if not widget then
    local go = self._function:SpawnOneObject("SeasonUIFunction")
    widget = SeasonUIFunction:New(go, self._funcAtlas)
    table.insert(self._functionWidgetPool, widget)
  end
  widget:SetData(eventPoint, express)
end

function SeasonUI:RemoveFunction(eventPoint)
  for _, widget in pairs(self._functionWidgetPool) do
    if widget:EventPoint() == eventPoint then
      widget:Clear()
      break
    end
  end
end

function SeasonUI:_GetFreeFunctionWidget()
  for _, widget in pairs(self._functionWidgetPool) do
    if widget:IsFree() then
      return widget
    end
  end
  return nil
end

function SeasonUI:ClearFunctionWidgets()
  for _, widget in pairs(self._functionWidgetPool) do
    widget:Clear()
  end
end

function SeasonUI:RefreshFunction(eventPoint)
  for _, widget in pairs(self._functionWidgetPool) do
    if widget:EventPoint() == eventPoint then
      widget:RefreshPosition()
      break
    end
  end
end

function SeasonUI:GetEventPointByFunction(gameObject)
  for _, widget in pairs(self._functionWidgetPool) do
    if widget:Function() == gameObject then
      return widget:EventPoint()
    end
  end
end
