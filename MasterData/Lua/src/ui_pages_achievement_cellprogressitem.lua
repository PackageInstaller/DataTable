local this = class("cellProgressItem", G_UIModuleBase)

function this.bind()
  return {img_icon = "", txt_progress = ""}
end

function this.methods()
  return {
    onClick_select = function(self)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_achievement"))
    end
  }
end

return this
