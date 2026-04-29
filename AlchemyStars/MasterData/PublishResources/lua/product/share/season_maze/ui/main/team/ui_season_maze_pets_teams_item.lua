_class("UISeasonMazePetsTeamsItem", UICustomWidget)
UISeasonMazePetsTeamsItem = UISeasonMazePetsTeamsItem

function UISeasonMazePetsTeamsItem:Constructor()
  self._petPstID = 0
end

function UISeasonMazePetsTeamsItem:OnShow(uiParams)
  self._module = self:GetModule(MissionModule)
  self:UIWidget()
  self:DefaultVisible()
  self:UIEvents()
end

function UISeasonMazePetsTeamsItem:OnHide()
  if self._equipLvWidget ~= nil then
    self._equipLvWidget:Dispose()
  end
end

function UISeasonMazePetsTeamsItem:BtnDetailOnClick(go)
  local petList = {}
  if self._getPetListCb then
    petList = self._getPetListCb()
  end
  local petModule = self:GetModule(PetModule)
  petModule.uiModule:SetTeamCustomPets(petList)
  local petid = self._petInfo:GetTemplateID()
  self:ShowDialog("UISpiritDetailGroupController", petid, false, nil, nil, true)
end

function UISeasonMazePetsTeamsItem:UIWidget()
  self._petIconLoader = self:GetUIComponent("RawImageLoader", "petIcon")
  self._leader = self:GetUIComponent("RectTransform", "leader")
  self._button = self:GetUIComponent("RectTransform", "button")
  self._widget = self:GetUIComponent("UIView", "widget")
  self._imgAdd = self:GetUIComponent("RectTransform", "imgAdd")
  self._imgGray = self:GetUIComponent("RectTransform", "imgGray")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._career = self._widget:GetUIComponent("Image", "career")
  self._attrMain = self._widget:GetUIComponent("Image", "attrMain")
  self._attrVice = self._widget:GetUIComponent("Image", "attrVice")
  self._petName = self._widget:GetUIComponent("UILocalizationText", "petName")
  self._lvValue = self._widget:GetUIComponent("UILocalizationText", "lvValue")
  self._imgGrade = self._widget:GetUIComponent("Image", "imgGrade")
  self._equipLv = self._widget:GetUIComponent("UISelectObjectPath", "equipLv")
  self._equipLvWidget = nil
  self._stars = {
    self._widget:GetUIComponent("RectTransform", "star1"),
    self._widget:GetUIComponent("RectTransform", "star2"),
    self._widget:GetUIComponent("RectTransform", "star3"),
    self._widget:GetUIComponent("RectTransform", "star4"),
    self._widget:GetUIComponent("RectTransform", "star5"),
    self._widget:GetUIComponent("RectTransform", "star6")
  }
  self._starAwaken = {}
  self._starLock = {}
  for k, v in pairs(self._stars) do
    self._starAwaken[k] = self:GetChildComponent(v, "RectTransform", "starAwaken")
    self._starLock[k] = self:GetChildComponent(v, "RectTransform", "starLock")
  end
  self._warningRoot = self._widget:GetUIComponent("RectTransform", "warning")
  self._txtWarning = self._widget:GetUIComponent("UILocalizationText", "txtWarning")
  self._lockGo = self:GetGameObject("lock")
  self._powerGo = self:GetGameObject("power")
  self._powerTex = self:GetUIComponent("UILocalizationText", "powerValue")
  self._hpImg = self:GetUIComponent("Image", "hpvalue")
  self._dialLines = self:GetUIComponent("UISelectObjectPath", "dialLines")
  self._lineRoot = self:GetUIComponent("RectTransform", "dialLines")
  self._hpTex = self:GetUIComponent("UILocalizationText", "hpTex")
  self._blackShadow = self:GetGameObject("blackShadow")
end

function UISeasonMazePetsTeamsItem:DefaultVisible()
  self._imgGray.gameObject:SetActive(false)
  self._warningRoot.gameObject:SetActive(false)
end

function UISeasonMazePetsTeamsItem:UIEvents()
  local function endDragFunc()
    if self._petPstID == 0 then
      return
    end
    self._imgGray.gameObject:SetActive(false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamItemLongPress, false, self._slot, self._petInfo)
  end
  
  local etl = UICustomUIEventListener.Get(self._button.gameObject)
  self:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(ped)
    if self._lock then
      return
    end
    if self._petPstID == 0 or GameGlobal.UIStateManager():IsLocked() then
      return
    end
    self._imgGray.gameObject:SetActive(true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamItemLongPress, true, self._slot, self._petInfo)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Drag, function(ped)
    if self._lock then
      return
    end
    if self._petPstID == 0 then
      return
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamUpdateReplaceCardPos, ped.position)
  end)
  self:AddUICustomEventListener(etl, UIEvent.EndDrag, function(ped)
    if self._lock then
      return
    end
    endDragFunc()
  end)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    if self._lock then
      return
    end
    if self._clickCb then
      self._clickCb(self._slot)
    end
  end)
  if not EDITOR then
    self:AddUICustomEventListener(etl, UIEvent.ApplicationFocus, function(b)
      if self._lock then
        return
      end
      if not b then
        if not etl.IsDragging then
          return
        end
        etl.IsDragging = false
        endDragFunc()
      end
    end)
  end
  self:AttachEvent(GameEventType.PetDataChangeEvent, self.OnPetInfoChanged)
  self:AttachEvent(GameEventType.OnPetSkinChange, self.OnPetInfoChanged)
