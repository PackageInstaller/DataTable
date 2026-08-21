require("ui_season_maze_room_base")
_class("UISeasonMazeRoom_Campsites", UISeasonMazeRoomBase)
UISeasonMazeRoom_Campsites = UISeasonMazeRoom_Campsites

function UISeasonMazeRoom_Campsites:InitWidget()
  self.UISeasonMazeBossAtk = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeBossAtk")
  self._UISeasonMazeTopIconPool = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeTopIcon")
  self.BankCount = self:GetUIComponent("UILocalizationText", "BankCount")
  self.smithyPrize = self:GetGameObject("smithyPrize")
  local backBtn = self:GetUIComponent("UISelectObjectPath", "backBtn")
  self._backBtn = backBtn:SpawnObject("UISMazeCommonTopButton")
  self._backBtn:SetData(function()
    self._seasonMazeModule:UIModule():ExitTo(UIStateType.UISeasonMazeMain)
  end, function()
    UISeasonMazeModule.OpenHelpUI(UISeasonMazeHelperTabIndex.Temp5, 10)
  end, function()
    self._seasonMazeModule:UIModule():ExitTo(UIStateType.UIMain)
  end)
  self.BeadBtnObj = self:GetGameObject("BeadBtn")
  self.role = self:GetGameObject("role")
  self.role:SetActive(false)
  self.roleRender = self:GetUIComponent("MeshRenderer", "role")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "iconLoader")
  self._iconRawImage = self:GetUIComponent("RawImage", "iconLoader")
  self._red = self:GetGameObject("Red")
  self._redCount = self:GetGameObject("Count")
  self._redCountValue = self:GetUIComponent("UILocalizationText", "CountValue")
  self._anim_med = self:GetUIComponent("Animation", "MedicalBtn")
  self._anim_life = self:GetUIComponent("Animation", "LifeBtn")
  self._anim_rec = self:GetUIComponent("Animation", "RecruitBtn")
  self._anim_smi = self:GetUIComponent("Animation", "Smithy")
  self._anim_bank = self:GetUIComponent("Animation", "Bank")
  self._go_med = self:GetGameObject("MedicalBtn")
  self._go_life = self:GetGameObject("LifeBtn")
  self._go_rec = self:GetGameObject("RecruitBtn")
  self._go_bank = self:GetGameObject("BankBtn")
  self._go_smi = self:GetGameObject("SmithyBtn")
  self._recruitRed = self:GetGameObject("recruitRed")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._go_med), UIEvent.Press, function(go)
    self._anim_med:Play()
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._go_life), UIEvent.Press, function(go)
    self._anim_life:Play()
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._go_rec), UIEvent.Press, function(go)
    self._anim_rec:Play()
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._go_bank), UIEvent.Press, function(go)
    self._anim_bank:Play()
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._go_smi), UIEvent.Press, function(go)
    self._anim_smi:Play()
  end)
end

function UISeasonMazeRoom_Campsites:SetTopIcon()
  self._UISeasonMazeTopIconWidget = self._UISeasonMazeTopIconPool:SpawnObject("UISeasonMazeTopIcon")
  self._UISeasonMazeTopIconWidget:SetData({
    SeasonMazeTopIconType.Lv,
    SeasonMazeTopIconType.Ms,
    SeasonMazeTopIconType.Money
  })
end

function UISeasonMazeRoom_Campsites:SetRecruitRed(bRed)
  self._hasRecruited = not bRed
  if self._recruitRed then
    self._recruitRed:SetActive(bRed)
  end
end

function UISeasonMazeRoom_Campsites:OnShowUI()
  self:InitWidget()
  self:SetTopIcon()
  self:SetBossAtk()
  self:SetBank()
  self:SetSmithy()
  self:RefreshNew()
  self:OnRecruitPetSucc(self._resultPet)
  self:AttachEvent(GameEventType.OnUISeasonMazeAttChanged, self.OnUISeasonMazeAttChanged)
  self:AttachEvent(GameEventType.OnRecruitPetSucc, self.OnRecruitPetSucc)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.RefreshNew)
  self:SetRecruitRed(not self._hasRecruited)
  self:_CheckGuide()
end

function UISeasonMazeRoom_Campsites:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UISeasonMazeRoom_Campsites)
end

