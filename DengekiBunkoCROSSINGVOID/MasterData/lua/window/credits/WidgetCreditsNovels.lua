local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")

function OnEnable()
  REF.Table.UITable:Reposition()
end

function SetUI(novelInfo)
  REF.Tittle.UILabel.text = WU.GetString("NovelName_" .. tostring(novelInfo.id))
  if novelInfo.id == 999 then
    REF.NovelCover.gameObject:SetActive(false)
    REF.Writer.gameObject:SetActive(false)
  else
    REF.NovelCover.gameObject:SetActive(true)
    REF.NovelCover.UITexture.mainTexturePath = "Texture/Book_icon/book_" .. tostring(novelInfo.id)
    local writeName = WU.GetString("NovelWriter_" .. tostring(novelInfo.id))
    REF.Writer.gameObject:SetActive(true)
    REF.writerName.UILabel.text = writeName
  end
  REF.painterName.UILabel.text = WU.GetString("NovelPainter_" .. tostring(novelInfo.id))
  for i = 0, #REF.NameGrid - 1 do
    if novelInfo.actor[i + 1] then
      REF.NameGrid[i]["$gameObject"]:SetActive(true)
      local content = WU.GetString("RoleName_" .. novelInfo.actor[i + 1].roleId) .. WU.GetString("Window_EnglishBrackets", WU.GetString(novelInfo.actor[i + 1].cv))
      REF.NameGrid[i]["$UILabel"].text = content
    else
      REF.NameGrid[i]["$gameObject"]:SetActive(false)
    end
  end
end
