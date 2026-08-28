local View = require("UIChildStore/UIChildStoreView")
local DataModel = require("UIChildStore/UIChildStoreDataModel")
local ViewFunction = require("UIChildStore/UIChildStoreViewFunction")
local NPCDialog = require("Common/NPCDialog")
local params
local Luabehaviour = {
  serialize = function()
    return params
  end,
  deserialize = function(initParams)
    View.Img_Icon:SetSprite((GetResPath(88300325)))
    params = initParams
    local data = Json.decode(initParams)
    if not data then
      return
    end
    DataModel.init(data.activityId, data.shopId)
    View.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      View.Group_Right.NewScrollGrid_CommodityList.grid.self:SetDataCount(#DataModel.shopList)
      View.Group_Right.NewScrollGrid_CommodityList.grid.self:RefreshAllElement()
      View.Group_Right.NewScrollGrid_CommodityList.grid.self:MoveToTop()
    end))
    NPCDialog.SetNPC(View.Group_NPC, DataModel.npcId)
    NPCDialog.SetNPCTextByEnum(View.Group_NPC, DataModel.NPCDialogEnum.enterText)
    View.StaticGrid_Coin.grid.self:RefreshAllElement()
  end,
  awake = function()
  end,
  start = function()
  end,
  perupdate = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
