require("ui_season_maze_campsites_base")
_class("UISeasonMaze_Campsites_Recruit", UISeasonMaze_Campsites_Base)
UISeasonMaze_Campsites_Recruit = UISeasonMaze_Campsites_Recruit

function UISeasonMaze_Campsites_Recruit:InitWidget()
  self._choosePool = self:GetUIComponent("UISelectObjectPath", "choosePool")
  self._resultPool = self:GetUIComponent("UISelectObjectPath", "resultPool")
  self._chooseGo = self:GetGameObject("choose")
  self._resultGo = self:GetGameObject("result")
  self._returnBgGo = self:GetGameObject("ReturnBg")
  self._ResetMaskGo = self:GetGameObject("ResetMask")
  self._EmptyTipsGo = self:GetGameObject("EmptyTips")
  self.topBtn = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._ResetCostText = self:GetUIComponent("UILocalizationText", "ResetCostText")
  self.UISeasonMazeTopIcon = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeTopIcon")
  self._rootAnim = self:GetGameObject():GetComponent("Animation")
  self._randomPets = {}
end

function UISeasonMaze_Campsites_Recruit:SetTopBtn()
  self.topBtn:SpawnObject("UISMazeCommonTopButton"):SetData(function()
    self:CloseDialogWithAnim()
  end, nil, nil, true)
end

function UISeasonMaze_Campsites_Recruit:CloseDialogWithAnim()
  self:Lock("UISeasonMaze_Campsites_Recruit:CloseDialogWithAnim")
  if self._rootAnim then
    self._rootAnim:Play("uianim_UISeasonMaze_Campsites_Recruit_out")
  end
  self:StartTask(function(TT)
    YIELD(TT, 267)
    self:UnLock("UISeasonMaze_Campsites_Recruit:CloseDialogWithAnim")
    self:CloseDialog()
  end, self)
end

