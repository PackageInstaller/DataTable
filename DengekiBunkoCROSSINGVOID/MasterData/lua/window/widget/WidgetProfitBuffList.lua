local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_callback

function Start()
  WU.BindButtonEvent(REF.GridProfitBuff[0]["$"], OnButtonClick)
end

function SetProfitBuffList(profitBuffList, pivot)
  local needCreateProfitBuffCount = #profitBuffList - #REF.GridProfitBuff
  for i = 1, needCreateProfitBuffCount do
    local source = REF.GridProfitBuff[0]["$gameObject"]
    local clone = CS.UnityEngine.GameObject.Instantiate(source, REF.GridProfitBuff.transform)
    clone.name = source.name
    WU.BindButtonEvent(_ENV["$"](clone)["$"], OnButtonClick)
  end
  for i = 1, #REF.GridProfitBuff do
    local isActive = i <= #profitBuffList
    REF.GridProfitBuff[i - 1]["$gameObject"]:SetActive(isActive)
    if isActive then
      REF.GridProfitBuff[i - 1]["$"].UISprite.spriteName = "profitbuff_icon_" .. profitBuffList[i].id
    end
  end
  REF.GridProfitBuff.UIGrid.pivot = pivot
  REF.GridProfitBuff.UIGrid:Reposition()
end

function SetClickCallback(callback)
  m_callback = callback
end

function OnButtonClick()
  if m_callback then
    m_callback()
  end
end
