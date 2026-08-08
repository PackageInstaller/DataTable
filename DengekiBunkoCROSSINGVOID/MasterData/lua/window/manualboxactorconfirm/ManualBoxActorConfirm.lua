local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local m_goodsInfo, m_callback
local ActorTypePrefix = {
  "Window_ActorMainPrefix",
  "Window_ActorAssistPrefix"
}

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnButtonConfirm)
  WU.BindButtonEvent(REF.ButtonCancel, OnCancelClick)
end

function SetData(actorId, quality, callback, goodsInfo)
  m_goodsInfo = goodsInfo
  m_callback = callback
  REF.LabelDescribeTitle.UIHtmlLabel.text = WU.GetString(fif(m_goodsInfo, "Window_BuyActorTitle", "Window_GetActorTitle"))
  REF.WidgetIconSlot["$SetActorCustom"]({id = actorId, quality = quality})
  REF.WidgetIconSlot["$SetClickCallback"](nil)
  REF.SpriteQualityBG.UISprite.spriteName = "actor_type_bg_" .. quality
  REF.SpriteActorType.UISprite.spriteName = "actor_type_" .. actorId
  REF.LabelCV.UILabel.text = WU.GetString("ActorCV_" .. actorId)
  REF.LabelDescription.UIHtmlLabel.text = WU.GetString("ActorDescribe_" .. actorId)
  local actorConfig = PB.get("ActorConfig", actorId)
  if actorConfig then
    REF.SpriteActorName.UISprite.spriteName = "actor_name_" .. actorConfig.animRes
    local actorTag = PB.get("ActorTag", actorId)
    if actorTag then
      REF.LabelCharactorType.UILabel.text = WU.GetString(ActorTypePrefix[actorConfig.kind]) .. WU.GetString("tag" .. actorTag.tag[1])
    end
  end
  REF.ScrollView.UIScrollView:ResetPosition()
  WU.SetActive(REF.NodeCost, m_goodsInfo)
  if m_goodsInfo then
    local cost = m_goodsInfo.cost[1]
    REF.LabelCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
  end
  WU.SetActive(REF.ButtonCancel, m_goodsInfo)
  REF.LabelConfirm.UIHtmlLabel.text = WU.GetString(fif(m_goodsInfo, "WindowShopBuy_Buy", "Window_Get"))
  REF.ButtonGrid.UIGrid:Reposition()
end

function OnButtonConfirm()
  WU.RecycleWindow(this)
  if m_callback then
    m_callback()
  end
end

function OnCancelClick()
  WU.RecycleWindow(this)
end
