_class("UITrailLevelBuffDes", UIController)
UITrailLevelBuffDes = UITrailLevelBuffDes

function UITrailLevelBuffDes:LoadDataOnEnter(TT, res, uiParams)
  self._talePetModule = GameGlobal.GetModule(TalePetModule)
  self._talePetModule:ApplyBuffInfo(TT)
  self._currentLevel, self._maxLevel = self._talePetModule:GetBuffLevel()
  self._exp, self._maxExp = self._talePetModule:GetBuffExp()
  self._petDatas = {}
  self._talePetCount = 4
  local cfgs = Cfg.cfg_tale_pet({})
  for _, cfg in pairs(cfgs) do
    local id = cfg.ID
    local isRestriction = self._talePetModule:HaveCallRestriction(id)
    if not isRestriction then
      local data = {}
      data.templateId = id
      data.sort = cfg.Sort
      data.lock = not self._talePetModule:IsGetTalePet(id)
      self._petDatas[#self._petDatas + 1] = data
    end
  end
  table.sort(self._petDatas, function(a, b)
    return a.sort < b.sort
  end)
end

function UITrailLevelBuffDes:OnShow()
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:CloseDialog()
  end, nil)
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._levelLabel = self:GetUIComponent("UILocalizationText", "Level")
  self._talePetBuffDesLabel = self:GetUIComponent("UILocalizationText", "TalePetBuffDes")
  self._normalPetBuffDesLabel = self:GetUIComponent("UILocalizationText", "NormalPetBuffDes")
  self._expBar = self:GetUIComponent("Slider", "ExpBar")
  self._expLabel = self:GetUIComponent("UILocalizationText", "Exp")
  self._nextBtn = self:GetGameObject("NextBtn")
  self._preBtn = self:GetGameObject("PreBtn")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._pets = {}
  for i = 1, self._talePetCount do
    local pet = self:GetUIComponent("UISelectObjectPath", "Pet" .. i)
    local item = pet:SpawnObject("UITrailLevelBuffPetItem")
    self._pets[#self._pets + 1] = item
    item:Refresh(self._petDatas[i], self)
  end
  self:RefreshUI()
  self:RefreshButtonStatus()
  self._currentSelectPet = nil
end

function UITrailLevelBuffDes:OnPetClick(petItem)
  if self._currentSelectPet == petItem then
    return
  end
  if self._currentSelectPet then
    self._currentSelectPet:UnSelect()
  end
  self._currentSelectPet = petItem
  self._currentSelectPet:Select()
end

function UITrailLevelBuffDes:RefreshUI()
  local cfg = Cfg.cfg_trail_level_buff_level[self._currentLevel]
  self._name:SetText(StringTable.Get(cfg.BuffName))
  self._talePetBuffDesLabel:SetText(StringTable.Get(cfg.TalePetBuffDes))
  self._normalPetBuffDesLabel:SetText(StringTable.Get(cfg.NormalPetBuffDes1))
  self._icon:LoadImage(cfg.BuffIcon)
  local level, maxLevel = self._talePetModule:GetBuffLevel()
  if maxLevel <= level then
    self._expBar.value = 1
    self._expLabel:SetText(StringTable.Get("str_tale_pet_buff_max_level"))
  else
    self._expBar.value = self._exp / self._maxExp
    self._expLabel:SetText("(" .. self._exp .. "/" .. self._maxExp .. ")")
  end
  self._levelLabel:SetText(StringTable.Get("str_tale_pet_trail_level_buff_level1", self._currentLevel))
end

function UITrailLevelBuffDes:RefreshButtonStatus()
  if self._currentLevel >= self._maxLevel then
    self._nextBtn:SetActive(false)
  else
    self._nextBtn:SetActive(true)
  end
  self._preBtn:SetActive(false)
end

function UITrailLevelBuffDes:NextBtnOnClick()
  self:Lock("UITrailLevelBuffDes_PlayAnim")
  GameGlobal.TaskManager():StartTask(self.PlayAnim, self, false)
end

function UITrailLevelBuffDes:PreBtnOnClick()
  self:Lock("UITrailLevelBuffDes_PlayAnim")
  GameGlobal.TaskManager():StartTask(self.PlayAnim, self, true)
end

function UITrailLevelBuffDes:PlayAnim(TT, isPre)
  self._anim:Play("uieff_uiTrailLevel_title01")
  YIELD(TT, 460)
  if isPre then
    self._currentLevel = self._currentLevel - 1
    self._nextBtn:SetActive(true)
    self._preBtn:SetActive(false)
    self:RefreshUI()
  else
    self._currentLevel = self._currentLevel + 1
    self._nextBtn:SetActive(false)
    self._preBtn:SetActive(true)
    self:RefreshUI()
  end
  YIELD(TT, 730)
  self:UnLock("UITrailLevelBuffDes_PlayAnim")
end

function UITrailLevelBuffDes:InsBtnOnClick()
  self:ShowDialog("UITrailLevelBuffIntroduce", self._currentLevel)
end
