local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local AuraCooldown = PB.all("Misc")[1].auraCooldown
local m_playerId
local BGPrefix = {
  "main_friend_bg_",
  "sub_friend_bg_"
}
local CheckBox = {"check_box", "check_box"}

function SetPlayerAura(player, selectedPlayer)
  REF.PlayerAuraSelection.gameObject:SetActive(player.playerId == selectedPlayer)
  REF["@playerId"] = player.playerId
  REF["@actorId"] = player.auraActorId
  REF["@stranger"] = player.stranger
  REF["@name"] = player.name
  REF["@quality"] = player.auraActorQuality
  REF.PlayerName.UILabel.text = player.name
  REF.PlayerLevel.UILabel.text = " - " .. WU.GetString("Window_Level", player.level)
  local actorConfig = PB.get("ActorConfig", player.auraActorId)
  REF.ActorHead.UITexture.mainTexturePath = "Texture/ActorInfightHead/sub_2/infight_head_" .. actorConfig.animRes
  local index = 1
  if actorConfig.kind == PB.enum.ActorType.Sub then
    index = 2
  end
  REF.ActorHead.UITexture.maskTexturePath = "Texture/Mask/sub_friend_mask"
  REF.QualityBG.UISprite.spriteName = BGPrefix[index] .. player.auraActorQuality
  REF.PlayerAuraSelection.UISprite.spriteName = CheckBox[index]
  REF.IsGuestSprite.gameObject:SetActive(player.stranger)
  if REF["@countDown"] ~= nil and player.playerId == m_playerId then
    return
  end
  m_playerId = player.playerId
  local countDown = CS.GameTime.serverUtc - player.lastUseTime
  REF.CountDown.gameObject:SetActive(countDown < AuraCooldown)
  if countDown < AuraCooldown then
    REF.Content.UIWidget.alpha = 0.4
  else
    REF.Content.UIWidget.alpha = 1
  end
  REF["@cooldown"] = countDown >= AuraCooldown
  REF.CountDownTime.UIHtmlLabel.text = WU.RenderCountDownTime(AuraCooldown - countDown, 32, false, true)
  REF["@countDown"] = countDown
end
