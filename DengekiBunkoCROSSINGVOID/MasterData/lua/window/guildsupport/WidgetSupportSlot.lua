local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local m_trans, m_mathf, m_one, m_centerPosX, m_width, m_request

function Start()
  m_trans = REF.root.transform
  m_mathf = CS.UnityEngine.Mathf
  m_one = CS.UnityEngine.Vector3.one
  local winRef = _ENV["$"](WU.FindWindow("GuildSupport"))
  m_centerPosX = winRef.SpriteCenter.transform.position.x
  m_width = winRef.WrapContentSupportList[1].root.transform.position.x - winRef.WrapContentSupportList[0].root.transform.position.x
end

function Update()
  local p = 1 - m_mathf.Abs(m_trans.position.x - m_centerPosX) / m_width
  m_trans.localScale = m_one * m_mathf.Lerp(0.8, 1, p)
  local showDetail = 0.5 < p
  WU.ToggleRendering(REF.LabelCount, showDetail)
  WU.ToggleRendering(REF.LabelAction, showDetail)
end

function SetRequest(request)
  m_request = request
  if m_request then
    REF.LabelRequester.UILabel.text = GU.GetMemberName(m_request.requestPlayerId)
    local itemInfo = PB.get("ItemInfo", m_request.donateRes.id)
    REF.TextureIcon.UITexture.mainTexturePath = "Texture/ItemIcon/" .. itemInfo.icon
    local receivedCount, bestDonorPlayerId = GU.GetDonateInfo(m_request)
    local guildMisc = PB.index("GuildMisc", 1)
    REF.NodeProgressBar.UIProgressBar.value = receivedCount / guildMisc.donateMaxCount
    REF.LabelCount.UILabel.text = receivedCount .. "/" .. guildMisc.donateMaxCount
    REF.SpriteProgressFG.UISprite.spriteName = fif(receivedCount >= guildMisc.donateMaxCount, "levelup_bar_01", "levelup_bar_02")
    local bestDonorName
    if bestDonorPlayerId then
      local guildDonate = this:GetData("fci/guild/donate/")
      bestDonorName = guildDonate.donatePlayerInfo[bestDonorPlayerId].playerName
    end
    REF.LabelDonor.UILabel.text = bestDonorName or WU.GetString("Window_GuildDonateTips")
    REF.LabelAction.gameObject:SetActive(0 < receivedCount)
  end
end

function GetRequest()
  return m_request
end
