_class("UIResDetailInfoCell", UICustomWidget)
UIResDetailInfoCell = UIResDetailInfoCell

function UIResDetailInfoCell:OnShow()
  self.nameTxt = self:GetUIComponent("UILocalizationText", "name")
  self.levelNumTxt = self:GetUIComponent("UILocalizationText", "levelnum")
  self.levelCNTxt = self:GetUIComponent("UILocalizationText", "levelcn")
  self.powerTxt = self:GetUIComponent("UILocalizationText", "power")
  self.warnGO = self:GetGameObject("warn")
  self.warnTxt = self:GetUIComponent("UILocalizationText", "warntxt")
  self.buffInfoBtnGo = self:GetGameObject("BuffInfoBtn")
  self._autoFightUnLock = self:GetGameObject("unlock")
  self._autoFightLock = self:GetGameObject("lock")
  self._autoFightRoot = self:GetGameObject("autoFightRoot")
  self._btnLayoutRoot = self:GetGameObject("layout")
  self._slash = self:GetGameObject("slash")
  self._doublePowerTxt = self:GetUIComponent("UILocalizationText", "doublePower")
  self.resDungeonModule = self:GetModule(ResDungeonModule)
  self.clientResInstance = self.resDungeonModule:GetClientResInstance()
  self.missionModule = self:GetModule(MissionModule)
  self:AttachEvent(GameEventType.ChangeResDouble, self.OnChangeResDouble)
  self._double = false
  self._doubleOffset = Vector3(-20, 0, 0)
  self._doubleSlashPowerColor = Color(0.3568627450980392, 0.3568627450980392, 0.3568627450980392)
  self.enableFakeInput = true
end

function UIResDetailInfoCell:OnHide()
  self:DetachEvent(GameEventType.ChangeResDouble, self.OnChangeResDouble)
end

function UIResDetailInfoCell:InitAutoFightBtnState()
  local roleMD = self:GetModule(RoleModule)
  local matchType = MatchType.MT_ResDungeon
  local param = {
    self.instanceData.cfg.ID
  }
  local enable, msg = roleMD:GetAutoFightStatusUI(param, matchType)
  self._autoBtnEnable = enable
  self._autoBtnMsg = msg
  self._autoFightRoot:SetActive(true)
  self._autoFightLock:SetActive(not self._autoBtnEnable)
  local aircraftModule = self:GetModule(AircraftModule)
  local room = aircraftModule:GetResRoom()
  local state = room and 2 or 1
  local textId = room and "str_battle_auto_fight_option_btn" or "str_common_auto_fight"
  UIWidgetHelper.SetLocalizationText(self, "_txtAutoFightBtn", StringTable.Get(textId))
end

function UIResDetailInfoCell:autoFightBtnOnClick()
  if self._autoBtnEnable then
    local id = self.instanceData:GetId()
    local power = self.instanceData:GetPower()
    local unlock = true
    local params = {
      matchType = MatchType.MT_ResDungeon,
      stageId = id,
      needPower = power,
      uuid = self.uiid,
      unlock = unlock,
      trackData = self._trackData,
      campParams = nil,
      toIndex = nil,
      checkFunction = nil,
      autoFightCallback = function(count)
        self:_DoFight(count)
      end
    }
    self:ShowDialog("UISerialAutoFightOption", params)
  else
    ToastManager.ShowToast(StringTable.Get(self._autoBtnMsg))
  end
end

function UIResDetailInfoCell:OnChangeResDouble(double)
  local power = 0
  if double then
    power = self.instanceData:GetPower() * 3
    self._doublePowerTxt:SetText(power)
    self.powerTxt.color = self._doubleSlashPowerColor
  else
    self.powerTxt.color = Color.white
  end
  self._doublePowerTxt.gameObject:SetActive(double)
  self._slash:SetActive(double)
  self._double = double
end

function UIResDetailInfoCell:Refresh(instanceData, activityawards, trackData)
  self.instanceData = instanceData
  self.activityawards = activityawards
  self._trackData = trackData
  self.uiid = self.instanceData.cfg.ID
  self.powerTxt:SetText(self.instanceData:GetPower())
  self.nameTxt:SetText(self.instanceData:GetName())
  self.levelNumTxt:SetText(self.instanceData:GetLevelNum())
  self.levelCNTxt:SetText(self.instanceData:GetLevelCN())
  local double = self.resDungeonModule:IsOpenDoubleRes()
  self:OnChangeResDouble(double)
  self:InitRewards()
  self:CheckWarn()
  self:CheckBuffIcon()
  self:InitAutoFightBtnState()
