_class("UISeasonMazeBanPetHeartItem", UICustomWidget)
UISeasonMazeBanPetHeartItem = UISeasonMazeBanPetHeartItem

function UISeasonMazeBanPetHeartItem:Constructor()
  self._heartItemInfo = nil
  self._callBack = nil
  self._petModule = GameGlobal.GameLogic():GetModule(PetModule)
end

function UISeasonMazeBanPetHeartItem:OnShow()
  self._uiHeartItemAtlas = self:RootUIOwner():GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self.atlasProperty = self:RootUIOwner():GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._atlasAwake = self:RootUIOwner():GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._newTeamAtlas = self:RootUIOwner():GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self._dialLine2Hp = Cfg.cfg_global.UIWidgetBattlePet_dialLine2Hp.IntValue or 200
  self._bigDiaLine = Cfg.cfg_global.UIWidgetBattlePet_bigDiaLine.IntValue or 5
  self._firstAttIcon = self:GetUIComponent("Image", "firstAttribute")
  self._secondAttribute = self:GetUIComponent("Image", "secondAttribute")
  self._firstGo = self:GetGameObject("first")
  self._secondGo = self:GetGameObject("second")
  self._nameText = self:GetUIComponent("UILocalizationText", "name")
  self._lvValueText = self:GetUIComponent("UILocalizationText", "lvValue")
  self._logo = self:GetUIComponent("RawImageLoader", "logo")
  self._rawimage = self:GetUIComponent("RawImageLoader", "drawIcon")
  self._gradeIcon = self:GetUIComponent("Image", "grade")
  self._qualityIcon = self:GetUIComponent("Image", "qualityIcon")
  self._power = self:GetGameObject("power")
  self._powerValue = self:GetUIComponent("UILocalizationText", "powerValue")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._new = self:GetGameObject("new")
  self._new:SetActive(false)
  self._select = self:GetGameObject("select")
  self._diLayer = self:GetGameObject("diLayer")
  self._interactTarget = self:GetUIComponent("Graphic", "diLayer")
  self._stars = self:GetGameObject("stars")
  self._hp = self:GetGameObject("hp")
  self._hpvalue = self:GetUIComponent("Image", "hpvalue")
  self._hpvalueRect = self:GetUIComponent("RectTransform", "dialLines")
  self._hpbg = self:GetUIComponent("Image", "hpbg")
  self._dialLines = self:GetUIComponent("UISelectObjectPath", "dialLines")
  self._lineRoot = self:GetUIComponent("RectTransform", "dialLines")
  self._grayMask = self:GetGameObject("grayMask")
  self._animRoot = self:GetUIComponent("RectTransform", "animRoot")
  self._root = self:GetUIComponent("CanvasGroup", "root")
  self._switchCount = self:GetGameObject("switchCount")
  self._switchCountTex = self:GetUIComponent("UILocalizationText", "switchCountTex")
  self._switchMask = self:GetGameObject("switchCountMask")
  self._redPoint = self:GetGameObject("redPoint")
  self._eliminateTxt = self:GetUIComponent("UILocalizationText", "EliminateTxt")
  self._eliminateRollingText = self:GetUIComponent("RollingText", "EliminateTxt")
  self._eliminateAreaObj = self:GetGameObject("EliminateArea")
  self._eliminateMark = self:GetGameObject("eliminateMark")
  self._eliminateMark:SetActive(false)
  self:ShowRedPoint(false)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._diLayer), UIEvent.Press, function()
    self._select:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._diLayer), UIEvent.Release, function()
    self._select:SetActive(false)
  end)
  self:AttachEvent(GameEventType.CheckCardNew, self.CheckCardNew)
  self:AttachEvent(GameEventType.PetDataChangeEvent, self.PetDataChangeEvent)
end

function UISeasonMazeBanPetHeartItem:PlayFadeInAnim()
  self._anim:Play("uieff_HeartSpiritItem_FadeIn")
end

function UISeasonMazeBanPetHeartItem:ResetInAnim()
  self._root.alpha = 1
end

