local MaxEquipTrinketsNum = CommonDefine.MaxEquipTrinketsNum
local UICompEquipedTrinketsInfo, Super = NewViewComponent("UICompEquipedTrinketsInfo")

function UICompEquipedTrinketsInfo:ctor(gameObject, view, enableBoundLight)
  Super.ctor(self, gameObject, view)
  self.enableBoundLight = enableBoundLight and true or false
  self.boundLightFilter = type(enableBoundLight) == "function" and enableBoundLight or nil
end

function UICompEquipedTrinketsInfo:OnBuildComponent()
  self.Group_Parts = self:FindChild(self.gameObject, "Group_Parts")
  self.trinketSuitIcon = self:FindChild(self.gameObject, "Image_Finish")
  self.trinketPartIcons = {}
  for i = 1, MaxEquipTrinketsNum do
    local partnodeName = "Group_Parts/Btn_Parts_" .. i
    local iconCfg = {
      icon = self:FindChild(self.gameObject, partnodeName .. "/Image_Parts_" .. i),
      selectImage = self:FindChild(self.gameObject, partnodeName .. "/Image_Select_Patrs_" .. i)
    }
    if self.enableBoundLight and iconCfg.icon then
      iconCfg.lightComp = self:AddViewComponentOnce(iconCfg.icon, UICompTrinketIconMat)
    end
    self.trinketPartIcons[i] = iconCfg
  end
end

function UICompEquipedTrinketsInfo:RegisterEvents()
  for i = 1, MaxEquipTrinketsNum do
    local go = self:FindChild(self.gameObject, "Group_Parts/Btn_Parts_" .. i)
    if go then
      self:AddButtonClickListener(go, function()
        self:_OnClickPart(i)
      end)
    end
  end
end

function UICompEquipedTrinketsInfo:SetTrinkets(trinkets)
  self.trinkets = trinkets
  self:_RefreshTrinketParts()
  self:_RefreshTrinketSuitIcon()
end

function UICompEquipedTrinketsInfo:SelectPart(part)
  for i = 1, MaxEquipTrinketsNum do
    local selectImage = self.trinketPartIcons[i].selectImage
    if not selectImage then
    else
      selectImage:SetActive(part == i)
    end
  end
end

function UICompEquipedTrinketsInfo:SetDelegate(delegate)
  self.delegate = delegate
end

function UICompEquipedTrinketsInfo:_RefreshTrinketParts()
  if not self.trinkets or 0 == table.length(self.trinkets) then
    self.Group_Parts:SetActive(false)
    for i = 1, MaxEquipTrinketsNum do
      self:_RefreshPartLight(i, false)
    end
    return
  end
  self.Group_Parts:SetActive(true)
  for i = 1, MaxEquipTrinketsNum do
    local imageObj = self.trinketPartIcons[i].icon
    if not imageObj then
    else
      local trinketUid = self.trinkets[i]
      local isExisted = trinketUid and trinketUid > 0
      if not isExisted then
        imageObj:SetActive(false)
        self:_RefreshPartLight(i, false)
      else
        local trinket = ItemDataUtils.GetItemByUid(trinketUid)
        if not trinket then
          imageObj:SetActive(false)
          self:_RefreshPartLight(i, false)
        else
          imageObj:SetActive(true)
          local iconPath = ItemDataUtils.GetItemIcon(trinket.tid)
          self:SetImage(imageObj, iconPath)
          self:_RefreshPartLight(i, self:_CalBoundLight(trinketUid))
        end
      end
    end
  end
end

function UICompEquipedTrinketsInfo:_RefreshPartLight(part, visible)
  if not self.enableBoundLight then
    return
  end
  local lightComp = self.trinketPartIcons[part].lightComp
  if lightComp then
    lightComp:EnableLight(visible, part)
  end
end

function UICompEquipedTrinketsInfo:_CalBoundLight(uid)
  if self.boundLightFilter then
    return self.boundLightFilter(uid) == true
  end
  return true
end

function UICompEquipedTrinketsInfo:_RefreshTrinketSuitIcon()
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

function UICompEquipedTrinketsInfo:_OnClickPart(part)
  if self.delegate then
    self.delegate:OnClickTrinketPartType(part, true)
  end
end

return UICompEquipedTrinketsInfo
