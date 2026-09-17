local this = {}

function this.createPage(name, path)
  return L_UI:createPage(name, path)
end

function this.addPageUpdateHandler(instanceId, scriptObject, handler)
  L_UI:addPageUpdateHandler(instanceId, scriptObject, handler)
end

function this.removePageUpdateHandler(instanceId)
  L_UI:removePageUpdateHandler(instanceId)
end

function this.createModule(name, path)
  return L_UI:createModule(name, path)
end

function this.sendMsg(eveId, pageName)
  L_UI:sendEvent(eveId, pageName)
end

function this.createPreviewNpc(uid, go, avatarData, loadNames, entranceType)
  local entity = require(L_EcsConst.aliveType.previewNpc).new(L_EcsConst.aliveType.previewNpc)
  local needLoadedAnimaNameList
  if loadNames ~= nil then
    needLoadedAnimaNameList = {}
    for i = 0, loadNames.Length - 1 do
      needLoadedAnimaNameList[i + 1] = loadNames[i]
    end
  end
  entity:initPreview(uid, go, avatarData, nil, needLoadedAnimaNameList, entranceType)
  return entity
end

local m_result = true

local function _setResult(result)
  m_result = result
end

function this.checkUIOpen(path, options)
  local lua = require(path)
  m_result = true
  if lua.check then
    lua.check(lua, options, _setResult)
  end
  return m_result
end

CS.Azur.Gameplay.UI.UIManager.luaMiddleware:InitLuaAdapter(this)
