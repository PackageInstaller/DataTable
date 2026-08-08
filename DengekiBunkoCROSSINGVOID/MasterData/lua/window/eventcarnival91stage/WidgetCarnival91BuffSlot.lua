local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local SE = require("Common/SkillEffect")
local m_goodsId, m_activityType

function Start()
  WU.BindButtonEvent(REF.ButtonDetail, OnClickDetail)
  this:RegisterGameEvent("Carnival91PassPlayEffect", OnCarnival91PassPlayEffect)
end

function SetData(goodsId)
  m_goodsId = goodsId
  m_activityType = this:GetData("Welfare/ActivityType")
  local shopInfo = this:GetData("fci/BuffShop/" .. m_activityType).shopInfo
  local _, goodInfo = table.find(shopInfo, function(k, v)
    return v.goodsId == goodsId
  end)
  local grade = goodInfo.grade
  local xlsxConfig = PB.get("ActivityBuffGoods", goodsId, fif(grade == 0, 1, grade))
  local upgradeXlsxConfig = PB.get("ActivityBuffGoods", goodsId, grade + 1)
  WU.SetActive(REF.SpriteSlotBGMask, grade == 0)
  REF.LabelName.UILabel.text = WU.GetString("ActivityBuffGoodName_" .. goodsId)
  REF.LabelGrade.UILabel.text = "Lv." .. fif(grade == 0, 1, grade)
  REF.SpriteBuff.UISprite.spriteName = xlsxConfig.spriteName
  REF.LabelDesc.UIHtmlLabel.text = SE.GetActivityBuffDesc(goodsId, fif(grade == 0, 1, grade))
  if upgradeXlsxConfig then
    WU.SetActive(REF.ButtonDetail, true)
    WU.SetActive(REF.LabelHintMax, false)
    REF.LabelCost.ResourcePrinter:SetResource(upgradeXlsxConfig.cost[1].type, upgradeXlsxConfig.cost[1].id, upgradeXlsxConfig.cost[1].count)
  else
    WU.SetActive(REF.ButtonDetail, false)
    WU.SetActive(REF.LabelHintMax, true)
  end
end

function OnCarnival91PassPlayEffect(goodsId)
  if goodsId == m_goodsId then
    PlayEffect()
  end
end

function PlayEffect()
  REF.EffectActive.EffectGenerator:Play()
end

function OnClickDetail()
  this:SetData("Carnival91Pass/GoodsId", m_goodsId)
  WU.AcquireWindowAsync("Carnival91BuffDetail")
end