function UISeasonMazeBanPetHeartItem:PetDataChangeEvent(pstid_list)
  if pstid_list then
    for key, value in pairs(pstid_list) do
      if value == self._petPstID then
        self._heartItemInfo = self._petModule:GetPet(self._petPstID)
        self:ShowInfo()
        break
      end
    end
  end
end

function UISeasonMazeBanPetHeartItem:OnHide()
  self:DetachEvent(GameEventType.CheckCardNew, self.CheckCardNew)
  self:DetachEvent(GameEventType.PetDataChangeEvent, self.PetDataChangeEvent)
  self._heartItemInfo = nil
  self._callBack = nil
  self._rawimage = nil
  self._qualityIcon = nil
  self._lvValueText = nil
  self._nameText = nil
  self._firstAttIcon = nil
  self._secondAttribute = nil
  self._gradeIcon = nil
  self._uiHeartItemAtlas = nil
  self._newTeamAtlas = nil
end

function UISeasonMazeBanPetHeartItem:SetData(pet, callBack, showNew, fristIn, teamType, skinEffectPath, isHelp, isSpPet)
  if fristIn then
    self._anim:Play()
  end
  self._callBack = callBack
  if not pet then
    return
  end
  self._heartItemInfo = pet
  self._petPstID = pet:GetPstID()
  self._showNew = false
  if showNew then
    self._showNew = showNew
  end
  self._fromSeasonMaze = teamType and teamType == TeamOpenerType.SeasonMaze
  self._fromMaze = teamType and teamType == TeamOpenerType.Maze
  self._fromAir = teamType and teamType == TeamOpenerType.Air
  self._skinEffectPath = skinEffectPath
  self._isHelp = isHelp
  self._isSpPet = isSpPet
  self:ShowInfo()
  self:CheckCardNew()
  self:CheckEliminate()
  self._interactTarget.raycastTarget = self._callBack ~= nil
end

function UISeasonMazeBanPetHeartItem:ShowInfo()
  local animPos
  if self._isSpPet then
    animPos = Vector2(0, 20)
  else
    animPos = Vector2(0, -55)
  end
  self._animRoot.anchoredPosition = animPos
  local petBody = self._heartItemInfo:GetPetBody(self._skinEffectPath)
  if petBody then
    self._rawimage:LoadImage(petBody)
  end
  self._nameText:SetText(StringTable.Get(self._heartItemInfo:GetPetName()))
  if self._fromMaze then
    self._lvValueText.gameObject:SetActive(false)
  else
    self._lvValueText.gameObject:SetActive(true)
    local petLevel = self._heartItemInfo:GetPetLevel()
    self._lvValueText:SetText(StringTable.Get("str_pet_config_level") .. petLevel)
  end
  if self._fromSeasonMaze then
  end
  if self._fromSeasonMaze then
  else
    self:GetMazePower(self._fromMaze)
  end
  self:GetSwitchCount()
  self._logo:LoadImage(self._heartItemInfo:GetPetLogo())
  local petStar = self._heartItemInfo:GetPetStar()
  self._qualityIcon.sprite = self._uiHeartItemAtlas:GetSprite("map_biandui_pin" .. petStar)
  self:ShowAwakenAndGradeIcon()
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if cfg_pet_element then
    self._firstAttIcon.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[self._heartItemInfo:GetPetFirstElement()].Icon))
    if self._heartItemInfo:GetPetSecondElement() and 0 < self._heartItemInfo:GetPetSecondElement() then
      self._secondGo:SetActive(true)
      self._secondAttribute.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[self._heartItemInfo:GetPetSecondElement()].Icon))
    else
      self._secondGo:SetActive(false)
    end
  end
  self:_SetEquipLv()
  self:_SetJobIcon()
end

function UISeasonMazeBanPetHeartItem:_SetEquipLv()
  local obj = UIWidgetHelper.SpawnObject(self, "_equipLv", "UIPetEquipLvIcon")
  obj:SetData(self._heartItemInfo, true)
end

function UISeasonMazeBanPetHeartItem:_SetJobIcon()
  local obj = UIWidgetHelper.SpawnObject(self, "_jobIcon", "UIPetJobIcon")
  if self._fromSeasonMaze then
    obj:SetData(self._heartItemInfo, 2, true)
  else
    obj:SetData(self._heartItemInfo, 2, self._fromMaze)
  end
