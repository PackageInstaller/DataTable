taptapAward = {}

taptapAward.TaptapAwardPanel = require("game/taptapAward/view/TaptapAwardPanel")

taptapAward.TaptapAwardManager = require("game/taptapAward/manager/TaptapAwardManager").new()
taptapAward.TaptapAwardController = require("game/taptapAward/controller/TaptapAwardController").new(taptapAward.TaptapAwardManager)

local module = {taptapAward.TaptapAwardController}
return module