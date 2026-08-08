local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_iaphandler = S:Get("IAPHandler")

function UpdateWidget(refRow, wrapIndex, realIndex)
  local data = m_iaphandler.GetProducts()
  refRow["$$SetData"](data[realIndex + 1], _ENV["$"](this))
end

function Awake()
  LU.Bind(REF.ItemList, {
    updateRow = UpdateWidget
  })
  this:RegisterGameEvent("OnGetPurchaseActivityInfo", function()
    local data = m_iaphandler.GetProducts()
    LU.Set(REF.ItemList, #data, false)
  end)
end

function Start()
  LU.Set(REF.ItemList, 0, false)
  WU.BindButtonEvent(REF.ButtonPurchaseVipCS, OnClickContactCustomerService)
end

function OnEnable()
  m_iaphandler.GetActivityInfo()
  REF.ScrollView.UIScrollView:ResetPosition()
end

function OnDisable()
end

function OnClickContactCustomerService()
  local url = WU.GetClientUrlParam(PB.all("MsdkUrl")[1].PurchaseCS)
  if url == nil then
    warning("need fill url in table")
    return
  end
  WU.OpenUrl(url)
end

function OnClickHelp()
  WU.AcquireWindowAsync("RulePay")
end
