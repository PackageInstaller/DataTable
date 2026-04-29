_class("UISeasonTalentTreeSkillParent", UICustomWidget)
UISeasonTalentTreeSkillParent = UISeasonTalentTreeSkillParent

function UISeasonTalentTreeSkillParent:OnShow()
  self.idx2pos = {
    [1] = Vector2(-264, 57),
    [2] = Vector2(-159, -250),
    [3] = Vector2(176, -247),
    [4] = Vector2(265, 59),
    [5] = Vector2(2, 249)
  }
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._mask = self:GetGameObject("Mask")
  self._lock = self:GetGameObject("Lock")
  self._lv = self:GetGameObject("Lv")
  self._lvTex = self:GetUIComponent("UILocalizationText", "LvTex")
  self._root = self:GetUIComponent("RectTransform", "root")
  self._buyTips = self:GetGameObject("BuyTips")
  self._select = self:GetGameObject("Select")
  self._anim = self:GetUIComponent("Animation", "UISeasonTalentTree_parent")
  self:Select(false)
  self:AttachEvent(GameEventType.OnSelectSkill, self.OnSelectSkill)
  self:AttachEvent(GameEventType.OnTalentTreeSkillUp, self.OnTalentTreeSkillUp)
end

function UISeasonTalentTreeSkillParent:Get_1P_2N_Icon()
  local pools = self._pool:GetAllSpawnList()
  local t_2n = pools[2]
  return t_2n:Get_1P_2N_Icon()
end

function UISeasonTalentTreeSkillParent:OnTalentTreeSkillUp(rootid)
  if rootid == self.rootid then
    self._anim:Play("uianim_UISeasonTalentTree_parent")
  end
end

function UISeasonTalentTreeSkillParent:OnSelectSkill(skillCls)
  local select = false
  if skillCls then
    select = skillCls.rootid == self.rootid
  end
  self:Select(select)
end

function UISeasonTalentTreeSkillParent:Select(active)
  self._select:SetActive(active)
end

function UISeasonTalentTreeSkillParent:SetData(idx, rootid, cfg, rootIDMap, comCfgID, callback)
  self.idx = idx
  self.rootid = rootid
  self.cfg = cfg
  self.cls = rootIDMap[rootid]
  self.rootIDMap = rootIDMap
  self.comCfgID = comCfgID
  self.callback = callback
  self:ShowChildList()
  self:OnValue()
end

function UISeasonTalentTreeSkillParent:OnValue()
  self:SetPos()
  self:SetIcon()
  self:SetMask()
  self:SetLock()
  self:SetBuyTips()
  self:SetLv()
end

function UISeasonTalentTreeSkillParent:SetPos()
  local pos = self.idx2pos[self.idx]
  self._root.anchoredPosition = pos
end

function UISeasonTalentTreeSkillParent:SetIcon()
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

function UISeasonTalentTreeSkillParent:SetMask()
  local mask = self.cls.level == 0 and not self.cls.lock
  self._mask:SetActive(mask)
end

function UISeasonTalentTreeSkillParent:SetLock()
  self._lock:SetActive(self.cls.lock)
end

function UISeasonTalentTreeSkillParent:SetBuyTips()
  self._buyTips:SetActive(self.cls.canBuy)
end

function UISeasonTalentTreeSkillParent:SetLv()
  local lv = self.cls.level
  self._lv:SetActive(0 < lv)
  if 0 < lv then
    local levelMax = self.cls:GetLevelMax()
    self._lvTex:SetText(lv .. "/" .. levelMax)
  end
end

function UISeasonTalentTreeSkillParent:ShowChildList()
  local childList = self.cfg.ChildSkill
  self._pool:SpawnObjects("UISeasonTalentTreeSkillChild", #childList)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #childList do
    local item = pools[i]
    local rootid = childList[i]
    item:SetData(self.idx, i, rootid, self.rootIDMap, self.comCfgID, self.callback)
  end
end

function UISeasonTalentTreeSkillParent:RefreshCls(cls, rootIDMap)
  self.cls = cls
  self.rootIDMap = rootIDMap
  self:RefreshChildList()
  self:OnValue()
end

function UISeasonTalentTreeSkillParent:RefreshChildList()
  local childList = self.cfg.ChildSkill
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #childList do
    local item = pools[i]
    item:RefreshCls(self.rootIDMap)
  end
end

function UISeasonTalentTreeSkillParent:IconOnClick(go)
  if self.callback then
    self.callback(self.cls)
  end
end
