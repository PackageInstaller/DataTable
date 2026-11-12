local SideBannerCtrl = class("SideBannerCtrl", BaseCtrl)
local Height = {
  [1] = 141.5,
  [2] = 181.1
}
local Spacing = 18.5
SideBannerCtrl._mapNodeConfig = {
  rtContent = {sComponentName = "Transform"},
  goEntry = {},
  goReward = {},
  goFavour = {},
  goAchievement = {},
  goItem = {}
}
SideBannerCtrl._mapEventConfig = {}

function SideBannerCtrl:Popup(tbList)
  self.sequence = DOTween.Sequence()
  self.sequence:SetUpdate(true)
  local nCount = #tbList
  local tbItem = {}
  for _, mapData in ipairs(tbList) do
    local mapItem = self:CreateBanner(mapData)
    table.insert(tbItem, mapItem)
    self.sequence:AppendCallback(function()
      mapItem.animator:Play("DictionaryPanel_reward_in")
    end)
    self.sequence:AppendInterval(0.1)
  end
  self.sequence:AppendInterval(0.333)
  if nCount == 1 then
    self.sequence:AppendInterval(1)
  end
  for k, _ in pairs(tbItem) do
    self.sequence:AppendCallback(function()
      local nHeight = self:GetMoveHeght(tbItem, k)
      for i = k + 1, nCount do
        tbItem[i].transform:DOLocalMoveY(nHeight, 0.2):SetEase(Ease.OutQuad):SetUpdate(true)
      end
      tbItem[k].animator:Play("DictionaryPanel_reward_out")
    end)
    self.sequence:AppendInterval(0.45)
  end
  self.sequence.onComplete = dotween_callback_handler(self, function()
    EventManager.Hit("CloseSideBanner")
  end)
end

function SideBannerCtrl:GetMoveHeght(tbItem, nIndex)
  local nHeight = 0
  for i = 1, nIndex do
    nHeight = nHeight + tbItem[i].height + Spacing
  end
  return nHeight
end

function SideBannerCtrl:CreateBanner(mapData)
  if mapData.nType == AllEnum.SideBaner.DictionaryEntry then
    return self:CreateEntry(mapData)
  elseif mapData.nType == AllEnum.SideBaner.DictionaryReward then
    return self:CreateReward(mapData)
  elseif mapData.nType == AllEnum.SideBaner.Favour then
    return self:CreateFavour(mapData)
  elseif mapData.nType == AllEnum.SideBaner.Achievement then
    return self:CreateAchievement(mapData)
  elseif mapData.nType == AllEnum.SideBaner.Item then
    return self:CreateItem(mapData)
  end
end

function SideBannerCtrl:CreateEntry(mapData)
  local goItem = instantiate(self._mapNode.goEntry, self._mapNode.rtContent)
  goItem:SetActive(true)
  local rtItem = goItem.transform:GetComponent("RectTransform")
  local trRoot = goItem.transform:Find("AnimRoot")
  local rtBg = trRoot:Find("imgBg"):GetComponent("RectTransform")
  local txtTitle = trRoot:Find("imgBg/txtTitle"):GetComponent("TMP_Text")
  local txtDone = trRoot:Find("imgBg/txtDone"):GetComponent("TMP_Text")
  local aniItem = trRoot:GetComponent("Animator")
  local goOther = trRoot:Find("imgBg/Other").gameObject
  local txtOther = trRoot:Find("imgBg/Other/txtOther"):GetComponent("TMP_Text")
  local mapCfg = ConfigTable.GetData("DictionaryEntry", mapData.nId)
  if mapCfg then
    NovaAPI.SetTMPText(txtTitle, mapCfg.Title)
  else
    NovaAPI.SetTMPText(txtTitle, "title error")
  end
  NovaAPI.SetTMPText(txtDone, ConfigTable.GetUIText("SideBanner_Dictionary_Get"))
  local bOther = mapData.nOtherCount ~= nil and mapData.nOtherCount > 0
  local nHeight = Height[bOther and 2 or 1]
  rtItem.sizeDelta = Vector2(rtItem.sizeDelta.x, nHeight)
  rtBg.sizeDelta = Vector2(rtBg.sizeDelta.x, nHeight)
  goOther:SetActive(bOther)
  if bOther then
    NovaAPI.SetTMPText(txtOther, orderedFormat(ConfigTable.GetUIText("SideBanner_Dictionary_Count"), mapData.nOtherCount))
  end
  local mapAfter = {
    animator = aniItem,
    transform = trRoot,
    height = nHeight
  }
  return mapAfter
