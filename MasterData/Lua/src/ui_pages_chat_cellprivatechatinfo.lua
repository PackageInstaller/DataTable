local this = class("cellPrivateChatInfo", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {photoEntity = nil}
end

function this.bind()
  return {
    cellChatHead = {
      moduleName = "pages/chat/cellChatHead"
    },
    item_id = 1,
    go_select = false,
    go_unselect = false,
    txt_name = "",
    img_headIcon = "",
    txt_level = "",
    go_state = false,
    txt_state = "",
    active_title = true,
    txt_title = L_WordsTpl:getValue("ui_systemMessage_18"),
    color_bgimg = C_Color.white,
    go_noTitle = false,
    txt_txtNoTitle = "",
    color_txtNoTitle = C_Color.white,
    color_txtNoTitleBg = C_Color.white,
    img_state = "",
    active_img_state = false,
    color_name = C_Color.white
  }
end

function this.methods()
  return {
    onClick_Head = function(self)
      self:emit("onClick_head", self.bind.uid)
    end,
    onClick_Chat = function(self)
    end,
    cellChatHead = {
      onClick = function(self, bind)
        self:emit("onClick_head", self.bind.uid)
      end
    }
  }
end

function this:refresh()
  self.bind.item_id = self.bind.uid
  if self.bindComponents.reddotSmall then
    self:registerReddot(self.bindComponents.reddotSmall, string.format(L_ReddotManager.DotDef.FriendPrivateChat_Player, self.bind.uid))
  end
  if self.bindComponents.state then
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.state)
  end
  self.bind.active_title = false
  self.bind.go_noTitle = true
  self.modules.cellChatHead:refreshWithId(self.bind.uid)
  local isSelect = self.curUid == self.bind.uid
  if not self.bind.state_online then
    local _, maskColor1 = C_ColorUtility.TryParseHtmlString("#e9e9e666")
    local _, maskColor2 = C_ColorUtility.TryParseHtmlString("#3d3d3c66")
    local maskColor = isSelect and maskColor1 or maskColor2
    self.modules.cellChatHead:setMask(true, maskColor)
  else
    self.modules.cellChatHead:setMask(false)
  end
end

function this:close()
  if self.headTex then
    C_PhotoManager.ReleaseTexture(self.headTex)
    self.headTex = nil
  end
end

function this:setHeadPic(headPath)
  if not string.isEmpty(headPath) then
    self.bind.img_headIcon = headPath
  else
  end
end

function this:setHeadSprite(tex)
  if self.bindComponents.img_headTex ~= nil and tex ~= nil then
    local rect = C_Rect(0, 0, tex.width, tex.height)
    local pivot = C_Vector2.one * 0.5
    self.bindComponents.img_headTex.sprite = Unity.Sprite.Create(tex, rect, pivot)
    return true
  end
  return false
end

