module("manual.ManualMapView", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("manual/ManualMapView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    -- self:setBg("manualHero_bg.jpg", false, "manual")
    self:setTxtTitle("战员图鉴") -- 战员图鉴
    self:setUICode(LinkCode.ManualHero)
end
-- 析构  
function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mMapItemList = {}
    self.mTitleItem = {}
    self.mTitleItemChild = {}

    self.bgH = 1238
    self.bgW = 3214
end
-- 初始化
function configUI(self)
    super.configUI(self)

    self.mMapScroll = self:getChildGO("mMapScroll"):GetComponent(ty.ScrollRect)
    self.mMapTitleItem = self:getChildGO("mMapTitleItem")
    self.mMapTitleItemChild = self:getChildGO("mMapTitleItemChild")
    self.mMapItem = self:getChildGO("mMapItem")
    self.mBtnBg = self:getChildGO("mBtnBg")
    self.mIconContent = self:getChildTrans("mIconContent")
    -- self.mBgContent = self:getChildTrans("mBgContent")
    self.mMap = self:getChildGO("mMap")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
end
-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self.data = args
    self.isShowChild = false
    self:showPanel()

end
-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:clearMapItemList()
    self:clearMapTitleItemList()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTips.text = _TT(80086)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBg, self.onClickBg)
end

function onClickBg(self)
    self.mapId = 0
    self.mTxtTips.gameObject:SetActive(false)
    local w, h = ScreenUtil:getScreenSize(nil)
    local centerW = (w - self.bgW) / 2
    local centerH = (h - self.bgH) / 2

    TweenFactory:move2LPosX(self.mMapScroll.content, centerW, 0.2)
    TweenFactory:move2LPosY(self.mMapScroll.content, -centerH, 0.2, gs.DT.Ease.Linear, function()
        self:updateShowTitle()
    end)
    -- self:updateShowTitle()
end

function showPanel(self)
    self.mTxtTips.gameObject:SetActive(false)

    if self.isReshow then
        self.mapId = manual.ManualHeroManager:getLastClickMapId()
    else
        self.mapId = 0
    end

    local mapDataList = manual.ManualHeroManager:getWorldMapData()
    local childIdList = manual.ManualHeroManager:getChildIdList()
    self:clearMapItemList()
    self:clearMapTitleItemList()
    for i = 1, #mapDataList do
        if table.indexof01(childIdList, mapDataList[i].id) == 0 and mapDataList[i].id ~= 6 then
            local mapItem = SimpleInsItem:create(self.mMapItem, self.mIconContent, "manualMapItem")
            mapItem:getGo():GetComponent(ty.AutoRefImage):SetImg(
                UrlManager:getPackPath("manualHero/" .. mapDataList[i].mapIcon), true)

            mapItem:getGo():GetComponent(ty.AutoRefImage).alphaHitTestMinimumThreshold = 0.5
            gs.TransQuick:UIPos(mapItem:getGo():GetComponent(ty.RectTransform), mapDataList[i].pos[1],
                mapDataList[i].pos[2])

            self.mMapItemList[mapDataList[i].id] = mapItem

        end
    end

    for i = 1, #mapDataList do
        local titleItem
        if table.indexof01(childIdList, mapDataList[i].id) == 0 then
            titleItem = SimpleInsItem:create(self.mMapTitleItem, self.mMapScroll.content, "manualMapTitleItem")
        else
            titleItem =
                SimpleInsItem:create(self.mMapTitleItemChild, self.mMapScroll.content, "manualMapTitleItemChild")
        end

        gs.TransQuick:UIPos(titleItem:getGo():GetComponent(ty.RectTransform), mapDataList[i].titlePos[1],
            mapDataList[i].titlePos[2])

        titleItem:getChildGO("mNoShow"):SetActive(mapDataList[i].id ~= 3 and mapDataList[i].id ~= 8)
        titleItem:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getIconPath(mapDataList[i].icon), false)

        titleItem:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(mapDataList[i].name)
        titleItem:getChildGO("mTxtNameEn"):GetComponent(ty.Text).text = _TT(mapDataList[i].engName)

        if table.indexof01(childIdList, mapDataList[i].id) == 0 then
            self.mTitleItem[mapDataList[i].id] = titleItem
        else
            titleItem:getGo():SetActive(false)
            self.mTitleItemChild[mapDataList[i].id] = titleItem
        end

        titleItem:addUIEvent("mBtnClick", function()
            self:onClickMap(mapDataList[i].id)
            -- manual.ManualHeroManager:setLastClickMapId(mapDataList[i].id)
        end)
    end

    local w, h = ScreenUtil:getScreenSize(nil)
    local centerW = (w - self.bgW) / 2
    local centerH = (h - self.bgH) / 2

    TweenFactory:move2LPosX(self.mMapScroll.content, centerW, 0.01)
    TweenFactory:move2LPosY(self.mMapScroll.content, -centerH, 0.01)

    if self.mapId ~= 0 then
       
        local childIdList = manual.ManualHeroManager:getChildIdList()
        if table.indexof01(childIdList, self.mapId) > 0 then
            local childId = self.mapId
            local parentId  = self:getParentMapId(self.mapId)
            self:onClickMap(parentId)
            local vo = manual.ManualHeroManager:getWorldDataByMapId(childId)
            GameDispatcher:dispatchEvent(EventName.OPEN_MANUALHERO_VIEW, {
                    camp = vo.id,
                    url = vo.icon,
                    des = _TT(vo.des),
                    name = _TT(vo.name)
                })
        else
            self:onClickMap(self.mapId)
        end
    end
