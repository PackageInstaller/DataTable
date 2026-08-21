_class("UIN20AVGCollection", UIController)
UIN20AVGCollection = UIN20AVGCollection

function UIN20AVGCollection:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
  self.mItem = GameGlobal.GetModule(ItemModule)
end

function UIN20AVGCollection:OnShow(uiParams)
  self.redTabBadge = self:GetGameObject("redTabBadge")
  self.newTabBadge = self:GetGameObject("newTabBadge")
  self.sv = self:GetUIComponent("ScrollRect", "sv")
  self.poolContent = self:GetUIComponent("UISelectObjectPath", "Content")
  self.badge = self:GetGameObject("badge")
  self.badgeSelect = self:GetGameObject("badgeSelect")
  self.badge:SetActive(false)
  self.cg = self:GetGameObject("cg")
  self.cg:SetActive(false)
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.sldProgress = self:GetUIComponent("Slider", "sldProgress")
  self.rtProgress = self:GetUIComponent("RectTransform", "sldProgress")
  self.poolProgress = self:GetUIComponent("UISelectObjectPath", "poolProgress")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.poolBadge = self:GetUIComponent("UISelectObjectPath", "poolBadge")
  self.time = self:GetGameObject("time")
  self.txtGetTime = self:GetUIComponent("UILocalizationText", "txtGetTime")
  self.imgCG = self:GetUIComponent("RawImageLoader", "imgCG")
  self.suo = self:GetGameObject("suo")
  self.btnShowCG = self:GetGameObject("btnShowCG")
  self.btnShowCG:SetActive(false)
  self.txtGetCondition = self:GetUIComponent("UILocalizationText", "txtGetCondition")
  self.poolCGAward = self:GetUIComponent("UISelectObjectPath", "cgAward")
  self.got = self:GetGameObject("got")
  self.canGet = self:GetGameObject("canGet")
  self.goBigCG = self:GetGameObject("goBigCG")
  self.goBigCG:SetActive(false)
  self.imgBigCG = self:GetUIComponent("RawImageLoader", "imgBigCG")
  self:FlushTab()
  self.curEndId = -1
  self:AutoSelectTab()
end

function UIN20AVGCollection:OnHide()
  self.imgCG:DestoryLastImage()
  self.imgBigCG:DestoryLastImage()
end

function UIN20AVGCollection:SetCurEndId(endId)
  if endId == self.curEndId then
    return
  end
  self.curEndId = endId
  local uis = self.poolContent:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    if endId == ui:EndId() then
      ui:FlushSelect(true)
      self.badge:SetActive(false)
      self.cg:SetActive(true)
      self:FlushCG()
    else
      ui:FlushSelect(false)
    end
  end
  if endId == 0 then
    self.badgeSelect:SetActive(true)
    self.badge:SetActive(true)
    self.cg:SetActive(false)
    self:FlushBadge()
    self:FlushTabBadgeNewEffect()
  else
    self.badgeSelect:SetActive(false)
    self:FlushTabCgNew()
  end
end

function UIN20AVGCollection:FlushTab()
  local notBEs = {}
  for index, ending in ipairs(self.data.endings) do
    if not ending.isBE then
      table.insert(notBEs, ending)
    end
  end
  local len = table.count(notBEs)
  self.poolContent:SpawnObjects("UIN20AVGCollectionItem", len)
  local uis = self.poolContent:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local ending = notBEs[i]
    local endId = ending.id
    ui:Flush(endId, function()
      self:SetCurEndId(endId)
    end)
  end
  self:FlushTabBadgeRed()
  self:FlushTabBadgeNew()
end

function UIN20AVGCollection:FlushTabBadgeRed()
  local isShow = self.data:HasRedBadge()
  self.redTabBadge:SetActive(isShow)
end

function UIN20AVGCollection:FlushTabBadgeNew()
  local isShow = self.data:HasNewBadge()
  self.newTabBadge:SetActive(isShow)
end

function UIN20AVGCollection:AutoSelectTab()
  if self.data:HasNewBadge() then
    self:SetCurEndId(0)
    return
  end
  for index, ending in ipairs(self.data.endings) do
    if ending:HasNew() then
      self:SetCurEndId(ending.id)
      return
    end
  end
  self:SetCurEndId(0)
end

