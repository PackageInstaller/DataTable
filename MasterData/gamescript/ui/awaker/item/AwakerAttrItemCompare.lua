local AwakerAttrItemCompare, Super = System.NewComponent("AwakerAttrItemCompare", AwakerAttrItem)

function AwakerAttrItemCompare:ctor(res, data)
  Super.ctor(self, res, data)
end

function AwakerAttrItemCompare:_OnBindDiffPart()
  self.ui.Image_Arrow:SetActive(false)
  self.ui.Text_Compare:SetActive(false)
  self.ui.Text_Count:SetActive(true)
end

return AwakerAttrItemCompare
