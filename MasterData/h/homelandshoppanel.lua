---@class HomelandShopPanel : HomelandShopPanel_Generate
---##################### 【HomelandShopPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HomelandShopPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HomelandShopPanel = require "HomelandShopPanel_Generate"

---@class MenuObj:UIObj
local MenuObj = class("HomelandShopPanel_MenuObj", UIObj)
function MenuObj:Initialize()
    UIObj.Initialize(self)
    self.tagText = self.transform:Find("labelLayout/tagText"):GetComponent(TypeInfo.TextMeshProUGUI)
    self.closeTimeImg = self.transform:Find("labelLayout/closeTimeImg"):GetComponent(TypeInfo.Image)
    self.closeTimeText = self.transform:Find("labelLayout/closeTimeImg/closeTimeText"):GetComponent(TypeInfo.TextMeshProUGUI)

    self.toggle = self.transform:GetComponent(TypeInfo.Toggle)
    self.toggle.onValueChanged:AddListener(BindCallback(self, self.OnTogglValueChange))
end

function MenuObj:SetData(data)
    UIObj.SetData(self, data)
    self.gameObject:SetActive(data ~= 0)
    if data == 0 then
        return
    end
    local cfg = Config.GetShopListInfo(data)
    if cfg == nil then
        return
    end
    self.tagText.text = cfg.shopName
    self.closeTimeImg.gameObject:SetActive(cfg.shopClose ~= 0 )
    if cfg.shopClose ~= 0 then
        local s = os.date("%Y-%m-%d %H:%M", cfg.shopClose)
        self.closeTimeText.text = s .. "结束"
    end
end
function MenuObj:Select()
    self.breakEvent = true
    self.toggle.isOn = true
    self.breakEvent = nil
end

function MenuObj:OnTogglValueChange(isOn)
    if not isOn then
        return    
    end
    if self.breakEvent == true then
       return 
    end
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.ui:SelectMenu(self.data)
end

---@class HomelandShopPanel_GoodsObj:UIObj
---@field ui HomelandShopPanel
---@field data integer
local GoodsObj = class("HomelandShopPanel_GoodsObj", UIObj)
function GoodsObj:Initialize()

    UIObj.Initialize(self)
    ---@type HomelandShopPanel_Generate_shopItemPrefab
    local peer = self
    peer.content.scaleButton.onClick:AddListener(function()
        self:OnClick()
    end)
    peer.buyBtn.scaleButton.onClick:AddListener(function()
        self:OnClick()
    end)
    self.sellout = false
end

---设置数据
---@param data integer
function GoodsObj:SetData(data)
    UIObj.SetData(self, data)
    self.gameObject:SetActive(data ~= 0)
    if data == 0 then
        return
    end

    local cfg = Config.GetShopMerchandiseInfo(data)
    if cfg == nil then    
        return
    end

    ---@type HomelandShopPanel_Generate_shopItemPrefab
    local peer = self

    local name, desc, icon, quality = Me:GetGoodsItemDisplayInifo(data)

    self.ui:LoadSpriteAsync(icon, peer.iconImg.image)

    self.ui:LoadSpriteAsync(string.format(Config.SpritePath.ItemRankFarme3, quality), peer.quaityImg.image)
    peer.nameText.text.text = name

    peer.numText.text.text = "x" .. tostring(cfg.content[1][3])

    --判断是否限购
    local curBuyCount,  maxBuyCount, limitType = Me:GetGoodLimitCount(self.data)
    peer.discountInfo:SetActive(maxBuyCount ~= 0)

    self.sellout = false
    if limitType ~= GE.ShopLimitType.None  then
        local s = LocalStrEnum["Shop_RefreshType_" .. limitType]
        .. LocalStrEnum.Shop_LimitCount
        peer.limitText.text.text = string.format("%s：%d/%d", s, curBuyCount, maxBuyCount)
        peer.selloutView:SetActive(curBuyCount <= 0)
        self.sellout = curBuyCount <= 0
    else
        peer.limitText.text.text = ""
        peer.selloutView:SetActive(false)
    end

    local isunlock = Me:CheckGoodsUnlock(data)
    peer.lockView:SetActive(not isunlock)
    if not isunlock then
        peer.lockText.text.text = cfg.limitConDesc
    end
  
    local picId, picNum, picRate = Me:GetShopItemPic(data)
    local picItemCfg = Config.GetItemInfo(picId)

    self.ui:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPathSmall, picItemCfg.icon), peer.picIcon.image)
    peer.picText.text.text = tostring(picNum)

    peer.oriPicText.text.text = ""
    self.discountInfo:SetActive(picRate ~= 0)
    if picRate ~= 0 then
        local r = picRate / 10
        peer.discountText.text.text = string.format("%s", tostring(r))
        peer.oriPicText.text.text = tostring(cfg.price[3])
    end
