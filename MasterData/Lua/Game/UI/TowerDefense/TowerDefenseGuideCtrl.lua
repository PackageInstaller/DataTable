local TowerDefenseGuideCtrl = class("TowerDefenseGuideCtrl", BaseCtrl)
TowerDefenseGuideCtrl._mapNodeConfig = {
  anim = {sNodeName = "Root", sComponentName = "Animator"},
  txt_Guide_window = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Guide"
  },
  txt_sv_char = {sComponentName = "TMP_Text"},
  txt_sv_item = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Title_Item"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  list_content = {
    sComponentName = "RectTransform"
  },
  temp_grid_char = {},
  char_content = {},
  char_detail = {},
  selected_char_list = {},
  txt_sv_selected_char = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_TeamEditor_SelectedChar"
  },
  selected_char_content = {},
  txtTitle_skill = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Guide_Skill"
  },
  txtTitle_potential = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Guide_Potential"
  },
  skill = {nCount = 2},
  PotentialItem = {nCount = 4},
  temp_grid_item = {},
  item_content = {},
  item_detail = {},
  txt_itemName = {sComponentName = "TMP_Text"},
  txt_itemCD = {sComponentName = "TMP_Text"},
  txt_des = {sComponentName = "TMP_Text"},
  btnAllClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  }
}
TowerDefenseGuideCtrl._mapEventConfig = {
  TowerDefenseGuideCellOnSelected = "OnEvent_CellOnSelected"
}
TowerDefenseGuideCtrl._mapRedDotConfig = {}
local SelectType = {Char = 1, Item = 2}

function TowerDefenseGuideCtrl:SetData(nActId, tbCharGuideIds)
  self._mapNode.anim:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self.tbSelectCharIds = tbCharGuideIds
  if self.tbSelectCharIds == nil then
    NovaAPI.SetTMPText(self._mapNode.txt_sv_char, ConfigTable.GetUIText("TowerDef_TeamEditor_Char"))
  else
    NovaAPI.SetTMPText(self._mapNode.txt_sv_char, ConfigTable.GetUIText("TowerDef_UnSelect_Char"))
  end
  self._mapNode.selected_char_list:SetActive(self.tbSelectCharIds ~= nil and #self.tbSelectCharIds > 0)
  self.tbCharacterIds = {}
  self.tbItemIds = {}
  self.nActId = nActId
  self.selectedGridGo = nil
  self.TowerDefenseData = PlayerData.Activity:GetActivityDataById(self.nActId)
  
  local function forEachFunction(config)
    if config.ActivityId == nActId and config.IsShow then
      if config.GuideType == GameEnum.TowerDefGuideType.Character and (self.tbSelectCharIds == nil or table.indexof(self.tbSelectCharIds, config.Id) <= 0) then
        table.insert(self.tbCharacterIds, config.Id)
      elseif config.GuideType == GameEnum.TowerDefGuideType.Item then
        table.insert(self.tbItemIds, config.Id)
      end
    end
  end
  
  ForEachTableLine(DataTable.TowerDefenseGuide, forEachFunction)
  
  local function sortFunction(a, b)
    local config_a = ConfigTable.GetData("TowerDefenseGuide", a)
    local config_b = ConfigTable.GetData("TowerDefenseGuide", b)
    local bUnlock_a = self.TowerDefenseData:IsLevelUnlock(config_a.LevelId) and self.TowerDefenseData:IsPreLevelPass(config_a.LevelId)
    local bUnlock_b = self.TowerDefenseData:IsLevelUnlock(config_b.LevelId) and self.TowerDefenseData:IsPreLevelPass(config_b.LevelId)
    if bUnlock_a and not bUnlock_b then
      return true
    elseif bUnlock_b and not bUnlock_a then
      return false
    else
      return a < b
    end
  end
  
  table.sort(self.tbCharacterIds, sortFunction)
  table.sort(self.tbItemIds, sortFunction)
  self._mapNode.list_content.gameObject:SetActive(false)
  local selectCharIndex, selectCharFirstaGo = self:CreateSelectedChar()
  local charIndex, charFirstaGo = self:CreateChar()
  local itemIndex, itemFirstaGo = self:CreateItem()
  self._mapNode.list_content.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self.tbSelectCharIds ~= nil then
      CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.selected_char_content:GetComponent("RectTransform"))
    end
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.char_content:GetComponent("RectTransform"))
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.item_content:GetComponent("RectTransform"))
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.list_content)
  end
  
  cs_coroutine.start(wait)
  if selectCharFirstaGo ~= nil then
    EventManager.Hit("TowerDefenseGuideCellOnSelected", self.tbSelectCharIds[selectCharIndex], SelectType.Char, selectCharFirstaGo)
  elseif charFirstaGo ~= nil then
    EventManager.Hit("TowerDefenseGuideCellOnSelected", self.tbCharacterIds[charIndex], SelectType.Char, charFirstaGo)
  elseif itemFirstaGo ~= nil then
    EventManager.Hit("TowerDefenseGuideCellOnSelected", self.tbItemIds[itemIndex], SelectType.Item, itemFirstaGo)
  end
