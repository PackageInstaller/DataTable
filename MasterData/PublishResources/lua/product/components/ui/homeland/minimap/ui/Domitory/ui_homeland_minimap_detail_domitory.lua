_class("UIHomelandMinimapDetailDomitory", UIHomelandMinimapDetailBase)
UIHomelandMinimapDetailDomitory = UIHomelandMinimapDetailDomitory

function UIHomelandMinimapDetailDomitory:OnShow()
end

function UIHomelandMinimapDetailDomitory:OnClose()
  UIHomelandMinimapDetailDomitory.super.OnClose(self)
end

function UIHomelandMinimapDetailDomitory:OnInitDone()
  self:_SetSkin()
  self:_SetDomitory()
end

function UIHomelandMinimapDetailDomitory:_SetSkin()
  local iconData = self:GetIconData()
  if not iconData then
    return
  end
  local building = self:GetIconData():GetParam()
  local cfg = Cfg.cfg_item_architecture[building:GetBuildId()]
  UIWidgetHelper.SetLocalizationText(self, "NameTxt", StringTable.Get(cfg.Name))
  UIWidgetHelper.SetLocalizationText(self, "ContentTxt", StringTable.Get(cfg.Des))
  UIWidgetHelper.SetRawImage(self, "Skin", cfg.Icon)
  self._nameTxt = self:GetUIComponent("UILocalizationText", "NameTxt")
  self._titleRect = self:GetUIComponent("RectTransform", "Title")
  if self._titleRect then
    local titleWidth = self._nameTxt.preferredWidth
    if 350 < titleWidth then
      titleWidth = 350
    end
    self._titleRect.sizeDelta = Vector2(titleWidth, self._titleRect.sizeDelta.y)
  end
end

function UIHomelandMinimapDetailDomitory:_SetDomitory()
  local homeLandModule = GameGlobal.GetModule(HomelandModule)
  local petModule = GameGlobal.GetModule(PetModule)
  local building = self:GetIconData():GetParam()
  local room = homeLandModule:GetDomitoryByPstID(building:GetBuildPstId())
  local petLoader = self:GetUIComponent("UISelectObjectPath", "Domitory")
  local pets = petLoader:SpawnObjects("UIHomelandMinimapDetailPetItem", 4)
  local building = self:GetIconData():GetParam()
  for i = 1, 4 do
    local petpstid = room.petList[i]
    local pet
    if petpstid and 0 < petpstid then
      pet = petModule:GetPet(petpstid)
    end
    pets[i]:SetData(pet)
  end
  local name = room.name
  if string.isnullorempty(name) then
    name = StringTable.Get("str_homeland_domitory_default_name")
  end
  UIWidgetHelper.SetLocalizationText(self, "txtTitle", name)
end

function UIHomelandMinimapDetailDomitory:CloseBtnOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapCloseDetailUI)
  self:OnClose()
end

function UIHomelandMinimapDetailDomitory:ConfirmBtnOnClick(go)
  self:CloseBtnOnClick(go)
end

function UIHomelandMinimapDetailDomitory:GetCloseAnimtionName()
  return "UIHomelandMinimapDetailDomitory_out"
end
