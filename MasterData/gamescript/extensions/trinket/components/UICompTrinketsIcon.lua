local MaxEquipTrinketsNum = CommonDefine.MaxEquipTrinketsNum
local UICompTrinketsIcon, Super = NewViewComponent("UICompTrinketsIcon")

function UICompTrinketsIcon:ctor(gameObject, view, trinkets)
  Super.ctor(self, gameObject, view)
  self.trinkets = trinkets or {}
end

function UICompTrinketsIcon:OnBuildComponent()
  self.trinketSuitIcon = self:FindChild(self.gameObject, "Trinket_Icon")
  self.trinketPartIcons = {}
  for i = 1, MaxEquipTrinketsNum do
    self.trinketPartIcons[i] = self:FindChild(self.gameObject, "Team_Icon_0" .. i)
  end
end

function UICompTrinketsIcon:OnEnterComponent()
  self:_RefreshTrinketParts()
  self:_RefreshTrinketSuitIcon()
end

function UICompTrinketsIcon:SetTrinkets(trinkets)
  self.trinkets = trinkets or {}
  self:_RefreshTrinketParts()
  self:_RefreshTrinketSuitIcon()
end

function UICompTrinketsIcon:_RefreshTrinketParts()
  for i = 1, MaxEquipTrinketsNum do
    local imageObj = self.trinketPartIcons[i]
    if not imageObj then
    else
      local trinketUid = self.trinkets[i]
      local trinket
      if trinketUid and trinketUid > 0 then
        trinket = ItemDataUtils.GetItemByUid(trinketUid)
      end
      imageObj:SetActive(nil ~= trinket)
    end
  end
end

function UICompTrinketsIcon:_RefreshTrinketSuitIcon()
  local isGatherAll = TrinketModel.Instance:IsSuitGatherAll(self.trinkets)
  if not isGatherAll then
    self.trinketSuitIcon:SetActive(false)
    return
  end
  self.trinketSuitIcon:SetActive(true)
  local trinketData = ItemDataUtils.GetItemByUid(self.trinkets[1])
  local iconPath = AwakerTrinketDataUtils.GetSuitIcon(trinketData.suitId)
  self:SetImage(self.trinketSuitIcon, iconPath)
end

return UICompTrinketsIcon
