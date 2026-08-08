local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_refSlot

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonGotIt, function()
    WU.RecycleWindow(this)
  end)
end

function SetView(rewards, titleText, contentText, isGot, buttonText)
  REF.LabelTitle.UIHtmlLabel.text = titleText
  REF.LabelContent.UIHtmlLabel.text = contentText
  REF.SpriteGot.gameObject:SetActive(isGot)
  if buttonText == nil then
    buttonText = WU.GetString("Window_GotIt")
  end
  REF.Label.UIHtmlLabel.text = buttonText
  m_refSlot = {}
  for i = 1, #REF.Rewards do
    local ref = REF.Rewards[i - 1]["$"]
    ref.gameObject:SetActive(i <= #rewards)
    if i <= #rewards then
      ref["$SetData"](rewards[i].type, rewards[i].id, rewards[i].count)
      ref["$SetClickCallback"](function()
        WU.ShowResourceDetail(rewards[i].type, rewards[i].id)
      end)
      m_refSlot[rewards[i].id] = ref
    end
  end
  REF.Rewards.UIGrid:Reposition()
end

function SetCustomActorInfo(id, quality)
  local refSlot = m_refSlot[id]
  if refSlot then
    refSlot["$SetActorCustom"]({id = id, quality = quality})
    refSlot["$SetClickCallback"](function()
      WU.AcquireWindowAsync("ItemDetail", function(ui)
        _ENV["$"](ui)["$$SetActorInfo"](id, quality)
      end)
    end)
  end
end
