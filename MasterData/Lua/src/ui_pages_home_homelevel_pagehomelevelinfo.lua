local this = class("pageHomeLevelInfo", G_UIPageBase)
local _homeLevelShowTpl = L_GameTpl:getHomeLevelShowTpl()

function this.bind()
  return {
    focusIndex_levelInfo = nil,
    scrollList_levelInfo = {
      moduleName = "pages/home/homeLevel/cellHomeLevelInfo"
    },
    go_tip = false,
    module_tip = {
      moduleName = "pages/home/homeLevel/moduleHomeInfoTip"
    },
    localPosition_tip = nil,
    go_newUp = false,
    go_newBottom = false,
    localPosition_curLevel = nil,
    txt_homeName = ""
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onValueChange_scrollList_levelInfo = function(self, value)
      if not self.canInvokeOnScrollListValueChange then
        return
      end
      self:updateNotReadNew()
      self:updateLeftLine()
      self.canInvokeOnScrollListValueChange = false
    end,
    scrollList_levelInfo = {
      onClick_select = function(self, itemBind, pos)
        self:showTip(itemBind, pos)
      end
    },
    onClick_home = function()
      local systemId = L_SystemConst.enum.renameHome
      if L_SystemBreakManager:checkBanSystemAndTip(systemId) then
        return
      end
      local data = {
        txtTitle = L_WordsTpl:getValue("notice_homeProduction_28"),
        placeHolder = L_WordsTpl:getValue("ui_modulePetBoxName_03"),
        limit = 7,
        textBoxType = L_Const.CommonTextBoxType.Rename,
        confirmCallback = function(txt)
          if string.isEmpty(string.trim(txt)) then
            L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_homeProduction_29"))
            return
          end
          if string.gsub(txt, " ", "") ~= txt then
            L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_homeProduction_30"))
            return
          end
          if string.gsub(txt, "\n", "") ~= txt then
            L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_illegal_message"))
            return
          end
          L_HomeStore:req_modifyHomeName(txt, function()
            L_FlyMsgManager:showNormalMsgByKey("ui_modulePetBoxName_05")
          end)
        end
      }
      L_GameUtil.showNormalTextBox(data)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  options = options or {}
  self._defaultSelectItemType = options.defaultSelectItemType
  self._defaultSelectItemId = options.defaultSelectItemId
  self:initLevelInfoList()
  self:updateNotReadNew()
  self:updateLeftLine()
  self:refreshHomeName()
  L_HomeStore:listenCallFunc(L_HomeStore.event.refreshHomeInfo, self.refreshHomeName, self)
  L_TimerManager:newOrResetTimer(self, "updateCanInvokeOnScrollListValueChange", function()
    self.canInvokeOnScrollListValueChange = true
  end, 1, -1)
end

function this:open()
  self.bindComponents.ani_pageHomeLevelInfo:Play("anim_homeLeve_In")
end

function this:close(options)
  local curLevel = L_PlayerStore:getLv()
  for i = 1, curLevel do
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.LevelUnlockHomeContent, i)
  end
  L_HomeStore:unListenCallFunc(L_HomeStore.event.refreshHomeInfo, self.refreshHomeName, self)
  L_TimerManager:clearTimer(self)
end

function this:refreshHomeName()
  self.bind.txt_homeName = L_HomeStore:getHomeName()
end