function UISeasonMaze_Campsites_Recruit:ShowChoosePet()
  self._chooseGo:SetActive(true)
  self._resultGo:SetActive(false)
  self._returnBgGo:SetActive(false)
  if #self._pets == 0 then
    self._EmptyTipsGo:SetActive(true)
    self._chooseGo:SetActive(false)
    return
  else
    self._EmptyTipsGo:SetActive(false)
  end
  self._choosePool:SpawnObjects("UISeasonMaze_Campsites_Recruit_Item", #self._pets)
  local pools = self._choosePool:GetAllSpawnList()
  self._cellWidgets = pools
  for i = 1, #self._pets do
    local pet = self._pets[i]
    local widget = pools[i]
    widget:SetData(i, pet, self._pets, function(idx)
      self:OnPetClick(idx)
    end)
  end
  self:PlayChooseCardsShowInAnim()
end

function UISeasonMaze_Campsites_Recruit:PlayChooseCardsShowInAnim()
  local lockName = "UISeasonMaze_Campsites_Recruit:PlayChooseCardsShowInAnim"
  self:StartTask(function(TT)
    self:Lock(lockName)
    local eachDelay = 60
    local lockTime = 667
    local maxDelayMs = 0
    if self._cellWidgets then
      for index, widget in ipairs(self._cellWidgets) do
        local delayMs = (index - 1) * eachDelay
        widget:PlayShowInAnim(delayMs)
        maxDelayMs = delayMs
      end
    end
    lockTime = lockTime + maxDelayMs
    YIELD(TT, lockTime)
    self:UnLock(lockName)
  end)
end

function UISeasonMaze_Campsites_Recruit:OnPetClick(idx)
  self._chooseIdx = idx
  local pools = self._choosePool:GetAllSpawnList()
  for i = 1, #self._pets do
    local widget = pools[i]
    widget:Select(self._chooseIdx)
  end
  local lockName = "UISeasonMaze_Campsites_Recruit:OnPetClick"
  self:StartTask(function(TT)
    self:Lock(lockName)
    local lockTime = 400
    YIELD(TT, lockTime)
    self:UnLock(lockName)
  end)
end

function UISeasonMaze_Campsites_Recruit:ShowResultPet()
  self._chooseGo:SetActive(false)
  self._resultGo:SetActive(true)
  self._returnBgGo:SetActive(true)
  self._resultWidget = self._resultPool:SpawnObject("UISeasonMaze_Campsites_Recruit_Item")
  self._resultWidget:SetData(1, self._resultPet, {
    self._resultPet
  })
  self._resultWidget:PlayShowInAnim(0)
end

function UISeasonMaze_Campsites_Recruit:ReqChoosePetList()
  self:Lock("UISeasonMaze_Campsites_Recruit:ReqChoosePetList")
  GameGlobal.TaskManager():StartTask(self.TaskReqChoosePetList, self)
end

function UISeasonMaze_Campsites_Recruit:TaskReqChoosePetList(TT)
  local res = AsyncRequestRes:New()
  local response = self._com:HandleSeasonMazePetRecruitList(TT, res)
  if res:GetSucc() then
    self._randomPets = response.pet_list
    local selectedPet = response.select_pet
    if selectedPet and 0 < selectedPet then
      self:GetPets()
      self._resultPet = nil
      for index, value in ipairs(self._pets) do
        if value:GetTemplateID() == selectedPet then
          self._resultPet = value
          break
        end
      end
      self:ShowResultPet()
      self:UnLock("UISeasonMaze_Campsites_Recruit:ReqChoosePetList")
    else
      self._resetCount = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_PetResetCnt)
      self:GetPets()
      self:ShowChoosePet()
      self:ShowResetBtn()
      self:UnLock("UISeasonMaze_Campsites_Recruit:ReqChoosePetList")
    end
  else
    self:UnLock("UISeasonMaze_Campsites_Recruit:ReqChoosePetList")
    local result = res:GetResult()
    Log.error("###[UISeasonMaze_Campsites_Recruit] HandleSeasonMazePetRecruitList fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMaze_Campsites_Recruit:GetPets()
  self._pets = {}
  local currentMazeLv = 1
  local cfg_lvs = Cfg.cfg_component_season_maze_lv({Lv = currentMazeLv})
  local cfg_lv
  if cfg_lvs and next(cfg_lvs) then
    cfg_lv = cfg_lvs[1]
  else
    Log.error("###[UISeasonMaze_Campsites_Recruit] cfg_lvs is nil ! id --> ", currentMazeLv)
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
        grade, level = self._uiSeasonMazeModule:GetPetGradeLv(templateID, grade, level)
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
        grade, level = self._uiSeasonMazeModule:GetPetGradeLv(templateID, grade, level)
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

function UISeasonMaze_Campsites_Recruit:OnShowUI(uiParams)
  self._mulitOpen = UnityEngine.Input.multiTouchEnabled
  UnityEngine.Input.multiTouchEnabled = false
  self:InitWidget()
  self._chooseIdx = 0
  self:SetTopBtn()
  self:SetUISeasonMazeTopIcon()
  self:ReqChoosePetList()
end

function UISeasonMaze_Campsites_Recruit:SetUISeasonMazeTopIcon()
  if self.UISeasonMazeTopIcon then
    if not self.UISeasonMazeTopIconWidget then
      self.UISeasonMazeTopIconWidget = self.UISeasonMazeTopIcon:SpawnObject("UISeasonMazeTopIcon")
    end
    local typeList = {
      SeasonMazeTopIconType.Money
    }
    self.UISeasonMazeTopIconWidget:SetData(typeList)
  end
end

function UISeasonMaze_Campsites_Recruit:GetCostNumber()
  return self:CalcResetCost(self._resetCount, self._cfg_global.PetParam)
end

function UISeasonMaze_Campsites_Recruit:ShowResetBtn()
  local cost = self:GetCostNumber()
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local costStr = tostring(cost)
  if cost > curGold then
    costStr = "<color=#c97d7d>" .. costStr .. "</color>"
  end
  self._ResetCostText:SetText(costStr)
  if self:_ResetHasEnoughPet() then
    self._ResetMaskGo:SetActive(false)
  else
    self._ResetMaskGo:SetActive(true)
  end
end

function UISeasonMaze_Campsites_Recruit:ChooseBtnOnClick(go)
  if self._chooseIdx == 0 then
    return
  end
  if not self._pets[self._chooseIdx] then
    return
  end
  self._resultPet = self._pets[self._chooseIdx]
  local pstid = self._resultPet:GetPstID()
  local templateID = self._resultPet:GetTemplateID()
  self:ReqSelectPet(templateID)
end

function UISeasonMaze_Campsites_Recruit:ReqSelectPet(templateID)
  self:Lock("UISeasonMaze_Campsites_Recruit:ReqSelectPet")
  GameGlobal.TaskManager():StartTask(self.TaskReqSelectPet, self, templateID)
end

function UISeasonMaze_Campsites_Recruit:TaskReqSelectPet(TT, templateID)
  local res = AsyncRequestRes:New()
  local response = self._com:HandleSeasonMazePetRecruitSelect(TT, res, templateID)
  if res:GetSucc() then
    self:ShowResultPet()
    YIELD(TT, 1000)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnRecruitPetSucc, self._resultPet)
    self:UnLock("UISeasonMaze_Campsites_Recruit:ReqSelectPet")
    local uiController = GameGlobal.UIStateManager():GetController("UISeasonMazeRoom_Campsites")
    if uiController then
      uiController:SetRecruitRed(false)
    end
    self:CloseDialogWithAnim()
  else
    self:UnLock("UISeasonMaze_Campsites_Recruit:ReqSelectPet")
    local result = res:GetResult()
    Log.error("###[UISeasonMaze_Campsites_Recruit] HandleSeasonMazePetRecruitSelect fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMaze_Campsites_Recruit:ResetBtnOnClick(go)
  self:ReqResetPetList()
end

function UISeasonMaze_Campsites_Recruit:ReqResetPetList()
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local cost = self:GetCostNumber()
  if curGold < cost then
    local tips = StringTable.Get("str_season_maze_gold_not_enough")
    ToastManager.ShowToast(tips)
    return
  end
  self:Lock("UISeasonMaze_Campsites_Recruit:ReqResetPetList")
  GameGlobal.TaskManager():StartTask(self.TaskReqResetPetList, self)
end

function UISeasonMaze_Campsites_Recruit:TaskReqResetPetList(TT)
  local res = AsyncRequestRes:New()
  local response = self._com:HandleSeasonMazePetRecruitReset(TT, res)
  self:UnLock("UISeasonMaze_Campsites_Recruit:ReqResetPetList")
  if res:GetSucc() then
    self._randomPets = response.pet_list
    self._chooseIdx = 0
    self._resetCount = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_PetResetCnt)
    self:GetPets()
    self:ShowChoosePet()
    self:ShowResetBtn()
    self:RefreshMoney()
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMaze_Campsites_Recruit] HandleSeasonMazePetRecruitReset fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMaze_Campsites_Recruit:OnHide()
  UnityEngine.Input.multiTouchEnabled = self._mulitOpen
