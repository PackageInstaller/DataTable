require("ui_n12_map_controller")
_class("UIN12MapQuestController", UIN12MapController)
UIN12MapQuestController = UIN12MapQuestController

function UIN12MapQuestController:GetComponents()
  self._headIcon = self:GetUIComponent("RawImageLoader", "head")
  self._talkTex = self:GetUIComponent("UILocalizationText", "talk")
  self._btnTex = self:GetUIComponent("UILocalizedTMP", "btnTex")
  self._passGo = self:GetGameObject("pass")
  self._alpha = self:GetUIComponent("CanvasGroup", "btnTex")
  self._btnImg = self:GetUIComponent("Image", "btn")
  self._btn = self:GetUIComponent("Button", "btn")
  self._contentSizeFitter = self:GetUIComponent("ContentSizeFitter", "btnTex")
  self._btnTexRect = self:GetUIComponent("RectTransform", "btnTex")
  self._atlas = self:GetAsset("UIN12_Entrust.spriteatlas", LoadType.SpriteAtlas)
end

function UIN12MapQuestController:OnValue()
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self:SetPass(true)
  local cfg = self:Cfg()
  local params = cfg.Params[1]
  if cfg.EventType == 5 then
    self._questType = 1
  elseif cfg.EventType == 6 then
    self._questType = 2
  else
    Log.error("###[UIN12MapQuestController] cfg.EventType is not 5 or 6 ! cfg.EventType --> ", cfg.EventType, "| nodeid --> ", self._nodeid)
  end
  local talk = params.Desc
  self._talkTex:SetText(StringTable.Get(talk))
  local head = params.Head
  if head then
    self._headIcon:LoadImage(head)
  end
  self._showNumber = params.ShowNumber and params.ShowNumber == 1
  self._rewards = cfg.RewardList
  self:SetTextMat()
  self:ShowBtnTex()
end

function UIN12MapQuestController:ShowBtnTex()
  local cfg_item = Cfg.cfg_item({})
  local tex = ""
  self._rewardTex = ""
  for i = 1, #self._rewards do
    local item = {}
    item.id = self._rewards[i][1]
    item.count = self._rewards[i][2]
    local _cfg_item = cfg_item[item.id]
    item.name = _cfg_item.Name
    local itemName = StringTable.Get(item.name)
    if 1 < item.count then
      itemName = StringTable.Get("str_n12_map_quest_x", itemName, item.count)
    end
    if i == 1 then
      self._rewardTex = self._rewardTex .. itemName
    elseif i == #self._rewards then
      self._rewardTex = StringTable.Get("str_n12_map_quest_and", self._rewardTex, itemName)
    else
      self._rewardTex = StringTable.Get("str_n12_map_quest_point", self._rewardTex, itemName)
    end
  end
  if self._questType == 1 then
    tex = StringTable.Get("str_n12_map_quest_get", self._rewardTex)
  elseif self._questType == 2 then
    tex = StringTable.Get("str_n12_map_quest_send", self._rewardTex)
    if self._showNumber then
      local firstID = self._rewards[1][1]
      local firstCount = self._itemModule:GetItemCount(firstID)
      tex = tex .. StringTable.Get("str_n12_map_quest_owner", firstCount)
    end
  end
  self._btnTex:SetText(tex)
  self:ChangeTextWidth(self._btnTex)
end

function UIN12MapQuestController:btnOnClick(go)
  if self._pass then
    return
  end
  if self._questType == 2 and not self:Enough() then
    local tips = StringTable.Get("str_n12_map_quest_not_enough")
    ToastManager.ShowToast(tips)
    return
  end
  self:RequestFinishEvent()
end

function UIN12MapQuestController:Enough()
  if not self._itemModule then
    self._itemModule = self:GetGameObject(ItemModule)
  end
  local enough = true
  for _, reward in pairs(self._rewards) do
    local count = reward[2]
    local haveCount = self._itemModule:GetItemCount(reward[1])
    if count > haveCount then
      enough = false
      break
    end
  end
  return enough
end

function UIN12MapQuestController:OnFinishEvent(rewards)
  local tips
  if self._questType == 1 then
    tips = StringTable.Get("str_n12_map_quest_get", self._rewardTex)
  elseif self._questType == 2 then
    tips = StringTable.Get("str_n12_map_quest_finish")
  end
  ToastManager.ShowToast(tips)
  self:RefreshPass()
end

function UIN12MapQuestController:RefreshPass()
  self:SetPass(true)
  self:ShowBtnTex()
end
