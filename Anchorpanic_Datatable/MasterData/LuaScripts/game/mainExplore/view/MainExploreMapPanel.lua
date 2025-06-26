--[[ 
-----------------------------------------------------
@filename       : MainExploreMapPanel
@Description    : 主线探索地图面板
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreMapPanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mainExplore/MainExploreMapPanel.prefab")

panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("")
    self:setBg("mainExplore_bg_02.jpg", false, "mainExploreMap")
end

--析构
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mScrollRect = self:getChildGO('Scroll View'):GetComponent(ty.RectTransform)
    self.mNodeMapRect = self:getChildGO('Content'):GetComponent(ty.RectTransform)
    
    self.mMapIconTypeGroup = self:getChildTrans('mMapIconTypeGroup')
    self.mMapIconTypeItem = self:getChildGO('MapIconTypeItem')
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    mainExplore.MainExploreSceneThingManager:addEventListener(mainExplore.MainExploreSceneThingManager.ADD_THING, self.onAddThingHandler, self)
    mainExplore.MainExploreSceneThingManager:addEventListener(mainExplore.MainExploreSceneThingManager.REMOVE_THING, self.onRemoveThingHandler, self)

    if(not self.mMapView)then
        self.mMapView = mainExplore.MainExploreMapView.new()
        self.mMapView:setParentTrans(self.mNodeMapRect)
        gs.TransQuick:SizeDelta(self.mNodeMapRect, self.mMapView:getSize())
    end
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    mainExplore.MainExploreSceneThingManager:removeEventListener(mainExplore.MainExploreSceneThingManager.ADD_THING, self.onAddThingHandler, self)
    mainExplore.MainExploreSceneThingManager:removeEventListener(mainExplore.MainExploreSceneThingManager.REMOVE_THING, self.onRemoveThingHandler, self)

    self:recoverListItem()
    if (self.mMapView) then
        self.mMapView:destroy()
        self.mMapView = nil
    end
end

function initViewText(self)
end

function addAllUIEvent(self)
end

function updateView(self)
    self:updatePlayerViewport()
    self:updateMapIcon()
end

function updatePlayerViewport(self)
    local scrollSizeW = self.mScrollRect.sizeDelta.x
    local scrollSizeH = self.mScrollRect.sizeDelta.y
    local mapSizeW, mapSizeH = self.mMapView:getSize()
    local maxX = mapSizeW / 2 - scrollSizeW / 2
    local maxY = mapSizeH / 2 - scrollSizeH / 2
    local playerPosX, playerPoxY = self.mMapView:getPlayerPos()
    playerPosX = math.min(playerPosX, maxX)
    playerPosX = math.max(playerPosX, -maxX)
    playerPoxY = math.min(playerPoxY, maxY)
    playerPoxY = math.max(playerPoxY, -maxY)
    gs.TransQuick:UIPos(self.mNodeMapRect, playerPosX, playerPoxY)
end

function updateMapIcon(self)
    self:recoverListItem()
    
    local eventDic = mainExplore.MainExploreManager:getEventDic(false)
    for eventId, eventVo in pairs(eventDic) do
        local eventThingVo = mainExplore.MainExploreSceneManager:getThingVo(eventId)
        local thing = mainExplore.MainExploreSceneThingManager:getThing(eventThingVo)
        self:onAddThingHandler(thing)
    end
end

function onAddThingHandler(self, thing)
    if(thing)then
        local thingVo = thing:getThingVo()
        local eventConfigVo = thingVo:getEventConfigVo()
        local eventId = eventConfigVo.eventId
        if(eventConfigVo.miniIcon ~= "" and eventConfigVo.miniShowOutEnable)then
            for i, iconData in pairs(self.mMapIconList) do
                if(iconData.thing:getThingVo():getEventConfigVo().eventType == thing:getThingVo():getEventConfigVo().eventType)then
                    return
                end
            end
            local function _clickFun()
            end
            local iconData = self:getIconData(thing, _clickFun)
            iconData.mapTxt.text = eventConfigVo:getTitle()
            iconData.mapIcon:SetImg(UrlManager:getPackPath(eventConfigVo.miniIcon), true)
            table.insert(self.mMapIconList, iconData)
        end
    end
end

function onRemoveThingHandler(self, thing)
    if(thing)then
        local thingVo = thing:getThingVo()
        local eventConfigVo = thingVo:getEventConfigVo()
        if(eventConfigVo.miniIcon ~= "" and eventConfigVo.miniShowOutEnable)then
            local iconData = self.mStaticIconDic[eventConfigVo.eventId]
            for i = #self.mMapIconList, 1, -1 do
                if(iconData.thing:getThingVo():getEventConfigVo().eventType == thing:getThingVo():getEventConfigVo().eventType)then
                    iconData.item:recover()
                end
                table.remove(self.mMapIconList, i)
                return
            end
        end
    end
end

function getIconData(self, thing, clickFun)
    local item = SimpleInsItem:create(self.mMapIconTypeItem, self.mMapIconTypeGroup, self.__cname .. "_icon")
    local mMapTxt = item:getChildGO("mMapTxt"):GetComponent(ty.Text)
    local mMapIcon = item:getChildGO("mMapIcon"):GetComponent(ty.AutoRefImage)
    item:addUIEvent("mImgClick", clickFun)
    
    local iconData = {}
    iconData.thing = thing
    iconData.item = item
    iconData.mapTxt = mMapTxt
    iconData.mapIcon = mMapIcon
    return iconData
end

-- 回收项
function recoverListItem(self)
    if(self.mMapIconList)then
        if self.mMapIconList then
            for i, iconData in pairs(self.mMapIconList) do
                iconData.item:recover()
            end
        end
    end
    self.mMapIconList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
