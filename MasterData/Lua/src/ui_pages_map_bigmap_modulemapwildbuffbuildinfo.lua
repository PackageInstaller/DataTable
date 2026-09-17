local module = class("moduleMapWildBuffBuildInfo", G_UIModuleBase)
local tag = "module:moduleMapWildBuffBuildInfo"
local _worldFilterMarkTpl = L_GameTpl:getWorldFilterMarkTpl()
local _homeBuildingCollectionTpl = L_GameTpl:getHomeBuildingCollectionTpl()
local _productsCollectionTpl = L_GameTpl:getProductsCollectionTpl()
local _homeBuildingBuffWorldTpl = L_GameTpl:getHomeBuildingBuffWorldTpl()

function module:preBind()
  return {}
end

function module:bind()
  return {
    img_icon = "",
    txt_buildName = "",
    txt_state = "",
    txt_desc = "",
    txt_trace = "",
    txt_traceE = ""
  }
end

function module:methods()
  return {
    onClick_trace = function(self)
      self:_OnEventBtnTrace()
    end
  }
end

function module:open()
  L_MapStore:listenCallFunc(L_MapStore.event.refreshNodeTrace, self._OnEventMessageTrace, self)
end

function module:close()
  L_MapStore:unListenCallFunc(L_MapStore.event.refreshNodeTrace, self._OnEventMessageTrace, self)
end

function module:initModule(node)
  self._mapCollectionNode = node
  self:OnRefreshInfo()
end

function module:OnRefreshInfo()
  local node = self._mapCollectionNode
  self._collectionId = node:getCollectionId()
  self._worldFilterMarkId = node:getWorldFilterMarkId()
  if math.isEmpty(self._worldFilterMarkId) then
    errorf(string.format("collection:%s,worldFilterMarkId is empty", self._collectionId))
    return
  end
  local tpl_worldFilterMark = _worldFilterMarkTpl:getTplById(self._worldFilterMarkId)
  self.bind.img_icon = _worldFilterMarkTpl:getIconBg(tpl_worldFilterMark)
  local isHadBuild, buffBuildId = node:getIsHadBuild()
  self.bind.txt_buildName = _worldFilterMarkTpl:getName(tpl_worldFilterMark)
  if isHadBuild then
    local tpl = _homeBuildingBuffWorldTpl:getTplById(buffBuildId)
    self.bind.txt_state = string.format("%sLv.%s", _homeBuildingBuffWorldTpl:getName(tpl), _homeBuildingBuffWorldTpl:getLevel(tpl))
    local descContent = _homeBuildingBuffWorldTpl:getCurBuffContent(tpl)
    self.bind.txt_desc = descContent
  else
    self.bind.txt_state = L_GameUtil.fillColor(L_WordsTpl:getValue("ui_moduleMapCollectionInfo_03"), L_Const.colorHtml.white001)
    self.bind.txt_desc = _worldFilterMarkTpl:getDes(tpl_worldFilterMark)
  end
  self:_OnRefreshNodeTraced()
end

function module:_OnRefreshNodeTraced()
  local curTracedNode = L_MapStore:getCurNodeTargetTracing()
  if table.isEmpty(curTracedNode) then
    self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_04")
  elseif curTracedNode.nodeType == self._mapCollectionNode.type and curTracedNode.id == self._mapCollectionNode.id then
    self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_05")
    self.bind.txt_traceE = "CANCEL"
  else
    self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_04")
    self.bind.txt_traceE = "TRACE"
  end
end

function module:_OnEventMessageTrace()
  self:_OnRefreshNodeTraced()
end

function module:_OnEventBtnTrace()
  local curTracedNode = L_MapStore:getCurNodeTargetTracing()
  if table.isEmpty(curTracedNode) then
    self.parent:excuteNodeFunction()
  elseif curTracedNode.nodeType == self._mapCollectionNode.type and curTracedNode.id == self._mapCollectionNode.id then
    L_MapStore:disposeNodeTarget()
  else
    self.parent:excuteNodeFunction()
  end
end

return module
