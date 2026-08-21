---@class GoodsItemPanel : GoodsItemPanel_Generate
---##################### 【GoodsItemPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【GoodsItemPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local GoodsItemPanel = require "GoodsItemPanel_Generate"
local SetNumView = require("SetNumView")
---@class GoodsItemPanel_GiftItemObj:UIObj
---@field ui GoodsItemPanel
---
local GiftItemObj = class("GoodsItemPanel_GiftItemObj", UIObj)
function GiftItemObj:Initialize()

    UIObj.Initialize(self)

    ---@type GoodsItemPanel_Generate_giftItemPrefab
    local peer = self
    peer.content.scaleButton.onClick:AddListener(BindCallback(self, self.OnClick))
end

---@param data integer[]
function GiftItemObj:SetData(data)
    UIObj.SetData(self, data)
    self.gameObject:SetActive(data ~= nil)
    if data == nil then
        return
    end

    ---@type GoodsItemPanel_Generate_giftItemPrefab
    local peer = self

    local itemId = data[2]
    local itemCfg = Config.GetItemInfo(itemId)
    if itemCfg == nil then
        return
    end
 
    self.ui:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, itemCfg.icon), peer.iconImg.image)

    self.ui:LoadSpriteAsync(string.format(Config.SpritePath.ItemRankFarme, itemCfg.quality), peer.qualityImg_1.image)
    self.ui:LoadSpriteAsync(string.format(Config.SpritePath.ItemRankFarme2, itemCfg.quality), peer.qualityImg_2.image)
    peer.numText.text.text = tostring(data[3])
end

function GiftItemObj:OnClick(data)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Me:ShowItemTips({id = self.data[2], type = self.data[1], navType = GE.NavigationType.GoodsItemPanel})
end

function GoodsItemPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.Shop_BuyGoodsMsg, self.RecvBuyGoodsMsg},
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
    }

    self.maxCount = 0
    self.price = 0
    self.priceItemId = 0
    self.curItemCount = -1

    ---@type GoodsItemPanel_GiftItemObj[]
    self.giftItemObj = {}

    ---@type integer[][]
    self.giftDatas = {}

    self.giftScrollRect.loopGridView:InitGridView(0, BindCallback(self, self.OnItemValueChange))
    UICommonUtils.CalculateColumnCount(self.giftScrollRect.loopGridView)

    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, self.RefreshResource},
    }

    ---@type SetNumView
    local lua_setNumView = SetNumView:new(self.setNumView.gameObject)
    lua_setNumView:InitGenerate()
    self.lua_setNumView = lua_setNumView
end

--function GoodsItemPanel:StartCreating(time)
--
--end

--function GoodsItemPanel:StartEnter(time)
--
--end

--function GoodsItemPanel:StartRemoving(time)
--
--end

--function GoodsItemPanel:StartExit(time)
--
--end

function GoodsItemPanel:OnOpen(data, initiative)

    local goodsId = 0
    local specificResList = nil
    if type(data) == "number" then
        goodsId = data
    elseif type(data) == "table" then
        goodsId = data.goodsId
        specificResList = data.specificResList
    end
    self.goodsId = goodsId
    self.isClosed = false
    local goodsInfo = Me:GetGoodsServerData(goodsId)
    if goodsInfo == nil then
        LuaLogger.es("商品信息错误 未找到服务器数据  goodsId:" .. tostring(goodsId))
        return
    end

    local goodsCfg = Config.GetShopMerchandiseInfo(goodsId)
    if goodsCfg == nil then
        return    
    end

    --导航栏
    self.customBackPanel.gameObject:SetActive(specificResList ~= nil)
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.GoodsItemPanel)
    self.customBackPanel.customBackPanel:OverrideSpecificRes(specificResList)
    self.customBackPanel.customBackPanel.back:SetActive(false)



    local name, desc, icon, quality = Me:GetGoodsItemDisplayInifo(goodsId)

    self:LoadSpriteAsync(icon, self.iconImg.image)

    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemRankFarme3, quality), self.qualityImg.image)

    local itemId = goodsCfg.content[1][2]
    local itemNum = goodsCfg.content[1][3]

    local isGift = #goodsCfg.content > 1
    
    self.numText.text.text = ""
    if not isGift then
       self.numText.text.text = "x" .. tostring(itemNum)  
    end
   
    --判断是否限购
    local curBuyCount, maxBuyCount, limitType = Me:GetGoodLimitCount(goodsId)
    local canByCount = curBuyCount

    self.limitInfo:SetActive(limitType ~= GE.ShopLimitType.None)
    if limitType ~= GE.ShopLimitType.None then
        self.limitCountText.text.text = string.format("-限购%s个-", tostring(canByCount))
    end

    local isGift = (#goodsCfg.content) > 1

    self.itemSpecialInfo:SetActive(not isGift)
    self.giftSpecialInfo:SetActive(isGift)
    self.lua_setNumView.gameObject:SetActive(not isGift)
    self.picInfo_item:SetActive(not isGift)
    self.picInfo_gift:SetActive(isGift)

    self.goodNameText.text.text = name
    self.discribeText.text.text = desc
    if not isGift then
        local ownCount = Me:getItemCountById(itemId)
        self.ownItemText.text.text = string.format("拥有:" .. tostring(ownCount))
    else
        self.giftDatas = {}
        for i = 1, #goodsCfg.content do
            table.insert(self.giftDatas, goodsCfg.content[i])
        end
        self.giftScrollRect.loopGridView:SetListItemCount(0)
        self.giftScrollRect.loopGridView:SetListItemCount(#self.giftDatas, true)
    end
    
    --计算可以购买的最大数量
    local picId, picNum, picRate  = Me:GetShopItemPic(goodsId)
    local itemCfg = Config.GetItemInfo(picId)
 
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPathSmall, itemCfg.icon), function (s)
        self.priceItemImg_1.image.sprite = s
        self.priceItemImg_2.image.sprite = s
        self.gift_priceItemImg_2.image.sprite = s
    end)

    self.unitPriceText.text.text = tostring(picNum)
    self:UpdateBuyData()