end

function UISeasonMazeBanPetHeartItem:CheckCardNew()
  if self._showNew then
    self._new:SetActive(self._petModule:BeNewPet(self._heartItemInfo:GetTemplateID()))
  end
end

function UISeasonMazeBanPetHeartItem:GetSwitchCount()
  local fromAir = self._fromAir
  self._switchCount:SetActive(fromAir and not self._isHelp)
  if fromAir and not self._isHelp then
    local airModule = GameGlobal.GetModule(AircraftModule)
    local countMax = Cfg.cfg_aircraft_values[35].IntValue or 2
    local room = airModule:GetRoomByRoomType(AirRoomType.TacticRoom)
    local count = room:GetPetRemainFightNum(self._petPstID)
    local countStr = ""
    if count <= 0 then
      countStr = "<color=#f34141>" .. count .. "/" .. countMax .. "</color>"
    else
      countStr = count .. "<color=#f34141>/</color>" .. countMax
    end
    self._switchCountTex:SetText(countStr)
    self._switchMask:SetActive(count <= 0)
  end
end

function UISeasonMazeBanPetHeartItem:GetMazePower(fromMaze)
  if not fromMaze then
    self._hp:SetActive(false)
    self._power:SetActive(false)
    return
  end
  local mazeModule = self:GetModule(MazeModule)
  local useLegendEnergy = mazeModule:IsPetActiveSkillUseLegendEnergy(self._petPstID)
  if not fromMaze or useLegendEnergy then
    self._power:SetActive(false)
  else
    self._power:SetActive(true)
    local powerCurrent, powerUpper = mazeModule:GetPetPower(self._petPstID)
    if powerCurrent < 0 then
      powerCurrent = powerUpper
    end
    self._powerValue:SetText(powerCurrent)
  end
  self._hp:SetActive(true)
  local mazePet = mazeModule:GetMazePetInfoByPstId(self._petPstID)
  local upper = math.floor(mazeModule:GetCalPetMaxHp(self._petPstID))
  local hp = math.floor(mazePet.blood * upper + 0.5)
  local die = mazePet.is_dead
  self._diaSp1 = self._uiHeartItemAtlas:GetSprite("map_biandui_xuetiao5")
  self._diaSp2 = self._uiHeartItemAtlas:GetSprite("map_biandui_xuetiao4")
  local hpvaluewidth = self._hpvalueRect.sizeDelta.x
  local dialLineCount = math.ceil(upper / self._dialLine2Hp) - 1
  self._dialLines:SpawnObjects("UIHeartMazeHpDialLineItem", dialLineCount)
  local dialLines = self._dialLines:GetAllSpawnList()
  for i = 1, #dialLines do
    local posx = hpvaluewidth / upper * self._dialLine2Hp * i
    local middleImg = i % self._bigDiaLine == 0
    local show = hp > i * self._dialLine2Hp
    local sp
    if middleImg then
      sp = self._diaSp1
    else
      sp = self._diaSp2
    end
    dialLines[i]:SetData(i, posx, sp, show)
  end
  if die then
    self._hpbg.sprite = self._uiHeartItemAtlas:GetSprite("map_biandui_xuetiao1")
    self._hpvalue.fillAmount = 0
  else
    self._hpbg.sprite = self._uiHeartItemAtlas:GetSprite("map_biandui_xuetiao2")
    self._hpvalue.fillAmount = hp / upper
  end
  self._grayMask:SetActive(die)
end

