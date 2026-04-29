_class("UIBreakController", UIController)
UIBreakController = UIBreakController

function UIBreakController:Construtor()
end

function UIBreakController:OnShow(uiParams)
  self._petModule = GameGlobal.GameLogic():GetModule(PetModule)
  self._roleModule = GameGlobal.GameLogic():GetModule(RoleModule)
  self._petInfos = self._petModule.uiModule:GetSortedPets()
  local petid = uiParams[1]
  self:RequestAllPetInfos()
  self._currIndex = self:FindOpenPetIndex(petid)
  self._currIndexTemp = self._currIndex
  self._petInfo = self._petInfos[self._currIndex]
  self._petPstID = self._petInfo:GetPstID()
  self.uiData = UIBreakUIData:New(self._petInfo)
  Log.debug("###[Break] 进入突破界面：PetID:--->", self._petInfo:GetTemplateID())
  local topButton = self:GetUIComponent("UISelectObjectPath", "TopButtons")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayInOutAnimation, true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CheckCardAwakeRedPoint)
    self:CloseDialog()
  end, function()
    self:ShowDialog("UIHelpController", "UIBreakController")
  end)
  self:InitWidgets()
  self:AttachEvent(GameEventType.PetAwakenEvent, self.RefreshAfterAwaked)
  self:AttachEvent(GameEventType.OnAwakenSelectPointChange, self.OnAwakenSelectPointChange)
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
  self:OnShowInfos()
  self:InitPetScrollView()
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundSelectAwakePoint)
end

function UIBreakController:OnAwakenSelectPointChange(idx, selectIdx)
  if GameGlobal.UIStateManager().uiControllerManager:IsTopUI(self:GetName()) then
    self.selectPointIdx = selectIdx
    self:SetMaterial()
    self:SetButtonState()
  end
end

function UIBreakController:OnShowInfos()
  self._leftLua:OnShowItem()
  if self._petInfos[self._currIndex - 1] then
    self._leftLua:SetData(self._currIndex - 1, self._petInfos[self._currIndex - 1])
  end
  self._rightLua:OnShowItem()
  if self._petInfos[self._currIndex + 1] then
    self._rightLua:SetData(self._currIndex + 1, self._petInfos[self._currIndex + 1])
  end
  self._centerLua:OnShowItem()
  if self._petInfos[self._currIndex] then
    self._centerLua:SetData(self._currIndex, self._petInfos[self._currIndex])
    local petId = self._petInfos[self._currIndex]:GetTemplateID()
    local petModule = GameGlobal.GetModule(PetModule)
    local pet = petModule:GetPetByTemplateId(petId)
    local isShow
    if pet then
      isShow = pet:IsShowRedPoint()
    end
    if isShow then
      pet:CancelRedPoint()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.CheckCardAwakeRedPoint)
    end
  end
end

function UIBreakController:OnHide()
  self:DetachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
  if self._leftLua then
    self._leftLua:Dispose()
  end
  if self._rightLua then
    self._rightLua:Dispose()
  end
  if self._centerLua then
    self._centerLua:Dispose()
  end
  if self._scrollViewHelper then
    self._scrollViewHelper:Dispose()
  end
  self.uiData:Dispose()
end

