--[[ 
-----------------------------------------------------
@filename       : SystemDeviceQualityVo
@Description    : 设备画质默认适配配置
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.systemSetting.SystemDeviceQualityVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.deviceName = cusData.device_name
    self.cpuName = cusData.cpu_name
    self.gpuName = cusData.gpu_name
    self.deviceDes = cusData.des
    self.qualityType = cusData.sfx_quality
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
