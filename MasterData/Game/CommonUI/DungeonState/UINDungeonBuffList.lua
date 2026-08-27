local UINDungeonBuffList = class("UINDungeonBuffList", UIBaseNode)
local base = UIBaseNode
local UINDungeonBuffItem = require("Game.CommonUI.DungeonState.UINDungeonBuffItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local DynBuff = require("Game.Exploration.Data.DynBuff")

function UINDungeonBuffList:OnInit()
  self.AbleToBuffItemPointer = true
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINDungeonBuffItem, self.ui.obj_buffItem)
  self.ui.obj_buffItem:SetActive(false)
  self.__ShowBuffDescription = BindCallback(self, self.ShowBuffDescription)
  self.__HideBuffDetail = BindCallback(self, self.HideBuffDetail)
  self.__onEpBuffListChange = BindCallback(self, self.RefrshBuffList)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffListChange, self.__onEpBuffListChange)
  self.__changeBuffListDisplay = BindCallback(self, self.ChangeBuffListDisplay)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffListDisplay, self.__changeBuffListDisplay)
  self.buffHideList = {}
  self.__btnBufDescActive = self.ui.btn_BuffDescriptionPage.gameObject.activeSelf
  UIUtil.AddButtonListener(self.ui.btn_BuffDescriptionPage, self, self._OnBuffDescriptionClick)
end

function UINDungeonBuffList:SetBuffListAbleToPointer(able)
  self.AbleToBuffItemPointer = able
end

