local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local m_comment

function Start()
  WU.BindButtonEvent(REF.NodeStar, function()
    if not m_comment.like then
      local patchData = {like = true}
      local actorId = this:GetData("ActorComment/ActorId")
      this:GameRequest("fci/comment/" .. actorId .. "/" .. m_comment.info.id):Patch(patchData, function(resp)
        REF.LabelStarCnt.UILabel.text = resp.info.likeCount
        if resp.like then
          REF.SpriteStar.UISprite.spriteName = "comment_praise_1"
        else
          REF.SpriteStar.UISprite.spriteName = "comment_praise_2"
        end
        this:BroadcastGameEvent("CommentLiked", resp)
      end)
    else
      WU.ShowHintText(WU.GetString("Window_CommentHasLiked"))
    end
  end)
end

function SetAsSplitLine()
  REF["@isLine"] = true
  REF["@isWaiting"] = false
  REF.Comment.gameObject:SetActive(false)
  REF.WidgetSplitLine.gameObject:SetActive(true)
  REF.WidgetWaiting.gameObject:SetActive(false)
end

function SetAsComment(comment)
  REF["@isWaiting"] = false
  REF["@isLine"] = false
  REF.Comment.gameObject:SetActive(true)
  REF.WidgetSplitLine.gameObject:SetActive(false)
  REF.WidgetWaiting.gameObject:SetActive(false)
  m_comment = comment
  if U.trim(comment.senderName) == "" then
    REF.LabelPlayerName.UILabel.text = comment.info.sender
  else
    REF.LabelPlayerName.UILabel.text = comment.senderName
  end
  REF.LabelComment.UILabel.text = comment.info.content
  REF.LabelStarCnt.UILabel.text = comment.info.likeCount
  if comment.like then
    REF.SpriteStar.UISprite.spriteName = "comment_praise_1"
  else
    REF.SpriteStar.UISprite.spriteName = "comment_praise_2"
  end
  REF["@isTop"] = comment.alwaysTop or comment.rank ~= 0
  REF.SpriteRecommend.gameObject:SetActive(comment.alwaysTop)
  local showRank = not comment.alwaysTop and comment.rank ~= 0
  REF.SpriteFront.gameObject:SetActive(showRank)
  if showRank then
    REF.SpriteFront.UISprite.spriteName = "comment_top" .. comment.rank
  end
end

function SetAsWaiting(isWait)
  REF["@isWaiting"] = true
  REF["@isLine"] = false
  REF.Comment.gameObject:SetActive(false)
  REF.WidgetSplitLine.gameObject:SetActive(false)
  REF.WidgetWaiting.gameObject:SetActive(true)
  local signAlpha
  if isWait then
    signAlpha = 1
  else
    signAlpha = 0
  end
  REF.SignWaiting.AnimatedAlpha.alpha = signAlpha
  REF.LabelWaiting.AnimatedAlpha.alpha = 1 - signAlpha
end
