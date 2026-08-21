_class("UIRecruitWish", UIController)
UIRecruitWish = UIRecruitWish

function UIRecruitWish:Constructor()
  self._cdEnd = {tick = 0, period = 1000}
end

function UIRecruitWish:LoadDataOnEnter(TT, res, uiParams)
  local param = uiParams[1]
  self._indexPool = param.indexPool
  self._cfgRecruit = Cfg.cfg_recruit_pool_view[param.idRecruit]
  if self._cfgRecruit == nil then
    Log.fatal("[UIRecruitWish] cfg_recruit_pool_view is nil, id ->: ", param.idRecruit)
    res:SetSucc(false)
    return
  end
  self._cfgOptional = Cfg.cfg_optional_pool[param.idOptional]
  if self._cfgOptional == nil then
    Log.fatal("[UIRecruitWish] cfg_optional_pool is nil, id ->: ", param.idOptional)
    res:SetSucc(false)
    return
  end
  Log.info("[UIRecruitWish] indexPool, cfgRecruit.ID, cfgOptional.ID ->: ", self._indexPool, self._cfgRecruit.ID, self._cfgOptional.ID)
  self._wishChanged = false
  self._gambleModule = self:GetModule(GambleModule)
end

function UIRecruitWish:OnShow(uiParams)
  self:UIWidget()
  self:CreatePetUp()
  self:CreatePetWish()
  self:FlushPetUp()
  self:FlushPetWish()
  self:FlushTips()
end

function UIRecruitWish:OnUpdate(deltaTimeMS)
  self._cdEnd.tick = self._cdEnd.tick + deltaTimeMS
  if self._cdEnd.tick >= self._cdEnd.period then
    self._cdEnd.tick = 0
    self:CheckAutoClose()
  end
end

function UIRecruitWish:OnHide()
  if self._wishChanged then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateDrawCardRed)
  end
end

function UIRecruitWish:BtnOKOnClick(go)
  local count = 0
  local selWish = self._gambleModule:GetOptionalPool(self._indexPool)
  for k, v in pairs(selWish) do
    if v ~= 0 then
      count = count + 1
    end
  end
  if count == ElementType.ElementType_Yellow then
    self:CloseDialog()
  else
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_draw_card_wish_not_working_tips"), function(param)
      self:CloseDialog()
    end, nil, function(param)
    end, nil)
  end
end

function UIRecruitWish:UIWidget(go)
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._effectTips = self:GetUIComponent("UILocalizationText", "effectTips")
  self._openTips = self:GetUIComponent("UILocalizationText", "openTips")
  self._unopenTips = self:GetUIComponent("UILocalizationText", "unopenTips")
  self._uiPetUp = self:GetUIComponent("UISelectObjectPath", "uiPetUp")
  self._uiPetWish = self:GetUIComponent("UISelectObjectPath", "uiPetWish")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIRecruitWish:CreatePetUp()
  local uiWidgets = self._uiPetUp:SpawnObjects("UIDrawCardAwardPetItem", 1)
  local sixup = self._cfgRecruit.sixup
  self._petUp = {
    petTid = sixup[1][1],
    uiWidget = uiWidgets[1]
  }
end

function UIRecruitWish:CreatePetWish()
  self._petWish = {}
  local selWish = self._gambleModule:GetOptionalPool(self._indexPool)
  local count = ElementType.ElementType_Yellow
  local uiList = self._uiPetWish:SpawnObjects("UIRecruitWishItem", count)
  for i = 1, count do
    local petTid = selWish[i]
    if petTid == nil then
      petTid = 0
    end
    local wish = {
      petTid = petTid,
      uiWidget = uiList[i]
    }
    table.insert(self._petWish, wish)
    wish.uiWidget:SetData(i, wish.petTid, function(elementType, petTid)
      self:OnSelectPet(elementType, petTid)
    end)
  end
end

function UIRecruitWish:FlushPetUp()
  self._petUp.uiWidget:SetData(6, self._petUp.petTid, nil)
  self._petUp.uiWidget:ShowPetAwakening(true)
  self._petUp.uiWidget:RootLocalScale(Vector3(1.0, 1.0, 1.0))
  self._petUp.uiWidget:AnimRootPosition(Vector2(0, -126))
end

function UIRecruitWish:FlushPetWish()
  for k, v in pairs(self._petWish) do
    v.uiWidget:SetPetTid(v.petTid)
  end
end

function UIRecruitWish:FlushTips()
  local poolTitle = StringTable.Get(self._cfgRecruit.PoolTitle)
  self._title:SetText(StringTable.Get("str_draw_card_wish_title", poolTitle))
  self._effectTips:SetText(StringTable.Get("str_draw_card_wish_wish_effect", poolTitle))
  local wishCount = 0
  for k, v in pairs(self._petWish) do
    if v.petTid ~= 0 then
      wishCount = wishCount + 1
    end
  end
  self._openTips.gameObject:SetActive(wishCount == ElementType.ElementType_Yellow)
  self._unopenTips.gameObject:SetActive(wishCount ~= ElementType.ElementType_Yellow)
end

function UIRecruitWish:CheckAutoClose()
  local awardPools = self._gambleModule:GetPrizePools()
  local poolData = awardPools[self._indexPool]
  local now = GetSvrTimeNow()
  local time = 0
  local closeType2 = poolData.close_condition2
  if closeType2 and 0 < closeType2 then
    time = closeType2
  else
    time = poolData.extend_data
  end
  if now >= time then
    local stateMgr = GameGlobal.UIStateManager()
    local uiName = "UIRecruitWishSelection"
    if stateMgr:IsShow(uiName) then
      stateMgr:CloseDialog(uiName)
    end
    local uiName = "UIRecruitWish"
    if stateMgr:IsShow(uiName) then
      stateMgr:CloseDialog(uiName)
    end
  end
end

function UIRecruitWish:OnSelectPet(elementType, selPetTid)
  local param = {
    idOptional = self._cfgOptional.ID,
    elementType = elementType,
    selPetTid = selPetTid
  }
  self:ShowDialog("UIRecruitWishSelection", param, function(newPetTid)
    self:OnReplacePet(elementType, newPetTid)
  end)
end

function UIRecruitWish:OnReplacePet(elementType, newPetTid)
  self:StartSafeTask("UIRecruitWishSelection::FlushDefaultSelection", function(lockName, TT)
    local retCode = self._gambleModule:HandleOptionalPoolReq(TT, self._indexPool, elementType, {newPetTid})
    if retCode == GAMBLE_CODE.GAMBLE_SUCCESS then
      local theWish = self._petWish[elementType]
      theWish.petTid = newPetTid
      theWish.uiWidget:SetPetTid(newPetTid)
      self:FlushTips()
      self._wishChanged = true
    else
      Log.fatal("[UIRecruitWish] HandleOptionalPoolReq ret ->: ", retCode)
    end
  end)
end