function UINDungeonBuffList:ChangeBuffListDisplay(isShow)
  if isShow then
    table.remove(self.buffHideList, #self.buffHideList)
  else
    table.insert(self.buffHideList, isShow)
  end
  if self.buffHideList == nil or #self.buffHideList <= 0 then
    self:Show()
  else
    self:Hide()
  end
end

function UINDungeonBuffList:InitBuffList(buffList)
  self:RefrshBuffList(buffList)
end

function UINDungeonBuffList:RefrshBuffList(buffList)
  self.buffList = buffList
  self.buffCount = 0
  self.itemPool:HideAll()
  local maxShowBuffNum = math.floor(self.ui.buffListScrollRect.transform.sizeDelta.x / (self.ui.buffList.spacing + self.ui.obj_buffItem.transform.sizeDelta.x))
  if WarChessManager:GetIsInWarChess() then
    self.buffList = {}
    local buffDic = WarChessManager:GetWarChessCtrl().backPackCtrl:GetWCBuffDic()
    for k, wcBuff in pairs(buffDic) do
      if wcBuff:GetWCBuffIsNeedShow() then
        self.buffCount = self.buffCount + 1
        local buffItem = self.itemPool:GetOne()
        buffItem:InitWcDunBuff(wcBuff, self.__ShowBuffDescription, self.__HideBuffDetail)
        table.insert(self.buffList, wcBuff)
      end
    end
  else
    local tempBuffDic = {}
    for index, epBuff in ipairs(buffList) do
      local dataId = epBuff.dataId
      if tempBuffDic[dataId] == nil then
        tempBuffDic[dataId] = {}
        tempBuffDic[dataId].count = 1
        tempBuffDic[dataId].buff = epBuff
      else
        tempBuffDic[dataId].count = tempBuffDic[dataId].count + 1
      end
    end
    for epBuffDataId, info in pairs(tempBuffDic) do
      if info.buff:IsBuffNeedShowOnBuffList() then
        self.buffCount = self.buffCount + 1
        if maxShowBuffNum > self.buffCount then
          local item = self.itemPool:GetOne(true)
          item:InitBuffByCfg(info.buff, info.buff:GetBuffCfg(), self.__ShowBuffDescription, self.__HideBuffDetail, info.count)
        end
      end
    end
  end
  if self.buffCount <= 0 then
    self:Hide()
  else
    self:Show()
  end
  if maxShowBuffNum <= self.buffCount then
    self.ui.obj_BuffCount:SetActive(true)
    self.ui.tex_BuffNum.text = tostring(self.buffCount)
  else
    self.ui.obj_BuffCount:SetActive(false)
  end
  if self.buffCount > 0 and not self.__btnBufDescActive then
    self.ui.btn_BuffDescriptionPage.gameObject:SetActive(true)
    self.__btnBufDescActive = true
  elseif self.buffCount == 0 and self.__btnBufDescActive then
    self.ui.btn_BuffDescriptionPage.gameObject:SetActive(false)
    self.__btnBufDescActive = false
  end
end

function UINDungeonBuffList:AddDropBuff(dropBuffId)
  local maxShowBuffNum = math.floor(self.ui.buffListScrollRect.transform.sizeDelta.x / (self.ui.buffList.spacing + self.ui.obj_buffItem.transform.sizeDelta.x))
  if WarChessManager:GetIsInWarChess() then
  else
    self.buffCount = self.buffCount + 1
    local buffId = ConfigData.game_config.unKnowBuffCfgId
    local buffCfg = ConfigData.dungeon_buff[buffId]
    local tempBuff = DynBuff.CreateByDungeonLevel(buffId, buffCfg)
    if maxShowBuffNum > self.buffCount then
      local item = self.itemPool:GetOne(true)
      item:InitBuffOnlyWithCfg(buffCfg, self.__ShowBuffDescription, self.__HideBuffDetail)
    end
    table.insert(self.buffList, tempBuff)
  end
  if maxShowBuffNum <= self.buffCount then
    self.ui.obj_BuffCount:SetActive(true)
    self.ui.tex_BuffNum.text = tostring(self.buffCount)
  else
    self.ui.obj_BuffCount:SetActive(false)
  end
  if self.buffCount > 0 and not self.__btnBufDescActive then
    self.ui.btn_BuffDescriptionPage.gameObject:SetActive(true)
    self.__btnBufDescActive = true
  elseif self.buffCount == 0 and self.__btnBufDescActive then
    self.ui.btn_BuffDescriptionPage.gameObject:SetActive(false)
    self.__btnBufDescActive = false
  end
end

function UINDungeonBuffList:CleanDropBuff()
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local isNeedRefrsh = false
  if dynPlayer ~= nil then
    local dropbuffId = ConfigData.game_config.unKnowBuffCfgId
    for i = #self.buffList, 1, -1 do
      if self.buffList[i].dataId == dropbuffId then
        table.remove(self.buffList, i)
        isNeedRefrsh = true
      end
    end
    if isNeedRefrsh then
      self:RefrshBuffList(dynPlayer:GetEpBuffList())
    end
  end
end

function UINDungeonBuffList:ShowBuffDescription(item, buffCfg)
  if not self.AbleToBuffItemPointer then
    return
  end
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local des
  if WarChessManager:GetIsInWarChess() then
    des = LanguageUtil.GetLocaleText(buffCfg.description)
  else
    local isGetDes = false
    for key, dynBuff in pairs(self.buffList) do
      if dynBuff:GetBuffCfg() == buffCfg then
        des = dynBuff:GetEpBuffDescribe()
        isGetDes = true
        break
      end
    end
    if not isGetDes then
      des = LanguageUtil.GetLocaleText(buffCfg.describe)
    end
  end
  if not self.__eHAType then
    self.__eHAType = HAType.autoCenter
  end
  if not self.__eVAtype then
    self.__eVAtype = VAType.up
  end
  if not self.__shiftX then
    self.__shiftX = 0
  end
  if not self.__shiftY then
    self.__shiftY = 0.5
  end
  win:SetTitleAndContext(LanguageUtil.GetLocaleText(buffCfg.name), des)
  win:FloatTo(item.transform, self.__eHAType, self.__eVAtype, self.__shiftX, self.__shiftY)
  win:Copy3DModifier(self.ui.comp_3dModifier)
end

function UINDungeonBuffList:SetBuffDetailFloatAlign(eHAType, eVAtype, shiftX, shiftY)
  self.__eHAType = eHAType
  self.__eVAtype = eVAtype
  self.__shiftX = shiftX
  self.__shiftY = shiftY
end

function UINDungeonBuffList:HideBuffDetail(skillData)
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UINDungeonBuffList:_OnBuffDescriptionClick()
  local battleWin = UIManager:GetWindow(UIWindowTypeID.Battle)
  local pauseSuc = false
  if battleWin ~= nil then
    pauseSuc = battleWin:TrySmallBattlePause()
    battleWin:HideMonsterOrNeutralRoleInfo()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(buffDescWin)
    buffDescWin:InitDescriptPageEpBuffShow(self.buffList, function()
      if pauseSuc then
        local battleWin = UIManager:GetWindow(UIWindowTypeID.Battle)
        if battleWin then
          battleWin:TryCancelBattlePause()
        end
      end
    end)
  end)
end

function UINDungeonBuffList:OnShow()
  base.OnShow(self)
  self.ui.btn_BuffDescriptionPage.gameObject:SetActive(true)
end

function UINDungeonBuffList:OnHide()
  base.OnHide(self)
  self.ui.btn_BuffDescriptionPage.gameObject:SetActive(false)
end

function UINDungeonBuffList:OnDelete()
  self.buffHideList = nil
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffListChange, self.__onEpBuffListChange)
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffListDisplay, self.__changeBuffListDisplay)
  self:HideBuffDetail()
  base.OnDelete(self)
end

return UINDungeonBuffList