end

function UIResDetailInfoCell:btninfoOnClick(go)
  if not self.instanceData then
    return
  end
  local enemys = self.instanceData:GetEnemys()
  if not enemys then
    ToastManager.ShowToast(StringTable.Get("str_toast_manager_no_enemy_info"))
    return
  end
  local enemys = UICommonHelper:GetInstance():GetOptimalEnemys(self.instanceData:GetLevelId())
  self:ShowDialog("UIEnemyTip", enemys, 1)
end

function UIResDetailInfoCell:btngoOnClick(go)
  self:_DoFight()
end

function UIResDetailInfoCell:_DoFight(autoFightCount)
  local instanceId = self.instanceData:GetId()
  if not self:IsPowerEnough() then
    self:ShowDialog("UIGetPhyPointController")
    return
  end
  self:SetLocalDBKey()
  local ctx = self.missionModule:TeamCtx()
  local mainType = self.clientResInstance:GetMainTypeByInstanceId(instanceId)
  ctx:Init(TeamOpenerType.ResInstance, mainType)
  self:ShowDialog("UITeams", function()
    SerialAutoFightModule.QuickSetData(autoFightCount ~= nil, MatchType.MT_ResDungeon, autoFightCount)
  end)
  self.resDungeonModule:SetEnterInstanceId(instanceId)
end

function UIResDetailInfoCell:SetLocalDBKey()
  local mainType = self.instanceData:GetMainType()
  local subType = self.instanceData:GetSubType()
  local instanceId = self.instanceData:GetId()
  local key = self.clientResInstance:GetLocalDBKey(mainType, subType)
  LocalDB.SetInt(key, instanceId)
  local subKey = self.clientResInstance.resInstanceSubLocalDBKey
  LocalDB.SetInt(subKey, subType)
end

function UIResDetailInfoCell:IsPowerEnough()
  local roleModule = self:GetModule(RoleModule)
  local leftPower = roleModule:GetAssetCount(RoleAssetID.RoleAssetPhyPoint)
  if self._double then
    return leftPower >= self.instanceData:GetPower() * 2
  else
    return leftPower >= self.instanceData:GetPower()
  end
end

function UIResDetailInfoCell:InitRewards()
  local rewards = {}
  table.appendArray(rewards, self.activityawards)
  table.appendArray(rewards, self.instanceData:GetRewards())
  local count = table.count(rewards)
  if count < 1 then
    return
  end
  local sop = self:GetUIComponent("UISelectObjectPath", "Content")
  sop:SpawnObjects("UIResAward", count)
  local list = sop:GetAllSpawnList()
  for i, v in ipairs(list) do
    v:Flush(rewards[i])
  end
end

function UIResDetailInfoCell:CheckWarn()
  local mainType = self.instanceData:GetMainType()
  local id = self.instanceData:GetId()
  local open = self.instanceData:Open()
  if not open then
    self.warnGO:SetActive(true)
    self.warnTxt:SetText(self.instanceData:GetWarn())
  else
    self.warnGO:SetActive(false)
  end
end

function UIResDetailInfoCell:CheckBuffIcon()
  local open = self.instanceData:Open()
  local isPassed = self.resDungeonModule:IsResDungeonPassed(self.instanceData:GetId())
  local wordBuffId = self.instanceData:GetWorldBuffId()
  if open and isPassed and wordBuffId and 0 < wordBuffId then
    self.buffInfoBtnGo:SetActive(true)
  else
    self.buffInfoBtnGo:SetActive(false)
  end
end

function UIResDetailInfoCell:BuffInfoBtnOnClick(go)
  local buffData = {}
  buffData.name = ""
  buffData.des = ""
  local word = Cfg.cfg_word_buff[self.instanceData:GetWorldBuffId()]
  if word and word.BuffID and word.BuffID[1] then
    local buff = Cfg.cfg_buff[word.BuffID[1]]
    if buff then
      buffData.name = StringTable.Get(buff.Name)
      buffData.des = StringTable.Get(buff.Desc)
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowResDetailBuffInfo, buffData, self.buffInfoBtnGo.transform.position, Vector3(190, -30, 0))
end
