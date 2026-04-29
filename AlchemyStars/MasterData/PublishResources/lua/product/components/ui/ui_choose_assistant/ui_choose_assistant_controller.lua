_class("UIChooseAssistantController", UIController)
UIChooseAssistantController = UIChooseAssistantController
local AssistantCutType = {
  Star13 = 1,
  Star4 = 2,
  Star5 = 3,
  Star6 = 4,
  StarAll = 5
}
_enum("AssistantCutType", AssistantCutType)

function UIChooseAssistantController:Constructor()
  self._itemCountPerRow = 3
  self._petModule = self:GetModule(PetModule)
  self._roleModule = self:GetModule(RoleModule)
  self._filterType = AssistantCutType.StarAll
  self._allPets = self._petModule:GetPets()
  self._firstIn = true
  local isShowQuestUI = GameGlobal.UIStateManager():IsShow("UIQuestController")
  if isShowQuestUI then
    GameGlobal.UIStateManager():CloseDialog("UIQuestController")
  end
end

function UIChooseAssistantController:CreateSortParamAll()
  local sortTypeAll = {}
  local PetSortParam1 = PetSortParam:New(PetSortType.Star, PetSortOrder.Descending)
  table.insert(sortTypeAll, PetSortParam1)
  local PetSortParam3 = PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
  table.insert(sortTypeAll, PetSortParam3)
  return sortTypeAll
end

function UIChooseAssistantController:CreateSortParamOther()
  local sortTypeOther = {}
  local PetSortParam2 = PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
  table.insert(sortTypeOther, PetSortParam2)
  return sortTypeOther
end

function UIChooseAssistantController:CreateFilterParam()
  local filterParam = {}
  return filterParam
end

function UIChooseAssistantController:CreatePetChangeCgTable()
  self._pet2grade = {}
  self._petExtraSkin = {}
  local pets = self._petModule:GetPets()
  local cfg_pet = Cfg.cfg_pet({})
  for key, value in pairs(pets) do
    local pet = value
    local petid = pet:GetTemplateID()
    local pet_cfg = cfg_pet[petid]
    local pet_cg = HelperProxy:GetInstance():GetPetStaticBody(petid, 0, 0, PetSkinEffectPath.NO_EFFECT)
    local pet_cfg_grade = Cfg.cfg_pet_grade({PetID = petid})
    for j = 1, #pet_cfg_grade do
      local pet_grade_data = pet_cfg_grade[j]
      local gradeCg = HelperProxy:GetInstance():GetPetStaticBody(petid, pet_grade_data.Grade, 0, PetSkinEffectPath.NO_EFFECT)
      if gradeCg ~= pet_cg and j <= pet:GetPetGrade() then
        self._pet2grade[petid] = j
        break
      end
    end
    local extraSkin = {}
    local skinData = self._petModule:GetPetSkinsData(petid)
    if skinData then
      for _, skinInfo in ipairs(skinData.skin_info) do
        local pet_skin_cfg = Cfg.cfg_pet_skin[skinInfo.skin_id]
        if pet_skin_cfg then
          local unlockType = pet_skin_cfg.UnlockType[1]
          if unlockType == 1 or unlockType == 2 then
          else
            table.insert(extraSkin, skinInfo.skin_id)
          end
        end
      end
    end
    if 0 < #extraSkin then
      self._petExtraSkin[petid] = extraSkin
    end
  end
end

function UIChooseAssistantController:OnShow()
  self:_InitSkinState()
  self:CreatePetChangeCgTable()
  self:_GetComponents()
  self:ChangeDynamicAndStatic(self._cgState)
  self:ShowCurrentAssistant()
  self:_OnValue()
  self:ShowInfo()
  self:_refreshPetSkinList()
  local controller = GameGlobal.UIStateManager():GetController("UIChooseMainCgController")
  if controller then
    controller:SetCgControllerShowOrHide(false)
  end
end

