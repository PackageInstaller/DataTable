local this = class("modulePhotoEdit_stamp", require("ui.pages.photoEdit.group.modulePhotoEdit_base"))
local _max = 5
local photographPicTpl = L_GameTpl:getPhotographPicTpl()

function this.bind()
  return {
    list = {
      moduleName = "pages/photoEdit/cellPhotoEditStamp"
    },
    modulePhotoStampHandle = {
      moduleName = "pages/photoEdit/modulePhotoStampHandle"
    },
    txt_use = "",
    txt_total = "",
    rayCast = false
  }
end

function this.methods()
  return {
    list = {
      onSelect = function(self, id)
        self:createStamp(id)
      end
    },
    onClickStampBg = function(self)
      self:unSelectStamp()
    end,
    modulePhotoStampHandle = {
      onClickDel = function(self, uiRect)
        self:deleteStamp(uiRect)
      end
    }
  }
end

function this:initParam(params)
  self.super.initParam(self, params)
  self:initList()
  self.modulePhotoStampHandle = self.modules.modulePhotoStampHandle
  self.modulePhotoStampHandle.imgRoot = self.imgRoot
  self.stampHandleObj = self.modulePhotoStampHandle.gameObject
  self.modulePhotoStampHandle:setActive(false)
  self:syncPhotoMask()
  self.stampDict = {}
  self.curSelectStamp = nil
  self:moveStampRoot()
end

function this:open()
  self.stampCount = 0
  self.bind.txt_total = "/" .. tostring(_max)
  self:refreshTxt()
end

function this:show()
  self:syncPhotoMask()
  self.bindComponents.stampRoot.gameObject:SetActive(true)
  self.bind.rayCast = true
end

function this:hide()
  self.modulePhotoStampHandle:setActive(false)
  self.curSelectStamp = nil
  self.bind.rayCast = false
end

function this:initList()
  local list = {}
  for i, v in pairs(photographPicTpl.data) do
    local can = L_ConditionManager:singleIsComplete(photographPicTpl:getSystemUnlock(v))
    if can then
      local temp = {
        id = i,
        img = photographPicTpl:getIcon(v)
      }
      table.insert(list, temp)
    end
  end
  self.bind.list:clear()
  self.bind.list:insert_array(list)
end

function this:moveStampRoot()
  self.bindComponents.stampRoot:SetParent(self.photoMask.transform)
  self.bindComponents.stampRoot.anchoredPosition = C_Vector2.zero
  self.bindComponents.stampRoot.offsetMin = C_Vector2.zero
  self.bindComponents.stampRoot.offsetMax = C_Vector2.zero
  self.bindComponents.stampRoot:SetSiblingIndex(1)
  self.modulePhotoStampHandle.gameObject.transform:SetParent(self.imgRoot)
end

function this:createStamp(id)
  if self.stampCount >= _max then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("situation_pic_limit"))
    return
  end
  local obj = CS.Lens.Framework.AzurAssets.Instantiate(self.bindComponents.imgPrefab.gameObject, false).Result
  obj:SetActive(true)
  obj.transform:SetParent(self.bindComponents.stampRoot)
  obj.transform.localPosition = C_Vector3.zero
  obj.transform.localScale = C_Vector3.one
  local img = obj:GetComponent(typeof(C_LImage))
  local tpl = photographPicTpl:getTplById(id)
  local icon = photographPicTpl:getIcon(tpl)
  img:LoadSprite(icon)
  local module = require("ui.pages.photoEdit.cellPhotoEditStampImg").new()
  module:init(obj, function(rect)
    self:onClickStamp(rect)
  end)
  self.stampDict[obj] = module
  self.stampCount = self.stampCount + 1
  self:onClickStamp(obj:GetComponent(typeof(C_RectTransform)))
  self:refreshTxt()
end

function this:onClickStamp(stampRect)
  self.modulePhotoStampHandle:setActive(true)
  self.modulePhotoStampHandle:bindStamp(stampRect, nil, true)
  self.curSelectStamp = stampRect
end

function this:unSelectStamp()
  self.modulePhotoStampHandle:setActive(false)
  self.curSelectStamp = nil
end

function this:deleteStamp(uiRect)
  self:unSelectStamp()
  local module = self.stampDict[uiRect.gameObject]
  if module then
    self.stampDict[uiRect.gameObject] = nil
    module:destroy()
    self.stampCount = self.stampCount - 1
  end
  self:refreshTxt()
end

function this:refreshTxt()
  self.bind.txt_use = tostring(self.stampCount)
end

function this:onSave()
  self.modulePhotoStampHandle:setActive(false)
end

function this:refresh()
end

function this:close()
  self.super.close(self)
  self.stampDict = nil
end

return this
