local WU, DB, REF = require("Common/WindowUtil")(this)
local DBH = require("Manager/DataBindingHandler")
local RU = require("Common/RedMarkUtil")
local S = require("Common/Singleton")
local m_configDataManager = S:Get("ConfigDataManager")
local m_showGift = false

function Start()
  InitState()
  WU.BindButtonEvent(REF.ButtonGift, function()
    if m_showGift then
      DB:GameRequest(string.format("fci/PringlesGift/%s", this:GetData("playerId"))):Post({}, function(res)
        DBH.ResChange(res.resChange)
        WU.ShowRewards(res.resChange)
        local pringlesGift = this:GetData("fci/WlfPringlesGift")
        pringlesGift.rewardTimes = 1
        pringlesGift.rewardTime = CS.GameTime.serverUtc
        this:SetData("fci/WlfPringlesGift", pringlesGift)
        RU.SetRedMark("Welfare/PringlesGift/New", false)
        WU.SetActive(REF.Effect, false)
        InitState()
      end)
    else
      WU.ShowHintText(WU.GetString("Error_RewardHasGot"))
    end
  end)
end

function OnEnable()
  PlayEffect()
end

function InitState()
  local pringlesGift = this:GetData("fci/WlfPringlesGift")
  m_showGift = fif(pringlesGift ~= nil and pringlesGift.rewardTimes == 0, true, false)
  local texturePath = "Texture/Welfare/Pingles_gift_" .. fif(m_showGift, "1", "2")
  REF.ButtonGift.UITexture.mainTexturePath = texturePath
end

function PlayEffect()
  WU.SetActive(REF.Effect, false)
  if not m_showGift then
    return
  end
  local preferences = m_configDataManager.GetPreferences()
  if not preferences.notFirstShowPringlesGift then
    preferences.notFirstShowPringlesGift = true
    m_configDataManager.SetPreferences(preferences)
    WU.SetActive(REF.Effect, true)
  end
end
