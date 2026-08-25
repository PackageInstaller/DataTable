local AwakerFavorSourceShowView, Super = NewClass("AwakerFavorSourceShowView", BaseView)
AwakerFavorSourceShowView.uiResCls = UI_Dungeons_Tip_AwakerFavorResource
local COLOR_BLUE = "#64EBFF"
local COLOR_WHITE = "#FFFFFF"
local FIELD_MAP = {
  {
    key = "expectedLike",
    langKey = "FavorSettleShowSourceTabTotal"
  },
  {
    key = "card",
    langKey = "FavorSettleShowSourceTabCard"
  },
  {
    key = "cost",
    langKey = "FavorSettleShowSourceTabCost"
  },
  {
    key = "madness",
    langKey = "FavorSettleShowSourceTabUlti"
  },
  {
    key = "silverKey",
    langKey = "FavorSettleShowSourceTabKeeper"
  },
  {
    key = "manual",
    langKey = "FavorSettleShowSourceTabManual"
  },
  {
    key = "activityAddition",
    langKey = "FavorSettleShowSourceTabActivity"
  },
  {
    key = "weaponAddition",
    langKey = "FavorSettleShowSourceTabWeapon"
  },
  {
    key = "assistAddition",
    langKey = "FavorSettleShowSourceTabAssist"
  }
}
local HideZeroList = {
  activityAddition = true,
  weaponAddition = true,
  assistAddition = true
}

function AwakerFavorSourceShowView:ctor(data)
  Super.ctor(self)
  self._favorScore = data.favorScore or {}
  self._awakerTids = data.awakerTids
  self.filtedMap = {}
end

function AwakerFavorSourceShowView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Close, System.fn(self, self.Close))
end

function AwakerFavorSourceShowView:OnEnterView()
  Super.OnEnterView(self)
  if self.ui.UI_Dungeons_Item_AwakerFavor then
    self.ui.UI_Dungeons_Item_AwakerFavor:SetActive(false)
  end
  self:SetFiltedMap()
  self:_InitValueLabels()
  local awakerTids = self:_GetSortedAwakerTids()
  for i, awakerTid in ipairs(awakerTids) do
    self:_InitItem(i, awakerTid, self._favorScore[awakerTid])
  end
end

function AwakerFavorSourceShowView:SetFiltedMap()
  self.filtedMap = table.deepclone(FIELD_MAP)
  for i = #FIELD_MAP, 1, -1 do
    local field = FIELD_MAP[i]
    if field.key and HideZeroList[field.key] then
      local sum = 0
      for _, scoreData in pairs(self._favorScore) do
        sum = sum + (scoreData[field.key] or 0)
      end
      if sum <= 0 then
        table.remove(self.filtedMap, i)
      end
    end
  end
end

function AwakerFavorSourceShowView:_GetSortedAwakerTids()
  if self._awakerTids and #self._awakerTids > 0 then
    return self._awakerTids
  end
  local tids = {}
  for tid in pairs(self._favorScore) do
    table.insert(tids, tid)
  end
  table.sort(tids)
  return tids
end

function AwakerFavorSourceShowView:_InitItem(index, awakerTid, scoreData)
  local go = GameObject.Instantiate(self.ui.UI_Dungeons_Item_AwakerFavor, self.ui.Group_TeamAwakerLike.transform)
  go:SetActive(true)
  local itemUi = UI_Dungeons_Item_AwakerFavorResource(go)
  local icon = AwakerDataUtils.GetLittleIcon(awakerTid)
  self:SetImage(itemUi.Icon_Awaker, icon)
  self:_InitHomology(itemUi, awakerTid)
  self:_InitValueTexts(itemUi, awakerTid, scoreData)
end

function AwakerFavorSourceShowView:_InitHomology(itemUi, awakerTid)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData then
    return
  end
  if itemUi.Text_Homology_Lv then
    self:SetText(itemUi.Text_Homology_Lv, LT.Text(awakerData.likeLevel))
  end
  local isMaxLikeLevel = AwakerFavorabilityCfgUtils.IsMaxAwakerLikeLevel(awakerData.tid, awakerData.likeLevel)
  if itemUi.Image_Homology then
    local imgProgress = itemUi.Image_Homology:GetComponent(typeof(CS.UnityEngine.UI.Image))
    if isMaxLikeLevel then
      imgProgress.fillAmount = 1
    else
      local expLimit = AwakerDataUtils.GetAwakerLikeExpRequire(awakerData.tid)
      imgProgress.fillAmount = expLimit > 0 and awakerData.like / expLimit or 0
    end
  end
  if itemUi.Image_AwakerFavor_Max then
    local showFavor = FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(awakerTid, awakerData)
    itemUi.Image_AwakerFavor_Max:SetActive(showFavor)
  end
end

function AwakerFavorSourceShowView:_InitValueLabels()
  local labelParentNode = self.ui.Group_Content
  local labelTemplate = self.ui.Text_AwakerFavor_Title
  for _, field in ipairs(self.filtedMap) do
    local labelGo = GameObject.Instantiate(labelTemplate, labelParentNode.transform)
    labelGo:SetActive(true)
    self:SetText(labelGo, LT.Text(field.langKey))
  end
end

function AwakerFavorSourceShowView:_InitValueTexts(itemUi, awakerTid, scoreData)
  local textParentNode = itemUi.Group_Values
  local valueTemplate = itemUi.Text_AwakerFavor_Value
  local isMax = AwakerFavorabilityCfgUtils.IsLikeExpFull(awakerTid)
  for _, field in ipairs(self.filtedMap) do
    local valueGo = GameObject.Instantiate(valueTemplate.gameObject, textParentNode.transform)
    valueGo:SetActive(true)
    local color = field.key == "expectedLike" and COLOR_BLUE or COLOR_WHITE
    local text
    if isMax then
      text = LT.Text("ExploreStressMax")
    else
      text = self:_FormatValueText(scoreData[field.key] or 0)
    end
    self:SetText(valueGo, StrUtils.GetColorText(text, color))
  end
end

function AwakerFavorSourceShowView:_FormatValueText(val)
  if val > 0 then
    return "+" .. val
  elseif val < 0 then
    do return tostring end
    return tostring, val
  else
    return "+0"
  end
end

return AwakerFavorSourceShowView
