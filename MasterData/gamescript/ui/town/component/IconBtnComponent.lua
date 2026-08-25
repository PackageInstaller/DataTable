local IconBtnComponent, Super = System.NewComponent("IconBtnComponent")

function IconBtnComponent:ctor(res, icon, callback, redDat)
  Super.ctor(self)
  self.ui = Btn_MainSceneResource(res)
  self.icon = icon
  self.callback = callback
  self.redDat = redDat
end

function IconBtnComponent:OnBind(binder)
  self.binder = binder
  self.binder:BindToImage(self.ui.Image_Icon, function()
    if self.icon == nil then
      return nil
    else
      return self.icon
    end
  end)
  self.binder:BindButtonClick(self.ui.uiNode, function()
    if self.callback then
      self.callback()
    end
  end)
  self.ui.Com_Text_New:SetActive(false)
  self.ui.Image_RedPoint:SetActive(false)
  self.ui.Bg_RedPointNumber:SetActive(false)
  if self.redDat then
    self.binder:BindToRaw(function(_, ret, _)
      self.ui.Com_Text_New:SetActive(false)
      self.ui.Image_RedPoint:SetActive(false)
      self.ui.Bg_RedPointNumber:SetActive(false)
      if ret == RedPointDataUtils.RedAttrType.IsNew then
        self.ui.Com_Text_New:SetActive(true)
      elseif ret == RedPointDataUtils.RedAttrType.Red then
        self.ui.Image_RedPoint:SetActive(true)
      elseif ret == RedPointDataUtils.RedAttrType.Num then
        self.ui.Bg_RedPointNumber:SetActive(true)
        local num = RedPointDataUtils.GetNumber(self.redDat)
        self.binder:SetText(self.ui.Text_RedPointNumber, num or 0)
      end
    end, function()
      if self.redDat then
        do return RedPointDataUtils.ShowRedPointStateByList end
        return RedPointDataUtils.ShowRedPointStateByList, DataCenter.redPointData.awaker
      end
    end)
  end
end

return IconBtnComponent
