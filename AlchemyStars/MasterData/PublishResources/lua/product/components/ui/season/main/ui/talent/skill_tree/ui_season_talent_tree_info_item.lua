_class("UISeasonTalentTreeInfoItem", UICustomWidget)
UISeasonTalentTreeInfoItem = UISeasonTalentTreeInfoItem

function UISeasonTalentTreeInfoItem:OnShow()
  self._isActive = true
  self._select = self:GetGameObject("Select")
  self._unSelect = self:GetGameObject("UnSelect")
  self._descPool = self:GetUIComponent("UISelectObjectPath", "DescPool")
  self._descPoolRT = self:GetUIComponent("RectTransform", "DescPool")
  self._descPoolGo = self:GetGameObject("DescPool")
  self._lock = self:GetGameObject("Lock")
  self._unLock = self:GetGameObject("UnLock")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._iconBg = self:GetGameObject("IconBg")
  self._skillName = self:GetUIComponent("UILocalizationText", "SkillName")
  self._skillType = self:GetUIComponent("UILocalizationText", "SkillType")
  self._lvPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._lvPoolRT = self:GetUIComponent("RectTransform", "Content")
  self._lockTips = self:GetUIComponent("UILocalizationText", "LockTips")
  self._buyCost = self:GetUIComponent("UILocalizationText", "BuyCost")
  self._buy = self:GetGameObject("Buy")
  self._upLv = self:GetGameObject("UpLv")
  self._preCost = self:GetUIComponent("UILocalizationText", "PreCost")
  self._upBtn = self:GetGameObject("UpBtn")
  self._maxLv = self:GetGameObject("MaxLv")
  self._upCost = self:GetUIComponent("UILocalizationText", "UpCost")
  self._anim = self:GetUIComponent("Animation", "UISeasonTalentTree_Info")
  self._effGo = self:GetGameObject("eff")
  self._Arrow = self:GetGameObject("Arrow")
end

function UISeasonTalentTreeInfoItem:RefreshData(com, skillData, selectSkill, isClickSkill)
  self.com = com
  self.comCfgID = self.com:GetComponentCfgId()
  self.comInfo = self.com:GetComponentInfo()
  self.slotCount = table.count(self.comInfo.m_talent_info.m_skill_solt)
  self.skillData = skillData
  self.selectSkill = selectSkill
  if isClickSkill then
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
    self._anim:Stop()
    self._anim:Play("uianim_UISeasonTalentTree_Info")
    self._timer = GameGlobal.Timer():AddEvent(133, function()
      self:Select()
    end)
  else
    self:Select()
  end
end

function UISeasonTalentTreeInfoItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._isActive = false
end

function UISeasonTalentTreeInfoItem:SetData(com, skillData, selectSkill, upCallback, buyCallback)
  self.com = com
  self.comCfgID = self.com:GetComponentCfgId()
  self.comInfo = self.com:GetComponentInfo()
  self.slotCount = table.count(self.comInfo.m_talent_info.m_skill_solt)
  self.skillData = skillData
  self.upCallback = upCallback
  self.buyCallback = buyCallback
  self.selectSkill = selectSkill
  self:Select()
end

function UISeasonTalentTreeInfoItem:Select()
  self._select:SetActive(self.selectSkill ~= nil)
  self._unSelect:SetActive(self.selectSkill == nil)
  if self.selectSkill then
    self:ShowRootIdInfo()
  else
    self:ShowPassiveAddition()
  end
end

