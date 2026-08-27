local DmFntThemeData = class("DmFntThemeData")

function DmFntThemeData:ctor(themeCfg, inSell, editRoomData)
  self.dmFntThemeCfg = themeCfg
  self._editRoomData = editRoomData
  self.id = themeCfg.id
  self._inSell = inSell
  local comformt = 0
  local totalNum = 0
  for fntId, num in pairs(themeCfg.theme_furniture_id) do
    local fntCfg = ConfigData.dorm_furniture[fntId]
    comformt = comformt + fntCfg.comfort * num
    totalNum = totalNum + num
  end
  self._comformt = comformt
  self._totalNum = totalNum
end

function DmFntThemeData:IsDmFntThemeInSell()
  return self._inSell
end

function DmFntThemeData:GetDmFntThemeTotalNum()
  return self._totalNum
end

function DmFntThemeData:GetDmFntThemeComformt()
  return self._comformt
end

function DmFntThemeData:GetDmFntThemeUseableNum()
  local useableNum = 0
  for fntId, num in pairs(self.dmFntThemeCfg.theme_furniture_id) do
    local fntCfg = ConfigData.dorm_furniture[fntId]
    local storageFntData = self._editRoomData:GetDmStorageFntData(fntId)
    if storageFntData ~= nil then
      useableNum = useableNum + math.min(storageFntData.count, num)
    end
  end
  return useableNum
end

return DmFntThemeData