function UIChooseAssistantController:_InitSkinState()
  local flagValue = self._roleModule:GetExtFlag(CharExtFlag.CEFT_MAIN_UI_SHOW_SPINE)
  if flagValue then
    self._cgState = DynamicAndStaticState.Static
  else
    self._cgState = DynamicAndStaticState.Dynamic
  end
end

function UIChooseAssistantController:ShowCurrentAssistant()
  local petid = self._roleModule.m_choose_painting.pet_template_id
  local defaultPetID, grade, skin, asid
  if petid and petid ~= 0 then
    Log.debug("###[UIChooseAssistantController]petid -- " .. petid)
    defaultPetID = petid
    grade = self._roleModule.m_choose_painting.pet_grade
    skin = self._roleModule.m_choose_painting.skin_id
    asid = self._roleModule.m_choose_painting.board_pet
    if asid == 3400050 then
      asid = 10015
    end
  else
    defaultPetID = Cfg.cfg_global.main_default_spine_pet_id.IntValue
    grade = 0
    skin = 0
    asid = 0
  end
  if asid and asid ~= 0 then
    self._staticDynamicBtns:SetActive(false)
    local cfg = Cfg.cfg_only_assistant[asid]
    if not cfg then
      Log.error("###[UIChooseAssistantController] cfg is nil ! id --> ", asid)
    else
      self._staticDynamicBtns:SetActive(true)
    end
  else
    self._staticDynamicBtns:SetActive(true)
  end
  local size = Cfg.cfg_global.ui_interface_common_size.ArrayValue
  local cgRect = self:GetGameObject("cg"):GetComponent("RectTransform")
  cgRect.sizeDelta = Vector2(size[1], size[2])
  Log.debug("###[UIChooseAssistantController]defaultPetID -- " .. defaultPetID)
  self._currID = defaultPetID
  self._currGrade = grade
  self._currSkinId = skin
  self._currAsId = asid
  self._selectID = self._currID
  self._selectGrade = self._currGrade
  self._selectSkinId = self._currSkinId
  self._selectAsId = self._currAsId
end

