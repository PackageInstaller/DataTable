_class("UISeasonTalentTreeSlotCell", UICustomWidget)
UISeasonTalentTreeSlotCell = UISeasonTalentTreeSlotCell

function UISeasonTalentTreeSlotCell:OnShow()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._light = self:GetGameObject("Light")
  self._P_light = self:GetGameObject("P_light")
  self._N_light = self:GetGameObject("N_light")
  self._power = self:GetGameObject("Power")
  self._normal = self:GetGameObject("Normal")
  self._lock = self:GetGameObject("Lock")
  self._unlock = self:GetGameObject("UnLock")
  self._select = self:GetGameObject("Select")
  self._btn = self:GetGameObject("Btn")
  self._P_select = self:GetGameObject("P_select")
  self._N_select = self:GetGameObject("N_select")
  self._P_empty = self:GetGameObject("P_empty")
  self._N_empty = self:GetGameObject("N_empty")
  self:SetLight(false)
  self:Select(false)
  self:AttachEvent(GameEventType.OnSelectSkill, self.OnSelectSkill)
  self:AttachEvent(GameEventType.OnSelectSlot, self.OnSelectSlot)
  self:EventListener()
end

function UISeasonTalentTreeSlotCell:OnSelectSkill(skillCls)
  if self.rootid and skillCls then
    local type = skillCls.type
    if type == self.cfg.TypeLimit and skillCls.level > 0 then
      self:SetLight(true)
      return
    end
  end
  self:SetLight(false)
end

function UISeasonTalentTreeSlotCell:OnSelectSlot(id)
  self:Select(id == self.cfg.SlotID)
end

function UISeasonTalentTreeSlotCell:Select(active)
  self._select:SetActive(active)
  if self.limitType then
    self._P_select:SetActive(active and self.limitType == SeasonTalentSkillType.Power)
    self._N_select:SetActive(active and self.limitType == SeasonTalentSkillType.Normal)
  end
end

function UISeasonTalentTreeSlotCell:SetLight(active)
  self._light:SetActive(active)
  self._P_light:SetActive(active and self.limitType == SeasonTalentSkillType.Power)
  self._N_light:SetActive(active and self.limitType == SeasonTalentSkillType.Normal)
end

function UISeasonTalentTreeSlotCell:SetData(idx, cfg, rootid, callback)
  self.idx = idx
  self.cfg = cfg
  self.limitType = self.cfg.TypeLimit
  self.rootid = rootid
  self.callback = callback
  self:OnValue()
  local slotRect = self:GetUIComponent("RectTransform", "Icon")
  return slotRect
end

function UISeasonTalentTreeSlotCell:RefreshData(rootid)
  self.rootid = rootid
  self:OnValue()
end

function UISeasonTalentTreeSlotCell:OnValue()
  self:SetIcon()
  self:SetLock()
  self:SetType()
end

function UISeasonTalentTreeSlotCell:SetIcon()
  if self.rootid and self.rootid > 0 then
    self._icon.gameObject:SetActive(true)
    local cfgs = Cfg.cfg_component_talent_tree_skill({
      ComponentID = self.comCfgID,
      SkillTypeID = self.rootid,
      Level = 1
    })
    local cfg = cfgs[1]
    local icon = cfg.Icon
    if icon then
      self._icon:LoadImage(icon)
    end
    self._P_empty:SetActive(false)
    self._N_empty:SetActive(false)
  else
    self._icon.gameObject:SetActive(false)
    self._P_empty:SetActive(self.limitType == SeasonTalentSkillType.Power)
    self._N_empty:SetActive(self.limitType == SeasonTalentSkillType.Normal)
  end
end

function UISeasonTalentTreeSlotCell:SetLock()
  self._lock:SetActive(self.rootid == nil)
  self._unlock:SetActive(self.rootid ~= nil)
end

function UISeasonTalentTreeSlotCell:SetType()
  self._power:SetActive(self.limitType == SeasonTalentSkillType.Power)
  self._normal:SetActive(self.limitType == SeasonTalentSkillType.Normal)
end

function UISeasonTalentTreeSlotCell:EventListener()
  local etl = UICustomUIEventListener.Get(self._btn)
  self:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(eventData)
    if self.rootid and self.rootid > 0 then
      local params = {}
      params.slotid = self.cfg.SlotID
      params.rootid = self.rootid
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalentDragEvent, TalentTree_FSM_Event_Type.Drag_Out_Begin, params)
    end
  end)
  self:AddUICustomEventListener(etl, UIEvent.Drag, function(eventData)
    if self.rootid and self.rootid > 0 then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalentDragEvent, TalentTree_FSM_Event_Type.Drag_Out_Drag, eventData.position)
    end
  end)
  
  local function endDragFunc(eventData)
    if self.rootid then
      if eventData then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalentDragEvent, TalentTree_FSM_Event_Type.Drag_Out_End, eventData.position)
      else
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalentDragEvent, TalentTree_FSM_Event_Type.Drag_Out_End, nil)
      end
    end
  end
  
  self:AddUICustomEventListener(etl, UIEvent.EndDrag, function(eventData)
    endDragFunc(eventData)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    if self.rootid then
      if self.callback then
        self.callback(self.cfg.SlotID)
      end
    else
      local tips
      if self.idx == 3 then
        tips = "str_season_talent_tree_slot_unlock1"
      elseif self.idx == 4 then
        tips = "str_season_talent_tree_slot_unlock2"
      end
      if tips then
        ToastManager.ShowToast(StringTable.Get(tips))
      end
      Log.debug("###[UISeasonTalentTreeSlotCell] slot is lock ! idx:", self.idx)
    end
  end)
  if not EDITOR then
    self:AddUICustomEventListener(etl, UIEvent.ApplicationFocus, function(b)
      if not b then
        if not etl.IsDragging then
          return
        end
        etl.IsDragging = false
        endDragFunc()
      end
    end)
  end
end
