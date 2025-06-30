-- @FileName:   FieldExplorationMapMainUI_220.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationMapMainUI_220', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fieldExploration/FieldExplorationMapMainUI_220.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")
    self:setTxtTitle(_TT(95118))
end

--析构
function dtor(self)
end

function initData(self)
    self.m_activityId = 220

end
-- 设置货币栏
function setMoneyBar(self)
end
-- 初始化
function configUI(self)
    self.mGruopMap = self:getChildTrans("mGruopMap")

    self.mTabGroup = self:getChildTrans("mTabGroup")
    self.mItemTab = self:getChildGO("mItemTab")

    self.mTextActivityTime = self:getChildGO("mTextActivityTime"):GetComponent(ty.Text)
end

function initViewText(self)

end

--激活
function active(self, args)
    super.active(self, args)

    self:createMapTab()

    local map_id = args.map_id or 1
    self:selectMapTab(map_id)

    self:addAllEventListener()

    local mainActivityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Gold)
    local overTime = mainActivityVo:getOverTimeDt()
    local t = os.date('*t', overTime)
    self.mTextActivityTime.text = string.format("活动截止时间：%02d/%02d %02d:%02d", t.month, t.day, t.hour, t.min)

    self.base_childGos["gBtnCloseAll"]:SetActive(map.MapLoader.m_curMapType ~= MAP_TYPE.SANDPLAY_GAME)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:removeAllEventListener()

    GameDispatcher:dispatchEvent(EventName.CLOSE_FIELDEXPLORATIONDUPPANEL)

    self:onRecoverMapItem()
end

function addAllEventListener(self)
end
function removeAllEventListener(self)
end

function createMapTab(self)
    self:clearTab()

    local mapDic = fieldExploration.FieldExplorationManager:getMapConfigDic()
    if mapDic then
        for i = 1, #mapDic do
            local tabItem = SimpleInsItem:create(self.mItemTab, self.mTabGroup, "FieldExplorationMapMainUI_220_TabItem")
            table.insert(self.mTabList, tabItem)

            tabItem.data = mapDic[i]
            tabItem:getChildGO("mTextNormal"):GetComponent(ty.Text).text = _TT(mapDic[i].name)
            tabItem:getChildGO("mTextSelect"):GetComponent(ty.Text).text = _TT(mapDic[i].name)
            local imgPath = UrlManager:getPackPath(string.format("fieldExploration_220/activity_game_tab0%s_220.png", mapDic[i].map_id))
            tabItem:getChildGO("mImgSelect"):GetComponent(ty.AutoRefImage):SetImg(imgPath)
            tabItem:addUIEvent(nil, function ()
                tabItem:select()
            end)

            tabItem.select = function (_item)
                for _, item in pairs(self.mTabList) do
                    item:unSelect()
                end

                _item:getChildGO("mImgNormal"):SetActive(false)
                _item:getChildGO("mImgSelect"):SetActive(true)

                self:onSelectMapTab(_item.data.map_id)
            end

            tabItem.unSelect = function (_item)
                _item:getChildGO("mImgNormal"):SetActive(true)
                _item:getChildGO("mImgSelect"):SetActive(false)
            end
        end

        self.mTabGroup.gameObject:SetActive(#mapDic > 1)
    end
end

function clearTab(self)
    if self.mTabList then
        for _, tabItem in pairs(self.mTabList) do
            tabItem:poolRecover()
        end
    end

    self.mTabList = {}
end

function onSelectMapTab(self, map_id)
    if map_id == self.m_select_mapId then
        return
    end

    self.m_select_mapId = map_id

    self:onRecoverMapItem()
    self.mMapConfigVo = fieldExploration.FieldExplorationManager:getMapConfigVO(self.m_activityId, self.m_select_mapId)
    local class = fieldExploration[string.format("FieldExplorationMapItem_%s_%s", self.mMapConfigVo.map_id, self.mMapConfigVo.activity_id)]
    self.mMapItem = class:poolGet()
    self.mMapItem:setData(self.mGruopMap, nil, self.mMapConfigVo)
end

function selectMapTab(self, map_id)
    for _, item in pairs(self.mTabList) do
        if item.data.map_id == map_id then
            item:select()
            break
        end
    end
end

function onRecoverMapItem(self)
    if self.mMapItem then
        self.mMapItem:poolRecover()
        self.mMapItem = nil
    end
end

return _M