function UISeasonMazeRoom_Campsites:RefreshNew()
  local count = 0
  local isUnlock = false
  local componentInfo = self._component:GetComponentInfo()
  if componentInfo then
    if componentInfo.m_auto_bead_map then
      for _, value in pairs(componentInfo.m_auto_bead_map) do
        local data = value
        if data and data.bead_info.b_new then
          count = count + 1
        end
      end
    end
    local cfgs = Cfg.cfg_component_season_maze({
      Hard = componentInfo.hard
    })
    if cfgs and cfgs[1] then
      isUnlock = 0 < cfgs[1].BeadSlotCnt
    end
  end
  if isUnlock then
    self._red:SetActive(count == 1)
    self._redCount:SetActive(1 < count)
    self._redCountValue:SetText(tostring(count))
  end
  self.BeadBtnObj:SetActive(isUnlock)
end

function UISeasonMazeRoom_Campsites:GetPets()
  local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  local seasonMazeObj = seasonMazeModule:CurSeasonObj()
  local cfgid = seasonMazeObj:GetMazeComponent():GetComponentCfgId()
  local uimodule = seasonMazeModule:GetUIModule()
  self._pets = {}
  local currentMazeLv = 1
  local cfg_lvs = Cfg.cfg_component_season_maze_lv({ComponentID = cfgid, Lv = currentMazeLv})
  local cfg_lv
  if cfg_lvs and next(cfg_lvs) then
    cfg_lv = cfg_lvs[1]
  else
    Log.error("###[UISeasonMazeRoom_Campsites] cfg_lvs is nil ! id --> ", currentMazeLv)
  end
  local petModule = GameGlobal.GetModule(PetModule)
  for index, value in ipairs(self._randomPets) do
    local pstid = 0
    local templateID = value
    local level = 1
    local grade = 0
    local awake = 0
    local equip = 0
    local skinId = 0
    local localPetData = petModule:GetPetByTemplateId(templateID)
    if localPetData then
      pstid = localPetData:GetPstID()
      awake = localPetData:GetPetAwakening()
      if cfg_lv.PetAwake and 0 < cfg_lv.PetAwake then
        awake = cfg_lv.PetAwake
      end
      grade = localPetData:GetPetGrade()
      level = localPetData:GetPetLevel()
      if cfg_lv.PetGrade and 0 < cfg_lv.PetGrade then
        grade = cfg_lv.PetGrade
        if cfg_lv.PetLv and 0 < cfg_lv.PetLv then
          level = cfg_lv.PetLv
        end
        grade, level = uimodule:GetPetGradeLv(templateID, grade, level)
      end
      equip = localPetData:GetEquipLv()
      if cfg_lv.PetEquip and 0 < cfg_lv.PetEquip then
        equip = cfg_lv.PetEquip
      end
      skinId = localPetData:GetSkinId()
    else
      if cfg_lv.PetAwake and 0 < cfg_lv.PetAwake then
        awake = cfg_lv.PetAwake
      end
      if cfg_lv.PetGrade and 0 < cfg_lv.PetGrade then
        grade = cfg_lv.PetGrade
        if cfg_lv.PetLv and 0 < cfg_lv.PetLv then
          level = cfg_lv.PetLv
        end
        grade, level = uimodule:GetPetGradeLv(templateID, grade, level)
      end
      if cfg_lv.PetEquip and 0 < cfg_lv.PetEquip then
        equip = cfg_lv.PetEquip
      end
    end
    local codeCheckPetData = _G.pet_data
    local tempData = codeCheckPetData:New()
    tempData.pet_pstid = pstid
    tempData.template_id = templateID
    tempData.current_skin = skinId or 0
    local pet = Pet:New(tempData)
    tempData.grade = grade
    tempData.level = level
    tempData.awakening = awake
    tempData.equip_lv = equip
    pet:SetData(tempData)
    table.insert(self._pets, pet)
  end
end

function UISeasonMazeRoom_Campsites:LoadDataOnEnter(TT, res, uiParams)
  local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  local seasonMazeObj = seasonMazeModule:CurSeasonObj()
  local component = seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  local response = component:HandleSeasonMazePetRecruitList(TT, res)
  self._resultPet = nil
  self._hasRecruited = false
  if res:GetSucc() then
    self._randomPets = response.pet_list
    local selectedPet = response.select_pet
    if selectedPet and 0 < selectedPet then
      self._hasRecruited = true
      self:GetPets()
      for index, value in ipairs(self._pets) do
        if value:GetTemplateID() == selectedPet then
          self._resultPet = value
          break
        end
      end
    elseif not self._randomPets or #self._randomPets == 0 then
      self._hasRecruited = true
    end
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMazeRoom_Campsites] HandleSeasonMazePetRecruitList fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoom_Campsites:OnRecruitPetSucc(pet)
  if pet then
    local icon = pet:GetPetVideo(PetSkinEffectPath.HEAD_ICON_WE_CHAT)
    if icon then
      self._iconLoader:LoadImage(icon)
      local texture = self._iconRawImage.material.mainTexture
      self.role:SetActive(true)
      self.roleRender.material:SetTexture("_MainTex", texture)
      return
    end
  end
  self.role:SetActive(false)