function UIChooseAssistantController:SortAndFilterPets()
  self._itemModule = GameGlobal.GetModule(ItemModule)
  local onlyAs = {}
  local cfg_only_assistant = Cfg.cfg_only_assistant({})
  if cfg_only_assistant and table.count(cfg_only_assistant) > 0 then
    for key, value in pairs(cfg_only_assistant) do
      local petid = value.PetID
      local itemid = value.ID
      local needItem = value.NeedItem
      local needSkin = value.SkinID
      local unlock = false
      local unlockItem = false
      if needItem then
        local count = self._itemModule:GetItemCount(itemid)
        if 0 < count then
          unlockItem = true
        end
      else
        local pet = self._petModule:GetPetByTemplateId(petid)
        if pet then
          unlockItem = true
        end
      end
      local unlockSkin = false
      if needSkin then
        local haveSkin = self._petModule:HaveSkin(needSkin)
        if haveSkin then
          unlockSkin = true
        end
      else
        unlockSkin = true
      end
      if unlockSkin and unlockItem then
        unlock = true
      end
      if unlock then
        if not onlyAs[petid] then
          onlyAs[petid] = {}
        end
        table.insert(onlyAs[petid], value)
      end
    end
  end
  if onlyAs and table.count(onlyAs) > 0 then
    for key, cgList in pairs(onlyAs) do
      table.sort(cgList, function(a, b)
        return a.Order < b.Order
      end)
    end
  end
  local onlyAsWithPet = {}
  local onlyAsWithoutPet = {}
  for key, value in pairs(onlyAs) do
    local cfgList = value
    local petid = key
    local pet = self._petModule:GetPetByTemplateId(petid)
    if pet then
      onlyAsWithPet[petid] = cfgList
    else
      onlyAsWithoutPet[petid] = cfgList
    end
  end
  local sortPets = {}
  for key, value in pairs(self._allPets) do
    local pet = value
    table.insert(sortPets, pet)
  end
  for key, value in pairs(onlyAsWithoutPet) do
    local petid = key
    local tempData = pet_data:New()
    tempData.template_id = petid
    tempData.current_skin = 0
    local pet = Pet:New(tempData)
    tempData.grade = 0
    tempData.level = 1
    tempData.awakening = 1
    tempData.equip_lv = 1
    pet:SetData(tempData)
    table.insert(sortPets, pet)
  end
  self._pets = {}
  if self._sortItemWidget then
    self._pets = self._sortItemWidget._pets
  end
  if self._selectID and self._selectID ~= -1 then
    local firstPet = self._petModule:GetPetByTemplateId(self._selectID)
    if not firstPet then
      Log.error("###[UIChooseAssistantController] firstPet is nil ! id --> ", self._selectID)
    end
    for i = 1, #self._pets do
      local petid = self._pets[i]:GetTemplateID()
      if petid == self._selectID then
        table.remove(self._pets, i)
        break
      end
    end
    table.insert(self._pets, 1, firstPet)
  end
  self._showPets = {}
  for i = 1, #self._pets do
    local pet = self._pets[i]
    local petid = pet:GetTemplateID()
    local withPet
    if onlyAsWithoutPet[petid] then
      withPet = false
    else
      withPet = true
    end
    local data = choose_assistant_ui_data_pet:New(petid, 0, 0, 0, withPet)
    table.insert(self._showPets, data)
    if data.withPet then
      local baseSkinData = choose_assistant_ui_data_skin:New(petid, 0, 0, 0)
      data:AppendSkinData(baseSkinData)
      if self._pet2grade[petid] then
        local gradeSkinData = choose_assistant_ui_data_skin:New(petid, self._pet2grade[petid], 0, 0)
        data:AppendSkinData(gradeSkinData)
      end
      if self._petExtraSkin[petid] then
        for _, skinId in ipairs(self._petExtraSkin[petid]) do
          local extraSkinData = choose_assistant_ui_data_skin:New(petid, 0, skinId, 0)
          data:AppendSkinData(extraSkinData)
        end
      end
    end
    local asList = onlyAs[petid]
    if asList then
      for i = 1, #asList do
        local extraAsData = choose_assistant_ui_data_skin:New(petid, 0, 0, asList[i].ID)
        data:AppendAsData(extraAsData)
      end
    end
  end
  local data = choose_assistant_ui_data_pet:New(-1, -1, -1, -1, true)
  table.insert(self._showPets, 1, data)
end

function UIChooseAssistantController:_GetComponents()
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "scrollView")
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self._cgGo = self:GetGameObject("cg")
  self._logo = self:GetUIComponent("RawImageLoader", "logo")
  self._logoGo = self:GetGameObject("LeftAnchor")
  self._posBtnGo = self:GetGameObject("posBtn")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil)
  self._star13Tex = self:GetUIComponent("UILocalizationText", "star13tex")
  self._star4Tex = self:GetUIComponent("UILocalizationText", "star4tex")
  self._star5Tex = self:GetUIComponent("UILocalizationText", "star5tex")
  self._star6Tex = self:GetUIComponent("UILocalizationText", "star6tex")
  self._starAllTex = self:GetUIComponent("UILocalizationText", "staralltex")
  self._star13Img = self:GetGameObject("star13img")
  self._star4Img = self:GetGameObject("star4img")
  self._star5Img = self:GetGameObject("star5img")
  self._star6Img = self:GetGameObject("star6img")
  self._starAllImg = self:GetGameObject("starallimg")
  self._star13star = self:GetUIComponent("Image", "star13star")
  self._star4star = self:GetUIComponent("Image", "star4star")
  self._star5star = self:GetUIComponent("Image", "star5star")
  self._star6star = self:GetUIComponent("Image", "star6star")
  self._currAssistentTex = self:GetUIComponent("UILocalizationText", "currAssistentTex")
  self._selectSkinAreaGen = self:GetUIComponent("UISelectObjectPath", "SelectSkinArea")
  if self._selectSkinAreaGen then
    self._selectSkinListWidget = self._selectSkinAreaGen:SpawnObject("UIChooseAssistantNewPetSkinList")
  end
  self._go = self:GetGameObject()
  self._viewBg = self:GetUIComponent("RectTransform", "viewBg")
  self._specialCg = self:GetUIComponent("RawImageLoader", "specialCg")
  self._staticDynamicBtns = self:GetGameObject("StaticDynamicBtns")
  self._staticRect = self:GetUIComponent("RectTransform", "static")
  self._dynamicRect = self:GetUIComponent("RectTransform", "dynamic")
  self._staticText = self:GetUIComponent("UILocalizationText", "staticText")
  self._dynamicText = self:GetUIComponent("UILocalizationText", "dynamicText")
  self._staticAndDynamicImg = self:GetUIComponent("RectTransform", "bar")
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._spineObj = self:GetGameObject("spine")
  self._CgObj = self:GetGameObject("CGObj")
  self._changePetPosAndScaleRoot = self:GetUIComponent("RectTransform", "posAndScale")
  self._sortItem = self:GetUIComponent("UISelectObjectPath", "sortItem")
  if self._sortItem then
    self._sortItemWidget = self._sortItem:SpawnObject("UIChooseSpiritSortItem")
  end
  self._saveAndCancelObj = self:GetGameObject("saveAndCancelBtn")