function UIBreakController:InitWidgets()
  self._leftView = self:GetUIComponent("UIView", "rectLeft")
  self._centerView = self:GetUIComponent("UIView", "rectCenter")
  self._rightView = self:GetUIComponent("UIView", "rectRight")
  self._leftLua = UIBreakInfoItem:New()
  self._centerLua = UIBreakInfoItem:New()
  self._rightLua = UIBreakInfoItem:New()
  self._leftLua:SetView(self._leftView)
  self._centerLua:SetView(self._centerView)
  self._rightLua:SetView(self._rightView)
  self.promotionDes = self:GetUIComponent("UILocalizedTMP", "promotionDes")
  
  function self.promotionDes.onHrefClick(hrefName)
    GameGlobal.UIStateManager():ShowDialog("UISkillHrefInfo", hrefName)
  end
  
  self.matLoader = self:GetUIComponent("UISelectObjectPath", "MatContent")
  self.jumpButton = self:GetGameObject("ButtonJump")
  self.buttonBreakBack = self:GetGameObject("ButtonBreakBack")
  self.buttonActiveBack = self:GetGameObject("ButtonActiveBreak")
  self.breaked = self:GetGameObject("breaked")
  self.cantReach = self:GetGameObject("cantReach")
  self._left = self:GetUIComponent("Transform", "left")
  self._right = self:GetUIComponent("Transform", "right")
  self._center = self:GetUIComponent("Transform", "center")
  self._OnlyAlpha = self:GetUIComponent("CanvasGroup", "OnlyAlpha")
  self._rectLeft = self:GetUIComponent("RectTransform", "rectLeft")
  self._rectLeft.anchoredPosition = Vector2(-200, 0)
  self._rectCenter = self:GetUIComponent("RectTransform", "rectCenter")
  self._rectCenter.anchoredPosition = Vector2(0, 0)
  self._rectRight = self:GetUIComponent("RectTransform", "rectRight")
  self._rectRight.anchoredPosition = Vector2(200, 0)
  self._alphaLeft = self:GetUIComponent("CanvasGroup", "rectLeft")
  self._alphaLeft.alpha = 0
  self._alphaLeft.blocksRaycasts = false
  self._alphaCenter = self:GetUIComponent("CanvasGroup", "rectCenter")
  self._alphaCenter.alpha = 1
  self._alphaCenter.blocksRaycasts = true
  self._alphaRight = self:GetUIComponent("CanvasGroup", "rectRight")
  self._alphaRight.alpha = 0
  self._alphaRight.blocksRaycasts = false
  self._petContentLayout = self:GetUIComponent("GridLayoutGroup", "PetContent")
  self._content = self:GetUIComponent("RectTransform", "PetContent")
  self._conditionText = self:GetUIComponent("UILocalizationText", "conditionText")
end

function UIBreakController:RequestAllPetInfos()
  self._listShowItemCount = table.count(self._petInfos)
end

function UIBreakController:FindOpenPetIndex(petid)
  if self._petInfos then
    for index = 1, #self._petInfos do
      if self._petInfos[index]:GetTemplateID() == petid then
        return index
      end
    end
  end
  return 1
end

function UIBreakController:InitPetScrollView()
  self._itemTable = {}
  self._scrollViewHelper = H3DScrollViewHelper:New(self, "PetScrollView", "UIBreakPetDetailItem", function(index, uiwidget)
    return self:_OnShowItem(index, uiwidget)
  end, function(index, uiwidget)
    return self:_OnHideItem(index, uiwidget)
  end)
  self._scrollViewHelper:SetGroupChangedCallback(function(index, item)
    if index + 1 > self._listShowItemCount then
      return
    end
    self:_ShowCurrIndexInfo(index + 1)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetListIndexChanged, self._petInfo:GetTemplateID())
  end)
  self._scrollViewHelper:SetValueChangedCallback(function(group, value, contentSize, itemSize)
    self:_OnValueChangedCallBack(group + 1, value, contentSize, itemSize)
  end)
  self._scrollRectWidth = self:GetUIComponent("RectTransform", "PetScrollView").sizeDelta.x
  local safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self._scrollViewHelper:Init(self._listShowItemCount, self._currIndex, safeArea.rect.size)
  self._scrollViewHelper:SetNextPageOffset(0.12)
end

function UIBreakController:_OnShowItem(index, uiwidget)
  if self._itemTable[index] == nil then
    self._itemTable[index] = uiwidget
  end
  local petData = self._petInfos[index]
  local matCgName = petData:GetPetStaticBody(PetSkinEffectPath.BODY_AWAKE)
  uiwidget:SetData(index, petData, self._currIndex)
end

function UIBreakController:_OnHideItem(index, uiwidget)
  if self._itemTable[index] == nil then
    return
  end
  uiwidget:OnHideCallBack()
end

function UIBreakController:_ShowCurrIndexInfo(index)
  local isCurrent = false
  if self._currIndex == index then
    isCurrent = true
  end
  self._currIndex = index
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BreakCheckIsCurrent, self._currIndex)
  self._petInfo = self._petInfos[index]
  self._petPstID = self._petInfo:GetPstID()
  self:ChangeLeftCenterRight()
  if not isCurrent then
    self:RefreshBreakInfo(false, false)
  end
  self:SetMaterial()
  self:SetButtonState()
  local imageLoader = self:GetUIComponent("RawImageLoader", "BgLoader")
  UICommonHelper:GetInstance():ChangePetTagBackground(self._petInfo:GetTemplateID(), imageLoader, true)
  self._currIndexTemp = self._currIndex
