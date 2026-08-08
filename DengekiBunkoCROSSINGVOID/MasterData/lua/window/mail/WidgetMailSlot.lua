local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local DBH = require("Manager/DataBindingHandler")
local U = require("Common/Util")
local m_configDataManager = S:Get("ConfigDataManager")
local m_mail, m_mailId, m_timeCountdown

function Start()
  WU.BindButtonEvent(REF.ButtonDelete, OnDeleteClick)
  WU.BindButtonEvent(REF.ButtonReceive, OnReceiveClick)
  WU.BindButtonEvent(REF["$"], OnMailFullContent)
end

function BindMail(id)
  WU.ToggleRendering(REF.Visual, false)
  if m_mailId then
    this:Unbind("fci/mail/" .. m_mailId, OnMailContent)
  end
  m_mailId = id
  this:Bind("fci/mail/" .. id, OnMailContent)
end

function Update(delta)
  if m_timeCountdown and m_timeCountdown.time > 1 then
    SetCountDown(m_timeCountdown.time)
  end
end

function OnMailContent(mail)
  if mail ~= nil then
    m_mail = mail
    WU.ToggleRendering(REF.SpriteTime, mail.expireTime and mail.expireTime > 0)
    local time = mail.expireTime - CS.GameTime.serverUtc
    local timeElapse = this:GetData("Mail/TimeElapse") or _ENV["!"]({})
    if 1 < time then
      m_timeCountdown = {
        id = mail.id,
        time = time
      }
      table.insert(timeElapse, m_timeCountdown)
    elseif mail.expireTime and mail.expireTime > 0 then
      this:BroadcastGameEvent("Mail/Delete", mail.id)
      return
    end
    this:SetData("Mail/TimeElapse", timeElapse)
    REF.Title.UILabel.text = mail.title
    REF.ContentShort.UILabel.text = string.gsub(mail.content, "<[^>]*>", "")
    REF.Time.UIHtmlLabel.text = WU.RenderTime(mail.createTime)
    REF.ImportantIcon.gameObject:SetActive(mail.important)
    REF.ButtonReceive.gameObject:SetActive(0 < #mail.attachments)
    REF.AttachmentIconParent.gameObject:SetActive(0 < #mail.attachments)
    REF.NormalIcon.UITexture.enabled = not (0 < #mail.attachments)
    REF.ReadIcon.gameObject:SetActive(mail.read and #mail.attachments == 0 or mail.attachmentsGot)
    if 0 < #mail.attachments then
      local showRes = WU.AttachmentToResourceType(mail.attachments[1])
      if showRes.type == PB.enum.ResourceType.ResUniqueWeapon then
        REF.WidgetIconSlot["$SetData"](showRes.type, showRes.id, nil, "S")
        REF.WidgetIconSlot["$ShowCustom"]({
          hideLevel = true,
          showEquip = false,
          showStar = false,
          phase = 1
        })
      else
        REF.WidgetIconSlot["$SetData"](showRes.type, showRes.id, showRes.count)
      end
    end
    if mail.read or 0 < #mail.attachments then
      if 1 > #mail.attachments then
        REF.ButtonDelete.gameObject:SetActive(true)
      else
        REF.ButtonDelete.gameObject:SetActive(mail.attachmentsGot)
        REF.ButtonReceive.gameObject:SetActive(not mail.attachmentsGot)
      end
    else
      REF.ButtonDelete.gameObject:SetActive(false)
      REF.ButtonReceive.gameObject:SetActive(false)
    end
    WU.ToggleRendering(REF.Visual, true)
  end
end

function OnDeleteClick()
  this:BroadcastGameEvent("Mail/Delete", m_mailId)
end

function OnReceiveClick()
  WU.RecordButtonClick(143001)
  this:BroadcastGameEvent("Mail/AttachmentsGot", m_mailId)
end

function OnMailFullContent()
  WU.RecordButtonClick(143002)
  this:SetData("Mail/SelectedId", m_mailId)
  WU.AcquireWindowAsync("MailFullContent")
end

function SetCountDown(time)
  if 1 < time then
    REF.LabelTime.UIHtmlLabel.text = WU.RenderCountDownTime(time, REF.LabelTime.UIHtmlLabel.fontSize)
  end
end