end

function UIChooseAssistantController:SetSaveAndCancelObj(boo)
  if self._saveAndCancelObj then
    self._saveAndCancelObj:SetActive(true)
  end
end

function UIChooseAssistantController:_OnValue()
  self:SortAndFilterPets()
  self:CalcCount()
  if self._listShowItemCount <= 0 then
    self._scrollView.gameObject:SetActive(false)
    return
  else
    self._scrollView.gameObject:SetActive(true)
  end
  if self._firstIn then
    self._firstIn = false
    self:_InitScrollView()
  else
    self._scrollView:SetListItemCount(self._listShowItemCount)
    self._scrollView:MovePanelToItemIndex(0, 0)
  end
end

function UIChooseAssistantController:_InitScrollView()
  if self._scrollView then
    self._scrollView:InitListView(self._listShowItemCount, function(scrollView, index)
      return self:_InitListView(scrollView, index)
    end)
  end
end

function UIChooseAssistantController:CalcCount()
  self._petCount = table.count(self._showPets)
  self._listShowItemCount = math.ceil(self._petCount / self._itemCountPerRow)
  self._listShowItemCount = self._listShowItemCount and self._listShowItemCount or 0
end

function UIChooseAssistantController:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIChooseAssistantItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._petCount then
      heartItem:GetGameObject():SetActive(false)
    else
      self:ShowHeartItem(heartItem, itemIndex)
    end
  end
  return item
end

function UIChooseAssistantController:ShowHeartItem(heartItem, index)
  local pet = self._showPets[index]
  heartItem:GetGameObject():SetActive(true)
  if pet ~= nil then
    heartItem:SetData(pet, self._currID, self._currGrade, self._currSkinId, self._currAsId, self._selectID, self._selectGrade, self._selectSkinId, self._selectAsId, function(petid, grade, skinId, asId)
      self._selectID = petid
      self._selectGrade = grade
      self._selectSkinId = skinId
      self._selectAsId = asId
      self:_refreshPetSkinList()
    end, function(petid, grade, skinId, asId)
      return self:GetHeadIconByIdAndGrade(petid, grade, skinId, asId)
    end)
  end
end

function UIChooseAssistantController:GetHeadIconByIdAndGrade(petid, grade, skinId, asId)
  local _petid = petid
  local _grade = grade
  local _skinId = skinId
  local _asId = asId
  if _asId and _asId ~= 0 then
    _skinId = 0
  end
  local icon = HelperProxy:GetInstance():GetPetHead(_petid, _grade, _skinId, PetSkinEffectPath.HEAD_ICON_CHANGE_ASSIST)
  return icon
