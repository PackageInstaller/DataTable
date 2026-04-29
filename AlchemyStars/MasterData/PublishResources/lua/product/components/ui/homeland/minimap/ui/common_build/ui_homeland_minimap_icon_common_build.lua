_class("UIHomelandMinimapIconCommonBuild", UIHomelandMinimapIconBase)
UIHomelandMinimapIconCommonBuild = UIHomelandMinimapIconCommonBuild

function UIHomelandMinimapIconCommonBuild:OnShow(uiParams)
  self._selectGO = self:GetGameObject("selected")
  self._museum = self:GetGameObject("Museum")
  self._wishingPool = self:GetGameObject("WishingPool")
  self._storageBox = self:GetGameObject("StorageBox")
  self._album = self:GetGameObject("Album")
  self._medalWall = self:GetGameObject("MedalWall")
end

function UIHomelandMinimapIconCommonBuild:OnInitDone()
  local building = self:GetIconData():GetParam()
  if building:GetBuildType() == ArchitectureSubType.Museum then
    self._museum:SetActive(true)
  elseif building:GetBuildType() == ArchitectureSubType.Wishing_Pool then
    self._wishingPool:SetActive(true)
  elseif building:GetBuildType() == ArchitectureSubType.Storage_Box then
    self._storageBox:SetActive(true)
  elseif building:GetBuildType() == ArchitectureSubType.Album then
    self._album:SetActive(true)
  elseif building:GetBuildType() == ArchitectureSubType.Medal_Wall then
    self._medalWall:SetActive(true)
  end
end

function UIHomelandMinimapIconCommonBuild:OnSelected()
  self._selectGO:SetActive(true)
end

function UIHomelandMinimapIconCommonBuild:OnUnSelected()
  self._selectGO:SetActive(false)
end

function UIHomelandMinimapIconCommonBuild:GetShowName()
  local building = self:GetIconData():GetParam()
  local skinID = building:SkinID()
  local cfgSkin = Cfg.cfg_item_architecture_skin[skinID]
  local name = ""
  if cfgSkin then
    name = StringTable.Get(cfgSkin.SkinName)
  else
    local itemID = building:GetBuildId()
    local cfg = Cfg.cfg_item[itemID]
    name = StringTable.Get(cfg.Name)
  end
  return name
end

function UIHomelandMinimapIconCommonBuild:GetAnimationName(animType)
  if not self._animationNames then
    self._animationNames = {}
    self._animationNames[MinimapIconAnimationType.IN] = "UIHomelandMinimapCommonBuildIcon_in"
    self._animationNames[MinimapIconAnimationType.OUT] = "UIHomelandMinimapCommonBuildIcon_out"
    self._animationNames[MinimapIconAnimationType.SELECT] = "UIHomelandMinimapCommonBuildIcon_Selected_in"
    self._animationNames[MinimapIconAnimationType.UNSELECT] = "UIHomelandMinimapCommonBuildIcon_Selected_out"
    self._animationNames[MinimapIconAnimationType.EXPANSION] = "UIHomelandMinimapCommonBuildIcon_expansion"
  end
  return self._animationNames[animType]
end
