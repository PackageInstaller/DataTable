_class("UISeasonMazeRoom_DirectionalRecruitChoosePet", UICustomWidget)
UISeasonMazeRoom_DirectionalRecruitChoosePet = UISeasonMazeRoom_DirectionalRecruitChoosePet

function UISeasonMazeRoom_DirectionalRecruitChoosePet:InitWidget()
  self._choosePool = self:GetUIComponent("UISelectObjectPath", "choosePool")
  self._resultPool = self:GetUIComponent("UISelectObjectPath", "resultPool")
  self._chooseGo = self:GetGameObject("choose")
  self._resultGo = self:GetGameObject("result")
  self._returnBgGo = self:GetGameObject("ReturnBg")
  self._ResetMaskGo = self:GetGameObject("ResetMask")
  self._EmptyTipsGo = self:GetGameObject("EmptyTips")
  self._resultBgGo = self:GetGameObject("ResultBg")
  self._chooseBgGo = self:GetGameObject("Bg")
  self._ResetCostText = self:GetUIComponent("UILocalizationText", "ResetCostText")
  self.UISeasonMazeTopIcon = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeTopIcon")
  self._rootAnim = self:GetGameObject():GetComponent("Animation")
  self._randomPets = {}
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:OnShow()
  self:InitWidget()
  self._chooseIdx = 0
  self:SetUISeasonMazeTopIcon()
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:SetData(backCb, finishCb)
  self._uiSeasonMazeModule = GameGlobal.GetUIModule(SeasonMazeModule)
  local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  local seasonMazeObj = seasonMazeModule:CurSeasonObj()
  self._com = seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._comInfo = self._com:GetComponentInfo()
  self._comCfgID = self._com:GetComponentCfgId()
  self._cfg_global = Cfg.cfg_component_season_maze_global[self._comCfgID]
  self._backCb = backCb
  self._finishCb = finishCb
  self._randomPets = self._comInfo.m_recruit_room_pet_list
  self._resetCount = self._comInfo.m_recruit_room_reflush_cnt
  self:GetPets()
  self:ShowChoosePet()
  self:ShowResetBtn()
  self:RefreshMoney()
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:OnHide()
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:BackBtnOnClick(go)
  if self._backCb then
    self._backCb()
  end
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:SetUISeasonMazeTopIcon()
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

function UISeasonMazeRoom_DirectionalRecruitChoosePet:ShowChoosePet()
  self._chooseGo:SetActive(true)
  self._resultGo:SetActive(false)
  self._returnBgGo:SetActive(false)
  self._chooseBgGo:SetActive(true)
  self._resultBgGo:SetActive(false)
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

function UISeasonMazeRoom_DirectionalRecruitChoosePet:PlayChooseCardsShowInAnim()
  local lockName = "UISeasonMazeRoom_DirectionalRecruitChoosePet:PlayChooseCardsShowInAnim"
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

function UISeasonMazeRoom_DirectionalRecruitChoosePet:OnPetClick(idx)
  self._chooseIdx = idx
  local pools = self._choosePool:GetAllSpawnList()
  for i = 1, #self._pets do
    local widget = pools[i]
    widget:Select(self._chooseIdx)
  end
  local lockName = "UISeasonMazeRoom_DirectionalRecruitChoosePet:OnPetClick"
  self:StartTask(function(TT)
    self:Lock(lockName)
    local lockTime = 400
    YIELD(TT, lockTime)
    self:UnLock(lockName)
  end)
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:ShowResultPet()
  self._chooseGo:SetActive(false)
  self._resultGo:SetActive(true)
  self._returnBgGo:SetActive(true)
  self._chooseBgGo:SetActive(false)
  self._resultBgGo:SetActive(true)
  self._resultWidget = self._resultPool:SpawnObject("UISeasonMaze_Campsites_Recruit_Item")
  self._resultWidget:SetData(1, self._resultPet, {
    self._resultPet
  })
  self._resultWidget:PlayShowInAnim(0)
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:GetPets()
  self._pets = {}
  local currentMazeLv = 1
  local cfg_lvs = Cfg.cfg_component_season_maze_lv({Lv = currentMazeLv})
  local cfg_lv
  if cfg_lvs and next(cfg_lvs) then
    cfg_lv = cfg_lvs[1]
  else
    Log.error("###[UISeasonMazeRoom_DirectionalRecruitChoosePet] cfg_lvs is nil ! id --> ", currentMazeLv)
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

function UISeasonMazeRoom_DirectionalRecruitChoosePet:GetCostNumber()
  return self:CalcResetCost(self._resetCount, self._cfg_global.RerollPetRoom)
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:CalcResetCost(resetCount, cfgParam)
  local x = resetCount or 0
  local cfg_reset = cfgParam
  local a = cfg_reset[1]
  local b = cfg_reset[2]
  local c = cfg_reset[3]
  if not (a and b) or not c then
    Log.error("###[UISeasonMazeRoom_DirectionalRecruitChoosePet] self._cfg_global.RerollPetRoom is nil !")
  end
  local baseCost = a * x ^ 2 + b * x + c
  local shopParam = 1
  local comInfo = self._com:GetComponentInfo()
  local priceAttr = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Goods_Price_Percent)
  local currentHard = comInfo.hard
  local seasonMazeCfg = self:GetSeasonMazeCfg(currentHard)
  if seasonMazeCfg then
    local bossInfos = comInfo.boss_info
    local bossCount = table.count(bossInfos)
    for i = 0, bossCount - 1 do
      local bossInfo = bossInfos[i]
      if bossInfo.do_cnt ~= -1 then
        shopParam = (seasonMazeCfg.ShopIndex[i + 1] + priceAttr) / 1000
        break
      end
    end
  end
  local cost = baseCost * shopParam
  cost = lmathext.round(cost)
  return cost
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:ShowResetBtn()
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

function UISeasonMazeRoom_DirectionalRecruitChoosePet:ChooseBtnOnClick(go)
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

function UISeasonMazeRoom_DirectionalRecruitChoosePet:ReqSelectPet(templateID)
  self:Lock("UISeasonMazeRoom_DirectionalRecruitChoosePet:ReqSelectPet")
  GameGlobal.TaskManager():StartTask(self.TaskReqSelectPet, self, templateID)
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:TaskReqSelectPet(TT, templateID)
  local res = AsyncRequestRes:New()
  local response = self._com:HandleSeasonMazeRecruitRoomSelect(TT, res, templateID)
  self:UnLock("UISeasonMazeRoom_DirectionalRecruitChoosePet:ReqSelectPet")
  if res:GetSucc() then
    self:ShowResultPet()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnRecruitPetSucc, self._resultPet)
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMazeRoom_DirectionalRecruitChoosePet] HandleSeasonMazePetRecruitSelect fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:ResetBtnOnClick(go)
  self:ReqResetPetList()
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:ReqResetPetList()
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local cost = self:GetCostNumber()
  if curGold < cost then
    local tips = StringTable.Get("str_season_maze_gold_not_enough")
    ToastManager.ShowToast(tips)
    return
  end
  self:Lock("UISeasonMazeRoom_DirectionalRecruitChoosePet:ReqResetPetList")
  GameGlobal.TaskManager():StartTask(self.TaskReqResetPetList, self)
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:TaskReqResetPetList(TT)
  local res = AsyncRequestRes:New()
  local response = self._com:HandleSeasonMazeRecruitRoomReflush(TT, res)
  self:UnLock("UISeasonMazeRoom_DirectionalRecruitChoosePet:ReqResetPetList")
  if res:GetSucc() then
    self._randomPets = response.pet_list
    self._chooseIdx = 0
    self._resetCount = self._comInfo.m_recruit_room_reflush_cnt
    self:GetPets()
    self:ShowChoosePet()
    self:ShowResetBtn()
    self:RefreshMoney()
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMazeRoom_DirectionalRecruitChoosePet] HandleSeasonMazeRecruitRoomReflush fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:RefreshMoney()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Gold)
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:BagBtnOnClick(go)
  self:ShowDialog("UISeasonMazeBackPackController", 1)
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:BagBtn1OnClick(go)
  self:ShowDialog("UISeasonMazeBackPackController", 1)
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:_ResetHasEnoughPet()
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

function UISeasonMazeRoom_DirectionalRecruitChoosePet:ResetMaskOnClick(go)
  local tips = StringTable.Get("str_season_maze_recruit_tips_1")
  ToastManager.ShowToast(tips)
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:GetSeasonMazeCfg(hardLevel)
  local cfgs = Cfg.cfg_component_season_maze({
    ComponentID = self._comCfgID
  })
  if cfgs and table.count(cfgs) > 0 then
    for _, v in pairs(cfgs) do
      if v.Hard == hardLevel then
        return v
      end
    end
  end
  return nil
end

function UISeasonMazeRoom_DirectionalRecruitChoosePet:ReturnBgOnClick(go)
  local resultPetTemplateID = self._resultPet:GetTemplateID()
  if self._finishCb then
    self._finishCb(resultPetTemplateID)
  end
end