end

function UIChooseAssistantController:ChangeCutType(cutType)
  self._filterType = cutType
end

function UIChooseAssistantController:ShowInfo()
  if self._selectID == -1 then
    return
  end
  local petid = self._selectID
  local grade = self._selectGrade
  local skinId = self._selectSkinId
  local asId = self._selectAsId
  if self._dcgHandle then
    self._dcgHandle:DestroyCurrentCG()
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnAssistantPetItemClick, self._selectID)
  local isSpecialCg = false
  local cgName, logo, name, spineName
  if asId and asId ~= 0 then
    self._staticDynamicBtns:SetActive(false)
    local cfg = Cfg.cfg_only_assistant[asId]
    if not cfg then
      Log.error("###[UIChooseAssistantController] cfg is nil ! id --> ", asId)
    else
      self._staticDynamicBtns:SetActive(true)
    end
    cgName = cfg.CG
    spineName = cfg.Spine
    if not cgName then
      Log.error("###[UIChooseAssistantController] cgName is nil ! id --> ", asId)
    end
    local cfg_pet = Cfg.cfg_pet[petid]
    if not cfg_pet then
      Log.error("###[UIChooseAssistantController] cfg_pet is nil ! id --> ", petid)
    end
    name = cfg_pet.Name
    logo = cfg_pet.Logo
  else
    self._staticDynamicBtns:SetActive(true)
    self:_InitSkinState()
    self:ChangeDynamicAndStatic(self._cgState)
    isSpecialCg = true
    cgName = HelperProxy:GetInstance():GetMainLobbyStaticBody(petid, grade, skinId, PetSkinEffectPath.BODY_CHANGE_ASSIST)
    if not cgName then
      isSpecialCg = false
      cgName = HelperProxy:GetInstance():GetPetStaticBody(petid, grade, skinId, PetSkinEffectPath.BODY_CHANGE_ASSIST)
    end
    spineName = HelperProxy:GetInstance():GetPetSpine(petid, grade, skinId, PetSkinEffectPath.BODY_CHANGE_ASSIST)
    local pet = self._petModule:GetPetByTemplateId(petid)
    logo = pet:GetPetLogo()
    name = pet:GetPetName()
  end
  self._cg.gameObject:SetActive(not isSpecialCg)
  self._specialCg.gameObject:SetActive(isSpecialCg)
  if isSpecialCg then
    local size = Vector2(2539, 1439)
    if skinId then
      local cfg_skin = Cfg.cfg_pet_skin[skinId]
      if cfg_skin then
        local mainSize = cfg_skin.MainLobbySize
        if mainSize then
          size = Vector2(mainSize[1], mainSize[2])
        end
        spineName = cfg_skin.MainLobbySpine
      end
    end
    local _rect = self._specialCg.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
    _rect.sizeDelta = size
    _rect.localScale = Vector3(1, 1, 1)
    self._specialCg:LoadImage(cgName)
    self._changePetPosAndScaleRoot.localScale = Vector3(1, 1, 1)
  else
    self._cg:LoadImage(cgName)
    self._changePetPosAndScaleRoot.localScale = Vector3(0.5, 0.5, 1)
  end
  if self._dcgHandle then
    self._dcgHandle:ChangeDynamicCGSync(spineName)
  else
    self._dcgHandle = DynamicCG.SyncLoad(spineName, self._spine)
  end
  UICG.SetTransform(self._cg.transform, self:GetName(), cgName)
  UICG.SetTransform(self._spine.transform, self:GetName(), spineName)
  local cfg_pet
  if 0 < grade then
    cfg_pet = Cfg.cfg_pet_grade({
      PetID = self._selectID,
      Grade = grade
    })[1]
  else
    cfg_pet = Cfg.cfg_pet[self._selectID]
  end
  local dynamicSpineAnim
  if cfg_pet and asId and asId ~= 0 then
    local cfg_as = Cfg.cfg_only_assistant[asId]
    if cfg_as then
      dynamicSpineAnim = cfg_as.SpineAnim
    end
  end
  if dynamicSpineAnim then
    local function tryFunc()
      if self._dcgHandle then
        self._dcgHandle:InitializeSpine()
        
        self._dcgHandle:SetAnimation(0, dynamicSpineAnim, true)
        self._dcgHandle:SetAnimMixTime(0)
        self._dcgHandle:Update(0)
      end
    end
    
    local succ = pcall(tryFunc)
    if not succ then
      Log.error("###[UIChooseAssistantController] set _dynamicSpineAnim fail ! anim:", dynamicSpineAnim)
    end
  end
  self._logo:LoadImage(logo)
  self._name:SetText(StringTable.Get(name))
  local isCurrPet
  if asId and asId ~= 0 then
    isCurrPet = self._currAsId == asId
  else
    isCurrPet = self._currID == petid and self._currGrade == grade and self._currSkinId == skinId
  end
  if isCurrPet then
    self._currAssistentTex:SetText(StringTable.Get("str_assistant_current_assistant"))
  else
    self._currAssistentTex:SetText(StringTable.Get("str_assistant_preview_assistant"))
  end
