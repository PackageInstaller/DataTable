local this = class("moduleInput", G_UIModuleBase)

function this.bind()
  return {txt_input = nil, go_del = false}
end

function this.methods()
  return {
    onValueChanged_sendInput = function(self, value)
      print("======================valuechange")
      if not self.limit or self.limit <= 0 then
        return
      end
      if 0 < C_LuaUtility.StringLength(value) then
        self.bind.go_del = true
      else
        self.bind.go_del = false
      end
      if C_LuaUtility.StringLength(value) > self.limit then
        self.bindComponents.input_text.text = C_LuaUtility.StringSub(value, 0, self.limit)
        local limit = L_GameTpl:getGameConstTpl():getMaxChat() > self.limit and self.limit or L_GameTpl:getGameConstTpl():getMaxChat()
        L_FlyMsgManager:showNormalMsgByKey("tips_chat_maxnum", {
          [0] = limit
        })
      end
    end,
    onClick_del = function(self)
      self.bindComponents.input_text.text = ""
      if self.del_callBack then
        self.del_callBack()
      end
      print("======================clickdel")
    end,
    onClick_search = function(self)
      print("======================clicksearch")
      if self.search_callBack then
        self.search_callBack(self.bindComponents.input_text.text)
      end
    end
  }
end

function this:open(options)
end

function this:close()
end

function this:setData(param)
  self.limit = param.limit
  self.del_callBack = param.del_callBack
  self.search_callBack = param.search_callBack
end

return this
