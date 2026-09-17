local this = class("pageMeetingLine", G_UIPageBase)
local wordsTpl = L_GameTpl:getWordsTpl()

function this.bind()
  return {
    txtLine = L_WordsTpl:getValue("notice_line_02"),
    module_commonTipBoard = L_Const.ModuleInfo.CommonTipBoard
  }
end

function this.methods()
  return {
    onClick_ok = function(self)
      local lineId = tonumber(self.bindComponents.iptLine.text)
      if lineId and 0 < lineId and lineId <= 1000 then
      else
        L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_lobby_noline"))
      end
    end,
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_close2 = function(self)
      L_UI:close(self.pageName)
    end,
    onValueChange_input = function(self, value)
      if string.isEmpty(self.bindComponents.iptLine.text) then
        return
      end
      local lineId = tonumber(value)
      if lineId == nil or lineId <= 0 then
        L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_lobby_noline"))
        self.bindComponents.iptLine.text = ""
      end
    end
  }
end

function this:preOpen(option)
  this.super.preOpen(option)
end

function this:close(options)
  this.super.close(self, options)
end

return this
