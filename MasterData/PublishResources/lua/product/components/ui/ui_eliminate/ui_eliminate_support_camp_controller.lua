_class("UIEliminateSupportCampController", UIController)
UIEliminateSupportCampController = UIEliminateSupportCampController

function UIEliminateSupportCampController:OnShow(uiParams)
  self._supportGroupID = uiParams[1]
  self.atlas = self:GetAsset("UIEliminate.spriteatlas", LoadType.SpriteAtlas)
  self._tags = {}
  self:_GetComponents()
  self:_InitComponents()
  self:StartTask(function(TT)
    YIELD(TT, 400)
  end)
end

function UIEliminateSupportCampController:_GetComponents()
  self._levelWidgetPool = self:GetUIComponent("UISelectObjectPath", "Levels")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIEliminateSupportCampController:_InitComponents()
  self._cfgs = Cfg.cfg_eliminate_support({
    GroupID = self._supportGroupID
  })
  if table.count(self._cfgs) == 0 then
    Log.exception("未在cfg_eliminate_support中配置该GroupID：", self._supportGroupID)
    return
  end
  local tagTb = {}
  for _, cfg in pairs(self._cfgs) do
    local tag = cfg.Tag
    if not tagTb[tag] then
      tagTb[tag] = {}
      table.insert(self._tags, tag)
    end
    table.insert(tagTb[tag], cfg)
  end
  table.sort(self._tags, function(a, b)
    return a < b
  end)
  self._levelWidgets = self._levelWidgetPool:SpawnObjects("UIEliminateSupportCampLevelGroup", table.count(tagTb))
  local index = 1
  for i, tagID in pairs(self._tags) do
    local info = tagTb[tagID]
    local widget = self._levelWidgets[index]
    widget:SetData(info)
    index = index + 1
  end
end

function UIEliminateSupportCampController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.CN7PopStarStep2)
end

function UIEliminateSupportCampController:CloseBtnOnClick(go)
  self:StartTask(function(TT)
    self:Lock("uieff_UIEliminateSupportCampController_out")
    self._anim:Play("uieff_UIEliminateSupportCampController_out")
    YIELD(TT, 400)
    self:UnLock("uieff_UIEliminateSupportCampController_out")
    self:CloseDialog()
  end)
end
