---@class GameShopPanel_HeroSkinMenu : GameShopPanel_HeroSkinMenu_Generate
---##################### 【GameShopPanel_HeroSkinMenu Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【GameShopPanel_HeroSkinMenu Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local GameShopPanel_HeroSkinMenu = require "GameShopPanel_HeroSkinMenu_Generate"

local shopId = 20006

---@type FiltrateGroupData[]
local skinFiltrateCfg = {
    {
        tagName = LocalStrEnum.SkinFiltrate_1,
        selectType = FiltrateSelectType.AllMultiSelect,
        items = {
            {
                itemName = LocalStrEnum.skinTag_0,
                isDefault = true,
            },
            {
                itemName = LocalStrEnum.skinTag_1,
                val = 1,
            },
            {
                itemName = LocalStrEnum.skinTag_2,
                val = 2,
            },
            {
                itemName = LocalStrEnum.skinTag_3,
                val = 3,
            },
            {
                itemName = LocalStrEnum.skinTag_4,
                val = 4,
            },
            {
                itemName = LocalStrEnum.skinTag_5,
                val = 5,
            },
            {
                itemName = LocalStrEnum.skinTag_6,
                val = 6,
            },
            {
                itemName = LocalStrEnum.skinTag_7,
                val = 7,
            },
            {
                itemName = LocalStrEnum.skinTag_8,
                val = 8,
            },
            {
                itemName = LocalStrEnum.skinTag_9,
                val = 9,
            },
            {
                itemName = LocalStrEnum.skinTag_10,
                val = 10,
            }
        },
    },
    {
        tagName = LocalStrEnum.SkinFiltrate_2,
        selectType = FiltrateSelectType.AllMultiSelect,
        items = {
            {
                itemName = LocalStrEnum.skinTag_0,
            },
            {
                itemName = LocalStrEnum.SkinFiltrate_2_2,
                isDefault = true,
                val = 2,
            },
            {
                itemName = LocalStrEnum.SkinFiltrate_2_1,
                isDefault = true,
                val = 1,
            },
            {
                itemName = LocalStrEnum.SkinFiltrate_2_4,
                isDefault = true,
                val = 4,
            },
            {
                itemName = LocalStrEnum.SkinFiltrate_2_3,
                val = 3,
            },
        },
    },
    {
        tagName = LocalStrEnum.SkinFiltrate_3,
        selectType = FiltrateSelectType.SingalSelect,
        items = {
            {
                itemName = LocalStrEnum.skinTag_0,
                isDefault = true,
            },
            {
                itemName = LocalStrEnum.SkinFiltrate_3_1,
                val = 1,
            },
            {
                itemName = LocalStrEnum.SkinFiltrate_3_2,
                val = 2,
            }
        },
    }
}

---@class SkinItemObj:UIObj
local SkinItemObj = class("GameShopPanel_HeroSkinMenu_SkinItemObj", UIObj)

function SkinItemObj:Initialize()
    UIObj.Initialize(self)
    ---@type GameShopPanel_HeroSkinMenu_Generate_skinPrefab
    local peer = self
    peer.content.scaleButton.onClick:AddListener(BindCallback_NoParams(self, self.OnClick))
end

---@param data integer 商品id
function SkinItemObj:SetData(data)
    UIObj.SetData(self, data)
    self.gameObject:SetActive(data ~= 0)
    if data == 0 then
        return
    end
    ---@type GameShopPanel_HeroSkinMenu_Generate_skinPrefab
    local peer = self
    local name, desc, icon, quality = Me:GetGoodsItemDisplayInifo(data)
    self.ui:LoadSpriteAsync(icon, peer.iconImg.image)
    local goodsCfg = Config.GetShopMerchandiseInfo(data)
    local isOwn = false
    local skinId = goodsCfg.content[1][2]
    local skinState = Me:getSkinData(skinId)
    isOwn = skinState ~= nil
    peer.ownInfo:SetActive(isOwn)
    local isUnlock = Me:CheckGoodsUnlock(data)
    peer.unopenInfo:SetActive(not isUnlock)
    local dis = goodsCfg.showDiscount
    peer.discountInfo:SetActive(dis ~= 0 and isUnlock)
    local timeLimit = goodsCfg.merchandiseClose ~= 0 and isUnlock
    peer.timeLimitInfo:SetActive(timeLimit)
    peer.selectImage:SetActive(false)
    local canvasGroup = peer.content.canvasGroup
    canvasGroup.alpha = 1
