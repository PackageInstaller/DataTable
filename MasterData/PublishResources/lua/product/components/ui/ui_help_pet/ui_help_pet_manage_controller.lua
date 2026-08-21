_class("UIHelpPetManageController", UIController)
UIHelpPetManageController = UIHelpPetManageController

function UIHelpPetManageController:Constructor()
  self.module = self:GetModule(HelpPetModule)
  self.atlas = self:GetAsset("UIHelpPet.spriteatlas", LoadType.SpriteAtlas)
  self._elements = {
    [1] = ElementType.ElementType_Blue,
    [2] = ElementType.ElementType_Red,
    [3] = ElementType.ElementType_Green,
    [4] = ElementType.ElementType_Yellow
  }
end

function UIHelpPetManageController:LoadDataOnEnter(TT, res, uiParams)
  self.params = uiParams
  local res = self.module:RequestHelpPet_SupportInfo(TT)
  if res:GetSucc() then
    self._info = {}
    for i = 1, #self._elements do
      local elem = self._elements[i]
      self._info[i] = self.module:UI_FindSupportPet(elem)
    end
    self._supportInfo = self.module:UI_GetSupportInfo()
    res:SetSucc(true)
  else
    res:SetSucc(false)
  end
end

function UIHelpPetManageController:GetComponents()
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._animComp = self:GetUIComponent("ATransitionComponent", "animComp")
  self._backBtns:SetData(function()
    self:GetModule(PetModule):ClearAllPetSortInfo()
    self:CloseDialog()
    if self.backCallBack then
      self.backCallBack()
    end
  end, function()
    self:ShowDialog("UIHelpController", "UIHelpPetManageController")
  end, function()
    self._animComp.enabled = false
    self:SwitchState(UIStateType.UIMain)
  end)
  self.leftSop = self:GetUIComponent("UISelectObjectPath", "holder")
  self.totalCount = self:GetUIComponent("UILocalizationText", "zong")
  self.sevenCount = self:GetUIComponent("UILocalizationText", "qitian")
  self.noGO = self:GetGameObject("no")
  self.haveGO = self:GetGameObject("have")
  self.sliders = {}
  for i = 1, 4 do
    self.sliders[i] = {}
    self.sliders[i].go = self:GetGameObject("slider" .. i)
    self.sliders[i].name = self:GetUIComponent("UILocalizationText", "name" .. i)
    self.sliders[i].image = self:GetUIComponent("Image", "tiaofill" .. i)
    self.sliders[i].countTxt = self:GetUIComponent("UILocalizationText", "count" .. i)
  end
end

function UIHelpPetManageController:OnValue()
  self:SetLeft()
  self:SetRight()
end

function UIHelpPetManageController:OnShow(uiParams)
  self.backCallBack = uiParams[1]
  self:GetComponents()
  self.leftSop:SpawnObjects("UIHelpPetManageCell", 4)
  self.items = self.leftSop:GetAllSpawnList()
  for i, item in ipairs(self.items) do
    item:InitData(self._elements[i], function(elementType)
      self:ShowDialog("UITeamChangeController", true, function(petTempId, elementType, isAdd)
        self:StartTask(function(TT)
          local a = 1
          if isAdd == false then
            a = 0
          end
          if a == 1 then
            ToastManager.ShowToast(StringTable.Get("str_help_pet_zzszcg"))
          end
          local res = self.module:RequestHelpPet_SupportSet(TT, petTempId, a)
          if res and res:GetSucc() then
            GameGlobal.UIStateManager():CloseDialog("UITeamChangeController")
            self._info[elementType] = self.module:UI_FindSupportPet(elementType)
            self:RefreshOneManageCell(elementType, self._info[elementType] and self._info[elementType].m_nTemplateID or 0)
          end
        end)
      end, elementType)
    end, i)
  end
  self:OnValue()
end

function UIHelpPetManageController:SetLeft()
  for i, item in ipairs(self.items) do
    item:SetData(self._info[i] and self._info[i].m_nTemplateID or 0, self._elements[i])
  end
end

function UIHelpPetManageController:RefreshOneManageCell(elementType, petTempId)
  for _, item in ipairs(self.items) do
    if item:GetElementType() == elementType then
      item:SetData(petTempId, elementType)
      return
    end
  end
end

function UIHelpPetManageController:SetRight()
  local totalCount = self._supportInfo and self._supportInfo.m_nFightTotal or 0
  local sevenCount = self._supportInfo and self._supportInfo.m_nFightWeek or 0
  self.totalCount:SetText(totalCount)
  self.sevenCount:SetText(sevenCount)
  self.tongjiList = self._supportInfo and self._supportInfo.m_listPetState
  if not self.tongjiList or 0 >= table.count(self.tongjiList) then
    self.noGO:SetActive(true)
    self.haveGO:SetActive(false)
  else
    self.noGO:SetActive(false)
    self.haveGO:SetActive(true)
    local maxCount = sevenCount
    self._tweenerTab = {}
    for i = 1, 4 do
      local data = self.tongjiList[i]
      if data then
        self.sliders[i].go:SetActive(true)
        self:UpdateOneSlider(i, data, maxCount)
      else
        self.sliders[i].go:SetActive(false)
      end
    end
  end
end

function UIHelpPetManageController:UpdateOneSlider(index, data, maxCount)
  local pet = self:GetModule(PetModule):GetPet(data.m_nPetPstID)
  self.sliders[index].name:SetText(StringTable.Get(pet:GetPetName()))
  local fightCount = data.m_nFightCount
  local rate = fightCount / maxCount
  local tweener = self.sliders[index].image:DOFillAmount(rate, 0.2)
  self._tweenerTab[#self._tweenerTab + 1] = tweener
  self.sliders[index].countTxt:SetText(StringTable.Get("str_help_pet_ci", fightCount))
end

function UIHelpPetManageController:OnHide()
  if self._tweenerTab and #self._tweenerTab > 0 then
    for i = 1, #self._tweenerTab do
      local tweener = self._tweenerTab[i]
      tweener:Kill()
    end
  end
  self._tweenerTab = nil
end

function UIHelpPetManageController:AddListener()
end
