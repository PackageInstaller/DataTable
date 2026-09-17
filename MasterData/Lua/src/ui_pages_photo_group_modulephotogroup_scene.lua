local this = class("modulePhotoGroup_scene", require("ui.pages.photo.group.modulePhotoGroup_base"))

function this.bind()
  return {
    selectedId = 0,
    list = {
      moduleName = "pages/photo/cell/cellPhotoScene"
    },
    activeBtnCur = nil,
    activeBtnGo = nil
  }
end

function this.methods()
  return {
    list = {
      onClick_handle = function(self, id)
        self:refreshSelection(id)
      end
    },
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end,
    onClickGo = function(self)
      self:onClickGo()
    end
  }
end

function this:open()
end

function this:initGroupList(groupId)
  local list = self.paramTpl:getListByGroupId(groupId)
  local content = {}
  for index, tpl in ipairs(list) do
    local data = {}
    self:packList(data, tpl, index)
    table.insert(content, data)
  end
  self.bind.list:clear()
  self.bind.list:insert_array(content)
  return content
end

function this:show()
  self:initGroupList(L_Const.photoGroup.scene)
  self:refreshCur()
  self:refreshSelect()
end

function this:refreshSelection(id)
  if AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
    L_FlyMsgManager:showNormalMsgByKey("notice_photo_noscene")
    return
  end
  self.curSelectId = id
  self:refreshSelect()
end

function this:refreshCur()
  local curSceneId = AzurWorldInstance.CurWorldId
  for i, v in pairs(self.modules.list) do
    local tpl = self.paramTpl:getTplById(v.bind.id)
    local sceneId = tonumber(self.paramTpl:getParam(tpl))
    local isCur = sceneId == curSceneId
    if L_PhotoManager.remSceneId == nil then
      isCur = sceneId == 0
    end
    v.bind.activeCur = isCur
    if isCur then
      self.curSelectId = v.bind.id
    end
  end
end

function this:refreshSelect()
  for i, v in pairs(self.modules.list) do
    v.bind.isOn = self.curSelectId == v.bind.id
  end
  local tpl = self.paramTpl:getTplById(self.curSelectId)
  local sceneId = tonumber(self.paramTpl:getParam(tpl))
  local curSceneId = AzurWorldInstance.CurWorldId
  local isCur = sceneId == curSceneId
  if L_PhotoManager.remSceneId == nil then
    isCur = sceneId == 0
  end
  self.bind.activeBtnCur = isCur
  self.bind.activeBtnGo = not isCur
end

function this:onClickGo()
  local tpl = self.paramTpl:getTplById(self.curSelectId)
  local sceneId = tonumber(self.paramTpl:getParam(tpl))
  if sceneId == 0 then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("notice_photo_sceneQuit"),
      confirmCallback = function()
        L_PhotoManager:backToNormalScene()
        L_PhotoManager.isGoScene = false
      end
    })
  else
    local curSceneId = AzurWorldInstance.CurWorldId
    if sceneId ~= curSceneId then
      local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.photo)
      if not result then
        return
      end
      L_PhotoManager:photoSwitchScene(sceneId)
      L_PhotoManager.isGoScene = true
    end
  end
end

return this