end

function UISeasonMazePetsTeamsItem:InitData(atlasProperty, atlasAwake, atlasProf, clickCb, getPetListCb, getHpCfg, isPrimary)
  self._atlasProperty = atlasProperty
  self._atlasAwake = atlasAwake
  self._atlasProf = atlasProf
  self._clickCb = clickCb
  self._getPetListCb = getPetListCb
  self._getHpCfg = getHpCfg
  self._isPrimary = isPrimary
end

function UISeasonMazePetsTeamsItem:FlushPet(slot, pet, lock)
  local theFirstIn = self._slot == nil
  local prePetPstID = self._petPstID
  self._slot = slot
  self._lock = lock
  self._uiSeasonMazeModule = self:GetUIModule(SeasonMazeModule)
  self._petInfo = pet
  if self._petInfo then
    self._petPstID = self._petInfo:GetPstID()
  else
    self._petPstID = 0
  end
  self:OnPetInfoChanged()
  if not theFirstIn and prePetPstID ~= self._petPstID and self._petInfo ~= nil then
    self._animation:Play("effanim_UISeasonMazePetsTeamsItem_in2")
  end
end

function UISeasonMazePetsTeamsItem:ShowHpAndPower()
  local hpUnit, lineUnit, sp1, sp2 = self._getHpCfg()
  local cur, hpMax = self._uiSeasonMazeModule:GetPetHP(self._petInfo:GetTemplateID(), self._petInfo)
  local rate = cur / hpMax
  self._hpTex:SetText(cur .. "/" .. hpMax)
  self._hpImg.fillAmount = rate
  local hpvaluewidth = 716
  local dialLineCount = math.ceil(hpMax / hpUnit) - 1
  if dialLineCount > self._lineRoot.childCount then
    local gaps = dialLineCount - self._lineRoot.childCount
    local oriGo = self._lineRoot:GetChild(0).gameObject
    for i = 1, gaps do
      local ins = UnityEngine.GameObject.Instantiate(oriGo, self._lineRoot)
    end
  end
  for i = 1, self._lineRoot.childCount do
    local go = self._lineRoot:GetChild(i - 1).gameObject
    local show = cur > i * hpUnit
    go:SetActive(show)
    if show then
      local middleImg = i % lineUnit == 0
      local sp
      if middleImg then
        sp = sp1
      else
        sp = sp2
      end
      go.transform:GetChild(0).gameObject:GetComponent("Image").sprite = sp
      local posx = hpvaluewidth / hpMax * hpUnit * i
      go.transform:GetChild(0).gameObject:GetComponent("RectTransform").anchoredPosition = Vector2(posx, 0)
    end
  end
  local notShowPower = GameGlobal.GetModule(MazeModule):IsPetActiveSkillUseLegendEnergy(nil, self._petInfo)
  self._powerGo:SetActive(not notShowPower)
  if not notShowPower then
    local power = self._uiSeasonMazeModule:GetPetPower(self._petInfo:GetTemplateID(), self._petInfo)
    self._powerTex:SetText(power)
  end
end

function UISeasonMazePetsTeamsItem:OnPetInfoChanged()
  if self._petInfo == nil then
    self._petIconLoader.gameObject:SetActive(false)
    self._leader.gameObject:SetActive(false)
    self._widget.gameObject:SetActive(false)
    self._imgAdd.gameObject:SetActive(true)
    self._blackShadow:SetActive(false)
  else
    self._blackShadow:SetActive(true)
    self._petIconLoader.gameObject:SetActive(true)
    self._leader.gameObject:SetActive(self._slot == 1)
    self._widget.gameObject:SetActive(true)
    self._imgAdd.gameObject:SetActive(false)
    self:ShowCareer()
    self:ShowName()
    self:ShowBattleMes()
    self:ShowLevel()
    self:ShowElement()
    self:ShowStarLevel()
    self:ShowGrade()
    self:ShowEquipLv()
    self:ShowHpAndPower()
  end
  if self._lock then
    self._lockGo:SetActive(true)
    self._imgAdd.gameObject:SetActive(false)
  else
    self._lockGo:SetActive(false)
    self._imgAdd.gameObject:SetActive(true)
  end