end

function SideBannerCtrl:CreateReward(mapData)
  local goItem = instantiate(self._mapNode.goReward, self._mapNode.rtContent)
  goItem:SetActive(true)
  local rtItem = goItem.transform:GetComponent("RectTransform")
  local trRoot = goItem.transform:Find("AnimRoot")
  local rtBg = trRoot:Find("imgBg"):GetComponent("RectTransform")
  local imgRewardIcon = trRoot:Find("imgBg/imgRewardIcon"):GetComponent("Image")
  local txtRewardCount = trRoot:Find("imgBg/txtRewardCount"):GetComponent("TMP_Text")
  local txtRewardTitle = trRoot:Find("imgBg/txtRewardTitle"):GetComponent("TMP_Text")
  local aniItem = trRoot:GetComponent("Animator")
  local goOther = trRoot:Find("imgBg/Other").gameObject
  local txtOther = trRoot:Find("imgBg/Other/txtOther"):GetComponent("TMP_Text")
  self:SetSprite_Coin(imgRewardIcon, mapData.mapReward.id)
  NovaAPI.SetTMPText(txtRewardCount, mapData.mapReward.count)
  NovaAPI.SetTMPText(txtRewardTitle, ConfigTable.GetUIText("SideBanner_Reward_Get"))
  local bOther = mapData.nOtherCount ~= nil and mapData.nOtherCount > 0
  local nHeight = Height[bOther and 2 or 1]
  rtItem.sizeDelta = Vector2(rtItem.sizeDelta.x, nHeight)
  rtBg.sizeDelta = Vector2(rtBg.sizeDelta.x, nHeight)
  goOther:SetActive(bOther)
  if bOther then
    NovaAPI.SetTMPText(txtOther, orderedFormat(ConfigTable.GetUIText("SideBanner_Reward_Count"), mapData.nOtherCount))
  end
  local mapAfter = {
    animator = aniItem,
    transform = trRoot,
    height = nHeight
  }
  return mapAfter
end

function SideBannerCtrl:CreateFavour(mapData)
  local goItem = instantiate(self._mapNode.goFavour, self._mapNode.rtContent)
  goItem:SetActive(true)
  local rtItem = goItem.transform:GetComponent("RectTransform")
  local trRoot = goItem.transform:Find("AnimRoot")
  local rtBg = trRoot:Find("imgBg"):GetComponent("RectTransform")
  local aniItem = trRoot:GetComponent("Animator")
  local imgHead = trRoot:Find("imgBg/imgHead"):GetComponent("Image")
  local txtFavourLevel = trRoot:Find("imgBg/txtFavourLevel"):GetComponent("TMP_Text")
  local txtName = trRoot:Find("imgBg/txtName"):GetComponent("TMP_Text")
  local txtDesc = trRoot:Find("imgBg/txtDesc"):GetComponent("TMP_Text")
  local imgHeart = trRoot:Find("imgBg/imgHeart"):GetComponent("Image")
  local goOther = trRoot:Find("imgBg/Other").gameObject
  local txtOther = trRoot:Find("imgBg/Other/txtOther"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtDesc, ConfigTable.GetUIText("SideBanner_Favour_Get"))
  local nSkinId = PlayerData.Char:GetCharSkinId(mapData.nId)
  local mapCfgData_Skin = ConfigTable.GetData_CharacterSkin(nSkinId)
  if mapCfgData_Skin then
    self:SetPngSprite(imgHead, mapCfgData_Skin.Icon, AllEnum.CharHeadIconSurfix.L)
  end
  local mapFavour = PlayerData.Char:GetCharAffinityData(mapData.nId)
  local level = 0
  if mapFavour ~= nil then
    level = mapFavour.Level
  end
  NovaAPI.SetTMPText(txtFavourLevel, level)
  local mapCharCfg = ConfigTable.GetData_Character(mapData.nId)
  if mapCharCfg then
    NovaAPI.SetTMPText(txtName, mapCharCfg.Name)
  end
  local mapAffinity = {}
  
  local function forEachAffinityLevel(mapLine)
    if mapLine.AffinityLevel == level then
      mapAffinity = mapLine
    end
  end
  
  ForEachTableLine(DataTable.AffinityLevel, forEachAffinityLevel)
  if mapAffinity.AffinityLevelIcon ~= "" then
    self:SetPngSprite(imgHeart, mapAffinity.AffinityLevelIcon)
  end
  local bOther = mapData.nOtherCount ~= nil and 0 < mapData.nOtherCount
  local nHeight = Height[bOther and 2 or 1]
  rtItem.sizeDelta = Vector2(rtItem.sizeDelta.x, nHeight)
  rtBg.sizeDelta = Vector2(rtBg.sizeDelta.x, nHeight)
  goOther:SetActive(bOther)
  if bOther then
    NovaAPI.SetTMPText(txtOther, orderedFormat(ConfigTable.GetUIText("SideBanner_Favour_Count"), mapData.nOtherCount))
  end
  local mapAfter = {
    animator = aniItem,
    transform = trRoot,
    height = nHeight
  }
  return mapAfter
