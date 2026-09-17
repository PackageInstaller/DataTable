local this = class("libraryBookStore", G_BaseStore)
this.event = {
  libraryBookChange = "libraryBook_add"
}
this:importPartialClass(require(L_R.store .. "libraryBook.libraryBookState"))
this:importPartialClass(require(L_R.store .. "libraryBook.libraryBookAction"))

function this:ctor()
  this.super.ctor(self)
end

function this.removeItem(id)
  self.data.itemDic[id] = nil
end

return this
