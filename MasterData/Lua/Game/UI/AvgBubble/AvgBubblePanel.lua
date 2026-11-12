local AvgBubblePanel = class("AvgBubblePanel", BasePanel)
AvgBubblePanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
AvgBubblePanel._bAddToBackHistory = false
AvgBubblePanel._tbDefine = {
  {
    sPrefabPath = "AvgBubble/AvgBubbleUI.prefab",
    sCtrlName = "Game.UI.AvgBubble.AvgBubbleCtrl"
  }
}

function AvgBubblePanel:Awake()
  self.sAvgBBCmdCfgPath = nil
  self.tbAvgBBCmdCfg = {}
  self.nBubbleType = 1
  local tbParam = self:GetPanelParam()
  self.sAvgId = tbParam[1]
  self.sGroupId = tostring(tbParam[2])
  self.nCurLanguageIdx = GetLanguageIndex(tbParam[3])
  self.sTxtLan = tbParam[3]
  self.sVoLan = tbParam[4]
  self.bIsPlayerMale = PlayerData.Base:GetPlayerSex() == true
  self.bParseSuc = self:ParseAvgBubbleConfig()
end

function AvgBubblePanel:OnEnable()
  if self.bParseSuc == false then
    EventManager.Hit(EventId.AvgBubbleExit)
    NovaAPI.DispatchEventWithData("AVG_BB_END", nil, string.format("%s|%s", self.sAvgId, tostring(self.sGroupId)))
  end
end

function AvgBubblePanel:OnDestroy()
  self.tbAvgBBCmdCfg = nil
  if self.sAvgBBCmdCfgPath ~= nil then
    package.loaded[self.sAvgBBCmdCfgPath] = nil
    self.sAvgBBCmdCfgPath = nil
  end
end

function AvgBubblePanel:ParseAvgBubbleConfig()
  self.sAvgBBCmdCfgPath = GetAvgLuaRequireRoot(self.nCurLanguageIdx) .. "Config/" .. self.sAvgId
  local ok, tbEntireAvgBBCmdCfg = pcall(require, self.sAvgBBCmdCfgPath)
  if not ok then
    printError("AvgId对应的配置文件没有找到,path:" .. self.sAvgBBCmdCfgPath .. ". error: " .. tbEntireAvgBBCmdCfg)
    return false
  else
    local bMatch = false
    for _, v in ipairs(tbEntireAvgBBCmdCfg) do
      if v.cmd == "SetGroupId" then
        if self.sGroupId == "PLAY_ALL_PLAY_ALL" then
          bMatch = true
        else
          bMatch = tostring(v.param[1]) == self.sGroupId
        end
      end
      if bMatch == true then
        if v.cmd == "SetBubbleUIType" then
          self.nBubbleType = v.param[1]
        elseif v.cmd == "SetBubble" then
          table.insert(self.tbAvgBBCmdCfg, v)
        end
      end
    end
    if #self.tbAvgBBCmdCfg > 0 then
      return true
    else
      printError(string.format("此AVG气泡指令配置文件里,该组未找到任何数据,path:%s, groupId:%s", self.sAvgBBCmdCfgPath, self.sGroupId))
      return false
    end
  end
end

return AvgBubblePanel
