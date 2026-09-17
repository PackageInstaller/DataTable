local module = class("moduleMainCityHomeBelt", require("ui.pages.home.homeBag.moduleHomeBelt"))
local DisplayState = {
  INIT = 0,
  SHOWING = 1,
  HIDING = 2
}

local function deepClone(object)
  local lookup_table = {}
  
  local function _copy(object)
    if type(object) ~= "table" then
      return object
    elseif lookup_table[object] then
      return lookup_table[object]
    end
    local new_table = {}
    lookup_table[object] = new_table
    for key, value in pairs(object) do
      new_table[_copy(key)] = _copy(value)
    end
    return setmetatable(new_table, getmetatable(object))
  end
  
  return _copy(object)
end

function module.bind()
  return {
    list_belt = {
      moduleName = "pages/home/homeBag/cellIconHomeBelt"
    },
    list_pageNum_pc = {
      moduleName = "pages/home/homeBag/cellHomeBeltNum"
    },
    list_pageNum_mobile = {
      moduleName = "pages/home/homeBag/cellHomeBeltNum"
    },
    select_tab_pc = -1,
    select_tab_mobile = -1,
    enabled_scroll = true,
    img_drag = "",
    toggle_isCrop = false,
    active_pageNum_pc = false,
    active_pageNum_mobile = false,
    active_btn_page_last = false,
    active_btn_page_next = false
  }
end

function module.methods()
  return {
    onClickNextTab = function(self)
      self:changeNextPage()
    end,
    onClick_homeBag = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.homeBag)
    end,
    onClick_page_last = function(self)
      self:changeLastPage()
    end,
    onClick_page_next = function(self)
      self:changeNextPage()
    end
  }
end

function module:setBelt(beltType, canSelect, params)
  module.super.setBelt(self, beltType, canSelect, params)
  self.bind.toggle_isCrop = beltType == L_Const.HomeShortcutBarType.HSBT_CROP
end

function module:open()
  module.super.open(self)
  L_ShortCutManager:addShortKeyFlag(self, "9", L_Const.AnchorType.Bottom, self.bindComponents.rect_buttonHomeBag, L_Vector3.new(0, -18, 0), 1)
  self:addLocker()
  self:initAnimationData()
end

function module:addLocker()
  self.systemToTrans = {
    [L_SystemConst.enum.homeBag] = {
      self.bindComponents.rect_buttonHomeBag
    }
  }
  for systemId, v in pairs(self.systemToTrans) do
    v.locker = C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(systemId)
    if v.locker then
      self:refreshSystem(systemId, false)
      v.locker:setCallback(self.refreshSystem, self, self.gameObject)
    end
  end
end

function module:refreshView(checkContentAni)
  if not self._beltType then
    return
  end
  module.super.refreshView(self, checkContentAni)
  self._oldBeltIds = deepClone(L_HomeStore:getOldBeltItems(self._beltType) or {})
  self._beltIds = deepClone(self._beltIds or {})
  L_HomeStore:updateOldBeltItems(self._beltType)
  if not table.isEmpty(self._oldBeltIds) then
    local pageIndexOfLastNewBeltItem = self:calculatePageIndexOfLastNewBeltItem(self._oldBeltIds, self._beltIds)
    if pageIndexOfLastNewBeltItem then
      self:onBeltClick(0)
      if self._onChangeEmplty then
        self._onChangeEmplty()
      end
      L_HomeStore:setBeltPage(self._beltType, pageIndexOfLastNewBeltItem)
    end
  end
end

function module:refreshSystem(systemId, isUnlock)
  local node = self.systemToTrans[systemId]
  local locker = node.locker
  for _, v in ipairs(node) do
    locker:tryShowOrHide(v, isUnlock)
  end
end

function module:destroyAllLocker()
  for _, v in pairs(self.systemToTrans) do
    local locker = v.locker
    if locker then
      C_IntegrateMgr.SystemUnlockModule:RemoveLocker(locker)
    end
  end
end

function module:initAnimationData()
  self.animation = self.animation or self.gameObject:GetComponent(typeof(C_Animation))
  self.displayState = DisplayState.INIT
end

function module:activeBelt()
  if self.displayState == DisplayState.SHOWING then
    return
  end
  L_TimerManager:stopTimer(self, "hideBelt")
  self.gameObject:SetActive(true)
  self.animation:Play("anim_home_maincity_belt_in")
  self.displayState = DisplayState.SHOWING
end

function module:hideBelt()
  if self.displayState == DisplayState.HIDING then
    return
  end
  self.animation:Play("anim_home_maincity_belt_out")
  self.displayState = DisplayState.HIDING
  local delayTimeBetweenOutAnimationAndHide = 0.2
  L_TimerManager:newOrResetTimer(self, "hideBelt", function()
    if L_CommonUtil.isValid(self.gameObject) then
      self.gameObject:SetActive(false)
    end
  end, delayTimeBetweenOutAnimationAndHide)
end

function module:close()
  module.super.close(self)
  self:destroyAllLocker()
  self:destoryTimer()
  L_ShortCutManager:clearShortKeyFlag(self)
end

function module:destoryTimer()
  L_TimerManager:clearTimer(self)
end

function module:calculatePageIndexOfLastNewBeltItem(oldBeltItems, beltItems)
  local tmpBeltIndexList = {}
  for beltIndex, _ in pairs(oldBeltItems) do
    local oldBeltItemId = oldBeltItems[beltIndex]
    local beltItemId = beltItems[beltIndex]
    if oldBeltItemId == 0 and beltItemId ~= 0 then
      table.insert(tmpBeltIndexList, beltIndex)
    end
  end
  if table.isEmpty(tmpBeltIndexList) then
    return nil
  else
    local lastBeltIndex = tmpBeltIndexList[#tmpBeltIndexList]
    local lineGridNum = L_HomeStore:getLineGridNum()
    local pageIndexOfLastBeltIndex = math.ceil(lastBeltIndex / lineGridNum)
    return pageIndexOfLastBeltIndex
  end
end

return module
