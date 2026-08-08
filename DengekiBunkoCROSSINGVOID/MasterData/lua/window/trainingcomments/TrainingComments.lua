local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local M_MAX_TOP_COMMENT_COUNT = 4
local m_perPage = 10
local m_interval = 2
local m_commentInterval = 0
local m_actorId, m_curPageNumber, m_hasNext, m_smallestCommentTime
local m_comments = {}
local m_topComments = {}

function SetupWindow()
  WU.BindButtonEvent(REF.SpriteSend, OnSubmitComment)
  CS.EventDelegate.Add(REF.ScrollView.UIScrollView.onNext, function()
    info("Actor", "next page request")
    if m_hasNext then
      this:GameRequest("fci/comment/" .. m_actorId):Page(m_curPageNumber, m_perPage):Get(function(resp)
        if #resp == m_perPage then
          m_curPageNumber = m_curPageNumber + 1
        else
          m_hasNext = false
        end
        for i = 1, #resp do
          if m_smallestCommentTime == nil then
            m_smallestCommentTime = resp[i].info.createTime
          end
          if m_smallestCommentTime > resp[i].info.createTime then
            m_smallestCommentTime = resp[i].info.createTime
            table.insert(m_comments, resp[i])
          else
            print("Actor", "throw comment " .. table.dump(resp[i]))
          end
        end
        RefreshComments(false)
      end)
    end
  end)
  CS.EventDelegate.Add(REF.ScrollView.UIScrollView.onPrev, function()
    info("Actor", "previous page request")
  end)
end

function InitWindow()
  WU.ToggleRendering(REF.ContentTable, false)
  REF.InputComment.UIInput.defaultText = WU.GetString("Window_CommentDefaultText")
  REF.LabelTitle.UIHtmlLabel.text = WU.GetString("Window_ActorCommentsTitle")
  m_curPageNumber = 0
  m_comments = {}
  m_topComments = {}
  m_smallestCommentTime = nil
  m_hasNext = true
  this:Bind("Actor/SelectedUid", OnCurrentActorUidChangedComments)
end

function OnCurrentActorUidChangedComments(uid)
  if uid then
    m_actorId = this:GetData("fci/actor/" .. uid).id
    SetCommentsDetail()
  end
end

function SetCommentsDetail()
  local resActorConfig = PB.get("ActorConfig", m_actorId)
  if resActorConfig == nil then
    info("Actor", "resActorConfig xlsx is missing actorId " .. m_actorId)
    REF.SpriteActorSmall.UISprite.spriteName = ""
  else
    REF.SpriteActorSmall.UISprite.spriteName = "actor_head_" .. resActorConfig.animRes
  end
  this:SetData("Actor/ActorId", m_actorId)
  this:GameRequest("fci/comment/" .. m_actorId):Page(m_curPageNumber, m_perPage):Get(function(resp)
    if #resp == m_perPage then
      m_curPageNumber = m_curPageNumber + 1
    else
      m_hasNext = false
    end
    for i = 1, #resp do
      if resp[i].rank == 0 and not resp[i].alwaysTop then
        table.insert(m_comments, resp[i])
      else
        table.insert(m_topComments, resp[i])
      end
      if resp[i].rank == 0 and not resp[i].alwaysTop then
        if m_smallestCommentTime == nil then
          m_smallestCommentTime = resp[i].info.createTime
        end
        if m_smallestCommentTime > resp[i].info.createTime then
          m_smallestCommentTime = resp[i].info.createTime
        end
      end
    end
    RefreshComments(true)
  end)
end

function UpdateWindow(delta)
  m_commentInterval = m_commentInterval + delta
end

function OnSubmitComment()
  if m_actorId and m_commentInterval > m_interval then
    local content = REF.InputComment.UIInput.value
    if U.trim(content) == "" then
      return
    end
    content = string.gsub(content, "<", "&lt;")
    content = string.gsub(content, ">", "&gt;")
    local postData = {content = content, like = false}
    this:GameRequest("fci/comment/" .. m_actorId):Post(postData, function(resp)
      table.insert(m_comments, 1, resp)
      REF.InputComment.UIInput.value = ""
      m_commentInterval = 0
      WU.ShowHintText(WU.GetString("Window_SubmitComment"))
      RefreshComments(true)
    end)
  end
end

function RefreshComments(goTop)
  local tableRef = REF.ContentTable
  for i = 1, #m_topComments do
    local ref = tableRef[i - 1]
    ref["$gameObject"]:SetActive(true)
    ref["$$SetComment"](m_topComments[i])
  end
  for i = #m_topComments + 1, M_MAX_TOP_COMMENT_COUNT do
    tableRef[i - 1]["$gameObject"]:SetActive(false)
  end
  if #m_comments ~= 0 then
    REF.WidgetSplitLine.gameObject:SetActive(true)
  end
  local count = #REF.ContentTable
  if count - M_MAX_TOP_COMMENT_COUNT - 1 < #m_comments then
    local widgetComment = REF.WidgetCommentB.gameObject
    for i = count - M_MAX_TOP_COMMENT_COUNT, #m_comments do
      CS.NGUITools.AddChild(REF.ContentTable.gameObject, widgetComment)
    end
  elseif count - M_MAX_TOP_COMMENT_COUNT - 1 > #m_comments then
    for i = #m_comments, count - M_MAX_TOP_COMMENT_COUNT - 1 do
      tableRef[i + M_MAX_TOP_COMMENT_COUNT]["$gameObject"]:SetActive(false)
    end
  end
  for i = 1, #m_comments do
    local ref = tableRef[i + M_MAX_TOP_COMMENT_COUNT]
    ref.Line.gameObject:SetActive(true)
    ref["$$SetComment"](m_comments[i])
    ref["$gameObject"]:SetActive(true)
    if i == 1 then
      ref.Line.gameObject:SetActive(false)
    end
  end
  REF.ContentTable.UITable:Reposition()
  if goTop then
    REF.ScrollView.UIScrollView:ResetPosition()
  end
  WU.ToggleRendering(REF.ContentTable, true)
end
