local this = class("cellChatMessage", G_UIModuleBase)
local chatBubbleTpl = L_GameTpl:getChatBubbleTpl()
local bubbleDefault = "UI/Atlas/ChatBubble/tex_chat_bg_frame_000.png"

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {photoEntity = nil}
end

function this.bind()
  return {
    moduleBaseInfo = {
      moduleName = "pages/chat/moduleChatBaseInfo"
    },
    txt_name = "",
    txt_title = "",
    txt_level = "",
    txt_message = "",
    txt_nameColor = C_Color(1, 1, 1, 1),
    img_bubbleBg = bubbleDefault,
    color_txtMessage = C_Color(0.31, 0.321, 0.365, 1)
  }
end

function this.methods()
  return {
    onClick_img_bg = function(self)
      self:showReportChat()
    end,
    onClick_reportChat = function(self)
      self:reportChat()
    end,
    onClick_reportMask = function(self)
      self:hideReportChat()
    end,
    moduleBaseInfo = {
      onClick_head = function(self)
        if L_PlayerStore:getPlayerId() == self.bind.playerUid then
          return
        end
        self:emit("onClick_head", self.bind.playerUid)
      end
    }
  }
end

function this:refresh()
  local infoModule = self.modules.moduleBaseInfo
  if infoModule then
    infoModule.bind.uid = self.bind.playerUid
    infoModule.bind.txt_name = self.bind.txt_name
    infoModule.bind.txt_title = self.bind.txt_title
    infoModule.bind.img_headFrame = self.bind.icon_frame
    infoModule.bind.txt_level = self.bind.txt_level
    infoModule:initShow()
  end
  local alphaValue = 0.8
  if self.bind.is_mark then
    self.bind.txt_nameColor = C_Color(0.01568627450980392, 0.6470588235294118, 0.8823529411764706, alphaValue)
  else
    self.bind.txt_nameColor = C_Color(0.13333333333333333, 0.14901960784313725, 0.1568627450980392, alphaValue)
  end
  if self.playInitFXNextRefresh then
    self:playInitFX()
  end
  self:hideReportChat()
  self:refreshBubble()
end

function this:unBind()
  self.playInitFXNextRefresh = false
end

this.playInitFXNextRefresh = false

function this:playInitFX()
  self.playInitFXNextRefresh = false
  if self.bindComponents and self.bindComponents.ani_cellMessage then
    local result = self.bindComponents.ani_cellMessage:Play()
  else
    self.playInitFXNextRefresh = true
  end
end

function this:refreshBubble()
  if self.bind.bubbleConfigId then
    local tpl = chatBubbleTpl:getTplById(self.bind.bubbleConfigId)
    if tpl then
      if chatBubbleTpl:getShowType(tpl) == 0 then
        self.bind.color_txtMessage = C_Color(0.31, 0.32, 0.36, 1)
        self.bind.img_bubbleBg = bubbleDefault
      else
        local colorStr = chatBubbleTpl:getTextColor(tpl)
        if not string.isEmpty(colorStr) then
          local _, textColor = C_ColorUtility.TryParseHtmlString(colorStr)
          if textColor then
            self.bind.color_txtMessage = textColor
          end
        else
          self.bind.color_txtMessage = C_Color(0.31, 0.32, 0.36, 1)
        end
        local bubbleIcon = chatBubbleTpl:getBubbleIcon(tpl)
        if bubbleIcon ~= nil then
          self.bind.img_bubbleBg = bubbleIcon
        end
      end
    end
  end
end

function this:csSetData(options)
  local infoModule = self.modules.moduleBaseInfo
  if infoModule and options.isSender then
    local playerUid = L_PlayerStore:getPlayerId()
    local baseInfo = L_FriendStore:getPlayerBaseInfo(playerUid)
    infoModule.bind.uid = playerUid
    infoModule.bind.txt_name = L_PlayerStore:getPlayerName()
    infoModule.bind.txt_title = L_FriendStore:ParsePlayerTitle(baseInfo)
    infoModule.bind.img_headFrame = L_PlayerDisplayStore:loadHeadFrame(baseInfo)
    infoModule.bind.txt_level = tostring(L_FriendStore:getPlayerLevel(baseInfo))
    infoModule:initShow()
    self.bind.txt_message = options.txt_message
    self.bind.bubbleConfigId = options.bubbleConfigId
  end
  if self.playInitFXNextRefresh then
    self:playInitFX()
  end
  self:refreshBubble()
end

function this:showReportChat()
  if L_PlayerStore:getPlayerId() == self.bind.playerUid then
    return
  end
  if not CS.Lens.Gameplay.UI.ReportStore.GetStore():IsReportTypeEnabledById(2) then
    return
  end
  if self.bindComponents and self.bindComponents.reportChat then
    self.bindComponents.reportChat.gameObject:SetActive(true)
  end
  if self.bindComponents and self.bindComponents.reportMask then
    self.bindComponents.reportMask.gameObject:SetActive(true)
  end
end

function this:hideReportChat()
  if self.bindComponents and self.bindComponents.reportChat then
    self.bindComponents.reportChat.gameObject:SetActive(false)
  end
  if self.bindComponents and self.bindComponents.reportMask then
    self.bindComponents.reportMask.gameObject:SetActive(false)
  end
end

function this:reportChat()
  local playerUid = self.bind.playerUid
  if L_PlayerStore:getPlayerId() == playerUid then
    return
  end
  local playerName = self.bind.txt_name
  local data = {
    reportType = 2,
    pid = playerUid,
    name = playerName
  }
  self:hideReportChat()
  L_GameUtil.showReportPlayerBox(data)
end

return this
