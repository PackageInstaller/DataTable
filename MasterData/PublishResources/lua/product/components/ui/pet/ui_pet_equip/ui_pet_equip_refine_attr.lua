_class("UIPetEquipRefineAttr", UICustomWidget)
UIPetEquipRefineAttr = UIPetEquipRefineAttr

function UIPetEquipRefineAttr:OnShow(uiParams)
  self:InitWidget()
end

function UIPetEquipRefineAttr:InitWidget()
  self.attackGo = self:GetGameObject("attackGo")
  self.line1Go = self:GetGameObject("line1Go")
  self.defenseGo = self:GetGameObject("defenseGo")
  self.line2Go = self:GetGameObject("line2Go")
  self.lifeGo = self:GetGameObject("lifeGo")
  self.attackBaseTxt = self:GetUIComponent("UILocalizationText", "attackBaseTxt")
  self.attackLvTxt = self:GetUIComponent("UILocalizationText", "attackLvTxt")
  self.defenseBaseTxt = self:GetUIComponent("UILocalizationText", "defenseBaseTxt")
  self.defenseLvTxt = self:GetUIComponent("UILocalizationText", "defenseLvTxt")
  self.lifeBaseTxt = self:GetUIComponent("UILocalizationText", "lifeBaseTxt")
  self.lifeLvTxt = self:GetUIComponent("UILocalizationText", "lifeLvTxt")
end

function UIPetEquipRefineAttr:SetData(petTemplateId, petLv)
  local cfg = UIPetEquipHelper.GetRefineCfg(petTemplateId, petLv)
  if not cfg then
    return
  end
  local preAttack = 0
  local preDefense = 0
  local preHp = 0
  if 1 < petLv then
    local preCfg = UIPetEquipHelper.GetRefineCfg(petTemplateId, petLv - 1)
    if preCfg then
      preAttack = preCfg.Attack
      preDefense = preCfg.Defence
      preHp = preCfg.Health
    end
  end
  local attack, defense, life
  if preAttack < cfg.Attack then
    attack = {}
    attack.base = preAttack
    attack.up = cfg.Attack
  end
  if preDefense < cfg.Defence then
    defense = {}
    defense.base = preDefense
    defense.up = cfg.Defence
  end
  if preHp < cfg.Health then
    life = {}
    life.base = preHp
    life.up = cfg.Health
  end
  self:_Refresh(attack, defense, life)
end

function UIPetEquipRefineAttr:_Refresh(attack, defense, life)
  self.attackGo:SetActive(attack ~= nil)
  self.line1Go:SetActive(attack ~= nil and (defense ~= nil or life ~= nil))
  if attack then
    self.attackBaseTxt:SetText("+" .. attack.base)
    self.attackLvTxt:SetText("+" .. attack.up - attack.base)
  end
  self.defenseGo:SetActive(defense ~= nil)
  self.line2Go:SetActive(defense ~= nil and life ~= nil)
  if defense then
    self.defenseBaseTxt:SetText("+" .. defense.base)
    self.defenseLvTxt:SetText("+" .. defense.up - defense.base)
  end
  self.lifeGo:SetActive(life ~= nil)
  if life then
    self.lifeBaseTxt:SetText("+" .. life.base)
    self.lifeLvTxt:SetText("+" .. life.up - life.base)
  end
end
