_class("UIHPBuffInfo", UICustomWidget)
UIHPBuffInfo = UIHPBuffInfo

function UIHPBuffInfo:Constructor()
  self._entityId = nil
  self._isBigHPSlider = false
  self._show_buff_interval_time = 2
  self._show_buff_fade_time = 0.2
  self._show_buff_move_time = 0.5
  self._show_buff_move_distance = 38
  self._show_buff_delta_time = 0
  self._onPlay = false
  self._buffViewInstanceList = {}
  self._curPage = 1
  self._pageMax = 1
  self._pageBuffCount = 4
  self.curPageEndIndex = self._pageBuffCount
  self.curPageStartIndex = 1
  self.backPreviousPage = false
  self.removeIndex = 1
  self._buffAnimationList = {}
  self._buffPlayingList = {}
  self._shieldLayer = 0
  self._onShow = true
end

function UIHPBuffInfo:Dispose()
  self._onShow = false
  if self.__playRefreshPageTask then
    TaskManager:GetInstance():KillTask(self.__playRefreshPageTask)
    self.__playRefreshPageTask = nil
  end
end

function UIHPBuffInfo:OnShow()
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  if not self._isBoss then
    self._pageBuffCount = (self._rectTransform.rect.width + BattleConst.HUDHPSliderBuffIconFullWidthOffset) // BattleConst.HUDHPSliderBuffIconWidth
  end
  self:_OnCreateBuffItemList()
  self._shieldRoot = self:GetGameObject("ShieldRoot")
  if self._shieldRoot then
    self._shieldRootPath = self:GetUIComponent("UISelectObjectPath", "ShieldRoot")
  end
  self._brokenRoot = self:GetGameObject("BrokenRoot")
  if self._brokenRoot then
    self._brokenRootPath = self:GetUIComponent("UISelectObjectPath", "BrokenRoot")
    self._brokenRoot:SetActive(false)
  end
  self._bombRoot = self:GetGameObject("BombRoot")
  if self._bombRoot then
    self._bombTransform = self._bombRoot:GetComponent("RectTransform")
    self._textBomb = self:GetUIComponent("UILocalizationText", "TextBomb")
  end
  self._antiRoot = self:GetGameObject("AntiRoot")
  if self._antiRoot then
    self._antiTransform = self._antiRoot:GetComponent("RectTransform")
    self._textAnti = self:GetUIComponent("UILocalizationText", "TextAnti")
  end
  local parent = self._rectTransform.transform.parent.parent
  local chessHP = parent.transform:Find("chessHP")
  if chessHP then
    self._chessHPTransform = chessHP
    self._chessHPRoot = chessHP.gameObject
  end
  self._blinkRoot = self:GetGameObject("BlinkRoot")
  if self._blinkRoot then
    self._blinkRootPath = self:GetUIComponent("UISelectObjectPath", "BlinkRoot")
    self._blinkRoot:SetActive(false)
  end
  self:AttachEvent(GameEventType.ChangeBuff, self.OnChangeBuff)
  self:AttachEvent(GameEventType.HPSliderBroken, self.OnHPSliderBroken)
  self:AttachEvent(GameEventType.HPBombLayer, self.OnRefreshHPBombLayer)
  self:AttachEvent(GameEventType.UpdateAntiActiveSkill, self.UpdateAntiActiveSkill)
  self:AttachEvent(GameEventType.HPSliderBlink, self.OnHPSliderBlink)
end

function UIHPBuffInfo:_OnCreateBuffItemList()
  self._buffRootPath = self:GetUIComponent("UISelectObjectPath", "BuffRoot")
  self._buffRootPath:SpawnObjects("UIHPBuffItem", self._pageBuffCount)
  self._buffItemList = self._buffRootPath:GetAllSpawnList()
  self._buffAnimationRootPath = self:GetUIComponent("UISelectObjectPath", "BuffAnimationRoot")
  self._buffAnimationRootPath:SpawnObjects("UIHPBuffItem", self._pageBuffCount)
  self._buffAnimationList = self._buffAnimationRootPath:GetAllSpawnList()
  if self._isBigHPSlider then
  end
end

function UIHPBuffInfo:OnHide()
  self:DetachEvent(GameEventType.ChangeBuff, self.OnChangeBuff)
  self:DetachEvent(GameEventType.HPSliderBroken, self.OnHPSliderBroken)
  self:DetachEvent(GameEventType.HPBombLayer, self.OnRefreshHPBombLayer)
  self:DetachEvent(GameEventType.UpdateAntiActiveSkill, self.UpdateAntiActiveSkill)
  self:DetachEvent(GameEventType.HPSliderBlink, self.OnHPSliderBlink)
end

function UIHPBuffInfo:OnOnwerEntityDead()
  self._entityId = nil
  self._buffViewInstanceList = {}
  self:_OnPlayCurPage()