end
function GoodsObj:OnClick()

    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local isUnLock, type = Me:CheckGoodsUnlock(self.data)
    if not isUnLock then
        if type == 2 then
            local cfg = Config.GetShopMerchandiseInfo(self.data)
            UICommonUtils.PopToast(cfg.limitConDesc)
        elseif type == 1 then

        end
        return 
    end
    if self.sellout then
        UICommonUtils.PopToast(LocalStrEnum.merchandiseBuyTip_2)
        return
    end
    self.ui:OnClickGoodItem(self.data)
end

---播放動畫
---@param sortIndex integer 播放順序
function GoodsObj:PlayAnima(sortIndex)

    ---@type HomelandShopPanel_Generate_shopItemPrefab
    local peer = self
    local rTrs = peer.content.rectTransform
    --rTrs.anchoredPosition = Vector2.New(0, -40)
    local canvasGroup = peer.content.canvasGroup
    canvasGroup.alpha = 0
    rTrs:DOKill()
    canvasGroup:DOKill()
    --rTrs:DOAnchorPos(Vector2.zero, 0.2):SetDelay((sortIndex-1)*0.05)
    canvasGroup:DOFade(1, 0.2):SetDelay((sortIndex-1)*0.05)
end

function GoodsObj:KillAnima()
    ---@type HomelandShopPanel_Generate_shopItemPrefab
    local peer = self
    local rTrs = peer.content.rectTransform
    --rTrs.anchoredPosition = Vector2.New(0, -40)
    local canvasGroup = peer.content.canvasGroup
    canvasGroup.alpha = 0
    rTrs:DOKill()
    canvasGroup:DOKill()
end

function GoodsObj:HideAnima()
    ---@type HomelandShopPanel_Generate_shopItemPrefab
    local peer = self
    local rTrs = peer.content.rectTransform
    --rTrs.anchoredPosition = Vector2.New(0, -40)
    local canvasGroup = peer.content.canvasGroup
    canvasGroup.alpha = 0
end


function GoodsObj:Destroy()
    ---@type HomelandShopPanel_Generate_shopItemPrefab
    local peer = self
    local rTrs = peer.content.rectTransform
    local canvasGroup = peer.content.canvasGroup
    rTrs:DOKill()
    canvasGroup:DOKill()
end

function HomelandShopPanel:InitLogic(data)

    self.autoRoot.autoAdjustCanvasRoot:ResetPadding()
   self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
        {GameMsgType.Shop_RefreshShopTypeMsg, self.RecvRefreshShopTypeMsg},
        {GameMsgType.Shop_BuyGoodsMsg, self.RecvBuyGoodsMsg},
        {GameMsgType.RefresShopDataMsg, self.RefresShopDataMsg},
    }

    ---菜单列表
    ---@type MenuObj[]
    self.menuListObjs = {}
    self.menuListToggle.gameObject:SetActive(false)
    ---@type HomelandShopPanel_GoodsObj[]
    self.goodsObjs = {}

    self.shopList.loopGridView:InitGridView(0, BindSelf(self, self.OnItemValueChange))
    UICommonUtils.CalculateColumnCount(self.shopList.loopGridView)
    self.curShopType = 0
end

function HomelandShopPanel:OnOpen(data, initiative)
    if self.spineObject == nil then
        
        local resPath = Config.PrefabPath.RoleSpine
        local spineName = "Role_10004"
        local prefabPath = string.format(resPath, spineName, spineName)

        self:LoadGameObjectAsync(prefabPath, function (obj)
            local spineObject = obj
            spineObject:SetParent(self.spineRoot.rectTransform)
            self.spineObject = spineObject

            --动作轨道配置可能会修改动画播放速度
            local objSpine = spineObject:GetComponent("SkeletonGraphic")
        
            --剧情关闭spine物理效果
            objSpine.PhysicsPositionInheritanceFactor = Vector2.zero
            --获取动画状态
            local objSpineAnim = spineObject:GetComponent("SkeletonAnimation")
            local animationState = objSpineAnim.AnimationState
            animationState:SetAnimation(GE.RoleSpineActionType.Action, "idle_action", true)

            self:PlaySpineAnima()
        end)
    end
    --导航栏
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.HomelandShopPanel)

    ---接管返回方法
    ---初始化页签
    local menuList = Me:GetShopMenuList(GE.ShopGroupType.type1)
    for i = 1, #menuList do
        local menuObj = self.menuListObjs[i]
        if menuObj == nil then
            local obj = EngineUtil.Instantiate(self.menuListToggle.gameObject)

            ---@type MenuObj
            menuObj = MenuObj:Create(obj, self)
            table.insert(self.menuListObjs, menuObj)
        end
        menuObj:SetData(menuList[i])
    end

    local shopType = 0
    if data ~= nil then
        shopType = data
    else
        shopType = menuList[1]
    end

    for i = 1, #self.menuListObjs do
        local listObj = self.menuListObjs[i]
        if listObj.data == shopType then
            listObj:Select()
            break
        end
    end
    self:SelectMenu(shopType, true)

    local loopGridView = self.shopList.loopGridView
    local columnCount = UICommonUtils.CalculateColumnCount(loopGridView)
    local w = self.goodsViewPanel.rectTransform.rect.width
    local cellSizex = loopGridView.ItemSize.x
    local spacingx = loopGridView.ItemPadding.x

    local view_W = (cellSizex + spacingx) * columnCount - spacingx + 30
    local r = view_W - w
    self.goodsViewBgImage.rectTransform.offsetMax = Vector2.New(r, 0)
    if initiative then
        CoveManager.instance():SetHomelandActive(false)
    end