end

--function GoodsItemPanel:OnClose(initiative)
--
--end

--function GoodsItemPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function GoodsItemPanel:OnRefresh(data)
--
--end

--[[
/content/titleInfo/closeBtn onClick 
--]]
function GoodsItemPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:playCloseAnim()
end

--[[
/content/buyInfo/cancleBtn onClick 
--]]
function GoodsItemPanel:cancleBtn_ScaleButton_onClick(cancleBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:playCloseAnim()
end

--[[
/content/buyInfo/buyBtn onClick 
--]]
function GoodsItemPanel:buyBtn_ScaleButton_onClick(buyBtn)

    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local picId, picNum, picRate  = Me:GetShopItemPic(self.goodsId)
    picNum = picNum * self.curItemCount
    if picId == GE.ResourceType.PayDiamond  then
        local itemCfg = Config.GetItemInfo(picId)
        local costStr = string.format("<size=200%%><sprite name=%s></size>", itemCfg.icon)
        local name, desc, icon, quality = Me:GetGoodsItemDisplayInifo(self.goodsId)
        UICommonUtils.PopMsgBox(LocalStrEnum.merchandiseBuyPrompt_2, string.format(LocalStrEnum.merchandiseBuyPromptDesc_2, costStr,picNum, self.curItemCount,name), MsgBoxType.Msg_Emoji, function()
            UIMgr:closeCurrentUI(self)
            Me:ShopBuyReq(self.goodsId, self.curItemCount, nil)
        end, nil, LocalStrEnum.Shop_Refresh_okBtn, LocalStrEnum.Shop_Refresh_cancleBtn)
        return
    end
    Me:ShopBuyReq(self.goodsId, self.curItemCount, nil)
    self:playCloseAnim()
end

--[[
/Mask onClick 
--]]
function GoodsItemPanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:playCloseAnim()
end

---更新滑动列表
---@param index integer 数据索引
---@param gridView SuperScrollView.LoopGridView
---@param index integer
---@param row integer
---@param col integer
function GoodsItemPanel:OnItemValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("giftItemPrefab")
    end
    local obj = loopItem.gameObject
    ---@type GoodsItemPanel_GiftItemObj
    local giftItemObj = nil
    for i = 1, #self.giftItemObj do
        local gObj = self.giftItemObj[i]
        if gObj.gameObject == obj then
            giftItemObj = gObj
            break
        end
    end
    if giftItemObj == nil then
        giftItemObj = GiftItemObj:Create(obj, self, self.giftItemPrefab)
        table.insert(self.giftItemObj, giftItemObj)
    end
    local data = self.giftDatas[index + 1]
    data = data or nil
    giftItemObj:SetData(data)
    return loopItem
end

function GoodsItemPanel:SetItemCount(count)
    self.curItemCount = count
    local isCanBuy = count <= self.maxCount
    self.buyBtn.gameObject:SetActive(isCanBuy )
    self.disableBuyBtn.gameObject:SetActive(not isCanBuy)
    self.allPriceText.text.text = tostring(self.price * count)
    self.gift_allPriceText.text.text = tostring(self.price * count)
    local itemCount = Me:getItemCountById(self.priceItemId)

    if itemCount >= self.price * count then
        self.allPriceText.text.text = tostring(self.price * count)
    else
        local s = tostring(self.price * count)
        s = "<color=#FF0000>" .. s .. "</color>"
        self.allPriceText.text.text = s
    end
end

function GoodsItemPanel:RecvBuyGoodsMsg(goodsId, buyNum, ret)
    --UIMgr:closeCurrentUI(self)
end

--[[
/content/buyInfo/disableBuyBtn onClick 
--]]
function GoodsItemPanel:disableBuyBtn_ScaleButton_onClick(disableBuyBtn)
    local picId, picNum, picRate  = Me:GetShopItemPic(self.goodsId)
    local itemCfg = Config.GetItemInfo(picId)
    -- if picId == GE.ResourceType.PayDiamond then
    --     local curBuyCount, maxBuyCount, limitType = Me:GetGoodLimitCount(self.goodsId)
    --     if curBuyCount > 0 then --提示钻石不足
    --         local costStr = string.format("<size=200%%><sprite name=%s></size>", itemCfg.icon)
    --         UICommonUtils.PopMsgBox(LocalStrEnum.merchandiseBuyPrompt_1, string.format(LocalStrEnum.merchandiseBuyPromptDesc_1, costStr), MsgBoxType.Msg_Emoji, function()
    --             local trunToId = 1310002
    --             UICommonUtils.CommonTurnTo(trunToId, self)
    --             --跳转
    --         end, nil, LocalStrEnum.Shop_Refresh_okBtn, LocalStrEnum.Shop_Refresh_cancleBtn)
    --     end
    -- elseif picId == GE.ResourceType.FreeDiamond then
    --     local costStr = string.format("<size=200%%><sprite name=%s></size>", itemCfg.icon)
    --     UICommonUtils.PopMsgBox(LocalStrEnum.ItemExchange_Title, string.format(LocalStrEnum.ItemExchange_Content, costStr), MsgBoxType.Msg_Emoji, function()
           
    --         local goodsId = 9901
    --         local ownCount = Me:getItemCountById(picId)
    --         local c = picNum - ownCount
    --         c = math.max(1, c)
    --         UIMgr:popUICover("ItemExchagnePanel", {goodsId = goodsId, minCount = c})
    --     end, nil, LocalStrEnum.Shop_Refresh_okBtn, LocalStrEnum.Shop_Refresh_cancleBtn)
    -- else
	    UICommonUtils.PopToast(string.format(LocalStrEnum.merchandiseBuyTip_1, itemCfg.itemName))
    --end
end

function GoodsItemPanel:UpdateBuyData()

    local goodsCfg = Config.GetShopMerchandiseInfo(self.goodsId)
    if goodsCfg == nil then
        return    
    end
    --判断是否限购
    local curBuyCount, maxBuyCount, limitType = Me:GetGoodLimitCount(self.goodsId)

    local maxCount = goodsCfg.buylimit
    if limitType ~= GE.ShopLimitType.None then
        maxCount = math.min(maxCount, curBuyCount)
    end
    --计算可以购买的最大数量
    local picId, picNum, picRate  = Me:GetShopItemPic(self.goodsId)
    local ownPicNum = Me:getItemCountById(picId)
    local picByCount = math.floor(ownPicNum / picNum)
    maxCount = math.min(maxCount, picByCount)
    self.isCanBy = maxCount >= 1

    self.price = picNum
    self.maxCount = maxCount
    self.priceItemId = picId
    self.curItemCount = -1

    self.lua_setNumView:SetData({
        maxNum = maxCount,
        titleText = "购买数量",
        onValueChange = function(curVal)
            self:SetItemCount(curVal)
        end
    })
end

function GoodsItemPanel:RefreshResource()
    if self.isClosed then
       return 
    end
    self:UpdateBuyData()
    local count = self.curItemCount
    self.curItemCount = 0
    self:SetItemCount(count)

end

function GoodsItemPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
    self.isClosed = true
end

--[[
/BoxBg/SetNumView/minusBtn onClick 
--]]
function GoodsItemPanel:minusBtn_ScaleButton_onClick(minusBtn)

end

--[[
/BoxBg/SetNumView/plusBtn onClick 
--]]
function GoodsItemPanel:plusBtn_ScaleButton_onClick(plusBtn)

end

--[[
/BoxBg/SetNumView/numSlider onValueChanged 
--]]
function GoodsItemPanel:numSlider_Slider_onValueChanged(numSlider,value)

end

--[[
/BoxBg/SetNumView/maxBtn onClick 
--]]
function GoodsItemPanel:maxBtn_ScaleButton_onClick(maxBtn)

end

return GoodsItemPanel