function UISeasonTalentTreeInfoItem:ShowPassiveAddition()
  local skillMap = self.skillData:RootIDMap()
  local usingList = {}
  for key, value in pairs(skillMap) do
    if value.type == SeasonTalentSkillType.Passive and value.level > 0 then
      table.insert(usingList, value)
    end
  end
  self._descPoolGo:SetActive(0 < table.count(usingList))
  if 0 < table.count(usingList) then
    local wordList = {}
    local attack = 0
    local defense = 0
    local hp = 0
    local point = 0
    local pointMax = 0
    local activeskill = 0
    for i = 1, #usingList do
      local skill = usingList[i]
      local cfg = Cfg.cfg_component_talent_tree_skill({
        ComponentID = self.comCfgID,
        SkillTypeID = skill.rootid,
        Level = skill.level
      })[1]
      if cfg.Attack then
        attack = attack + cfg.Attack
      end
      if cfg.Defense then
        defense = defense + cfg.Defense
      end
      if cfg.HP then
        hp = hp + cfg.HP
      end
      if cfg.Point then
        point = point + cfg.Point
      end
      if cfg.PointMax then
        pointMax = pointMax + cfg.PointMax
      end
      if cfg.activeskill then
        activeskill = activeskill + cfg.activeskill
      end
    end
    if 0 < attack then
      local attackStr = "<color=#49fff4>+" .. attack .. "</color>"
      local desc = StringTable.Get("str_season_talent_tree_skil_info_attack", attackStr)
      table.insert(wordList, desc)
    end
    if 0 < defense then
      local defenseStr = "<color=#49fff4>+" .. defense .. "</color>"
      local desc = StringTable.Get("str_season_talent_tree_skil_info_defense", defenseStr)
      table.insert(wordList, desc)
    end
    if 0 < hp then
      local hpStr = "<color=#49fff4>+" .. hp .. "</color>"
      local desc = StringTable.Get("str_season_talent_tree_skil_info_hp", hpStr)
      table.insert(wordList, desc)
    end
    if 0 < point then
      local pointStr = "<color=#49fff4>" .. point .. "</color>"
      local desc = StringTable.Get("str_season_talent_tree_skil_info_linecount", pointStr)
      table.insert(wordList, desc)
    end
    if 0 < pointMax then
      local pointMaxStr = "<color=#49fff4>" .. pointMax .. "</color>"
      local desc = StringTable.Get("str_season_talent_tree_skil_info_linemax", pointMaxStr)
      table.insert(wordList, desc)
    end
    if 0 < activeskill then
      local activeskillStr = "<color=#49fff4>" .. activeskill .. "</color>"
      local desc = StringTable.Get("str_season_talent_tree_desc_106", activeskillStr)
      table.insert(wordList, desc)
    end
    local countStr = "<color=#49fff4>" .. self.slotCount .. "</color>"
    local slotCountDesc = StringTable.Get("str_season_talent_tree_skil_info_slot", countStr)
    table.insert(wordList, slotCountDesc)
    self._descPool:SpawnObjects("UISeasonTalentTreeInfoDesc", #wordList)
    local pools = self._descPool:GetAllSpawnList()
    for i = 1, #wordList do
      local item = pools[i]
      local desc = wordList[i]
      item:SetData(desc)
    end
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._descPoolRT)
  end
end

function UISeasonTalentTreeInfoItem:ShowRootIdInfo()
  local lock = self.selectSkill.lock
  self._lock:SetActive(lock)
  self._unLock:SetActive(not lock)
  if lock then
    self:ShowLock()
  else
    self:ShowUnLock()
  end
  self:ShowIcon()
  self:ShowLvPool()
end

function UISeasonTalentTreeInfoItem:ShowLvPool()
  local rootid = self.selectSkill.rootid
  local level = self.selectSkill.level
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = self.comCfgID,
    SkillTypeID = rootid
  })
  local maxLevel = #cfgs
  self._lvPool:SpawnObjects("UISeasonTalentTreeInfoLv", maxLevel)
  local pools = self._lvPool:GetAllSpawnList()
  for i = 1, maxLevel do
    local item = pools[i]
    local lv = i
    local desc
    if i == 1 then
      lv = nil
      local cfgs2
      if 0 < level then
        cfgs2 = Cfg.cfg_component_talent_tree_skill({
          ComponentID = self.comCfgID,
          SkillTypeID = rootid,
          Level = level
        })
      else
        cfgs2 = Cfg.cfg_component_talent_tree_skill({
          ComponentID = self.comCfgID,
          SkillTypeID = rootid,
          Level = 1
        })
      end
      local cfg = cfgs2[1]
      desc = StringTable.Get(cfg.CurrentDesc)
    else
      local cfgs2 = Cfg.cfg_component_talent_tree_skill({
        ComponentID = self.comCfgID,
        SkillTypeID = rootid,
        Level = lv
      })
      local cfg = cfgs2[1]
      desc = StringTable.Get(cfg.UpDesc)
    end
    item:SetData(lv, level, desc)
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._lvPoolRT)
  GameGlobal.Timer():AddEvent(20, function()
    if self._isActive then
      local height = self._lvPoolRT.sizeDelta.y
      if 384 < height then
        self._Arrow:SetActive(true)
      else
        self._Arrow:SetActive(false)
      end
    end
  end)
end

function UISeasonTalentTreeInfoItem:ShowIcon()
  local rootid = self.selectSkill.rootid
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = self.comCfgID,
    SkillTypeID = rootid,
    Level = 1
  })
  local cfg = cfgs[1]
  if cfg.Icon then
    self._icon:LoadImage(cfg.Icon)
  end
  if cfg.Name then
    self._skillName:SetText(StringTable.Get(cfg.Name))
  end
  local typeName
  if self.selectSkill.type == SeasonTalentSkillType.Passive then
    typeName = "str_season_talent_tree_skil_type_1"
  elseif self.selectSkill.type == SeasonTalentSkillType.Normal then
    typeName = "str_season_talent_tree_skil_type_3"
  elseif self.selectSkill.type == SeasonTalentSkillType.Power then
    typeName = "str_season_talent_tree_skil_type_2"
  end
  self._skillType:SetText(StringTable.Get(typeName))
end