end

function TowerDefenseGuideCtrl:CreateSelectedChar()
  delChildren(self._mapNode.selected_char_content.transform)
  local firstGo
  local firstIndex = 0
  if self.tbSelectCharIds == nil then
    return 0, nil
  end
  for index, guideId in ipairs(self.tbSelectCharIds) do
    local guide_config = ConfigTable.GetData("TowerDefenseGuide", guideId)
    local charId = guide_config.ObjectId
    local config = ConfigTable.GetData("TowerDefenseCharacter", charId)
    if config ~= nil then
      local go = instantiate(self._mapNode.temp_grid_char, self._mapNode.selected_char_content.transform)
      go.name = charId
      local btn = go.transform:Find("btn_grid"):GetComponent("UIButton")
      local icon = go.transform:Find("btn_grid/AnimRoot/img_icon/icon_char"):GetComponent("Image")
      local lock = go.transform:Find("btn_grid/AnimRoot/img_icon/bg_Lock")
      local txt_name = go.transform:Find("btn_grid/AnimRoot/img_icon/txt_name"):GetComponent("TMP_Text")
      local txt_new = go.transform:Find("btn_grid/AnimRoot/img_icon/txt_new"):GetComponent("TMP_Text")
      if guide_config.Str == "" then
        txt_new.gameObject:SetActive(false)
      else
        txt_new.gameObject:SetActive(true)
        NovaAPI.SetTMPText(txt_new, guide_config.Str)
      end
      local bUnLock = true
      if guide_config ~= nil then
        bUnLock = self.TowerDefenseData:IsLevelUnlock(guide_config.LevelId) and self.TowerDefenseData:IsPreLevelPass(guide_config.LevelId)
      end
      if not bUnLock then
        lock.gameObject:SetActive(true)
        NovaAPI.SetTMPText(txt_name, ConfigTable.GetUIText("TowerDef_Lock"))
        btn.onClick:AddListener(function()
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TowerDef_LockTip"))
        end)
      else
        local i = index
        lock.gameObject:SetActive(false)
        self:SetPngSprite(icon, config.Icon .. AllEnum.CharHeadIconSurfix.QM)
        NovaAPI.SetTMPText(txt_name, config.Name)
        btn.onClick:AddListener(function()
          EventManager.Hit("TowerDefenseGuideCellOnSelected", self.tbSelectCharIds[i], SelectType.Char, go)
        end)
      end
      go:SetActive(true)
      if firstGo == nil then
        firstGo = go
        firstIndex = index
      end
    end
  end
  return firstIndex, firstGo
end