end

function UIChooseAssistantController:ChangeChooseState(type)
  local c = Color(1, 1, 1, 1)
  self._star13Tex.color = c
  self._star4Tex.color = c
  self._star5Tex.color = c
  self._star6Tex.color = c
  self._starAllTex.color = c
  self._star13Img:SetActive(false)
  self._star4Img:SetActive(false)
  self._star5Img:SetActive(false)
  self._star6Img:SetActive(false)
  self._starAllImg:SetActive(false)
  self._star13star.color = c
  self._star4star.color = c
  self._star5star.color = c
  self._star6star.color = c
  local c_yellow = Color(1, 0.9921568627450981, 0, 1)
  if type == AssistantCutType.Star13 then
    self._star13Tex.color = c_yellow
    self._star13Img:SetActive(true)
    self._star13star.color = c_yellow
  elseif type == AssistantCutType.Star4 then
    self._star4Tex.color = c_yellow
    self._star4Img:SetActive(true)
    self._star4star.color = c_yellow
  elseif type == AssistantCutType.Star5 then
    self._star5Tex.color = c_yellow
    self._star5Img:SetActive(true)
    self._star5star.color = c_yellow
  elseif type == AssistantCutType.Star6 then
    self._star6Tex.color = c_yellow
    self._star6Img:SetActive(true)
    self._star6star.color = c_yellow
  elseif type == AssistantCutType.StarAll then
    self._starAllTex.color = c_yellow
    self._starAllImg:SetActive(true)
  end
end

function UIChooseAssistantController:star13OnClick()
  if self._filterType ~= AssistantCutType.Star13 then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
    self:ChangeCutType(AssistantCutType.Star13)
    self:ChangeChooseState(AssistantCutType.Star13)
  end
end

function UIChooseAssistantController:star4OnClick()
  if self._filterType ~= AssistantCutType.Star4 then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
    self:ChangeCutType(AssistantCutType.Star4)
    self:ChangeChooseState(AssistantCutType.Star4)
  end
end

function UIChooseAssistantController:star5OnClick()
  if self._filterType ~= AssistantCutType.Star5 then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
    self:ChangeCutType(AssistantCutType.Star5)
    self:ChangeChooseState(AssistantCutType.Star5)
  end
end

function UIChooseAssistantController:star6OnClick()
  if self._filterType ~= AssistantCutType.Star6 then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
    self:ChangeCutType(AssistantCutType.Star6)
    self:ChangeChooseState(AssistantCutType.Star6)
  end
end

function UIChooseAssistantController:starallOnClick()
  if self._filterType ~= AssistantCutType.StarAll then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
    self:ChangeCutType(AssistantCutType.StarAll)
    self:ChangeChooseState(AssistantCutType.StarAll)
  end
end