function UISeasonTalentTreeInfoItem:ShowLock()
  local tips
  local type = self.selectSkill.type
  if type == SeasonTalentSkillType.Passive then
    local preid
    local passiveList = self.skillData:PassiveCfgList()
    for index, value in ipairs(passiveList) do
      if value.SkillTypeID == self.selectSkill.rootid then
        break
      end
      preid = value.SkillTypeID
    end
    if not preid then
      Log.error("###[UISeasonTalentTreeInfoItem] 错误,获取前置核心没获取到，currid:", self.selectSkill.rootid)
    else
      local rootidmap = self.skillData:RootIDMap()
      local preCls = rootidmap[preid]
      if preCls.lock then
        tips = "str_season_talent_tree_skil_info_lock"
      else
        tips = "str_season_talent_tree_skil_info_lock"
      end
    end
  else
    tips = "str_season_talent_tree_skil_info_lock"
  end
  self._lockTips:SetText(StringTable.Get(tips))
end

function UISeasonTalentTreeInfoItem:ShowUnLock()
  local level = self.selectSkill.level
  self._buy:SetActive(level == 0)
  self._upLv:SetActive(0 < level)
  if 0 < level then
    self:ShowUpLv()
  else
    self:ShowBuy()
  end
end

function UISeasonTalentTreeInfoItem:ShowBuy()
  self._buyCostEnough = true
  local rootid = self.selectSkill.rootid
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = self.comCfgID,
    SkillTypeID = rootid,
    Level = 1
  })
  local cfg = cfgs[1]
  if cfg.Price then
    local tex
    if self.selectSkill:Enough() then
      tex = "<color=#f2f0ff>" .. cfg.Price .. "</color>"
    else
      tex = "<color=#ff5656>" .. cfg.Price .. "</color>"
    end
    self._buyCost:SetText(tex)
  end
  local type = self.selectSkill.type
  if type == SeasonTalentSkillType.Passive then
    self._preCost.gameObject:SetActive(true)
    local idx, preList = self.skillData:GetSkillIdxAndPreSkill(rootid)
    if idx == 1 then
      self._preCost.gameObject:SetActive(false)
    else
      self._preCost.gameObject:SetActive(true)
      local allCost = 0
      for index, prerootid in ipairs(preList) do
        local tempCost = self.skillData:GetSkillCostCount(prerootid, SeasonTalentSkillType.Passive)
        allCost = allCost + tempCost
      end
      local needCost = cfg.NeedCost
      if not needCost then
        Log.error("###[UISeasonTalentTreeInfoItem] 错误,needCost 为空，rootid:", rootid)
      end
      local allCostStr
      if allCost >= needCost then
        allCostStr = allCost
      else
        allCostStr = "<color=#ff5656>" .. allCost .. "</color>"
        self._buyCostEnough = false
      end
      local preNumber = allCostStr .. "/" .. needCost
      local tips = StringTable.Get("str_season_talent_tree_skil_info_pre", preNumber)
      self._preCost:SetText(tips)
    end
  else
    self._preCost.gameObject:SetActive(false)
  end
end

function UISeasonTalentTreeInfoItem:ShowUpLv()
  local level = self.selectSkill.level
  local rootid = self.selectSkill.rootid
  local cfgs = Cfg.cfg_component_talent_tree_skill({
    ComponentID = self.comCfgID,
    SkillTypeID = rootid
  })
  local maxLevel = #cfgs
  self._maxLv:SetActive(level >= maxLevel)
  self._upBtn:SetActive(level < maxLevel)
  if self.selectSkill.type == SeasonTalentSkillType.Passive and level >= maxLevel then
    self._effGo:SetActive(true)
  else
    self._effGo:SetActive(false)
  end
  if level < maxLevel then
    local cfgs2 = Cfg.cfg_component_talent_tree_skill({
      ComponentID = self.comCfgID,
      SkillTypeID = rootid,
      Level = level + 1
    })
    local cfg = cfgs2[1]
    local tex
    if self.selectSkill:Enough() then
      tex = "<color=#f2f0ff>" .. cfg.UpgradeCost .. "</color>"
    else
      tex = "<color=#ff5656>" .. cfg.UpgradeCost .. "</color>"
    end
    self._upCost:SetText(tex)
  end
end

function UISeasonTalentTreeInfoItem:UpBtnOnClick(go)
  if not self.selectSkill:Enough() then
    local tips = StringTable.Get("str_season_talent_tree_info_not_enough")
    ToastManager.ShowToast(tips)
    return
  end
  self._anim:Stop()
  self._anim:Play("uianim_UISeasonTalentTree_Info_upgrade")
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEvent(200, function()
    if self.upCallback then
      self.upCallback()
    end
  end)
end

function UISeasonTalentTreeInfoItem:BuyBtnOnClick(go)
  if not self._buyCostEnough then
    local tips = StringTable.Get("str_season_talent_tree_pre_cost")
    ToastManager.ShowToast(tips)
    return
  end
  if not self.selectSkill:Enough() then
    local tips = StringTable.Get("str_season_talent_tree_info_not_enough")
    ToastManager.ShowToast(tips)
    return
  end
  self._anim:Stop()
  self._anim:Play("uianim_UISeasonTalentTree_Info_upgrade")
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEvent(200, function()
    if self.buyCallback then
      self.buyCallback()
    end
  end)
end
