local UICCRProductionItem = class("UICCRProductionItem", UIBaseNode)
local base = UIBaseNode

function UICCRProductionItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UICCRProductionItem:InitProductionItem(buildId, resData)
  self.buildId = buildId
  self:__ShowUI(resData.id, resData.name)
  self:UpdateProductionInfo(resData)
end

function UICCRProductionItem:__ShowUI(itemId, strName)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("Can't Find ItemCfg By ID:" .. itemId)
    return
  end
  self.ui.img_Icon.sprite = CRH:GetSprite(itemCfg.small_icon)
  self.ui.tex_Name.text = strName
  local lineColor = ItemQualityColor[itemCfg.quality]
  self.ui.img_Period.color = lineColor
  self.ui.img_Rate.color = Color.New(lineColor.r, lineColor.g, lineColor.b, 0.2)
end

function UICCRProductionItem:UpdateProductionInfo(resData)
  local speed = resData.speed
  local effSpeed = resData.effSpeed
  local countMax = resData.countMax
  self.ui.img_Period.fillAmount = resData.progress
  local count = resData.count
  self.ui.img_Rate.fillAmount = count / countMax
  self.ui.tex_Cur.text = tostring(count)
  self.ui.tex_Total:SetIndex(0, tostring(countMax))
  local hourSpeed = (speed + effSpeed) * 36
  self.ui.tex_Speed:SetIndex(0, tostring(hourSpeed))
end

function UICCRProductionItem:GetRingUI()
  return self.ui.img_Rate
end

function UICCRProductionItem:OnDelete()
  base.OnDelete(self)
end

return UICCRProductionItem