end

function HomelandShopPanel:PlaySpineAnima()

    local spineObject = self.spineObject
    ---@type SkeletonGraphicRenderTexture_Custom
    local myRT = spineObject:GetComponent("SkeletonGraphicRenderTexture_Custom")
    ---@type UnityEngine.RectTransform
    local rTrs = myRT.transform

    rTrs.anchoredPosition = Vector2.New(80, 0)
    myRT.enabled = true
    myRT.color = Color.New(1,1,1,0)
    local seq = DOTween.Sequence()
    seq:AppendInterval(1)
    seq:Append(rTrs:DOAnchorPosX(0, 0.2))
    seq:Join(myRT:DOFade(1, 0.2))
    seq:AppendCallback(function()
        myRT.enabled = false
    end)
    self.seq = seq
    
end

function HomelandShopPanel:OnClose(initiative)
    if initiative then
        CoveManager.instance():SetHomelandActive(true)
    end
end

function HomelandShopPanel:OnDestroy(initiative)
    
    if self.goodsObjs ~= nil then
        for i = 1, #self.goodsObjs do
            local gObj = self.goodsObjs[i]
            gObj:Destroy()
        end
        self.goodsObjs = nil
    end
end

---选中对应商店切页
---@param shopMenuId ShopGroupType
function HomelandShopPanel:SelectMenu(shopMenuId, isForce)

    if self.curShopType == shopMenuId and (not isForce) then
        return
    end

    self.curShopType = shopMenuId
    --是否可以刷新
    local shopCfg = Config.GetShopListInfo(shopMenuId)
    if shopCfg == nil then
        return
    end
    --导航栏
    self.customBackPanel.customBackPanel:OverrideSpecificRes(shopCfg.costType)
    self:UpdateShopRefreshInfo(shopMenuId)
    local goodsTab = Me:GetShopItemList(shopMenuId)
    self.goodsTab = goodsTab
    for i = 1, #self.goodsObjs do
        local gObj = self.goodsObjs[i]
        gObj:KillAnima()
    end
    self.waitPlayEffect = true

    self.shopList.loopGridView:SetListItemCount(0, false)
    self.shopList.loopGridView:SetListItemCount(#self.goodsTab, true)

    TimeMgr:AddWaitTimeExecute(2, function()
        self.waitPlayEffect = false
        ---播放动画
        for i = 1, #self.goodsTab do
            ---@type HomelandShopPanel_GoodsObj
            local gObj = nil
            for j = 1, #self.goodsObjs do
                local temp = self.goodsObjs[j]
                if temp.data == self.goodsTab[i] and temp.gameObject.activeSelf then
                    gObj = temp
                    break
                end
            end
            if gObj ~= nil then
                gObj:PlayAnima(i)
            end
        end
    end, self, true)
end

---更新滑动列表
---@param index integer 数据索引
---@param gridView SuperScrollView.LoopGridView
---@param index integer
---@param row integer
---@param col integer
function HomelandShopPanel:OnItemValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("shopItemPrefab")
    end
    local obj = loopItem.gameObject
    ---@type HomelandShopPanel_GoodsObj
    local goodsObj = nil
    for i = 1, #self.goodsObjs do
        local gObj = self.goodsObjs[i]
        if gObj.gameObject == obj then
            goodsObj = gObj
            break
        end
    end
    if goodsObj == nil then
        goodsObj = GoodsObj:Create(obj, self, self.shopItemPrefab)
        table.insert(self.goodsObjs, goodsObj)
    end
    local data = self.goodsTab[index + 1]
    data = data or 0
    goodsObj:SetData(data)
    if self.waitPlayEffect then
       goodsObj:HideAnima() 
    end
    return loopItem
end

---刷新
function HomelandShopPanel:UpdateShopRefreshInfo(shopType)
    --是否可以刷新
    local shopCfg = Config.GetShopListInfo(shopType)
    if shopCfg == nil then
        return
    end
    ---@type ShopInfo
    local serverShopData = Me:getShopRefreshData()[shopType]
    if serverShopData == nil then
        return
    end

    self.refreshInfoView:SetActive(shopCfg.isManualRefresh ~= 0)
    if shopCfg.isManualRefresh == 0 then
        return
    end
    local s = LocalStrEnum["Shop_RefreshType_" .. shopCfg.shopRefreshType]  ---{"每日", "每周", "每月", "永久"}
    local resetTime = Config.GetConfigInfo("DailyResetTime")
    self.refreshTimeText.text.text = string.format(LocalStrEnum.Shop_Refresh_TimeString, s, resetTime)

    local s = shopCfg.manualRefreshLimit - serverShopData.refreshNum

    --显示刷新道具
    local type, id, num = Me:GetShopRefreshItemInfo(shopType)
    self.refreshCountText.text.text = string.format(LocalStrEnum.Shop_Refresh_CountString, s, shopCfg.manualRefreshLimit)
    --表示免费刷新

    local itemCfg = Config.GetItemInfo(id)
    local iconSprite = itemCfg.icon
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPathSmall, iconSprite), self.refreshItemIcon.image)
    self.refreshItemNumText.text.text = tostring(num)

    self.refreshBtn.gameObject:SetActive(s > 0)
    self.unlockRefreshBtn.gameObject:SetActive(s <= 0)
