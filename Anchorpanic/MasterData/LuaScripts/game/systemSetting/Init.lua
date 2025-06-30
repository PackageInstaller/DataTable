systemSetting = {}
-- const
require("game/systemSetting/manager/SystemSettingConst")
--manager
systemSetting.SystemQualityVo = require("game/systemSetting/manager/vo/SystemQualityVo")
systemSetting.SystemDeviceQualityVo = require("game/systemSetting/manager/vo/SystemDeviceQualityVo")
systemSetting.SystemSettingManager = require("game/systemSetting/manager/SystemSettingManager").new()

systemSetting.systemSettingPanel = require('game/systemSetting/view/systemSettingPanel')
systemSetting.QualitySettingTabView = require('game/systemSetting/view/QualitySettingTabView')
systemSetting.SoundSettingTabView = require('game/systemSetting/view/SoundSettingTabView')
systemSetting.OtherSettingTabView = require('game/systemSetting/view/OtherSettingTabView')

--controller
local _c = require('game/systemSetting/controller/SystemSettingController').new(systemSetting.SystemSettingManager)
local module = {_c}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
