local this = class("cellChatEmotion", G_UIModuleBase)
local _emojiTpl = L_GameTpl:getChatEmojiTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    photoEntity = nil,
    curFrameIndex = 1,
    maxFrame = 1,
    isAni = false
  }
end

function this.bind()
  return {
    moduleBaseInfo = {
      moduleName = "pages/chat/moduleChatBaseInfo"
    },
    txt_name = "",
    txt_title = "",
    txt_level = "",
    img_emotion = "",
    frameCountPerRow = 0,
    frameCountPerCol = 0,
    frameCount = 0,
    frameAnimParamsComplete = false,
    frameAniFps = 8,
    txt_nameColor = C_Color(1, 1, 1, 1)
  }
end

function this.methods()
  return {
    moduleBaseInfo = {
      onClick_head = function(self)
        if L_PlayerStore:getPlayerId() == self.bind.playerUid then
          return
        end
        self:emit("onClick_head", self.bind.playerUid)
      end
    },
    btn_clickEmotion = function(self)
      if self.emojiId then
        local hasOrNotEmoji = L_ChatStore:checkEmojiOwnedDic(self.emojiId)
        L_UI:open("pageChatEmotion", {
          emojiId = self.emojiId,
          emojiCallBack = self.bind.emojiCallBack,
          hasOrNotEmoji = hasOrNotEmoji
        })
      end
    end
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
  self.emojiId = tonumber(L_ChatStore:getMessageMsg(self.bind.serverData))
  local tpl = _emojiTpl:getTplById(self.emojiId)
  self.bind.img_emotion = _emojiTpl:getResource(tpl)
  self.bind.frameCount = _emojiTpl:getMaxFrame(tpl)
  self.bind.frameCountPerRow = _emojiTpl:getFramePerRow(tpl)
  self.bind.frameCountPerCol = _emojiTpl:getFramePerCol(tpl)
  self.bind.frameAnimParamsComplete = true
  if self.playInitFXNextRefresh then
    self:playInitFX()
  end
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

function this:unBind()
  self.playInitFXNextRefresh = false
end

return this
