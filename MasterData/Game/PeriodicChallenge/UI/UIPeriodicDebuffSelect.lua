local UIPeriodicDebuffSelect = class("UIPeriodicDebuffSelect", UIBaseWindow)
local base = UIBaseWindow
local UINPeriodicDebuff = require("Game.PeriodicChallenge.UI.UINPeriodicDebuff")
local UINPeriodicDebuffTitle = require("Game.PeriodicChallenge.UI.UINPeriodicDebuffTitle")
local UINDungeonBuffItem = require("Game.CommonUI.DungeonState.UINDungeonBuffItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_MessageCommon = CS.MessageCommon

function UIPeriodicDebuffSelect:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_ClearAll, self, self.OnClickClear)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirm)
  UIUtil.SetTopStatus(self, self.Delete)
  self.buffItemPool = UIItemPool.New(UINPeriodicDebuff, self.ui.obj_debuffSelectItem)
  self.ui.obj_debuffSelectItem:SetActive(false)
  self.titleItemPool = UIItemPool.New(UINPeriodicDebuffTitle, self.ui.obj_debuffTitle)
  self.ui.obj_debuffTitle:SetActive(false)
  self.buffIconPool = UIItemPool.New(UINDungeonBuffItem, self.ui.img_BuffItem)
  self.ui.img_BuffItem:SetActive(false)
  self.resloader = CS.ResLoader.Create()
  self.permillageLayer = 0
  self.__OnSelectTogAction = BindCallback(self, self.OnItemValueChange)
  self.__OnPressBuffItemAction = BindCallback(self, self.__OnPressBuffItem)
  self.__OnPressUpBuffItemAction = BindCallback(self, self.__OnPressUpBuffItem)
end

function UIPeriodicDebuffSelect:InitDebuffSelect(fmtBuffSelectData, confirmFunc, closeCallback)
  self.buffIdDic = fmtBuffSelectData:GetFmtAllBuff()
  self.fmtBuffSelectData = fmtBuffSelectData
  self.closeCallback = closeCallback
  self.confirmFunc = confirmFunc
  self:CreateDebuffGroupInfo()
  self:CreateDebuffSelectInfo(fmtBuffSelectData:GetFmtBuffSelect())
  self:CreateItemList()
  self:Refresh()
  self.ui.enemyPower:SetActive(fmtBuffSelectData:IsShowEmenyPowerInFmtBuff())
end

function UIPeriodicDebuffSelect:CreateDebuffGroupInfo()
  self._debuffGroupInfo = {
    assis = {},
    normal = {},
    group = {}
  }
  for buffId, _ in pairs(self.buffIdDic) do
    if self.fmtBuffSelectData:IsFmtBuffAssis(buffId) then
      table.insert(self._debuffGroupInfo.assis, buffId)
    else
      local groupId = self.fmtBuffSelectData:GetFmtBuffGroupId(buffId)
      if groupId == nil then
        table.insert(self._debuffGroupInfo.normal, buffId)
      else
        local groupDebuffList = self._debuffGroupInfo.group[groupId]
        if groupDebuffList == nil then
          groupDebuffList = {}
          self._debuffGroupInfo.group[groupId] = groupDebuffList
        end
        table.insert(groupDebuffList, buffId)
      end
    end
  end
  
  local function Local_SortDebuff(list)
    table.sort(list, function(a, b)
      local aPermillage = self.buffIdDic[a]
      local bPermillage = self.buffIdDic[b]
      if aPermillage ~= bPermillage then
        return aPermillage < bPermillage
      end
      return a < b
    end)
  end
  
  Local_SortDebuff(self._debuffGroupInfo.assis)
  Local_SortDebuff(self._debuffGroupInfo.normal)
  for _, groupList in pairs(self._debuffGroupInfo.group) do
    Local_SortDebuff(groupList)
  end
end

