local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    parsedLetters = {},
    letterMap = {}
  }
end

return this
