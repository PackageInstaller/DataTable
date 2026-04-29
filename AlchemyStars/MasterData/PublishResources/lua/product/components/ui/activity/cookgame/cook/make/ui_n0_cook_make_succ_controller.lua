_class("UIN0CookMakeSuccController", UIController)
UIN0CookMakeSuccController = UIN0CookMakeSuccController

function UIN0CookMakeSuccController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIN0CookMakeSuccController:OnShow(uiParams)
  self:InitWidget()
  self._dataId = uiParams[1]
  self._afterStoryId = uiParams[2]
  self._foodCfg = Cfg.cfg_component_newyear_dinner_food[self._dataId]
  if not self._foodCfg then
    Log.error("UIN0CookMakeSuccController error , cfg_component_newyear_dinner_food can not find id : " .. self._dataId)
    return
  end
  self._foodId = self._foodCfg.FoodID
  self.title:SetText(StringTable.Get(self._foodCfg.Name))
  self.icon:LoadImage(self._foodCfg.BigTu)
  self:InitReward(self._foodCfg.Reward)
end

function UIN0CookMakeSuccController:InitReward(rewards)
  local len = #rewards
  local items = self.list:SpawnObjects("UIN0CookRewardItem", len)
  for k, v in ipairs(items) do
    local rewardData = rewards[k]
    local tplId = rewardData[1]
    local num = rewardData[2]
    v:SetData(tplId, num, function(id, pos)
      self:OnItemClicked(id, pos)
    end)
  end
end

function UIN0CookMakeSuccController:InitWidget()
  self.list = self:GetUIComponent("UISelectObjectPath", "list")
  self.title = self:GetUIComponent("UILocalizationText", "title")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._selectInfo = self._itemInfo:SpawnObject("UISelectInfo")
end

function UIN0CookMakeSuccController:OnItemClicked(matid, pos)
  self._selectInfo:SetData(matid, pos)
end

function UIN0CookMakeSuccController:MaskOnClick(go)
  self:CloseDialog()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN0CookMakeSucc)
  self:ChecAfterStory()
end

function UIN0CookMakeSuccController:ChecAfterStory()
  if not self._afterStoryId then
    return
  end
  local key = "CookGameAfterStory_" .. self._foodId
  if UIN0CookData.HasKey(key) then
    return
  end
  UIN0CookData.SetKey(key)
  self:ShowDialog("UIStoryController", self._afterStoryId)
end