function UIPeriodicDebuffSelect:CreateDebuffSelectInfo(selectedBuffIds)
  self._debuffSelectInfo = {
    selectedDic = {},
    selectedAssisBuffId = nil,
    selecedGroupDic = {}
  }
  if selectedBuffIds == nil then
    return
  end
  for _, buffId in ipairs(selectedBuffIds) do
    if self.buffIdDic[buffId] ~= nil then
      local isAssis = self.fmtBuffSelectData:IsFmtBuffAssis(buffId)
      local groupId = self.fmtBuffSelectData:GetFmtBuffGroupId(buffId)
      if (not isAssis or self._debuffSelectInfo.selectedAssisBuffId == nil) and (groupId == nil or self._debuffSelectInfo.selecedGroupDic[groupId] == nil) then
        self._debuffSelectInfo.selectedDic[buffId] = true
        if isAssis then
          self._debuffSelectInfo.selectedAssisBuffId = buffId
        end
        if groupId ~= nil then
          self._debuffSelectInfo.selecedGroupDic[groupId] = buffId
        end
      end
    end
  end
end

function UIPeriodicDebuffSelect:CreateItemList()
  self.ui.tex_Title.text = self.fmtBuffSelectData:GetFmtBuffTitle()
  self.ui.tex_Intro.text = self.fmtBuffSelectData:GetFmtBuffIntro()
  self.buffItemPool:HideAll()
  self.titleItemPool:HideAll()
  for i, buffId in ipairs(self._debuffGroupInfo.assis) do
    local item = self.buffItemPool:GetOne()
    item:InitDebuffItem(buffId, self.buffIdDic[buffId], self.__OnSelectTogAction, self._debuffSelectInfo.selectedDic[buffId], self.resloader)
  end
  for i, buffId in ipairs(self._debuffGroupInfo.normal) do
    local item = self.buffItemPool:GetOne()
    item:InitDebuffItem(buffId, self.buffIdDic[buffId], self.__OnSelectTogAction, self._debuffSelectInfo.selectedDic[buffId], self.resloader)
  end
  for _, groupId in ipairs(self.fmtBuffSelectData:GetFmtBuffGroupOrder()) do
    local groupBuffList = self._debuffGroupInfo.group[groupId]
    if groupBuffList ~= nil then
      local titleName = self.fmtBuffSelectData:GetFmtBuffGroupName(groupId)
      if titleName ~= 0 then
        local titleItem = self.titleItemPool:GetOne()
        titleItem:SetDebuffTitle(self.fmtBuffSelectData:GetFmtBuffGroupName(groupId))
      end
      for _, buffId in ipairs(groupBuffList) do
        local item = self.buffItemPool:GetOne()
        item:InitDebuffItem(buffId, self.buffIdDic[buffId], self.__OnSelectTogAction, self._debuffSelectInfo.selectedDic[buffId], self.resloader)
      end
    end
  end
end

function UIPeriodicDebuffSelect:Refresh()
  self.buffIconPool:HideAll()
  local permillageAll = 0
  for buffId, _ in pairs(self._debuffSelectInfo.selectedDic) do
    local buffCfg = ConfigData.exploration_buff[buffId]
    local item = self.buffIconPool:GetOne()
    item:InitBuffOnlyWithCfg(buffCfg, self.__OnPressBuffItemAction, self.__OnPressUpBuffItemAction)
    permillageAll = permillageAll + self.buffIdDic[buffId]
  end
  self.ui.tex_BuffCount:SetIndex(0, tostring(table.count(self._debuffSelectInfo.selectedDic)))
  self.ui.tex_Gain.text = tostring(math.floor(permillageAll / 10)) .. "%"
  local layer = math.floor(permillageAll / 100)
  layer = 0 < layer and layer or 0
  self.ui.tex_Layer:SetIndex(0, tostring(layer))
  self.permillageLayer = layer
  self.permillage = permillageAll
  local basePower = self.fmtBuffSelectData:GetFmtBuffRecomPowerBase()
  local powerRate = self.fmtBuffSelectData:GetFmtBuffRecomPowerRate()
  self.ui.tex_EnemyPower.text = tostring(self.fmtBuffSelectData:GetBuffEmenyPower(layer, 1))
  for _, item in ipairs(self.buffItemPool.listItem) do
    local selected = self._debuffSelectInfo.selectedDic[item.buffId] ~= nil
    if selected then
      item:ChangeState(selected, false)
    else
      local isForbid = false
      if self._debuffSelectInfo.selectedAssisBuffId ~= nil then
        isForbid = true
      else
        local groupId = self.fmtBuffSelectData:GetFmtBuffGroupId(item.buffId)
        isForbid = self._debuffSelectInfo.selecedGroupDic[groupId] ~= nil
      end
      item:ChangeState(selected, isForbid)
    end
  end
  local warningTipValue = self.fmtBuffSelectData:GetBuffScoreWarningValue(1)
  self.ui.obj_Warning:SetActive(permillageAll >= warningTipValue)