end

function UIBreakController:_OnValueChangedCallBack(group, value, contentSize, itemSize)
  local di = contentSize - itemSize
  if di <= 0 then
    return
  end
  local rate = itemSize / (contentSize - itemSize)
  if rate <= 0 then
    return
  end
  local centerRate = group * rate - 0.5 * rate
  local distance = value - centerRate
  local a = math.abs(distance) / (rate * 0.5) + 0.05
  a = 1.0 - a
  if a < 0 then
    a = 0
  elseif 1 < a then
    a = 1
  end
  self._OnlyAlpha.alpha = a
  local leftRightDis = math.abs(self._left.position.x - self._right.position.x)
  local centerPosition = self._center.position
  for i = self._currIndex - 1, self._currIndex + 1 do
    if self._itemTable[i] then
      self._itemTable[i]:ChangeCanvasGroupAlpha(leftRightDis, centerPosition.x)
    end
  end
  if 0 < self._content.localPosition.x or self._content.localPosition.x < -self._content.sizeDelta.x + self._scrollRectWidth then
    return
  end
  local c2c = self._itemTable[self._currIndex]:GetC2C()
  local nameRate = c2c / leftRightDis
  local posx = nameRate * 200
  self._rectCenter.anchoredPosition = Vector2(posx, 0)
  self._rectLeft.anchoredPosition = Vector2(posx - 200, 0)
  self._rectRight.anchoredPosition = Vector2(posx + 200, 0)
  self._alphaCenter.alpha = 1 - nameRate * 2
  if c2c < 0 then
    self._alphaLeft.alpha = 0
    self._alphaRight.alpha = nameRate * 2
  elseif 0 < c2c then
    self._alphaLeft.alpha = nameRate * 2
    self._alphaRight.alpha = 0
  else
    self._alphaLeft.alpha = 0
    self._alphaRight.alpha = 0
  end
end

function UIBreakController:ChangeLeftCenterRight()
  if self._currIndexTemp > self._currIndex then
    self._rectRight.anchoredPosition = self._rectRight.anchoredPosition - Vector2(400, 0)
    local rightLuaTemp = self._rightLua
    self._rightLua = self._centerLua
    self._centerLua = self._leftLua
    self._leftLua = rightLuaTemp
    local rightRectTemp = self._rectRight
    self._rectRight = self._rectCenter
    self._rectCenter = self._rectLeft
    self._rectLeft = rightRectTemp
    local alphaRightTemp = self._alphaRight
    self._alphaRight = self._alphaCenter
    self._alphaCenter = self._alphaLeft
    self._alphaLeft = alphaRightTemp
    if self._petInfos[self._currIndex - 1] then
      self._leftLua:RefreshData(self._currIndex - 1, self._petInfos[self._currIndex - 1], false)
    end
  elseif self._currIndexTemp < self._currIndex then
    self._rectLeft.anchoredPosition = self._rectLeft.anchoredPosition + Vector2(400, 0)
    local leftLuaTemp = self._leftLua
    self._leftLua = self._centerLua
    self._centerLua = self._rightLua
    self._rightLua = leftLuaTemp
    local leftRectTemp = self._rectLeft
    self._rectLeft = self._rectCenter
    self._rectCenter = self._rectRight
    self._rectRight = leftRectTemp
    local alphaLeftTemp = self._alphaLeft
    self._alphaLeft = self._alphaCenter
    self._alphaCenter = self._alphaRight
    self._alphaRight = alphaLeftTemp
    if self._petInfos[self._currIndex + 1] then
      self._rightLua:RefreshData(self._currIndex + 1, self._petInfos[self._currIndex + 1], false)
    end
  end
  self._alphaCenter.blocksRaycasts = true
  self._alphaRight.blocksRaycasts = false
  self._alphaLeft.blocksRaycasts = false
end

function UIBreakController:RefreshBreakInfo(isInit, playAnim, ignoreRefreshSelect)
  if self._petInfos[self._currIndex] then
    self._centerLua:RefreshBreakInfo(isInit, playAnim, ignoreRefreshSelect)
    local petId = self._petInfos[self._currIndex]:GetTemplateID()
    local petModule = GameGlobal.GetModule(PetModule)
    local pet = petModule:GetPetByTemplateId(petId)
    local isShow = pet:IsShowRedPoint()
    if isShow then
      pet:CancelRedPoint()
    end
  end
  self.uiData = UIBreakUIData:New(self._petInfo)
  self.selectPointIdx = self._centerLua:GetSelectPointIdx()