end

function getParentMapId(self,mapId)
    local list = manual.ManualHeroManager:getWorldMapData(mapId)
    local parentId = 0 
    for i = 1, #list, 1 do
        if table.indexof01(list[i].areaList, mapId) > 0 then
            parentId = list[i].id
        end
    end
    return parentId
end

function onClickMap(self, mapId)
    manual.ManualHeroManager:setLastClickMapId(mapId)
    local vo = manual.ManualHeroManager:getWorldDataByMapId(mapId)
    local childIdList = manual.ManualHeroManager:getChildIdList()

    --是子节点的
    if table.indexof01(childIdList, mapId) > 0 then
        GameDispatcher:dispatchEvent(EventName.OPEN_MANUALHERO_VIEW, {
            camp = vo.id,
            url = vo.icon,
            des = _TT(vo.des),
            name = _TT(vo.name)
        })
    else -- 不是子节点店
        local w, h = ScreenUtil:getScreenSize(nil)
        local centerW = (w - self.bgW) / 2
        local centerH = (h - self.bgH) / 2
        --不存在子节点
        if #vo.areaList == 0 then
            self.mapId = 0
            TweenFactory:move2LPosX(self.mMapScroll.content, centerW - vo.titlePos[1], 0.2)
            TweenFactory:move2LPosY(self.mMapScroll.content, -centerH - vo.titlePos[2], 0.2)
            GameDispatcher:dispatchEvent(EventName.OPEN_MANUALHERO_VIEW, {
                camp = vo.id,
                url = vo.icon,
                des = _TT(vo.des),
                name = _TT(vo.name)
            })
        else -- 存在子节点
            self.mapId = mapId
            TweenFactory:move2LPosX(self.mMapScroll.content, centerW - vo.titlePos[1], 0.2, gs.DT.Ease.Linear)
            TweenFactory:move2LPosY(self.mMapScroll.content, -centerH - vo.titlePos[2], 0.2, gs.DT.Ease.Linear,
                function()
                    self.mTxtTips.gameObject:SetActive(true)
                    self:updateShowTitle()
                end)
        end

    end

end

function updateShowTitle(self)

    local vo = manual.ManualHeroManager:getWorldDataByMapId(self.mapId)

    for k, v in pairs(self.mTitleItem) do
        v:getGo():SetActive(self.mapId == 0)
    end

    self.mMap:SetActive(self.mapId == 0)
    if self.mapId ~= 0 then
        for k, v in pairs(self.mTitleItemChild) do
            v:getGo():SetActive(table.indexof01(vo.areaList, k) ~= 0)
        end
    else
        for k, v in pairs(self.mTitleItemChild) do
            v:getGo():SetActive(false)
        end
    end

    for k, v in pairs(self.mMapItemList) do
        v:getGo():SetActive(k == self.mapId or self.mapId == 0)
    end
end

function clearMapItemList(self)
    for k, v in pairs(self.mMapItemList) do
        v:poolRecover()
    end
    self.mMapItemList = {}
end

function clearMapTitleItemList(self)
    for k, v in pairs(self.mTitleItemChild) do
        v:poolRecover()
    end
    self.mTitleItemChild = {}
    for k, v in pairs(self.mTitleItem) do
        v:poolRecover()
    end
    self.mTitleItem = {}
end

return _M