end

function SkinItemObj:Select(isSelect)
    ---@type GameShopPanel_HeroSkinMenu_Generate_skinPrefab
    local peer = self
    peer.selectImage:SetActive(isSelect)
    if isSelect then
        self.ui:SelectItem(self.data)
    end
end

function SkinItemObj:OnClick()
    self:Select(true)
end

---播放動畫
---@param sortIndex integer 播放順序
function SkinItemObj:PlayAnima(sortIndex)
    ---@type GameShopPanel_HeroSkinMenu_Generate_skinPrefab
    local peer = self
    local rTrs = peer.content.rectTransform
    rTrs.anchoredPosition = Vector2.New(40, 0)
    local canvasGroup = peer.content.canvasGroup
    canvasGroup.alpha = 0
    rTrs:DOKill()
    canvasGroup:DOKill()
    rTrs:DOAnchorPos(Vector2.zero, 0.2):SetDelay((sortIndex-1)*0.05)
    canvasGroup:DOFade(1, 0.2):SetDelay((sortIndex-1)*0.05)
end

function SkinItemObj:KillAnima()
    ---@type GameShopPanel_HeroSkinMenu_Generate_skinPrefab
    local peer = self
    local rTrs = peer.content.rectTransform
    local canvasGroup = peer.content.canvasGroup
    rTrs:DOKill()
    canvasGroup:DOKill()
end

function SkinItemObj:HideAnima()
    ---@type GameShopPanel_HeroSkinMenu_Generate_skinPrefab
    local peer = self
    local rTrs = peer.content.rectTransform
    local canvasGroup = peer.content.canvasGroup
    canvasGroup.alpha = 0
    rTrs:DOKill()
    canvasGroup:DOKill()
end

function SkinItemObj:Destroy()
    ---@type GameShopPanel_HeroSkinMenu_Generate_skinPrefab
    local peer = self
    local rTrs = peer.content.rectTransform
    local canvasGroup = peer.content.canvasGroup
    rTrs:DOKill()
    canvasGroup:DOKill()
end

---@class SkinTagObj:UIObj
local SkinTagObj = class("GameShopPanel_HeroSkinMenu_SkinTagObj", UIObj)

function SkinTagObj:Initialize()
    UIObj.Initialize(self)
end

---@param data integer 标签id
function SkinTagObj:SetData(data)
    UIObj.SetData(self, data)
    self.gameObject:SetActive(data ~= nil)
    if data == nil then
        return
    end

    ---@type GameShopPanel_HeroSkinMenu_Generate_tagPrefab
    local peer = self
    peer.nameText.text.text = LocalStrEnum["skinTag_" .. data]
end

function GameShopPanel_HeroSkinMenu:InitLogic(data)
    ---@type SkinItemObj[]
    self.skinItemObjs = {}
    ---@type integer[]
    self.skinDatas = {}

    ---@type SkinTagObj[]
    self.skinTagObjs = {}

    self.selectInfo = {
        goodsId = 0,
        skinId = 0,
    }

    ---@type FiltrateData
    self.filterData = {
        groups = skinFiltrateCfg,
        callback = BindSelf(self, self.OnFiltrateSelectCallBack)
    }

    for i = 1, #self.filterData.groups do
        local group = self.filterData.groups[i]
        for j = 1, #group.items do
            group.items[j].isSelect = group.items[j].isDefault
        end
    end

    self.tagPrefab.gameObject:SetActive(false)
    self.skinPrefab.gameObject:SetActive(false)

    self.skinScrollRect.loopListView2:InitListView(0, BindSelf(self, self.OnItemValueChange))
end

---@param ui UIBase
function GameShopPanel_HeroSkinMenu:SetParentUI(ui)
    self.parentUI = ui
    self.LoadSpriteAsync = function(self, path, callBack)
        self.parentUI:LoadSpriteAsync(path, callBack)
    end
    self.LoadGameObjectAsync = function(self, path, callBack)
        self.parentUI:LoadGameObjectAsync(path, callBack)
    end
