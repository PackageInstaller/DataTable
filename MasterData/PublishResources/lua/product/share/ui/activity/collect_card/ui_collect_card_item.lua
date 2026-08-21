_class("UICollectCardItem", UICustomWidget)
UICollectCardItem = UICollectCardItem

function UICollectCardItem:OnShow(uiParam)
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._icon2 = self:GetUIComponent("RawImageLoader", "Icon2")
  self._got = self:GetGameObject("got")
  self._nameTex = self:GetUIComponent("UILocalizedTMP", "NameTex")
  self._number = self:GetUIComponent("UILocalizedTMP", "Number")
  self._pool = self:GetUIComponent("UISelectObjectPath", "Pool")
  self._anim = self:GetUIComponent("Animation", "UICollectCardItem")
  self._root = self:GetUIComponent("CanvasGroup", "root")
  self._RedGo = self:GetGameObject("eff")
  self._GetBtn = self:GetGameObject("GetBtn")
  self._itemModule = GameGlobal.GetModule(ItemModule)
end

function UICollectCardItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UICollectCardItem:SetData(idx, cfg, haveCount, allCount, status, callback, getCb, inited)
  self._idx = idx
  self._callback = callback
  self._getCb = getCb
  self._cfg = cfg
  local icon = self._cfg.Icon
  self._icon:LoadImage(icon)
  local icon2 = self._cfg.IconGray
  self._icon2:LoadImage(icon2)
  local awards = self._cfg.Rewards
  self._pool:SpawnObjects("UICollectCardAward", #awards)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #awards do
    local awardid = awards[i][1]
    local awardcount = awards[i][2]
    local item = pools[i]
    item:SetData(awardid, awardcount, function(id, pos)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampaignCenterShowItemTips, id, pos)
    end)
  end
  local haveCount = haveCount
  self._number:SetText(haveCount .. "/" .. allCount)
  local cfgName = self._cfg.Name
  self._nameTex:SetText(StringTable.Get(cfgName))
  self._got:SetActive(status == QuestStatus.QUEST_Taken)
  self._RedGo:SetActive(status == QuestStatus.QUEST_Completed)
  self._GetBtn:SetActive(status == QuestStatus.QUEST_Completed)
  self:PlayAnim(inited)
end

function UICollectCardItem:PlayAnim(inited)
  if inited then
    self._root.alpha = 1
    return
  end
  local yieldTime = (self._idx - 1) * 66
  if 0 < yieldTime then
    self._root.alpha = 0
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
    self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._anim:Play("uieff_UICollectCardItem_in")
    end)
  else
    self._root.alpha = 0
    self._anim:Play("uieff_UICollectCardItem_in")
  end
end

function UICollectCardItem:IconOnClick(go)
  if self._callback then
    self._callback(self._idx)
  end
end

function UICollectCardItem:GetBtnOnClick(go)
  if self._getCb then
    self._getCb(self._idx)
  end
end