function UIN20AVGCollection:FlushBadge()
  local countReach, count = 0, 0
  for _, badge in ipairs(self.data.badges) do
    count = count + 1
    if badge:HasGot() then
      countReach = countReach + 1
    end
  end
  self.txtCount:SetText(countReach .. "/" .. count)
  self.sldProgress.maxValue = count
  self.sldProgress.value = countReach
  local len = table.count(self.data.badgeStages)
  self.poolProgress:SpawnObjects("UIN20AVGBadgeProgressItem", len)
  local uis = self.poolProgress:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local badgeStage = self.data.badgeStages[i]
    ui:Flush(badgeStage.id, function()
      local state = badgeStage:State()
      if state == AVGAwardState.CanGet then
        self:StartTask(function(TT)
          local c = self.data:GetComponentAVG()
          local res = AsyncRequestRes:New()
          local ret = c:HandleGetBadgeReward(TT, res, badgeStage.id)
          if N20AVGData.CheckCode(res) then
            UIActivityHelper.ShowUIGetRewards(badgeStage.awards)
            self:FlushTab()
            self:FlushBadge()
            GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGFlushNewRed)
          end
        end)
      else
        local award = badgeStage.awards[1]
        self:ShowDialog("UIItemTips", award, ui:GetGameObject(), "UIN20AVGCollection", Vector2(-377, 0))
      end
    end)
    local pos = Vector2(self.rtProgress.rect.width * badgeStage.count / count, 0)
    ui:FlushPos(pos)
  end
  len = table.count(self.data.badges)
  self.poolBadge:SpawnObjects("UIN20AVGBadgeItem", len)
  local uis = self.poolBadge:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local badge = self.data.badges[i]
    ui:Flush(badge.id, function()
      for i, ui in ipairs(uis) do
        ui:FlushSelect(badge.id)
      end
      local showName
      if badge:HasGot() then
        showName = badge.name
      else
        showName = "???"
      end
      self.txtName:SetText(showName)
      self.txtDesc:SetText(badge.desc)
    end)
    ui:FlushPos(badge.pos)
    if i == 1 then
      ui:btnOnClick()
    end
  end
end

function UIN20AVGCollection:FlushTabBadgeNewEffect()
  if self.curEndId ~= 0 then
    return
  end
  self:StartTask(function(TT)
    if self.data:HasNewBadge() then
      local key = "UIN20AVGCollection_FlushTabBadgeNewEffect"
      self:Lock(key)
      YIELD(TT, 500)
      for index, badge in ipairs(self.data.badges) do
        if badge:HasNew() then
          self:BadgeNewEffect(TT, index, badge)
          local items = self.mItem:GetItemByTempId(badge.itemId)
          for _, item in pairs(items) do
            local pstId = item:GetID()
            self.mItem:SetItemUnnewOverlay(TT, pstId)
          end
        end
      end
      self:UnLock(key)
      self:FlushTabBadgeRed()
      self:FlushTabBadgeNew()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGFlushNewRed)
    end
  end, self)
end

function UIN20AVGCollection:BadgeNewEffect(TT, index, badge)
  local uis = self.poolBadge:GetAllSpawnList()
  local ui = uis[index]
  self:_MoveTransform(ui)
  ui:FlushNewEffect(badge.pos)
  YIELD(TT, 1500)
end

function UIN20AVGCollection:_MoveTransform(obj)
  local trans = obj:GetGameObject():GetComponent("Transform")
  trans:SetAsLastSibling()
end

function UIN20AVGCollection:FlushCG()
  local ending = self.data:GetEndingById(self.curEndId)
  local state = ending:AwardState()
  local hasNew = ending:HasNew()
  if state then
    self.time:SetActive(true)
    local timestampGot = ending:GetTimestamp()
    local str = self.data:Timestamp2Str(timestampGot)
    self.txtGetTime:SetText(StringTable.Get("str_avg_n20_get_time", str))
    self.imgCG:LoadImage(ending.cgCollect)
    self.suo:SetActive(hasNew)
    if hasNew then
      UIWidgetHelper.PlayAnimation(self, "anim", "uieff_UIN20AVGCollection_cg", 2033)
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N20GetCG)
    end
    self.imgBigCG:LoadImage(ending.cg)
    self.btnShowCG:SetActive(true)
  else
    self.time:SetActive(false)
    self.imgCG:LoadImage("N20_avg_sc_image01")
    self.btnShowCG:SetActive(false)
  end
  self.txtGetCondition:SetText(ending.getConditionDesc)
  local awardState = ending:AwardState()
  local len = table.count(ending.awards)
  self.poolCGAward:SpawnObjects("UIN20AVGCGAward", len)
  local uis = self.poolCGAward:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local ra = ending.awards[i]
    ui:Flush(ra, function()
      self:ShowDialog("UIItemTips", ra, ui:GetGameObject(), "UIN20AVGCollection", Vector2(0, 250))
    end)
    ui:FlushGot(awardState == AVGAwardState.Got)
  end
  if awardState then
    if awardState == AVGAwardState.CanGet then
      self.got:SetActive(false)
      self.canGet:SetActive(true)
    else
      self.got:SetActive(true)
      self.canGet:SetActive(false)
    end
  else
    self.got:SetActive(false)
    self.canGet:SetActive(false)
  end