function TowerDefenseGuideCtrl:CreateChar()
  delChildren(self._mapNode.char_content.transform)
  local firstGo
  local firstIndex = 0
  for index, guideId in ipairs(self.tbCharacterIds) do
    local guide_config = ConfigTable.GetData("TowerDefenseGuide", guideId)
    local charId = guide_config.ObjectId
    local config = ConfigTable.GetData("TowerDefenseCharacter", charId)
    if config ~= nil then
      local go = instantiate(self._mapNode.temp_grid_char, self._mapNode.char_content.transform)
      go.name = charId
      local btn = go.transform:Find("btn_grid"):GetComponent("UIButton")
      local icon = go.transform:Find("btn_grid/AnimRoot/img_icon/icon_char"):GetComponent("Image")
      local lock = go.transform:Find("btn_grid/AnimRoot/img_icon/bg_Lock")
      local txt_name = go.transform:Find("btn_grid/AnimRoot/img_icon/txt_name"):GetComponent("TMP_Text")
      local txt_new = go.transform:Find("btn_grid/AnimRoot/img_icon/txt_new"):GetComponent("TMP_Text")
      if guide_config.Str == "" then
        txt_new.gameObject:SetActive(false)
      else
        txt_new.gameObject:SetActive(true)
        NovaAPI.SetTMPText(txt_new, guide_config.Str)
      end
      local bUnLock = true
      if guide_config ~= nil then
        bUnLock = self.TowerDefenseData:IsLevelUnlock(guide_config.LevelId) and self.TowerDefenseData:IsPreLevelPass(guide_config.LevelId)
      end
      if not bUnLock then
        lock.gameObject:SetActive(true)
        NovaAPI.SetTMPText(txt_name, ConfigTable.GetUIText("TowerDef_Lock"))
        btn.onClick:AddListener(function()
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TowerDef_LockTip"))
        end)
      else
        local i = index
        lock.gameObject:SetActive(false)
        self:SetPngSprite(icon, config.Icon .. AllEnum.CharHeadIconSurfix.QM)
        NovaAPI.SetTMPText(txt_name, config.Name)
        btn.onClick:AddListener(function()
          EventManager.Hit("TowerDefenseGuideCellOnSelected", self.tbCharacterIds[i], SelectType.Char, go)
        end)
      end
      go:SetActive(true)
      if firstGo == nil then
        firstGo = go
        firstIndex = index
      end
    end
  end
  return firstIndex, firstGo
end

function TowerDefenseGuideCtrl:CreateItem()
  delChildren(self._mapNode.item_content.transform)
  local firstGo
  local firstIndex = 0
  for index, guideId in ipairs(self.tbItemIds) do
    local guide_config = ConfigTable.GetData("TowerDefenseGuide", guideId)
    local itemId = guide_config.ObjectId
    local config = ConfigTable.GetData("TowerDefenseItem", itemId)
    if config ~= nil then
      local go = instantiate(self._mapNode.temp_grid_item, self._mapNode.item_content.transform)
      go.name = itemId
      local btn = go.transform:Find("btn_grid"):GetComponent("UIButton")
      local icon = go.transform:Find("btn_grid/AnimRoot/img_icon"):GetComponent("Image")
      local lock = go.transform:Find("btn_grid/AnimRoot/bg_Lock")
      local txt_lock = go.transform:Find("btn_grid/AnimRoot/txt_lock"):GetComponent("TMP_Text")
      local txt_new = go.transform:Find("btn_grid/AnimRoot/txt_new"):GetComponent("TMP_Text")
      if guide_config.Str == "" then
        txt_new.gameObject:SetActive(false)
      else
        txt_new.gameObject:SetActive(true)
        NovaAPI.SetTMPText(txt_new, guide_config.Str)
      end
      local bUnLock = true
      if guide_config ~= nil then
        bUnLock = self.TowerDefenseData:IsLevelUnlock(guide_config.LevelId) and self.TowerDefenseData:IsPreLevelPass(guide_config.LevelId)
      end
      if not bUnLock then
        lock.gameObject:SetActive(true)
        txt_lock.gameObject:SetActive(true)
        NovaAPI.SetTMPText(txt_lock, ConfigTable.GetUIText("TowerDef_Lock"))
        btn.onClick:AddListener(function()
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TowerDef_LockTip"))
        end)
      else
        local i = index
        lock.gameObject:SetActive(false)
        txt_lock.gameObject:SetActive(false)
        self:SetPngSprite(icon, config.CardIcon)
        btn.onClick:AddListener(function()
          EventManager.Hit("TowerDefenseGuideCellOnSelected", self.tbItemIds[i], SelectType.Item, go)
        end)
      end
      go:SetActive(true)
      if firstGo == nil then
        firstGo = go
        firstIndex = index
      end
    end
  end
  return firstIndex, firstGo
