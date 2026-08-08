local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local PU = require("Common/PlatformUtil")
local m_currentIndex, m_selectedActors, m_allActors, m_shareCount, m_startIndex, m_haveNum, m_totalNum

function Start()
  REF.ShareContent.gameObject:SetActive(false)
  local width = REF.WindowSize.UIWidget.width
  if 1920 < width then
    local scale = width / 1920 + 0.01
    REF.ShareContent.transform.localScale = {
      x = scale,
      y = scale,
      z = 1
    }
    REF.ShareContent.gameObject:SetActive(true)
  else
    REF.ShareContent.gameObject:SetActive(true)
  end
  REF.Black.gameObject:SetActive(true)
end

function OnEnable()
  this:Bind("Share/SelectedActors", OnSelectedChange)
  this:Bind("fci/baseinfo/", OnPlayerInfoChange)
end

function OnDisable()
  this:Unbind("Share/SelectedActors", OnSelectedChange)
  this:Unbind("fci/baseinfo/", OnPlayerInfoChange)
end

function SetShareInfo(shareInfo)
  m_currentIndex = shareInfo.currentIndex
  m_allActors = shareInfo.actorList
  m_shareCount = shareInfo.count
  m_selectedActors = {}
  m_haveNum = shareInfo.have
  m_totalNum = shareInfo.total
  local str = tostring(m_haveNum)
  _ENV["$"](REF.ShareContent).LabelHaveNum.UILabel.text = string.sub(str, 1, 1)
  _ENV["$"](REF.ShareContent).LabelHaveNumR.UILabel.text = string.sub(str, 2, string.len(str))
  _ENV["$"](REF.CameraContent).LabelHaveNum.UILabel.text = string.sub(str, 1, 1)
  _ENV["$"](REF.CameraContent).LabelHaveNumR.UILabel.text = string.sub(str, 2, string.len(str))
  str = tostring(m_totalNum)
  _ENV["$"](REF.ShareContent).LabelAllNum.UILabel.text = string.sub(str, 1, 1)
  _ENV["$"](REF.ShareContent).LabelAllNumR.UILabel.text = string.sub(str, 2, string.len(str))
  _ENV["$"](REF.CameraContent).LabelAllNum.UILabel.text = string.sub(str, 1, 1)
  _ENV["$"](REF.CameraContent).LabelAllNumR.UILabel.text = string.sub(str, 2, string.len(str))
  for i = m_currentIndex, m_currentIndex + m_shareCount - 1 do
    table.insert(m_selectedActors, m_allActors[i])
  end
  DB:SetData("Share/SelectedActors", m_selectedActors)
end

function OnSelectedChange(actors)
  m_selectedActors = actors
  if m_selectedActors == nil then
    return
  end
  local ref = _ENV["$"](REF.ShareContent)
  for i = 1, #REF.ShareActorGrid do
    ref.ShareActorGrid[i - 1]["$$SetData"](m_selectedActors[i])
    ref.ShareActorGrid[i - 1]["$$SetSelected"](false)
    REF.BGActorGrid[i - 1]["$$SetData"](m_selectedActors[i])
    REF.BGActorGrid[i - 1]["$$SetSelected"](false)
  end
end

function SetSharePicture()
  local ref = _ENV["$"](REF.CameraContent)
  for i = 1, m_shareCount do
    local dataCombined = m_selectedActors[i]
    ref.ShareActorGrid[i - 1]["$$SetData"](dataCombined)
    ref.ShareActorGrid[i - 1]["$$SetSelected"](false)
  end
  REF.CameraContent.gameObject:SetActive(true)
end

function OnPlayerInfoChange(baseInfo)
  if baseInfo then
    local ref1 = _ENV["$"](REF.ShareContent)
    AU.SetPlayerName(ref1.LabelName, this:GetData("accountCache"), baseInfo)
    ref1.LabelLevel.UILabel.text = WU.GetString("Window_Level", baseInfo.level)
    ref1.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](baseInfo)
    local ref2 = _ENV["$"](REF.CameraContent)
    AU.SetPlayerName(ref2.LabelName, this:GetData("accountCache"), baseInfo)
    ref2.LabelLevel.UILabel.text = WU.GetString("Window_Level", baseInfo.level)
    ref2.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](baseInfo)
    local accountCache = this:GetData("accountCache")
    local wg = CS.Msdk.WGPlatform.Instance
    local installChannel = wg:WGGetChannelId()
    if accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ or PU.IsPrivilegeIgnore(installChannel) then
      ref1.Player.transform.localPosition = {
        x = 30,
        y = 0,
        z = 0
      }
      ref2.Player.transform.localPosition = {
        x = 30,
        y = 0,
        z = 0
      }
      ref1.SpriteBG.UISprite.width = 450
      ref2.SpriteBG.UISprite.width = 450
      ref1.SpriteQR.gameObject:SetActive(false)
      ref2.SpriteQR.gameObject:SetActive(false)
    end
  end
end