end

function UIBreakController:SetMaterial()
  self.promotionDes:SetText(self.uiData:GetAttributeDes(self.selectPointIdx))
  local mats = self.uiData:GetMats(self.selectPointIdx)
  local single = self.selectPointIdx <= self.uiData:GetCurrent()
  if not mats then
    Log.fatal("selectidx -- > ", self.selectPointIdx)
  end
  self._matCount = #mats
  self.matLoader:SpawnObjects("UIBreakMatItem", #mats)
  self.matItems = self.matLoader:GetAllSpawnList()
  for i, mat in ipairs(mats) do
    local item = self.matItems[i]
    item:SetData(mat.id, mat.count, single, function(_id, _pos)
      self:OnMatClick(_id, _pos)
    end)
  end
end

function UIBreakController:OnItemCountChanged()
  self:SetMaterial()
end

function UIBreakController:SetButtonState()
  self.jumpButton:SetActive(false)
  self.breaked:SetActive(false)
  self.cantReach:SetActive(false)
  self.buttonBreakBack:SetActive(false)
  self.buttonActiveBack:SetActive(false)
  if self.selectPointIdx <= self.uiData:GetCurrent() then
    if self.selectPointIdx < self.uiData:GetAwakeMatch() then
      self.buttonBreakBack:SetActive(true)
    elseif self.selectPointIdx == self.uiData:GetAwakeMatch() then
      self.breaked:SetActive(true)
    else
      self.buttonActiveBack:SetActive(true)
    end
  elseif self.selectPointIdx == self.uiData:GetCurrent() + 1 then
    self.jumpButton:SetActive(true)
  else
    self.cantReach:SetActive(true)
    self._conditionText:SetText(StringTable.Get("str_pet_config_break_cantReach"))
  end
end

function UIBreakController:RefreshAfterAwaked()
  self:RefreshBreakInfo(false, true)
  self:SetMaterial()
  self:SetButtonState()
end

function UIBreakController:RefreshAfterBackOrActiveAwaked()
  self:RefreshBreakInfo(false, true, true)
  self.uiData = UIBreakUIData:New(self._petInfo)
  self:SetButtonState()
end

function UIBreakController:ButtonJumpOnClick(go)
  local cfg = self.uiData:GetCfg(self.uiData:GetCurrent() + 1)
  if self._petInfo:GetPetStar() < cfg.NeedStar then
    local tip = string.format(StringTable.Get("str_pet_config_tip_star_not_enough"), cfg.NeedStar)
    ToastManager.ShowToast(tip)
    return
  end
  if self._petInfo:GetPetGrade() < cfg.NeedGrade then
    local tip = string.format(StringTable.Get("str_pet_config_tip_grade_not_enough"), cfg.NeedGrade)
    ToastManager.ShowToast(tip)
    return
  end
  local canJump = true
  for i = 1, self._matCount do
    local item = self.matItems[i]
    if not item:IsEnough() then
      canJump = false
      item:ShakeAndHighlight()
      break
    end
  end
  if not canJump then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUIMaterialNotEnough)
    return
  end
  self:Lock(self:GetName())
  GameGlobal.TaskManager():StartTask(self.Jump, self, self.uiData:GetCurrent() + 1)
end

function UIBreakController:ButtonBreakBackOnClick(go)
  self:Lock("UIBreakController_ButtonBreakBackOnClick")
  GameGlobal.TaskManager():StartTask(function(TT)
    local req = self._petModule:ReqAwakeLock(TT, self._petInfo:GetPstID(), self.selectPointIdx)
    if req:GetSucc() then
      self:UnLock("UIBreakController_ButtonBreakBackOnClick")
      self:RefreshAfterBackOrActiveAwaked()
    else
      Log.fatal("[Awake] BreakBack failed: " .. req.m_result)
    end
  end)
end