end

function UIHPBuffInfo:SetData(entityId)
  self._buffViewInstanceList = {}
  self._entityId = entityId
end

function UIHPBuffInfo:SetBossData(entityId)
  self._entityId = entityId
  self._isBigHPSlider = true
  self._show_buff_interval_time = 9999999
  self._isBoss = true
  self._pageBuffCount = 16
  self._buffViewInstanceList = {}
  self:_OnPlayCurPage()
  self:_OnCreateBuffItemList()
  self:OnChangeBuff()
end

function UIHPBuffInfo:OnChangeBuff()
  if not self._entityId then
    return
  end
  local viewInstanceArray = InnerGameHelperRender.GetUIBuffViewArray(self._entityId, true)
  local viewInstanceIDArray = {}
  for i, buffView in ipairs(viewInstanceArray) do
    table.insert(viewInstanceIDArray, buffView:BuffID())
  end
  local addBuffViewList = {}
  local removeBuffViewList = {}
  for i, buffView in ipairs(self._buffViewInstanceList) do
    if not table.intable(viewInstanceIDArray, buffView:BuffID()) then
      table.insert(removeBuffViewList, buffView)
    end
  end
  for i, buffView in ipairs(viewInstanceArray) do
    if not table.intable(removeBuffViewList, buffView) then
      table.insert(addBuffViewList, buffView)
    end
  end
  for i, buffView in ipairs(addBuffViewList) do
    self:_OnRefreshBuff(true, buffView)
  end
  for i, buffView in ipairs(removeBuffViewList) do
    self:_OnRefreshBuff(false, buffView)
  end
  if self._layerShieldViewInstance and not table.intable(viewInstanceArray, self._layerShieldViewInstance) then
    self:_ShowShieldBuff(true)
  end
  local t = {}
  for _, v in ipairs(viewInstanceArray) do
    t[v:BuffID()] = v:GetLayerCount() or 0
  end
  InnerGameHelperRender.UISetHPBuffIcon(self._entityId, t)
end

function UIHPBuffInfo:_OnRefreshBuff(isAdd, buffViewInstance)
  if self:_OnSpecialBuffShow(buffViewInstance, not isAdd) then
    return
  end
  self:_OnUpdateBuffData(isAdd, buffViewInstance)
  self:_OnPlayBuff(isAdd)
end

function UIHPBuffInfo:_OnSpecialBuffShow(buffViewInstance, remove)
  if buffViewInstance:GetBuffEffectType() == BuffEffectType.LayerShield then
    self:_ShowShieldBuff(remove)
    return true
  end
  return false
end

function UIHPBuffInfo:_OnUpdateBuffData(isAdd, buffViewInstance)
  self.removeIndex = 1
  local oldBuffView
  for i = 1, #self._buffViewInstanceList do
    if buffViewInstance:BuffID() == self._buffViewInstanceList[i]:BuffID() then
      oldBuffView = self._buffViewInstanceList[i]
      self.removeIndex = i
      break
    end
  end
  if isAdd then
    if buffViewInstance:GetLayerCount() == 0 and buffViewInstance:GetBuffEffectType() == BuffEffectType.DragonMark then
      return
    end
    if not oldBuffView or not table.icontains(self._buffViewInstanceList, oldBuffView) then
      table.insert(self._buffViewInstanceList, buffViewInstance)
    else
      self._buffViewInstanceList[self.removeIndex] = buffViewInstance
    end
  elseif oldBuffView then
    self.curPageEndIndex = self._curPage * self._pageBuffCount
    self.curPageStartIndex = (self._curPage - 1) * self._pageBuffCount + 1
    self.backPreviousPage = false
    table.removev(self._buffViewInstanceList, oldBuffView)
  end
  self._buffViewInstanceList = self:OnSortBuffArray(self._buffViewInstanceList)
  self:_GetPageCount()
end

