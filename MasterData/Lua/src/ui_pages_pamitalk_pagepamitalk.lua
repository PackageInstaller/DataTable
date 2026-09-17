local this = class("pagePamiTalk", G_UIPageBase)

function this.bind()
  return {
    moduleCommonTop = {
      moduleName = "modulePages/moduleCommonTop"
    },
    talkList = {
      moduleName = "pages/pamiTalk/modulePamiTalkListCell"
    },
    talkTypeList = {
      moduleName = "pages/pamiTalk/modulePamiTalkTypeCell"
    },
    moduleFiltrate = {
      moduleName = "modulePages/filtrate/moduleHeroFiltrate"
    },
    spinePath = "",
    spineTalkText = "",
    contentActive = true,
    topicZoneActive = true,
    emptyTipsActive = false,
    fileterActive = false,
    filterBtnNormalActive = true,
    filterBtnActive = false
  }
end

function this.methods()
  return {
    onClick_filterBtn = function(self)
      self.bind.fileterActive = true
    end,
    onClick_pamiSpine = function(self)
      self.spineTouchIndex = self.spineTouchIndex + 1
      if self.spineTouchIndex > #self.spineTips then
        return
      end
      if self.spineTouchIndex == #self.spineTips then
        local des = self.spineTips[self.spineTouchIndex].des
        Timer.once(1, function()
          L_FlyMsgManager:showNormalMsg(des)
          L_UI:close(self.pageName)
        end, self)
      end
      self.bind.spineTalkText = self.spineTips[self.spineTouchIndex].text
      print("点击spine")
    end,
    talkTypeList = {
      onClick_talkTypeList = function(self, index)
        self.typeIndex = index
        self:setTypeListActive()
        self:updateTalkList()
      end
    }
  }
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.pamiTalk)
  callback(result)
end

function this:preOpen(options)
  L_PamiTalkStore:listenCallFunc(L_PamiTalkStore.event.refreshLettersData, self.onRefreshLettersData, self)
  self.spineTouchIndex = 1
  self.spineTips = L_PamiTalkManager:getPamiSpineTalks()
  self:updatePage()
end

function this:close(options)
  L_PamiTalkStore:unListenCallFunc(L_PamiTalkStore.event.refreshLettersData, self.onRefreshLettersData, self)
end

function this:onRefreshLettersData()
  self:updateTalkTypeList()
  self:updateTalkList()
end

function this:updatePage()
  self:initFilter()
  self:updateTopBar()
  self:updateTalkTypeList()
  self:updateTalkList()
  self:updateSpine()
end

function this:updateSpine()
end

function this:initFilter()
  local nationTpl = L_GameTpl:getGroupsTpl()
  local nations = nationTpl.data
  local res = {}
  for k, nation in pairs(nations) do
    table.insert(res, {
      name1 = L_Config:provider(nationTpl:getName(nation)),
      name2 = L_Config:provider(nationTpl:getName(nation)),
      id = nationTpl:getId(nation)
    })
  end
  table.sort(res, function(a, b)
    return a.id < b.id
  end)
  self.moduleFiltrateData = {
    closeCurModule = function()
      self.bind.fileterActive = false
    end,
    filtrate = function(data)
      self.filter = data
      self:updateTalkList()
    end,
    filterText = L_WordsTpl:getValue(L_PamiTalkManager.text.filter_birth_place)
  }
  self.moduleFiltrateData.filterOptions = res
  self.modules.moduleFiltrate:initModule(self.moduleFiltrateData)
end

function this:updateTalkTypeList()
  self.typeList, self.typeIndex = L_PamiTalkManager:getPamiLettersCategory()
  self.bind.talkTypeList:clear()
  self.bind.talkTypeList:insert_array(self.typeList)
  self:setTypeListActive()
end

function this:updateTalkList()
  if self.filter ~= nil and #self.filter > 0 then
    self.bind.filterBtnNormalActive = false
    self.bind.filterBtnActive = true
  else
    self.bind.filterBtnNormalActive = true
    self.bind.filterBtnActive = false
  end
  local talkData = L_PamiTalkManager:getPamiLetterGroupsByNation(self.filter)
  if not talkData or not talkData[self.typeIndex] then
    self.bind.contentActive = false
  else
    self.bind.contentActive = true
  end
  if not (talkData and talkData[self.typeIndex]) or #talkData[self.typeIndex] == 0 then
    self.bind.topicZoneActive = false
    self.bind.emptyTipsActive = true
    return
  end
  self.bind.topicZoneActive = true
  self.bind.emptyTipsActive = false
  self.bind.talkList:clear()
  self.bind.talkList:insert_array(talkData[self.typeIndex])
end

function this:updateTopBar()
  local uiTile = L_WordsTpl:getValue(L_PamiTalkManager.text.ui_Title)
  local data = {
    name = uiTile,
    helpBtnBool = false,
    mainBtnBool = false,
    closeCurPage = function()
      L_UI:close(self.pageName)
    end
  }
  self.modules.moduleCommonTop:initModule(data)
end

function this:setTypeListActive()
  for i = 1, #self.bind.talkTypeList do
    local typeIndex = self.bind.talkTypeList:getValue(i, "typeIndex")
    local active = typeIndex == self.typeIndex
    self.bind.talkTypeList:change(i, {selectedActive = active})
  end
end

return this
