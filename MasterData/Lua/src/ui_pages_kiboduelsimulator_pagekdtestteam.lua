local this = class("pageKDTestTeam", G_UIPageBase)
local PAGE_TYPE = {kibo = 1}
local MODE_TEXT = {
  [PAGE_TYPE.kibo] = L_WordsTpl:getValue("residual_code_pagekdtestteam_05")
}
local SLOT_NUM = 8

function this.bind()
  return {
    txt_inputSetLv = "",
    txt_inputSearch = "",
    txt_inputLevel = "",
    txt_mode = "",
    scrollList = {
      moduleName = "pages/kiboDuelSimulator/cellItem/kiboDuelSimulatorClickItem"
    },
    kiboInfo1 = {
      moduleName = "pages/kiboDuelSimulator/cellItem/cellKDTestTeamItem"
    },
    kiboInfo2 = {
      moduleName = "pages/kiboDuelSimulator/cellItem/cellKDTestTeamItem"
    },
    kiboInfo3 = {
      moduleName = "pages/kiboDuelSimulator/cellItem/cellKDTestTeamItem"
    },
    kiboInfo4 = {
      moduleName = "pages/kiboDuelSimulator/cellItem/cellKDTestTeamItem"
    },
    kiboInfo5 = {
      moduleName = "pages/kiboDuelSimulator/cellItem/cellKDTestTeamItem"
    },
    kiboInfo6 = {
      moduleName = "pages/kiboDuelSimulator/cellItem/cellKDTestTeamItem"
    },
    kiboInfo7 = {
      moduleName = "pages/kiboDuelSimulator/cellItem/cellKDTestTeamItem"
    },
    kiboInfo8 = {
      moduleName = "pages/kiboDuelSimulator/cellItem/cellKDTestTeamItem"
    },
    btn1 = true,
    btn2 = true,
    btn3 = true,
    btn4 = true,
    btn5 = true,
    btn6 = true,
    btn7 = true,
    btn8 = true
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_setLv = function(self)
      local level = tonumber(self.globalLv)
      if level then
        for i = 1, SLOT_NUM do
          self.kiboList[i]:setLevel(level)
        end
        self.bind.txt_inputLevel = tostring(level)
      end
    end,
    onChanged_search = function(self, text)
      self.searchKey = text
      self:refreshListByType()
    end,
    onChanged_globalLevel = function(self, text)
      self.globalLv = text
    end,
    onChanged_level = function(self, text)
      local level = tonumber(text)
      if level then
        self.kiboList[self.selectIndex]:setLevel(level)
      end
    end,
    scrollList = {
      onClick = function(self, bind)
        if self.pageType == PAGE_TYPE.kibo then
          local nextIndex = self:getNextKiboIndex(self.selectIndex)
          local flag = self.kiboList[self.selectIndex]:setKibo(bind.id)
          if flag then
            self:setSelect(nextIndex)
          end
        end
      end
    },
    onClick_Btn1 = function(self)
      self:setSelect(1)
    end,
    onClick_Btn2 = function(self)
      self:setSelect(2)
    end,
    onClick_Btn3 = function(self)
      self:setSelect(3)
    end,
    onClick_Btn4 = function(self)
      self:setSelect(4)
    end,
    onClick_Btn5 = function(self)
      self:setSelect(5)
    end,
    onClick_Btn6 = function(self)
      self:setSelect(6)
    end,
    onClick_Btn7 = function(self)
      self:setSelect(7)
    end,
    onClick_Btn8 = function(self)
      self:setSelect(8)
    end
  }
end

function this:ctor()
  this.super.ctor(self)
  self.pageType = PAGE_TYPE.kibo
  self.searchKey = ""
end

function this:open(options)
  this.super.open(self, options)
  self.side = options and options.side or 1
  self:initList()
  self.selectIndex = 1
  self:setSelect(self.selectIndex, true)
  self:refreshPageByType()
end

function this:initList()
  self.kiboList = {}
  for i = 1, SLOT_NUM do
    self.kiboList[i] = self.bind["kiboInfo" .. i].module
    self.kiboList[i]:initData(i, self.side)
  end
end

function this:getNextKiboIndex(index)
  local target = index
  local store = L_KiboDuelSimulatorStore:getData().playerInfo[self.side].kiboList
  if store[target].kiboId and store[target].kiboId > 0 then
    return target
  end
  for i = 1, 7 do
    target = target + 1
    if target == 9 then
      target = 1
    end
    if not store[target].kiboId or store[target].kiboId == 0 then
      return target
    end
  end
  return index
end

function this:refreshPageByType()
  self.bind.txt_mode = MODE_TEXT[self.pageType]
  for i = 1, SLOT_NUM do
    self.kiboList[i]:refreshType(self.pageType)
  end
  self:refreshListByType()
end

function this:refreshListByType()
  if self.pageType == PAGE_TYPE.kibo then
    self:refreshKiboList()
  end
end

function this:setSelect(index, force)
  if self.selectIndex == index and not force then
    return
  end
  self.kiboList[self.selectIndex]:setSelect(false)
  self.bind["btn" .. self.selectIndex] = true
  self.selectIndex = index
  local level = L_KiboDuelSimulatorStore:getData().playerInfo[self.side].kiboList[self.selectIndex].lv
  self.bind.txt_inputLevel = tostring(level)
  self.kiboList[index]:setSelect(true)
  self.bind["btn" .. self.selectIndex] = false
end

function this:refreshKiboList()
  local list = L_GameTpl:getPetTpl().data
  self.bind.scrollList:clear()
  for _, v in pairs(list) do
    local name = v.id .. "_" .. L_GameTpl:getPetTpl():getName(v)
    if string.isEmpty(self.searchKey) or string.match(name, self.searchKey) then
      self.bind.scrollList:insert({
        id = v.id,
        txt_name = name
      })
    end
  end
end

function this:close(options)
  this.super.close(self, options)
end

return this
