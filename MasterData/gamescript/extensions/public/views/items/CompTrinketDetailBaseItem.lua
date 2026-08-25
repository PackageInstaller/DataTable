local MAX_TRINKET_NUM = 6
local CompTrinketDetailBaseItem, Super = NewViewComponent("CompTrinketDetailBaseItem")

function CompTrinketDetailBaseItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = data.resource(uiNode)
  self.data = data
  self.trinketDatas = self.data.trinketDatas
end

function CompTrinketDetailBaseItem:RegisterEvents()
  if self.data.btnObjName and self.ui[self.data.btnObjName] and self.data.clickFunc then
    self:AddButtonClickListener(self.ui[self.data.btnObjName], self.data.clickFunc)
  end
end

function CompTrinketDetailBaseItem:OnEnterComponent()
  if not self.trinketDatas then
    return
  end
  self:_InitTrinketPart()
  self:_InitSuitImage()
end

function CompTrinketDetailBaseItem:_InitSuitImage()
  if not self.data.suitImageObjName and self.ui[self.data.suitImageObjName] then
    return
  end
  local suitImageObj = self.ui[self.data.suitImageObjName]
  local isSuitGatherAll = AwakerTrinketDataUtils.IsSuitGatherAll(self.trinketDatas)
  self:SetActive(suitImageObj, isSuitGatherAll)
  if isSuitGatherAll then
    local suitId = self.trinketDatas[1].suitId
    self:SetImage(suitImageObj, AwakerTrinketDataUtils.GetSuitIcon(suitId))
  end
  if self.data.specialTeamTrinketSuit then
    self:SetActive(suitImageObj, true)
    local suitId = self.data.specialTeamTrinketSuit
    self:SetImage(suitImageObj, AwakerTrinketDataUtils.GetSuitIcon(suitId))
  end
end

function CompTrinketDetailBaseItem:_InitTrinketPart()
  if not self.data.trinketImageObjPreName then
    return
  end
  local haveEquipTrinket = false
  for i = 1, MAX_TRINKET_NUM do
    local trinketImageObj = self.ui[self.data.trinketImageObjPreName .. i]
    local trinketData = self.trinketDatas[i]
    local uid = trinketData and trinketData.uid or 0
    local isValid = uid and uid > 0
    if trinketImageObj then
      trinketImageObj:SetActive(isValid)
    end
    if isValid then
      haveEquipTrinket = isValid
    end
  end
  if self.data.addImageObjName and self.ui[self.data.addImageObjName] then
    self.ui[self.data.addImageObjName]:SetActive(self.data.showAddImage and haveEquipTrinket)
  end
  if not haveEquipTrinket then
    self.ui.Image_Conversion:SetActive(false)
    self:SetText(self.ui.Text_Conversion, "")
  else
    self.ui.Image_Conversion:SetActive(true)
    self:SetText(self.ui.Text_Conversion, AwakerTrinketDataUtils.GetTrinketSuitCompletionRate(self.trinketDatas) .. "%")
  end
end

function CompTrinketDetailBaseItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompTrinketDetailBaseItem
