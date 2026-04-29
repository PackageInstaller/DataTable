_class("UICN20N49LineTalentTreeSlotCell", UICustomWidget)
UICN20N49LineTalentTreeSlotCell = UICN20N49LineTalentTreeSlotCell

function UICN20N49LineTalentTreeSlotCell:OnShow()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._power = self:GetGameObject("Power")
  self._normal = self:GetGameObject("Normal")
  self._lock = self:GetGameObject("Lock")
  self._unlock = self:GetGameObject("UnLock")
  self._p_empty = self:GetGameObject("P_empty")
  self._n_empty = self:GetGameObject("N_empty")
end

function UICN20N49LineTalentTreeSlotCell:SetData(idx, cfg, rootid)
  self.idx = idx
  self.cfg = cfg
  self.rootid = rootid
  self:OnValue()
end

function UICN20N49LineTalentTreeSlotCell:OnValue()
  self:SetIcon()
  self:SetLock()
  self:SetType()
end

function UICN20N49LineTalentTreeSlotCell:SetIcon()
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
    self._p_empty:SetActive(false)
    self._n_empty:SetActive(false)
  else
    self._icon.gameObject:SetActive(false)
    self._p_empty:SetActive(true)
    self._n_empty:SetActive(true)
  end
end

function UICN20N49LineTalentTreeSlotCell:SetLock()
  self._lock:SetActive(self.rootid == nil)
  self._unlock:SetActive(self.rootid ~= nil)
end

function UICN20N49LineTalentTreeSlotCell:SetType()
  self._power:SetActive(self.cfg.TypeLimit == SeasonTalentSkillType.Power)
  self._normal:SetActive(self.cfg.TypeLimit == SeasonTalentSkillType.Normal)
end