end

function GameShopPanel_HeroSkinMenu:ShowItem()
    local goods = Me:GetShopItemList(shopId)
    local outTimeGoods = Me:GetExceedTimeLimitShopItemList(shopId)
    tablex.move(outTimeGoods, 1, #outTimeGoods, #goods + 1, goods)

    table.sort(goods, BindSelf(Me, Me.SortGoods))
    self.allGoods = goods

    local goods = self:FiltrateGoods()
    local selectId = goods[1]
    if tablex.indexof(goods, self.selectInfo.goodsId) > 0 then
        selectId = self.selectInfo.goodsId
    end
    self.emptyInfo:SetActive(#goods == 0)
    self:SelectItem(selectId)
    self.skinDatas = goods

    for i = 1, #self.skinItemObjs do
        local gObj = self.skinItemObjs[i]
        gObj:KillAnima()
    end
    self.waitPlayEffect = true

    self.skinScrollRect.loopListView2:SetListItemCount(0)
    self.skinScrollRect.loopListView2:SetListItemCount(#self.skinDatas)
    TimeMgr:AddWaitTimeExecute(2, function()
        self.waitPlayEffect = false
         ---播放動畫
        for i = 1, #self.skinDatas do
            ---@type SkinItemObj
            local gObj = nil
            for j = 1, #self.skinItemObjs do
                local temp = self.skinItemObjs[j]
                if temp.gameObject.activeSelf and temp.data == self.skinDatas[i] then
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

function GameShopPanel_HeroSkinMenu:Close()
    if self.spineObject ~= nil then
        GameObject.Destroy(self.spineObject)
        self.spineObject = nil
    end
    self.curSpinePath = nil
    self.selectInfo.goodsId = 0
    self.selectInfo.skinId = 0
end

---更新滑动列表
---@param index integer 数据索引
---@param gridView SuperScrollView.LoopGridView
---@param index integer
---@param row integer
---@param col integer
function GameShopPanel_HeroSkinMenu:OnItemValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("skinPrefab")
    end
    local obj = loopItem.gameObject
    ---@type SkinItemObj
    local skinObj = nil
    for i = 1, #self.skinItemObjs do
        local sObj = self.skinItemObjs[i]
        if sObj.gameObject == obj then
            skinObj = sObj
            break
        end
    end
    if skinObj == nil then
        skinObj = SkinItemObj:Create(obj, self, self.skinPrefab)
        table.insert(self.skinItemObjs, skinObj)
    end
    local data = self.skinDatas[index + 1]
    data = data or 0
    skinObj:SetData(data)

    if data ~= 0 and data == self.selectInfo.goodsId then
        skinObj:Select(true)
    end
    if self.waitPlayEffect then
       skinObj:HideAnima() 
    end

    obj.name = "index_" .. index

    return loopItem
end

---选中商品
---@param goodsId integer
function GameShopPanel_HeroSkinMenu:SelectItem(goodsId)
    for i = 1, #self.skinItemObjs do
        local sObj = self.skinItemObjs[i]
        if sObj.data ~= goodsId then
            sObj:Select(false)
        end
    end

    self.infoBtn.gameObject:SetActive(goodsId ~= nil)
    self.skinInfo:SetActive(goodsId ~= nil)
    self.buyBtn:SetActive(goodsId ~= nil)
    if goodsId == nil then
        if self.spineObject ~= nil then
            GameObject.Destroy(self.spineObject)
            self.spineObject = nil
        end
        self.curSpinePath = nil
        self.selectInfo.goodsId = 0
        self.selectInfo.skinId = 0
        return
    end
    if self.selectInfo.goodsId == goodsId then
        self:ShowGoodsPic()
        return
    end

    local goodsCfg = Config.GetShopMerchandiseInfo(goodsId)
    if goodsCfg == nil then
        LuaLogger.es("商品 配置未找到 id:" .. goodsId)
        return
    end
    local content = goodsCfg.content[1]
    if content == nil or content[1] ~= GE.RewardType.Skin or content[2] == nil then
        LuaLogger.es("商品 错误 不是对应的皮肤道具 goodsId:" .. goodsId)
        return
    end

    local skinCfg = Config.GetCharacterSkinInfo(content[2])
    if skinCfg == nil then
        LuaLogger.es("皮肤数据错误skinId" .. tostring(content[2]))
        return
    end

    self.selectInfo.goodsId = goodsId
    self.selectInfo.skinId = skinCfg.id

    ---加载spine
    local resPath = Config.PrefabPath.RoleSpine
    local spineName = skinCfg.spineKey
    local prefabPath = string.format(resPath, spineName, spineName)

    if self.curSpinePath ~= prefabPath then
        self.curSpinePath = prefabPath
        self:LoadGameObjectAsync(prefabPath, BindCallback(self, self.OnSpineLoadCallBack, prefabPath))
    end

    local characterId = skinCfg.CharacterID
    local characterCfg = Config.GetCharacterInfo(characterId)
    self.heroNameText.text.text = characterCfg.name

    self.skinNameText.text.text = skinCfg.skinName

    local isActive = Me:CheckGoodsUnlock(goodsId)
    ---显示标签
    local tags = skinCfg.SkinTag
    for i = 1, #tags do
        local tagObj = self.skinTagObjs[i]
        if tagObj == nil then
            local obj = EngineUtil.Instantiate(self.tagPrefab, nil)
            tagObj = SkinTagObj:Create(obj, self, self.tagPrefab)
            table.insert(self.skinTagObjs, tagObj)
        end
        tagObj:SetData(tags[i])
    end
    for i = #tags + 1, #self.skinTagObjs do
        local tagObj = self.skinTagObjs[i]
        tagObj:SetData(nil)
    end
    --显示倒计时
    local serverTime = EngineUtil.ServerTime_Client()
    local str = nil
    if isActive and goodsCfg.merchandiseClose > serverTime then
        local t = goodsCfg.merchandiseClose - serverTime
        if t > 24 * 60 * 60 then
            local days = math.floor(t / 86400)
            local h = math.floor((t - days * 86400) / (60 * 60))
            str = string.format(LocalStrEnum.skinRemainTime_Day, days, h)
        elseif t > 60 * 60 then
            local h = math.floor(t / (60 * 60))
            str = string.format(LocalStrEnum.skinRemainTime_Hour, h)
        else
            str = LocalStrEnum.skinRemainTime_Min
        end
        self.limitTimeText.text.text = str
    end
    self.limitTimeBg:SetActive(not string.isNullOrEmpty(str))
    ---显示价格
    self:ShowGoodsPic()

    local canvasGruop = self.skinMaskImg.canvasGroup
    canvasGruop:DOKill()
    canvasGruop.alpha = 1
end

function GameShopPanel_HeroSkinMenu:PlaySkinSwitchAnima()

    local canvasGruop = self.skinMaskImg.canvasGroup
    canvasGruop:DOKill()
    canvasGruop.alpha = 1
    canvasGruop:DOFade(0, 0.2):SetEase(DG.Tweening.Ease.InQuart)

    local trs = self.spineRoot.transform
    trs:DOKill()
    trs.localScale = Vector3.one * 1.2
    local tween = trs:DOScale(1, 1.5):SetEase(DG.Tweening.Ease.OutCubic):SetDelay(0.2)

    ---@type UnityEngine.RectTransform
    local trs = self.skinInfo.transform
    local pos = trs.anchoredPosition
    pos.x = 0
    trs.anchoredPosition = pos
    trs:DOKill()
    trs:DOAnchorPosX(70, 0.5):SetEase(DG.Tweening.Ease.OutCubic):SetDelay(0.2)
end

function GameShopPanel_HeroSkinMenu:ShowGoodsPic()
    if self.selectInfo.goodsId == nil then
       return 
    end
    local isOwn = Me:getSkinData(self.selectInfo.skinId) ~= nil
    local isActive = Me:CheckGoodsUnlock(self.selectInfo.goodsId)
    self.buyBtn:SetActive(isActive and (not isOwn))
    if isActive then
        local picId, picNum, picRate = Me:GetShopItemPic(self.selectInfo.goodsId)

        local picItemCfg = Config.GetItemInfo(picId)
        self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPathSmall, picItemCfg.icon), self.picImg.image)
        self.picText.text.text = tostring(picNum)

        self.discountText:SetActive(picRate ~= 0)
        if picRate ~= 0 then
            local goodsId = self.selectInfo.goodsId
            local goodsCfg = Config.GetShopMerchandiseInfo(goodsId)
            self.discountText.text.text = tostring(goodsCfg.price[3])
        end
    end
end

---@param obj UnityEngine.GameObject
function GameShopPanel_HeroSkinMenu:OnSpineLoadCallBack(path, obj)
    if path ~= self.curSpinePath then
        --LuaLogger.es("加载结果不一致 curPath:" .. tostring(self.curSpinePath) .. "  path:" .. path)
        GameObject.Destroy(obj)
    end
    if self.spineObject ~= nil then
        GameObject.Destroy(self.spineObject)
        self.spineObject = nil
    end
    if IsNull(obj) then
        return
    end

    local spineObject = obj
    spineObject:SetParent(self.spineRoot.transform)
    ---@type UnityEngine.RectTransform
    local trans = spineObject.transform

    --self.selectInfo.skinId
    local skinCfg = Config.GetCharacterSkinInfo(self.selectInfo.skinId)
    local offset = skinCfg.spineOffset
    local rate = skinCfg.spineRate
    trans.anchoredPosition = Vector2.New(offset[1], offset[2])
    trans.localScale = Vector3.New(rate, rate, rate)

    --动作轨道配置可能会修改动画播放速度
    local objSpine = spineObject:GetComponent("SkeletonGraphic")

    --剧情关闭spine物理效果
    objSpine.PhysicsPositionInheritanceFactor = Vector2.zero
    --获取动画状态
    local objSpineAnim = spineObject:GetComponent("SkeletonAnimation")
    local animationState = objSpineAnim.AnimationState
    animationState:SetAnimation(GE.RoleSpineActionType.Action, "idle_action", true)
    self.spineObject = spineObject

    self:PlaySkinSwitchAnima()
end

function GameShopPanel_HeroSkinMenu:OnFiltrateSelectCallBack(filtrateOperation)
    if filtrateOperation == nil then
        return
    end

    for i = 1, #self.filterData.groups do
        local g = filtrateOperation[i]
        if g == nil then
            goto continue
        end
        local group = self.filterData.groups[i]
        for j = 1, #group.items do
            local isSelect = tablex.indexof(g, j) > 0
            group.items[j].isSelect = isSelect
        end
        ::continue::
    end
    -- local goods = self:FiltrateGoods()
    -- self.emptyInfo:SetActive(#goods == 0)
    -- if #goods == 0 then
    --     self:SelectItem(nil)
    -- end
    -- self.skinDatas = goods
    -- if tablex.indexof(goods, self.selectInfo.goodsId) < 0 then
    --     local goodsId = goods[1]
    --     self:SelectItem(goodsId)
    -- end
    -- self.skinScrollWarp:SetDataCount(#self.skinDatas)

    self:ShowItem()
end

---筛选符合条件的商品
function GameShopPanel_HeroSkinMenu:FiltrateGoods()
    local skinTag = {}  --皮肤标签
    local sellType = {}     ---销售状态标签
    local ownTag = {}   --是否拥有标签
    local tags = { skinTag, sellType, ownTag }
    for i = 1, #self.filterData.groups do
        local group = self.filterData.groups[i]
        local tagTab = tags[i]

        if group.selectType == FiltrateSelectType.AllMultiSelect then
            if not group.items[1].isSelect then
                for j = 2, #group.items do
                    if group.items[j].isSelect then
                        local tag = group.items[j].val
                        table.insert(tagTab, tag)
                    end
                end
            end
        else
            for j = 1, #group.items do
                if group.items[j].isSelect then
                    local tag = group.items[j].val
                    table.insert(tagTab, tag)
                end
            end
        end
    end

    local goods = {}
    for i = 1, #self.allGoods do
        local goodsId = self.allGoods[i]
        local goodsCfg = Config.GetShopMerchandiseInfo(goodsId)
        if goodsCfg == nil then
            goto continue
        end
        local content = goodsCfg.content[1]
        if content == nil or content[1] ~= GE.RewardType.Skin or content[2] == nil then
            goto continue
        end

        local skinCfg = Config.GetCharacterSkinInfo(content[2])
        if skinCfg == nil then
            goto continue
        end

        if #skinTag > 0 then
            local isHave = false
            if skinCfg.SkinTag ~= nil then
                for i = 1, #skinTag do
                    if tablex.indexof(skinCfg.SkinTag, skinTag[i]) > 0 then
                        isHave = true
                        break
                    end
                end
            end
            if not isHave then
                goto continue
            end
        end
        if #sellType > 0 then
            local isHave = false
            if tablex.indexof(sellType, 1) > 0 then --折扣
                if goodsCfg.showDiscount ~= 0 then
                    isHave = true
                end
            end

            if tablex.indexof(sellType, 2) > 0 then --售卖中
                if Me:CheckGoodsUnlock(goodsId) then
                    isHave = true
                end
            end

            if tablex.indexof(sellType, 3) > 0 then --未开售
                if not Me:CheckGoodsUnlock(goodsId) then
                    isHave = true
                end
            end

            if tablex.indexof(sellType, 4) > 0 then --限购
                local isUnlock = Me:CheckGoodsUnlock(goodsId)
                local timeLimit = goodsCfg.merchandiseClose ~= 0 and isUnlock
                if timeLimit then
                   isHave = true 
                end
            end

            if not isHave then
                goto continue
            end
        end

        if #ownTag > 0 then
            local isHave = false
            local isOwn = Me:getSkinData(skinCfg.id) ~= nil
            if tablex.indexof(ownTag, 1) > 0 then --拥有
                if isOwn then
                    isHave = true
                end
            end

            if tablex.indexof(ownTag, 2) > 0 then --未拥有
                if not isOwn then
                    isHave = true
                end
            end
            if not isHave then
                goto continue
            end
        end
        table.insert(goods, goodsId)
        ::continue::
    end
    return goods
end

function GameShopPanel_HeroSkinMenu:RefreshItem(goodsId)
    if self.selectInfo.goodsId ~= goodsId then
        return
    end

    self:SelectItem(goodsId)
end

function GameShopPanel_HeroSkinMenu:OnDestroy()
	if self.spineObject ~= nil then
        GameObject.Destroy(self.spineObject)
        self.spineObject = nil
    end

    if self.skinItemObjs ~= nil then
        for i = 1, #self.skinItemObjs do
            local gObj = self.skinItemObjs[i]
            gObj:Destroy()
        end
        self.skinItemObjs = nil
    end
    if not IsNull(self.spineRoot) then
        local trs = self.spineRoot.transform
        trs:DOKill()
    end

    if not IsNull(self.skinInfo) then
        local trs = self.skinInfo.transform
        trs:DOKill()
    end

    self.curSpinePath = nil
    self.selectInfo.goodsId = 0
    self.selectInfo.skinId = 0
end

--[[
/filterBtn onClick
--]]
function GameShopPanel_HeroSkinMenu:filterBtn_ScaleButton_onClick(filterBtn)
    UIMgr:popUICover("SkinGoodsFiltrateBox", self.filterData)
end

--[[
/infoBtn onClick
--]]
function GameShopPanel_HeroSkinMenu:infoBtn_ScaleButton_onClick(infoBtn)
    UIMgr:popUICover("SkinPreviewPanel", { skinId = self.selectInfo.skinId, goodsId = self.selectInfo.goodsId })
end

--[[
/buyBtn onClick
--]]
function GameShopPanel_HeroSkinMenu:buyBtn_ScaleButton_onClick(buyBtn)
    Me:BuyItem(self.selectInfo.goodsId, 1, function(goodsId)
        if goodsId ~= self.selectInfo.goodsId then
            return
        end

       	DLuaTimer:DoAfter(1, function()
            for i = 1, #self.skinItemObjs do
                local obj = self.skinItemObjs[i]
                if obj ~= nil and obj.data == goodsId then
                    obj:SetData(obj.data)
                    break
                end
            end
            self:ShowGoodsPic()
        end)
    end)
end

return GameShopPanel_HeroSkinMenu
