_class("UICN20MakeSucItem", UICustomWidget)
UICN20MakeSucItem = UICN20MakeSucItem

function UICN20MakeSucItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN20MakeSucItem:InitWidget()
  self.itemIcon = self:GetUIComponent("RawImageLoader", "icon")
  self.quilaty = self:GetUIComponent("Image", "quilaty")
  self.nameText = self:GetUIComponent("UILocalizationText", "NameText")
  self.moneyText = self:GetUIComponent("UILocalizationText", "moneyText")
  self.makeNumText = self:GetUIComponent("UILocalizationText", "MakeNumText")
  self.skillText = self:GetUIComponent("UILocalizationText", "SkillText")
  self.canLevelTreeText = self:GetUIComponent("UILocalizationText", "CanLevelTreeText")
  self.root = self:GetGameObject("root")
  self._atlas = self:GetAsset("UICN20N49.spriteatlas", LoadType.SpriteAtlas)
  self.canLevel = self:GetGameObject("CanLevel")
end

function UICN20MakeSucItem:SetData(responese, quickCB, campaign)
  self.responese = responese
  self.quickCB = quickCB
  self.root:SetActive(true)
  self.makeItemID = self.responese.item_id
  local alchemyCfg = Cfg.cfg_component_alchemy_item[self.makeItemID]
  if alchemyCfg == nil then
    Log.error("alchemyCfg IS zero", self.makeItemID)
  end
  local itemCfg = Cfg.cfg_item[self.makeItemID]
  if not itemCfg then
    Log.error("itemCfg matCfg IS NIL", self.makeItemID)
  end
  self.nameText:SetText(StringTable.Get(itemCfg.Name))
  self.itemIcon:LoadImage(itemCfg.Icon)
  local color = alchemyCfg.Quality
  if color == 3 then
    self.quilaty.sprite = self._atlas:GetSprite("cn20_ljdp_gezi05_01")
  elseif color == 4 then
    self.quilaty.sprite = self._atlas:GetSprite("cn20_ljdp_gezi04_01")
  elseif color == 5 then
    self.quilaty.sprite = self._atlas:GetSprite("cn20_ljdp_gezi03_01")
  else
    self.quilaty.sprite = self._atlas:GetSprite("cn20_ljdp_gezi01_01")
  end
  self.moneyText:SetText("00" .. alchemyCfg.Price)
  self.makeNumText:SetText(StringTable.Get("str_cn20_ryza_make_num", self.responese.num))
  if self.responese.extra_cnt > 0 then
    self.skillText.gameObject:SetActive(true)
    self.skillText:SetText(StringTable.Get("str_cn20_ryza_skill_cast", self.responese.extra_cnt))
  else
    self.skillText.gameObject:SetActive(false)
  end
  local name = "talent"
  local num = self.responese.num + self.responese.extra_cnt
  local list = {}
  local data = {
    [1] = self.makeItemID,
    [2] = num
  }
  table.insert(list, data)
  local tree = UICN20N49Helper.CheckContainTalentTreeCost(campaign, list)
  if tree ~= nil and 0 < table.count(tree) then
    self.canLevel:SetActive(true)
  else
    self.canLevel:SetActive(false)
  end
end

function UICN20MakeSucItem:SetPopActive(active)
  self.root:SetActive(active)
end

function UICN20MakeSucItem:QuickBtnOnClick(go)
  if self.quickCB then
    self.quickCB()
  end
  self.root:SetActive(false)
end

function UICN20MakeSucItem:GotoTreeBtnOnClick(go)
  self:ShowDialog("UICN20N49TreeController")
end

function UICN20MakeSucItem:ClickBgOnClick(go)
end
