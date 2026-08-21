sdk = {}
require('game/sdk/manager/SdkConst')
sdk.SdkController = require("game/sdk/controller/SdkController").new()
sdk.SdkManager = require("game/sdk/manager/SdkManager").new()

sdk.ChannelData = require("game/sdk/manager/ChannelData").new()
 
--[[ 替换语言包自动生成，请勿修改！
]]
