local this = class("modulePrice", G_UIModuleBase)

function this.bind()
  return {
    go_money = false,
    go_jump = false,
    txt_value = "",
    img_currency = ""
  }
end

function this.methods()
  return {
    onClick_Jump = function(self)
      if self.bind.go_jump == true then
        print("======================onClick_Jump")
        if self.jump_callBack then
          self.jump_callBack()
        end
      end
    end
  }
end

function this:open(options)
end

function this:close()
end

function this:setData(param, jump_callBack)
  self.bind.go_money = not param.bJump
  self.bind.go_jump = param.bJump
  self.bindComponents.mask.alpha = param.bJump and 1 or 0.5
  self.bind.txt_value = param.txt
  self.bind.img_currency = self.bind.imgCurrency
  self.jump_callBack = jump_callBack
end

return this
