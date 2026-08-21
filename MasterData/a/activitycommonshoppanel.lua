---@class ActivityCommonShopPanel : ActivityCommonShopPanel_Generate
---##################### 【ActivityCommonShopPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ActivityCommonShopPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ActivityCommonShopPanel = require "ActivityCommonShopPanel_Generate"

function ActivityCommonShopPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
        {GameMsgType.Shop_BuyGoodsMsg, self.refreshUI},
        {GameMsgType.RefresShopDataMsg, self.refreshUI},
    }
end

--function ActivityCommonShopPanel:StartCreating(time)
--
--end

--function ActivityCommonShopPanel:StartEnter(time)
--
--end

--function ActivityCommonShopPanel:StartRemoving(time)
--
--end

--function ActivityCommonShopPanel:StartExit(time)
--
--end

function ActivityCommonShopPanel:OnOpen(data, initiative)
    self:initData(data)
    if initiative then
        self:initUI()
    end
    self:refreshUI()
end

function ActivityCommonShopPanel:initData(data)
    if not data or not data.shopIdList then
        LuaLogger.e("ActivityCommonShopPanel:initData data or data.shopIdList is nil")
        return
    end
    self.curShopId = data.shopIdList[1]
    self.shopIdList = data.shopIdList
    self.tabList = {}
    --商品id列表
    self.goddIdList = {}
end

function ActivityCommonShopPanel:initUI(data)
    self:FillTemplateContent(self.toggleBtn, self.toggleList, tablex.size(self.shopIdList), function (index, itemObj)
        itemObj.isOn:SetActive(index == 1)
        local shopId = self.shopIdList[index]
        local shopCfg = Config.GetShopListInfo(shopId)
        if shopCfg then
            itemObj.name1.text.text = shopCfg.shopName
            itemObj.name2.text.text = shopCfg.shopName
        end
        table.insert(self.tabList, {
            itemObj = itemObj,
            shopId = self.shopIdList[index],
        })
        itemObj.scaleButton.onClick:RemoveAllListeners()
        itemObj.scaleButton.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self.curShopId = shopId
            self:refreshUI()
        end)
    end)
    self.shopLoopList.loopGridView:InitGridView(tablex.size(self.goddIdList), function(gridView, index, row, col)
        local loopListViewItem2 = gridView:GetShownItemByItemIndex(index)
        if loopListViewItem2 == nil then
            loopListViewItem2 = gridView:NewListViewItem("CommonShopBox")
        end
        local itemObj = loopListViewItem2.gameObject
        EngineUtil.FillPeer(self.commonShopBox, itemObj)
        local goodId = self.goddIdList[index + 1]
        if goodId then
            local cfg = Config.GetShopMerchandiseInfo(goodId)
            if cfg == nil then    
                return
            end
            local picId, picNum, picRate = Me:GetShopItemPic(goodId)
            local picItemCfg = Config.GetItemInfo(picId)
            if not picItemCfg then
                return
            end
            local name, desc, icon, quality = Me:GetGoodsItemDisplayInifo(goodId)
            itemObj.taskName.text.text = name

            self:LoadSpriteAsync(string.format(Config.SpritePath.ItemRankFarme3, quality), itemObj.quaityImg.image)
            self:LoadSpriteAsync(icon, itemObj.iconImg.image)
            itemObj.numText.text.text = "x" .. tostring(cfg.content[1][3])

            local curBuyCount,  maxBuyCount, limitType = Me:GetGoodLimitCount(goodId)
            local showSellOut = false
            if limitType ~= GE.ShopLimitType.None  then
                itemObj.limitTip:SetActive(true)
                itemObj.limitText.text.text = string.format("%d/%d", curBuyCount, maxBuyCount)
                if curBuyCount <= 0 then
                    showSellOut = true
                end
            else
                itemObj.limitTip:SetActive(false)
                itemObj.limitText.text.text = ""
            end
            itemObj.scaleButton.onClick:RemoveAllListeners()
            
            if showSellOut then
                itemObj.selloutView:SetActive(true)
                itemObj.priceBg:SetActive(false)
            else
                itemObj.selloutView:SetActive(false)
                itemObj.priceBg:SetActive(true)
                self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPathSmall, picItemCfg.icon), itemObj.picIcon.image)
                itemObj.picText.text.text = tostring(picNum)
                itemObj.scaleButton.onClick:AddListener(function()
                    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
                    UIMgr:popUICover("GoodsItemPanel", goodId)
                end)
            end
        end
        return loopListViewItem2
    end)
end

function ActivityCommonShopPanel:refreshUI()
    for _, tab in pairs(self.tabList) do
        tab.itemObj.isOn:SetActive(tab.shopId == self.curShopId)
    end
    local shopCfg = Config.GetShopListInfo(self.curShopId)
    if shopCfg == nil then
        return
    end
    self.customBackPanel.customBackPanel:OverrideSpecificRes(shopCfg.costType)

    self.goddIdList = Me:GetShopItemList(self.curShopId)
    self.shopLoopList.loopGridView:SetListItemCount(tablex.size(self.goddIdList))
    self.shopLoopList.loopGridView:RefreshAllShownItem2()
end

--function ActivityCommonShopPanel:OnClose(initiative)
--
--end

--function ActivityCommonShopPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ActivityCommonShopPanel:OnRefresh(data)
--
--end

--[[
/TaskLoopList/Viewport/Content/CommonShopBox/GoToBtn onClick 
--]]
function ActivityCommonShopPanel:goToBtn_ScaleButton_onClick(goToBtn)

end

--[[
/TaskLoopList/Viewport/Content/CommonShopBox/GetBtn onClick 
--]]
function ActivityCommonShopPanel:getBtn_ScaleButton_onClick(getBtn)

end

--[[
/ToggleBtn onClick 
--]]
function ActivityCommonShopPanel:toggleBtn_ScaleButton_onClick(toggleBtn)

end

--[[
/ShopLoopList/Viewport/Content/CommonShopBox onClick 
--]]
function ActivityCommonShopPanel:commonShopBox_ScaleButton_onClick(commonShopBox)

end

return ActivityCommonShopPanel