end

function UISeasonMazeRoom_Campsites:OnUISeasonMazeAttChanged()
  self:SetBank()
end

function UISeasonMazeRoom_Campsites:SetBossAtk()
  if self.UISeasonMazeBossAtk then
    if not self.UISeasonMazeBossAtkWidget then
      self.UISeasonMazeBossAtkWidget = self.UISeasonMazeBossAtk:SpawnObject("UISeasonMazeBossAtk")
    end
    self.UISeasonMazeBossAtkWidget:SetData()
  end
end

function UISeasonMazeRoom_Campsites:SetBank()
  local curHard = self._comInfo.hard
  local cfgs = Cfg.cfg_component_season_maze_save({
    ComponentID = self._comCfgID,
    LockHard = curHard
  })
  local max = 0
  if cfgs and 0 < table.count(cfgs) then
    for key, value in pairs(cfgs) do
      max = math.max(max, value.NeedNum)
    end
  end
  self._currentSaveCount = self._comInfo.save_info.exp
  self.BankCount:SetText(StringTable.Get("str_season_maze_room_camp_bank_count", self._currentSaveCount .. "/" .. max))
end

function UISeasonMazeRoom_Campsites:SetSmithy()
  self:ReqSlotInfos()
end

function UISeasonMazeRoom_Campsites:ReqSlotInfos()
  self:Lock("UISeasonMaze_Campsites_Smithy:ReqSlotInfos")
  GameGlobal.TaskManager():StartTask(self.TaskReqSlotInfos, self)
end

function UISeasonMazeRoom_Campsites:TaskReqSlotInfos(TT)
  local res = AsyncRequestRes:New()
  local response = self._component:HandleSeasonMazeGetSlot(TT, res)
  self:UnLock("UISeasonMaze_Campsites_Smithy:ReqSlotInfos")
  if res:GetSucc() then
    local comInfo = self._component:GetComponentInfo()
    local slotInfo = comInfo.slot_info
    if slotInfo then
      local prizeTag = slotInfo.dis_index
      self.smithyPrize:SetActive(prizeTag and 0 < prizeTag)
    end
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMazeRoom_Campsites] HandleSeasonMazeGetSlot fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoom_Campsites:OnHide()
end

function UISeasonMazeRoom_Campsites:NextBtnOnClick(go)
  if not self._hasRecruited then
    UISeasonMazeModule.PopMsgBox("", StringTable.Get("str_season_maze_room_camp_next_tip2"), SeasonMazeMsgBoxType.OkCancel, function()
      self:RecruitBtnOnClick()
    end, nil, function()
      self:OnHideUI()
    end, nil, function(popUI)
      popUI:SetOkCancelBtnTxt(StringTable.Get("str_season_maze_room_camp_recruit_jump"), StringTable.Get("str_season_maze_room_camp_next"))
    end)
    return
  end
  UISeasonMazeModule.PopMsgBox("", StringTable.Get("str_season_maze_room_camp_next_tip"), SeasonMazeMsgBoxType.OkCancel, function()
    self:OnHideUI()
  end)
end

function UISeasonMazeRoom_Campsites:MedicalBtnOnClick(go)
  self:ShowDialog("UISeasonMaze_Campsites_Medical")
end

function UISeasonMazeRoom_Campsites:LifeBtnOnClick(go)
  self:ShowDialog("UISeasonMaze_Campsites_Life")
end

function UISeasonMazeRoom_Campsites:BankBtnOnClick(go)
  self:ShowDialog("UISeasonMaze_Campsites_Bank")
end

function UISeasonMazeRoom_Campsites:SmithyBtnOnClick(go)
  self:ShowDialog("UISeasonMaze_Campsites_Smithy")
end

function UISeasonMazeRoom_Campsites:RecruitBtnOnClick(go)
  self:ShowDialog("UISeasonMaze_Campsites_Recruit")
end

function UISeasonMazeRoom_Campsites:BagBtnOnClick(go)
  self:ShowDialog("UISeasonMazeBackPackController", 1)
end

function UISeasonMazeRoom_Campsites:BeadBtnOnClick(go)
  self:ShowDialog("UISeasonMazeBead")
end
