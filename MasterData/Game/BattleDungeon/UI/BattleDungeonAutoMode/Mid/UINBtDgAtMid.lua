local base = UIBaseNode
local UINBtDgAtMid = class("UINBtDgAtMid", base)
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local cs_MessageCommon = CS.MessageCommon

function UINBtDgAtMid:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._decomposeAthTog = UINCommonSwitchToggle.New()
  self._decomposeAthTog:Init(self.ui.tog_DecomposeAth)
  self.__OnClickDecomposeAthTogFunc = BindCallback(self, self._OnClickDecomposeAthTog)
  self._buffTimesTog = UINCommonSwitchToggle.New()
  self._buffTimesTog:Init(self.ui.tog_BuffTimes)
  self._buffTimesTog:CommonSwitchTogAutoSetValue(false)
  self._switchBuffTimesFunc = BindCallback(self, self._OnClickSwitchBuffTimes)
end

function UINBtDgAtMid:InitBtDgAtMid(dungeonData, updCurTimesCheckFunc)
  self._dungeonData = dungeonData
  self._updCurTimesCheckFunc = updCurTimesCheckFunc
  local win = UIManager:GetWindow(UIWindowTypeID.ATHDungeon)
  if win == nil then
    return
  end
  local currentIsOn = win:GetDecomposeActive()
  self._decomposeAthTog:InitCommonSwitchToggle(currentIsOn, self.__OnClickDecomposeAthTogFunc)
  self:_UpdATHDgFBuffTimes()
end

function UINBtDgAtMid:_OnClickDecomposeAthTog(isOn)
  local win = UIManager:GetWindow(UIWindowTypeID.ATHDungeon)
  if win == nil then
    return
  end
  win:AthDgSwitchDecompose(isOn)
end

function UINBtDgAtMid:_OnBuffTimesChange(mouduleIdDic)
  local dropCfg = self._dungeonData:GetDgDataDropCfg()
  if dropCfg == nil then
    return
  end
  local mouduleId = ControllerManager:GetController(ControllerTypeId.TimePass):GetTimePassElemId(proto_object_CounterModule.CounterModuleDungeonPeriodDropTimes, dropCfg.save_id)
  if mouduleIdDic[mouduleId] == nil then
    return
  end
  self:_UpdATHDgFBuffTimes()
end

function UINBtDgAtMid:_UpdATHDgFBuffTimes()
  local dropCfg = self._dungeonData:GetDgDataDropCfg()
  if dropCfg == nil then
    self.ui.tog_BuffTimes.transform.parent.gameObject:SetActive(false)
    self.ui.tex_TipBuffNum.transform.parent.gameObject:SetActive(false)
    self._dropBuffRemainNum = nil
    return
  end
  self.ui.tog_BuffTimes.transform.parent.gameObject:SetActive(true)
  local useNum = ControllerManager:GetController(ControllerTypeId.TimePass):GetDungeonPeriodDropTimes(dropCfg.save_id)
  local numAdd = PlayerDataCenter.playerBonus:GetDungeonDropNumAdd(dropCfg.id)
  local remainNum = dropCfg.drop_times + numAdd - useNum
  self._dropBuffRemainNum = remainNum
  self.ui.tex_BuffTimes:SetIndex(dropCfg.reset_times_point, tostring(remainNum))
  local win = UIManager:GetWindow(UIWindowTypeID.ATHDungeon)
  if win == nil then
    return
  end
  local dropBuffActive = win:GetDgDropBuffActive()
  self._buffTimesTog:InitCommonSwitchToggle(dropBuffActive, self._switchBuffTimesFunc)
  self.ui.tex_TipBuffNum.transform.parent.gameObject:SetActive(dropBuffActive)
end

function UINBtDgAtMid:_OnClickSwitchBuffTimes(isOn)
  if self._dropBuffRemainNum <= 0 then
    return
  end
  self._buffTimesTog:SetCommonSwitchToggleValue(isOn)
  self.ui.tex_TipBuffNum.transform.parent.gameObject:SetActive(isOn)
  if isOn and self._updCurTimesCheckFunc then
    self._updCurTimesCheckFunc()
  end
  local win = UIManager:GetWindow(UIWindowTypeID.ATHDungeon)
  if win == nil then
    return
  end
  win:AthDgSwitchDropBuff(isOn)
end

function UINBtDgAtMid:UpdBtDgAtMidTipBuffNum(num)
  local value = 0
  if self._buffTimesTog:GetCommonSwitchToggleValue() then
    value = math.min(self._dropBuffRemainNum, num)
  end
  self.ui.tex_TipBuffNum:SetIndex(0, tostring(value))
end

function UINBtDgAtMid:GetBtDgAtMidValue()
  return self._buffTimesTog:GetCommonSwitchToggleValue(), self._decomposeAthTog:GetCommonSwitchToggleValue()
end

function UINBtDgAtMid:CheckBtDgAtMidBuffNumOpen(callback)
  if 0 < (self._dropBuffRemainNum or 0) and not self._buffTimesTog:GetCommonSwitchToggleValue() then
    local info = ConfigData:GetTipContent(2101)
    local dungeonName = self._dungeonData:GetDungeonName()
    info = string.format(info, dungeonName, tostring(self._dropBuffRemainNum))
    cs_MessageCommon.ShowMessageBox(info, function()
      self:_OnClickSwitchBuffTimes(true)
    end, callback)
    return
  end
  callback()
end

function UINBtDgAtMid:CheckBtDgAtMidAutoNum(num)
  if self._buffTimesTog:GetCommonSwitchToggleValue() and num > self._dropBuffRemainNum then
    num = self._dropBuffRemainNum
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2908))
  end
  return num
end

function UINBtDgAtMid:OnShow()
  base.OnShow(self)
  self._OnBuffTimesChangeFunc = BindCallback(self, self._OnBuffTimesChange)
  self._UpdATHDgFBuffTimesFunc = self._UpdATHDgFBuffTimesFunc or BindCallback(self, self._UpdATHDgFBuffTimes)
  MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitChange, self._UpdATHDgFBuffTimesFunc)
end

function UINBtDgAtMid:OnHide()
  MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange, self._UpdATHDgFBuffTimesFunc)
  base.OnHide(self)
end

function UINBtDgAtMid:OnDelete()
  base.OnDelete(self)
end

return UINBtDgAtMid
