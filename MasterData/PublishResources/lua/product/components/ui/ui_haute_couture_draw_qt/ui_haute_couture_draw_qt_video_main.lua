require("ui_haute_couture_draw_video_base")
_class("UIHauteCoutureDraw_QT_VideoMain", UIHauteCoutureDrawVideoBase)
UIHauteCoutureDraw_QT_VideoMain = UIHauteCoutureDraw_QT_VideoMain

function UIHauteCoutureDraw_QT_VideoMain:Constructor()
end

function UIHauteCoutureDraw_QT_VideoMain:OnShow(uiParams)
  self:InitWidgets()
  self:_LoadVideo()
end

function UIHauteCoutureDraw_QT_VideoMain:InitWidgets()
  self:InitWidgetsBase()
end
