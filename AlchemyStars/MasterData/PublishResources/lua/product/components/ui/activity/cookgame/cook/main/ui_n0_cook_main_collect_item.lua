_class("UIN0CookMainCollectItem", UICustomWidget)
UIN0CookMainCollectItem = UIN0CookMainCollectItem

function UIN0CookMainCollectItem:OnShow(uiParams)
  self._atlas = self:GetAsset("CookGame.spriteatlas", LoadType.SpriteAtlas)
  self:InitWidget()
end

function UIN0CookMainCollectItem:InitWidget()
  self.collectNumText = self:GetUIComponent("UILocalizationText", "collectNumText")
  self.rewardPool = self:GetUIComponent("UISelectObjectPath", "rewardPool")
  self.canReceive = self:GetGameObject("canReceive")
  self.hasReceive = self:GetGameObject("hasReceive")
  self.unReach = self:GetGameObject("unReach")
  self.imgBg = self:GetUIComponent("Image", "imgBg")
  self.animation = self:GetUIComponent("Animation", "animation")
end

function UIN0CookMainCollectItem:SetData(collectData, callback, itemClickCall)
  self.callback = callback
  self.itemClickCall = itemClickCall
  if not collectData then
    Log.error("UIN0CookMainCollectItem collectDara is nil")
    return
  end
  local cfg = collectData.cfg
  self.collectId = cfg.CollectID
  local status = collectData.status
  self.canReceive:SetActive(status == NewYearDinner_Status.E_NewYearDinner_Status_CAN_RECV)
  self.hasReceive:SetActive(status == NewYearDinner_Status.E_NewYearDinner_Status_RECVED)
  local isUnReach = status == NewYearDinner_Status.E_NewYearDinner_Status_LOCK or status == NewYearDinner_Status.E_NewYearDinner_Status_UN_FINISH
  self.unReach:SetActive(isUnReach)
  self:InitReward(cfg.Reward)
  if isUnReach then
    self.imgBg.sprite = self._atlas:GetSprite("n0_xyx_di02")
    self.collectNumText:SetText("<color=#ffdf80>" .. cfg.Count .. "</color>")
  else
    self.imgBg.sprite = self._atlas:GetSprite("n0_xyx_di03")
    self.collectNumText:SetText(cfg.Count)
  end
end

function UIN0CookMainCollectItem:InitReward(rewards)
  local len = #rewards
  local items = self.rewardPool:SpawnObjects("UIN0CookRewardItem", len)
  for k, v in ipairs(items) do
    local rewardData = rewards[k]
    local tplId = rewardData[1]
    local num = rewardData[2]
    v:SetData(tplId, num, function(tplId, pos)
      if self.itemClickCall then
        self.itemClickCall(tplId, pos)
      end
    end)
  end
end

function UIN0CookMainCollectItem:ReceiveBtnOnClick(go)
  if self.callback then
    self.callback(self.collectId)
  end
end

function UIN0CookMainCollectItem:PlayEnterAni()
  self.animation:Play()
end

function UIN0CookMainCollectItem:SetVisible(visible)
  self:GetGameObject():SetActive(visible)
end
