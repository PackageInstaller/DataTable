_class("UIMapNodeItemBase", UICustomWidget)
UIMapNodeItemBase = UIMapNodeItemBase

function UIMapNodeItemBase:Constructor()
  self.nodeInfo = nil
  self._vec0_5 = Vector2(0.5, 0.5)
end

function UIMapNodeItemBase:OnShow()
  self._atlas = self:GetAsset("UIDiscovery.spriteatlas", LoadType.SpriteAtlas)
  self._atlasNode = self:GetAsset("UIDiscoveryNode.spriteatlas", LoadType.SpriteAtlas)
  self._root = self:GetGameObject("root")
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._tipRoot = self:GetGameObject("tipRoot")
  self.txtTip = self:GetUIComponent("UILocalizationText", "txtTip")
  self:GetUIComponentStar()
  self:GetUIComponentRoot()
  self:GetUIComponentEff()
  self:AttachEvent(GameEventType.DiscoveryNodeStateChange, self.FlushState)
  self:AttachEvent(GameEventType.DiscoveryShowHideUIStage, self.Highlight)
end

function UIMapNodeItemBase:OnHide()
  self.nodeInfo = nil
  self.eff = nil
  self._tipRoot = nil
  self:DetachEvent(GameEventType.DiscoveryNodeStateChange, self.FlushState)
  self:DetachEvent(GameEventType.DiscoveryShowHideUIStage, self.Highlight)
end

function UIMapNodeItemBase:GetUIComponentStar()
  self.starPool = self:GetUIComponent("UISelectObjectPath", "star")
  self.starPool:SpawnObjects("UIMapNodeItemStar", 3)
end

function UIMapNodeItemBase:GetUIComponentRoot()
  self.animRoot = self:GetUIComponent("Animation", "root")
end

function UIMapNodeItemBase:GetUIComponentEff()
  self.eff = self:GetGameObject("eff")
  self.animEff = self:GetUIComponent("Animation", "eff")
end

function UIMapNodeItemBase:Init(nodeInfo, notPlayAnimation)
  self.nodeInfo = nodeInfo
  self._notPlayAnimation = notPlayAnimation
  self._rectTransform.anchorMax = self._vec0_5
  self._rectTransform.anchorMin = self._vec0_5
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = self.nodeInfo.pos
  self.txtTip:SetText(self.nodeInfo.name or "")
  self.eff:SetActive(false)
end

function UIMapNodeItemBase:Flush()
  self:FlushState(self.nodeInfo.id)
  self:FlushGuide()
  self:Animation()
end

function UIMapNodeItemBase:FlushState(nodeId)
  if nodeId == self.nodeInfo.id then
    local state = self.nodeInfo:State()
    if state then
      self._root:SetActive(true)
      self:FlushStar()
    else
      self._root:SetActive(false)
    end
  end
end

function UIMapNodeItemBase:FlushStar()
  local stage = self.nodeInfo.stages[1]
  local uiStars = self.starPool:GetAllSpawnList()
  for i, v in ipairs(uiStars) do
    local star = stage.star or 0
    v:Flush(i <= star)
  end
end

function UIMapNodeItemBase:FlushGuide()
end

function UIMapNodeItemBase:btnBgOnClick()
  self:ClickItem()
  self:PlayAnimMapTrainIn()
end

function UIMapNodeItemBase:PlayAnimMapTrainIn()
  self:StartTask(function(TT)
    local key = "UIMapNodeItemBasePlayAnimMapTrainIn"
    self:Lock(key)
    self.animEff:Play("uieff_MapTrain_in")
    YIELD(TT, 500)
    self.animEff:Play("uieff_MapTrain_loop")
    self:UnLock(key)
  end, self)
end

function UIMapNodeItemBase:ClickItem()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryShowHideUIStage, true, self.nodeInfo.id)
  if self.nodeInfo:State() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryPlayerMove, self.nodeInfo.id)
  end
end

function UIMapNodeItemBase:Highlight(isHighlight, nodeId)
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

function UIMapNodeItemBase:Animation()
  local state = self.nodeInfo:State()
  if state then
    if state == DiscoveryStageState.CanPlay and self.nodeInfo:IsFirstShow() then
      self.nodeInfo:SaveIsFirstShow()
    end
    self:PlayTipAnim()
  end
end

function UIMapNodeItemBase:PlayTipAnim()
  local name = self:GetTipAnimName()
  self.animRoot:Play(name)
end

function UIMapNodeItemBase:GetTipAnimName()
  return ""
end

function UIMapNodeItemBase:GetNodeInfo()
  return self.nodeInfo
end

function UIMapNodeItemBase:GetRectTransform()
  return self._rectTransform
end

function UIMapNodeItemBase:GetTip()
  if not self.nodeInfo then
    return
  end
  return self._tipRoot
end
