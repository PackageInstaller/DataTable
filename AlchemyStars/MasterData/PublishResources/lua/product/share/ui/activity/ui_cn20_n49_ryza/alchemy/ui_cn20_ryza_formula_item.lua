_class("UICN20RyzaFormulaItem", UICustomWidget)
UICN20RyzaFormulaItem = UICN20RyzaFormulaItem

function UICN20RyzaFormulaItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN20RyzaFormulaItem:InitWidget()
  self.selectbg = self:GetUIComponent("Image", "selectbg")
  self.bg = self:GetUIComponent("Image", "bg")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.quilaty = self:GetUIComponent("Image", "quilaty")
  self.nameText = self:GetUIComponent("UILocalizationText", "NameText")
  self.canCountText = self:GetUIComponent("UILocalizationText", "CanCountText")
  self.moneyText = self:GetUIComponent("UILocalizationText", "moneyText")
  self.canvasGroup = self:GetUIComponent("CanvasGroup", "bg")
  self.singleMoneyText = self:GetUIComponent("UILocalizationText", "SingleMoneyText")
  self._atlas = self:GetAsset("UICN20N49.spriteatlas", LoadType.SpriteAtlas)
end

function UICN20RyzaFormulaItem:SetData(formulaCfg, select_cb, index)
  self.formulaCfg = formulaCfg
  self.select_cb = select_cb
  self.index = index
  self.itemModule = GameGlobal.GetModule(ItemModule)
  local itemId = self.formulaCfg.ID
  local itemCfg = Cfg.cfg_item[itemId]
  if not itemCfg then
    Log.error("itemCfg IS NIL", itemId)
    return
  end
  self._cfg_item = itemCfg
  local alchemyCfgs = Cfg.cfg_component_alchemy_item({FormulaID = itemId})
  if not alchemyCfgs then
    Log.error("alchemyCfgs IS NIL", itemId)
    return
  end
  if #alchemyCfgs == 0 then
    Log.error("alchemyCfg IS zero", itemId)
    return
  end
  local firstAlchemyCfg = alchemyCfgs[1]
  self.makeAlchemyCfg = firstAlchemyCfg
  self.selectbg.gameObject:SetActive(false)
  self.canvasGroup.alpha = 1
  self.singleMoneyText.color = Color(0.384, 0.266, 0.054)
  self.moneyText.color = Color(0.384, 0.266, 0.054)
  local ALitemCfg = Cfg.cfg_item[self.makeAlchemyCfg.ID]
  if not ALitemCfg then
    Log.error("ALitemCfg matCfg IS NIL", self.makeAlchemyCfg.ID)
  end
  local icon = ALitemCfg.Icon
  self.icon:LoadImage(icon)
  local AlchitemCfg = Cfg.cfg_item[firstAlchemyCfg.ID]
  if not AlchitemCfg then
    Log.error("AlchitemCfg IS NIL", firstAlchemyCfg.ID)
    return
  end
  local name = StringTable.Get(AlchitemCfg.Name)
  self.nameText:SetText(name)
  local color = firstAlchemyCfg.Quality
  if color == 3 then
    self.quilaty.sprite = self._atlas:GetSprite("cn20_ljdp_gezi05_01")
  elseif color == 4 then
    self.quilaty.sprite = self._atlas:GetSprite("cn20_ljdp_gezi04_01")
  elseif color == 5 then
    self.quilaty.sprite = self._atlas:GetSprite("cn20_ljdp_gezi03_01")
  else
    self.quilaty.sprite = self._atlas:GetSprite("cn20_ljdp_gezi01_01")
  end
  self.mats = self.formulaCfg.Materials
  self.moneyText:SetText("00" .. firstAlchemyCfg.Price)
  self:CalcuCanCount()
end

function UICN20RyzaFormulaItem:GetCanMakeCount()
  return self.canCount
end

function UICN20RyzaFormulaItem:GetCanMakeItemId()
  return self.makeAlchemyCfg.ID
end

function UICN20RyzaFormulaItem:CalcuCanCount()
  local matList = {}
  for i = 1, #self.mats do
    if matList[self.mats[i]] ~= nil then
      matList[self.mats[i]] = matList[self.mats[i]] + 1
    else
      matList[self.mats[i]] = 1
    end
  end
  local canCount = 0
  local matCanCountList = {}
  for itemid, singleCount in pairs(matList) do
    local canUseCount = self.itemModule:GetItemCount(itemid)
    local singleMatCanCount = math.floor(canUseCount / singleCount)
    if singleMatCanCount == nil then
      singleMatCanCount = 0
    end
    matCanCountList[#matCanCountList + 1] = singleMatCanCount
  end
  canCount = matCanCountList[1]
  for i = 2, #matCanCountList do
    if canCount > matCanCountList[i] then
      canCount = matCanCountList[i]
    end
  end
  if 0 < canCount then
    self.canCountText:SetText(StringTable.Get("str_cn20_ryza_can_formula", canCount))
  else
    self.canCountText:SetText(StringTable.Get("str_cn20_ryza_uncan_formula"))
  end
  self.canCount = canCount
end

function UICN20RyzaFormulaItem:SetUnSelect()
  self:CalcuCanCount()
  self.canvasGroup.alpha = 0.5
  self.singleMoneyText.color = Color(0.384, 0.266, 0.054)
  self.moneyText.color = Color(0.384, 0.266, 0.054)
  self.selectbg.gameObject:SetActive(false)
end

function UICN20RyzaFormulaItem:SetSelect()
  self.canvasGroup.alpha = 1
  self.singleMoneyText.color = Color(0.917, 0.89, 0.815)
  self.moneyText.color = Color(0.917, 0.89, 0.815)
  self.selectbg.gameObject:SetActive(true)
  self:CalcuCanCount()
end

function UICN20RyzaFormulaItem:BgOnClick(go)
  self.canvasGroup.alpha = 1
  self.singleMoneyText.color = Color(0.917, 0.89, 0.815)
  self.moneyText.color = Color(0.917, 0.89, 0.815)
  self.selectbg.gameObject:SetActive(true)
  if self.select_cb then
    self.select_cb(self.index)
  end
  self:CalcuCanCount()
end
