_class("UIMapNodeBasePart", UICustomWidget)
UIMapNodeBasePart = UIMapNodeBasePart

function UIMapNodeBasePart:Constructor()
  self.nodeInfo = nil
  self.vec0_5 = Vector2(0.5, 0.5)
end

function UIMapNodeBasePart:OnShow()
  self.atlas = self:GetAsset("UIDiscovery.spriteatlas", LoadType.SpriteAtlas)
  self.root = self:GetGameObject("root")
  self.bg = self:GetGameObject("bg")
  self.rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self.txtIdx = self:GetUIComponent("UILocalizationText", "txtIdx")
  self:GetUIComponentStar()
  self:GetUIComponentEff()
  self:AttachEvent(GameEventType.DiscoveryNodeStateChange, self.FlushState)
  self:AttachEvent(GameEventType.DiscoveryShowHideUIStage, self.Highlight)
end

function UIMapNodeBasePart:OnHide()
  self:DetachEvent(GameEventType.DiscoveryNodeStateChange, self.FlushState)
  self:DetachEvent(GameEventType.DiscoveryShowHideUIStage, self.Highlight)
  self.nodeInfo = nil
end

function UIMapNodeBasePart:GetUIComponentStar()
  self.starPool = self:GetUIComponent("UISelectObjectPath", "star")
  self.starPool:SpawnObjects("UIMapNodeItemStar", 3)
end

function UIMapNodeBasePart:GetUIComponentEff()
  self.eff = self:GetGameObject("eff")
  self.animEff = self:GetUIComponent("Animation", "eff")
end

function UIMapNodeBasePart:Init(nodeInfo, notPlayAnimation)
  self.nodeInfo = nodeInfo
  self.notPlayAnimation = notPlayAnimation
  self:InitPos()
  self.eff:SetActive(false)
end

function UIMapNodeBasePart:InitPos()
  self.rectTransform.anchorMax = self.vec0_5
  self.rectTransform.anchorMin = self.vec0_5
  self.rectTransform.sizeDelta = Vector2.zero
  self.rectTransform.anchoredPosition = self.nodeInfo.pos
  self.txtIdx:SetText(self.nodeInfo.name or "")
end

function UIMapNodeBasePart:Flush(nodeInfo)
  self:FlushState(self.nodeInfo.id)
  self:Animation()
end

function UIMapNodeBasePart:FlushState(nodeId)
  if nodeId ~= self.nodeInfo.id then
    return
  end
  local state = self.nodeInfo:State()
  local show = state and true or false
  self.root:SetActive(show)
  self:FlushStar()
end

function UIMapNodeBasePart:FlushStar()
  local stage = self.nodeInfo.stages[1]
  local uis = self.starPool:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    ui:Flush(i <= (stage.star or 0))
  end
end

function UIMapNodeBasePart:Animation()
  local state = self.nodeInfo:State()
  if state then
    self:StartTask(function(TT)
      local tip = self.bg
      tip.transform.localScale = Vector3(0, 1, 1)
      if state == DiscoveryStageState.CanPlay and self.nodeInfo:IsFirstShow() then
        self.nodeInfo:SaveIsFirstShow()
      end
      self:PlayTipAnim()
    end, self)
  end
end

function UIMapNodeBasePart:PlayTipAnim()
  local tip = self.bg
  if tip and tip.transform then
    local timer = 0.4
    if self._notPlayAnimation then
      tip.transform.localScale = Vector3.one
    else
      tip.transform:DOScaleX(1, timer)
    end
  end
end

function UIMapNodeBasePart:Highlight(isHighlight, nodeId)
  if isHighlight then
    if nodeId == self.nodeInfo.id then
      self.eff:SetActive(true)
    else
      self.eff:SetActive(false)
    end
  else
    self.eff:SetActive(false)
  end
end

function UIMapNodeBasePart:bgOnClick()
  self:ClickItem()
  self:PlayAnimMapTrainIn()
end

function UIMapNodeBasePart:PlayAnimMapTrainIn()
  self:StartTask(function(TT)
    local key = "UIMapNodeBasePartPlayAnimMapTrainIn"
    self:Lock(key)
    self.animEff:Play("uieff_MapTrainHard_in")
    YIELD(TT, 500)
    self.animEff:Play("uieff_MapTrainHard_loop")
    self:UnLock(key)
  end, self)
end

function UIMapNodeBasePart:ClickItem()
  if self.nodeInfo:State() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryShowHideUIStage, true, self.nodeInfo.id)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryPlayerMove, self.nodeInfo.id)
  end
end

function UIMapNodeBasePart:GetNodeInfo()
  return self.nodeInfo
end

function UIMapNodeBasePart:GetRectTransform()
  return self.rectTransform
end
