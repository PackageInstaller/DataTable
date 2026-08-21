_class("UIN28GronruGameRewardItem", UICustomWidget)
UIN28GronruGameRewardItem = UIN28GronruGameRewardItem

function UIN28GronruGameRewardItem:Constructor()
end

function UIN28GronruGameRewardItem:OnShow(uiParams)
  self:InitWidget()
end

function UIN28GronruGameRewardItem:OnHide()
end

function UIN28GronruGameRewardItem:SetData(entieId, data, stage, cfg, atlas, manager)
  self._entieId = entieId
  self._data = data
  self._stage = stage
  self._cfg = cfg
  self._atlas = atlas
  self._manager = manager
  self:Flush()
end

function UIN28GronruGameRewardItem:InitWidget()
  self._headImg = self:GetUIComponent("Image", "Head")
  self._countText = self:GetUIComponent("Image", "Count")
  self._countText1 = self:GetUIComponent("Image", "Count1")
  self._rewards = self:GetUIComponent("UISelectObjectPath", "Rewards")
  self._getBtn = self:GetGameObject("Get")
  self._gotBtn = self:GetGameObject("Got")
  self._cantgetBtn = self:GetGameObject("ContGet")
end

function UIN28GronruGameRewardItem:Flush()
  local num = self._cfg.KillNum and self._cfg.KillBossNum > 0 and self._cfg.KillBossNum or self._cfg.KillNum
  local a, b = math.floor(num * 0.1), num % 10
  self._countText.sprite = self._atlas:GetSprite("N28_yrj_junei_nub" .. a)
  self._countText1.sprite = self._atlas:GetSprite("N28_yrj_junei_nub" .. b)
  self._headImg.sprite = self._atlas:GetSprite(self._cfg.Icon)
  self._getBtn:SetActive(self:_CheckState() == 1)
  self._gotBtn:SetActive(self:_CheckState() == 2)
  self._cantgetBtn:SetActive(self._data == nil or self:_CheckState() == 0)
  if self._cfg.Rewards then
    local widgets = self._rewards:SpawnObjects("UIN28GronruItem", #self._cfg.Rewards)
    for i, v in ipairs(self._cfg.Rewards) do
      local rew = {}
      rew.assetid = v[1]
      rew.count = v[2]
      widgets[i]:Flush(rew, self._atlas)
    end
  end
end

function UIN28GronruGameRewardItem:_CheckState()
  local state = 0
  if not self._data then
    return state
  end
  for key, value in pairs(self._data.enties_list) do
    if key == self._entieId then
      return value
    end
  end
  return state
end

function UIN28GronruGameRewardItem:GetOnClick(go)
  if not self._data then
    return
  end
  self._manager:RecieveRewards(self._stage.CampaignMissionId, self._entieId)
end

function UIN28GronruGameRewardItem:ContGetOnClick(go)
  ToastManager.ShowToast(StringTable.Get("str_n28_gronru_minigame_cantgetreward_tip"))
end

function UIN28GronruGameRewardItem:GotOnClick(go)
  ToastManager.ShowToast(StringTable.Get("str_n28_gronru_minigame_gotreward_tip"))
end
