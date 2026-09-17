local this = class("modulePhotoGroup_petFace", require("ui.pages.photo.group.modulePhotoGroup_base"))

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
        self:playFace(id)
      end
    }
  }
end

function this:open()
  self:initDefaultId()
  self:updateTargetEntity()
  self:initGroupList(L_Const.photoGroup.petFace)
end

function this:initDefaultId()
  self.defaultId = L_Const.photoParam.petDefFace
end

function this:playFace(id)
  self:setFaceId(id)
  if self.parent.curSelectEntityInfo then
    self.parent.curSelectEntityInfo.faceId = id
    local tpl = self.paramTpl:getTplById(id)
    local faceIndex = self.paramTpl:getParam(tpl)
    self.parent.curSelectEntityInfo.entity:playExpression(faceIndex)
  end
end

function this:setFaceId(id)
  self.faceId = id
end

function this:updateTargetEntity()
  if not self.parent then
    return
  end
  local faceId = self.parent.curSelectEntityInfo and self.parent.curSelectEntityInfo.faceId or self.defaultId
  self:setFaceId(faceId)
  self.bind.selectedId = self.faceId
end

return this
