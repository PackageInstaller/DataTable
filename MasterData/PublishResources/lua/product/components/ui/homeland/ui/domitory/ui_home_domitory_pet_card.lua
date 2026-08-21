_class("UIHomeDomitoryPetCard", UICustomWidget)
UIHomeDomitoryPetCard = UIHomeDomitoryPetCard

function UIHomeDomitoryPetCard:OnShow(uiParams)
  self:InitWidget()
end

function UIHomeDomitoryPetCard:InitWidget()
  self.root = self:GetGameObject("root")
  self.info = self:GetUIComponent("UISelectObjectPath", "info")
  self.noinfo = self:GetGameObject("noinfo")
  self.btn = self:GetGameObject("btn")
  self.noinfotext = self:GetUIComponent("UILocalizationText", "noinfotext")
  self.bg = self:GetGameObject("bg")
  self.settled = self:GetGameObject("settled")
  self.cantSettle = self:GetGameObject("cantSettle")
  local affinity = self:GetUIComponent("UISelectObjectPath", "affinity")
  self._affinity = affinity:SpawnObject("UIHomePetAffinityItem")
  self._spPet = self:GetUIComponent("UISelectObjectPath", "spPet")
end

function UIHomeDomitoryPetCard:SetData(pet, removeOne, onClick)
  self._pet = pet
  self._onClick = onClick
  local spPetActive, tex = self:CheckHomeSpPet()
  self._spPetItem = self._spPet:SpawnObject("UIHomeSpPet")
  self._spPetItem:SetData(spPetActive, tex)
  self._card = self.info:SpawnObject("UIHeartItem")
  self._card:SetData(pet, nil, false, false, nil, nil, false, spPetActive)
  self._affinity:SetData(pet)
  local module = self:GetModule(HomelandModule)
  self._canSettle = module:PetCanSettle(self._pet:GetTemplateID())
  if self._canSettle then
    self._isSettled = module:GetPetSettledRoom(self._pet:GetPstID()) ~= nil
  else
    self._isSettled = false
  end
  if removeOne and self._pet:GetPstID() == removeOne:GetPstID() then
    self.noinfo:SetActive(true)
    self.settled:SetActive(false)
    self.cantSettle:SetActive(false)
    self._isRemove = true
  else
    self.noinfo:SetActive(false)
    self._isRemove = false
    if self._canSettle then
      if self._isSettled then
        self.settled:SetActive(true)
        self.cantSettle:SetActive(false)
      else
        self.settled:SetActive(false)
        self.cantSettle:SetActive(false)
      end
    else
      self.settled:SetActive(false)
      self.cantSettle:SetActive(true)
    end
  end
end

function UIHomeDomitoryPetCard:CheckHomeSpPet()
  local cfg_pet = Cfg.cfg_pet[self._pet:GetTemplateID()]
  if cfg_pet then
    local binderID = cfg_pet.BinderPetID
    if binderID then
      local petModule = GameGlobal.GetModule(PetModule)
      local homeModule = GameGlobal.GetModule(HomelandModule)
      local cfg_pet = Cfg.cfg_pet({})
      local innerPets = homeModule:GetAllDomitoryPets()
      if innerPets then
        for i = 1, #innerPets do
          local pet = innerPets[i]
          local petid = pet:GetTemplateID()
          local _cfg = cfg_pet[petid]
          if _cfg and petid ~= self._pet:GetTemplateID() then
            local _binderID = _cfg.BinderPetID
            if _binderID == binderID then
              local tex = StringTable.Get("str_homeland_domitory_sp_pet_tex", StringTable.Get(pet:GetPetName()))
              return true, tex
            end
          end
        end
      end
    end
  end
  return false
end

function UIHomeDomitoryPetCard:bgOnClick(go)
  if not self._isRemove and self._isSettled then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_domitory_pet_is_settled"))
    return
  elseif not self._canSettle then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_domitory_pet_cant_settle"))
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ForceFinishGuideStep, GuideType.Button)
  self._onClick(self._pet, self._isRemove)
end

function UIHomeDomitoryPetCard:onSelectChanged(pet)
  if not pet then
    self.bg:SetActive(false)
    return
  end
  self.bg:SetActive(self._pet:GetPstID() == pet:GetPstID())
end
