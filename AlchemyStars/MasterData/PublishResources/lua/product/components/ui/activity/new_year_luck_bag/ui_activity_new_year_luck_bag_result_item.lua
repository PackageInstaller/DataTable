_class("UIActivityNewYearLuckBagResultItem", UICustomWidget)
UIActivityNewYearLuckBagResultItem = UIActivityNewYearLuckBagResultItem

function UIActivityNewYearLuckBagResultItem:OnShow()
  self._resultText = self:GetUIComponent("UILocalizationText", "resultText")
  self._petText = self:GetUIComponent("UILocalizationText", "petText")
  self._petName = self:GetUIComponent("UILocalizationText", "petName")
  self._reward = self:GetUIComponent("UISelectObjectPath", "reward")
  self._rewardCanvasGroup = self:GetUIComponent("CanvasGroup", "reward")
  self._finishReward = self:GetGameObject("finishReward")
  self._titleRawImage = self:GetUIComponent("RawImageLoader", "titleRawImage")
  self.titleRawImageCfg = {
    [3] = "N41_xncq_jq_wz01",
    [4] = "N41_xncq_jq_wz03",
    [5] = "N41_xncq_jq_wz02"
  }
end

function UIActivityNewYearLuckBagResultItem:FlushData(lotteryInfo, uiCtrl, isGet, clickCallback)
  self._rewardCanvasGroup.alpha = 1
  local drawCfgId = lotteryInfo.draw_cfg_id
  local randomType = lotteryInfo.random_type
  local rewardPetId = lotteryInfo.pet_cfg_id
  local rewards = lotteryInfo.m_rewards
  self._clickCallback = clickCallback
  local rewardPetCfg = Cfg.cfg_component_random_lottery_draw_pet[rewardPetId]
  self._titleRawImage:LoadImage(self.titleRawImageCfg[rewardPetCfg.DrawCfgID])
  self._resultText:SetText(StringTable.Get("str_cn12_n41_game_luck" .. randomType))
  self._petText:SetText(StringTable.Get(rewardPetCfg.PetSpeak))
  self._petName:SetText(StringTable.Get(rewardPetCfg.PetName))
  self._reward:SpawnObjects("UIActivityNewYearLuckBagAwardItem", #rewards)
  local items = self._reward:GetAllSpawnList()
  for i = 1, #items do
    local tb = {}
    local roleAsset = rewards[i]
    local cfgItem = Cfg.cfg_item[roleAsset.assetid]
    tb.assetid = roleAsset.assetid
    tb.icon = cfgItem.Icon
    tb.count = roleAsset.count
    tb.quality = cfgItem.Color
    items[i]:SetData(tb, function(id, pos)
      if self._clickCallback then
        self._clickCallback(id, pos)
      end
    end)
  end
  self:SetFinishDrawState(isGet)
end

function UIActivityNewYearLuckBagResultItem:SetFinishDrawState(isGet)
  self._finishReward:SetActive(isGet)
  if isGet then
    self._rewardCanvasGroup.alpha = 0.5
  end
end

function UIActivityNewYearLuckBagResultItem:OnHide()
end
