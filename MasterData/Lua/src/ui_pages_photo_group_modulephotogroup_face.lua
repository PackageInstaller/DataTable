local this = class("modulePhotoGroup_face", require("ui.pages.photo.group.modulePhotoGroup_base"))

function this.bind()
  return {
    selectedId = 0,
    goSlider = false,
    list = {
      moduleName = "pages/photo/cell/cellPhotoImage"
    }
  }
end

function this.methods()
  return {
    list = {
      onClick_handle = function(self, id)
        self:playAction(id)
      end
    },
    onClickCollect = function(self, isOn)
      self:onClickCollect(isOn)
    end,
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end
  }
end

function this:open()
  self:initDefaultId()
  self:initSelect()
  L_PhotoManager:addListener(L_PhotoManager.event.selectPhotoHeroChange, self.onEvent_selectPhotoHeroChange, self)
end

function this:show()
  self:initList()
  self:setSelectState()
end

function this:initSelect()
  local args = self:getUseArgs(L_Const.photoTemplateSettingParam.face)
  local initId = args and args.val or self.defaultId
  self.bind.selectedId = initId
  self:playAction(initId)
end

function this:onEvent_selectPhotoHeroChange(heroID)
  if not self.isBind or not heroID then
    return
  end
  local initId = self.defaultId
  self.bind.selectedId = initId
  self.actionId = initId
  L_PhotoManager:getMediator().playFaceActionId = nil
end

function this:close()
  L_PhotoManager:removeListener(L_PhotoManager.event.selectPhotoHeroChange, self.onEvent_selectPhotoHeroChange, self)
end

function this:initDefaultId()
  self.defaultId = L_Const.photoParam.defaultFace
end

function this:getTargetEntity()
  return L_PhotoManager:getMediator().target
end

function this:playAction(actionId)
  if self.actionId == actionId then
    return
  end
  if actionId == 602 then
    C_GameUtil.SetEntityEyeBlink(L_PhotoManager:getMediator().target, false)
  else
    C_GameUtil.SetEntityEyeBlink(L_PhotoManager:getMediator().target, true)
  end
  self.actionId = actionId
  L_PhotoManager:getMediator().playFaceActionId = actionId
  local collectData = L_PhotoManager:checkCollectFace(self.actionId)
  if collectData then
    self.bindComponents.tog_collect:SetIsOnWithoutNotify(collectData.isOn)
  end
end

function this:onClickCollect(isOn)
  L_PhotoManager:setCollectFace(self.actionId, isOn)
  for i, v in pairs(self.modules.list) do
    if v.bind.id == self.actionId then
      v.bind.isCollect = isOn
    end
  end
end

function this:initList()
  for _, v in pairs(self.modules.list) do
    v:clearTabGroup()
  end
  local list = self.paramTpl:getListByGroupId(L_Const.photoGroup.face)
  local dataList = {}
  for i, tpl in pairs(list) do
    local data = {}
    self:packList(data, tpl)
    local collectData = L_PhotoManager:checkCollectFace(tpl.id)
    data.isCollect = collectData.isOn
    data.collectTime = collectData.time
    data.sortIndex = tpl.sequence
    table.insert(dataList, data)
  end
  table.sort(dataList, function(a, b)
    if a.isCollect ~= b.isCollect then
      return a.isCollect
    end
    if a.isCollect and b.isCollect and a.collectTime ~= b.collectTime then
      return a.collectTime > b.collectTime
    end
    return a.sortIndex < b.sortIndex
  end)
  self.bind.list:clear()
  self.bind.list:insert_array(dataList)
end

function this:setSelectState()
  self.bind.selectedId = L_PhotoManager:getMediator().playFaceActionId
  local collectData = L_PhotoManager:checkCollectFace(self.actionId)
  if collectData then
    self.bindComponents.tog_collect:SetIsOnWithoutNotify(collectData.isOn)
  end
end

return this
