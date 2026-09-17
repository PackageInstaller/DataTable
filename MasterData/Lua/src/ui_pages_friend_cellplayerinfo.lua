local this = class("cellPlayerInfo", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {photoEntity = nil}
end

function this.bind()
  return {
    cellChatHead = {
      moduleName = "pages/chat/cellChatHead"
    },
    txt_name = "",
    img_headIcon = "",
    txt_level = "",
    txt_title = "",
    active_title = true,
    active_noTitile = false,
    go_state = false,
    txt_state = "",
    operate_friend = false,
    operate_apply = false,
    operate_add = false,
    operate_black = false,
    obj_btn_send = true,
    obj_txt_send = false,
    txt_achievement = "",
    active_empty = false,
    active_bg = true,
    active_headImg = true,
    active_name = true,
    active_level = false,
    active_head = true,
    active_operation = true,
    active_star = false
  }
end

function this.methods()
  return {
    onClick_agree = function(self)
      self:emit("onClick_agree", self.bind.uid)
    end,
    onClick_refuse = function(self)
      self:emit("onClick_refuse", self.bind.uid)
    end,
    onClick_apply = function(self)
      self:emit("onClick_apply", self.bind.uid, function()
        self.bind.obj_btn_send = false
        self.bind.obj_txt_send = true
      end)
    end,
    onClick_removeBlack = function(self)
      self:emit("onClick_removeBlack", self.bind.uid)
    end
  }
end

function this:refresh()
  if self.bind.is_empty then
    return
  end
  if not self.bind.txt_title or string.isEmpty(self.bind.txt_title) or self.bind.txt_title == L_WordsTpl:getValue("residual_code_cellfriendchatinfo_01") then
    self.bind.active_title = false
    self.bind.active_noTitile = true
  else
    self.bind.active_title = true
    self.bind.active_noTitile = false
  end
  local baseInfo = self.bind.baseInfo
  baseInfo = baseInfo or L_FriendStore:getPlayerBaseInfo(self.bind.uid)
  baseInfo = baseInfo or L_FriendStore:getRecommandFriendBaseInfo(self.bind.uid)
  if not baseInfo then
    return
  end
  self.modules.cellChatHead:refreshWithId(self.bind.uid)
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

function this:preOpen()
  local str = self.bind.txt_state
  str = L_GameUtil.clearColor(str)
  str = L_GameUtil.fillColor(str, "#ffffff80")
  self.bind.txt_state = str
end

return this
