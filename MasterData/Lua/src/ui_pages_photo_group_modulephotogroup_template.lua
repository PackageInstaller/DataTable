local this = class("modulePhotoGroup_template", require("ui.pages.photo.group.modulePhotoGroup_base"))
local templateListSize = L_DeviceTpl:getIsPc() and C_Vector2(412, 903) or C_Vector2(412, 671)
local _photoTemplateTpl = L_GameTpl:getPhotoTemplateTpl()
local STATE_MENU = {CONFIG = 1, CUSTOM = 2}

function this.bind()
  return {
    txt_empty = "",
    img_empty = false,
    activeAddBtn = false,
    mainList = {
      moduleName = "pages/photo/cell/cellPhotoTemplate"
    },
    size_mainList = templateListSize,
    moduleTitle = {
      moduleName = "pages/photo/modulePhotoListTitle"
    },
    txt_title1 = "",
    txt_title2 = "",
    txt_max = "",
    txt_cur = "",
    active_iconStar1 = false,
    active_iconStar2 = false
  }
end

function this.methods()
  return {
    moduleTitle = {
      onClickToggle = function(self, isOn)
        self:switchState(isOn)
      end
    },
    mainList = {
      onClickCell = function(self, cell)
        local function refreshFunc()
          self:refreshMainList(cell.bind.id)
        end
        
        if math.isEmpty(cell.bind.id) then
          L_PhotoManager:setTempChooseData(nil, nil, refreshFunc)
        else
          L_PhotoManager:setTempChooseData(cell.bind.type, cell.bind.id, refreshFunc)
        end
      end
    },
    onClickAdd = function(self, bind)
      local function sureCb(tempName, tex, callback)
        if L_PhotoStore:checkCustomTempIsMax() then
          if L_CommonUtil.isValid(tex) then
            tex:ReleaseTexture()
          end
          L_FlyMsgManager:showNormalMsgByKey("notice_modulePhotoGroup_template_04")
          callback(false)
          return
        end
        local id = L_PhotoStore:getAutoCustomTempId()
        L_PhotoManager:uploadTemplateImg(id, true, nil, function(bool, data, name)
          if bool then
            local data = L_PhotoManager:createPhotoWorldData(L_Const.photoTemplateDataType.custom, id, name, tempName)
            printf("createPhotoWorldData fullStr", data:toString())
            L_PhotoStore:req_createTemplate(data:toProtoSendData(), function(isSuccess)
              if isSuccess then
                self:refreshMain()
                self:refreshMainList(self.curSelectId)
              else
                L_PhotoStore:removeTemplateData(data.type, data.id, true)
              end
              callback(isSuccess)
            end)
          else
            callback(false)
            L_FlyMsgManager:showNormalMsgByKey("notice_modulePhotoGroup_template_03")
          end
        end, tex)
      end
      
      local width, height
      local oriWidth, oriHeight = 768, 432
      local d = C_Screen.height * oriWidth / (C_Screen.width * oriHeight)
      if d < 1 then
        height = oriHeight
        width = math.ceil(C_Screen.width / C_Screen.height * height)
      else
        width = oriWidth
        height = math.ceil(C_Screen.height / C_Screen.width * width)
      end
      L_PhotoManager:sendEvent(L_PhotoManager.event.pagePhotoWhiteCut, true)
      L_PhotoManager:capture(function(t2d)
        L_UI:open("pageTemplateTip", {
          ok_cb = sureCb,
          rt = t2d,
          openCallback = function()
            L_PhotoManager:sendEvent(L_PhotoManager.event.pagePhotoWhiteCut, false)
          end
        })
      end, width, height)
    end,
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end
  }
end

function this:open()
  L_PhotoManager:enterPhotoTemplate()
  self.state = STATE_MENU.CONFIG
  self.curSelectId = 0
end

function this:show()
  self:refreshMain()
  self:refreshMainList(self.curSelectId)
end

function this:close()
  L_PhotoManager:exitPhotoTemplate()
end

function this:getShowDataList()
  local list = {}
  local dataList
  if self.state == STATE_MENU.CONFIG then
    dataList = _photoTemplateTpl.data
    for _, data in pairs(dataList) do
      if _photoTemplateTpl:getShow(data) then
        table.insert(list, {
          id = _photoTemplateTpl:getId(data),
          type = L_Const.photoTemplateDataType.config,
          inputName = _photoTemplateTpl:getName(data),
          bgImgName = _photoTemplateTpl:getIconStr(data)
        })
      end
    end
    self.bind.size_mainList = L_DeviceTpl:getIsPc() and C_Vector2(412, 903) or C_Vector2(412, 671)
  elseif self.state == STATE_MENU.CUSTOM then
    local dataTemp = _photoTemplateTpl.data[0]
    table.insert(list, {
      id = _photoTemplateTpl:getId(dataTemp),
      type = L_Const.photoTemplateDataType.custom,
      inputName = _photoTemplateTpl:getName(dataTemp),
      bgImgName = _photoTemplateTpl:getIconStr(dataTemp)
    })
    dataList = L_PhotoStore:getCustomTempList()
    for _, data in pairs(dataList) do
      table.insert(list, {
        id = data.id,
        type = L_Const.photoTemplateDataType.custom,
        inputName = data.name,
        bgImgName = data.url
      })
    end
    self.bind.size_mainList = L_DeviceTpl:getIsPc() and C_Vector2(412, 843) or C_Vector2(412, 611)
  end
  return list
end

function this:refreshMain()
  local list = self:getShowDataList()
  self.bind.mainList:clear()
  self.bind.mainList:insert_array(list)
  if 0 < #list then
    self.bind.img_empty = false
  else
    self.bind.img_empty = true
  end
  self.bind.txt_empty = L_WordsTpl:getValue("notice_modulePhotoGroup_template_02")
  self:refreshTitleTxt()
end

function this:refreshTitleTxt()
  local num = L_PhotoStore:getCustomTempCount()
  local str = string.format("(%s/%s)", num, L_PhotoStore.canAddTempMaxVal)
  self.bind.txt_cur = tostring(num)
  self.bind.txt_max = "/" .. tostring(L_PhotoStore.canAddTempMaxVal)
  self.bind.txt_title1 = L_WordsTpl:getValue("notice_modulePhotoGroup_template_01")
  self.bind.txt_title2 = L_WordsTpl:getValue("notice_modulePhotoGroup_template_01")
end

function this:refreshMainList(selectId)
  local isCustomShowStar = false
  local cell_photoTemplate
  for _, v in pairs(self.modules.mainList) do
    local cell = v
    local isSelect = selectId == v.bind.id
    cell:refreshSelect(isSelect)
    if self.curSelectId == v.bind.id then
      cell_photoTemplate = v
    elseif selectId == v.bind.id then
      cell_photoTemplate = v
    end
  end
  self.curSelectId = selectId
  if cell_photoTemplate then
    if cell_photoTemplate.bind.type == L_Const.photoTemplateDataType.custom then
      isCustomShowStar = true
    else
      isCustomShowStar = false
    end
  else
    return
  end
  self.bind.active_iconStar1 = not isCustomShowStar
  self.bind.active_iconStar2 = isCustomShowStar
end

function this:switchState(isOn)
  if isOn then
    self.state = STATE_MENU.CUSTOM
  else
    self.state = STATE_MENU.CONFIG
  end
  self:refreshMain()
  self:refreshMainList(self.curSelectId)
end

return this
