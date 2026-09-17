local this = class("productStore", G_BaseStore)
this.event = {
  refreshHomeProduct = "productStore_refreshHomeProduct",
  closeTargetInfo = "productStore_closeTargetInfo",
  refreshFastProduct = "productStore_refreshFastProduct",
  accessoryProductCb = "productStore_accessoryProduct_Cb",
  productStartCb = "productStore_productStart_Cb",
  quickProductStart = "productStore_quickProductStart_Cb",
  quickProductCancel = "productStore_quickProductCancel_Cb",
  productCancel = "productStore_productCancel_Cb",
  productFinish = "productStore_productFinish_Cb",
  refreshAccessory = "productStore_refreshAccessory",
  refreshProductFormulaInfo = "productStore_refreshProductFormulaInfo",
  refreshMaxLimitProductFormulaInfo = "productStore_refreshMaxLimitProductFormulaInfo",
  productFinishGuide = "productStore_productFinishGuide"
}
this:importPartialClass(require(L_R.store .. "product.productState"))
this:importPartialClass(require(L_R.store .. "product.productAction"))
return this
