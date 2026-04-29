_class("UISeasonTalentLineMissionNode", UICustomWidget)
UISeasonTalentLineMissionNode = UISeasonTalentLineMissionNode

function UISeasonTalentLineMissionNode:OnShow()
  self._anim = self:GetUIComponent("Animation", "UISeasonTalentLineMission_Node")
  self._root = self:GetUIComponent("RectTransform", "pos")
  self._nameTex = self:GetUIComponent("UILocalizationText", "name")
  self._lockTex = self:GetUIComponent("UILocalizationText", "LockTex")
  self._star = self:GetGameObject("star")
  self._lockGo = self:GetGameObject("lock")
  self._red = self:GetGameObject("red")
  self._stars = {}
  for i = 1, 3 do
    local uiname = "Star" .. i
    local star = self:GetGameObject(uiname)
    self._stars[i] = star
  end
  self._atlas = self:GetAsset("UIS4TalentTree.spriteAtlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.OnTalentTreeRedLineChange, self.OnTalentTreeRedLineChange)
end

function UISeasonTalentLineMissionNode:SetData(idx, cfg, lineInfo, callback)
  self.idx = idx
  self.cfg = cfg
  self.lineInfo = lineInfo
  self.callback = callback
  self:RefreshUI()
end

function UISeasonTalentLineMissionNode:OnTalentTreeRedLineChange()
  self:SetRed()
end

function UISeasonTalentLineMissionNode:RefreshUI()
  self:SetLock()
  self:SetStar()
  self:SetCfgName()
  self:SetPos()
end

function UISeasonTalentLineMissionNode:SetCfgName()
  local campMissionCfg = Cfg.cfg_campaign_mission[self.cfg.CampaignMissionId]
  local nameStr = campMissionCfg.Name
  self._nameTex:SetText(StringTable.Get(nameStr))
end

function UISeasonTalentLineMissionNode:SetPos()
  local posx = self.cfg.MapPosX
  local posy = self.cfg.MapPosY
  self._root.anchoredPosition = Vector2(posx, posy)
  if 0 <= posy then
    self._anim:Play("uianim_UISeasonTalentLineMission_Node_up")
  else
    self._anim:Play("uianim_UISeasonTalentLineMission_Node_down")
  end
end

function UISeasonTalentLineMissionNode:SetStar()
  local star = 0
  local missionid = self.cfg.CampaignMissionId
  if self.lineInfo.m_pass_mission_info[missionid] then
    star = self.lineInfo.m_pass_mission_info[missionid].star
    star = GameGlobal.GetModule(MissionModule):ParseStarInfo(star)
  end
  for i = 1, 3 do
    local go = self._stars[i]
    local img = go:GetComponent("Image")
    local spriteName
    if i <= star then
      spriteName = "exp_s4_yxzx_xing01"
    else
      spriteName = "exp_s4_yxzx_xing02"
    end
    img.sprite = self._atlas:GetSprite(spriteName)
  end
end

function UISeasonTalentLineMissionNode:SetLock()
  self.lock = true
  local needid = self.cfg.NeedMissionId
  if needid and 0 < needid then
    if self.lineInfo.m_pass_mission_info[needid] and 0 < self.lineInfo.m_pass_mission_info[needid].star then
      self.lock = false
    end
  else
    self.lock = false
  end
  self._lockGo:SetActive(self.lock)
  self._star:SetActive(not self.lock)
  if self.lock then
    local campMissionCfg = Cfg.cfg_campaign_mission[needid]
    local nameStr = StringTable.Get(campMissionCfg.Name)
    local tips = StringTable.Get("str_season_talent_tree_line_node_lock_tex", nameStr)
    self._lockTex:SetText(tips)
  end
  self:SetRed()
end

function UISeasonTalentLineMissionNode:SetRed()
  local red = false
  if not self.lock then
    local missionid = self.cfg.CampaignMissionId
    red = not self.lineInfo.m_pass_mission_info[missionid]
  end
  self._red:SetActive(red)
end

function UISeasonTalentLineMissionNode:BtnOnClick(go)
  if self.lock then
    local needid = self.cfg.NeedMissionId
    local campMissionCfg = Cfg.cfg_campaign_mission[needid]
    local nameStr = StringTable.Get(campMissionCfg.Name)
    local tips = StringTable.Get("str_season_talent_tree_line_node_lock_tex", nameStr)
    ToastManager.ShowToast(tips)
  elseif self.callback then
    self.callback(self.idx)
  end
end
