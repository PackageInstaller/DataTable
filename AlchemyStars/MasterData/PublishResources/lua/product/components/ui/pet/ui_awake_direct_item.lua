_class("UIAwakeDirectItem", UICustomWidget)
UIAwakeDirectItem = UIAwakeDirectItem

function UIAwakeDirectItem:Constructor()
  self._heartItemInfo = nil
  self._callBack = nil
  self._petModule = GameGlobal.GameLogic():GetModule(PetModule)
  self._uiHeartItemAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UIAwakeDirectItem:OnShow()
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
  self._atlasAwake = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
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
  self._stars = self:GetUIComponent("UISelectObjectPath", "stars")
  self._hp = self:GetGameObject("hp")
  self._hpvalue = self:GetUIComponent("Image", "hpvalue")
  self._hpvalueRect = self:GetUIComponent("RectTransform", "dialLines")
  self._hpbg = self:GetUIComponent("Image", "hpbg")
  self._dialLines = self:GetUIComponent("UISelectObjectPath", "dialLines")
  self._grayMask = self:GetGameObject("grayMask")
  self:AttachEvent(GameEventType.CheckCardNew, self.CheckCardNew)
  self:AttachEvent(GameEventType.OnSelectUIHeartItem, self.OnSelectChanged)
  self:AttachEvent(GameEventType.PetDataChangeEvent, self.PetDataChangeEvent)
end

function UIAwakeDirectItem:PetDataChangeEvent(pstid_list)
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

function UIAwakeDirectItem:OnHide()
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
end

function UIAwakeDirectItem:SetData(pet, callBack, showNew, fristIn, teamType, skinEffectPath, select)
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
  self._fromMaze = teamType and teamType == TeamOpenerType.Maze
  self._skinEffectPath = skinEffectPath
  self:ShowInfo()
  self:CheckCardNew()
  self._interactTarget.raycastTarget = self._callBack ~= nil
  self:Select(select == true)
end

function UIAwakeDirectItem:ShowInfo()
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
  self:GetMazePower(self._fromMaze)
  self._logo:LoadImage(self._heartItemInfo:GetPetLogo())
  local petStar = self._heartItemInfo:GetPetStar()
  self._qualityIcon.sprite = self._uiHeartItemAtlas:GetSprite("map_biandui_pin" .. petStar)
  self:ShowAwakenAndGradeIcon()
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if cfg_pet_element then
    self._firstAttIcon.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[self._heartItemInfo:GetPetFirstElement()].Icon))
    if self._heartItemInfo:GetPetSecondElement() and self._heartItemInfo:GetPetSecondElement() > 0 then
      self._secondGo:SetActive(true)
      self._secondAttribute.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[self._heartItemInfo:GetPetSecondElement()].Icon))
    else
      self._secondGo:SetActive(false)
    end
  end
end

function UIAwakeDirectItem:CheckCardNew()
  if self._showNew then
    self._new:SetActive(self._petModule:BeNewPet(self._heartItemInfo:GetTemplateID()))
  end
end

function UIAwakeDirectItem:GetMazePower(fromMaze)
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

function UIAwakeDirectItem:ShowLogo()
  self._logo:LoadImage(self._heartItemInfo:GetPetLogo())
end

function UIAwakeDirectItem:ShowAwakenAndGradeIcon()
  local petStar = self._heartItemInfo:GetPetStar()
  local awakenStep = self._heartItemInfo:GetPetAwakening()
  self._starSp1 = self._uiHeartItemAtlas:GetSprite("spirit_xing3_frame")
  self._starSp2 = self._uiHeartItemAtlas:GetSprite("spirit_xing2_frame")
  self._stars:SpawnObjects("UIHeartItemStar", petStar)
  local stars = self._stars:GetAllSpawnList()
  local awakenStartIndex = petStar - awakenStep
  for i = 1, #stars do
    local sp
    if i > awakenStartIndex then
      sp = self._starSp1
    else
      sp = self._starSp2
    end
    stars[i]:SetData(sp)
  end
  local petId = self._heartItemInfo:GetTemplateID()
  local petGradeLevel = self._heartItemInfo:GetPetGrade()
  self._gradeIcon.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, petGradeLevel))
end

function UIAwakeDirectItem:openDetailOnClick(go)
  if self._showNew then
    self:CancelNew()
  end
  if self._callBack then
    self._callBack(self._petPstID)
  end
end

function UIAwakeDirectItem:CancelNew()
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

function UIAwakeDirectItem:OnSelectChanged(pstID)
  self:Select(self._heartItemInfo:GetPstID() == pstID)
end

function UIAwakeDirectItem:Select(_select)
  self._select:SetActive(_select)
end
