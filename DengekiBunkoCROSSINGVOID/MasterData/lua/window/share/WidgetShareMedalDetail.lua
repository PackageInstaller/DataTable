local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local EA = require("Common/EquipAttr")
local m_medal
local m_color = {
  [1] = 2346957670,
  [2] = 2345132902,
  [3] = 3700155238,
  [4] = 3956974950
}

function SetShareInfo(medal)
  m_medal = medal
  local medalInfo = PB.get("MedalInfo", medal.medalId)
  REF.WidgetIconSlotMedal["$SetData"](PB.enum.ResourceType.ResMedal, medal.medalId)
  REF.LabelName.UIHtmlLabel.text = "<font size=46>" .. WU.GetString("MedalName_" .. medal.medalId) .. "</font>&nbsp;<font size=24>(" .. WU.GetString("MedalSource_" .. medalInfo.source) .. ")</font>"
  local detailText = AU.RenderAuraOrMedalAttr(medalInfo)
  detailText = detailText .. "<font size=10><br></font>" .. "<font color=#6682B6FF>" .. WU.GetString("MedalStory_" .. medal.medalId) .. "</font>"
  REF.LabelDetail.UIHtmlLabel.text = detailText
  REF.ShareBG.UITexture.mainTexturePath = "Texture/Background/share_equipment_wide_bg_" .. tostring(medalInfo.quality)
end