function UISeasonMazeBanPetHeartItem:GetSeasonMazePower()
  local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  local uiSeasonMazeModule = seasonMazeModule:UIModule()
  self._power:SetActive(true)
  local powerCurrent, powerUpper = uiSeasonMazeModule:GetPetPower(self._petPstID, self._heartItemInfo)
  if powerCurrent < 0 then
    powerCurrent = powerUpper
  end
  self._powerValue:SetText(powerCurrent)
  self._hp:SetActive(true)
  local curHp, maxHp = uiSeasonMazeModule:GetPetHP(self._petPstID, self._heartItemInfo)
  local die = false
  if curHp <= 0 then
    die = true
  end
  if maxHp == nil then
    return
  end
  local upper = math.floor(maxHp)
  local hp = math.floor(curHp * upper + 0.5)
  self._diaSp3 = self._newTeamAtlas:GetSprite("cn14_sjmj_zdf_di017")
  self._diaSp4 = self._newTeamAtlas:GetSprite("cn14_sjmj_zdf_di016")
  local hpvaluewidth = self._hpvalueRect.sizeDelta.x
  local dialLineCount = math.ceil(upper / self._dialLine2Hp) - 1
  if dialLineCount > self._lineRoot.childCount then
    local gaps = dialLineCount - self._lineRoot.childCount
    local oriGo = self._lineRoot:GetChild(0).gameObject
    for i = 1, gaps do
      local ins = UnityEngine.GameObject.Instantiate(oriGo, self._lineRoot)
    end
  end
  for i = 1, self._lineRoot.childCount do
    local go = self._lineRoot:GetChild(i - 1).gameObject
    local show = curHp > i * self._dialLine2Hp
    go:SetActive(show)
    if show then
      local middleImg = i % self._bigDiaLine == 0
      local sp
      if middleImg then
        sp = self._diaSp3
      else
        sp = self._diaSp4
      end
      go.transform:GetChild(0).gameObject:GetComponent("Image").sprite = sp
      local posx = hpvaluewidth / upper * self._dialLine2Hp * i
      go.transform:GetChild(0).gameObject:GetComponent("RectTransform").anchoredPosition = Vector2(posx, -2)
    end
  end
  if die then
    self._hpvalue.fillAmount = 0
  else
    self._hpvalue.fillAmount = curHp / maxHp
  end
  self._grayMask:SetActive(die)
end

function UISeasonMazeBanPetHeartItem:ShowLogo()
  self._logo:LoadImage(self._heartItemInfo:GetPetLogo())
end

function UISeasonMazeBanPetHeartItem:ShowAwakenAndGradeIcon()
  local petStar = self._heartItemInfo:GetPetStar()
  local awakenStep = self._heartItemInfo:GetPetAwakening()
  local awakenLock = self._heartItemInfo:GetAwakeMatch()
  self._starSp1 = self._uiHeartItemAtlas:GetSprite("spirit_xing3_frame")
  self._starSp2 = self._uiHeartItemAtlas:GetSprite("spirit_xing2_frame")
  self._starSp3 = self._uiHeartItemAtlas:GetSprite("spirit_xiangqing_icon28")
  local awakenStartIndex = petStar - awakenStep
  local awakenLockIndex = petStar - awakenLock
  self:SetStar(awakenStartIndex, awakenLockIndex, petStar)
  local petId = self._heartItemInfo:GetTemplateID()
  local petGradeLevel = self._heartItemInfo:GetPetGrade()
  self._gradeIcon.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, petGradeLevel))
end

function UISeasonMazeBanPetHeartItem:SetStar(awakenStartIndex, awakenLockIndex, max)
  for i = 1, 6 do
    local star = self._stars.transform:GetChild(i - 1).gameObject
    if max < i then
      star:SetActive(false)
    else
      star:SetActive(true)
      local sp
      if awakenStartIndex < i then
        if i <= awakenLockIndex then
          sp = self._starSp3
        else
          sp = self._starSp1
        end
      else
        sp = self._starSp2
      end
      star:GetComponent("Image").sprite = sp
    end
  end
end

function UISeasonMazeBanPetHeartItem:CheckEliminate()
  local missionModule = self:GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  local teams = ctx:Teams()
  local teamOpenerType = ctx.teamOpenerType
  if teamOpenerType == TeamOpenerType.PopStarPro then
    local param = ctx.param
    local missionID = param[1]
    local cfg = Cfg.cfg_component_line_popstar_mission({MissionID = missionID})[1]
    local team = teams:Get(ctx.popStarTeamId):Clone()
    local isEliminate, eliminateID = EliminateHelper.CheckFetter(cfg.Fetters, team.pets, self._petPstID)
    local curSlot = ctx.curSlot
    local replacePsdID = team.pets[curSlot]
    local petModule = GameGlobal.GetModule(PetModule)
    if curSlot == -1 then
      self._eliminateAreaObj:SetActive(false)
      return
    end
    if replacePsdID ~= 0 and petModule:GetPet(replacePsdID):GetTemplateID() == eliminateID then
      isEliminate = false
    end
    if isEliminate then
      local eliminatePetCfg = Cfg.cfg_pet[eliminateID]
      local eliminatePetName = StringTable.Get(eliminatePetCfg.Name)
      self._eliminateAreaObj:SetActive(true)
      self._eliminateTxt:SetText(StringTable.Get("str_eliminate_fetter_with", eliminatePetName))
      self._eliminateRollingText:RefreshText(StringTable.Get("str_eliminate_fetter_with", eliminatePetName))
    else
      self._eliminateAreaObj:SetActive(false)
    end
  elseif teamOpenerType == TeamOpenerType.AniPopStar then
    local param = ctx.param
    local curSeasonID = param[4]
    local seasonCfg = Cfg.cfg_anipop_season[curSeasonID]
    local fetterID = seasonCfg.FettersId
    local team = teams:Get(ctx.aniPopStarTeamId):Clone()
    local isEliminate, eliminateID = EliminateHelper.CheckFetter(fetterID, team.pets, self._petPstID)
    local anipopModule = GameGlobal.GetModule(AnipopModule)
    local curSlot = ctx.curSlot
    local replacePsdID = team.pets[curSlot]
    local petModule = GameGlobal.GetModule(PetModule)
    if curSlot == -1 then
      self._eliminateAreaObj:SetActive(false)
      return
    end
    if replacePsdID ~= 0 and petModule:GetPet(replacePsdID):GetTemplateID() == eliminateID then
      isEliminate = false
    end
    if isEliminate then
      local eliminatePetCfg = Cfg.cfg_pet[eliminateID]
      local eliminatePetName = StringTable.Get(eliminatePetCfg.Name)
      self._eliminateAreaObj:SetActive(true)
      self._eliminateTxt:SetText(StringTable.Get("str_eliminate_fetter_with", eliminatePetName))
      self._eliminateRollingText:RefreshText(StringTable.Get("str_eliminate_fetter_with", eliminatePetName))
    else
      self._eliminateAreaObj:SetActive(false)
    end
    self._eliminateMark:SetActive(EliminateHelper.CheckExistFetter(fetterID, self._petPstID))
    local powerCurrent, powerUpper = anipopModule:GetPetPower(self._petPstID)
    if powerCurrent < 0 then
      powerCurrent = powerUpper
    end
    self._powerValue:SetText(powerCurrent)
    local petMd = GameGlobal:GetInstance().GetModule(PetModule)
    local pet = petMd:GetPet(self._petPstID)
    local activeSkillID = pet:GetPetActiveSkill()
    local cfg = BattleSkillCfg(activeSkillID)
    self._power:SetActive(cfg.TriggerType ~= SkillTriggerType.LegendEnergy)
  else
    self._eliminateAreaObj:SetActive(false)
  end
end

function UISeasonMazeBanPetHeartItem:CancelNew()
  local petInfo = self._petModule:GetPet(self._petPstID)
  if self._petModule:BeNewPet(petInfo:GetTemplateID()) then
    self:Lock("UIHeartCancelNew")
    self:StartTask(function(TT)
      local res = self._petModule:DelNewPetMark(TT, petInfo:GetTemplateID())
      self:UnLock("UIHeartCancelNew")
      if res:GetSucc() then
      else
        Log.fatal("###petModule:DelNewPetMark - msg : ", res:GetResult())
      end
    end, self)
  end
end

function UISeasonMazeBanPetHeartItem:ShowRedPoint(isShow)
  self._redPoint:SetActive(isShow)
end

function UISeasonMazeBanPetHeartItem:GetPetTid()
  return self._heartItemInfo:GetTemplateID()
end
