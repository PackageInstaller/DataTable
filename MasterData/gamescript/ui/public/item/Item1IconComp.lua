local Item1IconComp, Super = System.NewComponent("Item1IconComp", ItemIconCompBase)

function Item1IconComp:ctor(uiNode, dataSourceType, data)
  Super.ctor(self, uiNode, Item_Public_ArticleResource, dataSourceType, data)
end

function Item1IconComp:OnBind(binder)
  Super.OnBind(self, binder)
end

function Item1IconComp:BindNumSource(data)
  if data.num ~= nil then
    self.ui.Group_Number:SetActive(true)
    self.binder:BindToRaw(function(d, v, o)
      local text = StrUtils.NumberConvert(v)
      self.binder:SetText(self.ui.Text_Article_Number, text)
    end, function()
      return data.num
    end, true)
  else
    self.ui.Group_Number:SetActive(false)
  end
end

return Item1IconComp
