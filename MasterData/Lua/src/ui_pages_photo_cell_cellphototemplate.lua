local this = class("cellPhotoTemplate", G_UIModuleBase)

function this.bind()
  return {
    activeSelBoard = false,
    activeDeleteBtn = false,
    activeInfoNode = false,
    activeNoneNode = false,
    btn_edit = false,
    img_name = true,
    inputName = ""
  }
end

function this.methods()
  return {
    onClickEdit = function(self)
      local templateData = L_PhotoStore:getTemplateData(self.bind.type, self.bind.id, true)
      local data = {
        txtTitle = L_WordsTpl:getValue("ui_photo_template_changename"),
        txtContent = templateData.name,
        placeHolder = L_WordsTpl:getValue("ui_photo_template_changename_default"),
        limit = 7,
        textBoxType = L_Const.CommonTextBoxType.Rename,
        confirmCallback = function(txt)
          local systemId = L_SystemConst.enum.renamePhotoTemplate
          if L_SystemBreakManager:checkBanSystemAndTip(systemId) then
            return
          end
          if not self.bind.id then
            return
          end
          if templateData and not string.isEmpty(txt) and templateData.name ~= txt then
            txt = C_LuaUtility.StringSub(txt, 0, L_PhotoStore.tempRenameMaxNum)
            L_PhotoStore:req_renameTemplate(templateData.id, txt, function(isSuccess)
              if isSuccess then
                templateData.name = txt
              end
              self.bind.inputName = templateData.name
            end)
          else
            self.bind.inputName = templateData.name
          end
        end
      }
      L_GameUtil.showNormalTextBox(data)
    end,
    onDelete = function(self)
      if not self.bind.id then
        return
      end
      L_GameUtil.showCommonTip({
        txtTitle = L_WordsTpl:getValue("ui_cellPhotoTemplate_02"),
        txtContent = L_WordsTpl:getValue("ui_cellPhotoTemplate_01"),
        confirmCallback = function()
          if L_PhotoStore:removeTemplateData(self.bind.type, self.bind.id) then
            self.parent:refreshMain()
          end
        end
      })
    end,
    onClickCell = function(self)
      self:emit("onClickCell", self)
    end
  }
end

function this:open()
  self.templateData = self.templateData or table.empty
  self.bind.isSelect = false
  if L_DeviceTpl:getIsMobile() then
    self.bindComponents.txt_ornamental_fontsize.fontSize = 24
    self.bindComponents.inputfiled_pointsize.pointSize = 22
    self.bindComponents.img_bg_h.sizeDelta = C_Vector2(200, 64)
  end
  if L_DeviceTpl:getIsPc() then
  end
  self:refreshMain()
end

function this:close()
  if self.texture then
    C_PhotoManager.ReleaseTexture(self.texture)
    self.texture = nil
  end
end

function this:refreshMain()
  self.bind.activeInfoNode = not math.isEmpty(self.bind.id)
  self.bind.activeNoneNode = math.isEmpty(self.bind.id)
  if self.bind.type == L_Const.photoTemplateDataType.config then
    self.bind.btn_edit = false
    self.bind.activeDeleteBtn = false
  elseif self.bind.type == L_Const.photoTemplateDataType.custom then
    self.bind.btn_edit = not math.isEmpty(self.bind.id)
    self.bind.activeDeleteBtn = not math.isEmpty(self.bind.id)
  end
  if self.bind.type == L_Const.photoTemplateDataType.custom then
    self:createTexWithName(self.bind.bgImgName)
  elseif self.bind.type == L_Const.photoTemplateDataType.config then
    self.bindComponents.bgImg:ClearLoadSpriteData()
    self.bindComponents.bgImg:LoadSprite(self.bind.bgImgName, false)
  else
    self.bindComponents.bgImg:LoadSprite(self.bind.bgImgName)
  end
end

function this:refreshSelect(isSelect)
  self.bind.activeSelBoard = isSelect
end

function this:refreshImg()
  if self.bindComponents.bgImg ~= nil and self.sprite ~= nil then
    self.bindComponents.bgImg.sprite = self.sprite
    self.bindComponents.bgImg:SetNativeSize()
    self.bindComponents.bgImgTrans.anchorMin = C_Vector2(0.5, 0.5)
    self.bindComponents.bgImgTrans.anchorMax = C_Vector2(0.5, 0.5)
    self.bindComponents.bgImgTrans.anchoredPosition = C_Vector2(0, 0)
  end
end

function this:createTexWithName(name)
  if string.isEmpty(name) then
    return
  end
  L_PhotoManager:loadHeadTex(name, function(tex)
    if tex then
      if self.texture then
        C_PhotoManager.ReleaseTexture(self.texture)
        self.texture = nil
      end
      self.texture = tex
      local rect = C_Rect(0, 0, tex.width, tex.height)
      local pivot = C_Vector2.one * 0.5
      self.sprite = Unity.Sprite.Create(tex, rect, pivot)
      self:refreshImg()
    end
  end, L_PhotoStore.path.tempBgSavePath, L_PhotoStore.path.tempBgCDNPath)
end

return this