function UIBreakController:ButtonActiveBreakOnClick(go)
  self:Lock("UIBreakController_ButtonActiveBreakOnClick")
  GameGlobal.TaskManager():StartTask(function(TT)
    local req = self._petModule:ReqAwakeLock(TT, self._petInfo:GetPstID(), self.selectPointIdx)
    if req:GetSucc() then
      self:UnLock("UIBreakController_ButtonActiveBreakOnClick")
      self:RefreshAfterBackOrActiveAwaked()
    else
      Log.fatal("[Awake] BreakActive failed: " .. req.m_result)
    end
  end)
end

function UIBreakController:Jump(TT, _id)
  local req = self._petModule:RequestPetAwake(TT, self._petInfo:GetPstID(), _id)
  if req:GetSucc() then
    AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundSelectAwakePoint)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PetAwakenEvent, self._petInfo:GetPstID(), true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CheckCardAwakeRedPoint)
    self:UnLock(self:GetName())
  else
    Log.fatal("[Awake] jump failed: " .. req.m_result)
  end
end

function UIBreakController:OnMatClick(matId, pos)
  self:ShowDialog("UIItemGetPathController", matId)
end

UIBreakPromoteType = {
  Attack = 1,
  Defence = 2,
  HP = 3,
  NormalSkill = 4,
  ActiveSkill = 5,
  PassiveSkill = 6,
  ChainSkill = 7,
  WorkSkill = 8
}
_enum("UIBreakPromoteType", UIBreakPromoteType)
_class("UIBreakUIData", Object)
UIBreakUIData = UIBreakUIData

function UIBreakUIData:Constructor(petData)
  self._petData = petData
  self._id = self._petData:GetTemplateID()
  self._awake = self._petData:GetPetGrade()
  self._current = self._petData:GetPetAwakening()
  self._awakeLock = self._petData:GetAwakeLock()
  self._awakeMatch = self._petData:GetAwakeMatch()
  self.attributeCfg = self._petData:GetAwakeningConfig()
  self.skillCfg = Cfg.cfg_pet_skill({
    PetID = self._id,
    Grade = self._awake
  })
  self.levelCfg = self._petData:GetCurrentLevelConfig()
  self.breakCount = #self.attributeCfg
  self.normalAttack = self._petData:GetNormalSkill()
  self.activeSkill = self._petData:GetPetActiveSkill()
  self.passiveSkill = self._petData:GetPetPassiveSkill()
  self.chainSkills = self._petData:GetPetChainSkills()
  self.workSkills = self._petData:GetPetWorkSkills()
  self.chainSkillCount = 3
  self.workSkillCount = 3
  self.promoteDatas = {}
  self.mats = {}
  self.promoteDes = {}
  for i = 1, self.breakCount do
    local p, m, d = self:GetBreakData(i)
    self.promoteDatas[i] = p
    self.mats[i] = m
    if d then
      self.promoteDes[i] = d
    else
      self.promoteDes[i] = p[1].des
    end
  end
  self.skillTypeName = {
    [UIBreakPromoteType.NormalSkill] = StringTable.Get("str_pet_config_skill_major"),
    [UIBreakPromoteType.ActiveSkill] = StringTable.Get("str_pet_config_skill_major"),
    [UIBreakPromoteType.PassiveSkill] = StringTable.Get("str_pet_config_skill_equip"),
    [UIBreakPromoteType.ChainSkill] = StringTable.Get("str_pet_config_skill_chain"),
    [UIBreakPromoteType.WorkSkill] = StringTable.Get("str_pet_config_common_work_des")
  }
  self.resRequest = ResourceManager:GetInstance():SyncLoadAsset("UIBreak.spriteatlas", LoadType.SpriteAtlas)
  local atlas = self.resRequest.Obj
  self.attributeInfo = {
    [UIBreakPromoteType.Attack] = {
      name = StringTable.Get("str_pet_config_break_att_attack"),
      nameEN = "ATTACK",
      icon = atlas:GetSprite("spirit_tupo_icon1")
    },
    [UIBreakPromoteType.Defence] = {
      name = StringTable.Get("str_pet_config_break_att_defense"),
      nameEN = "DEFENCE",
      icon = atlas:GetSprite("spirit_tupo_icon2")
    },
    [UIBreakPromoteType.HP] = {
      name = StringTable.Get("str_pet_config_break_att_hp"),
      nameEN = "HP",
      icon = atlas:GetSprite("spirit_tupo_icon3")
    }
  }
end

function UIBreakUIData:Dispose()
  self.resRequest:Dispose()
end