end

function UISeasonMazePetsTeamsItem:ShowCareer()
  if self._prof2Img == nil then
    self._prof2Img = {
      [PetProfType.PetProf_Color] = "epg_gqxq_icon08",
      [PetProfType.PetProf_Blood] = "epg_gqxq_icon06",
      [PetProfType.PetProf_Attack] = "epg_gqxq_icon07",
      [PetProfType.PetProf_Function] = "epg_gqxq_icon09"
    }
    self._prof2Name = {
      [PetProfType.PetProf_Color] = "str_pet_tag_job_name_color_change_1",
      [PetProfType.PetProf_Blood] = "str_pet_tag_job_name_return_blood_1",
      [PetProfType.PetProf_Attack] = "str_pet_tag_job_name_attack_1",
      [PetProfType.PetProf_Function] = "str_pet_tag_job_name_function_1"
    }
  end
  local prof = self._petInfo:GetProf()
  local spriteName = self._prof2Img[prof]
  self._career.sprite = self._atlasProf:GetSprite(spriteName)
end

function UISeasonMazePetsTeamsItem:ShowName()
  self._petName:SetText(StringTable.Get(self._petInfo:GetPetName()))
end

function UISeasonMazePetsTeamsItem:ShowBattleMes()
  local tid = self._petInfo:GetTemplateID()
  local grade = self._petInfo:GetPetGrade()
  local skinId = self._petInfo:GetSkinId()
  local path = PetSkinEffectPath.CARD_TEAM
  local hpProxy = HelperProxy:GetInstance()
  local nameBattleMes = hpProxy:GetPetBattleMes(tid, grade, skinId, path)
  self._petIconLoader:LoadImage(nameBattleMes)
end

function UISeasonMazePetsTeamsItem:ShowLevel()
  local petLevel = self._petInfo:GetPetLevel()
  self._lvValue:SetText("LV." .. petLevel)
end

function UISeasonMazePetsTeamsItem:ShowElement()
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if cfg_pet_element == nil then
    self._attrMain.gameObject:SetActive(false)
    self._attrVice.gameObject:SetActive(false)
    return
  end
  local v1stSprite, v2ndSprite
  local v1stElement = self._petInfo:GetPetFirstElement()
  local v2ndElement = self._petInfo:GetPetSecondElement()
  if v1stElement ~= nil then
    local spriteName = UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[v1stElement].Icon)
    v1stSprite = self._atlasProperty:GetSprite(spriteName)
  end
  if v2ndElement ~= nil then
    local spriteName = UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[v2ndElement].Icon)
    v2ndSprite = self._atlasProperty:GetSprite(spriteName)
  end
  if v1stSprite ~= nil then
    self._attrMain.gameObject:SetActive(false)
    self._attrVice.gameObject:SetActive(true)
    self._attrVice.sprite = v1stSprite
  end
  if v2ndSprite ~= nil then
    self._attrMain.gameObject:SetActive(true)
    self._attrMain.sprite = v1stSprite
    self._attrVice.sprite = v2ndSprite
  end
end

function UISeasonMazePetsTeamsItem:ShowStarLevel()
  local petStar = self._petInfo:GetPetStar()
  local awakenStep = self._petInfo:GetPetAwakening()
  local awakenLock = self._petInfo:GetAwakeMatch()
  local maxStarLevel = #self._stars
  for starLevel = 1, maxStarLevel do
    local starGo = self._stars[starLevel].gameObject
    if starLevel <= petStar then
      starGo:SetActive(true)
    else
      starGo:SetActive(false)
    end
    local starGo = self._starAwaken[starLevel].gameObject
    local starLockGo = self._starLock[starLevel].gameObject
    if starLevel <= awakenLock then
      starGo:SetActive(true)
      starLockGo:SetActive(false)
    elseif starLevel <= awakenStep then
      starGo:SetActive(false)
      starLockGo:SetActive(true)
    else
      starGo:SetActive(false)
      starLockGo:SetActive(false)
    end
  end
end

function UISeasonMazePetsTeamsItem:ShowGrade()
  local petId = self._petInfo:GetTemplateID()
  local petGradeLevel = self._petInfo:GetPetGrade()
  self._imgGrade.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, petGradeLevel))
end

function UISeasonMazePetsTeamsItem:ShowEquipLv()
  if self._equipLvWidget == nil then
    self._equipLvWidget = UICustomWidgetPool:New(self:RootUIOwner(), self._equipLv)
  end
  local obj = self._equipLvWidget:SpawnObject("UIPetEquipLvIcon")
  obj:SetData(self._petInfo, true)
end

function UISeasonMazePetsTeamsItem:HideGuideWarn()
  self._warningRoot.gameObject:SetActive(false)
end

function UISeasonMazePetsTeamsItem:IsLocked()
  return false
end
