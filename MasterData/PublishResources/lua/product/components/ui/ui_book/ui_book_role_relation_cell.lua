_class("UIBookRoleRelationCell", UICustomWidget)

function UIBookRoleRelationCell:OnShow()
  self.rect = self:GetGameObject().transform:GetComponent("RectTransform")
  self.bgRect = self:GetUIComponent("RectTransform", "bg")
  self.bg = self:GetUIComponent("Image", "yellowBg")
  self.nameTxt = self:GetUIComponent("UILocalizationText", "name")
  self.nameRect = self:GetUIComponent("RectTransform", "name")
  self.sopRole = self:GetUIComponent("UISelectObjectPath", "contentrole")
  self.sopMonster = self:GetUIComponent("UISelectObjectPath", "contentmonster")
  self.contentRoleGO = self:GetGameObject("contentrole")
  self.contentRoleGO:SetActive(false)
  self.contentMonsterGO = self:GetGameObject("contentmonster")
  self.contentMonsterGO:SetActive(false)
  self.btnInfoGO = self:GetGameObject("btninfo")
  self.nameGo = self:GetGameObject("name")
  self.yellowBgGo = self:GetGameObject("yellowBg")
  self.line1 = self:GetGameObject("line1")
  self.line2 = self:GetGameObject("line2")
end

function UIBookRoleRelationCell:OnHide()
end

function UIBookRoleRelationCell:Refresh(bookRoleType, friendType, data, multOrSing, shiLiTag)
  self.shiLiTag = shiLiTag
  self.friendTag = friendType
  self.bookRoleType = bookRoleType
  self.data = data
  local cfg = Cfg.cfg_pet_tags[friendType]
  if not cfg then
    return
  end
  local shiLiCfg = Cfg.cfg_pet_tags[shiLiTag]
  local atlas = self:GetAsset("UIBook.spriteatlas", LoadType.SpriteAtlas)
  self.bg.sprite = atlas:GetSprite(shiLiCfg.RelationTiaoSpriteIcon)
  self.nameTxt:SetText(StringTable.Get(cfg.Name))
  self:InitRoles()
  local firstKey = -1
  for key, value in pairs(self.data) do
    firstKey = key
    break
  end
  self.contentRoleGO:SetActive(true)
  self.contentMonsterGO:SetActive(false)
  self.line1:SetActive(multOrSing)
  self.line2:SetActive(not multOrSing)
  if multOrSing then
    local btnWidth = 207.1
    if Cfg.cfg_monster_class[firstKey] then
      self.btnInfoGO:SetActive(false)
      btnWidth = 0
    else
      self.btnInfoGO:SetActive(true)
    end
    self.nameGo:SetActive(true)
    self.yellowBgGo:SetActive(true)
    local count = table.count(self.data)
    local newCount = count <= 3 and 3 or 4
    local customWidth = newCount * 142 + (newCount - 1) * 36
    self.bgRect.sizeDelta = Vector2(customWidth, 70)
    self.rect.sizeDelta = Vector2(customWidth + 30, 630)
    local namePreOff = 27.8
    local nameOriWidth = 432.7
    local restNameRectWidth = customWidth - namePreOff - btnWidth
    if restNameRectWidth < 0 then
      restNameRectWidth = nameOriWidth
    end
    if nameOriWidth > restNameRectWidth then
      self.nameRect.sizeDelta = Vector2(restNameRectWidth, self.nameRect.sizeDelta.y)
    else
      self.nameRect.sizeDelta = Vector2(nameOriWidth, self.nameRect.sizeDelta.y)
    end
  else
    self.btnInfoGO:SetActive(false)
    self.nameGo:SetActive(false)
    self.yellowBgGo:SetActive(false)
    self.bgRect.sizeDelta = Vector2(170, 70)
    self.rect.sizeDelta = Vector2(170, 630)
  end
end

function UIBookRoleRelationCell:btninfoOnClick(go)
  self:ShowDialog("UIBookRoleRelationShowController", self.dataList, self.shiLiTag, self.friendTag)
end

function UIBookRoleRelationCell:OpenEnemy(monsterId)
  local enemys = {monsterId}
  if not enemys then
    ToastManager.ShowToast(StringTable.Get("str_toast_manager_no_enemy_info"))
    return
  end
  self:ShowDialog("UIEnemyBookTip", enemys)
end

function UIBookRoleRelationCell:btngoOnClick(go)
end

function UIBookRoleRelationCell:InitRoles()
  local sop
  self.dataList = {}
  local count = table.count(self.data)
  if self.bookRoleType == BookRoleType.Pet then
    sop = self.sopRole
    for key, value in pairs(self.data) do
      local data = {}
      if not Cfg.cfg_monster_class[key] then
        data.petTempId = key
        data.petPsdId = value
        data.sortId = Cfg.cfg_pet[key].BookSort
        data.isMonster = false
      else
        data.monsterClassId = key
        data.monsterId = value
        data.sortId = 1
        data.isMonster = true
      end
      table.insert(self.dataList, data)
    end
  elseif self.bookRoleType == BookRoleType.Monster then
    sop = self.sopRole
    for key, value in pairs(self.data) do
      local data = {}
      data.monsterClassId = key
      data.monsterId = value
      data.sortId = 1
      table.insert(self.dataList, data)
    end
  end
  table.sort(self.dataList, function(a, b)
    return a.sortId < b.sortId
  end)
  sop:SpawnObjects("UIBookRoleRelationRoleCell", count)
  local list = sop:GetAllSpawnList()
  for index = 1, #list do
    local cell = list[index]
    cell:SetClickCallBack(function(cell)
      if cell:IsActive() then
        if self.bookRoleType == BookRoleType.Pet then
          if cell.data.isMonster then
            self:OpenEnemy(cell.data.monsterId)
          else
            local pet = self:GetModule(PetModule):GetPet(cell.data.petPsdId)
            self:ShowDialog("UIPetIntimacyMainController", pet:GetTemplateID(), PetIntimacyWindowType.FilesPanel)
          end
        elseif self.bookRoleType == BookRoleType.Monster then
          self:OpenEnemy(cell.data.monsterId)
        end
      elseif self.bookRoleType == BookRoleType.Pet then
        if cell.data.isMonster then
          ToastManager.ShowToast(StringTable.Get("str_book_monster_dont_have"))
        else
          ToastManager.ShowToast(StringTable.Get("str_book_role_dont_have"))
        end
      elseif self.bookRoleType == BookRoleType.Monster then
        ToastManager.ShowToast(StringTable.Get("str_book_monster_dont_have"))
      end
    end)
    local showLine = false
    if index == #self.dataList then
      showLine = false
    else
      showLine = index % 4 ~= 0
    end
    cell:Refresh(self.bookRoleType, self.dataList[index], showLine, 4 < index)
  end
end