end

function SideBannerCtrl:CreateAchievement(mapData)
  local goItem = instantiate(self._mapNode.goAchievement, self._mapNode.rtContent)
  goItem:SetActive(true)
  local rtItem = goItem.transform:GetComponent("RectTransform")
  local trRoot = goItem.transform:Find("AnimRoot")
  local rtBg = trRoot:Find("imgBg"):GetComponent("RectTransform")
  local txtTitle = trRoot:Find("imgBg/txtTitle"):GetComponent("TMP_Text")
  local txtDone = trRoot:Find("imgBg/txtDone"):GetComponent("TMP_Text")
  local aniItem = trRoot:GetComponent("Animator")
  local goOther = trRoot:Find("imgBg/Other").gameObject
  local txtOther = trRoot:Find("imgBg/Other/txtOther"):GetComponent("TMP_Text")
  local imgCup = trRoot:Find("imgBg/imgCup"):GetComponent("Image")
  local mapCfg = ConfigTable.GetData("Achievement", mapData.nId)
  if mapCfg then
    NovaAPI.SetTMPText(txtTitle, mapCfg.Title)
    self:SetPngSprite(imgCup, "UI/big_sprites/zs_achievement_cup_0" .. mapCfg.Rarity)
  else
    NovaAPI.SetTMPText(txtTitle, "Achievement error")
  end
  NovaAPI.SetTMPText(txtDone, ConfigTable.GetUIText("SideBanner_Achieve_Get"))
  local bOther = mapData.nOtherCount ~= nil and mapData.nOtherCount > 0
  local nHeight = Height[bOther and 2 or 1]
  rtItem.sizeDelta = Vector2(rtItem.sizeDelta.x, nHeight)
  rtBg.sizeDelta = Vector2(rtBg.sizeDelta.x, nHeight)
  goOther:SetActive(bOther)
  if bOther then
    NovaAPI.SetTMPText(txtOther, orderedFormat(ConfigTable.GetUIText("SideBanner_Achieve_Count"), mapData.nOtherCount))
  end
  local mapAfter = {
    animator = aniItem,
    transform = trRoot,
    height = nHeight
  }
  return mapAfter
end

function SideBannerCtrl:CreateItem(mapData)
  local goItem = instantiate(self._mapNode.goItem, self._mapNode.rtContent)
  goItem:SetActive(true)
  local trRoot = goItem.transform:Find("AnimRoot")
  local txtTitle = trRoot:Find("imgBg/txtTitle"):GetComponent("TMP_Text")
  local aniItem = trRoot:GetComponent("Animator")
  local txtItemCount = trRoot:Find("imgBg/txtItemCount"):GetComponent("TMP_Text")
  local imgItemIcon = trRoot:Find("imgBg/imgItemIcon"):GetComponent("Image")
  local mapCfg = ConfigTable.GetData_Item(mapData.mapReward.id)
  if mapCfg then
    self:SetPngSprite(imgItemIcon, mapCfg.Icon)
  end
  NovaAPI.SetTMPText(txtItemCount, "×" .. mapData.mapReward.count)
  NovaAPI.SetTMPText(txtTitle, ConfigTable.GetUIText("GachaItemTIpsTitle"))
  local mapAfter = {
    animator = aniItem,
    transform = trRoot,
    height = 140
  }
  return mapAfter
end

function SideBannerCtrl:ProcessList(tbList)
  table.sort(tbList, function(a, b)
    return a.nType < b.nType
  end)
  return tbList
end

function SideBannerCtrl:Awake()
end

function SideBannerCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    local tbList = self:ProcessList(tbParam)
    self:Popup(tbList)
  end
end

function SideBannerCtrl:OnDisable()
  if self.sequence then
    self.sequence:Kill()
    self.sequence = nil
  end
end

function SideBannerCtrl:OnDestroy()
end

return SideBannerCtrl