function UIChooseAssistantController:sskinBtnOnClick()
  ToastManager.ShowToast(StringTable.Get("str_pet_config_function_no_open"))
end

function UIChooseAssistantController:PosBtnOnClick()
  local isShowQuestUI = GameGlobal.UIStateManager():IsShow("UIQuestController")
  if isShowQuestUI then
    GameGlobal.UIStateManager():CloseDialog("UIQuestController")
  end
  self:CloseDialog()
  local mainController = GameGlobal.UIStateManager():GetController("UIMainLobbyController")
  local id, type = mainController:GetBgIDAndType()
  GameGlobal.UIStateManager():ShowDialog("UIChooseMainCgController", UIChooseAssistantType.Change2Cg, id, type)
end

function UIChooseAssistantController:BgBtnOnClick()
  self:CloseDialog()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnShowChangeMainCg, UIPetAndBgMoveType.Bg, true)
  local isShowQuestUI = GameGlobal.UIStateManager():IsShow("UIQuestController")
  if isShowQuestUI then
    GameGlobal.UIStateManager():CloseDialog("UIQuestController")
  end
  GameGlobal.UIStateManager():ShowDialog("UIChooseMainBgController")
end

function UIChooseAssistantController:changeBtnOnClick()
  self:Lock("UIChooseAssistantController:changeBtnOnClick")
  self:StartTask(self.ChangeRequest, self)
end

function UIChooseAssistantController:ChangeRequest(TT)
  local id = self._selectID
  local grade = self._selectGrade
  local skinID = self._selectSkinId
  local asID = self._selectAsId
  if id == -1 then
    grade = -1
    skinID = -1
    asID = -1
  else
    local open_id = GameGlobal.GameLogic():GetOpenId()
    local key = "MAIN_BG_AS_ACTIVE" .. open_id
    LocalDB.SetInt(key, 0)
  end
  local res = self._roleModule:RequestChoosePainting(TT, id, grade, skinID, asID)
  self:UnLock("UIChooseAssistantController:changeBtnOnClick")
  if res:GetSucc() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnAssistantChanged, true)
    self:CloseDialog()
  else
    Log.debug("###UIChooseAssistantController id-->", id, "|grade-->", grade, "|skin-->", skinID, "|as-->", asID)
    Log.fatal("###UIChooseAssistantController -- change assistent res error ! result --> ", res:GetResult())
  end
end

function UIChooseAssistantController:_refreshPetSkinList()
  local petId = self._selectID
  self._cgGo:SetActive(petId ~= -1)
  self._logoGo:SetActive(petId ~= -1)
  self._staticDynamicBtns:SetActive(petId ~= -1)
  self._changePetPosAndScaleRoot.gameObject:SetActive(petId ~= -1)
  if petId == -1 then
    self._name:SetText(StringTable.Get("str_assistant_current_pet_null"))
    if self._currID == petId then
      self._currAssistentTex:SetText(StringTable.Get("str_assistant_current_assistant"))
    else
      self._currAssistentTex:SetText(StringTable.Get("str_assistant_preview_assistant"))
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnAssistantPetItemClick, self._selectID)
    return
  end
  local curPetData
  for index, petData in ipairs(self._showPets) do
    if petData.petid == petId then
      curPetData = petData
      break
    end
  end
  if self._selectSkinListWidget then
    if not self._skilListSetted then
      self._selectSkinListWidget:SetRefreshUiCallBack(function(petid, grade, skinId, asId)
        self._selectID = petid
        self._selectGrade = grade
        self._selectSkinId = skinId
        self._selectAsId = asId
        self:ShowInfo()
      end)
      self._selectSkinListWidget:SetCheckIsCurSkinCallBack(function(petid, grade, skinId, asId)
        local isCur
        if self._currAsId and self._currAsId ~= 0 or asId and asId ~= 0 then
          if asId == self._currAsId then
            isCur = true
          end
        else
          isCur = petid == self._currID and grade == self._currGrade and skinId == self._currSkinId
        end
        return isCur
      end)
      self._skilListSetted = true
    end
    if curPetData then
      self._selectSkinListWidget:RefreshData(curPetData)
    end
  end
