local AlchemyMainExtModel = NewClass("AlchemyMainExtModel", BaseModel)

function AlchemyMainExtModel:OnInit()
  self.curPage = nil
  self.lastPage = nil
  self.jumpToItemTid = 0
end

function AlchemyMainExtModel:Set_curPage(page)
  if not page or type(page) ~= "number" then
    return
  end
  self.curPage = page
  self:LocalNotify(NotifyId.OnAlchemyPageChanged, page)
end

function AlchemyMainExtModel:Get_curPage()
  return self.curPage
end

function AlchemyMainExtModel:Set_lastPage(page)
  if not page or type(page) ~= "number" then
    return
  end
  self.lastPage = page
end

function AlchemyMainExtModel:Get_lastPage()
  return self.lastPage
end

function AlchemyMainExtModel:Set_jumpToItemTid(itemTid)
  self.jumpToItemTid = itemTid
end

function AlchemyMainExtModel:Get_jumpToItemTid()
  return self.jumpToItemTid
end

return AlchemyMainExtModel
