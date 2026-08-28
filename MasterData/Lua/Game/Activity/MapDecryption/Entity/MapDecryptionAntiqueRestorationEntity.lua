

---@class MapDecryptionAntiqueRestorationEntity
local MapDecryptionAntiqueRestorationEntity = Class('MapDecryptionAntiqueRestorationEntity')


function MapDecryptionAntiqueRestorationEntity:__init()
    ---------------------------------------
    --- server data
    self.antiqueId        = 0        --- 古物id
    self.status           = 0        --- 古物状态 0:未获得 1:未修复 2:已修复
    
    ---------------------------------------
    --- config data
    self.antiqueRestorationVo = nil  

    ---------------------------------------
    --- custom data
    self.isFinal           = false --- 是否最后一个
end


function MapDecryptionAntiqueRestorationEntity:__delete()

end

---Fill
---填充数据
---@param antiqueRestorationVo     MapDecryptionAntiqueRestorationVo
---@param restoreFlag number 修复标识
function MapDecryptionAntiqueRestorationEntity:Fill(antiqueRestorationVo, restoreFlag)
    local antiqueId = checkNumber(antiqueRestorationVo.antiqueId)
    self.antiqueId  = antiqueId
    self.antiqueRestorationVo = antiqueRestorationVo
    self.isFinal = false

    -- 古物状态 0:未获得 1:未修复 2:已修复
    local status = 0
    local isRestore = checkNumber(restoreFlag) == 1
    if isRestore then
        status = 2

    else
        status = GoodsUtils.GetThingNo(antiqueId) >= 1 and 1 or 0
        
    end

    self.status    = status

    
    return self
end

---Fill
---填充数据
---@param antiqueRestorationVo     MapDecryptionAntiqueRestorationVo
function MapDecryptionAntiqueRestorationEntity:FillFinalAntique(antiqueRestorationVo, isStuffAll)
    local antiqueId = checkNumber(antiqueRestorationVo.antiqueId)
    self.antiqueId  = antiqueId
    self.antiqueRestorationVo = antiqueRestorationVo
    self.isFinal = true

    local status = 0
    --- 古物状态 0:未获得 1:未合成 2:已合成
    local ownNum = GoodsUtils.GetThingNo(antiqueId)
    if ownNum >= 1 then
        status = 2

    else
        status = isStuffAll and 1 or 0

    end
    self.status = status

    return self
end


return MapDecryptionAntiqueRestorationEntity