function this:refreshSelect(curUid)
  self.curUid = curUid
  if not self.isBind then
    return
  end
  local isSelect = curUid == self.bind.uid
  local str = self.bind.txt_state
  local stateOutlineColor
  if str and self.bind.state_busy then
    str = L_GameUtil.clearColor(self.bind.txt_state)
    if isSelect then
      str = L_GameUtil.fillColor(str, "#f77575")
      local _, outlineColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
      stateOutlineColor = outlineColor
      self.bind.img_state = "UI/Atlas/Chat/tex_chat_icon_state_02_busy.png"
    else
      str = L_GameUtil.fillColor(str, "#ff7e7e")
      local _, outlineColor = C_ColorUtility.TryParseHtmlString("#2226287c")
      stateOutlineColor = outlineColor
      self.bind.img_state = "UI/Atlas/Chat/tex_chat_icon_state_01_busy.png"
    end
    self.bind.active_img_state = true
  elseif str and self.bind.state_online then
    str = L_GameUtil.clearColor(self.bind.txt_state)
    if isSelect then
      str = L_GameUtil.fillColor(str, "#2bb478")
      local _, outlineColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
      stateOutlineColor = outlineColor
      self.bind.img_state = "UI/Atlas/Chat/tex_chat_dec_friend_pop_star_02.png"
    else
      str = L_GameUtil.fillColor(str, "#2bb478")
      local _, outlineColor = C_ColorUtility.TryParseHtmlString("#2226287c")
      stateOutlineColor = outlineColor
      self.bind.img_state = "UI/Atlas/Chat/tex_chat_dec_friend_pop_star_01.png"
    end
    self.bind.active_img_state = true
  elseif str and self.bind.state_offline then
    str = L_GameUtil.clearColor(self.bind.txt_state)
    if isSelect then
      str = L_GameUtil.fillColor(str, "#a6a5a5")
      local _, outlineColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
      stateOutlineColor = outlineColor
    else
      str = L_GameUtil.fillColor(str, "#a6a5a5")
      local _, outlineColor = C_ColorUtility.TryParseHtmlString("#2226287c")
      stateOutlineColor = outlineColor
    end
    self.bind.active_img_state = false
  end
  self.bind.txt_state = str
  if stateOutlineColor then
    self.bindComponents.txt_state.style.useOutline = true
    self.bindComponents.txt_state.style.outlineColor = stateOutlineColor
    self.bindComponents.txt_state.style.outlineWidth = 0.4
    self.bindComponents.txt_state:RefreshStyle()
  end
  if not self.bind.state_online then
    local _, maskColor1 = C_ColorUtility.TryParseHtmlString("#e9e9e666")
    local _, maskColor2 = C_ColorUtility.TryParseHtmlString("#3d3d3c66")
    local maskColor = isSelect and maskColor1 or maskColor2
    self.modules.cellChatHead:setMask(true, maskColor)
  else
    self.modules.cellChatHead:setMask(false)
  end
  local name = L_GameUtil.clearColor(self.bind.txt_name)
  local flag, nameColor, nameOutlineColor
  if self.bind.is_mark then
    if isSelect then
      flag, nameColor = C_ColorUtility.TryParseHtmlString("#04a5e1cc")
      local _, outlineColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
      nameOutlineColor = outlineColor
    else
      flag, nameColor = C_ColorUtility.TryParseHtmlString("#3fc4f6")
      local _, outlineColor = C_ColorUtility.TryParseHtmlString("#222628")
      nameOutlineColor = outlineColor
    end
  elseif isSelect then
    flag, nameColor = C_ColorUtility.TryParseHtmlString("#222628cc")
    local _, outlineColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
    nameOutlineColor = outlineColor
  else
    flag, nameColor = C_ColorUtility.TryParseHtmlString("#ffffff")
    local _, outlineColor = C_ColorUtility.TryParseHtmlString("#222628cc")
    nameOutlineColor = outlineColor
  end
  self.bind.txt_name = name
  self.bind.color_name = nameColor
  if nameOutlineColor then
    self.bindComponents.txt_name.style.useOutline = true
    self.bindComponents.txt_name.style.outlineColor = nameOutlineColor
    self.bindComponents.txt_name.style.outlineWidth = 0.4
    self.bindComponents.txt_name:RefreshStyle()
  end
  if not self.bind.txt_title or string.isEmpty(self.bind.txt_title) or self.bind.txt_title == L_WordsTpl:getValue("residual_code_cellfriendchatinfo_01") then
    self.bind.go_noTitle = true
    self.bind.active_title = false
  else
    self.bind.go_noTitle = false
    self.bind.active_title = true
  end
  self.bind.go_select = isSelect
  self.bind.go_unselect = not isSelect
  self.bind.txt_txtNoTitle = L_WordsTpl:getValue("residual_code_cellprivatechatinfo_01")
  if isSelect then
    local _, colorTxtNoTitle = C_ColorUtility.TryParseHtmlString("#ffffffbf")
    self.bind.color_txtNoTitle = colorTxtNoTitle
    local _, colorBg = C_ColorUtility.TryParseHtmlString("#6d6d6d40")
    self.bind.color_txtNoTitleBg = colorBg
  else
    local _, colorTxtNoTitle = C_ColorUtility.TryParseHtmlString("#FFFFFF40")
    self.bind.color_txtNoTitle = colorTxtNoTitle
    local _, colorBg = C_ColorUtility.TryParseHtmlString("#6d6d6d7d")
    self.bind.color_txtNoTitleBg = colorBg
  end
end

function this:setFrame(framePath)
  if not string.isEmpty(framePath) then
    self.bind.active_frame = true
    self.bindComponents.img_Frame:LoadSprite(framePath, false)
  else
    self.bind.active_frame = false
  end
end

function this:setFrameBg(frameBgPath)
  if not string.isEmpty(frameBgPath) then
    self.bind.active_frame = true
    self.bindComponents.img_FrameBg:LoadSprite(frameBgPath, false)
  else
    self.bind.active_frame = false
  end
end

return this
