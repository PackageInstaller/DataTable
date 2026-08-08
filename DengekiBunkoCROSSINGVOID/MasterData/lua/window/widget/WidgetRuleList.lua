local WU, DB, REF = require("Common/WindowUtil")(this)
local LU = require("Common/ListUtil")

function Start()
end

function SetRuleInfoTable(ruleInfoTable)
  LU.Set(REF.WrapContent, ruleInfoTable.count)
  for i = 1, ruleInfoTable.count do
    REF.WrapContent[i - 1].LabelTitle.UIHtmlLabel.text = WU.GetString(ruleInfoTable.title .. i)
    REF.WrapContent[i - 1].LabelContent.UIHtmlLabel.text = WU.GetString(ruleInfoTable.content .. i)
  end
end
