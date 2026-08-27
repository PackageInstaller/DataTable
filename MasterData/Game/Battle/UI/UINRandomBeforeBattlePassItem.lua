local UINRandomBeforeBattlePassItem = class("UINRandomBeforeBattlePassItem", UIBaseNode)
local base = UIBaseNode

function UINRandomBeforeBattlePassItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINRandomBeforeBattlePassItem:SetJudgeIcon(careerId)
  local careerCfg = ConfigData.career[careerId]
  if careerCfg == nil then
    error("careerCfg is nil, id:" .. careerId)
  end
  self.ui.image_pass.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
end

function UINRandomBeforeBattlePassItem:InitPassItem(isPass)
  self.isPass = isPass
  if isPass then
    self.ui.obj_pass:SetActive(true)
    self.ui.obj_notPass:SetActive(false)
  else
    self.ui.obj_pass:SetActive(false)
    self.ui.obj_notPass:SetActive(true)
  end
end

function UINRandomBeforeBattlePassItem:LuckPass()
  self.ui.text_luck:SetActive(true)
end

function UINRandomBeforeBattlePassItem:OnHide()
  self.ui.obj_pass:SetActive(false)
  self.ui.obj_notPass:SetActive(true)
end

function UINRandomBeforeBattlePassItem:OnDelete()
  base.OnDelete(self)
end

return UINRandomBeforeBattlePassItem
