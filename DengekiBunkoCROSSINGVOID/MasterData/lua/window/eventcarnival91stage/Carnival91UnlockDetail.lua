local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonGotIt, function()
    WU.RecycleWindow(this)
  end)
end

function SetData(preRecord, theRecord)
  local xlsxConfig = PB.get("DungeonReward", theRecord.dungeonId)
  REF.LabelTitle.UIHtmlLabel.text = WU.GetString("Window_OpenCondition", WU.GetString("DungeonName_" .. theRecord.dungeonId))
  REF.LabelUnlockDoneTime.UILabel.text = WU.GetString("Window_Carnival91SemiFixedUnlockCondition", WU.GetString("DungeonName_" .. xlsxConfig.preDungeonId), xlsxConfig.preDungeonDoneTimes)
  REF.LabelUnlockProgress.UILabel.text = preRecord.doneTimes .. " / " .. xlsxConfig.preDungeonDoneTimes
  REF.SpriteProgressBarFg.UISprite.fillAmount = preRecord.doneTimes / xlsxConfig.preDungeonDoneTimes
  REF.LabelUnlockActors.UILabel.text = WU.GetString("Window_SemiFixedUnlockActorTitle", WU.GetString("DungeonName_" .. preRecord.dungeonId))
  local npcIds = _ENV["!"](PB.get("SemiFixedDungeon", xlsxConfig.preDungeonId).npcId):where(function(_, v)
    return v ~= 0
  end):toarray()
  for i = 0, #REF.GridActors - 1 do
    local npcId = npcIds[i + 1]
    if npcId then
      WU.SetActive(REF.GridActors[i].root, true)
      REF.GridActors[i]["$$SetData"](PB.get("DungeonNPC", npcId).actorId)
    else
      WU.SetActive(REF.GridActors[i].root, false)
    end
  end
end
