local GmModel = NewClass("GmModel", BaseModel)
local MAX_SAVE_GM_COUNT = 30

function GmModel:OnInit()
  self:OnReset()
end

function GmModel:OnReset()
  self._recentUseGm = nil
  self._mainBtnData = nil
  self._subBtnData = nil
  self._gmObjs = {}
  self._searchWord = ""
end

function GmModel:LoadRecentUseGm()
  local recent = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.RecentGm, nil)
  if type(recent) == "table" then
    self._recentUseGm = recent
  else
    self._recentUseGm = {}
  end
  return self._recentUseGm
end

function GmModel:GetRecentUseGm()
  if not self._recentUseGm then
    self:LoadRecentUseGm()
  end
  return self._recentUseGm
end

function GmModel:HasRecentUseGm()
  local recent = self:GetRecentUseGm()
  return type(recent) == "table" and next(recent) ~= nil
end

function GmModel:AddRecentGm(gmId)
  local recent = self:GetRecentUseGm()
  for k, v in ipairs(recent) do
    if tonumber(v) == gmId then
      table.remove(recent, k)
      break
    end
  end
  table.insert(recent, 1, gmId)
  if #recent > MAX_SAVE_GM_COUNT then
    table.remove(recent)
  end
end

function GmModel:SaveRecentUseGm()
  local recent = self:GetRecentUseGm()
  if next(recent) then
    MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.RecentGm, recent)
    MobileFileDataManager.Instance:OnSaveCommInfo()
  end
end

function GmModel:SetSearchWord(word)
  self._searchWord = word or ""
end

function GmModel:GetSearchWord()
  return self._searchWord or ""
end

function GmModel:BuildMainBtnData()
  local tbl = DT.GMTypeConfig
  if self._mainBtnData == nil then
    self._mainBtnData = table.clone(tbl)
  else
    table.clear(self._mainBtnData)
    for _, v in pairs(tbl) do
      table.insert(self._mainBtnData, v)
    end
  end
  local btnCount = #self._mainBtnData
  local gmConfig = GmClientUtils.GetGmConfig()
  for _, cfg in pairs(gmConfig) do
    if cfg.gmType and nil == tonumber(cfg.gmType) then
      local isFind = false
      for _, v in pairs(self._mainBtnData) do
        if v.Name == cfg.gmType then
          isFind = true
          break
        end
      end
      if not isFind then
        table.insert(self._mainBtnData, {
          TypeID = btnCount + 1,
          Name = cfg.gmType,
          Sort = cfg.id
        })
        btnCount = btnCount + 1
      end
    end
  end
  table.sort(self._mainBtnData, function(a, b)
    return a.Sort < b.Sort
  end)
  table.insert(self._mainBtnData, 1, {
    Name = "最近使用"
  })
  return self._mainBtnData
end

function GmModel:GetMainBtnData()
  if not self._mainBtnData then
    self:BuildMainBtnData()
  end
  return self._mainBtnData
end

function GmModel:BuildSubBtnData(mainType)
  if self._subBtnData == nil then
    self._subBtnData = {}
  else
    table.clear(self._subBtnData)
  end
  if 0 == mainType then
    return self._subBtnData
  end
  for _, v in pairs(DT.GMSubtypeConfig) do
    if mainType == v.TypeID then
      table.insert(self._subBtnData, v)
    end
  end
  if not DT.GMTypeConfig[mainType] then
    local subTypeCount = #self._subBtnData
    local gmConfig = GmClientUtils.GetGmConfig()
    for _, cfg in pairs(gmConfig) do
      if cfg.subtype and nil == tonumber(cfg.subtype) then
        local isFind = false
        for _, v in pairs(self._subBtnData) do
          if v.Name == cfg.subtype then
            isFind = true
            break
          end
        end
        if not isFind then
          table.insert(self._subBtnData, {
            ID = subTypeCount + 1,
            TypeID = subTypeCount + 1,
            SubtypeID = subTypeCount + 1,
            Name = cfg.subtype,
            Sort = cfg.id
          })
          subTypeCount = subTypeCount + 1
        end
      end
    end
    table.sort(self._subBtnData, function(a, b)
      return a.Sort < b.Sort
    end)
  end
  return self._subBtnData
end

function GmModel:GetSubBtnData()
  return self._subBtnData or {}
end

function GmModel:BuildGmObjsByType(mainType, subType)
  local gmObjs = {}
  local gmConfig = GmClientUtils.GetGmConfig()
  if 0 == mainType then
    local recent = self:GetRecentUseGm()
    if recent then
      for _, v in ipairs(recent) do
        local tmp = gmConfig[tonumber(v)]
        if tmp then
          table.insert(gmObjs, tmp)
        end
      end
    end
  else
    local mainBtnData = self:GetMainBtnData()
    local subBtnData = self:GetSubBtnData()
    local btnTypeCfg = mainBtnData[mainType + 1]
    local subTypeCfg = subBtnData[subType]
    if not subTypeCfg then
      self._gmObjs = gmObjs
      return
    end
    local mainTypeIndex = tostring(mainType or 1)
    for _, v in pairs(gmConfig) do
      if v.gmType == mainTypeIndex and v.subtype == subType then
        table.insert(gmObjs, v)
      elseif btnTypeCfg and v.gmType == btnTypeCfg.Name and v.subtype == subTypeCfg.Name then
        table.insert(gmObjs, v)
      end
    end
    table.sort(gmObjs, function(a, b)
      if a.order and b.order and a.order ~= b.order then
        return a.order < b.order
      end
      return a.id < b.id
    end)
  end
  self._gmObjs = gmObjs
end

function GmModel:FilterGmObjsBySearch(word)
  self._searchWord = word or ""
  local filterList = {}
  local reg = ""
  for i = 1, #word do
    reg = reg .. string.sub(word, i, i) .. ".*"
  end
  local gmConfig = GmClientUtils.GetGmConfig()
  for _, value in pairs(gmConfig) do
    if 0 == #word or string.find((value.namePingyin or "") .. (value.name or ""), reg) then
      table.insert(filterList, value)
    end
  end
  self._gmObjs = filterList
end

function GmModel:GetGmObjs()
  return self._gmObjs or {}
end

return GmModel
