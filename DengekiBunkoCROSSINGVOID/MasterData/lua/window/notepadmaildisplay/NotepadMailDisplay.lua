local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")

function SetData(data)
  local baseinfo = this:GetData("fci/baseinfo/")
  local name = ""
  if baseinfo ~= nil then
    name = baseinfo.name
  end
  REF.LabelTitle.UIHtmlLabel.text = WU.GetString("NotepadMailDisplay", name)
  REF.Message.UIHtmlLabel.text = data.content
  REF.RoleActor.UIHtmlLabel.text = data.role
  REF.Time.UIHtmlLabel.text = WU.RenderTime(data.time)
end
