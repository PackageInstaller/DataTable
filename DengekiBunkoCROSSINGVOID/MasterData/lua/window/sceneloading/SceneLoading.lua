local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local m_configDataManager = S:Get("ConfigDataManager")
local U = require("Common/Util")

function ChangeTexture()
  local curLevel = 100
  local curDungeonCount = 100
  local summary = this:GetData("fci/dungeon/chapter-summary")
  if summary ~= nil then
    curDungeonCount = summary.unlockedNormalDungeonsCnt
  end
  local baseInfo = this:GetData("fci/baseinfo/")
  if baseInfo ~= nil then
    curLevel = baseInfo.level
  end
  local tabs = {}
  local loadingConfigs = PB.all("LoadingConfig")
  for _, config in pairs(loadingConfigs) do
    if curLevel >= config.accountLevel and curLevel < config.closeLevel and curDungeonCount >= config.pveStageNumber and config.BigBg ~= "" then
      table.insert(tabs, config)
    end
  end
  if table.empty(tabs) then
    REF.BG.UITexture.mainTexturePath = "Texture/Loading/Loading02"
    REF.LabelTip.UILabel.text = WU.GetString("BattleLoading_Desc_1")
  else
    local index = math.random(1, #tabs)
    local loadingConfig = tabs[index]
    REF.BG.UITexture.mainTexturePath = loadingConfig.BigBg
    REF.LabelTip.UILabel.text = WU.GetString(loadingConfig.BattleLoading)
  end
  this:BroadcastGameEvent("HideLoadingSignCorner", true)
end

function ResetTexture()
  WU.RestartTween(REF.BG.TweenAlpha, function()
    REF.BG.UITexture.mainTexturePath = nil
    WU.RecycleWindow(this)
    WU.SetLockFlag(WU.LockInputFlag.GameLoading, false)
  end)
end

function InitWindow()
  UpdateLoadingProgress(0)
end

function ShowLoadingDetail()
  WU.SetLockFlag(WU.LockInputFlag.GameLoading, true)
  ChangeTexture()
end

function HideLoadingDetail()
  ResetTexture()
end

function UpdateLoadingProgress(progress)
end