function UIHPBuffInfo:_OnPlayBuff(isAdd)
  if isAdd then
    self:_OnPlayCurPage()
  else
    self.backPreviousPage = self.curPageStartIndex > self._curPage * self._pageBuffCount
    if #self._buffViewInstanceList == 0 or self.backPreviousPage then
      self:_OnPlayCurPage()
      return
    end
    if self.removeIndex <= self.curPageEndIndex then
      local startIndex = 1
      if self.removeIndex > self.curPageStartIndex then
        startIndex = self.removeIndex - self.curPageStartIndex + 1
      end
      local minCount = math.min(self._pageBuffCount, #self._buffViewInstanceList)
      if minCount + 1 <= self._pageBuffCount then
        for i = minCount + 1, self._pageBuffCount do
          local buffItem = self._buffItemList[i]
          buffItem:OnHide()
        end
      end
      for i = startIndex, minCount do
        TaskManager:GetInstance():CoreGameStartTask(function(TT)
          local buffItem = self._buffItemList[i]
          buffItem:OnHide()
          local animationItem = self:_GetEmptyBuffAnimationItem()
          local endPos = buffItem:GetGameObject():GetComponent("Transform").localPosition
          local startPos = endPos + Vector3(self._show_buff_move_distance, 0, 0)
          buffItem:SetTargetData(self._buffViewInstanceList[i])
          animationItem:DoMoveTween(self._buffViewInstanceList[i], startPos, endPos, self._show_buff_move_time)
          YIELD(TT, self._show_buff_move_time * 1000)
          buffItem:RefreshData()
        end)
      end
    else
      self:_OnPlayCurPage()
    end
  end
end

function UIHPBuffInfo:_GetPageCount()
  self._pageMax = math.ceil(#self._buffViewInstanceList / self._pageBuffCount)
  if self._pageMax == 1 then
    self._curPage = 1
  end
end

function UIHPBuffInfo:_GetEmptyBuffAnimationItem()
  for i, item in ipairs(self._buffAnimationList) do
    if not item:IsInMoveTween() then
      return item
    end
  end
  return self._buffAnimationList[#self._buffAnimationList]
end

function UIHPBuffInfo:_OnPlayCurPage()
  self._show_buff_delta_time = 0
  for i = 1, #self._buffItemList do
    local index = (self._curPage - 1) * self._pageBuffCount + i
    local buffItem = self._buffItemList[i]
    if index <= #self._buffViewInstanceList then
      buffItem:SetData(self._buffViewInstanceList[index])
    else
      buffItem:OnHide()
    end
  end
end

function UIHPBuffInfo:OnRefreshBuffTime(deltaTime)
  if #self._buffViewInstanceList <= self._pageBuffCount then
    return
  end
  self._show_buff_delta_time = self._show_buff_delta_time + deltaTime
  if self._show_buff_delta_time > self._show_buff_interval_time + self._show_buff_fade_time then
    self._show_buff_delta_time = self._show_buff_delta_time - self._show_buff_interval_time - self._show_buff_fade_time
    self:_PlayRefreshPage()
  end
end

function UIHPBuffInfo:_PlayRefreshPage()
  if self.__playRefreshPageTask then
    TaskManager:GetInstance():KillTask(self.__playRefreshPageTask)
  end
  self.__playRefreshPageTask = TaskManager:GetInstance():CoreGameStartTask(function(TT)
    for i = 1, #self._buffItemList do
      local buffItem = self._buffItemList[i]
      buffItem:DoFadeTween(0, self._show_buff_fade_time / 2)
    end
    for i = 1, #self._buffAnimationList do
      local buffItem = self._buffAnimationList[i]
      buffItem:DoFadeTween(0, self._show_buff_fade_time / 2)
    end
    YIELD(TT, self._show_buff_fade_time / 2 * 1000)
    self:_GetPageCount()
    if 1 < self._pageMax then
      self._curPage = self._curPage + 1
      if self._curPage > self._pageMax then
        self._curPage = 1
      end
    else
      self._curPage = 1
    end
    self:_OnPlayCurPage()
    for i = 1, #self._buffItemList do
      local buffItem = self._buffItemList[i]
      buffItem:DoFadeTween(1, self._show_buff_fade_time / 2)
    end
  end)
end

function UIHPBuffInfo:_ShowShieldBuff(remove)
  if not self._shieldRoot then
    return
  end
  local shieldLayer = 0
  self._layerShieldViewInstance = InnerGameHelperRender.GetSingleBuffByBuffEffect(self._entityId, BuffEffectType.LayerShield)
  if self._layerShieldViewInstance then
    shieldLayer = self._layerShieldViewInstance:GetLayerCount() or 0
  end
  if remove then
    shieldLayer = 0
  end
  if shieldLayer == self._shieldLayer then
    return
  end
  if shieldLayer < self._shieldLayer then
    if shieldLayer == 0 then
      self._rootAnim:Play("113")
      GameGlobal.TaskManager():CoreGameStartTask(self._delayHideShield, self)
      InnerGameHelperRender.RemoveBuffViewInstance(self._entityId, self._layerShieldViewInstance)
    else
      self._rootAnim:Play("112")
    end
  else
    if self._shieldRoot.transform.childCount == 0 then
      self._shieldRootPath:SpawnObject(nil)
    end
    if not self._textGo then
      self._textGo = GameObjectHelper.FindChild(self._shieldRoot.transform, "Number")
      self._textShield = self._textGo.gameObject:GetComponent("Text")
    end
    if not self._rootAnimGo then
      self._rootAnimGo = self._shieldRoot.transform:GetChild(0)
      self._rootAnim = self._rootAnimGo.gameObject:GetComponent("Animation")
    end
    self._shieldRoot:SetActive(true)
    self._rootAnim:Play("111")
  end
  self._textShield.text = shieldLayer
  self._shieldLayer = shieldLayer
  InnerGameHelperRender.UISetHPLayerShieldCount(self._entityId, shieldLayer)
  self:_OnSortShieldAndBombPos()
end

function UIHPBuffInfo:_delayHideShield(TT)
  YIELD(TT, 500)
  if self._shieldRoot and self._onShow and self._rootAnim:IsPlaying("111") == false then
    self._shieldRoot:SetActive(false)
  end
  self:_OnSortShieldAndBombPos()
end

function UIHPBuffInfo:OnCheckBuffAnimation()
  if self._initAnimation then
    return
  end
  if not self._rootAnim then
    return
  end
  if self._rootAnim:IsPlaying("111") then
    self._initAnimation = true
    GameGlobal.TaskManager():CoreGameStartTask(self._WaitAnimationInit, self)
  end
end

function UIHPBuffInfo:_WaitAnimationInit(TT)
  self._shieldRoot:SetActive(false)
  self._rootAnim:Stop()
  YIELD(TT)
  if self._shieldRoot then
    self._shieldRoot:SetActive(true)
    self._rootAnim:Play("111")
  end
  self:_OnSortShieldAndBombPos()
end

function UIHPBuffInfo:OnHPSliderBroken(entityID)
  if self._entityId ~= entityID then
    return
  end
  if not self._brokenRoot then
    return
  end
  if self._brokenRoot.transform.childCount == 0 then
    self._brokenRootPath:SpawnObject(nil)
  end
  self._brokenRoot:SetActive(true)
end

function UIHPBuffInfo:OnSortBuffArray(buffViewArray)
  table.sort(buffViewArray, function(a, b)
    if a:BuffID() == b:BuffID() then
      return a:BuffSeq() < b:BuffSeq()
    end
    return a:BuffID() < b:BuffID()
  end)
  return buffViewArray
end

function UIHPBuffInfo:OnRefreshHPBombLayer(entityID, layerCount)
  if self._entityId ~= entityID then
    return
  end
  if not self._bombRoot then
    return
  end
  self._bombRoot:SetActive(0 < layerCount)
  self._textBomb.text = layerCount
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    YIELD(TT)
    self:_OnSortShieldAndBombPos()
  end)
end

function UIHPBuffInfo:_OnSortShieldAndBombPos()
  if self._bombRoot and self._bombRoot.gameObject and self._bombRoot.gameObject.activeSelf then
    local pos = self._textShield and self._shieldRoot.gameObject.activeSelf and Vector2(135, -25) or Vector2(90, -25)
    self._bombTransform.anchoredPosition = pos
  end
  if self._antiRoot and self._antiRoot.gameObject and self._antiRoot.gameObject.activeSelf then
    local posAnti = Vector2(90, -25)
    if self._shieldRoot.gameObject.activeSelf and self._textShield then
      posAnti = posAnti + Vector2(45, 0)
    end
    if self._bombRoot.gameObject.activeSelf then
      posAnti = posAnti + Vector2(45, 0)
    end
    self._antiTransform.anchoredPosition = posAnti
  end
  if self._chessHPRoot and self._chessHPRoot.activeSelf and self._shieldRoot then
    self._shieldRoot.transform.anchoredPosition = Vector2(50, 25)
  end
end

function UIHPBuffInfo:UpdateAntiActiveSkill(entityID, showCD)
  if entityID ~= self._entityId then
    return
  end
  if not self._antiRoot then
    return
  end
  local antiSkillEnabled = InnerGameHelperRender.GetEntityAttribute(entityID, "AntiSkillEnabled")
  local maxCount = InnerGameHelperRender.GetEntityAttribute(entityID, "MaxAntiSkillCountPerRound")
  local antiCD = InnerGameHelperRender.GetEntityAttribute(entityID, "WaitActiveSkillCount")
  local show = maxCount ~= 0 and antiSkillEnabled == 1 or showCD ~= nil
  self._antiRoot.gameObject:SetActive(show)
  local originalCount = InnerGameHelperRender.GetEntityAttribute(entityID, "OriginalWaitActiveSkillCount")
  self._textAnti.gameObject:SetActive(originalCount ~= 1)
  if showCD then
    antiCD = showCD
  end
  self._textAnti:SetText(antiCD)
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    YIELD(TT)
    self:_OnSortShieldAndBombPos()
  end)
end

function UIHPBuffInfo:OnHPSliderBlink(entityID, show)
  if self._entityId ~= entityID then
    return
  end
  if not self._blinkRoot then
    return
  end
  if self._blinkRoot.transform.childCount == 0 then
    if show == false then
      return
    end
    self._blinkRootPath:SpawnObject(nil)
  end
  self._blinkRoot:SetActive(show)
end