end

function UISeasonMaze_Campsites_Recruit:RefreshMoney()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Gold)
end

function UISeasonMaze_Campsites_Recruit:BagBtnOnClick(go)
  self:ShowDialog("UISeasonMazeBackPackController", 1)
end

function UISeasonMaze_Campsites_Recruit:_ResetHasEnoughPet()
  local cfgs = Cfg.cfg_season_maze_pet({})
  local cfgPetCount = table.count(cfgs)
  local banCfgs = Cfg.cfg_season_maze_pet({Ban = 1})
  local banCount = table.count(banCfgs)
  cfgPetCount = cfgPetCount - banCount
  local comInfo = self._com:GetComponentInfo()
  local bagPetCount = table.count(comInfo.m_bag_info.pet_list)
  local showPetCount = 0
  local resetMinPetCount = 3
  if resetMinPetCount >= cfgPetCount - (bagPetCount + showPetCount) then
    return false
  else
    return true
  end
end

function UISeasonMaze_Campsites_Recruit:ResetMaskOnClick(go)
  local tips = StringTable.Get("str_season_maze_recruit_tips_1")
  ToastManager.ShowToast(tips)
end

function UISeasonMaze_Campsites_Recruit:ReturnBgOnClick(go)
  self:CloseDialogWithAnim()
end
