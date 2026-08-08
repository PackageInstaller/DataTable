local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_iapHandler = S:Get("IAPHandler")
local m_localedPrice, m_data

function Awake()
  WU.BindButtonEvent(REF.Icon, OnItemClick)
end

function SetBuyCount(count)
  m_data.buyCount = fif(count, count, 0)
  WU.SetActive(REF.SpriteSale, m_data.maxBuyCount == m_data.buyCount)
end

function SetData(data, mode)
  if data == nil then
    WU.SetActive(REF["$"], false)
    return
  end
  m_data = data
  local Icon = REF.Icon
  Icon.UITexture.width = fif(mode == 0, 840, 699)
  Icon.UITexture.height = fif(mode == 0, 831, 387)
  Icon.UITexture.mainTexturePath = "Texture/Purchase/" .. m_data.picBg
  WU.SetActive(REF.LimitCount, mode ~= 0)
  local rmbPrice = REF.RMBPrice
  rmbPrice.transform.localPosition = {
    x = 0,
    y = fif(mode == 0, -377, -154),
    z = 0
  }
  if m_data.productId ~= "" then
    m_localedPrice = m_iapHandler.GetLocalizedPrice(m_data.productId)
    if m_localedPrice ~= nil then
      rmbPrice.UIHtmlLabel.text = m_localedPrice
    else
      rmbPrice.UIHtmlLabel.text = m_data.price
    end
  end
  SetBuyCount(m_data.buyCount)
end

function OnItemClick()
  WU.AcquireWindowAsync("PurchaseBuy", function(window)
    _ENV["$"](window)["$$SetData"](m_data)
  end)
end
