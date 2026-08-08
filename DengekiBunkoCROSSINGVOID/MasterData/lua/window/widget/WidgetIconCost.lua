local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")

function SetData(cost, costType)
  if costType == nil then
    costType = PB.enum.ResourceType.ResPlayerMoney
  end
  local isEnough, bindCost, noBindCost = WU.IsEnoughMoney(cost, costType)
  if costType == PB.enum.ResourceType.ResPlayerPayMoney then
    REF.NoBindCost.gameObject:SetActive(true)
    REF.BindCost.gameObject:SetActive(false)
    REF.LabelCost.UIHtmlLabel.text = tostring(noBindCost)
  else
    if isEnough == true and 0 < noBindCost then
      REF.NoBindCost.gameObject:SetActive(true)
      REF.BindCost.gameObject:SetActive(true)
    else
      REF.NoBindCost.gameObject:SetActive(false)
      REF.BindCost.gameObject:SetActive(true)
    end
    REF.LabelCost.UIHtmlLabel.text = tostring(noBindCost)
    REF.LabelBindCost.UIHtmlLabel.text = tostring(bindCost)
  end
  if isEnough == false then
    REF.LabelBindCost.UIHtmlLabel.color = CS.NGUIMath.HexToColor(4278190335)
    REF.LabelCost.UIHtmlLabel.color = CS.NGUIMath.HexToColor(4278190335)
  else
    REF.LabelBindCost.UIHtmlLabel.color = CS.NGUIMath.HexToColor(995593215)
    REF.LabelCost.UIHtmlLabel.color = CS.NGUIMath.HexToColor(995593215)
  end
  REF.Grid.UIGrid:Reposition()
end
