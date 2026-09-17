local this = class("pagePetSortFilter", G_UIPageBase)
local PriorityIds = {
  1,
  2,
  3,
  4
}

local function normalizeOrderIdList(orderIdList)
  local mark = {}
  for _, id in ipairs(PriorityIds) do
    mark[id] = true
  end
  local result = {}
  local dup = {}
  for _, orderId in ipairs(orderIdList or {}) do
    if mark[orderId] and not dup[orderId] then
      dup[orderId] = true
      table.insert(result, orderId)
    end
  end
  return result
end

function this.bind()
  return {
    list_optionGroup = {
      moduleName = "pages/sortFilter/cellSortFilterGroup"
    },
    module_commonTipLarge = L_Const.ModuleInfo.ModuleCommonTip
  }
end

function this.methods()
  return {
    module_commonTipLarge = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        self:onClickConfirm()
      end
    },
    onClick_reset = function(self)
      self:resetToDefaults()
    end,
    onValueChanged_scrollView = function(self, _)
      if not self._lockBackVertical then
        self._backScrollNormalize = nil
      end
    end,
    list_optionGroup = {
      onClick_title = function(self, uiBinding, open)
        L_GameUtil.forceRebuildLayout(self.bindComponents.rect_Content)
        self._backScrollNormalize = self.bindComponents.scrollView_group.verticalNormalizedPosition
        FrameScheduler.add(function()
          self:refreshNormalizePos(uiBinding, open)
        end, 1, uiBinding)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  options = options or {}
  self._boxIndex = options.boxIndex
  self._callback = options.callback
  self._sortPickLimitNum = 4
  self._scopeSelectList = {
    options.isAll == true and 2 or 1
  }
  if options.isSeqOrder == nil or options.isSeqOrder == true then
    self._orderDirSelectList = {1}
  else
    self._orderDirSelectList = {2}
  end
  self._orderIdList = normalizeOrderIdList(options.orderIdList)
  self._defaultScopeId = self._scopeSelectList[1]
  self._defaultOrderId = self._orderDirSelectList[1]
  self._defaultOrderIdList = table.clone(self._orderIdList)
  if self._prioritySortHandle == nil then
    self._prioritySortHandle = handler(self, self.handlePrioritySortClick)
  end
  local moduleTip = self.modules.module_commonTipLarge
  moduleTip:initModule({
    txtTitle = L_WordsTpl:getValue("ui_kibo_box_sort_text_01"),
    txtContent = "",
    hideCancel = true
  })
  local tmp = {
    {
      sortOrFilter = L_SortFilterConst.SortOrFilter.Filter,
      selectValue = self._scopeSelectList,
      selectLimit = 1,
      keepOneSelected = true,
      hideSelectLimit = true,
      txt_title = L_WordsTpl:getValue("ui_kibo_box_sort_text_02"),
      customOptions = {
        {
          id = 1,
          name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_01"),
          txt_name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_01")
        },
        {
          id = 2,
          name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_02"),
          txt_name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_02")
        }
      }
    },
    {
      sortOrFilter = L_SortFilterConst.SortOrFilter.Filter,
      selectValue = self._orderDirSelectList,
      selectLimit = 1,
      keepOneSelected = true,
      hideSelectLimit = true,
      txt_title = L_WordsTpl:getValue("ui_kibo_box_sort_text_03"),
      customOptions = {
        {
          id = 1,
          name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_03"),
          txt_name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_03")
        },
        {
          id = 2,
          name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_04"),
          txt_name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_04")
        }
      }
    },
    {
      sortOrFilter = L_SortFilterConst.SortOrFilter.Sort,
      selectValue = self._orderIdList,
      selectLimit = self._sortPickLimitNum,
      sortTypeData = {},
      defaultList = {},
      txt_title = L_WordsTpl:getValue("ui_kibo_box_sort_text_04"),
      sortHandle = self._prioritySortHandle,
      customOptions = {
        {
          id = 1,
          name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_05"),
          txt_name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_05")
        },
        {
          id = 2,
          name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_06"),
          txt_name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_06")
        },
        {
          id = 3,
          name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_07"),
          txt_name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_07")
        },
        {
          id = 4,
          name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_08"),
          txt_name = L_WordsTpl:getValue("ui_kibo_box_sort_btn_08")
        }
      }
    }
  }
  self.bind.list_optionGroup:clear()
  self.bind.list_optionGroup:insert_array(tmp)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_Content)