function this:initLevelInfoList()
  local cellDataList = {}
  local allTpl = _homeLevelShowTpl.data
  local index = 0
  local allTplCount = 0
  local curLevel = 0
  local curIndex = 0
  local intervalTimeValue = 0
  local baseIntervalTime = 0.03
  local perCellHeight = 165
  local cellInfoHeight = 96
  local baseTime = C_Time.time
  for i, tpl in pairs(allTpl) do
    index = index + 1
    allTplCount = allTplCount + 1
    intervalTimeValue = intervalTimeValue + baseIntervalTime
    local cellTmp = _homeLevelShowTpl:getAllUnlockContent(tpl)
    local columnNum = math.ceil(#cellTmp / 10)
    local cellHeight = cellInfoHeight + perCellHeight * columnNum
    table.insert(cellDataList, {
      level = _homeLevelShowTpl:getId(tpl),
      intervalTime = intervalTimeValue,
      isPlayCellAnim = false,
      basePlayTime = baseTime + intervalTimeValue,
      size = cellHeight
    })
  end
  table.sort(cellDataList, function(a, b)
    return a.level < b.level
  end)
  index = 0
  local playerLv = L_PlayerStore:getLv()
  for i, v in pairs(cellDataList) do
    index = index + 1
    if playerLv >= v.level then
      curLevel = v.level
      curIndex = index
    else
      break
    end
  end
  local isPlayUnLockAnim = C_PlayerPrefsUtility.GetBool(L_PlayerStore:getPlayerId() .. curLevel, false)
  for i, v in pairs(cellDataList) do
    v.curLevel = curLevel
    v.isPlayCurLevelUnLockAnim = curLevel == 0 and true or isPlayUnLockAnim
  end
  self.currentStartLevelInfo = curLevel
  self.bind.scrollList_levelInfo:clear()
  self.bind.scrollList_levelInfo:insert_array(cellDataList)
  if not isPlayUnLockAnim and 1 < curLevel then
    self.bind.focusIndex_levelInfo = curIndex
  end
  self:autoSelectItem()
end

function this:OnMoveToVurLevel(ItemCount, index)
  local simpleValue = ItemCount - 1
  local meanValue = 1 / simpleValue
  local scrollPosTable = {}
  for i = simpleValue, 1, -1 do
    table.insert(scrollPosTable, i * meanValue)
  end
  table.insert(scrollPosTable, 0)
  self.bind.focusIndex_levelInfo = index
  DOTween.To(function()
    return scrollPosTable[index] - 0.1
  end, function(value)
    self.bindComponents.verTabView_content.verticalNormalizedPosition = value
  end, scrollPosTable[index], 0.5):SetEase(CS.DG.Tweening.Ease.OutQuad):OnComplete(function()
    self.bind.scrollList_levelInfo:getItemCls(index):playUnlockAnim()
  end)
end

function this:showTip(itemBind, pos)
  self.bind.go_tip = true
  C_AudioManager.Play("Play_SFX_System_UI_General_Paper_Open_L3")
  local module_tip = self.modules.module_tip
  module_tip:reset()
  module_tip:setData(itemBind.type, itemBind.id)
  local targetPos = self.bindComponents.rect_Board.transform:InverseTransformPoint(pos) + L_Vector3.new(50, 20, 0)
  local height = self.bindComponents.rect_moduleHomeLevelInfoTip.sizeDelta.y
  local width = self.bindComponents.rect_moduleHomeLevelInfoTip.sizeDelta.x
  local halfScreenHeight = self.bindComponents.rect_Board.transform.rect.height / 2
  if targetPos.y - height < -halfScreenHeight then
    targetPos.y = -halfScreenHeight + height
  end
  local halfScreenWidth = self.bindComponents.rect_Board.transform.rect.width / 2
  if halfScreenWidth < targetPos.x + width then
    targetPos.x = halfScreenWidth - width
  end
  self.bind.localPosition_tip = targetPos
end

function this:updateNotReadNew()
  local haveNewBottom, haveNewUp = false, false
  local showMinLv = math.maxinteger
  local showMaxLv = math.mininteger
  for i, v in ipairs(self.modules.scrollList_levelInfo) do
    if v.isBind then
      showMinLv = math.min(showMinLv, v.bind.level)
      showMaxLv = math.max(showMaxLv, v.bind.level)
      L_ReddotManager:clearNew(L_ReddotManager.DotDef.LevelUnlockHomeContent, v.bind.level)
    elseif showMinLv > v.bind.level then
      if L_ReddotManager:haveNew(L_ReddotManager.DotDef.LevelUnlockHomeContent, v.bind.level) then
        haveNewUp = true
      end
    elseif showMaxLv < v.bind.level and L_ReddotManager:haveNew(L_ReddotManager.DotDef.LevelUnlockHomeContent, v.bind.level) then
      haveNewBottom = true
    end
  end
  self.bind.go_newUp = haveNewUp
  self.bind.go_newBottom = haveNewBottom
end

function this:updateLeftLine()
  for i, v in pairs(self.modules.scrollList_levelInfo) do
    if v.isBind and v.bind.level == self.currentStartLevelInfo then
      local targetPos = self.bindComponents.rect_Board.transform:InverseTransformPoint(v.uiBinding.transform.position)
      self.bind.localPosition_curLevel = L_Vector3.new(2.6, targetPos.y, 0)
      return
    end
  end
  self.bind.localPosition_curLevel = L_Vector3.new(2.6, -2000, 0)
end

function this:autoSelectItem()
  if math.isEmpty(self._defaultSelectItemType) or math.isEmpty(self._defaultSelectItemId) then
    return
  end
  local itemIndex = _homeLevelShowTpl:getItemIndexByTypeId(self._defaultSelectItemType, self._defaultSelectItemId)
  if itemIndex then
    FrameScheduler.add(function()
      self.bind.focusIndex_levelInfo = itemIndex
      FrameScheduler.add(function()
        local list = self.modules.scrollList_levelInfo
        for i, v in pairs(list) do
          v:selectItem(self._defaultSelectItemType, self._defaultSelectItemId)
        end
      end, 1)
    end, 1)
  else
    error("autoSelectItem未找到对应数据")
  end
end

function this:onCloseTip()
  self.bind.go_tip = false
  for i, v in pairs(self.modules.scrollList_levelInfo) do
    v:clearSelect()
  end
end

function this:update()
  if CS.UnityEngine.Input.GetMouseButtonDown(0) then
    self:onCloseTip()
  end
end

return this