end

function HomelandShopPanel:OnClickGoodItem(goodsId)
    local data = goodsId
    UIMgr:popUICover("GoodsItemPanel", {goodsId = data, specificResList = self.customBackPanel.customBackPanel._specificResList})
end

--[[
/bottomInfoView/refreshInfoView/refreshBtn onClick 
--]]
function HomelandShopPanel:refreshBtn_ScaleButton_onClick(refreshBtn)

    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local shopCfg = Config.GetShopListInfo(self.curShopType)
    if shopCfg == nil then
       return
    end
    local serverShopData = Me:getShopRefreshData()[self.curShopType]
    if serverShopData == nil then
       return 
    end
    local s = shopCfg.manualRefreshLimit - serverShopData.refreshNum

    --显示刷新道具
    local type, id, num = Me:GetShopRefreshItemInfo(self.curShopType)

    local costStr = ""
    if num == nil or num == 0 then
        costStr = LocalStrEnum.Shop_Refresh_Free        --免费
    else
        local cfg = Config.GetItemInfo(id)
        costStr = string.format("<size=50><sprite name=%s></size>x%s</color>", cfg.icon, num)
    end

    UICommonUtils.PopMsgBox(LocalStrEnum.Shop_Refresh_Title, string.format(LocalStrEnum.Shop_Refresh_Content, s, costStr), MsgBoxType.Msg_Emoji, function()
        Me:ShopRefreshReq(self.curShopType, function()
            self:SelectMenu(self.curShopType, true)
        end)

    end, nil, LocalStrEnum.Shop_Refresh_okBtn, LocalStrEnum.Shop_Refresh_cancleBtn)
end

function HomelandShopPanel:RecvRefreshShopTypeMsg(shopType, ret)

end

---购买商品返回
---@param shopType integer
---@param goodsId integer
---@param buyNum integer
---@param ret integer
function HomelandShopPanel:RecvBuyGoodsMsg(goodsId, buyNum, ret)

    for i = 1, #self.goodsObjs do
        local goodsObj = self.goodsObjs[i]
        if goodsObj ~= nil and goodsObj.data == goodsId then
            goodsObj:SetData(goodsId)
        end
    end
end

---刷新商店信息
function HomelandShopPanel:RefresShopDataMsg()
    --self:SelectMenu(self.curShopType)
end

--[[
/autoRoot/goodsViewPanel/shopItemPrefab/content/buyBtn onClick 
--]]
function HomelandShopPanel:buyBtn_ScaleButton_onClick(buyBtn)

end

--[[
/autoRoot/bottomInfoView/refreshInfoView/unlockRefreshBtn onClick 
--]]
function HomelandShopPanel:unlockRefreshBtn_ScaleButton_onClick(unlockRefreshBtn)

end

return HomelandShopPanel