end

function this:resetToDefaults()
  self._scopeSelectList[1] = self._defaultScopeId
  self._orderDirSelectList[1] = self._defaultOrderId
  for i = #self._orderIdList, 1, -1 do
    table.remove(self._orderIdList, i)
  end
  for _, id in ipairs(self._defaultOrderIdList) do
    table.insert(self._orderIdList, id)
  end
  for i, v in ipairs(self.modules.list_optionGroup) do
    local cell = v
    if i == 1 then
      cell:setOptionListActive(self._scopeSelectList)
    elseif i == 2 then
      cell:setOptionListActive(self._orderDirSelectList)
    else
      cell:setOptionListActive(self._orderIdList)
    end
  end
end

function this:handlePrioritySortClick(_, isActive, sortId)
  local curSelectNum = #self._orderIdList
  local limitReached = curSelectNum >= self._sortPickLimitNum
  if isActive then
    local _, index = table.ipairsFind(self._orderIdList, function(v)
      return v == sortId
    end)
    table.remove(self._orderIdList, index)
  else
    if limitReached then
      if self._sortPickLimitNum == 1 and curSelectNum == 1 then
        table.remove(self._orderIdList, 1)
      else
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_filter_select_num_limit"), 0)
        return
      end
    end
    table.insert(self._orderIdList, sortId)
  end
  local priorityGroup = self.modules.list_optionGroup[3]
  if priorityGroup then
    priorityGroup:setOptionListActive(self._orderIdList)
  end
end

function this:getRequestData()
  local scopeIds = self.modules.list_optionGroup[1]:getSelectValueList()
  local orderIds = self.modules.list_optionGroup[2]:getSelectValueList()
  local scopeId = scopeIds and scopeIds[1] or 1
  local orderId = orderIds and orderIds[1] or 1
  return {
    box = self._boxIndex,
    is_all = scopeId == 2,
    is_seq_order = orderId == 1,
    order_id = table.clone(self._orderIdList)
  }
end

function this:onClickConfirm()
  if table.isEmpty(self._orderIdList) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_box_sort_priority_rule"))
    return
  end
  local requestData = self:getRequestData()
  if not requestData.is_all and L_PetStore:getBoxIsLock(requestData.box) then
    L_FlyMsgManager:showNormalMsgByKey(L_WordsTpl:getValue("notice_kibo_box_lock_tips"))
    return
  end
  L_PetStore:req_CSProtoOrderPetBoxInfo(requestData, function()
    if self._callback then
      self._callback(requestData)
    end
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_box_sort_success"))
    L_UI:close(self.pageName)
  end)
end

function this:refreshNormalizePos(cellUiBinding, isInfoOpen)
  local scroll = self.bindComponents.scrollView_group
  if not scroll then
    return
  end
  if isInfoOpen then
    local isVisible = L_EffectUtil.isElementVerticalVisible(cellUiBinding, scroll.viewport, scroll.content)
    local jumpY = self:getJumpY(cellUiBinding)
    local contenSize = scroll.content.sizeDelta
    local viewPortRectSize = scroll.viewport.rect.size
    if not isVisible then
      self._lockBackVertical = true
      scroll.verticalNormalizedPosition = math.clamp(1 - jumpY / (contenSize.y - viewPortRectSize.y), 0, 1)
      FrameScheduler.add(function()
        self._lockBackVertical = false
      end, 1, cellUiBinding)
    end
  else
    if self._backScrollNormalize then
      local y = self._backScrollNormalize
      scroll.verticalNormalizedPosition = math.clamp(y, 0, 1)
    end
    self._backScrollNormalize = nil
  end
end

function this:getJumpY(targetElement)
  local elementRect = targetElement:GetComponent(typeof(C_RectTransform))
  local elementAnchoredPos = elementRect.anchoredPosition
  return -elementAnchoredPos.y - 11 - elementRect.rect.height / 2
end

function this:escHandle()
  L_UI:close(self.pageName)
  L_AudioUtil.playSound("Play_SFX_System_UI_General_Frame_Close")
end

return this