end

function UIChooseAssistantController:OnUpdate(deltaTimeMS)
end

function UIChooseAssistantController:StaticDynamicBtnsOnClick()
  if self._cgState == DynamicAndStaticState.Static then
    self._cgState = DynamicAndStaticState.Dynamic
    GameGlobal.UAReportForceGuideEvent("UIMainClick", {
      "Click_Dynamic"
    }, true)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlideDynamic)
  else
    self._cgState = DynamicAndStaticState.Static
    GameGlobal.UAReportForceGuideEvent("UIMainClick", {
      "Click_Static"
    }, true)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlide)
  end
  self:ChangeDynamicAndStatic(self._cgState)
  GameGlobal.TaskManager():StartTask(self._OnGetExtData, self, self._cgState)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SwitchSkinStaticOrDynamic, self._cgState)
end

function UIChooseAssistantController:_OnGetExtData(TT, state)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local flagValue = false
  if state == DynamicAndStaticState.Static then
    flagValue = true
  else
    flagValue = false
  end
  roleModule:SetExtFlag(TT, CharExtFlag.CEFT_MAIN_UI_SHOW_SPINE, flagValue)
end

function UIChooseAssistantController:ChangeDynamicAndStatic(state)
  if self._dsTween then
    self._dsTween:Kill()
  end
  if state == DynamicAndStaticState.Dynamic then
    local pos = self._dynamicRect.anchoredPosition
    self._dsTween = self._staticAndDynamicImg:DOAnchorPos(pos, 0.3):SetEase(DG.Tweening.Ease.InOutCubic)
    self._dynamicText.color = Color.black
    self._staticText.color = Color(0.38823529411764707, 0.38823529411764707, 0.38823529411764707, 1)
    self._CgObj:SetActive(false)
    self._spineObj:SetActive(true)
  else
    local pos = self._staticRect.anchoredPosition
    self._dsTween = self._staticAndDynamicImg:DOAnchorPos(pos, 0.3):SetEase(DG.Tweening.Ease.InOutCubic)
    self._staticText.color = Color.black
    self._dynamicText.color = Color(0.38823529411764707, 0.38823529411764707, 0.38823529411764707, 1)
    self._CgObj:SetActive(true)
    self._spineObj:SetActive(false)
  end
end

function UIChooseAssistantController:cancelBtnOnClick()
  self:CloseDialog()
  local controller = GameGlobal.UIStateManager():GetController("UIChooseMainCgController")
  if controller then
    controller:SetCgControllerShowOrHide(true)
  else
    self:ShowDialog("UIChooseMainCgController")
  end
end

function UIChooseAssistantController:saveBtnOnClick()
  local id = self._selectID
  local grade = self._selectGrade
  local skinID = self._selectSkinId
  local asID = self._selectAsId
  local controller = GameGlobal.UIStateManager():GetController("UIChooseMainCgController")
  if id ~= self._roleModule.m_choose_painting.pet_template_id or grade ~= self._roleModule.m_choose_painting.pet_grade or skinID ~= self._roleModule.m_choose_painting.skin_id or asID ~= self._roleModule.m_choose_painting.board_pet then
    ChooseAssistantHelper:SaveTmpChooseCgPaintingData(true, id, grade, skinID, asID)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnAssistantChanged, true)
    self:CloseDialog()
    if controller then
      controller:SetCgControllerShowOrHide(true)
      controller:SetCgShowInfo({
        UIChooseAssistantType.Change2Cg,
        id,
        grade,
        skinID,
        asID
      })
    else
      self:ShowDialog("UIChooseMainCgController", UIChooseAssistantType.Change2Cg, id, grade, skinID, asID)
    end
  else
    self:CloseDialog()
    if controller then
      controller:SetCgControllerShowOrHide(true)
    else
      self:ShowDialog("UIChooseMainCgController")
    end
  end
end
