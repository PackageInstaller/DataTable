_class("UIHomelandMinimapIconBaseBuilding", UIHomelandMinimapIconBase)
UIHomelandMinimapIconBaseBuilding = UIHomelandMinimapIconBaseBuilding

function UIHomelandMinimapIconBaseBuilding:OnInitDone()
  self.getable = self:GetGameObject("getable")
  self.selected = self:GetGameObject("Selected")
  self.getable:SetActive(false)
  self:Init()
  self:Flush()
end

function UIHomelandMinimapIconBaseBuilding:Init()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetForgeData()
end

function UIHomelandMinimapIconBaseBuilding:Flush()
  local mapStateCount = self.data:GetSequenceStateCountMap()
  local countGetable = mapStateCount[ForgeSequenceState.Getable]
  if 0 < countGetable then
    self.getable:SetActive(true)
  else
    self.getable:SetActive(false)
  end
end

function UIHomelandMinimapIconBaseBuilding:OnSelected()
  self.selected:SetActive(true)
end

function UIHomelandMinimapIconBaseBuilding:OnUnSelected()
  self.selected:SetActive(false)
end

function UIHomelandMinimapIconBaseBuilding:GetShowName()
  local building = self:GetIconData():GetParam()
  local skinId = building:SkinID()
  local cfg_item_architecture_skin = Cfg.cfg_item_architecture_skin[skinId]
  return StringTable.Get(cfg_item_architecture_skin.SkinName)
end

function UIHomelandMinimapIconBaseBuilding:GetAnimationName(animType)
  if not self._animationNames then
    self._animationNames = {}
    self._animationNames[MinimapIconAnimationType.IN] = "UIHomelandMinimapIconBaseBuilding_in"
    self._animationNames[MinimapIconAnimationType.OUT] = "UIHomelandMinimapIconBaseBuilding_out"
    self._animationNames[MinimapIconAnimationType.SELECT] = "UIHomelandMinimapIconBaseBuilding_Selected_in"
    self._animationNames[MinimapIconAnimationType.UNSELECT] = "UIHomelandMinimapIconBaseBuilding_Selected_out"
    self._animationNames[MinimapIconAnimationType.EXPANSION] = "UIHomelandMinimapIconBaseBuilding_expansion"
  end
  return self._animationNames[animType]
end
