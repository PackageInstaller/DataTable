local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local TR = require("Common/TeamRCMDUtil")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local m_data
local ColorSet = TR.ChatColorSet

function Start()
  WU.BindButtonEvent(REF.NodeStar, function()
    local commentId = m_data.commentId
    this:GameRequest(string.format("fci/share-group/comments-like/%d", commentId)):SyncInput(false):Post(nil, function(resp)
      if commentId == m_data.commentId then
        REF.LabelStarCnt.UILabel.text = WU.SimplifyNum(resp.likeCount)
        WU.SetActive(REF.SpriteStarOff, false)
        WU.SetActive(REF.SpriteStarOn, true)
        m_data.liked = true
        m_data.likeCount = resp.likeCount
      end
    end)
  end)
end

function SetData(data, playerType)
  m_data = data
  REF.LabelTime.UILabel.text = WU.RenderTime(data.uploadTime, false, true)
  REF.LabelPlayerName.UILabel.text = WU.GetString("TeamRCMD_CommentName", data.playerName)
  REF.LabelPlayerName.UILabel.color = ColorSet[playerType]
  REF.LabelStarCnt.UILabel.text = WU.SimplifyNum(data.likeCount)
  REF.LabelComment.UILabel.text = data.cotent
  WU.SetActive(REF.SpriteStarOff, not data.liked)
  WU.SetActive(REF.SpriteStarOn, data.liked)
  REF.Box.UIWidget:UpdateAnchors()
end