function UIBreakUIData:GetBreakData(idx)
  local select = self.attributeCfg[idx]
  local mats = {}
  for i = 1, #select.NeedItem do
    local value = select.NeedItem[i]
    local content = string.split(value, ",")
    local mat = {}
    mat.id = tonumber(content[1])
    mat.count = tonumber(content[2])
    mats[#mats + 1] = mat
  end
  local promoteData = {}
  local promoteDes = ""
  local attack, attackValue, attackPercent = self:_GetPromoteAttack(idx)
  local defence, defenceValue, defencePercent = self:_GetPromoteDefence(idx)
  local hp, hpValue, hpPercent = self:_GetPromoteHP(idx)
  if 0 < attack then
    local from = math.floor(self._petData:GetPetAttack())
    if idx <= self._awakeMatch then
      for i = self._awakeMatch, idx, -1 do
        local delta = self:_GetPromoteAttack(i)
        if 0 < delta then
          from = from - delta
        end
      end
    elseif idx > self._awakeMatch then
      for i = self._awakeMatch + 1, idx - 1 do
        local delta = self:_GetPromoteAttack(i)
        if 0 < delta then
          from = from + delta
        end
      end
    end
    local to = from + attack
    self:_AddAttData(promoteData, UIBreakPromoteType.Attack, attackValue, from, to, attackPercent)
  end
  if 0 < defence then
    local from = math.floor(self._petData:GetPetDefence())
    if idx <= self._awakeMatch then
      for i = self._awakeMatch, idx, -1 do
        local delta = self:_GetPromoteDefence(i)
        if 0 < delta then
          from = from - delta
        end
      end
    elseif idx > self._awakeMatch then
      for i = self._awakeMatch + 1, idx - 1 do
        local delta = self:_GetPromoteDefence(i)
        if 0 < delta then
          from = from + delta
        end
      end
    end
    local to = from + defence
    self:_AddAttData(promoteData, UIBreakPromoteType.Defence, defenceValue, from, to, defencePercent)
  end
  if 0 < hp then
    local from = math.floor(self._petData:GetPetHealth())
    if idx <= self._awakeMatch then
      for i = self._awakeMatch, idx, -1 do
        local delta = self:_GetPromoteHP(i)
        if 0 < delta then
          from = from - delta
        end
      end
    elseif idx > self._awakeMatch then
      for i = self._awakeMatch + 1, idx - 1 do
        local delta = self:_GetPromoteHP(i)
        if 0 < delta then
          from = from + delta
        end
      end
    end
    local to = from + hp
    self:_AddAttData(promoteData, UIBreakPromoteType.HP, hpValue, from, to, hpPercent)
  end
  if 0 < attack or 0 < defence or 0 < hp then
    local des = self:_GetPromoteDes(idx)
    return promoteData, mats, des
  end
  if select.SkillType == SkillType.Normal then
    self:_AddSkillData(promoteData, UIBreakPromoteType.NormalSkill, select)
  elseif select.SkillType == SkillType.Chain then
    self:_AddSkillData(promoteData, UIBreakPromoteType.ChainSkill, select)
  elseif select.SkillType == SkillType.Active then
    self:_AddSkillData(promoteData, UIBreakPromoteType.ActiveSkill, select)
  elseif select.SkillType == SkillType.Passive then
    self:_AddSkillData(promoteData, UIBreakPromoteType.PassiveSkill, select)
  else
    Log.exception("[Break] 突破技能类型错误，星灵ID：", self._id, ", 觉醒等级：", self._awake, ", 突破等级：", idx, "，技能类型：", select.SkillType, "，配置id：", select.ID)
  end
  return promoteData, mats
end

function UIBreakUIData:_AddAttData(array, type, value, from, to, precent)
  array[#array + 1] = {
    type = type,
    value = value,
    precent = precent,
    from = from,
    to = to
  }
end

function UIBreakUIData:_AddSkillData(array, type, cfg)
  array[#array + 1] = {
    type = type,
    name = StringTable.Get(cfg.SkillName),
    icon = cfg.SkillIcon,
    icon_bianse = cfg.SkillGoldIcon,
    des = StringTable.Get(cfg.PromoteDes)
  }
end

function UIBreakUIData:_GetPromoteAttack(level)
  local total, value, percent = 0
  local cfg = self.attributeCfg[level]
  if 1 < level then
    value = cfg.Attack - self.attributeCfg[level - 1].Attack
    percent = cfg.AttackPercent - self.attributeCfg[level - 1].AttackPercent
  else
    value = cfg.Attack
    percent = cfg.AttackPercent
  end
  value = math.floor(value)
  local percentValue = 0
  if 0 < percent then
    percentValue = math.floor(self.levelCfg.Attack * percent / 100)
  end
  total = value + percentValue
  return total, value, percent
end

function UIBreakUIData:_GetPromoteDefence(level)
  local total, value, percent = 0
  local cfg = self.attributeCfg[level]
  if 1 < level then
    value = cfg.Defence - self.attributeCfg[level - 1].Defence
    percent = cfg.DefencePercent - self.attributeCfg[level - 1].DefencePercent
  else
    value = cfg.Defence
    percent = cfg.DefencePercent
  end
  value = math.floor(value)
  local percentValue = 0
  if 0 < percent then
    percentValue = math.floor(self.levelCfg.Defence * percent / 100)
  end
  total = value + percentValue
  return total, value, percent
end

function UIBreakUIData:_GetPromoteHP(level)
  local total, value, percent = 0
  local cfg = self.attributeCfg[level]
  if 1 < level then
    value = cfg.Health - self.attributeCfg[level - 1].Health
    percent = cfg.HealthPercent - self.attributeCfg[level - 1].HealthPercent
  else
    value = cfg.Health
    percent = cfg.HealthPercent
  end
  value = math.floor(value)
  local percentValue = 0
  if 0 < percent then
    percentValue = math.floor(self.levelCfg.Health * percent / 100)
  end
  total = value + percentValue
  return total, value, percent
end

function UIBreakUIData:_GetPromoteDes(idx)
  local attack, attackValue, attackPercent = self:_GetPromoteAttack(idx)
  local defence, defenceValue, defencePercent = self:_GetPromoteDefence(idx)
  local hp, hpValue, hpPercent = self:_GetPromoteHP(idx)
  local temp = {
    {
      value = attackValue,
      percent = attackPercent,
      name = StringTable.Get("str_pet_config_break_att_attack"),
      suffix = StringTable.Get("str_pet_config_break_att_base_attack")
    },
    {
      value = defenceValue,
      percent = defencePercent,
      name = StringTable.Get("str_pet_config_break_att_defense"),
      suffix = StringTable.Get("str_pet_config_break_att_base_defence")
    },
    {
      value = hpValue,
      percent = hpPercent,
      name = StringTable.Get("str_pet_config_break_att_hp"),
      suffix = StringTable.Get("str_pet_config_break_att_base_hp")
    }
  }
  local des = ""
  for _, attribute in ipairs(temp) do
    local text = ""
    local valid = false
    if attribute.value > 0 then
      if attribute.percent > 0 then
        text = StringTable.Get("str_pet_config_break_att_promote_both", attribute.value, attribute.percent, attribute.suffix)
      else
        text = StringTable.Get("str_pet_config_break_att_promote_value", attribute.name, attribute.value)
      end
      valid = true
    elseif attribute.percent > 0 then
      text = StringTable.Get("str_pet_config_break_att_promote_percent", attribute.percent, attribute.suffix)
      valid = true
    end
    if valid then
      des = des .. text .. "\n"
    end
  end
  return des
end

function UIBreakUIData:GetPromoteData(idx)
  return self.promoteDatas[idx]
end

function UIBreakUIData:GetAllPromoteData()
  return self.promoteDatas
end

function UIBreakUIData:GetMats(idx)
  if self.mats[idx] then
    return self.mats[idx]
  else
    return self.mats[#self.mats]
  end
end

function UIBreakUIData:GetAttributeDes(idx)
  return self.promoteDes[idx]
end

function UIBreakUIData:GetBreakCount()
  return self.breakCount
end

function UIBreakUIData:IsFullBreak()
  return self._current >= self.breakCount
end

function UIBreakUIData:GetCurrent()
  return self._current
end

function UIBreakUIData:GetAwakeLock()
  return self._awakeLock
end

function UIBreakUIData:GetAwakeMatch()
  return self._awakeMatch
end

function UIBreakUIData:GetSkillTypeName(type)
  return self.skillTypeName[type]
end

function UIBreakUIData:GetAttributeInfo(type)
  return self.attributeInfo[type]
end

function UIBreakUIData:GetCfg(idx)
  return self.attributeCfg[idx]
end
