local this = class("photoStore", G_BaseStore)
this.event = {
  photoRequest = "photoRequest",
  photoFinishGet = "photoFinishGet"
}
this.path = {
  imgCDNPath = "project-3/playerdata/face/",
  imgSavePath = Unity.Application.persistentDataPath .. "/photo/head/",
  tempBgCDNPath = "project-3/playerdata/template/",
  tempBgSavePath = Unity.Application.persistentDataPath .. "/photo/template/",
  imgStandeeHeroCDNPath = "project-3/playerdata/standee/hero/",
  imgStandeeHeroSavePath = Unity.Application.persistentDataPath .. "/photo/standee/hero/",
  situationCoverCDNPath = "project-3/playerdata/situation/cover/",
  situationCoverSavePath = Unity.Application.persistentDataPath .. "/photo/situation/cover/"
}
this.canShowPetMaxVal = L_GameClientTpl:getData("PHOTO_PET_NUM", L_Const.GameTplType.int)
this.canAddTempMaxVal = L_GameTpl:getGameConstTpl():getData("PHOTO_FORMWORK_MAX", L_Const.GameTplType.int)
this.tempRenameMaxNum = L_GameTpl:getGameConstTpl():getData("PHOTO_FORMWORK_TXT", L_Const.GameTplType.int)
this:importPartialClass(require(L_R.store .. "photo.photoAction"))
this:importPartialClass(require(L_R.store .. "photo.photoState"))

function this:injectCache()
  local paramTpl = L_GameTpl:getPhotographParamTpl()
  local config = paramTpl:getConfig()
  for _, v in pairs(config) do
    local id = paramTpl:getId(v)
    local default = paramTpl:getParam(v)
    self.data.cache[id] = default
  end
end

function this:setCache(id, val)
  self.data.cache[id] = val
end

function this:createTexWithName(name)
  local photoData = require(L_R.store .. "photo.photoData").new()
  photoData.name = name
  self.data.photoDic[name] = photoData
  local imgFilePath = self.path.imgSavePath .. "/" .. name
  local isExists = C_File.Exists(imgFilePath)
  
  local function getCallback(self, flag, tex)
    if flag then
      photoData.img = tex
      L_PhotoStore:call(L_PhotoStore.event.photoFinishGet, {url = name, tex = tex})
      if not isExists then
        C_PhotoManager.SaveTexture2DByPath(imgFilePath, name, tex)
      end
    end
  end
  
  if isExists then
    C_PhotoManager.GetTexture2DByPath(self.path.imgSavePath .. name, getCallback)
  else
    self:getScreenShotHead(self.path.imgGetUrl .. name, getCallback)
  end
end

function this:getScreenShotHead(url, callback)
  local function successCall(self, tex)
    if callback then
      callback(true, tex)
    end
  end
  
  local function failCall(self, key)
    if callback then
      callback(false, nil, key)
    end
  end
  
  C_HttpManager.GetTexture(url, handler(self, successCall), handler(self, failCall))
end

function this:createPhotoTemplateData(type, id, serverData)
  if id == nil or type == nil then
    errorf(string.format("createPhotoTemplateData type:%s, id:%s", type, id))
    return
  end
  local key = string.format("%s_%s", type, id)
  local data = self.data.templateDic[key]
  if not data then
    data = require(L_R.store .. "photo.photoTemplateData").new()
    data.type = type
    data.id = id
    self.data.templateDic[key] = data
  end
  if type == L_Const.photoTemplateDataType.config then
    local _photoTemplateTpl = L_GameTpl:getPhotoTemplateTpl()
    local cfg = _photoTemplateTpl:getTplById(id)
    L_PhotoManager:updateDataByFullStr(data, _photoTemplateTpl:getFullStr(cfg))
  elseif type == L_Const.photoTemplateDataType.custom and serverData then
    data.name = serverData.name
    data.url = serverData.url
    L_PhotoManager:updateDataByFullStr(data, serverData.arg)
  end
  return data
end

return this