end

function UIPeriodicDebuffSelect:OnClickClear()
  self:__ClearSelectInfo()
  self:Refresh()
end

function UIPeriodicDebuffSelect:OnClickConfirm()
  if self.confirmFunc ~= nil then
    local selectedBuffIds = {}
    for buffId, _ in pairs(self._debuffSelectInfo.selectedDic) do
      table.insert(selectedBuffIds, buffId)
    end
    self.confirmFunc(selectedBuffIds)
  end
  if self.closeCallback ~= nil then
    self.closeCallback(self.permillageLayer)
  end
  UIUtil.OnClickBackByUiTab(self)
end

function UIPeriodicDebuffSelect:OnItemValueChange(buffId, flag)
  if flag then
    self:__SelectDebuff(buffId)
  else
    self:__CancleDebuff(buffId)
  end
  self:Refresh()
end

function UIPeriodicDebuffSelect:__SelectDebuff(buffId)
  if self._debuffSelectInfo.selectedDic[buffId] ~= nil then
    return
  end
  if self._debuffSelectInfo.selectedAssisBuffId ~= nil then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(908))
    return
  end
  local groupId = self.fmtBuffSelectData:GetFmtBuffGroupId(buffId)
  if groupId ~= nil and self._debuffSelectInfo.selecedGroupDic[groupId] ~= nil then
    local lastSelect = self._debuffSelectInfo.selecedGroupDic[groupId]
    self._debuffSelectInfo.selecedGroupDic[groupId] = nil
    self._debuffSelectInfo.selectedDic[lastSelect] = nil
  end
  if self.fmtBuffSelectData:IsFmtBuffAssis(buffId) then
    self:__ClearSelectInfo()
    self._debuffSelectInfo.selectedAssisBuffId = buffId
  end
  if groupId ~= nil then
    self._debuffSelectInfo.selecedGroupDic[groupId] = buffId
  end
  self._debuffSelectInfo.selectedDic[buffId] = true
end

function UIPeriodicDebuffSelect:__CancleDebuff(buffId)
  if self._debuffSelectInfo.selectedDic[buffId] == nil then
    return
  end
  self._debuffSelectInfo.selectedDic[buffId] = nil
  if self._debuffSelectInfo.selectedAssisBuffId ~= nil and self.fmtBuffSelectData:IsFmtBuffAssis(buffId) then
    self._debuffSelectInfo.selectedAssisBuffId = nil
  end
  local groupId = self.fmtBuffSelectData:GetFmtBuffGroupId(buffId)
  if groupId ~= nil then
    self._debuffSelectInfo.selecedGroupDic[groupId] = nil
  end
end

function UIPeriodicDebuffSelect:__ClearSelectInfo()
  self._debuffSelectInfo.selectedDic = {}
  self._debuffSelectInfo.selectedAssisBuffId = nil
  self._debuffSelectInfo.selecedGroupDic = {}
end

function UIPeriodicDebuffSelect:__OnPressBuffItem(buffItem, buffCfg)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(LanguageUtil.GetLocaleText(buffCfg.name), LanguageUtil.GetLocaleText(buffCfg.describe))
  win:FloatTo(buffItem.transform, HAType.autoCenter, VAType.down)
end

function UIPeriodicDebuffSelect:__OnPressUpBuffItem()
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UIPeriodicDebuffSelect:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIPeriodicDebuffSelect
