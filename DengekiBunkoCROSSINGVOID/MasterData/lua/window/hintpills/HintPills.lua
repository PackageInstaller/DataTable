local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")

function SetupWindow()
  WU.BindButtonEvent(REF.Black, function()
    WU.RecordButtonClick(100121601)
    WU.RecycleWindow(this)
  end)
end

function SetContent(pills)
  WU.TraverseChildren(REF.ContentPillGot, function(go, parIdx)
    local gasket = _ENV["$"](go).root
    local data = pills[parIdx + 1]
    gasket.gameObject:SetActive(data ~= nil)
    if data then
      gasket["$SetData"](data.type, data.id, data.count)
      gasket["$SetClickCallback"](function()
        WU.AcquireWindowAsync("TowerNewPillDetail", function(ui)
          _ENV["$"](ui)["$$SetPillDetail"](data)
        end)
      end)
    end
  end)
end

function Focus(on)
  WU.RecordWindowFocus(1001216, on)
end
