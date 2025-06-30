--[[  AutoScript 自动脚本 
----------------------------------------------------- 
   @CreateTime:2021/4/6 14:19:18 
   @Author:Shenxintian 
   @Copyright: (LY)2021 雷焰网络 
   @Description:广告牌展示 I
]] 

ikon = {}

ikon.IkonManager = require("game/ikon/manager/IkonManager").new()

ikon.IkonView = "game/ikon/view/IkonView"

local _c = require('game/ikon/controller/IkonController').new(ikon.IkonManager)

local module = { _c }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
