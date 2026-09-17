local this = class("cellEmotion", G_UIModuleBase)
local emojiTpl = L_GameTpl:getChatEmojiTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    curFrameIndex = 1,
    maxFrame = 1,
    isAni = false
  }
end

function this.bind()
  return {
    txt_name = "",
    img_emotion = "",
    frameCountPerRow = 0,
    frameCountPerCol = 0,
    frameCount = 0,
    frameAniFps = 8,
    frameAnimParamsComplete = false,
    go_selectFrame = false,
    go_selectBg = false,
    go_numBg = false,
    go_frame = false,
    go_add = false,
    txt_selectId = "",
    go_empty = false,
    go_emotion = true,
    go_highLight = true
  }
end

function this:refresh()
  if self.bind.isInPageEdit == true then
    self:initImage()
    return
  end
  if self.bind.first then
    self.bind.go_add = true
    self.bind.go_frame = false
  else
    self.bind.go_add = false
    self.bind.go_frame = true
  end
  local iconRectTrans = self.bindComponents.iconRectTrans
  if self.bind.isEditButton == true then
    iconRectTrans.anchorMin = C_Vector2(0.5, 0.5)
    iconRectTrans.anchorMax = C_Vector2(0.5, 0.5)
    iconRectTrans.sizeDelta = C_Vector2(137, 152)
    iconRectTrans.anchoredPosition = C_Vector2(0, 0)
    iconRectTrans.pivot = C_Vector2(0.5, 0.5)
  else
    iconRectTrans.anchorMin = C_Vector2(0.5, 1)
    iconRectTrans.anchorMax = C_Vector2(0.5, 1)
    iconRectTrans.sizeDelta = C_Vector2(180, 180)
    iconRectTrans.anchoredPosition = C_Vector2(0, 0)
    iconRectTrans.pivot = C_Vector2(0.5, 1)
  end
  if self.bind.id then
    self:initImage()
  end
  if not self.bind.isEditButton and self.bind.groupId ~= nil and 1 < self.bind.groupId then
    local id = self.bind.id
    self:registerReddot(self.bindComponents.reddotNew, string.format(L_ReddotManager.DotDef.NewEmoji, id))
  else
    self.bindComponents.reddotNew.gameObject:SetActive(false)
  end
  self:newOrResetTimer("setEmotionIconColor", function()
    if self.bindComponents.imgIcon then
      self.bindComponents.imgIcon.color = C_Color(1, 1, 1, 1)
    end
  end, 0.1)
end

function this:initImage()
  if self.bind.id > 0 then
    self.bind.go_empty = false
    self.bind.go_emotion = true
    self.bind.go_highLight = true
    self.bind.go_frame = true
    local tpl = emojiTpl:getTplById(self.bind.id)
    self.bind.txt_name = emojiTpl:getName(tpl)
    self.bind.img_emotion = emojiTpl:getResource(tpl)
    self.bind.frameCount = emojiTpl:getMaxFrame(tpl)
    self.bind.frameCountPerRow = emojiTpl:getFramePerRow(tpl)
    self.bind.frameCountPerCol = emojiTpl:getFramePerCol(tpl)
    self.bind.frameAnimParamsComplete = true
  else
    self.bind.go_empty = true
    self.bind.go_emotion = false
    self.bind.go_highLight = false
    self.bind.go_frame = false
  end
end

function this.methods()
  return {
    onClick_select = function(self)
      self:emit("onClick_select", self.bind)
    end,
    onPointEnter = function(self)
      L_AudioUtil.playSound("Play_SFX_System_UI_Chat_QuickPhrase_Hover")
    end
  }
end

function this:setAnimActive(isActive)
  if self.bindComponents.anim then
    self.bindComponents.anim:SetActive(isActive)
  end
end

return this
