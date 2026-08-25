local MainShopData = Vue.reactive({})
MainShopData.shopData = {
  [1] = {
    goodsList = {
      {
        uid = 0,
        tid = 0,
        itemTid = 1,
        num = 0,
        buyCount = 0,
        price = 0,
        discount = 0,
        isSell = true,
        lock = false
      },
      {
        uid = 0,
        tid = 0,
        itemTid = 1,
        num = 0,
        buyCount = 0,
        price = 0,
        discount = 0,
        isSell = false,
        lock = false
      }
    },
    refreshCount = 0
  },
  [2] = {
    goodsList = {
      {
        uid = 0,
        tid = 0,
        itemTid = 1,
        num = 0,
        buyCount = 0,
        price = 0,
        discount = 0,
        isSell = true,
        lock = false
      },
      {
        uid = 0,
        tid = 0,
        itemTid = 1,
        num = 0,
        buyCount = 0,
        price = 0,
        discount = 0,
        isSell = false,
        lock = false
      }
    },
    refreshCount = 0
  },
  [3] = {
    goodsList = {
      {
        uid = 0,
        tid = 0,
        itemTid = 1,
        num = 0,
        buyCount = 0,
        price = 0,
        discount = 0,
        isSell = true,
        lock = false
      },
      {
        uid = 0,
        tid = 0,
        itemTid = 1,
        num = 0,
        buyCount = 0,
        price = 0,
        discount = 0,
        isSell = false,
        lock = false
      }
    },
    refreshCount = 0
  }
}
MainShopData.isInit = false
MainShopData.chargeData = {}
MainShopData.moonCardPurchased = false
MainShopData.moonCardEndTs = 0
MainShopData.energyMonthCardTs = 0
MainShopData.energyMonthCardState = CommonDefine.MonthCardState.Dummy
MainShopData.exchangeNum = 0
return MainShopData
