local this = class("frameTextureTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRow(tpl)
  return tpl.row
end

function this:getColumn(tpl)
  return tpl.column
end

function this:getFps(tpl)
  return tpl.fps
end

function this:getFrameImage(tpl)
  return tpl.frameImage
end

function this:getFrameNum(tpl)
  return tpl.frameNum
end

function this:getId(tpl)
  return tpl.id
end

return this