end

function UIN20AVGCollection:FlushTabCgNew()
  if self.curEndId == 0 then
    return
  end
  local uis = self.poolContent:GetAllSpawnList()
  local len = table.count(uis)
  for i, ui in ipairs(uis) do
    if self.curEndId == ui:EndId() then
      local fz = i - 1
      local fm = len - 1
      if 0 < fm then
        self.sv.verticalNormalizedPosition = 1 - fz / fm
        break
      end
      self.sv.verticalNormalizedPosition = 0
      break
    end
  end
  self:StartTask(function(TT)
    local ending = self.data:GetEndingById(self.curEndId)
    if ending:HasNew() then
      local items = self.mItem:GetItemByTempId(ending.itemId)
      for _, item in pairs(items) do
        local key = "UIN20AVGCollectionFlushTab"
        self:Lock(key)
        local pstId = item:GetID()
        self.mItem:SetItemUnnewOverlay(TT, pstId)
        self:FlushTab()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGFlushNewRed)
        self:UnLock(key)
      end
    end
  end, self)
end

function UIN20AVGCollection:btnExitOnClick(go)
  self:CloseDialog()
end

function UIN20AVGCollection:imgTabBadgeOnClick(go)
  self:SetCurEndId(0)
end

function UIN20AVGCollection:btnAwardOnClick(go)
  local ending = self.data:GetEndingById(self.curEndId)
  local awardState = ending:AwardState()
  if awardState == AVGAwardState.CanGet then
    self:StartTask(function(TT)
      local key = "UIN20AVGCollectionbtnAwardOnClick"
      self:Lock(key)
      local c = self.data:GetComponentAVG()
      local res = AsyncRequestRes:New()
      local res = c:HandleAcceptCgReward(TT, ending.itemIdGift)
      if N20AVGData.CheckCode(res) then
        UIActivityHelper.ShowUIGetRewards(ending.awards)
        self:FlushTab()
        self:FlushCG()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.AVGFlushNewRed)
      end
      self:UnLock(key)
    end)
  end
end

function UIN20AVGCollection:btnShowCGOnClick(go)
  self.goBigCG:SetActive(true)
end

function UIN20AVGCollection:imgBGOnClick(go)
  self.goBigCG:SetActive(false)
end

function UIN20AVGCollection:_Test_SetCgNew()
  if not UIActivityHelper.CheckDebugOpen() then
    return
  end
  self:StartTask(function(TT)
    local notBEs = {}
    for index, ending in ipairs(self.data.endings) do
      if not ending.isBE then
        local items = self.mItem:GetItemByTempId(ending.itemId)
        for _, item in pairs(items) do
          local key = "UIN20AVGCollectionFlushTab"
          self:Lock(key)
          local pstId = item:GetID()
          self.mItem:_RequestItemOverlayFlag(TT, pstId, ItemDataFlags.Item_Flag_Is_New_Overlay, true)
          self:UnLock(key)
        end
      end
    end
  end, self)
end

function UIN20AVGCollection:_Test_SetBadgeNew()
  if not UIActivityHelper.CheckDebugOpen() then
    return
  end
  self:StartTask(function(TT)
    for index, badge in ipairs(self.data.badges) do
      local items = self.mItem:GetItemByTempId(badge.itemId)
      for _, item in pairs(items) do
        local key = "UIN20AVGCollectionFlushTab"
        self:Lock(key)
        local pstId = item:GetID()
        self.mItem:_RequestItemOverlayFlag(TT, pstId, ItemDataFlags.Item_Flag_Is_New_Overlay, true)
        self:UnLock(key)
      end
    end
  end, self)
end
