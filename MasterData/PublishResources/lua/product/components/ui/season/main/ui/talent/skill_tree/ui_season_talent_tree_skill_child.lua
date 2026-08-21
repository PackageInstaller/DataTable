_class("UISeasonTalentTreeSkillChild", UICustomWidget)
UISeasonTalentTreeSkillChild = UISeasonTalentTreeSkillChild

function UISeasonTalentTreeSkillChild:OnShow()
  self.idx2pos = {
    [1] = {
      [1] = Vector2(-109, 150),
      [2] = Vector2(-184, 4),
      [3] = Vector2(-108, -136)
    },
    [2] = {
      [1] = Vector2(-176, -28),
      [2] = Vector2(-102, -154),
      [3] = Vector2(61, -163)
    },
    [3] = {
      [1] = Vector2(-50, -166),
      [2] = Vector2(108, -156),
      [3] = Vector2(185, -30)
    },
    [4] = {
      [1] = Vector2(116, -137),
      [2] = Vector2(184, 4),
      [3] = Vector2(115, 148)
    },
    [5] = {
      [1] = Vector2(145, 101),
      [2] = Vector2(2, 163),
      [3] = Vector2(-143, 101)
    }
  }
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._mask = self:GetGameObject("Mask")
  self._using = self:GetGameObject("Using")
  self._light = self:GetGameObject("Light")
  self._buyTips = self:GetGameObject("BuyTips")
  self._select = self:GetUIComponent("CanvasGroup", "Select")
  self._select.alpha = 0
  self._power = self:GetGameObject("Power")
  self._normal = self:GetGameObject("Normal")
  self._P_light = self:GetGameObject("P_light")
  self._N_light = self:GetGameObject("N_light")
  self._P_select = self:GetGameObject("P_select")
  self._N_select = self:GetGameObject("N_select")
  self._P_tips = self:GetGameObject("P_tips")
  self._N_tips = self:GetGameObject("N_tips")
  self._P_using = self:GetGameObject("P_using")
  self._N_using = self:GetGameObject("N_using")
  self._N_eff = self:GetGameObject("N_eff")
  self._P_eff = self:GetGameObject("P_eff")
  self._lock = self:GetGameObject("Lock")
  self._lv = self:GetGameObject("Lv")
  self._lvTex = self:GetUIComponent("UILocalizationText", "LvTex")
  self._root = self:GetUIComponent("RectTransform", "root")
  self._btn = self:GetGameObject("Icon")
  self._anim = self:GetUIComponent("Animation", "UISeasonTalentTree_child")
  self:SetLight(false)
  self:Select(false)
  self:AttachEvent(GameEventType.OnSelectSkill, self.OnSelectSkill)
  self:AttachEvent(GameEventType.OnSelectSlot, self.OnSelectSlot)
  self:EventListener()
end

function UISeasonTalentTreeSkillChild:Get_1P_2N_Icon()
  return self._icon.gameObject
end

function UISeasonTalentTreeSkillChild:OnSelectSkill(skillCls)
  local select = false
  if skillCls then
    select = skillCls.rootid == self.rootid
  end
  self:Select(select)
end

function UISeasonTalentTreeSkillChild:Select(active)
  self._N_select:SetActive(active and self.cls.type == SeasonTalentSkillType.Normal)
  self._P_select:SetActive(active and self.cls.type == SeasonTalentSkillType.Power)
  if active then
    self._select.alpha = 0
    self._anim:Stop()
    self._anim:Play("uianim_UISeasonTalentTree_child_in")
  elseif self.select then
    self._select.alpha = 1
    self._anim:Stop()
    self._anim:Play("uianim_UISeasonTalentTree_child_out")
  end
  self.select = active
end

function UISeasonTalentTreeSkillChild:OnSelectSlot(slotid)
  if self.cls.level > 0 and slotid then
    local cfgs = Cfg.cfg_component_talent_tree_slot({SlotID = slotid})
    local slotCfg = cfgs[1]
    if slotCfg.TypeLimit == self.cls.type then
      self:SetLight(true)
      return
    end
  end
  self:SetLight(false)
end

function UISeasonTalentTreeSkillChild:SetLight(active)
  self._light:SetActive(active)
  self._P_light:SetActive(active and self.cls.type == SeasonTalentSkillType.Power)
  self._N_light:SetActive(active and self.cls.type == SeasonTalentSkillType.Normal)
end

function UISeasonTalentTreeSkillChild:SetData(parentIdx, idx, rootid, map, comCfgID, callback)
  self.parentIdx = parentIdx
  self.idx = idx
  self.rootid = rootid
  self.cls = map[self.rootid]
  self.comCfgID = comCfgID
  self.callback = callback
  self:OnValue()
end

function UISeasonTalentTreeSkillChild:OnValue()
  self:SetPos()
  self:SetIcon()
  self:SetMask()
  self:SetType()
  self:SetUsing()
  self:SetLv()
  self:SetLock()
  self:SetBuyTips()
end

function UISeasonTalentTreeSkillChild:SetMask()
  local mask = self.cls.level == 0 and not self.cls.lock
  self._mask:SetActive(mask)
end

function UISeasonTalentTreeSkillChild:SetType()
  self._power:SetActive(self.cls.type == SeasonTalentSkillType.Power)
  self._normal:SetActive(self.cls.type == SeasonTalentSkillType.Normal)
end

function UISeasonTalentTreeSkillChild:SetUsing()
  self._using:SetActive(self.cls.using)
  self._P_using:SetActive(self.cls.using and self.cls.type == SeasonTalentSkillType.Power)
  self._N_using:SetActive(self.cls.using and self.cls.type == SeasonTalentSkillType.Normal)
end

function UISeasonTalentTreeSkillChild:SetLv()
  local lv = self.cls.level
  self._lv:SetActive(0 < lv)
  if 0 < lv then
    local levelMax = self:GetLevelMax()
    self._lvTex:SetText(lv .. "/" .. levelMax)
  end
end

function UISeasonTalentTreeSkillChild:GetLevelMax()
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = self.comCfgID,
    SkillTypeID = self.rootid
  })
  return #cfgs
end

function UISeasonTalentTreeSkillChild:SetLock()
  self._lock:SetActive(self.cls.lock)
end

function UISeasonTalentTreeSkillChild:SetBuyTips()
  self._buyTips:SetActive(self.cls.canBuy)
  self._P_tips:SetActive(self.cls.canBuy and self.cls.type == SeasonTalentSkillType.Power)
  self._N_tips:SetActive(self.cls.canBuy and self.cls.type == SeasonTalentSkillType.Normal)
end

function UISeasonTalentTreeSkillChild:SetIcon()
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
end

function UISeasonTalentTreeSkillChild:SetPos()
  local pos = self.idx2pos[self.parentIdx][self.idx]
  self._root.anchoredPosition = pos
end

function UISeasonTalentTreeSkillChild:RefreshCls(map)
  self.cls = map[self.rootid]
  self:OnValue()
end

function UISeasonTalentTreeSkillChild:EventListener()
  local etl = UICustomUIEventListener.Get(self._btn)
  self:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(eventData)
    if self.cls.level > 0 then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalentDragEvent, TalentTree_FSM_Event_Type.Drag_In_Begin, self.cls)
    end
  end)
  self:AddUICustomEventListener(etl, UIEvent.Drag, function(eventData)
    if self.cls.level > 0 then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalentDragEvent, TalentTree_FSM_Event_Type.Drag_In_Drag, eventData.position)
    end
  end)
  
  local function endDragFunc(eventData)
    if self.cls.level > 0 then
      if eventData then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalentDragEvent, TalentTree_FSM_Event_Type.Drag_In_End, eventData.position)
      else
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalentDragEvent, TalentTree_FSM_Event_Type.Drag_In_End, nil)
      end
    end
  end
  
  self:AddUICustomEventListener(etl, UIEvent.EndDrag, function(eventData)
    endDragFunc(eventData)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    if self.callback then
      self.callback(self.cls)
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
