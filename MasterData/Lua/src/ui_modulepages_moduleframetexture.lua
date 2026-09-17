local this = class("moduleFrameTexture", G_UIModuleBase)
local FrameTpl = L_GameTpl:getFrameTextureTpl()

function this.bind()
  return {
    textureName = "",
    col = 1,
    row = 1,
    frameCount = 1,
    fps = 1,
    setComplete = false
  }
end

function this.methods()
  return {}
end

function this:setFrameId(id)
  if self._id == id then
    return
  end
  self._id = id
  local tpl = FrameTpl:getTplById(id)
  if not tpl then
    self.bind.textureName = ""
    return
  end
  self.bind.textureName = FrameTpl:getFrameImage(tpl)
  self.bind.col = FrameTpl:getColumn(tpl)
  self.bind.row = FrameTpl:getRow(tpl)
  self.bind.frameCount = FrameTpl:getFrameNum(tpl)
  self.bind.fps = FrameTpl:getFps(tpl)
  self.bind.setComplete = true
end

function this:setImage(path, col, row, count, fps)
  if self.bind.textureName == path then
    return
  end
  self._id = math.mininteger
  self.bind.textureName = path
  col = col or 1
  row = row or 1
  self.bind.col = col
  self.bind.row = row
  self.bind.frameCount = count or col * row
  self.bind.fps = fps or 8
  self.bind.setComplete = true
end

function this:stop()
  if not self._fps then
    self._fps = self.bind.fps
    self.bind.fps = 0
  end
end

function this:play()
  if self._fps then
    self.bind.fps = self._fps
    self._fps = 0
  end
end

return this
