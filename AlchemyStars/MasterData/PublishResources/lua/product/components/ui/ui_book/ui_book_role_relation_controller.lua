_class("UIBookRoleRelationController", UIController)
UIBookRoleRelationController = UIBookRoleRelationController

function UIBookRoleRelationController:Constructor()
end

function UIBookRoleRelationController:OnShow(uiParams)
  self.id = uiParams[1]
  local module = self:GetModule(BookModule)
  local cfg = Cfg.cfg_pet_tags[self.id]
  self.bookRoleType = cfg.BookType
  local data = module:GetResBookData(self.id)
  self.dataDic = {}
  self.dataDic.mult = {}
  self.dataDic.sing = {}
  local cv = Cfg.cfg_pet_tags[self.id]
  if cv.BookType == BookRoleType.Pet then
    local monsters = module:GetMonsterData()
    for index, friendId in ipairs(cfg.OwnFriendGroup) do
      local dataList = {}
      for key, value in pairs(data[friendId]) do
        dataList[key] = value
      end
      for key, value in pairs(monsters[friendId]) do
        dataList[key] = value
      end
      self.dataDic.mult[friendId] = dataList
    end
    for index, friendId in ipairs(cfg.AloneGroup) do
      local dataList = {}
      for key, value in pairs(data[friendId]) do
        dataList[key] = value
      end
      for key, value in pairs(monsters[friendId]) do
        dataList[key] = value
      end
      self.dataDic.sing[friendId] = dataList
    end
  else
    for index, friendId in ipairs(cfg.OwnFriendGroup) do
      self.dataDic.mult[friendId] = data[friendId]
    end
    for index, friendId in ipairs(cfg.AloneGroup) do
      self.dataDic.sing[friendId] = data[friendId]
    end
  end
  self.zhuangshiImg = self:GetUIComponent("Image", "zhuanshi")
  self.bgImg = self:GetUIComponent("RawImageLoader", "bg")
  self.bgGO = self:GetGameObject("bg")
  self.bgGO:SetActive(true)
  self.bg2GO = self:GetGameObject("bg2")
  self.bg2GO:SetActive(true)
  self.noCampGO = self:GetGameObject("nocamp")
  self.picImg = self:GetUIComponent("Image", "pic")
  self.nameTxt = self:GetUIComponent("UILocalizationText", "title")
  self.descTxt = self:GetUIComponent("UILocalizationText", "desc")
  self.content = self:GetUIComponent("UISelectObjectPath", "content")
  local count = table.count(self.dataDic.mult) + table.count(self.dataDic.sing)
  self.content:SpawnObjects("UIBookRoleRelationCell", count)
  local items = self.content:GetAllSpawnList()
  local index = 1
  for _, cell in pairs(items) do
    self:InitCell(cell, index)
    index = index + 1
  end
  local topButton = self:GetUIComponent("UISelectObjectPath", "topbtn")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:CloseDialog()
  end)
  local cfg = Cfg.cfg_pet_tags[self.id]
  self.nameTxt:SetText(StringTable.Get(cfg.Name))
  self.descTxt:SetText(StringTable.Get(cfg.Desc))
  local atlas = self:GetAsset("UIBook.spriteatlas", LoadType.SpriteAtlas)
  self.picImg.sprite = atlas:GetSprite(cfg.RelationSpriteIcon)
  if self.id == PetFilterType.YouMin then
    self.noCampGO:SetActive(true)
  else
    self.noCampGO:SetActive(false)
  end
  self.zhuangshiImg.sprite = atlas:GetSprite(cfg.BookZhuangshi)
  self.bgImg:LoadImage(cfg.BookBg)
end

function UIBookRoleRelationController:OnHide()
end

function UIBookRoleRelationController:InitCell(cell, index)
  local cfg = Cfg.cfg_pet_tags[self.id]
  local tags = {}
  local idx = 1
  for i = 1, #cfg.OwnFriendGroup do
    tags[idx] = {}
    tags[idx].mult = true
    tags[idx].data = cfg.OwnFriendGroup[i]
    idx = idx + 1
  end
  for i = 1, #cfg.AloneGroup do
    tags[idx] = {}
    tags[idx].mult = false
    tags[idx].data = cfg.AloneGroup[i]
    idx = idx + 1
  end
  local friendType = tags[index].data
  local multOrSing = tags[index].mult
  local data
  if multOrSing then
    data = self.dataDic.mult[friendType]
  else
    data = self.dataDic.sing[friendType]
  end
  cell:Refresh(self.bookRoleType, friendType, data, multOrSing, self.id)
end
