local GlobalRes = "ui/global/"
local EdgeMaskLayer = class("EdgeMaskLayer")

function EdgeMaskLayer:ctor(scene)
  self.root = display.newNode():addTo(scene)
  self.root:pos(display.cx, display.cy)
  local mlayer = cc.EdgeMaskLayer:create()
  mlayer:addTo(self.root)
  local glView = cc.Director:getInstance():getOpenGLView()
  local framesize = glView:getFrameSize()
  local rect = glView:getViewPortRect()
  local scaleX = framesize.width / display.width
  local scaleY = framesize.height / display.height
  if scaleX / scaleY <= 1 then
    local top = display.newSprite("background/mask_top.jpg"):pos(0, rect.height / 2 / scaleY - 1):anch(0.5, 0):addTo(mlayer)
    local buttom = display.newSprite("background/mask_top.jpg"):pos(0, -rect.height / 2 / scaleY):anch(0.5, 1):flipY(true):addTo(mlayer)
    if framesize.width > 1400 then
      top:setScaleX(framesize.width / 1400)
      buttom:setScaleX(framesize.width / 1400)
    end
  else
    local left = display.newSprite("background/mask_left.jpg"):pos(-rect.width / 2 / scaleX, 0):anch(1, 0.5):addTo(mlayer)
    local right = display.newSprite("background/mask_left.jpg"):pos(rect.width / 2 / scaleX, 0):anch(0, 0.5):flipX(true):addTo(mlayer)
    if framesize.height > 800 then
      left:setScaleY(framesize.height / 800)
      right:setScaleY(framesize.height / 800)
    end
  end
end

return EdgeMaskLayer
