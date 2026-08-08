local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_iapHandler = S:Get("IAPHandler")
local m_localedPrice, m_data

function Awake()
  WU.BindButtonEvent(REF["$"], OnItemClick)
  this:RegisterGameEvent("FinishPurchase", function()
    SetData(m_data)
  end)
end

function SetData(data)
  if data ~= nil then
    m_data = data
    REF.Icon.UISprite.spriteName = m_data.productPicture
    if m_data.ratio == 0 then
      m_localedPrice = m_iapHandler.GetLocalizedPrice(m_data.productId)
      REF.Diamonds.UIHtmlLabel.text = WU.GetString("Purchase_Diamonds", m_data.count)
    else
      m_localedPrice = WU.GetString("Purchase_Any")
      REF.Diamonds.UIHtmlLabel.text = WU.GetString("Purchase_AnyPrice", m_data.ratio)
    end
    if m_localedPrice ~= nil then
      REF.Price.UIHtmlLabel.text = m_localedPrice
    else
      REF.Price.UIHtmlLabel.text = WU.GetString("Purchase_NotAvaiable")
    end
    local activityInfo = m_iapHandler.GetActivityByPrice(m_data.count)
    REF.Promotion.gameObject:SetActive(false)
    REF.PromotionText.gameObject:SetActive(false)
    if activityInfo then
      local sendNum = m_iapHandler.GetSendNum(activityInfo)
      if m_iapHandler.IsDoubleSendByFirst(activityInfo) == true then
        REF.Promotion.gameObject:SetActive(true)
        REF.PromotionText.gameObject:SetActive(true)
        REF.PromotionText.UIHtmlLabel.text = WU.GetString("Purchase_Promotion", m_data.count)
      elseif 0 < sendNum then
        REF.PromotionText.gameObject:SetActive(true)
        REF.PromotionText.UIHtmlLabel.text = WU.GetString("Purchase_PromotionText", sendNum)
      end
    end
  end
end

function OnItemClick()
  if m_localedPrice == nil then
    WU.ShowHintText(WU.GetString("Purchase_NotAvaiable"))
  else
    WU.AcquireWindowAsync("PurchaseOrder", function(window)
      _ENV["$"](window)["$$SetData"](m_data)
    end)
  end
end
