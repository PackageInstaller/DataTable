local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")

function SetupWindow()
  WU.BindButtonEvent(REF.Black, function()
    WU.RecycleWindow(this)
  end)
end

function ShowHintListener(data)
  local index = 0
  local enough = true
  for id, v in pairs(data) do
    if type(id) == "number" then
      enough = enough and v.count >= v.needCount
      if v.displayNum ~= nil then
        local itemInfo = PB.get("ItemInfo", id)
        REF.Grid[index]["$gameObject"]:SetActive(true)
        REF.Grid[index].Item.UITexture.mainTexturePath = "Texture/ItemIcon/" .. itemInfo.icon
        REF["Quality0" .. index + 1].UISprite.spriteName = "icon_bg_" .. itemInfo.quality
        REF.Grid[index].HowMuch.UILabel.text = "x" .. v.displayNum
        index = index + 1
        if 3 < index then
          break
        end
      end
    end
  end
  for i = index, 3 do
    REF.Grid[i]["$gameObject"]:SetActive(false)
  end
  local Star = "\226\152\133"
  local actor = this:GetData("fci/actor/" .. data.uid)
  local name = WU.GetString("ActorName_" .. actor.id)
  local level = WU.GetString("Window_Level", actor.level)
  local star = ""
  for i = 1, actor.star do
    star = star .. Star
  end
  REF.EnoughDescribe.UIHtmlLabel.text = WU.GetString("ItemListenerEnoughAll", name, level, star)
  REF.EnoughDescribe.gameObject:SetActive(enough)
  REF.BackGroundFrame.UISprite.height = fif(enough, 185, 105)
  REF.BackGroundLine.UISprite.height = fif(enough, 213, 133)
  REF.Grid.UIGrid:Reposition()
  this:DelayInvokeInScaledSeconds(3, function()
    WU.RecycleWindow(this)
  end)
end