end

function TowerDefenseGuideCtrl:UpdateDetail()
  self._mapNode.char_detail:SetActive(false)
  self._mapNode.item_detail:SetActive(false)
  if self.SelectedType == SelectType.Char then
    local charId = ConfigTable.GetData("TowerDefenseGuide", self.nSelectedId).ObjectId
    local config = ConfigTable.GetData("TowerDefenseCharacter", charId)
    if config == nil then
      return
    end
    local skill1 = self._mapNode.skill[1]
    local icon1 = skill1.transform:Find("AnimRoot/imgIcon"):GetComponent("Image")
    local skill1_bg1 = skill1.transform:Find("AnimRoot/imgBg1"):GetComponent("Image")
    local skill1_bg2 = skill1.transform:Find("AnimRoot/imgBg2"):GetComponent("Image")
    local skill1_type = skill1.transform:Find("AnimRoot/imgType")
    local btn1 = skill1:GetComponent("UIButton")
    btn1.onClick:RemoveAllListeners()
    local skillConfig = ConfigTable.GetData("Skill", config.SkillId)
    if skillConfig ~= nil then
      if skillConfig.Icon ~= "" then
        self:SetPngSprite(icon1, skillConfig.Icon)
      end
      self:SetAtlasSprite(skill1_type:GetComponent("Image"), "05_language", "zs_character_skill_text_" .. skillConfig.Type)
      btn1.onClick:AddListener(function()
        EventManager.Hit(EventId.OpenPanel, PanelId.TowerDefenseTipsPanel, btn1.gameObject, skillConfig.Title, skillConfig.Desc)
      end)
    end
    local skill2 = self._mapNode.skill[2]
    local icon2 = skill2.transform:Find("AnimRoot/imgIcon"):GetComponent("Image")
    local skill2_bg1 = skill2.transform:Find("AnimRoot/imgBg1"):GetComponent("Image")
    local skill2_bg2 = skill2.transform:Find("AnimRoot/imgBg2"):GetComponent("Image")
    local skill2_type = skill2.transform:Find("AnimRoot/imgType")
    local atkSkillConfig = ConfigTable.GetData("Skill", config.NormalAtkId)
    local btn2 = skill2:GetComponent("UIButton")
    btn2.onClick:RemoveAllListeners()
    if atkSkillConfig ~= nil then
      if atkSkillConfig.Icon ~= "" then
        self:SetPngSprite(icon2, atkSkillConfig.Icon)
      end
      self:SetAtlasSprite(skill2_type:GetComponent("Image"), "05_language", "zs_character_skill_text_" .. atkSkillConfig.Type)
      btn2.onClick:AddListener(function()
        EventManager.Hit(EventId.OpenPanel, PanelId.TowerDefenseTipsPanel, btn2.gameObject, atkSkillConfig.Title, atkSkillConfig.Desc)
      end)
    end
    local EETConfig = ConfigTable.GetData("MonsterValueTempleteAdjust", config.Templete)
    if EETConfig ~= nil then
      local sName = AllEnum.ElementIconType.SkillEx .. EETConfig.EET
      self:SetAtlasSprite(skill1_bg1, "12_rare", sName)
      self:SetAtlasSprite(skill2_bg1, "12_rare", sName)
      local _, color = ColorUtility.TryParseHtmlString(AllEnum.SkillElementBgColor[EETConfig.EET])
      NovaAPI.SetImageColor(skill1_bg2, Color(color.r, color.g, color.b, 0.2980392156862745))
      NovaAPI.SetImageColor(skill2_bg2, Color(color.r, color.g, color.b, 0.2980392156862745))
    end
    local tbPotential = {}
    for _, value in ipairs(config.NewPotential6) do
      table.insert(tbPotential, value)
    end
    for _, value in ipairs(config.NewPotential4) do
      table.insert(tbPotential, value)
    end
    for _, potentialItem in pairs(self._mapNode.PotentialItem) do
      potentialItem:SetActive(false)
    end
    for index, value in ipairs(tbPotential) do
      local potential_config = ConfigTable.GetData("TowerDefensePotential", value)
      if potential_config ~= nil then
        local go = self._mapNode.PotentialItem[index]
        local normal = go.transform:Find("btnItem/AnimRoot/goNormal")
        local special = go.transform:Find("btnItem/AnimRoot/goSpecial")
        normal.gameObject:SetActive(false)
        special.gameObject:SetActive(false)
        if potential_config.Rarity == GameEnum.itemRarity.SSR then
          local icon = special.transform:Find("imgSpIcon"):GetComponent("Image")
          self:SetPngSprite(icon, potential_config.Icon .. AllEnum.PotentialIconSurfix.A)
          special.gameObject:SetActive(true)
        elseif potential_config.Rarity == GameEnum.itemRarity.SR then
          local icon = normal.transform:Find("goInfo/imgIcon1"):GetComponent("Image")
          self:SetPngSprite(icon, potential_config.Icon .. AllEnum.PotentialIconSurfix.A)
          normal.gameObject:SetActive(true)
        end
        local btn = go.transform:Find("btnItem"):GetComponent("UIButton")
        btn.onClick:RemoveAllListeners()
        btn.onClick:AddListener(function()
          EventManager.Hit(EventId.OpenPanel, PanelId.TowerDefenseTipsPanel, go.gameObject, potential_config.Name, potential_config.PotentialDes)
        end)
        go:SetActive(true)
      end
    end
    self._mapNode.char_detail:SetActive(true)
  elseif self.SelectedType == SelectType.Item then
    local itemId = ConfigTable.GetData("TowerDefenseGuide", self.nSelectedId).ObjectId
    local config = ConfigTable.GetData("TowerDefenseItem", itemId)
    if config == nil then
      return
    end
    NovaAPI.SetTMPText(self._mapNode.txt_itemName, config.Name)
    NovaAPI.SetTMPText(self._mapNode.txt_itemCD, config.ItemTips)
    NovaAPI.SetTMPText(self._mapNode.txt_des, config.Des)
    self._mapNode.item_detail:SetActive(true)
  end
end

function TowerDefenseGuideCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self._mapNode.anim:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    self.selectedGridGo = nil
    EventManager.Hit("CloseTowerDefenseGuidePanel")
  end, true, true, true)
end

function TowerDefenseGuideCtrl:OnEvent_CellOnSelected(nSelectedId, nType, go)
  if self.selectedGridGo ~= nil then
    local selected = self.selectedGridGo.transform:Find("btn_grid/AnimRoot/go_select")
    selected.gameObject:SetActive(false)
  end
  self.selectedGridGo = go
  local selected = self.selectedGridGo.transform:Find("btn_grid/AnimRoot/go_select")
  selected.gameObject:SetActive(true)
  self.nSelectedId = nSelectedId
  self.SelectedType = nType
  self:UpdateDetail()
end

return TowerDefenseGuideCtrl
