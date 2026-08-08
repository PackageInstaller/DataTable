local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local m_goods, m_enterType
local ActorTypePrefix = {
  "Window_ActorMainPrefix",
  "Window_ActorAssistPrefix"
}

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnButtonConfirm)
  WU.BindButtonEvent(REF.ButtonCancel, OnCancelClick)
end

function InitWindow()
  m_enterType = this:GetData("GachaScoreShop/EnterType")
  m_goods = this:GetData("GachaScoreShop/Goods")
  SetData()
  if m_enterType == 1 then
    this:RegisterGameEvent("GachaScoreShopClose", function()
      WU.RecycleWindow(this)
    end)
  end
end

function SetData()
  WU.SetActive(REF.DescribeSVNode, false)
  WU.SetActive(REF.WidgetSkinDetail, false)
  WU.SetActive(REF.DescribeArmNode, false)
  if m_goods then
    if m_goods.good and m_goods.good.type == PB.enum.ResourceType.ResActor then
      REF.LabelDescribeTitle.UIHtmlLabel.text = WU.GetString("Window_GachaScroeExchangeTitleActor")
      WU.SetActive(REF.DescribeSVNode, true)
      local actor = m_goods.good
      REF.WidgetIconSlot["$SetActorCustom"]({
        id = actor.id,
        quality = actor.quality
      })
      REF.WidgetIconSlot["$SetClickCallback"](nil)
      REF.SpriteQualityBG.UISprite.spriteName = "actor_type_bg_" .. actor.quality
      REF.SpriteActorType.UISprite.spriteName = "actor_type_" .. actor.id
      REF.LabelCV.UILabel.text = WU.GetString("ActorCV_" .. actor.id)
      REF.LabelDescription.UIHtmlLabel.text = WU.GetString("ActorDescribe_" .. actor.id)
      local actorConfig = PB.get("ActorConfig", actor.id)
      if actorConfig then
        REF.SpriteActorName.UISprite.spriteName = "actor_name_" .. actorConfig.animRes
        local actorTag = PB.get("ActorTag", actor.id)
        if actorTag then
          REF.LabelCharactorType.UILabel.text = WU.GetString(ActorTypePrefix[actorConfig.kind]) .. WU.GetString("tag" .. actorTag.tag[1])
        end
      end
    elseif m_goods.good and m_goods.good.type == PB.enum.ResourceType.ResActorSkin then
      REF.LabelDescribeTitle.UIHtmlLabel.text = WU.GetString("Window_GachaScroeExchangeTitleSkin")
      WU.SetActive(REF.WidgetSkinDetail, true)
      local skin = m_goods.good
      REF.WidgetIconSlot["$SetData"](skin.type, skin.id)
      REF.WidgetSkinDetail["$SetDataBySkinId"](skin.id)
      REF.WidgetIconSlot["$SetClickCallback"](nil)
    elseif m_goods.good and m_goods.good.type == PB.enum.ResourceType.ResUniqueWeapon then
      local armInfo = PB.get("UniqueWeaponInfo", m_goods.good.id)
      if armInfo == nil then
        error("UniqueWeaponInfo.xlsx has no this id " .. m_goods.good.id)
        return
      end
      WU.SetActive(REF.DescribeArmNode, true)
      REF.LabelDescribeTitle.UIHtmlLabel.text = WU.GetString("Window_GachaScroeExchangeTitleWeapon")
      WU.SetLabel(REF.LabelPicturer, WU.GetString("UniqueWeapon_ArtistPrefix") .. armInfo.Artist)
      REF.WidgetIconSlot["$SetData"](m_goods.good.type, m_goods.good.id, nil, "S")
      REF.WidgetIconSlot["$ShowCustom"]({
        hideLevel = true,
        showEquip = false,
        showStar = false,
        phase = 1
      })
      REF.WidgetIconSlot["$SetClickCallback"](nil)
      REF.LabelCharactorTypeArm.UILabel.text = WU.GetString("UniqueWeapon_GachaExchangeKind_" .. armInfo.position)
      REF.TextureArmName.UITexture.mainTexturePath = "Texture/ImpressionRole_name/impression_role_name_" .. m_goods.good.id .. "_0"
      REF.TextureArmName.UITexture:MakePixelPerfect()
      REF.TextureArmName.UITexture.color = CS.NGUIMath.HexToColor(995593215)
      REF.LabelArmDescription.UIHtmlLabel.text = WU.GetString("UniqueWeapon_Story_" .. m_goods.good.id .. "_short")
    end
    REF.LabelCost.ResourcePrinter:SetAutoColor(false, false)
    REF.LabelCost.ResourcePrinter:SetResource(m_goods.cost.type, m_goods.cost.id, m_goods.cost.count)
    REF.LabelOwn.ResourcePrinter:SetAutoColor(true, true)
    REF.LabelOwn.ResourcePrinter:SetResource(m_goods.cost.type, m_goods.cost.id, m_goods.cost.count)
    REF.ScrollView.UIScrollView:ResetPosition()
    REF.ScrollViewArm.UIScrollView:ResetPosition()
  end
end

function OnButtonConfirm()
  if m_goods then
    local tryToPaySuccess = true
    local lackMoney = {}
    WU.TryToPay(m_goods.cost.type, m_goods.cost.id, m_goods.cost.count, function()
    end, function()
      tryToPaySuccess = false
      table.insert(lackMoney, m_goods.cost.type)
    end)
    if tryToPaySuccess then
      if m_enterType == 1 then
        local trade = {
          good_id = m_goods.goodId
        }
        this:GameRequest("fci/gacha-shop/trade"):Post(trade, function(result)
          WU.RecycleWindow("GachaScoreExchange")
          this:BroadcastGameEvent("OnScoreShopPurchaseSuccess", result)
        end)
      elseif m_enterType == 2 then
        local trade = {
          info = m_goods,
          shopId = this:GetData("Shop/Id"),
          buyCount = 1
        }
        local wireFormatTable = ProtobufT("ApiShopTrade", trade)
        this:GameRequest("fci/ShopTrade"):Post(wireFormatTable, function(result)
          WU.RecycleWindow("GachaScoreExchange")
          this:BroadcastGameEvent("OnShopPurchaseSuccess", result)
        end)
      elseif m_enterType == 3 then
        this:GameRequest("fci/gacha-shop-weapon/" .. m_goods.goodId .. "/"):Post(nil, function(result)
          WU.RecycleWindow("GachaScoreExchange")
          this:BroadcastGameEvent("OnScoreShopPurchaseSuccess", result)
        end)
      end
    else
      WU.RecycleWindow("GachaScoreExchange")
      do
        local failedDesc = ""
        for i = 1, #lackMoney do
          if lackMoney[i] == PB.enum.ResourceType.ResPlayerGold then
            failedDesc = WU.GetString("WindowShopBuy_PurchaseFailedA") .. "\n"
          elseif lackMoney[i] == PB.enum.ResourceType.ResPlayerMoney then
            failedDesc = WU.GetString("WindowShopBuy_PurchaseFailedB") .. "\n"
          else
            failedDesc = WU.GetString("WindowShopBuy_PurchaseFailedD") .. "\n"
          end
        end
        WU.ShowHintText(failedDesc)
      end
    end
  end
end

function OnCancelClick()
  WU.RecycleWindow("GachaScoreExchange")
end
