local WU, DB, REF = require("Common/WindowUtil")(this)

function SetupWindow()
end

function InitWindow()
  local serviceTerms = this:GetData("UserAgreement")
  REF.LabelAgreement.UILabel.text = serviceTerms
end

function UninitWindow()
end
